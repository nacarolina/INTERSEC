using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
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
    public partial class PermissoesUsers : System.Web.UI.Page
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
                hfIdPrefeitura.Value = HttpContext.Current.Profile["idPrefeitura"].ToString();
                ViewState["IdPrefeitura"] = HttpContext.Current.Profile["idPrefeitura"].ToString();
                Banco db = new Banco("");
                DataTable dt;
                hfCidade.Value = db.ExecuteScalarQuery("select [Prefeitura] from [dbo].[Prefeitura] where [Id] = " + ViewState["IdPrefeitura"]);
            }

        }

        private static string PegaPrefeitura()
        {
            string Prefeitura = "";
            foreach (string rol in Roles.GetRolesForUser())
            {
                if (rol.Contains("cliente: "))
                {
                    Prefeitura = rol;
                }
            }
            return Prefeitura;
        }

        [WebMethod]
        public static List<ListaPermissoesUser> getPermissoesUser(string idPrefeitura, string Usuario)
        {
            Banco dbStatic = new Banco("");
            string sql = @"SELECT RoleName, Description FROM aspnet_Roles WHERE RoleName Like 'central%' order by RoleName";
            DataTable dt = dbStatic.ExecuteReaderQuery(sql);
            string Prefeitura = PegaPrefeitura();

            List<ListaPermissoesUser> ListaPermissoesUser = new List<ListaPermissoesUser>();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow item in dt.Rows)
                {
                    if (Roles.IsUserInRole(Usuario, item["RoleName"].ToString()))
                    {
                        ListaPermissoesUser.Add(new ListaPermissoesUser(item["RoleName"].ToString(), "checked", item["Description"].ToString()));

                    }
                    else
                    {
                        if (item["RoleName"].ToString().Contains("cliente:"))
                        {
                            if (item["RoleName"].ToString().Contains(Prefeitura))
                                ListaPermissoesUser.Add(new ListaPermissoesUser(item["RoleName"].ToString(), "checked", item["Description"].ToString()));
                        }
                        else
                        {
                            ListaPermissoesUser.Add(new ListaPermissoesUser(item["RoleName"].ToString(), "", item["Description"].ToString()));
                        }
                    }
                }
            }

            return ListaPermissoesUser;
        }

        [WebMethod]
        public static List<ListUsuarios> GetUsers(string prefeitura)
        {
            Banco dbStatic = new Banco("");
            string sql = "select distinct userName,replace(r.RoleName,'cliente: ','') Prefeitura from aspnet_Users u join  aspnet_UsersInRoles ur on ur.UserId=u.UserId " + 
                " join aspnet_Roles r on r.RoleId=ur.RoleId where r.RoleId=ur.RoleId and RoleName like '%"+prefeitura+"%' ";
            DataTable dt = dbStatic.ExecuteReaderQuery(sql);

            List<ListUsuarios> ListaUsers = new List<ListUsuarios>();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow item in dt.Rows)
                {
					ProfileBase profile = ProfileBase.Create(item["UserName"].ToString(),true);
					ListaUsers.Add(new ListUsuarios
					{
						User = item["UserName"].ToString(),
						Prefeitura = item["Prefeitura"].ToString(),
						Empresa = profile.GetPropertyValue("EmpresaUsuario").ToString()
                    });
                }
            }

            return ListaUsers;
        }

        [WebMethod]
        public static void SaveRoleUser(string user, string role)
        {
            if (!Roles.IsUserInRole(user, role))
            {
                Roles.AddUserToRole(user, role);
            }
            else
            {
                Roles.RemoveUserFromRole(user, role);
            }
        }
        public struct ListUsuarios
        {
            public string User { get; set; }
            public string Prefeitura { get; set; }
			public string Empresa { get; set; }
        }

        public class ListaPermissoesUser
        {
            public ListaPermissoesUser(string _funcionalidade, string _permissao, string _descricao)
            {
                Funcionalidade = _funcionalidade;
                Permissao = _permissao;
                Descricao = _descricao;

            }
            public string Funcionalidade { get; set; }
            public string Permissao { get; set; }
            public string Descricao { get; set; }
        }

    }
}