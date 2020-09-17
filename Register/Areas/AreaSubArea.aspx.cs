using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace GwCentral.Register.Areas
{
    public partial class AreaSubArea : System.Web.UI.Page
    {
        public static string idioma = "pt-BR";
        public static CultureInfo cultureInfo;
        protected override void InitializeCulture()
        {
            idioma = Request.UserLanguages != null ? Request.UserLanguages[0] : "pt-BR";
            if (HttpContext.Current.Profile["idioma"].Equals(idioma) || string.IsNullOrEmpty(HttpContext.Current.Profile["idioma"].ToString()))
            {
                cultureInfo = new CultureInfo(idioma);
                HttpContext.Current.Profile["idioma"] = idioma;
                Thread.CurrentThread.CurrentCulture = cultureInfo;
                Thread.CurrentThread.CurrentUICulture = cultureInfo;
            }
            else
            {
                idioma = HttpContext.Current.Profile["idioma"].ToString();
                cultureInfo = new CultureInfo(idioma);
                Thread.CurrentThread.CurrentCulture = cultureInfo;
                Thread.CurrentThread.CurrentUICulture = cultureInfo;
            }
        }

        [WebMethod]
        public static void changeLanguage(string idioma)
        {
            HttpContext.Current.Profile["idioma"] = idioma;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            hfUser.Value = User.Identity.Name;
        }

        public struct localesResource
        {
            public string name { get; set; }
            public string value { get; set; }
        }

        [WebMethod]
        public static object requestResource()
        {
            List<localesResource> resource = new List<localesResource>();
            string file = getFileResource(idioma);
            string folder = "App_GlobalResources";

            string filePath = HttpContext.Current.Server.MapPath(@"~\" + folder + @"\" + file);
            XmlDocument document = new XmlDocument();
            document.Load(filePath);

            XmlNodeList nodes = document.SelectNodes("//data");
            foreach (XmlNode node in nodes)
            {
                XmlAttribute attr = node.Attributes["name"];
                string resourceKey = attr.Value;
                resource.Add(new localesResource
                {
                    name = resourceKey,
                    value = HttpContext.GetGlobalResourceObject("Resource", resourceKey, cultureInfo).ToString()
                });
            }
            var json = JsonConvert.SerializeObject(new { resource });
            return json;
        }

        public static string getFileResource(string idioma)
        {
            string file = "Resource.resx";
            if (!string.IsNullOrEmpty(idioma))
            {
                file = idioma.IndexOf("es") != -1 ? "Resource.es.resx" : file; //espanhol
                file = idioma.IndexOf("en") != -1 ? "Resource.en.resx" : file; //ingles
            }
            return file;
        }

        public static string getResource(string nameResource)
        {
            string valueResource = "";
            string file = getFileResource(idioma);
            string folder = "App_GlobalResources";

            string filePath = HttpContext.Current.Server.MapPath(@"~\" + folder + @"\" + file);
            XmlDocument document = new XmlDocument();
            document.Load(filePath);

            XmlNodeList nodes = document.SelectNodes("//data");
            foreach (XmlNode node in nodes)
            {
                XmlAttribute attr = node.Attributes["name"];
                string resourceKey = attr.Value;
                if (resourceKey == nameResource)
                {
                    valueResource = HttpContext.GetGlobalResourceObject("Resource", resourceKey, cultureInfo).ToString();
                    break;
                }
            }
            return valueResource;
        }

        public struct Area
        {
            public string id { get; set; }
            public string tipo { get; set; }
            public string nome { get; set; }
            public string idArea { get; set; }
        }

        [WebMethod]
        public static List<Area> ListarAreas(string tipo)
        {
            Banco db = new Banco("");
            DataTable dtAreas = db.ExecuteReaderQuery(@"Select * from Area_SubArea Where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
                " and tipo='" + tipo + "'");

            List<Area> lstAreas = new List<Area>();

            foreach (DataRow item in dtAreas.Rows)
            {
                lstAreas.Add(new Area
                {
                    id = item["id"].ToString(),
                    tipo = item["tipo"].ToString(),
                    nome = item["nome"].ToString(),
                    idArea = item["idArea"].ToString()
                });
            }

            return lstAreas;
        }

        public struct EqpAneis
        {
            public string idPonto { get; set; }
            public string cruzamento { get; set; }
            public string qtdAneis { get; set; }
        }

        [WebMethod]
        public static List<EqpAneis> ListaEqpAneis()
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"Select d.Id, Cruzamento, QtdAnel from DNA d join Status s on d.Id = s.IdDna 
join Programacao p on s.Serial=Convert(varchar,p.IdEqp) Where d.IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " order by Cruzamento");

            List<EqpAneis> lst = new List<EqpAneis>();

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new EqpAneis
                {
                    idPonto = item["Id"].ToString(),
                    cruzamento = item["Cruzamento"].ToString(),
                    qtdAneis = item["QtdAnel"].ToString()
                });
            }

            return lst;
        }

        public struct vinculoAnel
        {
            public string idPonto { get; set; }
            public string anel { get; set; }
            public string cruzamento { get; set; }
        }

        [WebMethod]
        public static List<vinculoAnel> getAneisVinculados(string idArea)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"Select distinct a.idEqp,a.idArea,Cruzamento from AreaAneis a join Status s on Convert(varchar,a.IdEqp)=s.IdDna join Dna d on s.IdDna=d.Id
