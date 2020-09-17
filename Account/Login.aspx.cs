using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GwCentral.Account
{
    public partial class Login : Page
    {
        public static string idioma = "pt-BR";
        public static CultureInfo cultureInfo;
        protected override void InitializeCulture()
        {
            idioma = Request.UserLanguages != null ? Request.UserLanguages[0] : "pt-BR";
            cultureInfo = new CultureInfo(idioma);
            HttpContext.Current.Profile["idioma"] = idioma;
            Thread.CurrentThread.CurrentCulture = cultureInfo;
            Thread.CurrentThread.CurrentUICulture = cultureInfo;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.Name != "")
            {
                Response.Redirect("..//Default.aspx");
            }

            //RegisterHyperLink.NavigateUrl = "Register.aspx";
            //OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];

            //var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            //if (!String.IsNullOrEmpty(returnUrl))
            //{
            //    RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            //}
        }

        protected void Login1_LoggedIn(object sender, EventArgs e)
        {

        }

        protected void Login1_LoginError(object sender, EventArgs e)
        {
            
        }

        protected void Login1_LoginError1(object sender, EventArgs e)
        {
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                try
                {
                   Login1.FindControl("pnlErro").Visible = true;
                }
                catch (Exception ex) { }
             
            }
          
        }
    }
}