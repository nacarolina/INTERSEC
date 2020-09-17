<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LocaisGruposSemaforicos.aspx.cs" Inherits="GwCentral.Register.Dna.LocaisGruposSemaforicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <%--<title><%= Resources.Resource.locaisGruposSemaforicos %></title>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />--%>

    <style>
        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            overflow-x: hidden;
            width: 300px;
            background-color: #ffffff;
            cursor: pointer;
        }

        .loading {
            position: absolute;
            background: #fff;
            width: 150px;
            height: 150px;
            border-radius: 100%;
            border: 10px solid #00acff;
            z-index: 10;
            padding-top: 52px;
            font-size: large;
            color: #00a7f7;
        }

            .loading:after {
                content: '';
                background: trasparent;
                width: 140%;
                height: 140%;
                position: absolute;
                border-radius: 100%;
                top: -20%;
                left: -20%;
                opacity: 1.7;
                box-shadow: rgb(0, 172, 255) -4px -5px 3px -3px;
                animation: rotate 2s infinite linear;
            }

        @keyframes rotate {
            0% {
                transform: rotateZ(0deg);
            }

            100% {
                transform: rotateZ(360deg);
            }
        }

        /*---*/
        @media (max-width: 1440px) {
            .proporcaoSelect {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoInput {
                max-width: 67% !important;
                flex: 60% !important;
                padding-right: 15px;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
                padding-right: 15px !important;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoSle {
                width: 40% !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoSle {
                width: 100% !important;
                padding-right: 0 !important;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoSle {
                width: 40% !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoSle {
                width: 100% !important;
            }
        }

        @media (max-width: 1023px) {
            .divBtnAddPlano {
                padding-right: 0 !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoAddControlador {
                margin-top: 28px;
                margin-bottom: 0px;
                float: right;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoAddControlador {
                /*margin-top: 28px;
                margin-bottom: 0px;*/
                margin-top: 20px;
                text-align: right;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoDivBtn {
                max-width: 100% !important;
                flex: 100% !important;
            }
        }

        @media (max-width: 1023px) {
            .camposCadastro {
                max-width: 100% !important;
                margin-bottom: 15px;
            }

            .proporcaoAddControlador {
                margin-bottom: 0px;
                float: left;
            }

            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
            }

            .pesquisa {
                width: 100%;
            }

            .proporcaoDivBtn {
                max-width: 100% !important;
                flex: 100% !important;
                float: right;
            }

            .proporcaoInputPesq {
                padding-right: 15px !important;
            }

            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
                padding-right: 0 !important;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.listaLocais %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hdfIdEqp" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfLocal" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfIdDna" runat="server" ClientIDMode="Static" />

    <div id="body" style="margin-top: 15px;">

        <h5 class="form-section" style="border-bottom: 1px solid #e9ecef;"><i class="ft-map-pin"></i>
            <%= Resources.Resource.controlador %>: 
            <label id="lblIdEquipamento">1234 - Av. Parana, 234</label>
        </h5>

        <div class="row" style="padding-right: 15px; padding-left: 15px; margin-bottom: 15px; margin-top: 20px;">
            <div class="col-6 col-md-4 proporcaoSelect proporcaoInput proporcaoSle" style="float: left; padding-left: 0;">
                <div class="col-md-9 divBtnAddPlano" style="padding-left: 0;">
                    <%= Resources.Resource.endereco %>:
                        <input id="txtEndereco" placeholder="<%= Resources.Resource.endereco %>..." class="form-control" type="text" onkeyup="filterAddress(this.value)" />
                </div>
            </div>

            <div class="col-6 col-md-4 proporcaoDivBtn" style="padding-right: 0;">
                <div class="proporcaoAddControlador" style="float: right;">
                    <button id="btnNovoLocal" type="button" class="btn btn-icon btn-secondary mr-1" style="margin-left: 10px; margin-right: 0px !important;" onclick="callMapGrupoSemaforico('novo')"><%= Resources.Resource.novo %></button>
                </div>
            </div>
        </div>

        <div class="table-responsive" style="margin-bottom: 20px">
            <table id="tblLocais" class="table table-bordered mb-0" style="margin-top: 10px;">
                <thead id="thLocais">
                    <tr>
                        <th><%= Resources.Resource.endereco %></th>
                        <th><%= Resources.Resource.gruposVinculados %></th>
                        <th><%= Resources.Resource.visualizar %></th>
                    </tr>
                </thead>
                <tbody id="tbLocais">
                    <tr>
                        <td colspan="3"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>

    <script src="LocaisGrupoLogico.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>
        function filterAddress(endereco) {
            var filter, table, tr, td, i;
            filter = endereco.toUpperCase();
            table = document.getElementById("tblLocais");
            tr = table.getElementsByTagName("tr");

            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        $(function () {
            loadResourcesLocales();
            listarLocais();
        });

    </script>
</asp:Content>
