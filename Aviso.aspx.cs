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

namespace GwCentral
{
    public partial class Aviso : System.Web.UI.Page
    {
        public static string idioma = "pt-BR";
        public static CultureInfo cultureInfo;
        Banco db = new Banco("");
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

        [WebMethod]
        public static List<string> GetAvisosControlador(string dtInicial, string dtFinal, string idEqp, string falha)
        {
            List<string> lstProblems = new List<string>();
            DataTable dt = new DataTable();
            Banco db = new Banco("");
            string sql = @"";
            if (dtInicial == "" && dtFinal == "")
            {
                sql = @"select top 350 l.idEqp,l.Falha,l.DataHora,Funcao,l.Id from Status s
JOIN LogsControlador l on l.idEqp=serial where IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and FalhaSolucionada='N' ";
            }
            else
            {
                sql = @"select l.idEqp,l.Falha,l.DataHora,Funcao,l.Id from Status s 
JOIN LogsControlador l on l.idEqp = serial where IdPrefeitura =" + HttpContext.Current.Profile["idPrefeitura"] + "and FalhaSolucionada = 'N'";
                dtInicial = dtInicial.Substring(6, 4) + dtInicial.Substring(3, 2) + dtInicial.Substring(0, 2);
                dtFinal = dtFinal.Substring(6, 4) + dtFinal.Substring(3, 2) + dtFinal.Substring(0, 2);
                sql += " and CONVERT(bigint,l.dataHora,103)>=CONVERT(bigint,'" + dtInicial + "000000',103) and  CONVERT(bigint,l.dataHora,103)<=CONVERT(bigint,'" + dtFinal + "235959',103) ";
            }
            if (idEqp != "")
            {
                sql += " and l.idEqp='" + idEqp + "'";
            }
            if (falha!="")
            {
                sql += " and (Funcao like '%"+falha+"%' or l.Falha like'%"+falha+"%')";
            }
            sql += " order by l.DataHora desc";
            dt = db.ExecuteReaderQuery(sql);
            string DtHr = "";
            foreach (DataRow item in dt.Rows)
            {
                string ano = item["DataHora"].ToString().Substring(0, 4);
                string mes = item["DataHora"].ToString().Substring(4, 2);
                string dia = item["DataHora"].ToString().Substring(6, 2);
                string hr = item["DataHora"].ToString().Substring(8, 2);
                string min = item["DataHora"].ToString().Substring(10, 2);
                string seg = item["DataHora"].ToString().Substring(12, 2);
                DtHr = dia + "/" + mes + "/" + ano + " " + hr + ":" + min + ":" + seg;
                lstProblems.Add(string.Format("{0}@{1}@{2}@{3}@{4}", item["idEqp"].ToString(), item["Falha"].ToString(), DtHr,item["Funcao"].ToString(),item["Id"].ToString()));
            }

            return lstProblems;
        }

		[WebMethod]
		public static void SolucionarFalha(string id, string user, string idEqp)
		{
			Banco db = new Banco("");
			db.ExecuteNonQuery("update LogsControlador set FalhaSolucionada='S' where id=" + id);

			db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Alarmes'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
			   "','Solucionou a Falha manualmente do idEqp: " + idEqp + ", idLogControlador: "+id+"','LogsControlador')");
		}
    }
}