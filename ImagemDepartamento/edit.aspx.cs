using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ImagemDna_edit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string Id = Request.QueryString["img"];
            if (Id == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }
            img1.ImageUrl = "Images/" + Request.QueryString["img"];
        }
    }
    protected void cmdRotacionar_Click(object sender, ImageClickEventArgs e)
    {
    //    System.Web.UI.WebControls.Image
        if (img1.Attributes["class"] == null)
            img1.Attributes["class"] = "rotacionar90";
        else if
            (img1.Attributes["class"].Equals("rotacionar90")) img1.Attributes["class"] = "rotacionar180";
        else if
            (img1.Attributes["class"].Equals("rotacionar180")) img1.Attributes["class"] = "rotacionar270";
        else if
            (img1.Attributes["class"].Equals("rotacionar270")) img1.Attributes["class"] = "rotacionar0";
        else if (img1.Attributes["class"].Equals("rotacionar0")) img1.Attributes["class"] = "rotacionar90";
        else
            img1.Attributes["class"] = "rotacionar90";


    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        return;
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(Server.MapPath(img1.ImageUrl));
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        System.Drawing.Image img = System.Drawing.Image.FromStream(response.GetResponseStream());
        img.Save(Server.MapPath(img1.ImageUrl)); 
    }
}