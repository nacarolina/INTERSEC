using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Infortronics;
using System.Data;
using System.Web.Security;
using System.IO;
using System.Web.Services;
using System.Globalization;
using System.Threading;
using System.Xml;

namespace GwCentral.Register.CityHall
{
    public partial class register : System.Web.UI.Page
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
            if (IsPostBack == false)
            {
                string Id = "";

                Id = Request.QueryString["Id"];// retorna o valor da linha selecionada
                ViewState["Id"] = Id;// viewstate é tipo de variavel
                DataTable dt;
                
                if (Id == null || Id == "new")
                {
                    txtPrefeitura.Enabled = true;
                    txtEndereco.Enabled = true;
                    txtTelefone.Enabled = true;
                    txtEmail.Enabled = true;
                    txtSite.Enabled = true;
                    btnSalvarAlteracao.Visible = false;
                    btnBack.Visible = false;
                    CreateUserButton.Visible = true;
                    pnlLoginResponsavel.Visible = true;
                }
                else
                {
                    dt = db.ExecuteReaderQuery("Select * from Prefeitura where Id=" + Id);
                    DataRow dr = dt.Rows[0];
                    txtPrefeitura.Text = dr["Prefeitura"].ToString();
                    txtEndereco.Text = dr["Endereco"].ToString();
                    txtTelefone.Text = dr["Telefone"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtSite.Text = dr["Site"].ToString();
                    txtPortaReset.Text = dr["PortaReset"].ToString();

                    if (!string.IsNullOrEmpty(dr["idClienteSicappSemaforo"].ToString()) && dr["idClienteSicappSemaforo"].ToString() != "0")
                        hfIdCliente.Value = dr["idClienteSicappSemaforo"].ToString();
                    else
                        hfIdCliente.Value = "";

                    txtPrefeitura.Enabled = true;
                    txtEndereco.Enabled = true;
                    txtTelefone.Enabled = true;
                    txtEmail.Enabled = true;
                    txtSite.Enabled = true;
                    btnSalvarAlteracao.Enabled = true;

                    btnSalvarAlteracao.Visible = true;
                    btnBack.Visible = true;
                    CreateUserButton.Visible = false;
                    pnlLoginResponsavel.Visible = false;

                }

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

        protected void btnVoltar_Click(object sender, EventArgs e)
        {
            Response.Redirect("../CityHall/Default.aspx");
        }

        public struct PrefeituraList {
            public string Nome { get; set; }
            public string Id { get; set; }
        }

        [WebMethod]
        public static List<PrefeituraList> GetClients(string prefixText) 
        {
            Banco db = new Banco("");
            DataTable dt;
            List<PrefeituraList> lst = new List<PrefeituraList>();
            dt = db.ExecuteReaderQuery(@"USE [Sicapp] select Id,Prefeitura from Prefeitura where Prefeitura like '%" + prefixText + "%'");
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new PrefeituraList
                {
                    Nome = item["Prefeitura"].ToString(),
                    Id = item["Id"].ToString()
                });
            }
            return lst;
        }

        [WebMethod]
        public static string GetClientsSemaforoSicapp(string idCliente) 
        {
            Banco db = new Banco("");
            string Cliente = db.ExecuteScalarQuery("USE [Sicapp] select Prefeitura from Prefeitura where Id=" + idCliente);

            return Cliente;
        }

