<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="MapGrupoSemaforico.aspx.cs" Inherits="GwCentral.Register.Dna.MapGrupoSemaforico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title><%= Resources.Resource.locaisGruposSemaforicos %> - <%= Resources.Resource.mapa %></title>
    <%-- <link href='https://api.mapbox.com/mapbox.js/v2.2.3/mapbox.css' rel='stylesheet' />
    <script src="../../Scripts/mapbox.js"></script>--%>
    <link rel="stylesheet" href="../../dist-leaflet-markers/leaflet.awesome-markers.css" />
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
        /*AJUSTA TELA INICIAL QUANDO A TELA É REDUZIDA/SELECT - BOTOES*/
        @media (max-width: 1440px) {
            .proporcaoMetade {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoMetade {
                flex: 0 0 50% !important;
                max-width: 50% !important;
            }
        }
    </style>

    <link href="../../distMarkers/css/map-icons.css" rel="stylesheet" />
    <script src="../../distMarkers/js/map-icons.js"></script>
    <link href="../../assets/icomoon/style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.locaisGruposSemaforicos %> - <%= Resources.Resource.mapa %>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hdfId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfIdEqp" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfIdDna" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfLocal" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfOperacaoCad" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfTypeMarker" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfIdLocal" runat="server" ClientIDMode="Static" />

    <div id="map" style="position: absolute; width: 100%; height: 100%; overflow: hidden; top: 0px; left: 0px"></div>
    <div class="alert alert-info" style="left: 77.6%; position: absolute; top: 9%; background-color: #e2f1fe">
        <strong style="color: #1962a1">Info!</strong><p class="modal-title text-muted" style="display: inline-block; padding-left: 10px;" id="smallGpSelecionado"><%= Resources.Resource.grupoSemaforicoSelecionado %>: XX</p>
    </div>
    <div class="btn-group" style="position: absolute; top: 9%; left: 0.7%">
        <div class="btn-group">
            <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
                <span class="glyphicon glyphicon-menu-hamburger" style="font-size: 10px;"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#" id="btnMarkerEqp" data-active="false" onclick="AddMarkerEqp(this)"><%= Resources.Resource.controlador %></a></li>
                <li><a href="#" id="btnMarkerGrupos" data-active="true" onclick="AddMarkerGrupos(this)"><%= Resources.Resource.gruposSemaforicos %></a></li>
                <li><a href="#" id="btnAllAneis" data-active="false" onclick="AddAllAneis(this)"><%= Resources.Resource.anel %></a></li>
            </ul>
        </div>
        <button type="button" id="btnAddMarkerUp" class="btn btn-info" onclick="$('#hdfTypeMarker').val('cima')"><span class="ft ft-arrow-up"></span></button>
        <button type="button" id="btnAddMarkerDown" class="btn btn-info" onclick="$('#hdfTypeMarker').val('baixo')"><span class="ft ft-arrow-down"></span></button>
        <button type="button" id="btnAddMarkerRight" class="btn btn-info" onclick="$('#hdfTypeMarker').val('direita')"><span class="ft ft-arrow-right"></span></button>
        <button type="button" id="btnAddMarkerLeft" class="btn btn-info" onclick="$('#hdfTypeMarker').val('esquerda')"><span class="ft ft-arrow-left"></span></button>
        <button type="button" id="btnAddMarkerReturnRight" class="btn btn-info" onclick="$('#hdfTypeMarker').val('conversão direita')"><span class="ft ft-corner-up-right"></span></button>
        <button type="button" id="btnAddMarkerReturnLeft" class="btn btn-info" onclick="$('#hdfTypeMarker').val('conversão esquerda')"><span class="ft ft-corner-up-left"></span></button>
        <button type="button" id="btnAddMarkerUpRight" class="btn btn-info" onclick="$('#hdfTypeMarker').val('diagonal cima direita')"><span class="ft ft-arrow-up-right"></span></button>
        <button type="button" id="btnAddMarkerUpLeft" class="btn btn-info" onclick="$('#hdfTypeMarker').val('diagonal cima esquerda')"><span class="ft ft-arrow-up-left"></span></button>
        <button type="button" id="btnAddMarkerDownRight" class="btn btn-info" onclick="$('#hdfTypeMarker').val('diagonal baixo direita')"><span class="ft ft-arrow-down-right"></span></button>
        <button type="button" id="btnAddMarkerDownLeft" class="btn btn-info" onclick="$('#hdfTypeMarker').val('diagonal baixo esquerda')"><span class="ft ft-arrow-down-left"></span></button>
        <button type="button" id="btnAddMarker" class="btn btn-info" onclick="$('#hdfTypeMarker').val('pedestre')"><i class="material-icons" style="font-size: 15px;">directions_walk</i></button>
        <button type="button" id="btnCancelMarker" class="btn btn-info" onclick="$('#hdfTypeMarker').val('')"><i class="material-icons" style="font-size: 15px;">pan_tool</i></button>
        <button type="button" class="btn btn-info collapsed" data-toggle="collapse" data-target="#divSearch" title="Buscar Local" aria-expanded="false"><span class="fa fa-map-marker" style="font-size: 16px;"></span></button>
    </div>
    <div id="divSearch" class="collapse" style="left: 37%; position: absolute; top: 10%; height: 0px;" aria-expanded="false">
        <p><b><%= Resources.Resource.cruzamento %>:</b></p>
        <table>
            <tbody>
                <tr>
                    <td>
                        <asp:TextBox ID="txtCruzamento" CssClass="form-control" Width="350px" Style="display: inline;" runat="server" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td>
                        <img id="imgPesquisarCruzamento" src="../../Images/search.png" style="width: 32px; height: 32px; cursor: pointer;" onclick="Geocodificacao();" />
                    </td>
                    <td>
                        <asp:HiddenField ID="hdfLat" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hdfLng" runat="server" ClientIDMode="Static" />
                        <button type="button" class="btn btn-default" id="btnSalvar" data-tipo="Salvar" style="display: none;"><%= Resources.Resource.salvar %></button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <div id="modalGruposSemaforicos" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" style="width: 100%">
                <div class="modal-header" style="border-bottom: 1px solid #d8d8d8;">
                    <h4 class="modal-title"><%= Resources.Resource.gruposVinculados %></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <input type="text" id="prelLocal" class="form-control" />
                    <button id="btnSalvarEndereco" class="btn btn-success btn-sm" style="margin-top:5px" onclick="SalvarEndereco()"><%= Resources.Resource.salvar %> <%= Resources.Resource.endereco %></button>
                    <div class="row proporcaoRow">
                        <div class="col-6 col-md-4 " style="max-width: 100%; flex: 100%; border-bottom: 1px solid #d8d8d8;">
                            <small class="text-muted"><%= Resources.Resource.gruposSemaforicos %></small>
                            <hr />
                            <div id="divGruposSemaforicos" style=" width: 100%; overflow: auto;">
                                <table id="tblGrupoSemaforico" class="table table-bordered  mb-0" style="margin-top: 10px; font-size: smaller; margin-bottom: 150px !important;">
                                    <thead>
                                        <tr>
                                            <th><%= Resources.Resource.grupo %></th>
                                            <th><%= Resources.Resource.tipo %></th>
                                            <th><%= Resources.Resource.modelo %></th>
                                            <th><%= Resources.Resource.anel %></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbGrupoSemaforico"></tbody>
                                    <tfoot id="tfGrupoSemaforico">
                                        <tr>
                                            <td colspan="6"><%= Resources.Resource.naoHaRegistros %>
                                                <br />
                                                <button style="margin-top: 10px;" onclick="NovoGrupo()" class="btn mr-1 mb-1 btn-outline-secondary btn-sm"><%= Resources.Resource.cadastrar %> <%= Resources.Resource.novo %></button></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                            <div id="dvCadastroGrupo" class="row" style="display: none; padding-bottom:10px">

                                <div style="width: 100%">
                                    <div class="col-6 col-md-4" style="max-width: 50%; float: left;">
                                        <%= Resources.Resource.grupo %>:
                                        <select id="sleGrupo" class="form-control">
                                            <option value="">Selecione..</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                            <option value="13">13</option>
                                            <option value="14">14</option>
                                            <option value="15">15</option>
                                            <option value="16">16</option>
                                            <option value="17">17</option>
                                            <option value="18">18</option>
                                            <option value="19">19</option>
                                            <option value="20">20</option>
                                            <option value="21">21</option>
                                            <option value="22">22</option>
                                            <option value="23">23</option>
                                            <option value="24">24</option>
                                        </select>
                                    </div>
                                    <div class="col-6 col-md-4" style="max-width: 50%; float: right;">
                                        <%= Resources.Resource.tipo %>
                                        <select id="sleTipo" class="form-control">
                                            <option value="">Selecione..</option>
                                            <option value="VEICULAR">VEICULAR</option>
                                            <option value="PEDESTRE">PEDESTRE</option>
                                        </select>
                                    </div>
                                </div>
                                <div style="width: 100%; padding-top: 15px">
                                    <div class="col-6 col-md-4" style="max-width: 50%; float: left;">
                                        <%= Resources.Resource.anel %>
                                        <select id="sleAnel" class="form-control">
                                            <option value="">Selecione..</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                        </select>
                                    </div>
                                    <div class="col-6 col-md-4" style="max-width: 50%; float: right;">
                                        <%= Resources.Resource.modelo %>
                                        <select id="sleModelo" class="form-control">
                                        </select>
                                    </div>
                                </div>
                                <div style="padding-left: 15px; padding-top: 15px">
                                    <button class="btn btn-success" id="btnSalvarCadGrupo" onclick="SalvarGrupo()"><%= Resources.Resource.salvar %></button>
                                    <button class="btn btn-warning" onclick="CancelarCadGrupo()"><%= Resources.Resource.cancelar %></button>
                                </div>

                            </div>
                        </div>

                    </div>

                    <div class="col-6 col-md-4" style="max-width: 100%; padding-top:10px">
                        <small class="text-muted"><%= Resources.Resource.gruposVinculados %></small>
                        <hr />
                        <div id="divGruposSemaforicosVinculados" style="height: 92%; width: 100%; overflow: auto;">
                            <table id="tblGrupoSemaforicoVinculados" class="table table-bordered  mb-0" style="margin-top: 10px; font-size: smaller;">
                                <thead>
                                    <tr>
                                        <th><%= Resources.Resource.grupo %></th>
                                        <th><%= Resources.Resource.tipo %></th>
                                        <th><%= Resources.Resource.marcador %></th>
                                        <th><%= Resources.Resource.modelo %></th>
                                        <th><%= Resources.Resource.anel %></th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody id="tbGrupoSemaforicoVinculados"></tbody>
                                <tfoot id="tfGrupoSemaforicoVinculados">
                                    <tr>
                                        <td colspan="7"><%= Resources.Resource.naoHaRegistros %></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="text-align: right !important;">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/e8cc7ed1ec.js" crossorigin="anonymous"></script>
    <script src="LocaisGrupoLogico.js"></script>

    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBYQJ8OSMm1XQcb2h8lla6IbG2rNeKtQ9Q" type="text/javascript"></script>
    <script>
        $(function () {
            Geocodificacao("Foz do Iguaçu", '', $("#hdfId").val())
            var addresspicker = $("#txtCruzamento").addresspicker({
                componentsFilter: 'country:BR',
                updateCallback: callGeocode,
                mapOptions: {
                    zoom: 5,
                    center: new google.maps.LatLng($("#txtLat").val(), $("#txtLong").val()),
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                },
                elements: {
                    map: "#map",
                    lat: "#txtLat",
                    lng: "#txtLong"
                }
            });
        });


    </script>

</asp:Content>
