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
    public partial class CadastroProduto : System.Web.UI.Page
    {
        Banco db = new Banco("");
        string sql = "";
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 
                PanelDados.Visible = false;
                btnExcluir.Visible = false;
                btnCancelar.Visible = false;

                #region CarregaCbo
                // where idPrefeitura=" + ViewState["IdPrefeitura"].ToString()
                sql = "SELECT IdTipoProduto,dsc FROM TipoProduto";
                dt = db.ExecuteReaderQuery(sql);
                DropTipoProduto.DataTextField = "Dsc";
                DropTipoProduto.DataValueField = "IdTipoProduto";
                DropTipoProduto.DataSource = dt;
                DropTipoProduto.DataBind();
                DropTipoProduto.Items.Insert(0, new ListItem("Selecione o Tipo do Produto"));

                sql = "Select Id,Categoria from Categoria";
                dt = db.ExecuteReaderQuery(sql);
                DropCategoria.DataTextField = "categoria";
                DropCategoria.DataValueField = "id";
                DropCategoria.DataSource = dt;
                DropCategoria.DataBind();
                DropCategoria.Items.Insert(0, new ListItem("Selecione a Categoria"));

                sql = "Select Id,RazaoSocial from Fabricante";
                dt = db.ExecuteReaderQuery(sql);
                DropFabricante.DataTextField = "RazaoSocial";
                DropFabricante.DataValueField = "Id";
                DropFabricante.DataSource = dt;
                DropFabricante.DataBind();
                DropFabricante.Items.Insert(0, new ListItem("--Selecione o Fabricante --"));
                #endregion

                // where idPrefeitura=" + ViewState["IdPrefeitura"].ToString() + " group by Id,NomeProduto,NumeroSerie,Marca,Modelo
                sql = "Select Id,NomeProduto,NumeroSerie,Marca,Modelo from Produto order by NomeProduto";
                dt = db.ExecuteReaderQuery(sql);
                //mpProduto.Show();
                grdProduto.Visible = true;
                grdProduto.DataSource = dt;
                grdProduto.DataBind();

                #region recupera valores
                #region recupera tipop
                if (Request.QueryString["origem"] == "tipop")
                {

                    if (Request.QueryString["IdProduto"] != null)
                    {
                        txtNmrSerie.Text = Request.QueryString["NmrSerie"].ToString();
                        txtProduto.Text = Request.QueryString["Produto"].ToString();
                        txtMarca.Text = Request.QueryString["Marca"].ToString();
                        txtModelo.Text = Request.QueryString["Modelo"].ToString();
                        txtVolume.Text = Request.QueryString["Volume"].ToString();
                        DropTipoUni.SelectedItem.Text = Request.QueryString["TipoUni"].ToString();
                        DropCategoria.SelectedValue = Request.QueryString["IdCategoria"].ToString();
                        DropTipoProduto.SelectedValue = Request.QueryString["Idtipop"];

                        btnCadastrar.Text = "Salvar Alterações";
                        btnExcluir.Visible = true;
                        btnCancelar.Visible = true;
                        PanelDados.Visible = true;
                    }
                    if (Request.QueryString["IdProduto"] == "new")
                    {
                        txtNmrSerie.Text = Request.QueryString["NmrSerie"].ToString();
                        txtProduto.Text = Request.QueryString["Produto"].ToString();
                        txtMarca.Text = Request.QueryString["Marca"].ToString();
                        txtModelo.Text = Request.QueryString["Modelo"].ToString();
                        txtVolume.Text = Request.QueryString["Volume"].ToString();
                        DropTipoUni.SelectedItem.Text = Request.QueryString["TipoUni"].ToString();
                        DropCategoria.SelectedValue = Request.QueryString["IdCategoria"].ToString();
                        DropTipoProduto.SelectedValue = Request.QueryString["Idtipop"];

                        btnCadastrar.Text = "Salvar";
                        btnExcluir.Visible = false;
                        btnCancelar.Visible = true;
                        PanelDados.Visible = true;
                    }
                }

                #endregion

                #region categoria
                if (Request.QueryString["origem"] == "Categoria")
                {

                    if (Request.QueryString["IdProduto"] != null)
                    {
                        txtNmrSerie.Text = Request.QueryString["NmrSerie"].ToString();
                        txtProduto.Text = Request.QueryString["Produto"].ToString();
                        txtMarca.Text = Request.QueryString["Marca"].ToString();
                        txtModelo.Text = Request.QueryString["Modelo"].ToString();
                        txtVolume.Text = Request.QueryString["Volume"].ToString();
                        DropTipoUni.SelectedItem.Text = Request.QueryString["TipoUni"].ToString();
                        DropCategoria.SelectedValue = Request.QueryString["IdCategoria"];


                        btnCadastrar.Text = "Salvar Alterações";
                        btnExcluir.Visible = true;
                        btnCancelar.Visible = true;
                        PanelDados.Visible = true;
                    }
                    if (Request.QueryString["IdProduto"] == "new")
                    {
                        txtNmrSerie.Text = Request.QueryString["NmrSerie"].ToString();
                        txtProduto.Text = Request.QueryString["Produto"].ToString();
                        txtMarca.Text = Request.QueryString["Marca"].ToString();
                        txtModelo.Text = Request.QueryString["Modelo"].ToString();
                        txtVolume.Text = Request.QueryString["Volume"].ToString();
                        DropTipoUni.SelectedItem.Text = Request.QueryString["TipoUni"].ToString();
                        DropCategoria.SelectedValue = Request.QueryString["IdCategoria"];


                        btnCadastrar.Text = "Salvar";
                        btnExcluir.Visible = false;
                        btnCancelar.Visible = true;
                        PanelDados.Visible = true;
                    }

                }
                #endregion

                #region fabricante

                if (Request.QueryString["Origem"] == "Fabricante")
                {
                    if (Request.QueryString["IdProduto"] != null)
                    {
                        txtNmrSerie.Text = Request.QueryString["NmrSerie"].ToString();
                        txtProduto.Text = Request.QueryString["Produto"].ToString();
                        txtMarca.Text = Request.QueryString["Marca"].ToString();
                        txtModelo.Text = Request.QueryString["Modelo"].ToString();
                        txtVolume.Text = Request.QueryString["Volume"].ToString();
                        DropTipoUni.SelectedItem.Text = Request.QueryString["TipoUni"].ToString();
                        DropCategoria.SelectedValue = Request.QueryString["IdCategoria"];
                        DropFabricante.SelectedValue = Request.QueryString["IdFabricante"];


                        btnCadastrar.Text = "Salvar Alterações";
                        btnExcluir.Visible = true;
                        btnCancelar.Visible = true;
                        PanelDados.Visible = true;

                    }

                    if (Request.QueryString["IdProduto"] == "new")
                    {
                        txtNmrSerie.Text = Request.QueryString["NmrSerie"].ToString();
                        txtProduto.Text = Request.QueryString["Produto"].ToString();
                        txtMarca.Text = Request.QueryString["Marca"].ToString();
                        txtModelo.Text = Request.QueryString["Modelo"].ToString();
                        txtVolume.Text = Request.QueryString["Volume"].ToString();
                        DropTipoUni.SelectedItem.Text = Request.QueryString["TipoUni"].ToString();
                        DropCategoria.SelectedValue = Request.QueryString["IdCategoria"];
                        DropFabricante.SelectedValue = Request.QueryString["IdFabricante"];


                        btnCadastrar.Text = "Salvar";
                        btnExcluir.Visible = false;
                        btnCancelar.Visible = true;
                        PanelDados.Visible = true;
                    }

                }
                #endregion

                #endregion


            }
        }
        protected void grdProduto_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            ImgPesquisar.Visible = false;
            btnCadastrar.Text = "Salvar Alterações";
            PanelDados.Visible = true;
            btnExcluir.Visible = true;
            btnCancelar.Visible = true;
            //IdPrefeitura=" + ViewState["IdPrefeitura"].ToString() + " and
            string idCategoriaPlaca = db.ExecuteScalarQuery("select Id from Categoria where  (Categoria='PLACA' or categoria='PLACAS')");

            ViewState["IdProdutoGrid"] = grdProduto.DataKeys[e.NewSelectedIndex].Value;

            sql = "Select NomeProduto,NumeroSerie,Marca,Modelo,Volume,TipoUni,IdFabricante,IdCategoria,IdTipoProduto from Produto where Id=" + ViewState["IdProdutoGrid"];
            dt = db.ExecuteReaderQuery(sql);
            DataRow dr = dt.Rows[0];
            if (idCategoriaPlaca == dr["idCategoria"].ToString())
            {
                // IdPrefeitura=" + ViewState["IdPrefeitura"].ToString() + " and
                string idCategoriaControlador = db.ExecuteScalarQuery("select Id from Categoria where Categoria='CONTROLADOR'");
                dt = db.ExecuteReaderQuery(@"select p.NomeProduto Nome,p.Marca,p.Modelo,p.Id from  Produto  p
where p.IdCategoria=" + idCategoriaControlador);
                grdControlador.DataSource = dt;
                grdControlador.DataBind();
                pnlControlador.Visible = true;
                foreach (GridViewRow row in grdControlador.Rows)
                {
                    dt = db.ExecuteReaderQuery("select idProdutoControlador from PlacasControlador where idProdutoPlaca=" + ViewState["IdProdutoGrid"].ToString());
                    foreach (DataRow dr1 in dt.Rows)
                    {
                        if (dr1["idProdutoControlador"].ToString() == grdControlador.DataKeys[row.RowIndex].Value.ToString())
                        {
                            ((CheckBox)row.Cells[0].FindControl("chk")).Checked = true;
                        }
                    }
                }
            }
            else
            {
                pnlControlador.Visible = false;
            }
            txtProduto.Text = dr["NomeProduto"].ToString();
            txtNmrSerie.Text = dr["NumeroSerie"].ToString();
            txtMarca.Text = dr["Marca"].ToString();

            txtModelo.Text = dr["Modelo"].ToString();
            DropTipoUni.SelectedItem.Text = dr["TipoUni"].ToString();
            DropFabricante.SelectedValue = dr["IdFabricante"].ToString();
            DropCategoria.SelectedValue = dr["IdCategoria"].ToString();
            DropTipoProduto.SelectedValue = dr["IdTipoProduto"].ToString();
            grdProduto.Visible = false;
            txtVolume.Text = dr["Volume"].ToString();
            if (DropTipoUni.SelectedItem.Text == "UNIDADE")
            {
                txtVolume.Text = "1";
                txtVolume.Enabled = false;
            }
            else
            {
                txtVolume.Enabled = true;
            }


        }
        protected void grdProduto_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void btnAdcFabricante_Click(object sender, EventArgs e)
        {

            if (ViewState["IdProdutoGrid"] != null)
            {
                Response.Redirect("../Fabricante/CadastroFabricante.aspx?Origem=CadProduto&IdProduto=" + ViewState["IdProdutoGrid"] + "&NmrSerie=" + txtNmrSerie.Text + "&Produto=" + txtProduto.Text + "&Marca=" + txtMarca.Text +
                    "&Modelo=" + txtModelo.Text + "&TipoUni=" + DropTipoUni.SelectedItem.Text + "&Volume=" + txtVolume.Text + "&IdCategoria=" + DropCategoria.SelectedValue + "&IdTipoProduto=" + DropTipoProduto.SelectedValue);
            }
            else
            {
                Response.Redirect("../Fabricante/CadastroFabricante.aspx?Origem=CadProduto&IdProduto=new&NmrSerie=" + txtNmrSerie.Text + "&Produto=" + txtProduto.Text + "&Marca=" + txtMarca.Text +
                    "&Modelo=" + txtModelo.Text + "&TipoUni=" + DropTipoUni.SelectedItem.Text + "&Volume=" + txtVolume.Text + "&IdCategoria=" + DropCategoria.SelectedValue + "&IdTipoProduto=" + DropTipoProduto.SelectedValue);
            }
        }
        protected void ImgPesquisar_Click(object sender, ImageClickEventArgs e)
        {
            if (txtNmrSerie.Text == "" && txtProduto.Text == "")
            {
                sql = "Select Id,NomeProduto,NumeroSerie,Marca,Modelo from Produto where order by NomeProduto";
                dt = db.ExecuteReaderQuery(sql);
                //mpProduto.Show();
                grdProduto.Visible = true;
                grdProduto.DataSource = dt;
                grdProduto.DataBind();
            }

            if (txtNmrSerie.Text != "" && txtProduto.Text == "")
            {
                sql = "Select Id,NomeProduto,NumeroSerie,Marca,Modelo from Produto where NumeroSerie Like '%" + txtNmrSerie.Text + "%' group by Id,NomeProduto,NumeroSerie,Marca,Modelo order by NomeProduto";
                dt = db.ExecuteReaderQuery(sql);
                if (dt.Rows.Count == 0)
                {
                    mpMsg.Show();
                    lblMsg.Text = "Não há Produt cadastrados com este Número de Série!";
                    return;
                }
                else
                {
                    // mpProduto.Show();
                    grdProduto.Visible = true;
                    grdProduto.DataSource = dt;
                    grdProduto.DataBind();
                }
            }

            if (txtNmrSerie.Text == "" && txtProduto.Text != "")
            {
                sql = "Select Id,NomeProduto,NumeroSerie,Marca,Modelo from Produto where (NomeProduto like '%" + txtProduto.Text + "%' or modelo like '%" + txtProduto.Text + "%')  order by NomeProduto";
                dt = db.ExecuteReaderQuery(sql);
                if (dt.Rows.Count == 0)
                {
                    mpMsg.Show();
                    lblMsg.Text = "Não há Produto cadastrado com este Nome!";
                    return;
                }
                else
                {
                    grdProduto.Visible = true;
                    grdProduto.DataSource = dt;
                    grdProduto.DataBind();
                }
            }
            if (txtNmrSerie.Text != "" && txtProduto.Text != "")
            {
                sql = @"Select Id,NomeProduto,NumeroSerie,Marca,Modelo from Produto where (NomeProduto like '%" + txtProduto.Text + "%' or modelo like '%" + txtProduto.Text + "%') and  NumeroSerie like '%" + txtNmrSerie.Text +
                   "%'   group by Id,NomeProduto,NumeroSerie,Marca,Modelo order by NomeProduto";
                dt = db.ExecuteReaderQuery(sql);
                if (dt.Rows.Count == 0)
                {
                    mpMsg.Show();
                    lblMsg.Text = "Não há Produto cadastrado com este Número de Série e Nome!";
                    return;
                }
                else
                {
                    grdProduto.Visible = true;
                    grdProduto.DataSource = dt;
                    grdProduto.DataBind();
                }
            }
        }
        protected void btnCadastrar_Click(object sender, EventArgs e)
        {
            if (btnCadastrar.Text == "Novo")
            {
                btnCadastrar.Text = "Salvar";
                PanelDados.Visible = true;
                grdProduto.Visible = false;
                ImgPesquisar.Visible = false;
                btnCancelar.Visible = true;
                pnlControlador.Visible = false;
                txtMarca.Text = "";
                txtModelo.Text = "";
                txtNmrSerie.Text = "";
                txtProduto.Text = "";
                txtVolume.Text = "";

                DropCategoria.SelectedIndex = 0;
                DropFabricante.SelectedIndex = 0;
                DropTipoProduto.SelectedIndex = 0;
                DropTipoUni.SelectedIndex = 0;

                return;

            }

            #region Valida Controlador
            //IdPrefeitura=" + ViewState["IdPrefeitura"].ToString() + " and
            string idCategoriaPlaca = db.ExecuteScalarQuery("select Id from Categoria where  (Categoria='PLACA' or categoria='PLACAS')");
            if (idCategoriaPlaca == DropCategoria.SelectedValue)
            {
                int i = 0;
                foreach (GridViewRow row in grdControlador.Rows)
                {
                    if (((CheckBox)row.Cells[0].FindControl("chk")).Checked == false)
                    {
                        i++;
                    }
                }
                if (i == grdControlador.Rows.Count)
                {
                    mpMsg.Show();
                    lblMsg.Text = "Selecione um Controlador para a Placa!";
                    return;
                }
            }

            #endregion
            if (btnCadastrar.Text == "Salvar")
            {
                #region Valida
                // and idPrefeitura=" + ViewState["IdPrefeitura"].ToString()
                DataTable dtNumeroSerie = db.ExecuteReaderQuery("select * from Produto where NumeroSerie='" + txtNmrSerie.Text + "'");
                if (dtNumeroSerie.Rows.Count > 0)//valida se o nmr de serie corresponde a marca,modelo, e nome cadastrado já no banco
                {
                    DataRow drNmrSerie = dtNumeroSerie.Rows[0];
                    string NomeProduto = drNmrSerie["NomeProduto"].ToString().Trim();

                    string Nome = txtProduto.Text.ToString().Trim();//tira espaço
                    txtProduto.Text = Nome;


                    if (txtMarca.Text != drNmrSerie["marca"].ToString())
                    {
                        mpMsg.Show();
                        lblMsg.Text = "A Marca não Corresponde à esse Número de Série!";
                        return;

                    }
                    if (txtModelo.Text != drNmrSerie["modelo"].ToString())
                    {
                        mpMsg.Show();
                        lblMsg.Text = "O Modelo não Corresponde à esse Número de Série!";
                        return;

                    }
                    else if (txtProduto.Text != NomeProduto)
                    {
                        mpMsg.Show();
                        lblMsg.Text = "O Nome do Produto não Corresponde à esse Número de Série!";
                        return;

                    }
                }
                #endregion
                if (txtNmrSerie.Text == "")
                {
                    mpMsg.Show();
                    lblMsg.Text = "Preencha o Campo Número de Série!";
                    return;
                }
                if (txtProduto.Text == "")
                {
                    mpMsg.Show();
                    lblMsg.Text = "Preencha o Campo Produto!";
                    return;
                }

                sql = @"Insert into Produto(NomeProduto,NumeroSerie,TipoUni,Marca,Modelo,Volume,IdTipoProduto,IdCategoria,IdFabricante) Values ('" + txtProduto.Text +
                    "','" + txtNmrSerie.Text + "','" + DropTipoUni.SelectedItem.Text + "','" + txtMarca.Text + "','" + txtModelo.Text + "','" + txtVolume.Text + "'," +
                    DropTipoProduto.SelectedValue + "," + DropCategoria.SelectedValue + "," + DropFabricante.SelectedValue + ") Select SCOPE_IDENTITY()";
                ViewState["IdProduto"] = db.ExecuteScalarQuery(sql);
                if (idCategoriaPlaca == DropCategoria.SelectedValue)
                {
                    foreach (GridViewRow row in grdControlador.Rows)
                    {
                        if (((CheckBox)row.Cells[0].FindControl("chk")).Checked == true)
                        {
                            string idProdutoControlador = grdControlador.DataKeys[row.RowIndex].Value.ToString();
                            db.ExecuteNonQuery("insert into PlacasControlador (idProdutoControlador,idProdutoPlaca) values (" + idProdutoControlador + "," + ViewState["IdProduto"].ToString() + ")");
                        }
                    }
                }
                mpMsg.Show();
                lblMsg.Text = "Produto Adicionado com Sucesso!";


                sql = sql = sql = @"Select Id,NomeProduto,NumeroSerie,Marca,Modelo from Produto order by NomeProduto";
                dt = db.ExecuteReaderQuery(sql);
                grdProduto.Visible = true;
                grdProduto.DataSource = dt;
                grdProduto.DataBind();

                PanelDados.Visible = false;
                txtNmrSerie.Text = "";
                txtProduto.Text = "";
                btnCadastrar.Text = "Novo";
                ImgPesquisar.Visible = true;
                btnCancelar.Visible = false;
                return;
            }

            if (btnCadastrar.Text == "Salvar Alterações")
            {
                sql = @"Update Produto set NomeProduto='" + txtProduto.Text + "',NumeroSerie='" + txtNmrSerie.Text + "',Marca='" + txtMarca.Text + "',Modelo='" + txtModelo.Text +
                    "',Volume='" + txtVolume.Text + "',TipoUni='" + DropTipoUni.SelectedItem.Text + "',IdTipoProduto=" + DropTipoProduto.SelectedValue + ",IdCategoria=" +
                    DropCategoria.SelectedValue + ",IdFabricante=" + DropFabricante.SelectedValue + " where Id=" + ViewState["IdProdutoGrid"];
                db.ExecuteNonQuery(sql);

                if (idCategoriaPlaca == DropCategoria.SelectedValue)
                {
                    db.ExecuteNonQuery("delete from PlacasControlador where idProdutoPlaca=" + ViewState["IdProdutoGrid"].ToString());
                    foreach (GridViewRow row in grdControlador.Rows)
                    {
                        if (((CheckBox)row.Cells[0].FindControl("chk")).Checked == true)
                        {
                            string idProdutoControlador = grdControlador.DataKeys[row.RowIndex].Value.ToString();
                            db.ExecuteNonQuery("insert into PlacasControlador (idProdutoControlador,idProdutoPlaca) values (" + idProdutoControlador + "," + ViewState["IdProdutoGrid"].ToString() + ")");
                        }
                    }
                }
                mpMsg.Show();
                lblMsg.Text = "Produto Alterado com Sucesso!";

                sql = sql = @"Select Id,NomeProduto,NumeroSerie,Marca,Modelo from Produto order by NomeProduto";
                dt = db.ExecuteReaderQuery(sql);
                grdProduto.Visible = true;
                grdProduto.DataSource = dt;
                grdProduto.DataBind();
                txtNmrSerie.Text = "";
                txtProduto.Text = "";


                btnCadastrar.Text = "Novo";
                ImgPesquisar.Visible = true;
                PanelDados.Visible = false;
                btnExcluir.Visible = false;
                btnCancelar.Visible = false;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            PanelDados.Visible = false;
            ImgPesquisar.Visible = true;
            btnCadastrar.Text = "Novo";
            btnCancelar.Visible = false;
            btnExcluir.Visible = false;
            grdProduto.Visible = true;

            txtNmrSerie.Text = "";
            txtProduto.Text = "";
            txtMarca.Text = "";
            txtModelo.Text = "";
            txtVolume.Text = "";

        }
        protected void btnExcluir_Click(object sender, EventArgs e)
        {
            sql = "select IdPatrimonio from Patrimonio where IdProduto=" + ViewState["IdProdutoGrid"];
            dt = db.ExecuteReaderQuery(sql);
            if (dt.Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", "alert('Esse Produto esta patrimoniado e nao pode ser excluido!')", true);
                return;
            }

            sql = "Delete from Produto where id=" + ViewState["IdProdutoGrid"];
            db.ExecuteNonQuery(sql);
            db.ExecuteNonQuery("delete from PlacasControlador where idProdutoPlaca=" + ViewState["IdProdutoGrid"].ToString());
            mpMsg.Show();
            lblMsg.Text = "Produto Excluído com Sucesso!";

            sql = "Select Id,NomeProduto,NumeroSerie,Marca,Modelo from Produto  group by Id,NomeProduto,NumeroSerie,Marca,Modelo order by NomeProduto";
            dt = db.ExecuteReaderQuery(sql);

            grdProduto.Visible = true;
            grdProduto.DataSource = dt;
            grdProduto.DataBind();

            txtNmrSerie.Text = "";
            txtProduto.Text = "";
            PanelDados.Visible = false;
            btnCadastrar.Text = "Novo";
            btnExcluir.Visible = false;
            btnCancelar.Visible = false;
            ImgPesquisar.Visible = true;
        }
        protected void btnAdcCategoria_Click(object sender, EventArgs e)
        {

            if (ViewState["IdProdutoGrid"] != null)
            {
                Response.Redirect("../Categoria/Default.aspx?Origem=CadProduto&IdProduto=" + ViewState["IdProdutoGrid"] + "&NmrSerie=" + txtNmrSerie.Text + "&Produto=" + txtProduto.Text + "&Marca=" + txtMarca.Text +
                    "&Modelo=" + txtModelo.Text + "&TipoUni=" + DropTipoUni.SelectedItem.Text + "&Volume=" + txtVolume.Text);
            }
            else
            {
                Response.Redirect("../Categoria/Default.aspx?Origem=CadProduto&IdProduto=new&NmrSerie=" + txtNmrSerie.Text + "&Produto=" + txtProduto.Text + "&Marca=" + txtMarca.Text +
                    "&Modelo=" + txtModelo.Text + "&TipoUni=" + DropTipoUni.SelectedItem.Text + "&Volume=" + txtVolume.Text);
            }

        }
        protected void btnAdcTipoProduto_Click(object sender, EventArgs e)
        {

            if (ViewState["IdProdutoGrid"] != null)
            {
                Response.Redirect("../TipoProduto/Cadastro.aspx?Origem=CadProduto&IdProduto=" + ViewState["IdProdutoGrid"] + "&NmrSerie=" + txtNmrSerie.Text + "&Produto=" + txtProduto.Text + "&Marca=" + txtMarca.Text +
                    "&Modelo=" + txtModelo.Text + "&TipoUni=" + DropTipoUni.SelectedItem.Text + "&Volume=" + txtVolume.Text + "&IdCategoria=" + DropCategoria.SelectedValue);
            }
            else
            {
                Response.Redirect("../TipoProduto/Cadastro.aspx?Origem=CadProduto&IdProduto=new&NmrSerie=" + txtNmrSerie.Text + "&Produto=" + txtProduto.Text + "&Marca=" + txtMarca.Text +
                    "&Modelo=" + txtModelo.Text + "&TipoUni=" + DropTipoUni.SelectedItem.Text + "&Volume=" + txtVolume.Text + "&IdCategoria=" + DropCategoria.SelectedValue);
            }

        }
        protected void grdProduto_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Creating hover effects on mouseover event for each row
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Height = 34;
                e.Row.Attributes["onmouseover"] = "this.style.background='#E6E6E6';";
                if ((e.Row.RowIndex % 2) == 0)
                    // if even row      
                    e.Row.Attributes["onmouseout"] = "this.style.background='White';";
                else
                    // alternate row      
                    e.Row.Attributes["onmouseout"] = "this.style.background='White';";
            }
        }

        protected void DropTipoProduto_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropTipoProduto.SelectedItem.Text.ToUpper() == "SEMAFORICO")
            {
                dt = db.ExecuteReaderQuery(@"select id,categoria from Categoria where  categoria IN('CONTROLADOR','GPRS','ACESSORIOS','SISTEMA DE ILUMINAÇÃO','SISTEMA DE ILUMINACAO','GRUPO FOCAL','CABO','CABOS','PLACA'
,'PLACAS','NOBREAK','COLUNA','COLUNAS')");
                DropCategoria.DataTextField = "categoria";
                DropCategoria.DataValueField = "id";
                DropCategoria.DataSource = dt;
                DropCategoria.DataBind();
                DropCategoria.Items.Insert(0, new ListItem("Selecione a Categoria"));
            }
            else
            {
                DataTable dte;
                sql = "Select Id,Categoria from Categoria";
                dte = db.ExecuteReaderQuery(sql);
                DropCategoria.DataTextField = "categoria";
                DropCategoria.DataValueField = "id";
                DropCategoria.DataSource = dte;
                DropCategoria.DataBind();
                DropCategoria.Items.Insert(0, new ListItem("Selecione a Categoria"));
            }
        }
        protected void DropCategoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropCategoria.SelectedItem.Text == "PLACA" || DropCategoria.SelectedItem.Text == "PLACAS")
            {
                string idCategoriaControlador = db.ExecuteScalarQuery("select Id from Categoria where  Categoria='CONTROLADOR'");
                dt = db.ExecuteReaderQuery(@"select p.NomeProduto Nome,p.Marca,p.Modelo,p.Id from  Produto  p
where p.IdCategoria=" + idCategoriaControlador);// + " and idPrefeitura=" + ViewState["IdPrefeitura"].ToString()
                grdControlador.DataSource = dt;
                grdControlador.DataBind();
                pnlControlador.Visible = true;
            }
            else
            {
                pnlControlador.Visible = false;
            }
        }
         
    }
}