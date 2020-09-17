using Infortronics;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dna_Imagem : System.Web.UI.Page
{
    Banco db = new Banco();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (AjaxFileUpload1.IsInFileUploadPostBack)
        {
            // do for ajax file upload partial postback request
        }
        else if (Request.QueryString["preview"] == "1" && !string.IsNullOrEmpty(Request.QueryString["fileId"]))
        {
            var fileId = Request.QueryString["fileId"];
            string fileContentType = null;
            byte[] fileContents = null;


            fileContents = (byte[])Session["fileContents_" + fileId];
            fileContentType = (string)Session["fileContentType_" + fileId];

            if (fileContents != null)
            {
                Response.Clear();
                Response.ContentType = fileContentType;
                Response.BinaryWrite(fileContents);
                Response.End();
            }

        }
        else if (!IsPostBack)
        {
            string Id = Request.QueryString["Id"];
            Id = "23";
            Session["Id"] = Id;
            if (Id == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }
            else
            {
                lblId.Text = Id;
                lblDna.Text = db.ExecuteScalarQuery(string.Format(@"SELECT Cruzamento FROM DNA WHERE Id={0}", Id));
                BindDataList();
            }
        }

    }
    protected void BindDataList()
    {
        lstData.DataSource = db.ExecuteReaderQuery(
            string.Format("SELECT DISTINCT CONVERT(VARCHAR(10), DtHr, 103) DtHr FROM ImagemDna WHERE IdDna={0} ORDER BY CONVERT(VARCHAR(10), DtHr, 103) DESC", lblId.Text));
        lstData.DataBind();
        Session["Id"] = lblId.Text;
    }
    protected void lstData_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            string dthr = ((Label)e.Item.FindControl("lblData")).Text;
            DataList lst = ((DataList)e.Item.FindControl("dtlist"));
            DataTable dt = db.ExecuteReaderQuery(string.Format("SELECT Arquivo FROM ImagemDna WHERE IdDna={0} AND DtHr='{1}'", lblId.Text, dthr));
            DirectoryInfo dir = new DirectoryInfo(MapPath("Images"));
            FileInfo[] files = dir.GetFiles();
            ArrayList listItems = new ArrayList();
            foreach (FileInfo info in files)
            {
                var q = from query in dt.AsEnumerable()
                        where query.Field<string>("Arquivo").Contains(info.Name)
                        select query;
                if (q.ToList().Count > 0)
                    listItems.Add(info);
            }
            lst.DataSource = listItems;
            lst.DataBind();
        }
        catch
        {

        }
    }




    protected void AjaxFileUpload1_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs file)
    {
        // User can save file to File System, database or in session state
        if (file.ContentType.ToLower().Contains("jpg") || file.ContentType.ToLower().Contains("gif")
            || file.ContentType.ToLower().Contains("png") || file.ContentType.ToLower().Contains("jpeg"))
        {


            // Limit preview file for file equal or under 4MB only, otherwise when GetContents invoked
            // System.OutOfMemoryException will thrown if file is too big to be read.
            if (file.FileSize <= 1024 * 1024 * 4)
            {
                Session["fileContentType_" + file.FileId] = file.ContentType;
                Session["fileContents_" + file.FileId] = file.GetContents();

                // Set PostedUrl to preview the uploaded file.         
                file.PostedUrl = string.Format("?preview=1&fileId={0}", file.FileId);
            }
            else
            {
                file.PostedUrl = "fileTooBig.gif";
            }

            // Since we never call the SaveAs method(), we need to delete the temporary fileß
            // file.DeleteTemporaryData();



            string f = Session["Id"].ToString().PadLeft(4, '0') + ".jpg";
            string path = Server.MapPath("Images/") + f;
            int p = 1;
            while (File.Exists(path))
            {
                f = Session["Id"].ToString().PadLeft(4, '0') + "-" + p.ToString() + ".jpg";
                path = Server.MapPath("Images/") + f;

                p++;
            }
            AjaxFileUpload1.SaveAs(path);
            db.ExecuteNonQuery(string.Format(@"INSERT INTO [ImagemDna] ([IdDna],[DtHr],[Arquivo])
VALUES ({0},'{1}','{2}')", Session["Id"], DateTime.Now.ToString("dd/MM/yyyy"), f));
          //  BindDataList();
        }
    }



    protected void AjaxFileUpload1_UploadCompleteAll(object sender, AjaxControlToolkit.AjaxFileUploadCompleteAllEventArgs e)
    {

        var startedAt = (DateTime)Session["uploadTime"];
        var now = DateTime.Now;
        e.ServerArguments = new JavaScriptSerializer()
            .Serialize(new
            {
                duration = (now - startedAt).Seconds,
                time = DateTime.Now.ToShortTimeString()
            });

    }
    protected void AjaxFileUpload1_UploadStart(object sender, AjaxControlToolkit.AjaxFileUploadStartEventArgs e)
    {
        var now = DateTime.Now;
        e.ServerArguments = now.ToShortTimeString();
        Session["uploadTime"] = now;
    }


}