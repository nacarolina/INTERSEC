using Infortronics;
using System;
using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace GwCentral.Admin.Users
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
                mpAlert.Y = 150;
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

        protected void grdUsers_SelectedIndexChanged(object sender, EventArgs e)
        {
            mpAlert.Show();
        }
        protected void grdUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            e.Cancel = true;
            Membership.DeleteUser(e.Keys[0].ToString());
            grdUsers.DataBind();

        }

        protected void FormView1_ModeChanging(object sender, FormViewModeEventArgs e)
        {
            mpAlert.Show();
        }

        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            grdUsers.DataBind();
        }
        protected void CreateUserButton_Click(object sender, EventArgs e)
        {
            MembershipCreateStatus s = new MembershipCreateStatus();
            //  string str=crypt(txtPassWebTrans.Text);
            Banco db = new Banco("");
            string prefeitura = db.ExecuteScalarQuery("select prefeitura from prefeitura where id=" + HttpContext.Current.Profile["idPrefeitura"]);
            //db.ClearSQLParams();
            //db.AddSQLParam("Login", txtUserWebTrans.Text);
            //db.AddSQLParam("Password", str);
            //if (db.ExecuteScalarStoredProcedureWeb("CHECK_USER", true).ToString() == "false")
            //{
            //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('Usuário WebTrans inválido')", true);
            //    ModalPopupExtender1.Show();
            //    txtUserWebTrans.Focus();
            //    return;
            //}

            Membership.CreateUser(txtUserName.Text, txtPassword.Text, txtEmail.Text, txtPasswordQuestion.Text, txtPasswordAnswer.Text, true, out s);

            try
            {
                Roles.AddUserToRole(txtUserName.Text, "cliente: " + prefeitura);
                            
            }
            catch (Exception)
            {

            }
            switch (s)
            {
                case MembershipCreateStatus.DuplicateEmail:
                    txtEmail.Text = "";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + getResource("emailExistente") + "', 'invalido');", true);
                    break;
                case MembershipCreateStatus.DuplicateProviderUserKey:
                    grdUsers.DataBind();
                    Limpa();
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + s.ToString() + "', 'invalido');", true);
                    break;
                case MembershipCreateStatus.DuplicateUserName:
                    txtUserName.Text = "";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + getResource("nomeExistente") + "', 'invalido');", true);
                    break;
                case MembershipCreateStatus.InvalidAnswer:
                    txtPasswordAnswer.Text = "";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + getResource("respostaInvalida") + "', 'invalido');", true);
                    break;
                case MembershipCreateStatus.InvalidEmail:
                    txtEmail.Text = "";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + getResource("emailInvalido") + "', 'invalido');", true);
                    break;
                case MembershipCreateStatus.InvalidPassword:
                    txtPassword.Text = "";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + getResource("senhaInvalida") + "', 'invalido');", true);
                    break;
                case MembershipCreateStatus.InvalidProviderUserKey:
                    grdUsers.DataBind();
                    Limpa();
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + s.ToString() + "', 'invalido');", true);
                    break;
                case MembershipCreateStatus.InvalidQuestion:
                    txtPasswordQuestion.Text = "";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + getResource("questaoInvalida") + "', 'invalido');", true);
                    break;
                case MembershipCreateStatus.InvalidUserName:
                    txtUserName.Text = "";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + getResource("nomeInvalido") + "', 'invalido');", true);
                    break;
                case MembershipCreateStatus.ProviderError:
                    grdUsers.DataBind();
                    Limpa();
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + s.ToString() + "', 'invalido');", true);
                    break;
                case MembershipCreateStatus.Success:
                    ProfileBase profile = ProfileBase.Create(txtUserName.Text);
                    profile.SetPropertyValue("EmpresaUsuario", txtEmpresa.Text);
                    profile.Save();
                    grdUsers.DataBind();
                    Limpa();
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + getResource("salvoComSucesso") + "', 'valido');", true);
                    break;
                case MembershipCreateStatus.UserRejected:
                    txtUserName.Text = "";
                    txtUserName.Focus();
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "AvisoPopupUser", "AvisoPopupUser('" + getResource("usuarioRejeitado") + "', 'invalido');", true);
                    break;
            }
        }


        private string crypt(string str)
        {
            MD5 md5Hasher = MD5.Create();
            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(str));
            StringBuilder sBuilder = new StringBuilder();

            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }

            return sBuilder.ToString();
        }

        private void Limpa()
        {
            txtConfirmPassword.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtEmpresa.Text = string.Empty;
            txtPasswordAnswer.Text = string.Empty;
            txtPasswordQuestion.Text = string.Empty;
            txtPasswordQuestion.Text = string.Empty;
            txtUserName.Text = string.Empty;
        }
        protected void grdRoles_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

            mpAlert.Show();
        }

        protected void btnFind_Click(object sender, EventArgs e)
        {
            dsMembersFilter.DataBind();
        }
    }
}