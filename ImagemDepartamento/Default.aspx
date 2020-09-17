<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="ImagemDna_Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <span class="auto-style8"><strong>Upload de Imagens do Departamento</strong></span><hr />

    <link rel="stylesheet" type="text/css" href="../style-projects-jquery.css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- Arquivos utilizados pelo jQuery lightBox plugin -->
    <script type="text/javascript" src="Scripts/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="Scripts/jquery.lightbox-0.5.js"></script>
    <link rel="stylesheet" type="text/css" href="Styles/jquery.lightbox-0.5.css" media="screen" />
    <script type="text/javascript">
        $(function () {
            $('#gallery a').lightBox();
            $('#gallery1 a').lightBox();
        });
        Sys.WebForms.PageRequestManager.getInstance().add_initializeRequest(
  function () {
      if (document.getElementById) {
          var progress = document.getElementById('progress');
          var blur = document.getElementById('blur');

          progress.style.width = '300px';
          progress.style.height = '30px';
          blur.style.height = document.documentElement.clientHeight;
          progress.style.top = document.documentElement.clientHeight / 3 - progress.style.height.replace('px', '') / 2 + 'px';
          progress.style.left = document.body.offsetWidth / 2 - progress.style.width.replace('px', '') / 2 + 'px';
      }
  }
)
        function divexpandcollapse(divname) {
            var img = "img" + divname;
            if ($("#" + img).attr("src") == "plus.png") {
                $("#" + img)
    .closest("tr")
    .after("<td></td><tr><td colspan = '100%'>" + $("#" + divname)
    //.after("<tr><td></td><td colspan = '100%'>" + $("#" + divname)
    .html() + "</td></tr>");
                $("#" + img).attr("src", "minus.png");
            } else {
                $("#" + img).closest("tr").next().remove();
                $("#" + img).attr("src", "plus.png");
            }
        }
    </script>
    <style type="text/css">
        /* jQuery lightBox plugin - Gallery style */
        #gallery {
            background-color: #FFFFFF;
            padding: 2px;
            width: 100%;
            /*height: 185px;*/
        }

            #gallery ul {
                list-style: none;
            }

                #gallery ul li {
                    display: inline;
                }

                #gallery ul img {
                    border: 1px solid #3e3e3e;
                    border-width: 5px 5px 20px;
                }

                #gallery ul a:hover img {
                    border: 1px solid #fff;
                    border-width: 5px 5px 20px;
                    color: #fff;
                }

                #gallery ul a:hover {
                    color: #fff;
                }

        #gallery1 {
            background-color: #FFFFFF;
            padding: 2px;
            width: 100%;
            /*height: 185px;*/
        }

            #gallery1 ul {
                list-style: none;
            }

                #gallery1 ul li {
                    display: inline;
                }

                #gallery1 ul img {
                    border: 1px solid #3e3e3e;
                    border-width: 5px 5px 20px;
                }

                #gallery1 ul a:hover img {
                    border: 1px solid #fff;
                    border-width: 5px 5px 20px;
                    color: #fff;
                }

                #gallery1 ul a:hover {
                    color: #fff;
                }

        .auto-style2 {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #727272;
        }

        .auto-style4 {
            width: 185px;
            height: 28px;
        }

        .auto-style5 {
            width: 260px;
            height: 28px;
        }

        .auto-style6 {
            width: 166px;
            height: 28px;
        }

        .auto-style7 {
            width: 100%;
            -webkit-border-radius: 10px;
            border-radius: 10px;
            height: 100px;
            background-color: #dcdcdc;
        }

        .auto-style8 {
            font-size: large;
            font-weight: normal;
        }

        .auto-style9 {
            width: 100%;
            height: 11px;
        }

        .auto-style10 {
            font-size: medium;
        }

        .blockScreen {
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: pink;
            z-index: 9999999;
        }

        #blur {
            /*width: 100%;
            background-color: black;
            moz-opacity: 0.5;
            khtml-opacity: .5;
            opacity: .5;
            filter: alpha(opacity=50);
            z-index: 120;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;*/
        }

        #progress {
            z-index: 200;
            /*background-color: White;*/
            position: absolute;
            top: 50%;
            left: 50%;
            margin-top: -50px;
            margin-left: -50px;
            /*border: solid 1px black;*/
            padding: 5px 5px 5px 5px;
            text-align: center;
            vertical-align: central;
        }

        .auto-style12 {
            font-size: medium;
            margin-top: 5px;
        }

        .myButton {
            -moz-box-shadow: inset 0px 1px 0px 0px #ffffff;
            -webkit-box-shadow: inset 0px 1px 0px 0px #ffffff;
            box-shadow: inset 0px 1px 0px 0px #ffffff;
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #dfdfdf));
            background: -moz-linear-gradient(top, #ededed 5%, #dfdfdf 100%);
            background: -webkit-linear-gradient(top, #ededed 5%, #dfdfdf 100%);
            background: -o-linear-gradient(top, #ededed 5%, #dfdfdf 100%);
            background: -ms-linear-gradient(top, #ededed 5%, #dfdfdf 100%);
            background: linear-gradient(to bottom, #ededed 5%, #dfdfdf 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#dfdfdf',GradientType=0);
            background-color: #ededed;
            -moz-border-radius: 6px;
            -webkit-border-radius: 6px;
            border-radius: 6px;
            border: 1px solid #dcdcdc;
            display: inline-block;
            cursor: pointer;
            color: #000000;
            font-family: arial;
            font-size: 15px;
            font-weight: bold;
            padding: 6px 24px;
            text-decoration: none;
            text-shadow: 0px 1px 0px #ffffff;
        }

            .myButton:hover {
                background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #dfdfdf), color-stop(1, #ededed));
                background: -moz-linear-gradient(top, #dfdfdf 5%, #ededed 100%);
                background: -webkit-linear-gradient(top, #dfdfdf 5%, #ededed 100%);
                background: -o-linear-gradient(top, #dfdfdf 5%, #ededed 100%);
                background: -ms-linear-gradient(top, #dfdfdf 5%, #ededed 100%);
                background: linear-gradient(to bottom, #dfdfdf 5%, #ededed 100%);
                filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf', endColorstr='#ededed',GradientType=0);
                background-color: #dfdfdf;
            }

            .myButton:active {
                position: relative;
                top: 1px;
            }

        .auto-style13 {
        }

        .auto-style14 {
            font-size: medium;
        }

        .auto-style16 {
            width: 440px;
        }

        .auto-style17 {
            font-size: medium;
         
        }
        .auto-style23 {
            text-align:left;
        }
        .auto-style25 {
            width: 359px;
        }
        .auto-style26 {}
        .auto-style27 {
            text-align: left;
            width: 127px;
        }
        .auto-style28 {
            height: 28px;
        }
    </style>

    <%--   <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="main">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                    <ProgressTemplate>
                        <div id="blur">&nbsp;</div>
                        <div id="progress">

                            <asp:ImageButton ID="imgCar" runat="server" ImageUrl="~/Images/carregando.gif" />

                        </div>


                    </ProgressTemplate>

                </asp:UpdateProgress>
            </div>--%>

    <table class="auto-style2" id="tab">
        <tr>
            <td class="auto-style4">&nbsp; Selecione o Departamento: </td>
            <td class="auto-style5">
                <asp:DropDownList ID="ddlDepartamento" runat="server" AutoPostBack="True" Height="26px" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged" Width="100%">
                </asp:DropDownList>
            </td>
            <td class="auto-style6"><strong>Selecione a Subdivisão:</strong></td>
            <td class="auto-style5">
                <asp:DropDownList ID="ddlSubdivisao" runat="server" Height="26px" Width="100%" OnSelectedIndexChanged="DropSubdivisao_SelectedIndexChanged" AutoPostBack="True">
                </asp:DropDownList>
            </td>
            <td class="auto-style28"></td>
        </tr>
    </table>
    <br />
    <asp:Label ID="lblDepartamento" runat="server" Text="Label" CssClass="auto-style12" Visible="False"></asp:Label>
    <br />
    <asp:Label ID="lblVazioProduto" runat="server" Text="*Não existe imagem" ForeColor="Red" Visible="False" Style="font-size: medium"></asp:Label>
    <asp:Panel ID="pnlFotosProduto" runat="server" Visible="False">
        <table class="auto-style9">
            <tr>
                <td class="auto-style17">Produto(s) com Foto(s)<div style="width: 50%; height: 1px; background-color: #9c9c9c">&nbsp;</div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlProdutos" runat="server" Visible="true">

                        <table style="width: 100%">
                            <tr>
                                <td class="auto-style27">&nbsp; Nome do Produto:</td>
                                <td class="auto-style25">
                                    <asp:TextBox ID="txtNomeProduto" runat="server" Width="100%" Height="15px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ID="btnProcurar" runat="server" BackColor="Transparent" BorderColor="Transparent" ImageUrl="~/Images/search_icon.png" CssClass="auto-style26" Height="32px" OnClick="btnProcurar_Click" Width="32px" />
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style23" colspan="3">
                                    <div style="background-color: #428bca; height: 30px; width: 100%; margin: 0; padding: 0">
                                        <table id="tblHeader" border="1" cellpadding="0" cellspacing="0" rules="all" style="font-family: Arial; font-size: 10pt; width: 686px; color: white; border-collapse: collapse; height: 100%;">
                                            <tr>
                                                <td class="auto-style16" style="text-align: left">Nome do Produto</td>
                                                <td style="width: 150px; text-align: left">Nmr. do Patrimônio</td>
                                                <td style="width: 150px; text-align: center"></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:Panel ID="pnlScroll" runat="server" ScrollBars="Vertical" Height="149px" BackColor="White" CssClass="auto-style13">
                            <asp:GridView ID="grdProdutos" runat="server" ShowHeader="false" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" OnSelectedIndexChanged="grdProdutos_SelectedIndexChanged" OnRowDataBound="grdProdutos_RowDataBound">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:BoundField DataField="NomeProduto" HeaderText="Produto" ItemStyle-Width="350px">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NumeroPatrimonio" HeaderText="Nmr. do Patrimonio" ItemStyle-Width="150px">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:CommandField SelectText="Visualizar Imagens" ShowSelectButton="True" />

                                </Columns>
                                <EditRowStyle BackColor="#2461BF" />
                                <FooterStyle BackColor="#428bca" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#428bca" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#EFF3FB" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                <EmptyDataTemplate>Nenhum produto com Imagem encontrado.</EmptyDataTemplate>
                            </asp:GridView>
                        </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        
                    </asp:Panel>
                    <asp:Panel ID="pnlVisualizarImagemProduto" runat="server" Visible="False">
                        <asp:Label ID="lblProduto" runat="server" CssClass="auto-style12" Text="Label"></asp:Label>
                        <span class="auto-style10">&nbsp; -&nbsp; </span>
                        <asp:Label ID="lblNumeroPatrimonio" runat="server" CssClass="auto-style14" Text="Label"></asp:Label>
                        <br />
                        <asp:Button ID="btnVoltar" runat="server" CssClass="myButton" Height="31px" OnClick="btnVoltar_Click" Text="Voltar" />
                        <br />
                        <div id="gallery1">
                            <asp:DataList ID="lstImagemProduto" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" OnItemCommand="lstImagemProduto_ItemCommand" OnSelectedIndexChanged="Button1_Click">
                                <ItemTemplate>
                                    <table class="auto-style7" id="tab">
                                        <tr>
                                            <td>&nbsp;
                                    <br />
                                                &nbsp;
                                    <asp:Image ID="Image1" runat="server" Height="88px" ImageUrl='<%# Bind("Name", "images/{0}") %>' Width="95px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;
                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Bind("Name", "images/{0}") %>' Text='<%# Bind("NomeImagem") %>' />
                                                <asp:Label ID="Label1" runat="server" Visible="False" Text='<%# Bind("Name") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="ImageButton1" runat="server" BackColor="Transparent" BorderColor="Transparent" ImageUrl="~/Images/Botao_Excluir.png" OnClientClick="return confirm('Confirma a exclusão desta imagem?');" Text="Apagar Imagem" />
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" />
                            </asp:DataList>
                            <br />
                        </div>
                    </asp:Panel>
                </td>
            </tr>
        </table>

    </asp:Panel>

    <br />
    <asp:Label ID="lblVazio" runat="server" Text="*Não existe imagem" ForeColor="Red" Visible="False" Style="font-size: medium"></asp:Label>

    <br />
                    <asp:LinkButton ID="btnEnviar" runat="server" OnClick="LinkButton1_Click" Visible="False">Enviar imagens</asp:LinkButton>

    <br />

    <asp:Panel ID="pnlImagemDepartamento" runat="server" Visible="False">
        <table class="auto-style9">
            <tr>
                <td class="auto-style10">Foto(s)
                    <asp:Label ID="lblFotos" runat="server" Text="Label"></asp:Label>
                    <div style="width: 50%; height: 1px; background-color: #9c9c9c">
                        &nbsp;</div>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="gallery">
                        <asp:DataList ID="lst" runat="server" OnItemCommand="DataList1_ItemCommand" OnSelectedIndexChanged="Button1_Click" RepeatColumns="5" RepeatDirection="Horizontal">
                            <ItemTemplate>
                                <table id="tab" class="auto-style7">
                                    <tr>
                                        <td>&nbsp;
                                                            <br />
                                            &nbsp;
                                                            <asp:Image ID="Image1" runat="server" Height="88px" ImageUrl='<%# Bind("Name", "images/{0}") %>' Width="95px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;
                                                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Bind("Name", "images/{0}") %>' Text='<%# Bind("Name") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:ImageButton ID="ImageButton1" runat="server" BackColor="Transparent" BorderColor="Transparent" ImageUrl="~/Images/Botao_Excluir.png" OnClientClick="return confirm('Confirma a exclusão desta imagem?');" Text="Apagar Imagem" />
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" />
                        </asp:DataList>
                        <br />
                    </div>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <br />

</asp:Content>