        protected void CreateUserButton_Click(object sender, EventArgs e)
        {
            MembershipCreateStatus s = new MembershipCreateStatus();
            Banco db = new Banco("");
            string sql = "";
            string filename = "";
            if (FileUpload1.HasFile)
            {
                try
                {
                    if (FileUpload1.PostedFile.ContentType == "image/jpeg" || FileUpload1.PostedFile.ContentType == "image/jpg" || FileUpload1.PostedFile.ContentType == "image/png")
                    {
                        filename = Path.GetFileName(FileUpload1.FileName);

                    }
                    else
					{
						Response.Write("<script>alert('" + getResource("arquivoNaoPermitido") + "')</script>");
						//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("arquivoNaoPermitido") + "');", true);
						return;
                    }
                }
                catch
                {
                }
            }
            if (txtPrefeitura.Text == "")
            {
				txtPrefeitura.Focus();
				Response.Write("<script>alert('" + getResource("cliente") + " - " + getResource("campoObrigatorio") + "')</script>");
				//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("cliente") + " - " + getResource("campoObrigatorio") + "');", true);
				return;
            }

            if (txtEndereco.Text == "")
            {
				txtEndereco.Focus();

				Response.Write("<script>alert('" + getResource("endereco") + " - " + getResource("campoObrigatorio") + "')</script>");
				//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert(" + getResource("endereco") + " - " + getResource("campoObrigatorio") + "');", true);
				return;
            }


            if (txtEmail.Text == "")
            {
				txtEmail.Focus();
				Response.Write("<script>alert('Email - " + getResource("campoObrigatorio") + "')</script>");
				//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert(email - " + getResource("campoObrigatorio") + ");", true);
                return;
            }

            Membership.CreateUser(txtUserName.Text, txtPassword.Text, txtEmail.Text, txtPasswordQuestion.Text, txtPasswordAnswer.Text, true, out s);

            switch (s)
            {
                case MembershipCreateStatus.DuplicateEmail:
					Response.Write("<script>alert('" + getResource("emailExistente") + "')</script>");
					//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("emailExistente") + "');", true);
                    txtEmail.Text = "";
                    txtEmail.Focus();
                    return;
                    break;
                case MembershipCreateStatus.DuplicateProviderUserKey:
					Response.Write("<script>alert('" + s.ToString() + "')</script>");
					//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + s.ToString() + "');", true);
                    return;
                    break;
                case MembershipCreateStatus.DuplicateUserName:
					Response.Write("<script>alert('" + getResource("nomeExistente") + "')</script>");
					//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("nomeExistente") + "');", true);
                    txtUserName.Text = ""; 
                    txtUserName.Focus();
                    return;
                    break;
                case MembershipCreateStatus.InvalidAnswer:
					Response.Write("<script>alert('" + getResource("respostaInvalida") + "')</script>");
					//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("respostaInvalida") + "');", true);
                    txtPasswordAnswer.Text = "";
                    txtPasswordAnswer.Focus();
                    return;
                    break;
                case MembershipCreateStatus.InvalidEmail:
					Response.Write("<script>alert('" + getResource("emailInvalido") + "')</script>");
					//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("emailInvalido") + "');", true);
                    txtEmail.Text = "";
                    txtEmail.Focus();
                    return;
                    break;
                case MembershipCreateStatus.InvalidPassword:
					Response.Write("<script>alert('" + getResource("senhaInvalida") + "')</script>");
					//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("senhaInvalida") + "');", true);
                    txtPassword.Text = "";
                    txtPassword.Focus();
                    return;
                    break;
                case MembershipCreateStatus.InvalidProviderUserKey:
					Response.Write("<script>alert('" + s.ToString() + "')</script>");
					//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + s.ToString() + "');", true);
                    return;
                    break;
                case MembershipCreateStatus.InvalidQuestion:
					Response.Write("<script>alert('" + getResource("questaoInvalida") + "')</script>");
					//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("questaoInvalida") + "');", true);
                    txtPasswordQuestion.Text = "";
                    txtPasswordQuestion.Focus();
                    return;
                    break;
                case MembershipCreateStatus.InvalidUserName:
					Response.Write("<script>alert('" + getResource("nomeInvalido") + "')</script>");
					//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("nomeInvalido") + "');", true);
                    txtUserName.Text = "";
                    txtUserName.Focus();
                    return;
                    break;
                case MembershipCreateStatus.ProviderError:
					Response.Write("<script>alert('" + s.ToString() + "')</script>");
					//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + s.ToString() + "');", true);
                    return;
                    break;
                case MembershipCreateStatus.Success:
					//    clsLog.GravaLog("I", "aspnet_Users", "User", User.Identity.Name, "", txtUserName.Text);
					Roles.AddUserToRole(txtUserName.Text, "central_user");
					Roles.AddUserToRole(txtUserName.Text, "central_mapa");
                    Roles.AddUserToRole(txtUserName.Text, "central_cadastro");
                    Roles.AddUserToRole(txtUserName.Text, "central_prefeitura");
                    Roles.AddUserToRole(txtUserName.Text, "central_HorarioVerao");
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("salvoComSucesso") + "');", true);
                    break;
                case MembershipCreateStatus.UserRejected:
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("usuarioRejeitado") + "');", true);
                    txtUserName.Text = "";
                    txtUserName.Focus();
                    return;
                    break;
            }

            if (FileUpload1.HasFile)
            {
                try
                {
                    if (FileUpload1.PostedFile.ContentType == "image/jpeg" || FileUpload1.PostedFile.ContentType == "image/jpg" || FileUpload1.PostedFile.ContentType == "image/png")
                    {

                        String path = Server.MapPath("~\\Images\\");
                        filename = DateTime.Now.Millisecond.ToString()	+ filename;
                        FileUpload1.SaveAs(path + filename);

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("arquivoNaoPermitido") + "');", true);
                        return;
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + ex.ToString() + "');", true);
                }
            }
            sql = "Insert into Prefeitura (Prefeitura,Endereco,Telefone,Email,Site,Responsavel,Usuario,DtHr,logoCaminho,idClienteSicappSemaforo,PortaReset) Values ('" + txtPrefeitura.Text + "','" + txtEndereco.Text + "','" + txtTelefone.Text + "','" + txtEmail.Text + "','" + txtSite.Text + "','" + txtUserName.Text + "','" + User.Identity.Name + "','" + DateTime.Now + "','~/Images/" + filename + "','" + hfIdCliente.Value + "','" + txtPortaReset.Text + "')";
            db.ExecuteNonQuery(sql);



            if (!Roles.RoleExists("cliente: " + txtPrefeitura.Text))
                Roles.CreateRole("cliente: " + txtPrefeitura.Text);

            Roles.AddUsersToRole(new string[] { txtUserName.Text }, "cliente: " + txtPrefeitura.Text);

            /* if (!Roles.RoleExists("Cadastro de Departamento"))
                 Roles.CreateRole("Cadastro de Departamento");
             Roles.AddUsersToRole(new string[] { txtUserName.Text }, "Cadastro de Departamento");*/


            if (!Roles.RoleExists("cadastro"))
                Roles.CreateRole("cadastro");

            Roles.AddUsersToRole(new string[] { txtUserName.Text }, "cadastro");

            Response.Redirect("../CityHall/Default.aspx");
        }
        protected void btnSalvarAlteracao_Click(object sender, EventArgs e)
        {
            string sql = "";
            string filename = "";
			if (txtPrefeitura.Text == "")
			{
				txtPrefeitura.Focus();
				Response.Write("<script>alert('" + getResource("cliente") + " - " + getResource("campoObrigatorio") + "')</script>");
				//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("cliente") + " - " + getResource("campoObrigatorio") + "');", true);
				return;
			}

			if (txtEndereco.Text == "")
			{
				txtEndereco.Focus();

				Response.Write("<script>alert('" + getResource("endereco") + " - " + getResource("campoObrigatorio") + "')</script>");
				//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert(" + getResource("endereco") + " - " + getResource("campoObrigatorio") + "');", true);
				return;
			}


			if (txtEmail.Text == "")
			{
				txtEmail.Focus();
				Response.Write("<script>alert('Email - " + getResource("campoObrigatorio") + "')</script>");
				//ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert(email - " + getResource("campoObrigatorio") + ");", true);
				return;
			}
			if (FileUpload1.HasFile)
            {
                try
                {
                    if (FileUpload1.PostedFile.ContentType == "image/jpeg" || FileUpload1.PostedFile.ContentType == "image/jpg" || FileUpload1.PostedFile.ContentType == "image/png")
                    {
                        filename = Path.GetFileName(FileUpload1.FileName);

                        String path = Server.MapPath("~\\Images\\");
                        filename = DateTime.Now.Millisecond.ToString() + filename;
                        FileUpload1.SaveAs(path + filename);

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("arquivoNaoPermitido") + "'!')", true);
                        return;
                    }
                }
                catch
                {
                }
            }
            sql = @"Update Prefeitura set Prefeitura  ='" + txtPrefeitura.Text + "',Endereco='" + txtEndereco.Text + "',Telefone='" + txtTelefone.Text + 
                "',Email='" + txtEmail.Text + "',Site='" + txtSite.Text + "',Usuario='" + User.Identity.Name +
                "',DtHr='" + DateTime.Now + "',logoCaminho='~/Images/" + filename + "',idClienteSicappSemaforo='" + hfIdCliente.Value + "', PortaReset='" + txtPortaReset.Text + 
                "' where Id=" + ViewState["Id"].ToString();
            db.ExecuteReaderQuery(sql);
            Response.Redirect("../CityHall/Default.aspx");
        }
    }
}