<%@ Page Title="Áreas" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="Area.aspx.cs" Inherits="GwCentral.Register.Areas.Area" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title id="titlePag"><%= Resources.Resource.area %></title>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />

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
            width: 500px;
        }

        #ulDropMenu > li > a {
            color: #428bca;
        }

        #liDrop ul.dropdown-menu {
            border-radius: 4px;
            box-shadow: none;
            margin-top: 20px;
            width: 500px;
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

    <div id="divLoading" style="z-index: 99; display: none;">
        <div style="background-color: rgba(0,0,0,.4); position: absolute; z-index: 99; width: 100%; height: 100%; transition: background-color .1s; top: 45px;">
            <div style="background-color: #fff; width: 300px; height: 300px; text-align: center; z-index: 10; padding-left: 75px; padding-top: 52px; border-radius: 10px; position: absolute; margin: auto; top: 0; right: 0; bottom: 0; left: 0;">
                <div class="loading"><%= Resources.Resource.aguarde %> ...</div>
                <div style="font-size: large; color: #00a7f7; font-size: x-large; color: #00a7f7; margin-top: 192px; margin-left: -60px;"><%= Resources.Resource.carregando %> ...</div>
            </div>
        </div>
    </div>

    <div id="map" style="position: absolute; width: 100%; height: 100%; overflow: hidden;"></div>
    <div class="btn-group" style="left: 25px; position: absolute; top: 65px;">
        <button type="button" class="btn btn-primary collapsed" data-toggle="collapse" data-target="#divSearch" title="<%= Resources.Resource.buscar %>" aria-expanded="false"><span class="fa fa-map-marker" style="font-size: 16px;"></span></button>
    </div>
    <div id="divSearch" class="collapse" style="left: 59px; position: absolute; top: 65px; height: 0px;" aria-expanded="false">
        <p>
            <input class="form-control" placeholder="<%= Resources.Resource.endereco %>..." type="text" id="txtLocal" style="width: 500px;" />
        </p>
    </div>
    <div style="left: 25px; position: absolute; top: 100px;">
        <button type="button" class="btn btn-primary collapsed" data-toggle="collapse" data-target="#divOptionsMarker" title="<%= Resources.Resource.opcoes %>" aria-expanded="false"><span class="glyphicon glyphicon-menu-hamburger" style="font-size: 10px;"></span></button>
    </div>
    <div id="divOptionsMarker" class="collapse" style="left: 60px; position: absolute; top: 100px; height: 0px;" aria-expanded="false">
        <div class="btn-group">
            <button type="button" id="btnMarkerEqp" class="btn btn-default" data-active="false" onclick="AddMarkerEqp(this)" title="<%= Resources.Resource.controlador %>"><i class="material-icons" style="font-size: 16px;">traffic</i></button>
            <button type="button" id="btnMarkerGrupos" class="btn btn-default" data-active="false" onclick="AddMarkerGrupos(this)" title="<%= Resources.Resource.grupo %>"><i class="material-icons" style="font-size: 16px;">zoom_out_map</i></button>
            <button class="btn btn-default dropdown-toggle" type="button" style="height: 35px;" title="<%= Resources.Resource.anel %>" data-toggle="dropdown">
                <i class="fa fa-crosshairs" style="font-size: 16px;"></i>
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="#" id="btnAllAneis" onclick="AddAllAneis(this)"><i class="fa fa-crosshairs" style="font-size: 16px; padding-right: 15px;"></i><%= Resources.Resource.anel %></a></li>
                <li><a href="#" id="btnAddAnel1" style="display:none" data-active="false" onclick="AddMarkerAneis(this)"><i class="fa fa-crosshairs" style="font-size: 16px; color: red; padding-right: 15px;"></i><%= Resources.Resource.anel %> 1</a></li>
                <li><a href="#" id="btnAddAnel2" style="display:none" data-active="false" onclick="AddMarkerAneis(this)"><i class="fa fa-crosshairs" style="font-size: 16px; color: blue; padding-right: 15px;"></i><%= Resources.Resource.anel %> 2</a></li>
                <li><a href="#" id="btnAddAnel3" style="display:none" data-active="false" onclick="AddMarkerAneis(this)"><i class="fa fa-crosshairs" style="font-size: 16px; color: green; padding-right: 15px;"></i><%= Resources.Resource.anel %> 3</a></li>
                <li><a href="#" id="btnAddAnel4" style="display:none" data-active="false" onclick="AddMarkerAneis(this)"><i class="fa fa-crosshairs" style="font-size: 16px; color: yellow; padding-right: 15px;"></i><%= Resources.Resource.anel %> 4</a></li>
            </ul>
        </div>
    </div>
    <ul id="ulNavbar" class="nav navbar-nav" style="right: 10px; position: absolute; top: 65px;">
        <li id="liDrop" class="dropdown">
            <a id="lnkDropToggle" href="#" class="dropdown-toggle" data-toggle="collapse" data-target="#ulDropMenu"><%= Resources.Resource.configuracoes %> <%= Resources.Resource.area %> <span class="glyphicon glyphicon-flag pull-right"></span></a>
            <ul id="ulDropMenu" class="dropdown-menu">
                <li><a href="#" data-toggle="collapse" data-target="#divNovaArea"><%= Resources.Resource.area %> <span class="glyphicon glyphicon-cog pull-right"></span></a></li>
                <li id="divNovaArea" class="collapse" style="margin-left: 10px; margin-top: 10px; margin-right: 5px;">
                    
                    <div class="gmnoprint" style="height:40px; border-bottom:1px solid #d8d8d8;">
                        <%= Resources.Resource.opcoes %>/<%= Resources.Resource.mapa %>: <button type="button" title="<%= Resources.Resource.limpar %>" class="btn btn-default" onclick="drawingManager.setDrawingMode(null);">
                            <span style="display: inline-block;">
                                <div style="width: 16px; height: 16px; overflow: hidden; position: relative;">
                                    <img alt="" src="https://maps.gstatic.com/mapfiles/drawing.png" style="position: absolute; left: 0px; top: -144px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 16px; height: 192px;">
                                </div>
                            </span>
                        </button>
                        <button type="button" title="<%= Resources.Resource.desenhar %>" class="btn btn-default" onclick="drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);">
                            <span style="display: inline-block;">
                                <div style="width: 16px; height: 16px; overflow: hidden; position: relative;">
                                    <img alt="" src="https://maps.gstatic.com/mapfiles/drawing.png" style="position: absolute; left: 0px; top: -64px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 16px; height: 192px;">
                                </div>
                            </span>
                        </button>
                    </div>
                    <p style="margin-top:10px;"><%= Resources.Resource.nome %> <%= Resources.Resource.area %>:</p>
                    <div class="input-group">
                        <input type="text" id="txtNomeArea" class="form-control"/>
                        <div class="input-group-addon" onclick="Salvar()">
                            <a href="#" id="btnSalvar"><%= Resources.Resource.salvar %> </a>
                        </div>
                    </div>
                </li>
                <li class="divider"></li>
                <li><a href="#" onclick="Cancelar(); $('#divNovaArea').collapse('show');"><%= Resources.Resource.novo %> <span class="glyphicon glyphicon-plus pull-right"></span></a></li>
                <li class="divider"></li>
                <li><a href="#" onclick="Cancelar();"><%= Resources.Resource.cancelar %> <span class="glyphicon glyphicon-trash pull-right"></span></a></li>
                <li class="divider"></li>
                <li><a href="#" data-toggle="collapse" data-target="#divListArea"><%= Resources.Resource.lista %> <%= Resources.Resource.area %> <span class="glyphicon glyphicon-list-alt pull-right"></span></a></li>
                <li id="divListArea" class="collapse" style="margin-left: 10px; margin-top: 10px; margin-right: 5px;">
                    <div class="input-group">
                        <input type="text" id="txtArea" class="form-control" onkeyup="FindlistRows('0',this)" placeholder="<%= Resources.Resource.buscar %>..." />
                        <span class="input-group-addon">
                            <a href="#"><span class="glyphicon glyphicon-search" onclick="FindlistRows('0',this)"></span></a>
                        </span>
                    </div>
                    <div id="exibirArea" style="height: 250px; margin-top: 10px; overflow-y: scroll;">
                        <table id="tblArea" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th><%= Resources.Resource.area %></th>
                                    <th><%= Resources.Resource.gruposVinculados %></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="tbArea"></tbody>
                            <tfoot id="tfArea" style="display: none;">
                                <tr>
                                    <td colspan="5"><%= Resources.Resource.naoHaRegistros %></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </li>
            </ul>
        </li>
    </ul>

    <div class="modal fade" id="modalGruposArea" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%= Resources.Resource.grupo %> <%= Resources.Resource.area %></h4>
                </div>
                <div class="modal-body">
                    <pre id="preArea"><%= Resources.Resource.area %>:</pre>

                    <table id="tblGrupoArea" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th><%= Resources.Resource.grupo %></th>
                                <th><%= Resources.Resource.anel %></th>
                                <th><%= Resources.Resource.endereco %></th>
                                <th>Id. <%= Resources.Resource.controlador %></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="tbGrupoArea"></tbody>
                        <tfoot id="tfGrupoArea">
                            <tr>
                                <td colspan="5"><%= Resources.Resource.naoHaRegistros %></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                </div>
            </div>

        </div>
    </div>

    <script src="https://maps.googleapis.com/maps/api/js?libraries=drawing,places,geometry&key=AIzaSyAEbTl1Ap78hKxlDNENs6iu8iBBJaWg2Lc"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.js"></script>
    <script src="../../Scripts/jquery.ui.addresspicker.js"></script>
    <script src="../../Scripts/jsts.min.js"></script>
    <script src="../MapUtils.js"></script>
    <script src="Area.js"></script>
</asp:Content>
