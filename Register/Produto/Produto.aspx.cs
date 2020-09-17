using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GwCentral.Register.Produto
{
    public partial class Produto : System.Web.UI.Page
    {
        Banco db = new Banco("");
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = null;
            Session["IdDepartamento"] = "";
            ViewState["ValorPesquisa"] = Request.QueryString["NomeProduto"];
            ViewState["TipoPesquisa"] = Request.QueryString["TipoPesquisa"];
            if (ViewState["TipoPesquisa"].ToString() == "Produto")
            {
                string sql = @"select p.numeroserie,NomeProduto 'Nome do Produto', marca , modelo,Fabricante
         from Patrimonio p left join Fornecedor f  on p.idFornecedor=f.id 
        where NomeProduto like '%" + ViewState["ValorPesquisa"].ToString() + "%' and p.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() +
                      @"  Group by p.numeroserie,NomeProduto, marca , modelo,Fabricante";
                dt = db.ExecuteReaderQuery(sql);

                if (dt.Rows.Count == 0)
                {
                    ClientScript.RegisterStartupScript(System.Type.GetType("System.String"), "Alert",
    "<script languaje='javascript'> { window.alert(\"Não ha Produto Cadastrado!\") }</script>");
                    return;
                }

                grdProduto.DataSource = dt;
                grdProduto.DataBind();
            }
            if (ViewState["TipoPesquisa"].ToString() == "NumeroSerie")
            {
                //Caso seja Cobrasin lista todos os produtos de todas prefeitura
                if (HttpContext.Current.Profile["idPrefeitura"].ToString() == "30")
                {
                    string sql = @"select p.numeroserie,NomeProduto 'Nome do Produto', marca , modelo,Fabricante
         from Patrimonio p left join Fornecedor f  on p.idFornecedor=f.id 
        where NumeroSerie like '%" + ViewState["ValorPesquisa"].ToString() + "%' Group by p.numeroserie,NomeProduto, marca , modelo,Fabricante";
                    dt = db.ExecuteReaderQuery(sql);

                    if (dt.Rows.Count == 0)
                    {
                        ClientScript.RegisterStartupScript(System.Type.GetType("System.String"), "Alert",
        "<script languaje='javascript'> { window.alert(\"Não ha Produto Cadastrado!\") }</script>");
                        return;
                    }

                    grdProduto.DataSource = dt;
                    grdProduto.DataBind();
                }
                else
                {
                    string sql = @"select p.numeroserie,NomeProduto 'Nome do Produto', marca , modelo,Fabricante
         from Patrimonio p left join Fornecedor f  on p.idFornecedor=f.id 
        where NumeroSerie like '%" + ViewState["ValorPesquisa"].ToString() + "%' and p.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() +
    @"  Group by p.numeroserie,NomeProduto, marca , modelo,Fabricante";
                    dt = db.ExecuteReaderQuery(sql);

                    if (dt.Rows.Count == 0)
                    {
                        ClientScript.RegisterStartupScript(System.Type.GetType("System.String"), "Alert",
        "<script languaje='javascript'> { window.alert(\"Não ha Produto Cadastrado!\") }</script>");
                        return;
                    }

                    grdProduto.DataSource = dt;
                    grdProduto.DataBind();
                }
            }
        }
        protected void grdProduto_SelectedIndexChanged(object sender, EventArgs e)
        {
            string origem = "";
            Session["NumeroSerie"] = Server.HtmlDecode(grdProduto.SelectedRow.Cells[0].Text);
            Session["NomeProduto"] = Server.HtmlDecode(grdProduto.SelectedRow.Cells[1].Text);
            Session["Marca"] = Server.HtmlDecode(grdProduto.SelectedRow.Cells[2].Text);
            Session["Modelo"] = Server.HtmlDecode(grdProduto.SelectedRow.Cells[3].Text);
            Session["Fabricante"] = Server.HtmlDecode(grdProduto.SelectedRow.Cells[4].Text);
            Session["RazaoSocial"] = Server.HtmlDecode(grdProduto.SelectedRow.Cells[5].Text);

            try
            {
                origem = Request.QueryString["CadPatrimonio"];
            }
            catch
            { }

            string sql = @"select idTipoProduto,idCategoria from Patrimonio where NumeroSerie='" + grdProduto.SelectedRow.Cells[0].Text + "'";
            DataTable dt = db.ExecuteReaderQuery(sql);
            DataRow dr = dt.Rows[0];
            Session["idTipoProduto"] = dr["idTipoProduto"].ToString();
            Session["idCategoria"] = dr["idCategoria"].ToString();

            if (origem == Request.QueryString["CadPatrimonio"])
            {
                if (Session["IdDepartamento"].ToString() == "-- Selecione o Departamento --")
                {
                    Response.Redirect("../Patrimonio/Cadastro.aspx?RetCad=true");
                }
                else
                {
                    Response.Redirect("../Patrimonio/Cadastro.aspx?RetCad=true&IdDepartamento=" + Session["IdDepartamento"].ToString());
                }

            }
        }
        protected void btnVoltar_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Patrimonio/Cadastro.aspx?RetCad=true");
        }
    }
}