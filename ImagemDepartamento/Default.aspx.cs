using Infortronics;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
public class imgs
{
    public imgs(string _caminho)
    {
        Name = _caminho;
    }
    public string Name { get; set; }
}
public class imgs2
{
    public imgs2(string _caminho, string nomeImagem)
    {
        Name = _caminho;
        NomeImagem = nomeImagem;
    }
    public string Name { get; set; }
    public string NomeImagem { get; set; }
}
public partial class ImagemDna_Default2 : System.Web.UI.Page
{
    Banco db = new Banco();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            foreach (string role in Roles.GetRolesForUser())
            {
                DataTable dt = db.ExecuteReaderQuery("SELECT * FROM Prefeitura Where Prefeitura = '" + role.Replace("cliente: ", "") + "'");
                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    ViewState["IdPrefeitura"] = dr["id"].ToString();
                    dt = db.ExecuteReaderQuery("SELECT * FROM Departamento D join Prefeitura P on P.Id=D.IdPrefeitura where Prefeitura='" + role.Replace("cliente: ", "") + "'");
                    ddlDepartamento.DataTextField = "Nome";
                    ddlDepartamento.DataValueField = "Id";
                    ddlDepartamento.DataSource = dt;
                    ddlDepartamento.DataBind();
                    ddlDepartamento.Items.Insert(0, new ListItem("-- Selecione o Departamento --"));

                }
            }
            try
            {
                if (Request.QueryString["Voltar"].ToString() == "Sim")
                {
                    ddlDepartamento.SelectedValue = Session["IdDepartamento"].ToString();
                    DataTable dt = db.ExecuteReaderQuery("Select id, Subdivisao from subdivisao_departamento where idDepartamento=" + Session["IdDepartamento"].ToString());
                    ddlSubdivisao.DataTextField = "Subdivisao";
                    ddlSubdivisao.DataValueField = "Id";
                    ddlSubdivisao.DataSource = dt;
                    ddlSubdivisao.DataBind();
                    ddlSubdivisao.Items.Insert(0, new ListItem("-- Selecione a Subdivisão --"));
                    if (Session["IdSubDivisao"] != null)
                    {
                        ddlSubdivisao.SelectedValue = Session["IdSubDivisao"].ToString();
                    }
                    Pesquisa();
                }
                
            }
            catch (Exception)
            {
            }

            if (!string.IsNullOrEmpty(Request.QueryString["idDepartamento"]))
            {
                ddlDepartamento.SelectedValue = Request.QueryString["idDepartamento"].ToString();
                DataTable dt = db.ExecuteReaderQuery("Select id, Subdivisao from subdivisao_departamento where idDepartamento=" + ddlDepartamento.SelectedValue);
                ddlSubdivisao.DataTextField = "Subdivisao";
                ddlSubdivisao.DataValueField = "Id";
                ddlSubdivisao.DataSource = dt;
                ddlSubdivisao.DataBind();
                ddlSubdivisao.Items.Insert(0, new ListItem("-- Selecione a Subdivisão --"));
                if (!string.IsNullOrEmpty(Request.QueryString["idSubdivisao"]))
                {
                    ddlSubdivisao.SelectedValue = Request.QueryString["idSubdivisao"].ToString();
                }
                Pesquisa();
            }
          
        }
      

        //DataTable dt = db.ExecuteReaderQuery(string.Format("SELECT Arquivo FROM ImagemDna"));
        //DirectoryInfo dir = new DirectoryInfo(MapPath("Images\\07112013"));
        //FileInfo[] files = dir.GetFiles();
        //ArrayList listItems = new ArrayList();
        //List<imgs> img = new List<imgs>();
        //foreach (FileInfo info in files)
        //{
        //    var q = from query in dt.AsEnumerable()
        //            where query.Field<string>("Arquivo").Contains(info.Name)
        //            select query;
        //    if (q.ToList().Count > 0)
        //        // listItems.Add(info);
        //        img.Add(new imgs("07112013\\" + info.Name));
        //}

        //DataList1.DataSource = img;
        //DataList1.DataBind();
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        if (ddlDepartamento.Text != "-- Selecione o Departamento --")
        {
            if (ddlSubdivisao.Text != "-- Selecione a Subdivisão --")
            {
                Response.Redirect("uploadImage.aspx?IdDepartamento=" + ddlDepartamento.SelectedValue + "&IdSubDivisao=" + ddlSubdivisao.SelectedValue);
            }
            else
            {
                Response.Redirect("uploadImage.aspx?IdDepartamento=" + ddlDepartamento.SelectedValue);
            }
        }
    }
    protected void DeleteButton_Click(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
    }
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        string NomeArquivo = "";
        string nome = ((HyperLink)e.Item.FindControl("HyperLink1")).Text;
        string diretorio = MapPath("Images\\" + nome);

        if (((HyperLink)e.Item.FindControl("HyperLink1")).Text.Contains(@"/"))
        {
            int pos = ((HyperLink)e.Item.FindControl("HyperLink1")).Text.IndexOf(@"/");
            NomeArquivo = nome.Substring(pos + 1);
        }
        System.IO.File.Delete(diretorio);

        db.ExecuteNonQuery("DELETE FROM ImagemDepartamento where Nome = '" + NomeArquivo + "'");
        Pesquisa();
    }

    protected void ddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt = db.ExecuteReaderQuery("Select id, Subdivisao from subdivisao_departamento where idDepartamento=" + ddlDepartamento.SelectedValue);
        ddlSubdivisao.DataTextField = "Subdivisao";
        ddlSubdivisao.DataValueField = "Id";
        ddlSubdivisao.DataSource = dt;
        ddlSubdivisao.DataBind();
        ddlSubdivisao.Items.Insert(0, new ListItem("-- Selecione a Subdivisão --"));
        Pesquisa();
    }
    protected void DropSubdivisao_SelectedIndexChanged(object sender, EventArgs e)
    {
        Pesquisa();
    }
    private void Pesquisa()
    {
        if (ddlDepartamento.Text == "-- Selecione o Departamento --")
        {
            ClientScript.RegisterStartupScript(System.Type.GetType("System.String"), "Alert",
      "<script languaje='javascript'> { window.alert(\"Selecione o Departamento!\") }</script>");
            lblDepartamento.Visible = false;
            pnlImagemDepartamento.Visible = false;
            pnlFotosProduto.Visible = false;
            btnEnviar.Visible = false;
            lblVazio.Visible = false;
            lblVazioProduto.Visible = false;
            return;
        }
        btnEnviar.Visible = true;
        try
        {
            DataTable dt = null;
            pnlVisualizarImagemProduto.Visible = false;

            if (ddlDepartamento.Text != "-- Selecione o Departamento --")
            {
                lblDepartamento.Text = "Departamento: " + ddlDepartamento.SelectedItem;
                lblFotos.Text = "do Departamento:" + ddlDepartamento.SelectedItem;
                lblDepartamento.Visible = true;
                btnEnviar.Visible = true;
                btnEnviar.Text = "Enviar imagens pro Departamento";

                if (ddlSubdivisao.Text != "-- Selecione a Subdivisão --")
                {
                    lblDepartamento.Text = "Departamento: " + ddlDepartamento.SelectedItem + " - SubDivisão: " + ddlSubdivisao.SelectedItem;
                    lblFotos.Text = "da Subdivisão:" + ddlSubdivisao.SelectedItem;
                    lblDepartamento.Visible = true;
                    btnEnviar.Text = "Enviar imagens pra Subdivisão";
                    dt = db.ExecuteReaderQuery(string.Format("SELECT Nome FROM ImagemDepartamento WHERE IdDepartamento = " + ddlDepartamento.SelectedValue + " and IdSubDivisao = " + ddlSubdivisao.SelectedValue));
                    if (dt.Rows.Count == 0)
                    {
                        lblVazio.Visible = true;
                        lblVazio.Text = "*Não existe imagem para esta Subdivisão!";
                        pnlImagemDepartamento.Visible = false;
                    }
                    else
                    {
                        pnlImagemDepartamento.Visible = true;
                        lblVazio.Visible = false;
                    }
                    DataTable dt1 = db.ExecuteReaderQuery("Select P.NomeProduto,P.NumeroPatrimonio from ImagemPatrimonio Ip Join Patrimonio P on P.IdPatrimonio = Ip.IdPatrimonio where Ip.IdDepartamento = " + ddlDepartamento.SelectedValue + " and Ip.IdSubDivisao = " + ddlSubdivisao.SelectedValue + " Group by P.NomeProduto,P.NumeroPatrimonio");
                    if (dt1.Rows.Count > 0)
                    {
                        grdProdutos.DataSource = dt1;
                        grdProdutos.DataBind();
                        pnlFotosProduto.Visible = true;
                        pnlProdutos.Visible = true;
                        lblVazioProduto.Visible = false;
                    }
                    else
                    {
                        pnlFotosProduto.Visible = false;
                        lblVazioProduto.Visible = true;
                        pnlProdutos.Visible = false;
                        lblVazioProduto.Text = "*Não existe nenhum Produto com imagem para esta Subdivisão!";
                    }
                }
                else
                {
                    dt = db.ExecuteReaderQuery(string.Format("SELECT Nome FROM ImagemDepartamento WHERE IdDepartamento = " + ddlDepartamento.SelectedValue + " and IdSubDivisao IS NULL"));
                    if (dt.Rows.Count == 0)
                    {
                        lblVazio.Visible = true;
                        lblVazio.Text = "Não existe imagem para este Departamento!";
                        pnlImagemDepartamento.Visible = false;
                    }
                    else
                    {
                        pnlImagemDepartamento.Visible = true;
                        lblVazio.Visible = false;
                    }
                    DataTable dt1 = db.ExecuteReaderQuery("Select P.NomeProduto,P.NumeroPatrimonio from ImagemPatrimonio Ip Join Patrimonio P on P.IdPatrimonio = Ip.IdPatrimonio where Ip.IdDepartamento = " + ddlDepartamento.SelectedValue + " and Ip.IdSubDivisao=0 Group by P.NomeProduto,P.NumeroPatrimonio");
                    if (dt1.Rows.Count > 0)
                    {
                        grdProdutos.DataSource = dt1;
                        grdProdutos.DataBind();
                        pnlFotosProduto.Visible = true;
                        pnlProdutos.Visible = true;
                        lblVazioProduto.Visible = false;
                    }
                    else
                    {
                        pnlFotosProduto.Visible = false;
                        pnlProdutos.Visible = false;
                        lblVazioProduto.Visible = true;
                        lblVazioProduto.Text = "*Não existe nenhum Produto com imagem para este Departamento!";
                    }
                }
            }
            List<string> xxx = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                xxx.Add(item[0].ToString().ToUpper());
            }

            DirectoryInfo dir = new DirectoryInfo(MapPath("Images\\" + ddlDepartamento.SelectedValue));
            //DirectoryInfo dir = new DirectoryInfo("E:\\inetpub\\wwwroot\\Sicapp\\ArquivosDoc\\arqs\\" + ddlDepartamento.SelectedValue);
            FileInfo[] files = dir.GetFiles();
            // ArrayList listItems = new ArrayList();
            List<imgs> img = new List<imgs>();
            foreach (FileInfo info in files)
            {
                //var q = from query in dt.AsEnumerable()
                //        where query.Field<string>("Arquivo").ToUpper().Contains(info.Name.ToUpper())
                //        select query;
                // if (q.ToList().Count > 0)
                if (!xxx.Contains(info.Name.ToUpper()))
                    xxx.Remove(info.Name.ToUpper());
                // listItems.Add(info);
                //  img.Add(new imgs(Session["Id"].ToString() + "/" + info.Name));

            }
            foreach (string item in xxx)
            {
                img.Add(new imgs(ddlDepartamento.SelectedValue + "/" + item));
            }
            lst.DataSource = img;
            lst.DataBind();
        }
        catch
        {
        }
    }
    protected void grdProdutos_SelectedIndexChanged(object sender, EventArgs e)
    {
        pnlProdutos.Visible = false;
        pnlVisualizarImagemProduto.Visible = true;
        lblProduto.Text = "Produto:" + grdProdutos.Rows[grdProdutos.SelectedIndex].Cells[0].Text;
        lblNumeroPatrimonio.Text = "Nmr. do Patrimônio:" + grdProdutos.Rows[grdProdutos.SelectedIndex].Cells[1].Text;
        DataTable dt = null;
        if (ddlDepartamento.Text != "-- Selecione o Departamento --")
        {
            if (ddlSubdivisao.Text != "-- Selecione a Subdivisão --")
            {
                dt = db.ExecuteReaderQuery(string.Format("SELECT Nome FROM ImagemPatrimonio WHERE NumeroPatrimonio = '" + grdProdutos.Rows[grdProdutos.SelectedIndex].Cells[1].Text + "' and IdDepartamento = " + ddlDepartamento.SelectedValue + " and IdSubDivisao = " + ddlSubdivisao.SelectedValue));
            }
            else
            {
                dt = db.ExecuteReaderQuery(string.Format("SELECT Nome FROM ImagemPatrimonio WHERE NumeroPatrimonio = '" + grdProdutos.Rows[grdProdutos.SelectedIndex].Cells[1].Text + "' and IdDepartamento = " + ddlDepartamento.SelectedValue));
            }
        }
        DataRow dr = dt.Rows[0];
        List<string> xxx = new List<string>();
        foreach (DataRow item in dt.Rows)
        {
            xxx.Add(item[0].ToString().ToUpper());
        }

        DirectoryInfo dir = new DirectoryInfo(MapPath("Images\\" + ddlDepartamento.SelectedValue + "\\FotosPatrimonio\\" + grdProdutos.Rows[grdProdutos.SelectedIndex].Cells[1].Text));
        FileInfo[] files = dir.GetFiles();
        // ArrayList listItems = new ArrayList();
        List<imgs2> img = new List<imgs2>();
        foreach (FileInfo info in files)
        {
            //var q = from query in dt.AsEnumerable()
            //        where query.Field<string>("Arquivo").ToUpper().Contains(info.Name.ToUpper())
            //        select query;
            // if (q.ToList().Count > 0)
            if (!xxx.Contains(info.Name.ToUpper()))
                xxx.Remove(info.Name.ToUpper());
            // listItems.Add(info);
            //  img.Add(new imgs(Session["Id"].ToString() + "/" + info.Name));

        }
        foreach (string item in xxx)
        {
            img.Add(new imgs2(ddlDepartamento.SelectedValue + "\\FotosPatrimonio\\" + grdProdutos.Rows[grdProdutos.SelectedIndex].Cells[1].Text + "/" + item, item));
        }
        lstImagemProduto.DataSource = img;
        lstImagemProduto.DataBind();
    }
    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        pnlProdutos.Visible = true;
        pnlVisualizarImagemProduto.Visible = false;
    }
    protected void lstImagemProduto_ItemCommand(object source, DataListCommandEventArgs e)
    {
        string NomeArquivo = ((HyperLink)e.Item.FindControl("HyperLink1")).Text;
        string nome = ((Label)e.Item.FindControl("Label1")).Text;
        string diretorio = MapPath("Images\\" + nome);
        System.IO.File.Delete(diretorio);

        db.ExecuteNonQuery("DELETE FROM ImagemPatrimonio where Nome = '" + NomeArquivo + "'");
        DataTable dt = null;
        if (ddlDepartamento.Text != "-- Selecione o Departamento --")
        {
            if (ddlSubdivisao.Text != "-- Selecione a Subdivisão --")
            {
                dt = db.ExecuteReaderQuery(string.Format("SELECT Nome FROM ImagemPatrimonio WHERE NumeroPatrimonio = '" + lblNumeroPatrimonio.Text.Remove(0, 19).ToString() + "' and IdDepartamento = " + ddlDepartamento.SelectedValue + " and IdSubDivisao = " + ddlSubdivisao.SelectedValue));
            }
            else
            {
                dt = db.ExecuteReaderQuery(string.Format("SELECT Nome FROM ImagemPatrimonio WHERE NumeroPatrimonio = '" + lblNumeroPatrimonio.Text.Remove(0, 19).ToString() + "' and IdDepartamento = " + ddlDepartamento.SelectedValue));
            }
        }
        List<string> xxx = new List<string>();
        foreach (DataRow item in dt.Rows)
        {
            xxx.Add(item[0].ToString().ToUpper());
        }

        DirectoryInfo dir = new DirectoryInfo(MapPath("Images\\" + ddlDepartamento.SelectedValue + "\\FotosPatrimonio\\" + lblNumeroPatrimonio.Text.Remove(0, 19).ToString()));
        FileInfo[] files = dir.GetFiles();
        // ArrayList listItems = new ArrayList();
        List<imgs2> img = new List<imgs2>();
        foreach (FileInfo info in files)
        {
            //var q = from query in dt.AsEnumerable()
            //        where query.Field<string>("Arquivo").ToUpper().Contains(info.Name.ToUpper())
            //        select query;
            // if (q.ToList().Count > 0)
            if (!xxx.Contains(info.Name.ToUpper()))
                xxx.Remove(info.Name.ToUpper());
            // listItems.Add(info);
            //  img.Add(new imgs(Session["Id"].ToString() + "/" + info.Name));

        }
        foreach (string item in xxx)
        {
            img.Add(new imgs2(ddlDepartamento.SelectedValue + "\\FotosPatrimonio\\" + lblNumeroPatrimonio.Text.Remove(0, 19).ToString() + "/" + item, item));
        }
        lstImagemProduto.DataSource = img;
        lstImagemProduto.DataBind();

        if (dt.Rows.Count > 0)
        {
        }
        else
        {
            if (ddlDepartamento.Text != "-- Selecione o Departamento --")
            {
                if (ddlSubdivisao.Text != "-- Selecione a Subdivisão --")
                {
                    dt = db.ExecuteReaderQuery("Select P.NomeProduto,P.NumeroPatrimonio from ImagemPatrimonio Ip Join Patrimonio P on P.IdPatrimonio = Ip.IdPatrimonio where Ip.IdDepartamento = " + ddlDepartamento.SelectedValue + " and Ip.IdSubDivisao = " + ddlSubdivisao.SelectedValue + " Group by P.NomeProduto,P.NumeroPatrimonio");
                }
                else
                {
                    dt = db.ExecuteReaderQuery("Select P.NomeProduto,P.NumeroPatrimonio from ImagemPatrimonio Ip Join Patrimonio P on P.IdPatrimonio = Ip.IdPatrimonio where Ip.IdDepartamento = " + ddlDepartamento.SelectedValue + " Group by P.NomeProduto,P.NumeroPatrimonio");
                }
                grdProdutos.DataSource = dt;
                grdProdutos.DataBind();
            }
        }
    }
    protected void grdProdutos_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onmouseover"] = "this.style.background='#D1DDF1';";
            if ((e.Row.RowIndex % 2) == 0)
                // if even row      
                e.Row.Attributes["onmouseout"] = "this.style.background='#EFF3FB';";
            else
                // alternate row      
                e.Row.Attributes["onmouseout"] = "this.style.background='White';";

        }
    }
    protected void btnProcurar_Click(object sender, ImageClickEventArgs e)
    {
        DataTable dt = null;
        if (ddlDepartamento.Text != "-- Selecione o Departamento --")
        {
            lblDepartamento.Text = "Departamento: " + ddlDepartamento.SelectedItem;
            lblDepartamento.Visible = true;

            if (ddlSubdivisao.Text != "-- Selecione a Subdivisão --")
            {
                dt = db.ExecuteReaderQuery("Select P.NomeProduto,P.NumeroPatrimonio from ImagemPatrimonio Ip Join Patrimonio P on P.IdPatrimonio = Ip.IdPatrimonio where Ip.IdDepartamento = " + ddlDepartamento.SelectedValue + " and Ip.IdSubDivisao = " + ddlSubdivisao.SelectedValue + " and P.NomeProduto like '%" + txtNomeProduto.Text + "%' Group by P.NomeProduto,P.NumeroPatrimonio");
            }
            else
            {
                dt = db.ExecuteReaderQuery("Select P.NomeProduto,P.NumeroPatrimonio from ImagemPatrimonio Ip Join Patrimonio P on P.IdPatrimonio = Ip.IdPatrimonio where Ip.IdDepartamento = " + ddlDepartamento.SelectedValue + " and P.NomeProduto like '%" + txtNomeProduto.Text + "%' Group by P.NomeProduto,P.NumeroPatrimonio");
            }
            grdProdutos.DataSource = dt;
            grdProdutos.DataBind();
        }
    }
}