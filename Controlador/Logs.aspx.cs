using Infortronics;
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

namespace GwCentral
{
    public partial class Logs : System.Web.UI.Page
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
                hfIdEqp.Value = Request.QueryString["idEqp"];
            }
        }

        [WebMethod]
        public static List<Log> GetLogs(bool operacao, bool restabelecimento, bool bFalha, string dtIni, string dtFim, string idEqp, string tipoData)
        {
            ArrayList list = new ArrayList();
            if (operacao)
                list.Add("'operacao'");
            if (restabelecimento)
                list.Add("'restabelecimento'");
            if (bFalha)
                list.Add("'falha'");

            Banco db = new Banco("");

            string valor, falha, usuario = "";
            List<Log> lst = new List<Log>();
            string sql = "select Funcao,Valor,Falha,Usuario,DataHora from logsControlador where idEqp='" + idEqp + "' and tipo in (" + string.Join(",", list.ToArray()) + ")";
            if (tipoData == "Mensal")
            {
                sql += " and substring(DataHora, 0, 7)='" + dtIni + "'";
            }
            else if (tipoData == "Periodo")
            {
                sql += string.Format(" and convert(datetime, substring(DataHora,0,9),103) >= Convert(datetime,'{0}',103) AND convert(datetime, substring(DataHora,0,9),103) <= Convert(datetime,'{1}',103)", dtIni, dtFim);
            }
            else
            {
                sql += " and substring(DataHora, 0, 9)='" + dtIni.Replace("/", "") + "'";
            }

            sql += " order by dataHora desc";
            DataTable dt = db.ExecuteReaderQuery(sql);
            foreach (DataRow dr in dt.Rows)
            {
                string ano = dr["DataHora"].ToString().Substring(0, 4);
                string mes = dr["DataHora"].ToString().Substring(4, 2);
                string dia = dr["DataHora"].ToString().Substring(6, 2);
                string hr = dr["DataHora"].ToString().Substring(8, 2);
                string min = dr["DataHora"].ToString().Substring(10, 2);
                string seg = dr["DataHora"].ToString().Substring(12, 2);
                usuario = dr["Usuario"].ToString();
                if (usuario == "null")
                    usuario = "";
                valor = dr["Valor"].ToString();
                if (valor == "null")
                    valor = "";
                falha = dr["Falha"].ToString();
                if (falha == "null")
                    falha = "";
                lst.Add(new Log
                {
                    Usuario = usuario,
                    Falha = falha,
                    Funcao = dr["Funcao"].ToString(),
                    DtHr = dia + "/" + mes + "/" + ano + " " + hr + ":" + min + ":" + seg,
                    origem = "ctrl"
                });
            }
            return lst;
        }
        public struct Log
        {
            public string origem { get; set; }
            public string Usuario { get; set; }
            public string DtHr { get; set; }
            public string Valor { get; set; }
            public string Funcao { get; set; }
            public string Falha { get; set; }
        }
    }
}