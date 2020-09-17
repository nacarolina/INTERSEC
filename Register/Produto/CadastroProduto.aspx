<%@ Page Title="" Language="C#" MasterPageFile="" AutoEventWireup="true" CodeBehind="CadastroProduto.aspx.cs" Inherits="GwCentral.Register.Produto.CadastroProduto" %>
     
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
  
    <%--<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />--%>

    <%--<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />--%>
    <style type="text/css">
        .modalBackground {
            background-color: Gray;
            filter: alpha(opacity=70);
            opacity: 0.7;
        }

        .modalPopup {
            background-color: #ffffdd;
            border-width: 3px;
            border-style: solid;
            border-color: Gray;
            padding: 3px;
            width: 250px;
        }

            .modalPopup p {
                padding: 5px;
            }

        /*.auto-style8 {
            width: 120px;
            height: 44px;
        }

        .auto-style9 {
            height: 44px;
            width: 323px;
        }

        .auto-style11 {
            width: 323px;
        }

        .auto-style12 {
            color: white;
        }

        .auto-style13 {
            width: 232px;
        }

        .auto-style14 {
            width: 235px;
        }

        .auto-style15 {
            width: 141px;
        }

        .auto-style16 {
            width: 141px;
            height: 44px;
        }

        .auto-style17 {
            width: 395px;
        }*/
        .auto-style1 {
            width: 121px;
        }

        .auto-style2 {
            width: 128px;
        }

        .auto-style3 {
            width: 250px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    Cadastro de Produto
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel runat="server" Style="margin-bottom: 10px; border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; width: 900px; border-color: #f4f4f4;">
        <asp:Panel ID="Panel1" runat="server">
            <table style="margin-bottom: 10px; border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; border-color: #f4f4f4; width: 100%;">
                <tr style="border-bottom: 1px solid #d8d8d8; height: 60px;">
                    <td class="auto-style2">
                        <asp:Label ID="lblNmSerie" runat="server" Text="Número de Série:"></asp:Label>
                    </td>
                    <td class="auto-style3">
                        <asp:TextBox ID="txtNmrSerie" CssClass="form-control" runat="server" Width="212px"></asp:TextBox>
                    </td>
                    <td style="padding-left: 5px;" class="auto-style1">
                        <asp:Label ID="Label1" runat="server" Text="Nome do Produto:"></asp:Label>

                    </td>
                    <td style="width: 220px; margin-right: 1000px;">
                        <asp:TextBox ID="txtProduto" CssClass="form-control" runat="server" Width="212px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:ImageButton ID="ImgPesquisar" runat="server" ImageUrl="~/Images/search.png" OnClick="ImgPesquisar_Click" Height="28px" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="PanelDados" runat="server">
            <table style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 100%; border-color: transparent;">
                <tr style="margin-left: 10px; border-bottom: 1px solid #d8d8d8; height: 60px; margin-right: 10px;">
                    <td style="width: 150px;">Marca:
                    </td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txtMarca" runat="server" Width="263px" CssClass="form-control"></asp:TextBox>
                    </td>
                    <td class="auto-style11">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMarca" ErrorMessage="Preencha o Campo Marca!" ForeColor="Red" ValidationGroup="cad"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="margin-left: 10px; border-bottom: 1px solid #d8d8d8; height: 60px; margin-right: 10px;">
                    <td style="width: 150px;">Modelo:
                    </td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txtModelo" runat="server" Width="263px" CssClass="form-control"></asp:TextBox>

                    </td>
                    <td class="auto-style11">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtModelo" ErrorMessage="Preencha o Campo Modelo!" ForeColor="Red" ValidationGroup="cad"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="margin-left: 10px; border-bottom: 1px solid #d8d8d8; height: 60px; margin-right: 10px;">
                    <td style="width: 150px;">Tipo de Unidade:
                    </td>
                    <td class="auto-style9">
                        <asp:DropDownList ID="DropTipoUni" runat="server" onchange="return ValidaUnidade()" Height="30px" Width="268px" CssClass="form-control">
                            <asp:ListItem>Selecione o Tipo de Unidade</asp:ListItem>
                            <asp:ListItem>UNIDADE</asp:ListItem>
                            <asp:ListItem>KILOGRAMO</asp:ListItem>
                            <asp:ListItem>LITRO</asp:ListItem>
                            <asp:ListItem>GRAMO</asp:ListItem>
                            <asp:ListItem>FARDO</asp:ListItem>
                            <asp:ListItem>METRO</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style9">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DropTipoUni" ErrorMessage="Preencha o Campo Tipo de Unidade!" ForeColor="Red" InitialValue="Selecione o Tipo de Unidade " ValidationGroup="cad"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="margin-left: 10px; border-bottom: 1px solid #d8d8d8; height: 60px; margin-right: 10px;">
                    <td style="width: 150px;">Volume:
                    </td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txtVolume" runat="server" Width="263px" CssClass="form-control"></asp:TextBox>

                    </td>
                    <td class="auto-style11">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtVolume" ClientIDMode="Static" ErrorMessage="Preencha o Campo Volume!" ForeColor="Red" ValidationGroup="cad"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="margin-left: 10px; border-bottom: 1px solid #d8d8d8; height: 60px; margin-right: 10px;">
                    <td style="width: 150px;">Tipo do Produto:
                    </td>
                    <td class="auto-style11">
                        <asp:DropDownList ID="DropTipoProduto" runat="server" CssClass="form-control" Width="268px" Height="30px" AutoPostBack="True" OnSelectedIndexChanged="DropTipoProduto_SelectedIndexChanged"></asp:DropDownList>
                        <%--<asp:Button ID="btnAdcTipoProduto" runat="server" class="myButton" Font-Bold="True" Text="+" ToolTip="Adicionar novo Tipo de Produto!" Width="32px" OnClick="btnAdcTipoProduto_Click" />--%>
                    </td>
                    <td class="auto-style11">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="DropTipoProduto" ErrorMessage="Preencha o Campo Tipo do Produto!" ForeColor="Red" ValidationGroup="cad"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="margin-left: 10px; border-bottom: 1px solid #d8d8d8; height: 60px; margin-right: 10px;">
                    <td style="width: 150px;">Categoria:
                    </td>
                    <td class="auto-style11">
                        <asp:DropDownList ID="DropCategoria" runat="server" Width="268px" Height="30px" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="DropCategoria_SelectedIndexChanged"></asp:DropDownList>
                        <%--<asp:Button ID="btnAdcCategoria" runat="server" class="myButton" Font-Bold="True" Text="+" ToolTip="Adicionar nova Categoria!" Width="32px" OnClick="btnAdcCategoria_Click" />--%>
                    </td>
                    <td class="auto-style11">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="DropCategoria" ErrorMessage="Preencha o Campo Categoria!" ForeColor="Red" InitialValue="Selecione a Categoria" ValidationGroup="cad"></asp:RequiredFieldValidator>
                    </td>

                </tr>
                <tr style="margin-left: 10px; border-bottom: 1px solid #d8d8d8; height: 60px; margin-right: 10px;">
                    <td style="width: 150px;">Fabricante:
                    </td>
                    <td class="auto-style11">
                        <asp:DropDownList ID="DropFabricante" runat="server" Width="268px" Height="30px" CssClass="form-control"></asp:DropDownList>
                        <%--<asp:Button ID="btnAdcFabricante" runat="server" class="myButton" Font-Bold="True" OnClick="btnAdcFabricante_Click" Text="+" ToolTip="Adicionar novo Fabricante!" Width="32px" />--%>
                    </td>
                    <td class="auto-style11">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="DropFabricante" ErrorMessage="Preencha o Campo Fabricante!" ForeColor="Red" ValidationGroup="cad"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="pnlControlador" Visible="false" runat="server" Height="350px" ScrollBars="Vertical">
                <h4>Selecione os Controladores da Placa</h4>
                <br />
                <asp:GridView ID="grdControlador" DataKeyNames="Id" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" AutoGenerateColumns="False" Width="100%">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="chk" runat="server" Width="15px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome" />
                        <asp:BoundField DataField="Marca" HeaderText="Marca" SortExpression="Marca" />
                        <asp:BoundField DataField="Modelo" HeaderText="Modelo" SortExpression="Modelo" />
                    </Columns>
                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                    <HeaderStyle BackColor="#444956" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                    <%--<SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />--%>
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#242121" />
                </asp:GridView>
            </asp:Panel>
        </asp:Panel>
        <table>
            <tr style="height: 50px;">
                <td>
                    <asp:Button ID="btnCadastrar" runat="server" Text="Novo" Width="180px" OnClick="btnCadastrar_Click" ValidationGroup="cad" />
                </td>
                <td>
                    <asp:Button ID="btnExcluir" runat="server" Text="Excluir"  Width="180px" OnClick="btnExcluir_Click" />
                </td>
                <td>
                    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" Width="180px" OnClick="btnCancelar_Click" EnableClientScript = "False" />
           
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:GridView ID="grdProduto" runat="server" Width="100%" Style="border: 1px solid darkgray;" AutoGenerateColumns="False" CellPadding="4" GridLines="Horizontal" DataKeyNames="Id" OnSelectedIndexChanged="grdProduto_SelectedIndexChanged" OnSelectedIndexChanging="grdProduto_SelectedIndexChanging" ForeColor="Black" OnRowDataBound="grdProduto_RowDataBound" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
        <Columns>
            <asp:BoundField DataField="NomeProduto" HeaderText="Nome">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="marca" HeaderText="Marca">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="modelo" HeaderText="Modelo">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="NumeroSerie" HeaderText="Número de série">
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:CommandField SelectText="Selecionar" ShowSelectButton="True" />
        </Columns>
        <EmptyDataTemplate>
            Não há registros!
        </EmptyDataTemplate>
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle BackColor="#444956" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <%--<SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />--%>
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>

    <asp:Button runat="server" ID="Button7" Style="display: none;" />
    <ajaxToolkit:ModalPopupExtender ID="mpMsg" runat="server" BackgroundCssClass="modalBackground"
        CancelControlID="ImageButton2" DropShadow="true" PopupControlID="pnlMensagem"
        PopupDragHandleControlID="Panel2"
        TargetControlID="Button7">
    </ajaxToolkit:ModalPopupExtender>

    <asp:Panel ID="pnlMensagem" runat="server" BackColor="White">

        <asp:Panel runat="Server" ID="Panel2"
            Style="cursor: move; background-color: #444956; border: solid 1px Gray; color: Black; text-align: left;" Width="100%">
            <table style="height: 21px; width: 100%">
                <tr style="border-bottom-style: solid; border-width: thin; border-bottom-color: #444956">
                    <td style="margin-left: 10px; padding-left: 10px;" class="auto-style4">
                        <strong><span><span class="auto-style8">&nbsp;<span class="auto-style12">Atenção!</span></span><span class="auto-style24"> </span></span></strong>
                    </td>
                    <td align="right" style="text-align: right; margin-right: 0px; padding-right: 0px;" class="auto-style4">
                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/close24.png"
                            ImageAlign="Right" BackColor="#4CA2BF" BorderColor="#4CA2BF" Width="16px" Height="16px" />&nbsp;
                    </td>
                </tr>

            </table>
        </asp:Panel>

        <table style="padding-left: 10px; padding-right: 10px">
            <tr>
                <td>
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red" Text="Label" Style="color: #000000"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
     <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>--%>
    <%--<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>--%>
    <%--<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>--%>
    
    <script type="text/javascript">

        function ValidaUnidade() {
            var ddlTipoUnidade = $("#<%= DropTipoUni.ClientID%>").val();
            if (ddlTipoUnidade == "UNIDADE") {
                var t = document.getElementById('<%=txtVolume.ClientID%>');
                document.getElementById('<%=txtVolume.ClientID%>').disabled = true;
                t.value = '1';
            }
            else {
                document.getElementById('<%=txtVolume.ClientID%>').value = '';
                document.getElementById('<%=txtVolume.ClientID%>').disabled = false;
            }
        }
        function IniciaPagina() {
            //ValidaUnidade();
        }
    </script>
</asp:Content>
