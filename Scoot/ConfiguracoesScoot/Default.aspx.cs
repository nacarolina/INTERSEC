using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using static GwCentral.Admin.MapConfig;

namespace GwCentral.Scoot.ConfiguracoesScoot
{
    public partial class ConfiguracoesScoot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hfUsuarioLogado.Value = User.Identity.Name;
        }

        [WebMethod]
        public static ArrayList loadControladores()
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery("select scnControlador from scootControladores where idprefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["scnControlador"].ToString(), dr["scnControlador"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public static ArrayList carregarAneis(string controlador)
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery("select scnAnel1,isnull(qtdEstagioAnel1,'0')qtdEstagioAnel1 from scootControladores where scnAnel1<>'' and scnControlador='" + controlador + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + " " +
            "union select scnAnel2,isnull(qtdEstagioAnel2,'0')qtdEstagioAnel2 from scootControladores where scnAnel2<>'' and scnControlador='" + controlador + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() +
            "union select scnAnel3,isnull(qtdEstagioAnel3,'0')qtdEstagioAnel3 from scootControladores where scnAnel3<>'' and scnControlador='" + controlador + "' and idPrefeitura= " + HttpContext.Current.Profile["idPrefeitura"].ToString() +
            "union select scnAnel4,isnull(qtdEstagioAnel4,'0')qtdEstagioAnel4 from scootControladores where scnAnel4<>'' and scnControlador='" + controlador + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["scnAnel1"].ToString(), dr["qtdEstagioAnel1"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public static ArrayList carregarEstagios(string anel)
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery("select id, estagio from scootEstagios where scnAnel='" + anel + "' and idPrefeitura='" + HttpContext.Current.Profile["idPrefeitura"].ToString() + "' order by convert(int,estagio)");

            string estagio = "";            foreach (DataRow dr in dt.Rows)            {
                string estagioHexa = dr["estagio"].ToString();
                string estagioBinario = HexToBinary(estagioHexa);
                //00000001 = A
                //00000010 = B
                //00000100 = C
                //00001000 = D
                //00010000 = E
                //00100000 = F
                //01000000 = G
                //10000000 = H

                if (estagioBinario == "00000001")                    estagio = "A";                if (estagioBinario == "00000010")                    estagio = "B";                if (estagioBinario == "00000100")                    estagio = "C";                if (estagioBinario == "00001000")                    estagio = "D";                if (estagioBinario == "00010000")                    estagio = "E";                if (estagioBinario == "00100000")                    estagio = "F";                if (estagioBinario == "01000000")                    estagio = "G";                if (estagioBinario == "10000000")                    estagio = "H";                lst.Add(new ListItem(estagio, dr["estagio"].ToString()));            }
            return lst;
        }

        public struct Detectores
        {
            public string anel { get; set; }
            public string estagio { get; set; }
            public string detector { get; set; }
        }

        [WebMethod]
        public static List<Detectores> carregarEstagiosCadastrados(string controlador)
        {
            List<Detectores> lst = new List<Detectores>();
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery("select estagio,anel,detector from scootLacos where scnControlador='" + controlador + "'");
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new Detectores
                {
                    anel = dr["Anel"].ToString(),
                    estagio = dr["estagio"].ToString(),
                    detector = dr["detector"].ToString()
                });
            }
            return lst;
        }

        #region CONVERSÃO BINÁRIO/HEXA - HEXA/BINÁRIO
        public static string BinaryStringToHexString(string binary)
        {
            if (string.IsNullOrEmpty(binary))
                return binary;

            StringBuilder result = new StringBuilder(binary.Length / 8 + 1);

            // TODO: check all 1's or 0's... throw otherwise

            int mod4Len = binary.Length % 8;
            if (mod4Len != 0)
            {
                // pad to length multiple of 8
                binary = binary.PadLeft(((binary.Length / 8) + 1) * 8, '0');
            }

            for (int i = 0; i < binary.Length; i += 8)
            {
                string eightBits = binary.Substring(i, 8);
                result.AppendFormat("{0:X2}", Convert.ToByte(eightBits, 2));
            }

            return result.ToString();
        }

        public static string HexToBinary(string hexValue)
        {
            string binaryval = "";
            binaryval = Convert.ToString(Convert.ToInt32(hexValue, 16), 2).PadLeft(8, '0');
            return binaryval;
        }
        #endregion

        [WebMethod]
        public static string salvarLacos(string controlador, string detector, string anel, string estagio, string usuarioLogado)
        {
            Banco db = new Banco("");

            string existe = db.ExecuteScalarQuery("select id from scootLacos where scnControlador='" + controlador + "' " +
                " and detector = '" + detector + "' ");
            if (existe != "")
            {
                db.ExecuteNonQuery("update scootLacos set anel='" + anel + "', estagio='" + estagio + "' where id='" + existe + "' ");

                db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) " +
                " values ('" + usuarioLogado + "','Scoot - ConfiguraçõesScoot'," + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','Alterou o Detector: " + detector + " do anel: " + anel + " " +
                " e estágio: " + estagio + "' do Controlador: " + controlador + "','scootLacos')");
            }
            else
            {
                db.ExecuteNonQuery("insert into scootLacos (scnControlador,detector,anel,estagio,idPrefeitura) " +
                                " values ('" + controlador + "','" + detector + "','" + anel + "','" + estagio + "', " +
                                " " + HttpContext.Current.Profile["idPrefeitura"] + ") ");

                db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) " +
                " values ('" + usuarioLogado + "','Scoot - ConfiguraçõesScoot'," + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','Cadastrou o Detector: " + detector + " com anel: " + anel + " " +
                " e estágio: " + estagio + "' do Controlador: " + controlador + "','scootLacos')");
            }

            return "SUCESSO";
        }

        [WebMethod]
        public static void excluirDetector(string controlador, string detector, string usuarioLogado)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery("delete from scootLacos where scnControlador='" + controlador + "' and detector='" + detector + "' ");

            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) " +
                " values ('" + usuarioLogado + "','Scoot - ConfiguraçõesScoot'," + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','Excluiu o Detector: " + detector + ", do Controlador: " + controlador + "','scootLacos')");
        }

        //------------------------------------------------------------------------------------------------------------------------------

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
    }
}