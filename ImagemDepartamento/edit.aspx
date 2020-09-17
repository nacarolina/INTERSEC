<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="edit.aspx.cs" Inherits="ImagemDna_edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .rotacionar270 {
            -webkit-transform: rotate(270deg);
            -moz-transform: rotate(270deg);
            filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=3);
            -ms-transform: rotate(270deg);
        }

        .rotacionar180 {
            -webkit-transform: rotate(180deg);
            -moz-transform: rotate(180deg);
            filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=1);
            -ms-transform: rotate(180deg);
        }

        .rotacionar90 {
            -webkit-transform: rotate(90deg);
            -moz-transform: rotate(90deg);
            filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=2);
            -ms-transform: rotate(90deg);
        }

        .rotacionar0 {
            -webkit-transform: rotate(0deg);
            -moz-transform: rotate(0deg);
            filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=0);
            -ms-transform: rotate(0deg);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <table align="center">
        <tr>
            <td>
                <div align="center" style="text-align: center;">

                    <asp:ImageButton ImageUrl="~/Images/turn48.png" ID="cmdRotacionar" OnClick="cmdRotacionar_Click" runat="server" />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="divImagem" runat="server">
                    &nbsp;<asp:Image ID="img1" runat="server" />
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Salvar" /></td>
        </tr>
    </table>

</asp:Content>

