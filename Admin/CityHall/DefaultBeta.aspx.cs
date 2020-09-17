using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GwCentral.Admin.CityHall
{
    public partial class DefaultBeta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public struct ListClientes
        {
            public string id { get; set; }
            public string cliente { get; set; }
            public string endereco { get; set; }
            public string site { get; set; }
            public string telefone { get; set; }
            public string email { get; set; }
            public string responsavel { get; set; }
            public string portaReset { get; set; }
        }

        [WebMethod]
        public static List<ListClientes> carregarClientes()
        {
            Banco db = new Banco("");

            List<ListClientes> lst = new List<ListClientes>();

            DataTable dt = db.ExecuteReaderQuery("Select id, Prefeitura, Endereco, Site, Telefone, Email, Responsavel, PortaReset from Prefeitura");

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new ListClientes
                {
                    id = item["id"].ToString(),
                    cliente = item["Prefeitura"].ToString(),
                    endereco = item["Endereco"].ToString(),
                    site = item["Site"].ToString(),
                    telefone = item["Telefone"].ToString(),
                    email = item["Email"].ToString(),
                    responsavel = item["Responsavel"].ToString(),
                    portaReset = item["PortaReset"].ToString(),
                });
            }

            return lst;
        }

        public static string salvarNovoCliente(string a, string b)
        {
            MembershipCreateStatus s = new MembershipCreateStatus();
            Banco db = new Banco("");
            string sql = "";
            string filename = "";

            #region VALIDAÇÕES
            //if (FileUpload1.HasFile)
            //{
            //    try
            //    {
            //        if (FileUpload1.PostedFile.ContentType == "image/jpeg" || FileUpload1.PostedFile.ContentType == "image/jpg" || FileUpload1.PostedFile.ContentType == "image/png")
            //        {
            //            filename = Path.GetFileName(FileUpload1.FileName);

            //        }
            //        else
            //        {
            //            Response.Write("<script>alert('" + getResource("arquivoNaoPermitido") + "')</script>");
            //            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("arquivoNaoPermitido") + "');", true);
            //            return;
            //        }
            //    }
            //    catch
            //    {
            //    }
            //}
            //if (txtPrefeitura.Text == "")
            //{
            //    txtPrefeitura.Focus();
            //    Response.Write("<script>alert('" + getResource("cliente") + " - " + getResource("campoObrigatorio") + "')</script>");
            //    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("cliente") + " - " + getResource("campoObrigatorio") + "');", true);
            //    return;
            //}

            //if (txtEndereco.Text == "")
            //{
            //    txtEndereco.Focus();

            //    Response.Write("<script>alert('" + getResource("endereco") + " - " + getResource("campoObrigatorio") + "')</script>");
            //    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert(" + getResource("endereco") + " - " + getResource("campoObrigatorio") + "');", true);
            //    return;
            //}


            //if (txtEmail.Text == "")
            //{
            //    txtEmail.Focus();
            //    Response.Write("<script>alert('Email - " + getResource("campoObrigatorio") + "')</script>");
            //    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert(email - " + getResource("campoObrigatorio") + ");", true);
            //    return;
            //}
            #endregion

            //Membership.CreateUser(txtUserName.Text, txtPassword.Text, txtEmail.Text, txtPasswordQuestion.Text, txtPasswordAnswer.Text, true, out s);

            //switch (s)
            //{
            //    case MembershipCreateStatus.DuplicateEmail:
            //        Response.Write("<script>alert('" + getResource("emailExistente") + "')</script>");
            //        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("emailExistente") + "');", true);
            //        txtEmail.Text = "";
            //        txtEmail.Focus();
            //        return;
            //        break;
            //    case MembershipCreateStatus.DuplicateProviderUserKey:
            //        Response.Write("<script>alert('" + s.ToString() + "')</script>");
            //        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + s.ToString() + "');", true);
            //        return;
            //        break;
            //    case MembershipCreateStatus.DuplicateUserName:
            //        Response.Write("<script>alert('" + getResource("nomeExistente") + "')</script>");
            //        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("nomeExistente") + "');", true);
            //        txtUserName.Text = "";
            //        txtUserName.Focus();
            //        return;
            //        break;
            //    case MembershipCreateStatus.InvalidAnswer:
            //        Response.Write("<script>alert('" + getResource("respostaInvalida") + "')</script>");
            //        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("respostaInvalida") + "');", true);
            //        txtPasswordAnswer.Text = "";
            //        txtPasswordAnswer.Focus();
            //        return;
            //        break;
            //    case MembershipCreateStatus.InvalidEmail:
            //        Response.Write("<script>alert('" + getResource("emailInvalido") + "')</script>");
            //        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("emailInvalido") + "');", true);
            //        txtEmail.Text = "";
            //        txtEmail.Focus();
            //        return;
            //        break;
            //    case MembershipCreateStatus.InvalidPassword:
            //        Response.Write("<script>alert('" + getResource("senhaInvalida") + "')</script>");
            //        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("senhaInvalida") + "');", true);
            //        txtPassword.Text = "";
            //        txtPassword.Focus();
            //        return;
            //        break;
            //    case MembershipCreateStatus.InvalidProviderUserKey:
            //        Response.Write("<script>alert('" + s.ToString() + "')</script>");
            //        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + s.ToString() + "');", true);
            //        return;
            //        break;
            //    case MembershipCreateStatus.InvalidQuestion:
            //        Response.Write("<script>alert('" + getResource("questaoInvalida") + "')</script>");
            //        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("questaoInvalida") + "');", true);
            //        txtPasswordQuestion.Text = "";
            //        txtPasswordQuestion.Focus();
            //        return;
            //        break;
            //    case MembershipCreateStatus.InvalidUserName:
            //        Response.Write("<script>alert('" + getResource("nomeInvalido") + "')</script>");
            //        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("nomeInvalido") + "');", true);
            //        txtUserName.Text = "";
            //        txtUserName.Focus();
            //        return;
            //        break;
            //    case MembershipCreateStatus.ProviderError:
            //        Response.Write("<script>alert('" + s.ToString() + "')</script>");
            //        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + s.ToString() + "');", true);
            //        return;
            //        break;
            //    case MembershipCreateStatus.Success:
            //        //    clsLog.GravaLog("I", "aspnet_Users", "User", User.Identity.Name, "", txtUserName.Text);
            //        Roles.AddUserToRole(txtUserName.Text, "central_user");
            //        Roles.AddUserToRole(txtUserName.Text, "central_mapa");
            //        Roles.AddUserToRole(txtUserName.Text, "central_cadastro");
            //        Roles.AddUserToRole(txtUserName.Text, "central_prefeitura");
            //        Roles.AddUserToRole(txtUserName.Text, "central_HorarioVerao");
            //        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("salvoComSucesso") + "');", true);
            //        break;
            //    case MembershipCreateStatus.UserRejected:
            //        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("usuarioRejeitado") + "');", true);
            //        txtUserName.Text = "";
            //        txtUserName.Focus();
            //        return;
            //        break;
            //}

            //if (FileUpload1.HasFile)
            //{
            //    try
            //    {
            //        if (FileUpload1.PostedFile.ContentType == "image/jpeg" || FileUpload1.PostedFile.ContentType == "image/jpg" || FileUpload1.PostedFile.ContentType == "image/png")
            //        {

            //            String path = Server.MapPath("~\\Images\\");
            //            filename = DateTime.Now.Millisecond.ToString() + filename;
            //            FileUpload1.SaveAs(path + filename);

            //        }
            //        else
            //        {
            //            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("arquivoNaoPermitido") + "');", true);
            //            return;
            //        }
            //    }
            //    catch (Exception ex)
            //    {
            //        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + ex.ToString() + "');", true);
            //    }
            //}
            //sql = "Insert into Prefeitura (Prefeitura,Endereco,Telefone,Email,Site,Responsavel,Usuario,DtHr,logoCaminho,idClienteSicappSemaforo,PortaReset) Values ('" + txtPrefeitura.Text + "','" + txtEndereco.Text + "','" + txtTelefone.Text + "','" + txtEmail.Text + "','" + txtSite.Text + "','" + txtUserName.Text + "','" + User.Identity.Name + "','" + DateTime.Now + "','~/Images/" + filename + "','" + hfIdCliente.Value + "','" + txtPortaReset.Text + "')";
            //db.ExecuteNonQuery(sql);



            //if (!Roles.RoleExists("cliente: " + txtPrefeitura.Text))
            //    Roles.CreateRole("cliente: " + txtPrefeitura.Text);

            //Roles.AddUsersToRole(new string[] { txtUserName.Text }, "cliente: " + txtPrefeitura.Text);

            ///* if (!Roles.RoleExists("Cadastro de Departamento"))
            //     Roles.CreateRole("Cadastro de Departamento");
            // Roles.AddUsersToRole(new string[] { txtUserName.Text }, "Cadastro de Departamento");*/


            //if (!Roles.RoleExists("cadastro"))
            //    Roles.CreateRole("cadastro");

            //Roles.AddUsersToRole(new string[] { txtUserName.Text }, "cadastro");

            //Response.Redirect("../CityHall/Default.aspx");

            return "";
        }
    }
}