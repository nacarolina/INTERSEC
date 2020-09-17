<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Register.CityHall.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="../../Styles/forms-styles.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h4><%= Resources.Resource.cadastroCliente %></h4>
    <hr />
    <asp:Panel ID="Panel1" runat="server">
        <%= Resources.Resource.nome %>:<br />
        <div class="input-group">
            <asp:TextBox ID="txtPrefeitura" CssClass="form-control" runat="server"></asp:TextBox>
            <span class="input-group-btn">
                <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" OnClick="btnFind_Click"><i class="fas fa-search"></i></asp:LinkButton>
                <asp:LinkButton ID="btnCadastrarNovo" runat="server" OnClick="btnCadastrarNovo_Click" CssClass="btn btn-success"><i class="fas fa-plus"></i></asp:LinkButton>
            </span>
        </div>
    </asp:Panel>
    <br />
    <small class="text-muted">* <%= Resources.Resource.lista %> <%= Resources.Resource.cliente %></small>
    <hr />
    <asp:GridView ID="GridDetalhe" runat="server" CssClass="table table-bordered table-striped table-hover" AutoGenerateColumns="False" OnRowDataBound="GridDetalhe_RowDataBound" OnSelectedIndexChanged="GridDetalhe_SelectedIndexChanged" AllowPaging="True" OnPageIndexChanging="GridDetalhe_PageIndexChanging" GridLines="Horizontal">
        <Columns>
            <asp:BoundField DataField="Prefeitura" HeaderText="<%$ Resources:Resource, cliente %>" />
            <asp:BoundField DataField="Endereco" HeaderText="<%$ Resources:Resource, endereco %>" />
            <asp:BoundField DataField="Site" HeaderText="Site" />
            <asp:BoundField DataField="Telefone" HeaderText="<%$ Resources:Resource, telefone %>" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Responsavel" HeaderText="<%$ Resources:Resource, responsavel %>" />
            <asp:BoundField DataField="PortaReset" HeaderText="Porta Reset" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("Id","register.aspx?Id={0}") %>' CssClass="btn btn-primary"><i class="fas fa-edit"></i></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate><%= Resources.Resource.naoHaRegistros %></EmptyDataTemplate>
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle BackColor="White" ForeColor="Black" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="White" ForeColor="Black" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>
    <table>
        <tr>
            <td>
                <br />
                <asp:Label ID="lblRegistro" runat="server" Style="text-align: center; color: #000000;" Text="<%= Resources.Resource.naoHaRegistros %>" Visible="False"></asp:Label>
                <asp:ObjectDataSource ID="dsRoles" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetRoles" TypeName="infortronics.User"></asp:ObjectDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
