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

namespace GwCentral.Register.Trajetos
{
    public partial class Trajetos : System.Web.UI.Page
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
        }

        public struct LoadAllRoutes
        {
            public string Id { get; set; }
            public string Nome { get; set; }
            public string Area { get; set; }
        }

        [WebMethod]
        public static List<LoadAllRoutes> FindAllRoutes()
        {
            Banco db = new Banco("");
            DataTable dt;

            List<LoadAllRoutes> lst = new List<LoadAllRoutes>();
            dt = db.ExecuteReaderQuery(@"select * from Trajetos Where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

            foreach (DataRow item in dt.Rows)
            {
                string area = "";
                area = db.ExecuteScalarQuery("Select NomeArea from Area Where id=" + item["idArea"].ToString());
                lst.Add(new LoadAllRoutes
                {
                    Id = item["id"].ToString(),
                    Nome = item["Nome"].ToString(),
                    Area = area
                });
            }
            return lst;
        }
    }
}