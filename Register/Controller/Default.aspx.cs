using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace GwCentral.Register.Controller
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
        
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            Banco db = new Banco("");
            string filepath = Server.MapPath("\\ArquivoCroqui");
            HttpFileCollection uploadedFiles = Request.Files;

            for (int i = 0; i < uploadedFiles.Count; i++)
            {
                HttpPostedFile userPostedFile = uploadedFiles[i];

                try
                {
                    if (userPostedFile.ContentLength > 0)
                    {
                        userPostedFile.SaveAs(filepath + "\\" + Path.GetFileName(userPostedFile.FileName));
                    }
                }
                catch (Exception Ex)
                {
                }
            }
            return;
        }

        public struct Equipamento
        {
            public string cruzamento { get; set; }
            public string idDna { get; set; }
            public string serial { get; set; }
        }

        [WebMethod]
        public static List<Equipamento> GetAllEqp()
        {
            Banco db = new Banco("");
            List<Equipamento> lstEqp = new List<Equipamento>();
            DataTable dt = db.ExecuteReaderQuery(@"select d.Cruzamento,d.Id,s.Serial from DNA d 
left join Status s on s.IdDna = d.Id and s.idprefeitura=d.idprefeitura 
where d.IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);


            foreach (DataRow item in dt.Rows)
            {
                lstEqp.Add(new Equipamento
                {
                    cruzamento = item["Cruzamento"].ToString(),
                    idDna = item["Id"].ToString(),
                    serial = item["Serial"].ToString()
                });
            }

            return lstEqp;
        }
        [WebMethod]
        public static List<string> GetDna(string prefixText)
        {
            Banco db = new Banco(""); 

            db.ClearSQLParams();
            db.AddSQLParam("Cruzamento", prefixText);
            db.AddSQLParam("idPrefeitura", HttpContext.Current.Profile["idPrefeitura"]);
            DataTable dt = db.ExecuteReaderStoredProcedure("GetDna", true);

            List<string> lstDna = new List<string>();

            foreach (DataRow item in dt.Rows)
            {
                lstDna.Add(string.Format("{0}@{1}", item["Id"].ToString(), item["Cruzamento"].ToString()));
            }

            return lstDna;
        }


        [WebMethod]
        public static string SalvarArquivo(string base64, string NomeArquivo, string idEqp)
        {
            Banco db = new Banco("");
            try
            {
                base64 = base64.Replace("\"", "");
                byte[] bytes = Convert.FromBase64String(base64);
                string path = System.Web.Hosting.HostingEnvironment.MapPath("~/Register/Controller/ArquivoCroqui/"+ NomeArquivo);
                File.WriteAllBytes(path, Convert.FromBase64String(base64));

                db.ExecuteNonQuery("insert into CroquiEqp (idPrefeitura,idEqp,NomeArquivo) values(" + HttpContext.Current.Profile["idPrefeitura"] + ",'" + idEqp + "','" + NomeArquivo + "')");

                return "Arquivo foi salvo com sucesso";
            }
            catch (Exception e)
            {
                return "Erro ao Salvar - " + e.Message;
            }
        }
    }
}