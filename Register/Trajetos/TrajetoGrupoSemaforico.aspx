<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="TrajetoGrupoSemaforico.aspx.cs" Inherits="GwCentral.Register.Trajetos.TrajetoGrupoSemaforico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title id="titlePag"><%= Resources.Resource.rotaGrupoSemaforico %></title>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <link href="../Areas/treeView.css" rel="stylesheet" />

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

        #ulNavbar > li > a:hover, .nav > li > a:focus, .nav .open > a, .nav .open > a:hover, .nav .open > a:focus {
            background: #fff;
        }

        #liDrop {
            background: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 450px;
        }

        #ulDropMenu > li > a {
            color: #428bca;
        }

        #liDrop ul.dropdown-menu {
            border-radius: 4px;
            box-shadow: none;
            margin-top: 20px;
            width: 450px;
        }

            #liDrop ul.dropdown-menu:before {
                content: "";
                border-bottom: 10px solid #fff;
                border-right: 10px solid transparent;
                border-left: 10px solid transparent;
                position: absolute;
                top: -10px;
                right: 16px;
                z-index: 10;
            }

            #liDrop ul.dropdown-menu:after {
                content: "";
                border-bottom: 12px solid #ccc;
                border-right: 12px solid transparent;
                border-left: 12px solid transparent;
                position: absolute;
                top: -12px;
                right: 14px;
                z-index: 9;
            }
    </style>

    <link href="../../distMarkers/css/map-icons.css" rel="stylesheet" />
    <script src="../../distMarkers/js/map-icons.js"></script>
    <link href="../../assets/icomoon/style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <script src="../../assets/sweetalert-dev.js"></script>
    <link href="../../assets/sweetalert.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hfLat" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfLng" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfCallServer" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfIdSubarea" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfSubarea" runat="server" ClientIDMode="Static" />

    <div id="divLoading" style="z-index: 99; display: none;">
        <div style="background-color: rgba(0,0,0,.4); position: absolute; z-index: 99; width: 100%; height: 100%; transition: background-color .1s; top: 45px;">
            <div style="background-color: #fff; width: 300px; height: 300px; text-align: center; z-index: 99; padding-left: 75px; padding-top: 52px; border-radius: 10px; position: absolute; margin: auto; top: 0; right: 0; bottom: 0; left: 0;">
                <div class="loading"><%= Resources.Resource.aguarde %> ...</div>
                <div style="font-size: large; color: #00a7f7; font-size: x-large; color: #00a7f7; margin-top: 192px; margin-left: -60px;"><%= Resources.Resource.carregando %> ...</div>
            </div>
        </div>
    </div>

    <div id="map" style="position: absolute; width: 100%; height: 100%; overflow: hidden;"></div>

    <div class="btn-group" style="left: 25px; position: absolute; top: 65px;">
        <button type="button" class="btn btn-primary collapsed" data-toggle="collapse" data-target="#divSearch" title="<%= Resources.Resource.buscar %>" aria-expanded="false"><span class="fa fa-map-marker" style="font-size: 16px;"></span></button>
    </div>
    <div id="divSearch" class="collapse" style="left: 63px; position: absolute; top: 65px; height: 0px;" aria-expanded="false">
        <div class="input-group" style="width: 500px;">
            <input placeholder="<%= Resources.Resource.buscar %> <%= Resources.Resource.endereco %>.." class="form-control" type="text" id="txtLocal" />
            <span class="input-group-btn">
                <button type="button" class="btn btn-primary" onclick="searchAddress();"><i class="fas fa-search-location"></i></button>
            </span>
        </div>
    </div>
    <div style="left: 25px; position: absolute; top: 100px;">
        <button type="button" class="btn btn-primary collapsed" data-toggle="collapse" data-target="#divOptionsMarker" title="<%= Resources.Resource.opcoes %>" aria-expanded="false"><span class="glyphicon glyphicon-menu-hamburger" style="font-size: 10px;"></span></button>
    </div>
    <div id="divOptionsMarker" class="collapse" style="left: 60px; position: absolute; top: 100px; height: 0px;" aria-expanded="false">
        <div class="btn-group">
            <button type="button" id="btnMarkerEqp" class="btn btn-default" data-active="false" onclick="AddMarkerEqp(this)" title="<%= Resources.Resource.controlador %>"><i class="material-icons" style="font-size: 16px;">traffic</i></button>
            <button type="button" id="btnMarkerGrupos" class="btn btn-default" data-active="false" onclick="AddMarkerGrupos(this)" title="<%= Resources.Resource.gruposSemaforicos %>"><i class="material-icons" style="font-size: 16px;">zoom_out_map</i></button>
            <button class="btn btn-default dropdown-toggle" type="button" style="height: 35px;" title="<%= Resources.Resource.anel %>" data-toggle="dropdown">
                <i class="fa fa-crosshairs" style="font-size: 16px;"></i>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="#" id="btnAllAneis" onclick="AddAllAneis(this)"><i class="fa fa-crosshairs" style="font-size: 16px; padding-right: 15px;"></i><%= Resources.Resource.anel %></a></li>
                <li><a href="#" id="btnAddAnel1" data-active="false" style="display: none" onclick="AddMarkerAneis(this)"><i class="fa fa-crosshairs" style="font-size: 16px; color: red; padding-right: 15px;"></i><%= Resources.Resource.anel %> 1</a></li>
                <li><a href="#" id="btnAddAnel2" data-active="false" style="display: none" onclick="AddMarkerAneis(this)"><i class="fa fa-crosshairs" style="font-size: 16px; color: blue; padding-right: 15px;"></i><%= Resources.Resource.anel %> 2</a></li>
                <li><a href="#" id="btnAddAnel3" data-active="false" style="display: none" onclick="AddMarkerAneis(this)"><i class="fa fa-crosshairs" style="font-size: 16px; color: green; padding-right: 15px;"></i><%= Resources.Resource.anel %> 3</a></li>
                <li><a href="#" id="btnAddAnel4" data-active="false" style="display: none" onclick="AddMarkerAneis(this)"><i class="fa fa-crosshairs" style="font-size: 16px; color: yellow; padding-right: 15px;"></i><%= Resources.Resource.anel %> 4</a></li>
            </ul>
        </div>
    </div>

    <ul id="ulNavbar" class="nav navbar-nav" style="right: 10px; position: absolute; top: 65px;">
        <li id="liDrop" class="dropdown">
            <a id="lnkDropToggle" href="#" class="dropdown-toggle" data-toggle="collapse" data-target="#ulDropMenu"><%= Resources.Resource.configuracoes %> <span class="glyphicon glyphicon-road pull-right"></span></a>
            <ul id="ulDropMenu" class="dropdown-menu">
                <li><a href="#" data-toggle="collapse" data-target="#divTrajeto"><%= Resources.Resource.rota %> <span class="glyphicon glyphicon-cog pull-right"></span></a></li>
                <li id="divTrajeto" class="" style="margin-left: 10px; margin-top: 10px; margin-right: 5px;" aria-expanded="true">
                    <%= Resources.Resource.nomeRota %>:
                    <div class="input-group">
                        <input type="text" id="txtTrajeto" class="form-control" placeholder="<%= Resources.Resource.rota %>..." />
                        <div class="input-group-addon" onclick="Save()">
                            <a href="#" id="btnSalvar"><%= Resources.Resource.salvar %> </a>
                        </div>
                    </div>
                    <p style="border-bottom: 1px solid #d8d8d8; margin-top: 10px;">
                        <small class="text-muted">* <%= Resources.Resource.selecioneSubAreaConfigRota %></small>
                        <pre id="preArea"><%= Resources.Resource.areaSelecionada %>:</pre>
                    </p>
                </li>
                <li class="divider"></li>
                <%--<li><a href="#" data-toggle="collapse" data-target="#divListArea"><%= Resources.Resource.listaAreas %> <%= Resources.Resource.subArea %> <span class="glyphicon glyphicon-list-alt pull-right"></span></a></li>--%>
                <li id="divListArea" class="collapse" style="margin-left: 10px; margin-top: 10px; margin-right: 5px;">
                    <div id="exibirArea" style="height: 200px; overflow-y: scroll;">
                        <ul id="treeArea"></ul>
                    </div>
                </li>
                <li class="divider"></li>
                <li><a style="cursor: pointer;" onclick="Excluir()"><%= Resources.Resource.excluir %> <%= Resources.Resource.rota %> <span class="glyphicon glyphicon-trash pull-right"></span></a></li>
                <%--<li class="divider"></li>
                <li><a id="btnVincularGrupos" style="cursor: pointer;" onclick="vinculoGrupoTrajeto()"><%= Resources.Resource.vincularGruposRota %></a></li>--%>
                <li class="divider"></li>
                <li><a onclick="$('#btnMarkerGrupos').data('active', false); initialize('trajetos')" style="cursor: pointer;"><%= Resources.Resource.recarregarRota %> <span class="glyphicon glyphicon-road pull-right"></span></a></li>
                <%--<li class="divider"></li>
               <li><a style="cursor: pointer;" onclick="loadGruposVinculados()" data-toggle="collapse" data-target="#divGruposVinculados"><%= Resources.Resource.visualizarGruposVinculados %> <i class="material-icons" style="font-size: 16px; float: right;">zoom_out_map</i></a></li>
                <li class="divider"></li>
                <li>
                    <div id="divGruposVinculados" class="collapse" style="margin-left: 10px; height: 250px; overflow-y: scroll;">
                        <table id="tblInfo" class="table table-bordered">
                            <thead>
                                <tr>
                                    <th><%= Resources.Resource.grupo %></th>
                                    <th><%= Resources.Resource.anel %></th>
                                    <th><%= Resources.Resource.endereco %></th>
                                    <th>Id. <%= Resources.Resource.controlador %></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="tbInfo"></tbody>
                            <tfoot id="tfInfo">
                                <tr>
                                    <td colspan="5"><%= Resources.Resource.naoHaRegistros %></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </li>--%>
                <li>
                    <table style="float: right;">
                        <tr>
                           <%-- <td style="padding: 10px;">
                                <button type="button" class="btn btn-success" onclick="Cancelar('Novo'); $('#divTrajeto').collapse('show');"><%= Resources.Resource.novo %></button></td>--%>
                            <td style="padding: 10px;">
                                <button type="button" class="btn btn-default" onclick="Voltar()"><%= Resources.Resource.voltar %></button>
                            </td>
                            <td style="padding: 10px;">
                                <button type="button" class="btn btn-danger" onclick="Cancelar('Limpar')"><%= Resources.Resource.cancelar %></button>
                            </td>
                        </tr>
                    </table>
                </li>
            </ul>
        </li>
    </ul>

    <script src="https://maps.googleapis.com/maps/api/js?libraries=drawing,places,geometry&key=AIzaSyAEbTl1Ap78hKxlDNENs6iu8iBBJaWg2Lc"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.js"></script>
    <script src="../../Scripts/jquery.ui.addresspicker.js"></script>
    <script src="../../Scripts/jsts.min.js"></script>
    <script src="../Areas/treeViewAreas.js"></script>
    <script src="../MapUtils.js"></script>
    <script src="Trajeto.js"></script>
    <script>
        $(function () {
            initialize('trajetos');
            ListAllArea();
        })
    </script>
</asp:Content>

