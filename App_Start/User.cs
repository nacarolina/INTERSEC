using System;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Profile;
using System.Web.Security;

namespace Infortronics
{
	/// <summary>
	/// Summary description for User
	/// </summary>

	[DataObject()]
	public class User
	{
		public User()
		{
			//
			// TODO: Add constructor logic here
			//
		}
		[DataObjectMethod(DataObjectMethodType.Select)]
		public DataTable GetAllUsers()
		{
			Banco db = new Banco("");
			string prefeitura = db.ExecuteScalarQuery("select prefeitura from prefeitura where id="+ HttpContext.Current.Profile["idPrefeitura"].ToString());
			DataTable dt = new DataTable("Usuarios");
			MembershipUserCollection muc = Membership.GetAllUsers();

			dt.Columns.Add("Usuario", Type.GetType("System.String"));
			dt.Columns.Add("Email", Type.GetType("System.String"));
			//dt.Columns.Add("Comentario", Type.GetType("System.String"));
			//dt.Columns.Add("DataCadastro", Type.GetType("System.DateTime"));
			//dt.Columns.Add("UltimoAcesso", Type.GetType("System.DateTime"));
			dt.Columns.Add("Status", Type.GetType("System.String"));

			foreach (MembershipUser mu in muc)
			{
				if (mu.UserName == "admin")
					continue;
				DataRow dr;

				if (Roles.IsUserInRole(mu.UserName,"cliente: "+prefeitura))
				{

					dr = dt.NewRow();
					dr["Usuario"] = mu.UserName;
					dr["Email"] = mu.Email;
					//dr["Comentario"] = mu.Comment;
					//dr["DataCadastro"] = mu.CreationDate;
					//dr["UltimoAcesso"] = mu.LastLoginDate;
					dr["Status"] = mu.IsOnline == true ? "Online" : "Offline";
					dt.Rows.Add(dr);
				}

			}

			return dt;
		}

		[DataObjectMethod(DataObjectMethodType.Select)]
		public DataTable GetUser2(string Usuario)
		{
			if (Usuario == "" || Usuario == null)
				return GetAllUsers();
			DataTable dt = new DataTable("Usuarios");
			MembershipUser mu = Membership.GetUser(Usuario);
			ProfileBase profile = ProfileBase.Create(Usuario, true);


			dt.Columns.Add("Usuario", Type.GetType("System.String"));
			dt.Columns.Add("EmpresaUsuario", Type.GetType("System.String"));
			dt.Columns.Add("Email", Type.GetType("System.String"));
			dt.Columns.Add("Status", Type.GetType("System.String"));
			if (mu != null)
			{
				DataRow dr;
				dr = dt.NewRow();
				dr["Usuario"] = mu.UserName;
				dr["Email"] = mu.Email;
				dr["Status"] = mu.IsOnline == true ? "Online" : "Offline";
				dt.Rows.Add(dr);
			}
			return dt;
		}
		[DataObjectMethod(DataObjectMethodType.Select)]
		public DataTable GetUser(string Usuario)
		{
			if (Usuario == null)
				return null;
			MembershipUser mu = Membership.GetUser(Usuario);
			DataTable dt = new DataTable("Usuario");

			ProfileBase profile = ProfileBase.Create(Usuario, true);

			dt.Columns.Add("Usuario", Type.GetType("System.String"));
			dt.Columns.Add("Email", Type.GetType("System.String"));
			dt.Columns.Add("EmpresaUsuario", Type.GetType("System.String"));
			dt.Columns.Add("Comentario", Type.GetType("System.String"));
			dt.Columns.Add("DataCadastro", Type.GetType("System.DateTime"));
			dt.Columns.Add("UltimoAcesso", Type.GetType("System.DateTime"));
			dt.Columns.Add("Status", Type.GetType("System.String"));
			DataRow dr;
			dr = dt.NewRow();
			dr["Usuario"] = mu.UserName;
			dr["Email"] = mu.Email;
			dr["EmpresaUsuario"] = profile.GetPropertyValue("EmpresaUsuario");
			dr["Comentario"] = mu.Comment;
			dr["DataCadastro"] = mu.CreationDate;
			dr["UltimoAcesso"] = mu.LastLoginDate;
			dr["Status"] = mu.IsOnline == true ? "Online" : "Offline";
			dt.Rows.Add(dr);


			return dt;
		}

		[DataObjectMethod(DataObjectMethodType.Update)]
		public void UpdateUser(string Usuario, string Email, string Comentario, string EmpresaUsuario)
		{
			if (Usuario == null)
				return;
			MembershipUser mu = Membership.GetUser(Usuario);
			mu.Email = Email;
			mu.Comment = Comentario;
			Membership.UpdateUser(mu);
			ProfileBase profile = ProfileBase.Create(Usuario, true);
			profile.SetPropertyValue("EmpresaUsuario", EmpresaUsuario);
			profile.Save();

		}

		[DataObjectMethod(DataObjectMethodType.Select)]
		public DataTable GetRoles(string Usuario)
		{
			if (Usuario == null)
				return null;
			DataTable dt = new DataTable("Permissoes");
			string[] roles = Roles.GetAllRoles();
			string[] rolesUser = Roles.GetRolesForUser(Usuario);
			dt.Columns.Add("Permissao", Type.GetType("System.String"));
			dt.Columns.Add("on", Type.GetType("System.Boolean"));

			foreach (var item in roles)
			{
				DataRow dr;
				dr = dt.NewRow();
				dr["Permissao"] = item;
				dr["on"] = rolesUser.Contains(item) ? true : false;
				dt.Rows.Add(dr);
			}
			return dt;
		}
	}
}