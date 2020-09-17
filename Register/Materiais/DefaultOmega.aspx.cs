using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GwCentral.Register.Materiais
{
    public partial class DefaultOmega : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hfIdPrefeitura.Value = HttpContext.Current.Profile["idPrefeitura"].ToString();
        }
    }
}