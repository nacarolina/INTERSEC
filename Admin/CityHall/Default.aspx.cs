using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Infortronics;
using System.Globalization;
using System.Threading;
using System.Web.Services;

namespace GwCentral.Register.CityHall
{
    public partial class Default : System.Web.UI.Page
    {
        Banco db = new Banco("");

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
                DataTable dt = db.ExecuteReaderQuery("SELECT * FROM Prefeitura");
                if (dt.Rows.Count > 0)
                {
                    ViewState["dt"] = dt;
                    GridDetalhe.DataSource = ((DataTable)ViewState["dt"]);
                    GridDetalhe.DataBind();

                    lblRegistro.Visible = false;
                }
                else
                {
                    lblRegistro.Visible = true;
                }

                btnCadastrarNovo.Visible = true;
                Panel1.Visible = true;
            }


        }
        protected void btnCadastrarNovo_Click(object sender, EventArgs e)
        {
            Response.Redirect("../CityHall/register.aspx?Id=new");
        }

        protected void GridDetalhe_RowDataBound(object sender, GridViewRowEventArgs e)
        {// Creating hover effects on mouseover event for each row
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.background='#D1DDF1';";
                if ((e.Row.RowIndex % 2) == 0)
                    // if even row      
                    e.Row.Attributes["onmouseout"] = "this.style.background='#EFF3FB';";
                else
                    // alternate row      
                    e.Row.Attributes["onmouseout"] = "this.style.background='White';";

            }
        }
        protected void GridDetalhe_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void GridDetalhe_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridDetalhe.PageIndex = e.NewPageIndex;
            GridDetalhe.DataSource = (DataTable)ViewState["dt"];
            GridDetalhe.DataBind();

        }

        protected void btnFind_Click(object sender, EventArgs e)
        {
            string sql = ("Select * from Prefeitura where Prefeitura like'%" + txtPrefeitura.Text + "%'");
            DataTable dt = db.ExecuteReaderQuery(sql);
            GridDetalhe.DataSource = dt;
            GridDetalhe.DataBind();
        }
    }

}
