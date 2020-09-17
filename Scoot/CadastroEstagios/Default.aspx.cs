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

namespace GwCentral.Scoot.CadastroEstagios
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
            hfUser.Value = User.Identity.Name;
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

            DataTable dt = db.ExecuteReaderQuery(@"select scnAnel1,isnull(qtdEstagioAnel1,'0')qtdEstagioAnel1  from scootControladores where scnAnel1<>'' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() +
"union select scnAnel2,isnull(qtdEstagioAnel2,'0')qtdEstagioAnel2 from scootControladores where scnAnel2<>'' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() +
"union select scnAnel3,isnull(qtdEstagioAnel3,'0')qtdEstagioAnel3 from scootControladores where scnAnel3<>'' and idPrefeitura= " + HttpContext.Current.Profile["idPrefeitura"].ToString() +
"union select scnAnel4,isnull(qtdEstagioAnel4,'0')qtdEstagioAnel4 from scootControladores where scnAnel4<>'' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["scnAnel1"].ToString(), dr["qtdEstagioAnel1"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public static List<Estagios> GetEstagios(string anel)
        {
            List<Estagios> lst = new List<Estagios>();
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"select id,Estagio,TempoMaxVerde,VerdeSeguranca from scootEstagios 
where scnAnel='" + anel + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + " order by Estagio");

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
        public static string getProxPlano(string anel)
        {
            Banco db = new Banco("");
            string plano = db.ExecuteScalarQuery("select top 1 isnull((plano+1),1) from scootPlanos where scnAnel='" + anel + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + "  order by plano desc");
            if (string.IsNullOrEmpty(plano))
            {
                return "1";
            }
            return plano;
        }

        [WebMethod]
        public static string AdicionarEstagio(string estagio, string anel, string user)
        {
            Banco db = new Banco("");
            string controlador = db.ExecuteScalarQuery("select scncontrolador from scootControladores where scnAnel1='" + anel + "' or scnAnel2='" + anel + "' or scnAnel3='" + anel + "' or scnAnel4='" + anel + "'");

            string existe = db.ExecuteScalarQuery("select id from scootEstagios where scnAnel='" + anel + "' and estagio='" + estagio + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
            if (string.IsNullOrEmpty(existe) == false)
                return "Esse estágio já está cadastrado!";

            db.ExecuteNonQuery("insert into scootEstagios (estagio,scnAnel,idPrefeitura) values ('" + estagio + "','" + anel + "'," + HttpContext.Current.Profile["idPrefeitura"].ToString() + ")");

            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Scoot - Cadastro estagios'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Cadastrou o estagio: " + estagio + ", verdeSeguranca: 0, verdeMax: 0','scootEstagios')");
            return "SUCESSO";
        }

        [WebMethod]
        public static void SalvarEstagios(string estagio, string verdeSeguranca, string verdeMax, string anel, string user, string id)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery("update scootEstagios set verdeSeguranca='" + verdeSeguranca + "',tempoMaxVerde='" + verdeMax + "' where id=" + id);
            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Scoot - Cadastro plano e estagios'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Alterou o  verdeSeguranca: " + verdeSeguranca + ", verdeMax: " + verdeMax + " do  estagio: " + estagio + ", anel: " + anel + "','scootEstagios')");
        }

        [WebMethod]
        public static void ExcluirEstagio(string id, string anel, string estagio, string user)
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

            db.ExecuteNonQuery("delete from scootEstagios where id=" + id);
            db.ExecuteNonQuery("delete from scootPlanos where estagio='" + estagio + "' and anel='" + anel + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());

            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Scoot - Cadastro plano e estagios'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Excluiu o estagio: " + estagio + ", do anel: " + anel + "','scootEstagios')");
        }

        [WebMethod]
        public static void ExcluirPlano(string anel, string plano, string user)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"select distinct e.id,e.Estagio,e.TempoMaxVerde,e.VerdeSeguranca from scootEstagios e 
                           JOIN scootPlanos p on p.Estagio=e.Estagio where e.scnAnel='" + anel + "' and p.Plano='" + plano + "' and e.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
            foreach (DataRow dr in dt.Rows)
            {
                db.ExecuteNonQuery("delete from scootEstagios where id=" + dr["id"].ToString());
            }
            db.ExecuteNonQuery("delete from scootPlanos where scnAnel='" + anel + "' and plano='" + plano + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());

            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Scoot - Cadastro plano e estagios'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Excluiu o plano: " + plano + " e todos os estagios do plano','scootPlanos')");
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