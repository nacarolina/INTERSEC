<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AreaSubArea.aspx.cs" Inherits="GwCentral.Register.Areas.AreaSubArea" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">

    <title><%= Resources.Resource.cadastroArea %></title>
    <style>
        


        @keyframes rotate {
            0% {
                transform: rotateZ(0deg);
            }

            100% {
                transform: rotateZ(360deg);
            }
        }

        .not-display {
            display: inline !important;
        }

        .autocomplete-items {
            top: 80% !important;
            left: 15px !important;
            right: 180px !important;
        }

        .collapse-table tr:not(.header) {
            display: none;
        }

        .collapse-table .header.active td:after {
            content: "\2212";
        } 
        .form-group input[type="checkbox"] {
            display: none;
        }

            .form-group input[type="checkbox"] + .btn-group > label span {
                width: 20px;
            }

                .form-group input[type="checkbox"] + .btn-group > label span:first-child {
                    display: none;
                }

                .form-group input[type="checkbox"] + .btn-group > label span:last-child {
                    display: inline-block;
                }

            .form-group input[type="checkbox"]:checked + .btn-group > label span:first-child {
                display: inline-block;
            }

            .form-group input[type="checkbox"]:checked + .btn-group > label span:last-child {
                display: none;
            } 
    </style>
    <link href="treeView.css" rel="stylesheet" />
    <link href="../../Styles/autoComplete.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="Server">
    <%= Resources.Resource.cadastroArea %>/<%= Resources.Resource.subArea %></a>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="index.html"><%= Resources.Resource.cadastro %></a>
        </li>
        <li class="breadcrumb-item"><a href="#"><%= Resources.Resource.cadastroArea %>/<%= Resources.Resource.subArea %></a></a>
        </li>
    </ol>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:HiddenField ID="hfUser" ClientIDMode="Static" runat="server" />
    <div id="divMain" style="overflow: auto; height: 500px;">
        <div class="panel panel-default" style="width: 220px; margin-left: 10px; margin-top: 10px;">
            <table>
                <tr style="height: 40px;">
                    <td style="border-right: 1px solid #d4d4d4; padding-left: 10px; padding-right: 10px;">
                        <img src="../../Images/area.png" />
                        <h5 style="display: inline">- <%= Resources.Resource.area %></h5>
                    </td>
                    <td style="padding-left: 10px;">
                        <img src="../../Images/subArea.png" />
                        <h5 style="display: inline">- <%= Resources.Resource.subArea %></h5>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <small class="text-muted" style="margin-left: 15px;">* <%= Resources.Resource.botaoDireitoParaOpcoes %></small>
        <hr style="margin: 0px 15px;" />

        <table>
            <tr>
                <td style="width: 350px; border-right: 1px solid #d4d4d4; padding-left: 10px;">
                    <div style="margin: 15px;">
                        <div class="row">
                            <ul id="treeArea"></ul>
                        </div>
                    </div>
                </td>
                <td style="padding-left: 10px;">
                    <div id="divAneisVinculados" style="width: 100%; border: 1px solid #d4d4d4; margin: 10px; display: none;">
                        <div style="border-bottom: 1px solid #d4d4d4;">
                            <p style="margin: 10px">
                                <span class="la la-bars" style="padding-right: 10px;"></span>- <%= Resources.Resource.listaEqpVinculado %> - <%= Resources.Resource.subArea %>: <span id="spnArea">--</span>
                                <button style="float: right;padding: 2px;width: 7%;" data-toggle="tooltip" title="<%= Resources.Resource.imprimir %>" id="btnPrint" class="btn btn-info btn-sm" type="button" onclick="print('#tblAneis');"><span class="la la-print" style="color: #fff;"></span></button>
                            </p>
                        </div>
                        <div class="panel-body">
                            <table id="tblAneis" class="table table-bordered table-striped table-hover"></table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

        <div id="contextMenu" style="display: none; border: 1px solid #e9e9e9; width: 20%; border-radius: 10px; background-color:white" class="panel panel-primary">
            <div class="panel-heading " style="text-align: center; padding: 5px; margin-bottom: 10px; border-bottom: 1px solid #e9e9e9;">
                <%= Resources.Resource.opcoes %>
            </div>
            <div style="margin-left: 10px; margin-right: 10px;">
                <button class="mr-1 mb-1 btn btn-outline-secondary btn-min-width" onclick="NovaSubArea()" style="width: 100%; border-color: #d3d3d3;">
                    <span class="glyphicon glyphicon-plus" style="padding-right: 10px; color: green;"></span><%= Resources.Resource.novo %></button>
                <button class="mr-1 mb-1 btn btn-outline-secondary btn-min-width" onclick="Renomear()" style="width: 100%; border-color: #d3d3d3;"><span class="glyphicon glyphicon-pencil" style="padding-right: 10px; color: blue;"></span><%= Resources.Resource.renomear %></button>
                <button class="mr-1 mb-1 btn btn-outline-secondary btn-min-width" onclick="Excluir()" id="confirm-dialog" style="width: 100%; border-color: #d3d3d3;"><%= Resources.Resource.excluir %></button>

                <button class="mr-1 mb-1 btn btn-outline-secondary btn-min-width" onclick="getAneisVinculados()" style="width: 100%; border-color: #d3d3d3;" data-toggle="modal" data-target="#modalControl"><span class="glyphicon glyphicon-edit" style="padding-right: 10px;"></span><%= Resources.Resource.vincularControlador  %></button>
            </div>
        </div>
    </div>
    <div class="modal" id="modalControl" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><%= Resources.Resource.vincularControlador %></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <small id="infoArea" class="text-muted"></small>
                    <hr style="padding-left: 10px; padding-right: 10px;" />
                    <table id="tblControl" class="table table-bordered collapse-table"></table>
                </div>
                <div class="modal-footer">
                    <button id="btnFechar" type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
    <script src="treeViewAreas.js"></script>

    <script src="../../Scripts/autoComplete.js"></script>
    <script>
</script>
</asp:Content>
