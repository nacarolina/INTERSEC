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

namespace GwCentral.MonitoramentoCentral
{
    public partial class Monitoramento : System.Web.UI.Page
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
                Banco db = new Banco("");
                string retorno = !string.IsNullOrEmpty(Request.QueryString["IdEqp"]) ? Request.QueryString["IdEqp"] : "";
                hdfIdEqp.Value = db.ExecuteScalarQuery("Select Serial from Status Where IdDna='" + retorno+"'");
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

        [WebMethod]
        public static string getFalhasEqp(string idEqp)
        {
            string falha = "SC";
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"select falha,isnull((case when (DATEDIFF(minute,convert(datetime,s.atualizado),getdate()) < isnull(tempofalhacomunicacao,15))
then 'True' else 'False' end),'False') comunicaControll
 from DNA d
 JOIN[Status] s on s.IdDna = d.id
join ConfigMap cm on cm.idPrefeitura = d.idPrefeitura where d.idPrefeitura="+ HttpContext.Current.Profile["idPrefeitura"] + " and d.id='"+idEqp+"'");
            if (dt.Rows.Count>0)
            {
                DataRow dr = dt.Rows[0];
                if (dr["comunicaControll"].ToString() == "False")
                {
                    falha = "FC";
                }
                else
                    falha = dr["Falha"].ToString();
            }
            return falha;
        }

        [WebMethod]
        public static void ResetAnelEqp(string anel, string idEqp)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"Select isnull(Byte2,0) Byte2 from TarefasImposicao Where IdControlador='" + idEqp + "'");
            if (dt.Rows.Count > 0)
            {
                int[] byte2 = DecimalToBinary(int.Parse(dt.Rows[0]["Byte2"].ToString()));

                if (anel == "1") byte2[0] = 1;
                if (anel == "2") byte2[1] = 1;
                if (anel == "3") byte2[2] = 1;
                if (anel == "4") byte2[3] = 1;

                setByte2(byte2, idEqp);
            }
        }

        [WebMethod]
        public static void ResetEqp(string idEqp)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"Select isnull(Byte1,0) Byte1 from TarefasImposicao Where IdControlador='" + idEqp + "'");
            if (dt.Rows.Count > 0)
            {
                int[] byte1 = DecimalToBinary(int.Parse(dt.Rows[0]["Byte1"].ToString()));
                byte1[0] = 1;
                setByte1(byte1, idEqp);
            }
        }

        public static void setByte1(int[] byte1, string idEqp)
        {
            Banco db = new Banco("");
                        Array.Reverse(byte1);
            string byteTarefas = string.Join("", byte1);
            int decimalValue = Convert.ToInt32(byteTarefas, 2);
            db.ExecuteNonQuery("Update TarefasImposicao set Byte1=" + decimalValue + " Where IdControlador='" + idEqp+"'");
        }

        public static void setByte2(int[] byte2, string idEqp)
        {
            Banco db = new Banco("");
            Array.Reverse(byte2);
            string byteTarefas = string.Join("", byte2);
            int decimalValue = Convert.ToInt32(byteTarefas, 2);
            db.ExecuteNonQuery("Update TarefasImposicao set Byte2=" + decimalValue + " Where IdControlador='" + idEqp+"'");
        }

        public static int[] DecimalToBinary(int number)
        {
            int[] binaryNum = new int[8];

            int i = 0;
            while (number > 0)
            {
                binaryNum[i] = number % 2;
                number = number / 2;
                i++;
            }
            return binaryNum;
        }

        public struct Planos
        {
            public string NomePlano { get; set; }
            public string Tipo { get; set; }
            public bool Imposicao { get; set; }
        }

        [WebMethod]
        public static List<Planos> getPlanos(string idEqp)
        {
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"Select distinct NomePlano,TipoPlano from Planos p Where IdEqp='{0}'
UNION SELECT 'PISCANTE' NomePlano, 'AMARELO INTERMITENTE' TipoPlano UNION SELECT 'APAGADO' NomePlano, 'APAGADO' TipoPlano order by NomePlano", idEqp));

            List<Planos> lst = new List<Planos>();
            foreach (DataRow item in dt.Rows)
            {
                DataTable dtImposicao = db.ExecuteReaderQuery(@"Select id from ImposicaoPlanos Where PlanoImposto='" + item["NomePlano"].ToString() +
                    "' and IdEqp='" + idEqp + "'");

                bool imposicao = dtImposicao.Rows.Count > 0 ? true : false;
                lst.Add(new Planos
                {
                    NomePlano = item["NomePlano"].ToString(),
                    Tipo = item["TipoPlano"].ToString(),
                    Imposicao = imposicao
                });
            }
            return lst;
        }

        [WebMethod]
        public static bool ImporPlano(string plano, string idEqp, string tempo, string tipo)
        {
            bool retorno = false;
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(@"Select Byte1 from TarefasImposicao Where IdControlador='" + idEqp + "'");
            int[] byte1 = DecimalToBinary(int.Parse(dt.Rows[0]["Byte1"].ToString()));

            if (tipo == "cancelamento")
            {
                db.ExecuteNonQuery("Delete from ImposicaoPlanos Where PlanoImposto='" + plano + "' and IdEqp='" + idEqp + "'");
                byte1[1] = 0;
                byte1[2] = 1;
                byte1[7] = 0;

                setByteTarefas(byte1, idEqp);
            }
            else
            {
                DataTable dtImposicao = db.ExecuteReaderQuery(@"Select id from ImposicaoPlanos Where IdEqp='" + idEqp + "'");
                retorno = dtImposicao.Rows.Count > 0 ? true : false;

                if (!retorno)
                {
                    db.ExecuteNonQuery("Insert Into ImposicaoPlanos (PlanoImposto, TempoImposicao, IdEqp) values ('" + plano + "','" + tempo + "','" + idEqp + "')");
                    byte1[1] = 1;
                    byte1[2] = 0;
                    byte1[7] = 0;

                    setByteTarefas(byte1, idEqp);
                }
            }

            return retorno;
        }

        public static void setByteTarefas(int[] byte1, string idEqp)
        {
            Banco db = new Banco("");
            Array.Reverse(byte1);
            string byteTarefas = string.Join("", byte1);
            int decimalValue = Convert.ToInt32(byteTarefas, 2);
            db.ExecuteNonQuery("Update TarefasImposicao set Byte1=" + decimalValue + " Where IdControlador='" + idEqp+"'");
        }
    }
}