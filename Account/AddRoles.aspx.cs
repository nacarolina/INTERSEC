using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Membership.OpenAuth;
using Microsoft.AspNet.Membership;
using Microsoft.AspNet.Membership.OpenAuth.Data;
namespace GwCentral.Account
{
    public partial class AddRoles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //RoleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(new MyDbContext()));
           // var str = RoleManager.Create(new IdentityRole(roleName));
        }
    }
}