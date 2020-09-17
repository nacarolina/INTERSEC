using Infortronics;
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

namespace GwCentral.ProgramadorSemanforico
{
    public partial class Versao : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                hfIdPrefeitura.Value = HttpContext.Current.Profile["idPrefeitura"].ToString();
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
        //[WebMethod]
        //public static ArrayList loadMunicipio(string idPrefeitura)
        //{
        //    Banco db = new Banco("");
        //    DataTable dt = db.ExecuteReaderQuery("select Id,Prefeitura from Prefeitura where Id=" + idPrefeitura);
        //    ArrayList lst = new ArrayList();
        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        lst.Add(new ListItem(dr["Prefeitura"].ToString(), dr["Id"].ToString()));
        //    }
        //    return lst;
        //}


        [WebMethod]
        public static string SalvarVersao(string idPrefeitura, string versao, string data, string dsc)
        {
            Banco db = new Banco("");

            if (versao == "")
            {
                return getResource("informeVersao");
            }

            DataTable dt = db.ExecuteReaderQuery("select Id,Prefeitura from Prefeitura where Id=" + idPrefeitura);
            ArrayList lst = new ArrayList();
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["Prefeitura"].ToString(), dr["Id"].ToString()));

                DataTable dtversao = db.ExecuteReaderQuery("SELECT * FROM [semaforo].[dbo].[ProgramadorVersao] where [IdPrefeitura] =  " + dr["Id"].ToString() + " and [Versao] <> '" + versao + "'");
                foreach (DataRow drversao in dtversao.Rows)
                {
                    if (dtversao.Rows.Count > 0)
                    {
                        db.ExecuteNonQuery("UPDATE [dbo].[ProgramadorVersao] SET [Ativo] = 'False' WHERE [Versao] <> '" + versao + "' and [IdPrefeitura] = " + dr["Id"].ToString());
                    }
                }

                db.ExecuteNonQuery("INSERT INTO [dbo].[ProgramadorVersao] ([Versao],[Data],[Dsc],[Ativo],[IdPrefeitura]) " +
                "VALUES ('" + versao + "','" + data + "','" + dsc + "','True'," + dr["Id"].ToString() + ")");
            }

            return "SUCESSO";
        }


        [WebMethod]
        public static List<ProgramadorVersao> GetVersao(string idPrefeitura)
        {
            Banco db = new Banco("");
            List<ProgramadorVersao> lst = new List<ProgramadorVersao>();

            string Versao = "", Data = "", Dsc = "";

            DataTable dt = db.ExecuteReaderQuery("SELECT distinct [Versao],[Data],[Dsc],[Ativo],[IdPrefeitura] FROM [semaforo].[dbo].[ProgramadorVersao]" +
                "where [IdPrefeitura] = " + idPrefeitura + " order by Versao desc");
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ProgramadorVersao
                {
                    Versao = dr["Versao"].ToString(),
                    Data = dr["Data"].ToString(),
                    Dsc = dr["Dsc"].ToString(),
                    Ativo = dr["Ativo"].ToString()
                });
            }

            return lst;
        }


        public struct ProgramadorVersao
        {
            public string Versao { get; set; }
            public string Data { get; set; }
            public string Dsc { get; set; }
            public string Ativo { get; set; }
        }

        [WebMethod]
        public static string EditarVersao(string idPrefeitura, string versao, string dthr, string dsc)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("UPDATE [dbo].[ProgramadorVersao] SET [Data] = '" + dthr + "',[Dsc] = '" + dsc + "' WHERE [IdPrefeitura] = " + idPrefeitura + " and [Versao] = '" + versao + "'");
            return "SUCESSO";
        }


    }
}