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

namespace GwCentral.Register.Corredor
{
    public partial class Map : System.Web.UI.Page
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
            hfUser.Value = User.Identity.Name;
            if (!IsPostBack)
            {
                hfIdCorredor.Value = Request.QueryString["idCorredor"];
                if (hfIdCorredor.Value != "")
                {
                    hfOrigem.Value = "alterar";
                }
                else
                    hfOrigem.Value = "novo";
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
        }
        [WebMethod]
        public static List<GruposLocais> carregarGruposNoMapa(string endereco)
        {
            Banco db = new Banco("");
            List<GruposLocais> lst = new List<GruposLocais>();

            string sql = @"Select GrupoLogico, TipoGrupo, Endereco, latitude, longitude, lg.tipoMarcador,lg.Id IdLocal,g.Anel,lg.idEqp, modelo=(select modelo from ModeloGrupoSemaforico mg where mg.id=g.idModeloGrupoSemaforico)
 From LocaisGruposLogicos lg Join GruposLogicos g on lg.Id = g.IdLocal where endereco like '%" + endereco +
"%' order by endereco";
            DataTable dt = db.ExecuteReaderQuery(sql);
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new GruposLocais
                {
                    grupo = item["GrupoLogico"].ToString(),
                    tipo = item["TipoGrupo"].ToString(),
                    Endereco = item["Endereco"].ToString(),
                    lat = item["latitude"].ToString(),
                    lng = item["longitude"].ToString(),
                    tipoMarcador = item["tipoMarcador"].ToString(),
                    idLocal = item["IdLocal"].ToString(),
                    anel = item["Anel"].ToString(),
                    idEqp = item["idEqp"].ToString(),
                    modelo = item["modelo"].ToString()
                });
            }
            return lst;
        }
        [WebMethod]
        public static List<GruposLocais> carregarGruposCorredorNoMapa(string idCorredor)
        {
            Banco db = new Banco("");
            List<GruposLocais> lst = new List<GruposLocais>();

            string sql = @"Select ca.id,ca.GrupoLogico,Distancia, TipoGrupo, Endereco, latitude, longitude, lg.tipoMarcador,lg.Id IdLocal,g.Anel,lg.idEqp,
 modelo=(select modelo from ModeloGrupoSemaforico mg where mg.id=g.idModeloGrupoSemaforico),indice
 From CorredorAneis ca Join GruposLogicos g on ca.GrupoLogico=g.GrupoLogico and ca.idEqp=g.idEqp
 JOIN LocaisGruposLogicos lg on lg.id=g.idLocal
  where idCorredor =" + idCorredor +" order by indice";
            DataTable dt = db.ExecuteReaderQuery(sql);
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new GruposLocais
                {
                    grupo = item["GrupoLogico"].ToString(),
                    tipo = item["TipoGrupo"].ToString(),
                    Endereco = item["Endereco"].ToString(),
                    lat = item["latitude"].ToString(),
                    lng = item["longitude"].ToString(),
                    tipoMarcador = item["tipoMarcador"].ToString(),
                    idLocal = item["IdLocal"].ToString(),
                    anel = item["Anel"].ToString(),
                    idEqp = item["idEqp"].ToString(),
                    modelo = item["modelo"].ToString(),
                    indice=item["Indice"].ToString(),
                    idCorredorAnel=item["id"].ToString(),
                    Distancia=item["Distancia"].ToString()
                });
            }
            return lst;
        }

        [WebMethod]
        public static void excluirCorredor(string idCorredor)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("delete Corredor where id=" + idCorredor);
            db.ExecuteNonQuery("delete CorredorAneis where idCorredor=" + idCorredor);
        }

        [WebMethod]
        public static void salvarCorredor(string idCorredor,string corredor,string wayPoints, string tempoPercurso)
        {
            Banco db = new Banco("");
            db.ExecuteScalarQuery("update Corredor set corredor='" + corredor + "',wayPoints='"+wayPoints+"',tempoPercurso='"+tempoPercurso+"' where id=" + idCorredor);
        }
        public struct Corredor
        {
            public string NomeCorredor { get; set; }
            public string TempoPercurso { get; set; }
            public string WayPoints { get; set; } 
        }

        [WebMethod]
        public static List<Corredor> CarregarCorredor(string idCorredor)
        {
            Banco db = new Banco("");
            List<Corredor> lst = new List<Corredor>();
            DataTable dt = db.ExecuteReaderQuery(@"select Corredor,TempoPercurso,WayPoints from Corredor where id=" + idCorredor);
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new Corredor
                {
                    NomeCorredor = item["Corredor"].ToString(),
                    TempoPercurso = item["TempoPercurso"].ToString(), 
                    WayPoints = item["WayPoints"].ToString(), 
                });

            }

            return lst;
        }


        [WebMethod]
        public static string salvarGrupoNoCorredor(string idCorredor, string corredor, string grupo, string idEqp, string indice, string wayPoints, string lat, string lng)
        {
            Banco db = new Banco("");
            string id = "", idCorredorAnterior = "",latAnterior="",lngAnterior="";
            if (Convert.ToInt32(indice) > 1)
            {
                int indiceAnterior = Convert.ToInt32(indice) - 1;
                DataTable dt = db.ExecuteReaderQuery(@"select id,latGrupo,lngGrupo from CorredorAneis where idPrefeitura ="+ HttpContext.Current.Profile["idPrefeitura"] + " and idCorredor="+idCorredor+" and indice='"+indiceAnterior+"'");
                foreach (DataRow dr in dt.Rows)
                {
                    idCorredorAnterior = dr["id"].ToString();
                    latAnterior = dr["latGrupo"].ToString();
                    lngAnterior = dr["lngGrupo"].ToString();

                }
            }
            if (idCorredor == "")
            {
                id = db.ExecuteScalarQuery("insert into corredor (Corredor,TempoPercurso,idPrefeitura,wayPoints) values('" + corredor + "',''," + HttpContext.Current.Profile["idPrefeitura"] + ",'"+wayPoints+"') select SCOPE_IDENTITY()");
                db.ExecuteNonQuery("insert into CorredorAneis (idPrefeitura,idEqp,GrupoLogico,indice,idCorredor,idCorredorAnterior,latGrupo,lngGrupo) values (" + HttpContext.Current.Profile["idPrefeitura"]
                    + ",'"+idEqp+"','"+grupo+"','"+indice+"',"+id+",'','"+lat+"','"+lng+"')");
            }
            else
            {
                double distancia = CalcularDistancia(Double.Parse(lat.Replace(".",",")), Double.Parse(lng.Replace(".", ",")), Double.Parse(latAnterior.Replace(".", ",")), Double.Parse(lngAnterior.Replace(".", ",")), "K");

                db.ExecuteNonQuery("insert into CorredorAneis (idPrefeitura,idEqp,GrupoLogico,indice,idCorredor,idCorredorAnterior,latGrupo,lngGrupo,distancia) values (" + HttpContext.Current.Profile["idPrefeitura"]
                    + ",'" + idEqp + "','" + grupo + "','" + indice + "'," + idCorredor + ",'"+idCorredorAnterior+ "','" + lat + "','" + lng + "','" + distancia+"')");
            }
            return id;
        }
        /**********CalcularDistancia
 *
 * ESPERADO: (double) lat1 = Latitude1 Origem
 *           (double) lon1 = Longitude1 Origem
 *
 *           (double) lat2 = Latitude2  Destino
 *           (double) lon2 = Longitude2 Destino
 *
 * RETORNO: (double) DISTANCIA em METROS entre as coordenadas
 *
 * */
        public static double CalcularDistancia(double lat1, double lon1, double lat2, double lon2, String UnidadeMedida_Retorno)
        {
            double theta = lon1 - lon2;
            double dist = Math.Sin(deg2rad(lat1)) * Math.Sin(deg2rad(lat2)) + Math.Cos(deg2rad(lat1)) * Math.Cos(deg2rad(lat2)) * Math.Cos(deg2rad(theta));
            dist = Math.Acos(dist);
            dist = rad2deg(dist);
            dist = dist * 60 * 1.1515; // M = Miles (default)
            if (UnidadeMedida_Retorno.Equals("K"))
            {
                dist = dist * 1.609344; //K =; Kilometers 
                
                String DistanciaFormatada = string.Format("{0:0.000}", dist);
                dist = Convert.ToDouble(DistanciaFormatada);
            }
            else if (UnidadeMedida_Retorno.Equals("N"))
            {
                dist = dist * 0.8684;   //N = Nautical Miles
            }

            return (dist);
        }
        /*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
        /*::    This function converts decimal degrees to radians           :*/
        /*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
        private static double deg2rad(double deg)
        {
            return (deg * Math.PI / 180.0);
        }

        /*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
        /*::    This function converts radians to decimal degrees           :*/
        /*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
        private static double rad2deg(double rad)
        {
            return (rad * 180 / Math.PI);
        }
    }
}