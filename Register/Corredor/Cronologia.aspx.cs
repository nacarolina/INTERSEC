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

namespace GwCentral.Register.Corredor
{
    public partial class Cronologia : System.Web.UI.Page
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
            if (!HttpContext.Current.Profile["idioma"].Equals(idioma))
            {
                idioma = HttpContext.Current.Profile["idioma"].ToString();
                cultureInfo = new CultureInfo(idioma);
                Thread.CurrentThread.CurrentCulture = cultureInfo;
                Thread.CurrentThread.CurrentUICulture = cultureInfo;
            }

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
            if (!IsPostBack)
            {
            }
        }
        public struct GruposLocais
        {
            public string grupo { get; set; }
            public string tipo { get; set; }
            public string Endereco { get; set; }
            public string lat { get; set; }
            public string lng { get; set; }
            public string tipoMarcador { get; set; }
            public string idLocal { get; set; }
            public string anel { get; set; }
            public string indice { get; set; }
            public string modelo { get; set; }
            public string idEqp { get; set; }
            public string idCorredorAnel { get; set; }
            public string Distancia { get; set; }
            public string tempoEntreCruzamentos { get; set; }
            public string velocidadeMedia { get; set; }
        }
        [WebMethod]
        public static List<GruposLocais> carregarCronologia(string idCorredor)
        {
            Banco db = new Banco("");
            List<GruposLocais> lst = new List<GruposLocais>();

            string sql = @"Select ca.id,ca.GrupoLogico,Distancia, TipoGrupo,tempoEntreCruzamentos,velocidadeMedia, Endereco, latitude, longitude, lg.tipoMarcador,lg.Id IdLocal,g.Anel,lg.idEqp,
 modelo=(select modelo from ModeloGrupoSemaforico mg where mg.id=g.idModeloGrupoSemaforico),indice
 From CorredorAneis ca Join GruposLogicos g on ca.GrupoLogico=g.GrupoLogico and ca.idEqp=g.idEqp
 JOIN LocaisGruposLogicos lg on lg.id=g.idLocal
  where idCorredor =" + idCorredor + " order by indice";
            DataTable dt = db.ExecuteReaderQuery(sql);
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new GruposLocais
                {
                    grupo = "G" + item["GrupoLogico"].ToString(),
                    tipo = item["TipoGrupo"].ToString(),
                    Endereco = item["Endereco"].ToString(),
                    lat = item["latitude"].ToString(),
                    lng = item["longitude"].ToString(),
                    tipoMarcador = item["tipoMarcador"].ToString(),
                    idLocal = item["IdLocal"].ToString(),
                    anel = item["Anel"].ToString(),
                    idEqp = item["idEqp"].ToString(),
                    modelo = item["modelo"].ToString(),
                    indice = item["Indice"].ToString(),
                    idCorredorAnel = item["id"].ToString(),
                    Distancia = item["Distancia"].ToString(),
                    tempoEntreCruzamentos = item["tempoEntreCruzamentos"].ToString(),
                    velocidadeMedia = item["velocidadeMedia"].ToString()
                });
            }
            return lst;
        }
        [WebMethod]
        public static ArrayList carregarCorredores()
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(@"select Corredor,id  from Corredor where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["Corredor"].ToString(), dr["id"].ToString()));
            }
            return lst;
        }


        [WebMethod]
        public static void salvarGrupoCorredor(string idCorredorAnel, string velocidadeMedia, string TempoEntreCruzamentos, string idCorredor)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("update CorredorAneis set tempoEntreCruzamentos='" + TempoEntreCruzamentos + "',velocidadeMedia='" + velocidadeMedia + "' where id=" + idCorredorAnel);
            DataTable dt = db.ExecuteReaderQuery(" select isnull(tempoEntreCruzamentos,'0')tempoEntreCruzamentos from CorredorAneis where idCorredor=" + idCorredor);
            TimeSpan tsTempoPercurso = new TimeSpan();
            foreach (DataRow dr in dt.Rows)
            {
                TimeSpan ts = new TimeSpan(0, 0,Convert.ToInt32(dr["tempoEntreCruzamentos"].ToString()));
                tsTempoPercurso = tsTempoPercurso.Add(ts);
            }
            db.ExecuteNonQuery("update Corredor set tempoPercurso='" + tsTempoPercurso.Minutes.ToString().PadLeft(2,'0')+":"+tsTempoPercurso.Seconds.ToString().PadLeft(2, '0') + "' where id=" + idCorredor);
        }

        [WebMethod]
        public static string carregarTempoPercurso(string idCorredor)
        {
            Banco db = new Banco("");
            string tempoPErcurso = db.ExecuteScalarQuery("select tempoPercurso from Corredor where id=" + idCorredor);

            return tempoPErcurso;
        }
    }
}