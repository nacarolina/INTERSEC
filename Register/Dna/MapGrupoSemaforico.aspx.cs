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

namespace GwCentral.Register.Dna
{
    public partial class MapGrupoSemaforico : System.Web.UI.Page
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
                hdfId.Value = !string.IsNullOrEmpty(Request.QueryString["id"]) ? Request.QueryString["id"] : "";
                hdfIdEqp.Value = !string.IsNullOrEmpty(Request.QueryString["idEqp"]) ? Request.QueryString["idEqp"] : "";
                hdfLocal.Value = !string.IsNullOrEmpty(Request.QueryString["local"]) ? Request.QueryString["local"] : "";
                hdfIdDna.Value = !string.IsNullOrEmpty(Request.QueryString["idDna"]) ? Request.QueryString["idDna"] : "";
                hdfTypeMarker.Value = !string.IsNullOrEmpty(Request.QueryString["typeMarker"]) ? Request.QueryString["typeMarker"] : "";
                txtCruzamento.Text = !string.IsNullOrEmpty(Request.QueryString["cruzamento"]) ? Request.QueryString["cruzamento"] : "";
                hdfLat.Value = !string.IsNullOrEmpty(Request.QueryString["lat"]) ? Request.QueryString["lat"] : "";
                hdfLng.Value = !string.IsNullOrEmpty(Request.QueryString["lng"]) ? Request.QueryString["lng"] : "";

                if (!string.IsNullOrEmpty(Request.QueryString["tipo"]))
                {
                    if (Request.QueryString["tipo"] == "novo")
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "loadResourcesLocales", "loadResourcesLocales();", true);
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "novoLocal", "novoLocal();", true);
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "loadResourcesLocales", "loadResourcesLocales();", true);
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Detalhes", string.Format("Detalhes('{0}','{1}');",
                      txtCruzamento.Text, hdfId.Value), true);
                    }
                }
                //                DataTable dt = db.ExecuteReaderQuery(string.Format(@"select top 1 cm.latitude,cm.longitude,cm.zoom,cm.TempoAtualizaMapa,d.HabilitacaoCentral
                //from  ConfigMap cm
                //left join  Dna d
                //on cm.idPrefeitura = d.idPrefeitura
                //and d.HabilitacaoCentral = 1
                //where cm.idPrefeitura = {0}", HttpContext.Current.Profile["idPrefeitura"]));

                //                if (dt.Rows.Count > 0)
                //                {
                //                    DataRow dr = dt.Rows[0];
                //                    Page.ClientScript.RegisterStartupScript(this.GetType(),
                //    "LoadMap", "LoadMap('" + dr["latitude"].ToString() + "','" + dr["longitude"].ToString() + "','" + dr["zoom"].ToString() + "','" + dr["TempoAtualizaMapa"].ToString() + "');", true);

                //                }
                //                else
                //                {
                //                    Page.ClientScript.RegisterStartupScript(this.GetType(),
                //                    "LoadMap", "LoadMap('','','','');", true);
                //                }
            }
        }

        [WebMethod]
        public static ArrayList loadModeloGrupos()
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery("select * from ModeloGrupoSemaforico ");
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["Modelo"].ToString(), dr["Id"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public static string SalvarGrupo(string grupo, string tipo, string modelo, string anel, string idEqp, string idLocal, string tipoMarcador, string operacao)
        {
            Banco db = new Banco("");

            if (operacao == "salvar")
            {
                string existe = db.ExecuteScalarQuery("select grupoLogico from GruposLogicos where GrupoLogico='" + grupo + "' and idEqp='" + idEqp + "'");
                if (existe != "")
                {
                    return "Erro";
                }
                else
                {
                    db.ExecuteNonQuery(@"insert into GruposLogicos (GrupoLogico,IdProgramacao,Anel,TipoGrupo,IdEqp,IdLocal,tipoMarcador,idModeloGrupoSemaforico,idPrefeitura)
values('" + grupo + "', '', '" + anel + "', '" + tipo + "', '" + idEqp + "', '" + idLocal + "', '" + tipoMarcador + "'," + modelo + ",'"+ HttpContext.Current.Profile["idPrefeitura"] + "')");
                }
            }
            else
            {
                db.ExecuteNonQuery("update GruposLogicos set TipoGrupo='"+tipo+"',idModeloGrupoSemaforico="+modelo+" where grupoLogico='" + grupo + "' and idEqp='" + idEqp + "'");
            }
            return "SUCESSO";
        }
    }
}