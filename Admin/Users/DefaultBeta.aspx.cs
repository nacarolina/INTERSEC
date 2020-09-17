using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using static GwCentral.Admin.Users.PermissoesUsers;

namespace GwCentral.Admin.Users
{
    public partial class DefaultBeta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfusuarioLogado.Value = User.Identity.Name;
            }
        }

        public struct ListUsuarios
        {
            public string usuarios { get; set; }
            public string email { get; set; }
        }
        [WebMethod]
        public static List<ListUsuarios> carregarUsuarios(string prefeitura)
        {
            Banco dbStatic = new Banco("");

            string sql = "";
            if (prefeitura == "")
            {
                sql = "select distinct userName, LoweredUserName email from aspnet_Users u";
            }
            else
            {
                sql = "select distinct userName, LoweredUserName email from aspnet_Users u join  aspnet_UsersInRoles ur on ur.UserId=u.UserId " +
                    " join aspnet_Roles r on r.RoleId=ur.RoleId where r.RoleId=ur.RoleId and RoleName like '%" + prefeitura + "%' ";
            }

            DataTable dt = dbStatic.ExecuteReaderQuery(sql);

            List<ListUsuarios> ListUsuarios = new List<ListUsuarios>();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow item in dt.Rows)
                {
                    ProfileBase profile = ProfileBase.Create(item["UserName"].ToString(), true);
                    ListUsuarios.Add(new ListUsuarios
                    {
                        usuarios = item["UserName"].ToString(),
                        email = item["email"].ToString(),
                    });
                }
            }

            return ListUsuarios;
        }

        public struct ListPrefeitura
        {
            public string id { get; set; }
            public string prefeitura { get; set; }
        }

        [WebMethod]
        public static List<ListPrefeitura> carregarPrefeitura()
        {
            Banco db = new Banco("");

            List<ListPrefeitura> lst = new List<ListPrefeitura>();

            DataTable dt = db.ExecuteReaderQuery("select id, Prefeitura from Prefeitura");

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new ListPrefeitura
                {
                    id = item["id"].ToString(),
                    prefeitura = item["Prefeitura"].ToString(),
                });
            }

            return lst;
        }

        #region ALTERAÇÃO IDIOMA
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
        #endregion

        [WebMethod]
        public static string salvarUsuario(string nomeUsuario, string nomeEmpresa, string email, string senha, string confimarSenha, string perguntaSecreta, string confirmarPerguntaSecreta, string prefeituraCad)
        {
            MembershipCreateStatus s = new MembershipCreateStatus();

            string idPrefeitura = "";
            Banco db = new Banco("");
            Membership.CreateUser(nomeUsuario, senha, email, perguntaSecreta, confirmarPerguntaSecreta, true, out s);

            try
            {
                idPrefeitura = db.ExecuteScalarQuery("select id from Prefeitura where Prefeitura='" + prefeituraCad+"'");
                Roles.AddUserToRole(nomeUsuario, "cliente: " + prefeituraCad);

            }
            catch (Exception)
            {

            }
            switch (s)
            {
                case MembershipCreateStatus.InvalidUserName:
                    return getResource("nomeInvalido");
                    break;

                case MembershipCreateStatus.DuplicateEmail:
                    return getResource("emailExistente"); //VALIDA E-MAIL EXISTENTE
                    break;

                case MembershipCreateStatus.DuplicateProviderUserKey:
                    return s.ToString();
                    break;

                case MembershipCreateStatus.DuplicateUserName:
                    return getResource("nomeExistente"); //VALIDA NOME
                    break;

                case MembershipCreateStatus.InvalidAnswer:
                    return getResource("respostaInvalida"); //VALIDA RESPOSTA PERGUNTA
                    break;

                case MembershipCreateStatus.InvalidEmail:
                    return getResource("emailInvalido"); //VALIDA E-MAIL
                    break;

                case MembershipCreateStatus.InvalidPassword:
                    return getResource("senhaInvalida");
                    break;

                case MembershipCreateStatus.InvalidProviderUserKey:
                    return s.ToString();
                    break;

                case MembershipCreateStatus.InvalidQuestion:
                    return getResource("questaoInvalida"); //RESPOSTA INVALIDA
                    break;


                case MembershipCreateStatus.ProviderError:
                    return s.ToString();
                    break;

                case MembershipCreateStatus.Success:
                    ProfileBase profile = ProfileBase.Create(nomeUsuario);
                    profile.SetPropertyValue("EmpresaUsuario", nomeEmpresa);
                    profile.SetPropertyValue("idPrefeitura", idPrefeitura);
                    profile.Save();
                    return "sucesso";
                    break;

                case MembershipCreateStatus.UserRejected:
                    return getResource("usuarioRejeitado");
                    break;
            }

            return "sucesso";
        }

        [WebMethod]
        public static void excluirUsuario(string usuario)
        {
            Membership.DeleteUser(usuario);
        }

        [WebMethod]
        public static void editarSenhaUsuario(string usuarioLogado, string usuario, string novaSenha)
        {
            MembershipUser mu = Membership.GetUser(usuario);
            if (mu.IsLockedOut)
                mu.UnlockUser();
            //string s = mu.GetPassword("Gabriel");s
            Banco db = new Banco("");
            db.ExecuteNonQuery("insert into LogsSistema (idPrefeitura,DtHr,[user],[Log],Dsc,tela) values (" + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now + "','" + usuarioLogado + "','','Alterou a senha para=" + novaSenha + " do usuario:" + usuario + "','Alterar senha do Usuario')");

            mu.ChangePassword(mu.ResetPassword(), novaSenha);
            //clsLog.GravaLog("U", "Usuario", "Senha", User.Identity.Name, "", "");
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('" + getResource("salvoComSucesso") + "');", true);
        }
    }
}