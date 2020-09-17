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

namespace GwCentral.Relatorios
{
    public partial class ImprimirLacosComFalha : System.Web.UI.Page
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpContext.Current.Profile["idioma"] = idioma;
                lblDtHr.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
                hfIdPrefeitura.Value = HttpContext.Current.Profile["idPrefeitura"].ToString();
            }
        }
        [WebMethod]
        public static List<Falha> getFalhas()
        {
            List<Falha> lst = new List<Falha>();

            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery("select Falha,IdEqp,DataHora from LogsControlador where FalhaSolucionada='N' and Hardware='LACO' and tipo='FALHA'");
            foreach (DataRow dr in dt.Rows)
            {
                string ano = dr["DataHora"].ToString().Substring(0, 4);
                string mes = dr["DataHora"].ToString().Substring(4, 2);
                string dia = dr["DataHora"].ToString().Substring(6, 2);
                string hr = dr["DataHora"].ToString().Substring(8, 2);
                string min = dr["DataHora"].ToString().Substring(10, 2);
                string seg = dr["DataHora"].ToString().Substring(12, 2);
                lst.Add(new Falha
                {
                    Dsc = dr["Falha"].ToString(),
                    DtHr = dia + '/' + mes + '/' + ano + ' ' + hr + ':' + min + ':' + seg,
                    idEqp = dr["IdEqp"].ToString()
                });
            }
            return lst;
        }
        public struct Falha
        {
            public string Dsc { get; set; }
            public string idEqp { get; set; }
            public string DtHr { get; set; }
        }
    }
}