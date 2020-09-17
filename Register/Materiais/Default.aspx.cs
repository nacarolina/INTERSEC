using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GwCentral.Register.Materiais
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Banco db = new Banco("");
            if (!IsPostBack)
            {
                foreach (string role in Roles.GetRolesForUser())
                {
                    DataTable dt = db.ExecuteReaderQuery("SELECT Id FROM Prefeitura Where Prefeitura = '" + role.Replace("cliente: ", "") + "'");
                    if (dt.Rows.Count > 0)
                    {
                        DataRow dr = dt.Rows[0];
                        ViewState["IdPrefeitura"] = dr["id"].ToString();
                        ViewState["RolePrefeitura"] = role.Replace("cliente: ", "");
                    }

                }

                hfIdPrefeitura.Value = ViewState["IdPrefeitura"].ToString();

                if (Request.QueryString["idtalao"] != null)
                {
                    hfIdOcorrencia.Value = Request.QueryString["idtalao"].ToString();
                }
                else
                {
                    hfIdOcorrencia.Value = "";
                }

                if (Request.QueryString["idDna"] != null)
                {
                    hfIdDna.Value = Request.QueryString["idDna"].ToString();
                }
                else
                {
                    hfIdDna.Value = "";
                }

                if (Request.QueryString["IdDnaGSS"] != null)
                {
                    hfIdDnaGSS.Value = Request.QueryString["IdDnaGSS"].ToString();
                }
                else
                {
                    hfIdDnaGSS.Value = "";
                }
            }
        }

        protected void lnkAbrirImagens_Click(object sender, EventArgs e)
        {
            Response.Redirect("../ImagemDepartamento/Default.aspx?idDepartamento=" + hfIdDepartamento.Value + "&idSubdivisao=" + hfIdSub.Value);
        }

        protected void lnkAbrirProjetos_Click(object sender, EventArgs e)
        {
            Response.Redirect("../ProjetoDepartamento/Default.aspx?idDepartamento=" + hfIdDepartamento.Value + "&idSubdivisao=" + hfIdSub.Value);
        }
    }
}