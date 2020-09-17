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

namespace GwCentral.Scoot.Entreverdes
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hfUsuarioLogado.Value = User.Identity.Name;
        }

        [WebMethod]        public static ArrayList carregarAneis()        {            ArrayList lst = new ArrayList();            Banco db = new Banco("");            DataTable dt = db.ExecuteReaderQuery("select scnAnel1 from scootControladores where scnAnel1<>'' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + " " +
                " union select scnAnel2 from scootControladores where scnAnel2<>'' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + " " +
                " union select scnAnel3 from scootControladores where scnAnel3<>'' and idPrefeitura= " + HttpContext.Current.Profile["idPrefeitura"].ToString() + " " +
                " union select scnAnel4 from scootControladores where scnAnel4<>'' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());            foreach (DataRow dr in dt.Rows)            {                lst.Add(new ListItem(dr["scnAnel1"].ToString(), dr["scnAnel1"].ToString()));            }            return lst;        }

        [WebMethod]        public static ArrayList carregarGridPlanos(string anel)        {            ArrayList lst = new ArrayList();            Banco db = new Banco("");            DataTable dt = db.ExecuteReaderQuery("select Plano, count(0)qtdEstagios from scootPlanos where scnAnel='" + anel + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + " group by plano");            foreach (DataRow dr in dt.Rows)            {                lst.Add(new ListItem(dr["Plano"].ToString(), dr["qtdEstagios"].ToString()));            }            return lst;        }

        [WebMethod]        public static ArrayList carregarPlanos(string anelSelecionado)        {            ArrayList lst = new ArrayList();            Banco db = new Banco("");            DataTable dt = db.ExecuteReaderQuery("select distinct Plano from scootPlanos where scnAnel='" + anelSelecionado + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);            foreach (DataRow dr in dt.Rows)            {                lst.Add(new ListItem(dr["Plano"].ToString(), dr["Plano"].ToString()));            }            return lst;        }

        public struct Entreverdes
        {
            public string id { get; set; }
            public string estagio1 { get; set; }
            public string estagio2 { get; set; }
            public string entreverdes { get; set; }
            public string demandado { get; set; }
        }
        [WebMethod]
        public static List<Entreverdes> carregarEntreverdes(string anel)
        {
            List<Entreverdes> lst = new List<Entreverdes>();
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery("select id,Estagio1,Estagio2,Entreverdes,Demandado from scootEntreverdes " +
                " where scnAnel='" + anel + "' and idPrefeitura='" + HttpContext.Current.Profile["idPrefeitura"].ToString() + "' ");

            string estagio1 = "";            string estagio2 = "";            foreach (DataRow dr in dt.Rows)            {                if (dr["Estagio1"].ToString() == "1")                    estagio1 = "A";                if (dr["Estagio2"].ToString() == "1")                    estagio2 = "A";                if (dr["Estagio1"].ToString() == "2")                    estagio1 = "B";
                if (dr["Estagio2"].ToString() == "2")                    estagio2 = "B";                if (dr["Estagio1"].ToString() == "4")                    estagio1 = "C";                if (dr["Estagio2"].ToString() == "4")                    estagio2 = "C";                if (dr["Estagio1"].ToString() == "8")                    estagio1 = "D";                if (dr["Estagio2"].ToString() == "8")                    estagio2 = "D";                if (dr["Estagio1"].ToString() == "10")                    estagio1 = "E";                if (dr["Estagio2"].ToString() == "10")                    estagio2 = "E";                if (dr["Estagio1"].ToString() == "20")                    estagio1 = "F";                if (dr["Estagio2"].ToString() == "20")                    estagio2 = "F";                if (dr["Estagio1"].ToString() == "40")                    estagio1 = "G";                if (dr["Estagio2"].ToString() == "40")                    estagio2 = "G";                if (dr["Estagio1"].ToString() == "80")                    estagio1 = "H";                if (dr["Estagio2"].ToString() == "80")                    estagio2 = "H";                lst.Add(new Entreverdes
                {
                    id = dr["id"].ToString(),
                    estagio1 = estagio1,
                    estagio2 = estagio2,
                    entreverdes = dr["Entreverdes"].ToString(),
                    demandado = dr["Demandado"].ToString()
                });            }

            return lst;
        }

        [WebMethod]        public static ArrayList carregarGridEstagios(string anel)        {            ArrayList lst = new ArrayList();            Banco db = new Banco("");            DataTable dt = db.ExecuteReaderQuery("select id, Estagio from scootEstagios where scnAnel='" + anel + "' " +
                " and idPrefeitura='" + HttpContext.Current.Profile["idPrefeitura"].ToString() + "' order by convert(int, estagio)");            string estagio = "";            foreach (DataRow dr in dt.Rows)            {                if (dr["estagio"].ToString() == "1")                    estagio = "A";                if (dr["estagio"].ToString() == "2")                    estagio = "B";                if (dr["estagio"].ToString() == "4")                    estagio = "C";                if (dr["estagio"].ToString() == "8")                    estagio = "D";                if (dr["estagio"].ToString() == "10")                    estagio = "E";                if (dr["estagio"].ToString() == "20")                    estagio = "F";                if (dr["estagio"].ToString() == "40")                    estagio = "G";                if (dr["estagio"].ToString() == "80")                    estagio = "H";                lst.Add(new ListItem(estagio, dr["id"].ToString()));            }            return lst;        }

        [WebMethod]
        public static string salvar(string estagio1, string estagio2, string entreverdes, string anel, string demandado)
        {
            Banco db = new Banco("");

            #region 
            if (estagio1 == "A")
                estagio1 = "1";
            if (estagio1 == "B")
                estagio1 = "2";
            if (estagio1 == "C")
                estagio1 = "4";
            if (estagio1 == "D")
                estagio1 = "8";
            if (estagio1 == "E")
                estagio1 = "10";
            if (estagio1 == "F")
                estagio1 = "20";
            if (estagio1 == "G")
                estagio1 = "40";
            if (estagio1 == "H")
                estagio1 = "80";

            if (estagio2 == "A")
                estagio2 = "1";
            if (estagio2 == "B")
                estagio2 = "2";
            if (estagio2 == "C")
                estagio2 = "4";
            if (estagio2 == "D")
                estagio2 = "8";
            if (estagio2 == "E")
                estagio2 = "10";
            if (estagio2 == "F")
                estagio2 = "20";
            if (estagio2 == "G")
                estagio2 = "40";
            if (estagio2 == "H")
                estagio2 = "80";
            #endregion

            string id = db.ExecuteScalarQuery("select id from scootEntreverdes where Estagio1='" + estagio1 + "' " +
                " and Estagio2='" + estagio2 + "' and scnAnel='" + anel + "' " +
                " and idPrefeitura='" + HttpContext.Current.Profile["idPrefeitura"].ToString() + "' ");

            db.ExecuteNonQuery("update scootEstagios set Dispensavel='" + demandado + "' where scnAnel='" + anel + "' " +
                " and Estagio='" + estagio1 + "' and idPrefeitura='" + HttpContext.Current.Profile["idPrefeitura"].ToString() + "' ");

            if (!string.IsNullOrEmpty(id))
            {
                db.ExecuteNonQuery("update scootEntreverdes set Estagio1='" + estagio1 + "', Estagio2='" + estagio2 + "', Entreverdes='" + entreverdes + "', scnAnel='" + anel + "', demandado='" + demandado + "'  where id='" + id + "' ");
            }
            else
            {
                db.ExecuteScalarQuery("insert into scootEntreverdes (Estagio1, Estagio2, Entreverdes, scnAnel, idPrefeitura, demandado) " +
                " values ('" + estagio1 + "','" + estagio2 + "','" + entreverdes + "','" + anel + "', '" + HttpContext.Current.Profile["idPrefeitura"].ToString() + "', '" + demandado + "') ");
            }
            
            return "";
        }

        //TRADUÇÃO ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

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
    }
}