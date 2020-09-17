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

namespace GwCentral.Controlador
{
    public partial class GruposSemaforicos : System.Web.UI.Page
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

        protected void Page_Load(object sender, EventArgs e)
        {
            hfIdEqp.Value = Request.QueryString["idEqp"];
        }

        public struct ListaGrupos
        {
            public string Grupo { get; set; }
            public string Endereco { get; set; }
            public string Tipo { get; set; }
        }

        [WebMethod]
        public static List<ListaGrupos> GetListaGrupos(string idEqp)
        {
            Banco db = new Banco("");
            string serial = db.ExecuteScalarQuery(" select serial from [Status] where idDna='" + idEqp + "'");
            List<ListaGrupos> lst = new List<ListaGrupos>();

            DataTable dt = db.ExecuteReaderQuery(@"select 'Anel: ' + convert(varchar,anel,102) +' - '+convert(varchar,grupoLogico,102)grupoLogico,TipoGrupo,
            endereco = (select endereco from LocaisGruposLogicos l where l.id = gl.idlocal)
            from GruposLogicos gl where ideqp = '" + serial + "' order by anel, convert(int, grupologico, 103)");
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListaGrupos
                {
                    Grupo = dr["grupoLogico"].ToString(),
                    Tipo = dr["TipoGrupo"].ToString(),
                    Endereco = dr["endereco"].ToString()
                });
            }
            return lst;
        }
    }
}