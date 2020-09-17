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

namespace GwCentral.Register.Trajetos
{
    public partial class TrajetoGrupoSemaforico : System.Web.UI.Page
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
            Banco db = new Banco("");

            if (!IsPostBack)
            {
                DataTable dt = db.ExecuteReaderQuery(string.Format(@"select top 1 latitude,longitude from ConfigMap where idPrefeitura = {0}", HttpContext.Current.Profile["idPrefeitura"]));

                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    hfLat.Value = dr["latitude"].ToString();
                    hfLng.Value = dr["longitude"].ToString();
                }
                hfIdSubarea.Value = Request.QueryString["idSubarea"];
                hfSubarea.Value = Request.QueryString["Subarea"];
                hfCallServer.Value = !string.IsNullOrEmpty(Request.QueryString["Call"]) ? Request.QueryString["Call"] : "";
                hfId.Value = !string.IsNullOrEmpty(Request.QueryString["Id"]) ? Request.QueryString["Id"] : "";
            }
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

        public class routeWayPoints
        {
            public string Waypoints { get; set; }
            public string Trajeto { get; set; }
            public string id { get; set; }
            public string idArea { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public static string SalvarTrajeto(List<routeWayPoints> routes)
        {
            string id = "";
            Banco db = new Banco("");
            foreach (var item in routes)
            {
                #region InsertLinhaItinerarios

                id = db.ExecuteScalarQuery(@"INSERT INTO Trajetos (Nome,coordenadas,idPrefeitura,idArea)VALUES('" + item.Trajeto + "','" + item.Waypoints + "',"
                    + HttpContext.Current.Profile["idPrefeitura"] + "," + item.idArea + ")select scope_identity()");

                #endregion
            }
            return id;
        }

        [WebMethod(EnableSession = true)]
        public static string EditarTrajeto(List<routeWayPoints> routes)
        {
            string id = "";
            Banco db = new Banco("");
            foreach (var item in routes)
            {
                #region EditLinhaItinerarios
                id = item.id;
                db.ExecuteNonQuery(@"Update Trajetos set Nome='" + item.Trajeto + "', coordenadas='" + item.Waypoints + "', idArea=" + item.idArea + " where id=" + item.id);
                #endregion
            }
            return id;
        }

        public class infoGrupos
        {
            public string id { get; set; }
            public string grupo { get; set; }
            public string idLocal { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public static void SalvarGrupoTrajeto(List<infoGrupos> grupos)
        {
            Banco db = new Banco("");
            foreach (var item in grupos)
            {
                string idTrajeto = db.ExecuteScalarQuery(@"Select idTrajeto from GruposLogicos Where GrupoLogico=" + item.grupo +
                    " and idLocal=" + item.idLocal + " and idTrajeto=" + item.id);

                if (string.IsNullOrEmpty(idTrajeto)) db.ExecuteNonQuery(@"Update GruposLogicos set idTrajeto=" + item.id +
                    " Where GrupoLogico=" + item.grupo + " and idLocal=" + item.idLocal);
            }
        }

        [WebMethod]
        public static void ExcluirTrajeto(string id)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("delete from Trajetos where id=" + id + "; Update GruposLogicos set idTrajeto=null Where idTrajeto=" + id);
        }

        [WebMethod]
        public static void ExcluirVinculoGrupo(string grupo, string idLocal)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("Update GruposLogicos set idTrajeto=null Where GrupoLogico=" + grupo + " and idLocal=" + idLocal);
        }

        public struct LoadTrajetos
        {
            public string Id { get; set; }
            public string Trajeto { get; set; }
            public string WayPoints { get; set; }
            public string idArea { get; set; }
            public string area { get; set; }
            public string coords { get; set; }
        }


        [WebMethod]
        public static List<LoadTrajetos> DetalhesTrajeto(string id)
        {
            Banco db = new Banco("");
            List<LoadTrajetos> lst = new List<LoadTrajetos>();
            DataTable dt = db.ExecuteReaderQuery(@"select id,Nome,Replace(Replace(coordenadas,'(',''),')','@')coordenadas,idArea from Trajetos where id=" + id);
            foreach (DataRow item in dt.Rows)
            {
                string nomeArea = "";
                DataTable dtArea = db.ExecuteReaderQuery("Select Nome from Area_SubArea Where id=" + item["idArea"].ToString());
                if (dtArea.Rows.Count > 0)
                    nomeArea = dtArea.Rows[0]["Nome"].ToString();

                lst.Add(new LoadTrajetos
                {
                    Id = item["id"].ToString(),
                    Trajeto = item["Nome"].ToString(),
                    WayPoints = item["coordenadas"].ToString(),
                    idArea = item["idArea"].ToString(),
                    area = nomeArea
                });

            }

            return lst;
        }

        public struct GruposVinculados
        {
            public string grupo { get; set; }
            public string tipo { get; set; }
            public string Endereco { get; set; }
            public string lat { get; set; }
            public string lng { get; set; }
            public string tipoMarcador { get; set; }
            public string idLocal { get; set; }
            public string anel { get; set; }
            public string idEqp { get; set; }
        }

        [WebMethod]
        public static List<GruposVinculados> getGruposVinculados(string idTrajeto)
        {
            Banco db = new Banco("");
            List<GruposVinculados> lst = new List<GruposVinculados>();
            DataTable dt = db.ExecuteReaderQuery(@"Select GrupoLogico,TipoGrupo,Endereco,latitude,longitude,lg.tipoMarcador,lg.Id IdLocal,g.Anel, g.idEqp
From LocaisGruposLogicos lg left Join GruposLogicos g on lg.Id = g.IdLocal Where lg.IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]
+ " and g.idTrajeto=" + idTrajeto);
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new GruposVinculados
                {
                    grupo = item["GrupoLogico"].ToString(),
                    tipo = item["TipoGrupo"].ToString(),
                    Endereco = item["Endereco"].ToString(),
                    lat = item["latitude"].ToString(),
                    lng = item["longitude"].ToString(),
                    tipoMarcador = item["tipoMarcador"].ToString(),
                    idLocal = item["IdLocal"].ToString(),
                    anel = item["Anel"].ToString(),
                    idEqp = item["idEqp"].ToString()
                });

            }

            return lst;
        }
    }
}