Where d.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and idArea=" + idArea + " order by IdEqp");

            List<vinculoAnel> lst = new List<vinculoAnel>();

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new vinculoAnel
                {
                    idPonto = item["IdEqp"].ToString(),
                    //anel = item["anel"].ToString(),
                    cruzamento = item["Cruzamento"].ToString()
                });
            }

            return lst;
        }

        [WebMethod]
        public static string vincularAneis(string idEqp, int qtdAnel, string idArea, string user)
        {
            Banco db = new Banco("");

            string existe = db.ExecuteScalarQuery("select top 1 id from AreaAneis where idEqp='"+idEqp+"' and idArea<>"+idArea);
            if (!string.IsNullOrEmpty(existe))
            {
                return "Existe";
            }
            string id = db.ExecuteScalarQuery("Select top 1 id From AreaAneis Where idEqp='" + idEqp + "' and idArea=" + idArea);

            if (string.IsNullOrEmpty(id))
            {
                int anel = 0;
                while (qtdAnel > anel)
                {
                    anel++;
                    id = db.ExecuteScalarQuery(@"Insert Into AreaAneis (idEqp,anel,idArea) Values ('" + idEqp + "'," + anel + "," + idArea + ") select SCOPE_IDENTITY();");
                }
                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Area e Sub-Areas'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                   "','Cadastrou o equipamento idEqp: " + idEqp + " na idAreaSubArea: " + idArea + ", idAreaAneis: " + id + "','AreaAneis')");
            }
            else
            {
                db.ExecuteNonQuery("Delete from AreaAneis Where idArea=" + idArea + " and idEqp='" + idEqp+"'");
                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Area e Sub-Areas'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                   "','Excluiu equipamento idEqp: " + idEqp + " na idAreaSubArea: " + idArea + "','AreaAneis')");
            }
            return "SUCESSO";
        }

        [WebMethod]
        public static List<Area> BuscarAreas(string tipo, string nome)
        {
            Banco db = new Banco("");
            DataTable dtArea = null;

            if (tipo == "area")
            {
                dtArea = db.ExecuteReaderQuery(@"Select * from Area_SubArea Where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
                   " and nome='" + nome + "' and tipo='" + tipo + "'");
            }
            else
            {
                dtArea = db.ExecuteReaderQuery(@"Select * from Area_SubArea Where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
                   " and nome='" + nome + "' and tipo='" + tipo + "'");
            }

            List<Area> lstAreas = new List<Area>();

            if (dtArea != null)
            {
                lstAreas.Add(new Area
                {
                    id = dtArea.Rows[0]["id"].ToString(),
                    tipo = dtArea.Rows[0]["tipo"].ToString(),
                    nome = dtArea.Rows[0]["nome"].ToString(),
                    idArea = dtArea.Rows[0]["idArea"].ToString()
                });
            }

            return lstAreas;
        }

        [WebMethod]
        public static List<Area> ListarTodasAreas()
        {
            Banco db = new Banco("");
            DataTable dtAreas = db.ExecuteReaderQuery(@"Select * from Area_SubArea Where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            List<Area> lstAreas = new List<Area>();

            foreach (DataRow item in dtAreas.Rows)
            {
                lstAreas.Add(new Area
                {
                    id = item["id"].ToString(),
                    tipo = item["tipo"].ToString(),
                    nome = item["nome"].ToString(),
                    idArea = item["idArea"].ToString()
                });
            }

            return lstAreas;
        }

        [WebMethod]
        public static string SalvarArea(string nome, string user)
        {
            string retorno = "";
            Banco db = new Banco("");

            string idExistente = db.ExecuteScalarQuery(@"Select id from Area_SubArea Where nome='" + nome +
                "' and tipo='area' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

            if (!string.IsNullOrEmpty(idExistente))
                return retorno = getResource("areaExistente") + "!";
            else
            {
                string id = db.ExecuteScalarQuery(@"Insert Into Area_SubArea (nome,tipo,idPrefeitura) Values ('" + nome + "','area',"
                     + HttpContext.Current.Profile["idPrefeitura"] + ") select SCOPE_IDENTITY();");

                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Area e Sub-Areas'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                   "','Cadastrou a area: " + nome + ", id: " + id + "','Area_SubArea')");
            }
            return retorno;
        }

        [WebMethod]
        public static string SalvarSubArea(string nome, string idArea, string user)
        {
            string retorno = "";
            Banco db = new Banco("");

            string idExistente = db.ExecuteScalarQuery(@"Select id from Area_SubArea Where nome='" + nome +
                "' and tipo='subArea' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

            if (!string.IsNullOrEmpty(idExistente))
                return retorno = getResource("subareaExistente") + "!";
            else
            {
                string id = db.ExecuteScalarQuery(@"Insert Into Area_SubArea (nome,tipo,idPrefeitura,idArea) Values ('" + nome + "','subArea',"
                     + HttpContext.Current.Profile["idPrefeitura"] + "," + idArea + ") select SCOPE_IDENTITY();");

                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Area e Sub-Areas'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                   "','Cadastrou a Subarea: " + nome + " na idArea: " + idArea + ", id: " + id + "','Area_SubArea')");
            }
            return retorno;
        }

        [WebMethod]
        public static string Renomear(string nome, string id, string user)
        {
            string retorno = "";
            Banco db = new Banco("");

            string idExistente = db.ExecuteScalarQuery(@"Select id from Area_SubArea Where nome='" + nome +
                "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and id <> " + id);

            if (!string.IsNullOrEmpty(idExistente))
                return retorno = getResource("nomeExistente") + "!";
            else
            {
                string tipo = db.ExecuteScalarQuery("select tipo from Area_Subarea where id=" + id);
                db.ExecuteNonQuery(@"Update Area_SubArea set nome='" + nome + "' Where id=" + id);
                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Area e Sub-Areas'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                      "','Alterou a " + tipo + ": " + nome + ", id: " + id + "','Area_SubArea')");
            }
            return retorno;
        }

        [WebMethod]
        public static void Excluir(string id, string user)
        {
            Banco db = new Banco("");
            string tipo = db.ExecuteScalarQuery("select tipo from Area_Subarea where id=" + id);
            string nome = db.ExecuteScalarQuery("select nome from Area_Subarea where id=" + id);

            db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Area e Sub-Areas'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                  "','Excluiu a " + tipo + ": " + nome + ", id: " + id + "','Area_SubArea')");

            db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Area e Sub-Areas'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                  "','Excluiu os aneis da idArea_SubArea: " + id + "','AreaAneis')");

            db.ExecuteNonQuery(@"Delete from Area_SubArea Where id=" + id +
                "; Delete from Area_SubArea Where idArea=" + id +
                "; Delete from AreaAneis Where idArea=" + id);
			if (tipo=="area")
			{
				db.ExecuteNonQuery("delete corredor where idArea="+id+" and idPrefeitura="+ HttpContext.Current.Profile["idPrefeitura"]);
			}
			else
			{
				db.ExecuteNonQuery("delete corredor where idSubArea=" + id + " and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
			}
        }
    }
}