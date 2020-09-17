<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Admin.UserChangePass.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h4 style="padding:5px;"><i class="fas fa-user-edit"></i> <%= Resources.Resource.editar %> <%= Resources.Resource.usuario %></h4>

    <table class="table table-condensed" style="width:400px;">
        <tr>
            <td style="width: 144px;">
                <%= Resources.Resource.usuario %>:
                <asp:TextBox ID="txtUser" Width="400px" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 144px;">
                <%= Resources.Resource.novaSenha %>:
                <asp:TextBox ID="txtNovaSenha" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ControlToValidate="txtNovaSenha" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" SetFocusOnError="True" Style="font-size: small"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 144px;">
                <%= Resources.Resource.redigiteNovaSenha %>:
                <asp:TextBox ID="txtConfirmaSenha" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server" ControlToValidate="txtConfirmaSenha" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" SetFocusOnError="True" Style="font-size: small"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtNovaSenha" ControlToValidate="txtConfirmaSenha" ErrorMessage="<%$ Resources:Resource, senhaInvalida %>" ForeColor="Red" Style="font-size: small"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 136px;" colspan="2">
                <asp:Button ID="btnSalvar" runat="server" Font-Size="Medium" CssClass="btn btn-success" OnClick="btnSalvar_Click1" Text="<%$ Resources:Resource, salvar %>" Width="120px" />
            </td>
        </tr>
    </table>
</asp:Content>
