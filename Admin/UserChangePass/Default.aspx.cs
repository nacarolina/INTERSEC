using Infortronics;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace GwCentral.Admin.UserChangePass
{
    public partial class Default : System.Web.UI.Page
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
                string usuario = Request.QueryString["user"];
                if (!string.IsNullOrEmpty(usuario))
                {
                    txtUser.Text = usuario;
                }
                else
                {
                    txtUser.Text = User.Identity.Name;
                }
                //MembershipUserCollection m_usercollec = Membership.GetAllUsers();
                //foreach (MembershipUser user in m_usercollec)
                //{
                //    if (Roles.IsUserInRole(Convert.ToString(user),"cliente: "+Profile.Prefeitura.Nome))
                //    {

                //        txtUser.Items.Add(user.UserName);
                //    }
                //}
            }
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

        protected void ddlUser_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void btnSalvar_Click1(object sender, EventArgs e)
        {
            //bool b = MembershipUser;
            MembershipUser mu = Membership.GetUser(txtUser.Text);
            if (mu.IsLockedOut)
                mu.UnlockUser();
            //string s = mu.GetPassword("Gabriel");s
            Banco db = new Banco("");
            db.ExecuteNonQuery("insert into LogsSistema (idPrefeitura,DtHr,[user],[Log],Dsc,tela) values (" + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now + "','" + User.Identity.Name + "','','Alterou a senha para=" + txtNovaSenha.Text + " do usuario:" + txtUser.Text + "','Alterar senha do Usuario')");

            mu.ChangePassword(mu.ResetPassword(), txtNovaSenha.Text);
            //clsLog.GravaLog("U", "Usuario", "Senha", User.Identity.Name, "", "");
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("salvoComSucesso") + "');", true);
        }
    }
}