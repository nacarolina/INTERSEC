using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Runtime.InteropServices;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using static GwCentral.Admin.MapConfig;

namespace GwCentral.Scoot
{
    public partial class link : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfUsuarioLogado.Value = User.Identity.Name;
            }
        }

        public struct Link
        {
            public string id { get; set; }
            public string scnlink { get; set; }
            public string linkType { get; set; }
            public string junction { get; set; }
            public string linkClass { get; set; }
            public string stageGreens { get; set; }
            public string stoplineLink { get; set; }
            public string stoplineUpLink { get; set; }
            public string upstreamNode { get; set; }
            public string upNodeThruStage { get; set; }
            public string downNodeThruStage { get; set; }
            public string mainDownstream { get; set; }
            public string congestionLink { get; set; }
            public string BottleneckLink { get; set; }
            public string BusEquipamentScn { get; set; }
        }

        #region loadJunction
        public struct lstJunction
        {
            public string junction { get; set; }
        }

        [WebMethod]
        public static List<lstJunction> loadJunction()
        {
            Banco db = new Banco("");

            List<lstJunction> lst = new List<lstJunction>();

            DataTable dt = db.ExecuteReaderQuery(
                @"SELECT junction FROM ScootJunction"
                );

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new lstJunction
                {
                    junction = item["junction"].ToString()
                });
            }

            return lst;
        }
        #endregion

        #region
        [WebMethod]
        public static List<Link> carregarLinks(string junction)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(
                @"SELECT * FROM scootLink
                WHERE junctionSCN LIKE '%"+junction+"%'"
                );
            List<Link> lst = new List<Link>();
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new Link
                {
                    id = dr["id"].ToString(),
                    junction = dr["JunctionSCN"].ToString(),
                    scnlink = dr["scnLink"].ToString(),
                    linkClass = dr["linkClass"].ToString(),
                    linkType=dr["linkType"].ToString(),
                    stageGreens=dr["StageGreens"].ToString(),
                    stoplineLink=dr["stoplineLink"].ToString(),
                    BottleneckLink=dr["BottleneckLinkScn"].ToString(),
                    BusEquipamentScn=dr["BusEquipamentScn"].ToString(),
                    congestionLink=dr["CongestionLink"].ToString(),
                    downNodeThruStage=dr["downNodeThruStage"].ToString(),
                    mainDownstream=dr["mainDownStreamLink"].ToString(),
                    stoplineUpLink=dr["stoplineUpLink"].ToString(),
                    upNodeThruStage=dr["upNodeThruStage"].ToString(),
                    upstreamNode=dr["upStreamNodeScn"].ToString()
                }) ;
            }

            return lst;
        } 
        #endregion

        [WebMethod]
        public static ArrayList getProximaAproximacao(string junction)
        {
            Banco db = new Banco("");
            ArrayList lst = new ArrayList();

            string outstation = junction.Replace("J", "X");
            outstation = outstation.Substring(0, outstation.Length - 1) + "0";
            string aprox = db.ExecuteScalarQuery("select scnLink from scootLInk where Junction_SCN='" + junction + "'").Replace(junction.Replace("J", "N"), "");

            #region trata
            if (aprox == "")
                aprox = "A";
            else if (aprox == "A")
                aprox = "B";
            else if (aprox == "B")
                aprox = "C";
            else if (aprox == "C")
                aprox = "D";
            else if (aprox == "D")
                aprox = "E";
            else if (aprox == "E")
                aprox = "F";
            else if (aprox == "F")
                aprox = "G";
            else if (aprox == "G")
                aprox = "H";
            else if (aprox == "H")
                aprox = "I";
            else if (aprox == "I")
                aprox = "J";
            else if (aprox == "J")
                aprox = "K";
            else if (aprox == "K")
                aprox = "L";
            else if (aprox == "L")
                aprox = "M";
            else if (aprox == "M")
                aprox = "N";
            else if (aprox == "N")
                aprox = "O";
            else if (aprox == "O")
                aprox = "P";
            else if (aprox == "P")
                aprox = "Q";
            else if (aprox == "Q")
                aprox = "R";
            else if (aprox == "R")
                aprox = "S";
            else if (aprox == "S")
                aprox = "T";
            else if (aprox == "T")
                aprox = "U";
            else if (aprox == "U")
                aprox = "V";
            else if (aprox == "V")
                aprox = "W";
            else if (aprox == "W")
                aprox = "X";
            else if (aprox == "X")
                aprox = "Y";
            else if (aprox == "Y")
                aprox = "Z";
            else if (aprox == "Z")
                aprox = "";
            #endregion 

            string QtdLacosAdicionados = db.ExecuteScalarQuery("select count(0) from scootLaco where outstationSCN='" + outstation + "'");

            lst.Add(new ListItem(aprox, QtdLacosAdicionados));
            return lst;
        }

        [WebMethod]
        public static string salvar(string junction, string outstation, string node, string scn_link, string link_type,
             string link_class, string utc_stage_greens, string stopline_link, string stopline_uplink,
             string upstream_node, string up_node_thru_stage, string down_node_thru_stage, string main_downstream_link,
             string congestion_link, string bottleneck_link, string bus_equipament_scn, string connected_user)
        {
            Banco db = new Banco("");

            //scootCONTROLADORES
            string id = db.ExecuteScalarQuery(
                @"INSERT INTO scootlink(junctionScn,outstationScn,nodeScn,scnlink,linktype,linkclass,stagegreens,
                stoplinelink,stoplineuplink,upstreamnodescn,upnodethrustage,downnodethrustage,
                maindownstreamlink,congestionlink,bottlenecklinkscn,busequipamentscn) 
                VALUES ('" + junction + "','" + outstation + "','" + node + "','" + scn_link + "','" + link_type + "', " +
                " '" + link_class + "','" + utc_stage_greens + "','" + stopline_link + "', " +
                " '" + stopline_uplink + "','" + upstream_node + "', '" + up_node_thru_stage + "', " +
                " '" + down_node_thru_stage + "','" + main_downstream_link + "','" + congestion_link + "', " +
                " '" + bottleneck_link + "','" + bus_equipament_scn + "') " +
                " SELECT SCOPE_IDENTITY()"
                );

            #region LOG
            db.ExecuteNonQuery(
                @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela)
                VALUES ('" + connected_user + "','Scoot - Link', " +
                HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                " 'Salvou a aproximação: " + scn_link + ", Junction= " + junction + ", " +
                " Outstation= " + outstation + ", Node= " + node + ", Link Type= " + link_type + ", Link Class= " + link_class + ", " +
                " UTC Stage Greens=" + utc_stage_greens + ", Stopline Link=" + stopline_link + ", " +
                " Stopline Upline=" + stopline_uplink + ", Upstream Node=" + upstream_node + ", " +
                " Up Node Thru Stage=" + up_node_thru_stage + ", Down Node Thru Stage=" + down_node_thru_stage + ", " +
                " Main Downstream Link=" + main_downstream_link + ", Congestion Link=" + congestion_link + ", " +
                " Bottleneck Link=" + bottleneck_link + ", Bus Equipament SCN=" + bus_equipament_scn + "', " +
                " 'scootLink')"
                );
            #endregion

            return "success";
        }

        #region SCRIPT TRANSLATION
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
        #endregion
    }
}