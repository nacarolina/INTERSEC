using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections;
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
using static GwCentral.Admin.MapConfig;

namespace GwCentral.Scoot.Planos
{
    public partial class Default : System.Web.UI.Page
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfUsuarioLogado.Value = User.Identity.Name;
            }
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

        [WebMethod]
        public static ArrayList loadAneis()
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(@"select scnAnel1,'1'Anel  from scootControladores where scnAnel1<>'' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() +
"union select scnAnel2,'2'Anel from scootControladores where scnAnel2<>'' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() +
"union select scnAnel3,'3'Anel from scootControladores where scnAnel3<>'' and idPrefeitura= " + HttpContext.Current.Profile["idPrefeitura"].ToString() +
"union select scnAnel4,'4'Anel from scootControladores where scnAnel4<>'' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["scnAnel1"].ToString(), dr["Anel"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public static List<Estagios> GetEstagios(string anel)
        {
            List<Estagios> lst = new List<Estagios>();
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"select id,Estagio,TempoMaxVerde,VerdeSeguranca from scootEstagios where scnAnel='" + anel + "' " +
                " and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + " order by convert(int, Estagio)");

            foreach (DataRow dr in dt.Rows)
            {
                string estagio = "";

                if (dr["estagio"].ToString() == "1")
                    estagio = "A";
                if (dr["estagio"].ToString() == "2")
                    estagio = "B";
                if (dr["estagio"].ToString() == "4")
                    estagio = "C";
                if (dr["estagio"].ToString() == "8")
                    estagio = "D";
                if (dr["estagio"].ToString() == "10")
                    estagio = "E";
                if (dr["estagio"].ToString() == "20")
                    estagio = "F";
                if (dr["estagio"].ToString() == "40")
                    estagio = "G";
                if (dr["estagio"].ToString() == "80")
                    estagio = "H";

                lst.Add(new Estagios
                {
                    estagio = estagio,
                    id = dr["id"].ToString(),
                    verdeMax = dr["TempoMaxVerde"].ToString(),
                    verdeSeguranca = dr["VerdeSeguranca"].ToString()
                });
            }

            return lst;
        }

        [WebMethod]
        public static List<EstagiosPlano> GetPlanos(string anel)
        {
            List<EstagiosPlano> lst = new List<EstagiosPlano>();
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"select Plano,Ciclo,count(0)qtdEstagios from scootPlanos where scnAnel='" + anel + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + "  group by plano,ciclo ");

            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new EstagiosPlano
                {
                    plano = dr["Plano"].ToString(),
                    ciclo = dr["Ciclo"].ToString(),
                    qtdEstagios = dr["qtdEstagios"].ToString()
                });
            }

            return lst;
        }

        [WebMethod]
        public static string SalvarEstagio(string anel, string estagio, string plano, string ciclo, string momentoAbertura)
        {
            Banco db = new Banco("");
            if (estagio == "A")
                estagio = "1";
            if (estagio == "B")
                estagio = "2";
            if (estagio == "C")
                estagio = "4";
            if (estagio == "D")
                estagio = "8";
            if (estagio == "E")
                estagio = "10";
            if (estagio == "F")
                estagio = "20";
            if (estagio == "G")
                estagio = "40";
            if (estagio == "H")
                estagio = "80";

            string id = db.ExecuteScalarQuery("select id from scootPlanos where scnAnel='" + anel + "' and estagio='" + estagio + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and plano='" + plano + "'");
            if (string.IsNullOrEmpty(id) == false)
            {
                return "estagio";
            }

            string controlador = anel.Replace("J", "X").Substring(0, anel.Length - 1);
            controlador += "0";

            id = db.ExecuteScalarQuery("insert into scootPlanos (idPrefeitura,plano,scnAnel,estagio,scnControlador,MomentoAbertura,ciclo) values (" + HttpContext.Current.Profile["idPrefeitura"] + ",'" + plano + "','" + anel + "','" + estagio + "','"
               + controlador + "','" + momentoAbertura + "','" + ciclo + "') SELECT SCOPE_IDENTITY()");
            return id;
        }

        [WebMethod]
        public static string salvarPlano(string anel, string plano, string ciclo, string estagio, string momentoAbertura, string usuarioLogado, string id)
        {
            Banco db = new Banco("");
            if (estagio == "A")
                estagio = "1";
            if (estagio == "B")
                estagio = "2";
            if (estagio == "C")
                estagio = "4";
            if (estagio == "D")
                estagio = "8";
            if (estagio == "E")
                estagio = "10";
            if (estagio == "F")
                estagio = "20";
            if (estagio == "G")
                estagio = "40";
            if (estagio == "H")
                estagio = "80";

            db.ExecuteNonQuery("update scootPlanos set scnAnel='" + anel + "', Plano='" + plano + "', Ciclo='" + ciclo + "', " +
                " Estagio='" + estagio + "', MomentoAbertura='" + momentoAbertura + "' where id=" + id);
            //Alterou o momento de Abertura: x no estagio: x no plano: x no anel: x
            //LOG
            db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + usuarioLogado + "','Cadastro Plano'," +
                HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','Alterou o momento de abertura: " + momentoAbertura +
                ", no estágio: " + estagio + ", no plano: " + plano + ", no anel=" + anel + " ','scootPlanos')");

            return "success";
        }

        [WebMethod]
        public static string excluirEstagioPlano(string id, string usuarioLogado, string estagio, string anel, string plano)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery("delete scootPlanos where id=" + id + " and idPrefeitura='" + HttpContext.Current.Profile["idPrefeitura"] + "' ");

            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + usuarioLogado + "','Scoot - Cadastrar Planos', " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','Excluiu o estágio: " + estagio + " do plano: " + plano + " do Anel: " + anel + "','scootPlanos')");

            return "sucesso";
        }

        [WebMethod]
        public static string excluirPlano(string anel, string plano, string usuarioLogado)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery("delete scootPlanos where scnAnel='" + anel + "' and Plano='" + plano + "' and idPrefeitura='" + HttpContext.Current.Profile["idPrefeitura"] + "' ");

            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + usuarioLogado + "','Scoot - Planos', " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','Excluiu o plano: " + plano + " do Anel: " + anel + " ','scootPlanos')");

            return "sucesso";
        }

        [WebMethod]        public static string getProxPlano(string anel)        {            Banco db = new Banco("");            string ProxPlano = db.ExecuteScalarQuery("select top 1 isnull((plano+1),1) from scootPlanos where scnAnel='" + anel + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + "  order by plano desc");            if (string.IsNullOrEmpty(ProxPlano))            {                return "1";            }
            else
            {
                DataTable dt = db.ExecuteReaderQuery("select distinct Plano from scootPlanos where scnAnel='" + anel + "' and plano <" + ProxPlano+" order by plano");

                int contador = 1;
                foreach (DataRow dr in dt.Rows)
                {
                    int plano = Convert.ToInt32(dr["Plano"].ToString());

                    if (plano != contador)
                    {
                        return contador.ToString();
                    }
                    contador++;
                }
            }            return ProxPlano;        }

        [WebMethod]
        public static List<EstagiosPlano> GetEstagiosPlano(string anel, string plano, string nmrAnel)
        {
            List<EstagiosPlano> lst = new List<EstagiosPlano>();
            Banco db = new Banco("");
            string desativarEstagios = db.ExecuteScalarQuery("Select estagiosDesativarTMPE" + nmrAnel + " from scootControladores where scnAnel" + nmrAnel + "='" + anel + "' ");
            DataTable dt = db.ExecuteReaderQuery("select p.id,p.MomentoAbertura,p.Estagio,e.TempoMaxVerde,e.VerdeSeguranca from scootPlanos " +
                " p JOIN scootEstagios e on e.estagio = p.Estagio  and e.scnAnel = p.scnAnel where p.scnAnel='" + anel + "' and p.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + "  and plano='" + plano + "' order by id");

            foreach (DataRow dr in dt.Rows)
            {
                string estagio = "";
                bool desativarTMPE = false;

                if (dr["estagio"].ToString() == "1")
                    estagio = "A";
                if (dr["estagio"].ToString() == "2")
                    estagio = "B";
                if (dr["estagio"].ToString() == "4")
                    estagio = "C";
                if (dr["estagio"].ToString() == "8")
                    estagio = "D";
                if (dr["estagio"].ToString() == "10")
                    estagio = "E";
                if (dr["estagio"].ToString() == "20")
                    estagio = "F";
                if (dr["estagio"].ToString() == "40")
                    estagio = "G";
                if (dr["estagio"].ToString() == "80")
                    estagio = "H";

                if (desativarEstagios.Contains(estagio))
                {
                    desativarTMPE = true;
                }
                else
                {
                    desativarTMPE = false;
                }

                lst.Add(new EstagiosPlano
                {
                    estagio = estagio,
                    id = dr["id"].ToString(),
                    verdeMax = dr["TempoMaxVerde"].ToString(),
                    verdeSeguranca = dr["VerdeSeguranca"].ToString(),
                    momentoAbertura = dr["MomentoAbertura"].ToString(),
                    desativarTMPE = desativarTMPE
                });
            }

            return lst;
        }

        public struct EstagiosPlano
        {
            public string id { get; set; }
            public string estagio { get; set; }
            public string ciclo { get; set; }
            public string plano { get; set; }
            public string qtdEstagios { get; set; }
            public string momentoAbertura { get; set; }
            public string verdeSeguranca { get; set; }
            public string verdeMax { get; set; }
            public bool desativarTMPE { get; set; }
        }

        public struct Estagios
        {
            public string id { get; set; }
            public string estagio { get; set; }
            public string verdeSeguranca { get; set; }
            public string verdeMax { get; set; }
        }

    }
}