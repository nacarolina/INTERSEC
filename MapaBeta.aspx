<%@ Page Title="Mapa" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="MapaBeta.aspx.cs" Inherits="GwCentral.MapaBeta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href='https://api.mapbox.com/mapbox.js/v2.2.3/mapbox.css' rel='stylesheet' />
    <script src="Scripts/mapbox.js"></script>
    <link rel="stylesheet" href="dist-leaflet-markers/leaflet.awesome-markers.css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.mapa %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-label/v0.2.1/leaflet.label.js'></script>
    <link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-label/v0.2.1/leaflet.label.css' rel='stylesheet' />

    <asp:HiddenField ID="hfTemEqp" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfIdEqp" runat="server" ClientIDMode="Static" />
    <input type="hidden" id="hfIdPonto" />
    <asp:HiddenField ID="hfResetaControlador" runat="server" ClientIDMode="Static" />
    <input id="hfUserPermReset" type="hidden" />
    <asp:HiddenField ID="hfIdPrefeitura" runat="server" ClientIDMode="Static"></asp:HiddenField>
    <asp:HiddenField ID="hfLatLng" runat="server" ClientIDMode="Static" />

    <div id="map" style="position: absolute !important; width: 100%; height: 100%; left: 0px; top: 0px" class="leaflet-container leaflet-retina leaflet-fade-anim"></div>

    <div class="modal fade" id="divPopupMarker" role="dialog" style="font-family: Arial; font-size: 0.9em;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header" style="border-bottom: 1px solid #e9ecef;">
                    <h4 class="modal-title"><span id="lblIdPonto"></span>- <span id="lblCruzamento"></span></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <i id="itensao" class='ft-battery-charging' style='font-size: 18px !important;'></i>&nbsp<span id="lblTensao" style="font-family: Arial; word-break: break-all;"></span>&nbsp&nbsp&nbsp&nbsp<i id="itemp" class='ft-thermometer' style='font-size: 18px !important;'></i><span id="lblTemperatura" style="font-family: Arial; word-break: break-all;"></span>&nbsp&nbsp&nbsp&nbsp<i id="iestado" class='ft-activity' style='font-size: 18px !important;'></i>&nbsp<span id="lblEstado" style="font-family: Arial; word-break: break-all;"></span>&nbsp&nbsp&nbsp<p class="bg-warning" style="width:200px;"><span id="lblSerialMestre" style="font-family: Arial; word-break: break-all;"></span></p><span id="lblLinkMap" style="font-family: Arial; word-break: break-all;color: #1a73e8; font-size: small;"></span>&nbsp&nbsp&nbsp&nbsp<a onclick="AbrirGoogleMaps()" style="color: #1a73e8; font-size: small;">Vista da Rua</a>
                    <div id="divDetalhesDna">
                        <div class="card-footer text-center p-1" style="padding-top: 0px !important;">
                            <div class="row">
                                <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center" style="border-bottom: 1px solid #ECEFF1; border-left: 1px solid #ECEFF1;">
                                    <p class="blue-grey lighten-2 mb-0" style="margin-top: 10%;"><%= Resources.Resource.programacao %>: </p>
                                    <p><span id="lblProgramacao" style="word-break: break-all;"></span></p>
                                </div>
                                <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center" style="border-bottom: 1px solid #ECEFF1;">
                                    <p class="blue-grey lighten-2 mb-0" style="margin-top: 10%;"><%= Resources.Resource.ultimaAtualizacaoProgramacao %>: </p>
                                    <p><span id="lblDtHrAtualizacaoProg">00/00/0000 00:00:00</span></p>
                                </div>
                                <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center" style="border-bottom: 1px solid #ECEFF1;">
                                    <p class="blue-grey lighten-2 mb-0" style="margin-top: 10%;">IP</p>
                                    <p>
                                        <span id="lblIP">000.000.000.000</span>
                                    </p>
                                </div>

                                <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center" style="border-bottom: 1px solid #ECEFF1;">
                                    <p class="blue-grey lighten-2 mb-0" style="margin-top: 10%;"><%= Resources.Resource.tarefasPendentes %>: </p>
                                    <p>
                                        <span id="lblTarefasPendentes"></span>
                                    </p>
                                </div>
                                <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center" style="border-bottom: 1px solid #ECEFF1;">
                                    <p class="blue-grey lighten-2 mb-0" style="margin-top: 10%;"><%= Resources.Resource.ultimaComunicacao %>:</p>
                                    <p><span id="lblUltComunicacao">00/00/0000 00:00:00</span></p>
                                </div>
                                <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center" style="border-bottom: 1px solid #ECEFF1; border-left: 1px solid #ECEFF1;">
                                    <p class="blue-grey lighten-2 mb-0" style="margin-top: 10%;"><%= Resources.Resource.modoOperacional %>: </p>
                                    <p><span id="lblModoOperacional"></span></p>
                                </div>
                                <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center" style="border-bottom: 1px solid #ECEFF1;">
                                    <p class="blue-grey lighten-2 mb-0" style="margin-top: 10%;"><%= Resources.Resource.falhas %>: </p>
                                    <p><span id="spaFalhas"></span></p>
                                </div>
                                <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center" style="border-bottom: 1px solid #ECEFF1;">
                                    <p class="blue-grey lighten-2 mb-0" style="margin-top: 10%;"><%= Resources.Resource.porta %>:</p>
                                    <p><span id="spaPorta"></span></p>
                                </div>
                                <%-- <div class="col-md-3 col-12 border-right-blue-grey border-right-lighten-5 text-center" style="border-bottom: 1px solid #ECEFF1;border-left: 1px solid #ECEFF1;">
                                    <p class="blue-grey lighten-2 mb-0" style="margin-top: 10%;"></p>
                                    <p></p>
                                </div>--%>
                            </div>

                            <div class="btn-group" role="group" style="margin-top: 2%;">
                                <button type="button" id="btnMonitoramento" class="btn  btn-secondary" style="font-size: small; padding: 0.5rem;" onclick="AbrirMonitoramento('');">
                                    <%--<img style="height: 22px" src="../Images/TempoReal.png" />--%>
                                    <i class="la la-laptop"></i>
                                    <span><%= Resources.Resource.abrirMonitoramento %></span>
                                </button>

                                <button type="button" class="btn btn-primary" style="font-size: small; padding: 0.5rem;" onclick="VerAgenda();">
                                    <%--  <img src="Images/if_document-08_1622828 (1).png" style="width: 25px;" />--%>
                                    <i class="la la-calendar"></i>
                                    <%= Resources.Resource.verAgenda %></button>
                                <button type="button" class="btn  btn-info " style="font-size: small; padding: 0.5rem;" onclick="VerPlanos();">
                                    <%--<img src="Images/analytics_bar_chart32.png" style="width: 25px;" />--%>
                                    <i class="icon-graph"></i>
                                    <%= Resources.Resource.verPlanos %></button>
                                <button type="button" id="btnCroqui" class="btn btn-warning" style="font-size: small; padding: 0.5rem;" onclick="Croqui()">
                                    <%--<img src="Images/iconfinder_folder-project_287298.png" style="width: 32px;" />--%>
                                    <i class="la la-object-group"></i>
                                    <%= Resources.Resource.croqui %></button>

                                <button type="button" class="btn btn-danger" style="font-size: small; padding: 0.5rem;" onclick="Logs()">
                                    <%-- <img src="Images/lists.png" style="width: 25px;" />--%>
                                    <i class="la la-comment"></i>
                                    <%= Resources.Resource.logs %></button>
                            </div>
                        </div>
                    </div>
                    <%-- <table class="table table-bordered" style="margin-top: -10px;">
                            <tr>
                                <td colspan="2">
                                   
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <b><%= Resources.Resource.programacao %>: </b><span id="lblProgramacao"></span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <b><%= Resources.Resource.ultimaAtualizacaoProgramacao %>: </b>
                                    <span id="lblDtHrAtualizacaoProg">00/00/0000 00:00:00</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b><%= Resources.Resource.ultimaComunicacao %>: </b>
                                    <span id="lblUltComunicacao">00/00/0000 00:00:00</span>
                                </td>
                                <td>
                                    <b>IP:</b>
                                    <span id="lblIP">000.000.000.000</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b><%= Resources.Resource.modoOperacional %>: </b>
                                    <span id="lblModoOperacional"></span>
                                </td>
                                <td>
                                    <b><%= Resources.Resource.tarefasPendentes %>: </b>
                                    <span id="lblTarefasPendentes"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b><%= Resources.Resource.falhas %>: </b><span id="spaFalhas"></span>
                                </td>
                                <td>
                                    <b><%= Resources.Resource.fusoHorario %>: </b><span id="spaTipoHorarioEqp"></span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <b><%= Resources.Resource.porta %>: </b><span id="spaPorta"></span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div class="btn-group" role="group">
                                        <button type="button" id="btnMonitoramento" class="btn  btn-secondary" style="font-size:small;padding: 0.5rem;" onclick="AbrirMonitoramento('');">
                                            <img src="../Images/TempoReal.png" />
                                            <%= Resources.Resource.abrirMonitoramento %></button>

                                        <button type="button" class="btn btn-primary" style="font-size:small;padding: 0.5rem;" onclick="VerAgenda();">
                                            <img src="Images/if_document-08_1622828 (1).png" />
                                            <%= Resources.Resource.verAgenda %></button>
                                        <button type="button" class="btn  btn-info " style="font-size:small;padding: 0.5rem;" onclick="VerPlanos();">
                                            <img src="Images/analytics_bar_chart32.png" />
                                            <%= Resources.Resource.verPlanos %></button>

                                        <button type="button" class="btn btn-danger" style="font-size:small;padding: 0.5rem;" onclick="Logs()">
                                            <img src="Images/lists.png" style="width: 32px;" />
                                            <%= Resources.Resource.logs %></button>
                                    <button type="button" id="btnCroqui" class="btn btn-warning" style="font-size:small;padding: 0.5rem;" onclick="Croqui()">
                                        <img src="Images/iconfinder_folder-project_287298.png" style="width: 32px;" />
                                        <%= Resources.Resource.croqui %></button>
                                    </div>
                                </td>
                            </tr> 
                        </table>--%>
                    <ul class="nav nav-tabs" style="border-bottom: 1px solid  #a198986b;">
                        <li class="nav-item"><a style="border: 1px solid #a198986b; border-bottom: 0px;" class="nav-link active" data-toggle="tab" href="#divListaGrupos" aria-controls="divListaGrupos" aria-expanded="true"><%= Resources.Resource.gruposSemaforicos %></a></li>
                        <li class="nav-item"><a style="border-right: 1px solid #a198986b; border-top: 1px solid  #a198986b;" class="nav-link" data-toggle="tab" href="#divLogsCentral" aria-controls="divLogsCentral" aria-expanded="false">Logs <%= Resources.Resource.controlador %> </a></li>
                        <li class="nav-item"><a style="border-right: 1px solid #a198986b; border-top: 1px solid #a198986b;" class="nav-link" data-toggle="tab" href="#HistReset" aria-controls="HistReset" aria-expanded="false">Status Reset</a></li>
                        <li class="nav-item"><a style="border-right: 1px solid #a198986b; border-top: 1px solid #a198986b;" class="nav-link" data-toggle="modal" data-target="#dvImagens">Imagens</a></li>
                    </ul>

                    <div class="tab-content px-1 pt-1" style="border: 1px solid #a198986b; border-top: 0px">
                        <div id="divListaGrupos" class="tab-pane fade active show" aria-expanded="true" aria-labelledby="base-divListaGrupos">
                            <label><%= Resources.Resource.listaGrupoSemaforico %></label>
                            <table style="margin-top: 10px;" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th><%= Resources.Resource.grupo %></th>
                                        <th><%= Resources.Resource.tipo %></th>
                                        <th><%= Resources.Resource.endereco %></th>
                                    </tr>
                                </thead>
                                <tbody id="tbListaGrupos"></tbody>
                            </table>
                        </div>
                        <div id="divLogsCentral" class="tab-pane fade" aria-labelledby="base-divLogsCentral">
                            <div style="overflow: auto; height: 250px;">
                                <label><%= Resources.Resource.lista %> Logs - <%= Resources.Resource.controlador %></label>
                                <table id="tblLogsCentral" style="margin-top: 10px; height: 250px;" class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <%--<th><%= Resources.Resource.tipo %></th>--%>
                                            <th><%= Resources.Resource.falhas %></th>
                                            <th><%= Resources.Resource.alarme %></th>
                                            <th><%= Resources.Resource.usuario %></th>
                                            <th><%= Resources.Resource.data %>/<%= Resources.Resource.hora %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbLogsCentral"></tbody>
                                </table>
                            </div>
                        </div>
                        <div id="HistReset" class="tab-pane fade" style="margin-top: 15px; width: 95%;" aria-labelledby="base-HistReset">
                            <p>
                                <input type="button" id="btnResetarControl" style="font-size: smaller; padding: 0.5rem;" onclick="ResetarControlador();" class="btn btn-outline-secondary" value="Resetar Controlador" />
                            </p>
                            <p id="pHistReset" style="display: none;">
                                <span class="text-danger">Não há histórico de Reset para este controlador!</span>
                            </p>
                            <p id="pReseteControlador" style="border-bottom: 1px solid #cccccc; display: none;">
                                <span id="spaReseteControlador"></span>
                            </p>
                            <div id="HistoricoReset" style="display: none; height: 200px; overflow-y: scroll;">
                                <table id="tbHistoricoReset" class="table table-bordered">
                                    <caption>Lista de envios de Reset</caption>
                                    <thead style="margin-top: 10px;">
                                        <tr>
                                            <th style="border: 1px solid #d8d8d8; border-collapse: collapse; padding: 5px; width: 250px;">Data</th>
                                            <th style="border: 1px solid #d8d8d8; border-collapse: collapse; padding: 5px; width: 250px;">MIB</th>
                                            <th style="border: 1px solid #d8d8d8; border-collapse: collapse; padding: 5px; width: 250px;">Retorno</th>
                                            <th style="border: 1px solid #d8d8d8; border-collapse: collapse; padding: 5px; width: 250px;">Usuario</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbHistReset"></tbody>
                                </table>
                            </div>
                        </div>

                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="dvImagens" tabindex="-1" role="dialog" aria-labelledby="myModalLabel17" style="display: none; height: 100% !important; margin: 0; padding: 0;" aria-hidden="true">
        <div class="modal-dialog " role="document">
            <div class="modal-content" style="height: auto; min-height: 100%; border-radius: 0;">
                <div class="modal-header">
                    <%--<h4 class="modal-title" id="myModalLabel17">Imagens da intersecção</h4>--%>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: calc(100% - 20px)!important;">
                    <div id="dvImagensCarousel" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                        </ol>
                        <div class="carousel-inner" role="listbox">
                        </div>
                        <a class="carousel-control-prev" href="#dvImagensCarousel" role="button" data-slide="prev" style="top: 20px;">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Anterior</span>
                        </a>
                        <a class="carousel-control-next" href="#dvImagensCarousel" role="button" data-slide="next" style="top: 20px;">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Proximo</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="mpCroqui" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 100%">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <div id="containerSlides" class="container" style="width: 100%">
                        <div id="mySlides" class="mySlides">
                            <div id="numberText" class="numbertext">1 / 6</div>
                            <img src="img_woods_wide.jpg" style="width: 100%" />
                        </div>

                        <a class="prev" onclick="plusSlides(-1)">❮</a>
                        <a class="next" onclick="plusSlides(1)">❯</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="popupConfirmResetarControl" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><%= Resources.Resource.atencao %></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p><%= Resources.Resource.idPonto %>: <span id="spaIdPontoConfirmResete"></span></p>
                    <p><%= Resources.Resource.desejaRestarEqp %></p>
                </div>
                <div class="modal-footer">
                    <button type="button" onclick="HabilitarReseteControl();" class="btn btn-success"><%= Resources.Resource.sim %></button>
                    <button type="button" class="btn btn-danger" onclick="NoReseteControl();"><%= Resources.Resource.nao %></button>
                </div>
            </div>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/e8cc7ed1ec.js" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="Scripts/jsts.min.js"></script>
    <script src="Scripts/leaflet/leaflet.geometryutil.js"></script>
    <script>
        function AbrirGoogleMaps() {
            window.open("https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=" + $("#hfLatLng").val());
        }
        var map; var latLng;
        var marker;
        var arrMarker = [];


        var qtdNormal = 0, qtdFaltaEnergia = 0, qtdSubtencao = 0, qtdDesligado = 0, qtdAmareloIntermitente = 0,
            qtdEstacionado = 0, qtdPlugManual = 0, qtdFalhaComunicacao = 0, qtdSemComunicacao = 0, qtdManutencao = 0,
            qtdFalhas = 0, qtdPortaAberta = 0, qtdImposicaoPlano = 0;

        var falhas = "", Zoom = "";
        var timerLoadDnaMap, timerAvisoCtrl, timerSyncTasks;
        var iPandPort;
        var user, pwd;

        var directions;

        var callServer = function (urlName, params, callback) {
            $("#divLoading").css("display", "block");
            $.ajax({
                type: 'POST',
                url: urlName,
                dataType: 'json',
                data: params,
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (callback && typeof (callback) == "function") {
                        callback(data.d);
                    }
                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    params = data; alert('Erro ao obter parametros map!');
                    window.location.reload(true);
                }
            });
        };

        $(function () {
            loadResourcesLocales();
        })

        var globalResources;
        function loadResourcesLocales() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: 'MapaBeta.aspx/requestResource',
                dataType: "json",
                success: function (data) {
                    globalResources = JSON.parse(data.d);
                }
            });
        }

        function getResourceItem(name) {
            if (globalResources != undefined) {
                for (var i = 0; i < globalResources.resource.length; i++) {
                    if (globalResources.resource[i].name === name) {
                        return globalResources.resource[i].value;
                    }
                }
            }
        }

        function LoadMap(lat, lng, zoom, tempoAtualizacao) {

            var timerLoadDnaMap;

            L.mapbox.accessToken = 'pk.eyJ1IjoiemVsYW8iLCJhIjoiY2lndjU5Zmx3MGhvenZxbTNlOWQ4YXE1ZCJ9.oGn84GgkJqonGYYm5bqi8Q';
            map = L.mapbox.map('map', 'mapbox.streets')
                .addControl(L.mapbox.geocoderControl('mapbox.places', {
                    autocomplete: true
                }));

            var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                osmAttribution = 'Map data &copy; 2012 <a href="http://openstreetmap.org">OpenStreetMap</a> contributors',
                osm = new L.TileLayer(osmUrl, { maxZoom: 18, attribution: osmAttribution });

            if (lat == "")
                lat = -23.1543;

            if (lng == "")
                lng = -47.43877;

            if (zoom == "")
                zoom = 12;

            if (tempoAtualizacao == "")
                tempoAtualizacao = 180000;

            map.setView(new L.LatLng(lat, lng), zoom).addLayer(osm);
            FilterMap("", "", "", "");
            //map.on('click', onMapClick);

            timerLoadDnaMap = setInterval(function () { FilterMap("", "", "", ""); }, tempoAtualizacao);
        }

        var popup = L.popup();

        function onClickMarker(e) {
            var idPonto = this.label._content;

            if (this.options.title != "FC") {
                $("#lblModoOperacional").text(getResourceItem("centralizado"));
            }
            else $("#lblModoOperacional").text("Local");

            document.getElementById('hfIdPonto').value = idPonto;
            document.getElementById("lblIdPonto").innerHTML = "<b>" + getResourceItem("idPonto") + ":</b> " + idPonto;

            if ($("#chkModoNobreak").is(":checked")) {
                $('.nav-tabs a[href="#nobreak"]').tab('show');
            }
            else {
                $('.nav-tabs a[href="#controlador"]').tab('show');
            }

            $("#hfLatLng").val(this._latlng.lat + "," + this._latlng.lng);
            //$("#divLoad").css("display", "block");

            GetDetailsDna(idPonto);
        }



        function FilterMap(consorcio, empresa, idPonto, status) {

            var i = arrMarker.length - 1;
            while (arrMarker[i]) {
                map.removeLayer(arrMarker[i]);
                arrMarker.pop(i);
                i--;
            }

            $("#chkLabelMarker").data("checked", false);

            callServer('WebServices/Map.asmx/LoadFilterMap', "{'consorcio':'" + consorcio + "','empresa':'" + empresa + "','idPonto':'" + idPonto + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','endereco':''}", function (eqp) {
                var qtdNormalNob = 0, qtdFalhaNob = 0, qtdUsoNob = 0, qtdSemComunicaoNob = 0;
                $.each(eqp, function (index, item) {
                    var statusPorta = "";

                    if (item.statusManutencao != "-1") {
                        CreateMarker(item.latitude, item.longitude, item.statusManutencao, item.idDna, "M", "" + item.estadoNobreak, status);
                        qtdManutencao++;
                        $("#btnAbrirOs").css("display", "none");
                    }
                    else {
                        $("#btnAbrirOs").css("display", "");
                        if (item.porta == "1") {
                            qtdPortaAberta++;
                            statusPorta = "P";
                        }
                        else {
                            statusPorta = "";
                        }

                        switch (item.statusComunicacao) {
                            case "True":
                                var bitsFalha = parseInt(item.falha).toString(2);
                                falhas = "";
                                var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaPonto", "");
                                CreateMarker(item.latitude, item.longitude, verificaFalhas.statusFalha, item.idDna, falhas, statusPorta + item.estadoNobreak, status);
                                break;
                            case "False":
                                CreateMarker(item.latitude, item.longitude, "FalhaComunicacao", item.idDna, "FC", statusPorta + item.estadoNobreak, status);
                                // qtdFalhaComunicacao++;
                                break;
                        }
                    }
                    switch (item.estadoNobreak) {
                        case "Normal":
                            qtdNormalNob++;
                            break;
                        case "Falha":
                            qtdFalhaNob++;
                            break;
                        case "EmUso":
                            qtdUsoNob++;
                            break;
                        case "SC":
                            qtdSemComunicaoNob++;
                            break;
                    }
                    //map.setView(new L.LatLng(item.latitude, item.longitude), 13);
                });
                //EstatisticaFalha();

                //if ($("#chkModoNobreak").is(":checked")) {
                //    filterNobreakMap("init");
                //}
                //if ($("#ckdmodoEstatisticaCtrl").is(":checked")) {
                //    filterAllMapCtrl();
                //}
                //else {
                //    FiltraFalha();
                //}
            });

        }

        var position = new Object();

        function GetLatLng() {

            var latPosition = latLng.indexOf(",");
            var lat = latLng.substring(7, latPosition);
            var lng = latLng.substring(latPosition + 1).replace(')', '');

            position.Lat = lat;
            position.Lng = lng;

        }


        function VerificaFalhas(bitsFalha, callName, status) {

            this.statusFalha = "";
            this.falhas = "";

            if (bitsFalha == 0) {
                if (callName == "CarregaPonto") {
                    this.statusFalha = "Normal";
                    falhas = "N";
                    qtdNormal++;
                }
                else if (callName == "CarregaFalha") {
                    this.falhas = "Normal";
                }
            }
            else {
                if (callName == "CarregaPonto") {
                    this.statusFalha = "Falha";
                    qtdFalhas++;
                }

                bitsFalha = bitsFalha.split('').reverse().join('');
                for (var positionBit = 0; positionBit < bitsFalha.length; positionBit++) {
                    //Falta de Energia
                    if (positionBit == 0 && bitsFalha[positionBit] == "1") {

                        if (callName == "CarregaPonto") {
                            falhas = "F";
                            qtdFaltaEnergia++;
                        }

                        else if (callName == "CarregaFalha") {
                            this.falhas = "Falta de Energia";
                        }
                    }

                    //Subtensao
                    if (positionBit == 1 && bitsFalha[positionBit] == "1") {

                        if (callName == "CarregaPonto") {
                            if (falhas == "") {
                                falhas = "S";
                            }
                            else {
                                falhas += ",S"
                            }

                            qtdSubtencao++;
                        }
                        if (callName == "CarregaFalha") {
                            if (this.falhas == "") {
                                this.falhas = "Subtensao";
                            }
                            else {
                                this.falhas += ",Subtensao";
                            }
                        }
                    }

                    //Apagado/Desligado
                    if (positionBit == 2 && bitsFalha[positionBit] == "1") {
                        if (callName == "CarregaPonto") {
                            if (falhas == "") {
                                falhas = "D";
                            }
                            else {
                                falhas += ",D"
                            }

                            qtdDesligado++;
                        }
                        if (callName == "CarregaFalha") {
                            if (this.falhas == "") {
                                this.falhas = "Apagado/Desligado";
                            }
                            else {
                                this.falhas += ",Apagado/Desligado";
                            }
                        }
                    }

                    //Amarelo intermitente
                    if (positionBit == 3 && bitsFalha[positionBit] == "1") {
                        if (callName == "CarregaPonto") {
                            if (falhas == "") {
                                falhas = "A";
                            }
                            else {
                                falhas += ",A"
                            }

                            qtdAmareloIntermitente++;
                        }
                        if (callName == "CarregaFalha") {
                            if (this.falhas == "") {
                                this.falhas += "Amarelo intermitente";
                            }
                            else {
                                this.falhas += ",Amarelo intermitente";
                            }
                        }
                    }

                    //Estacionado
                    if (positionBit == 4 && bitsFalha[positionBit] == "1") {
                        if (callName == "CarregaPonto") {
                            if (falhas == "") {
                                falhas = "E";
                            }
                            else {
                                falhas += ",E";
                            }
                        }
                        if (callName == "CarregaFalha") {
                            if (this.falhas == "") {
                                this.falhas += "Estacionado";
                            }
                            else {
                                this.falhas += ",Estacionado";
                            }
                        }
                    }

                    //Plug Manual
                    if (positionBit == 5 && bitsFalha[positionBit] == "1") {
                        this.statusFalha = "Plug"
                        qtdPlugManual++;
                    }

                    //Imposicao Plano
                    if (positionBit == 6 && bitsFalha[positionBit] == "1") {
                        this.statusFalha = "Imposicao"
                        qtdImposicaoPlano++;
                    }
                }
            }
        }


        function GetDetailsDna(idPonto) {
            callServer('WebServices/Map.asmx/GetDetailsDna', "{'idPonto':'" + idPonto + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}", function (eqp) {
                $("#lblTensao")[0].innerHTML = "";
                $("#lblTemperatura")[0].innerHTML = "";
                $("#lblEstado")[0].innerHTML = "";
                $("#lblSerialMestre")[0].innerHTML = "";
                $("#lblLinkMap")[0].innerHTML = "";
                if (eqp.length > 0) {
                    $("#lblIP")[0].innerHTML = eqp[0].ipCtrl;
                    if (eqp[0].dtManutencaoCtrl == "")
                        $("#btnResetarControl").css("display", "block");
                    else
                        $("#btnResetarControl").css("display", "none");

                    var dtHorarioVerao = eqp[0].horarioVeraoEqp.split('-');
                    if (dtHorarioVerao.length > 1) {
                        var yyyy = "", MM = "", dd = "";

                        yyyy = dtHorarioVerao[0].substring(0, 4);
                        MM = dtHorarioVerao[0].substring(4, 6);
                        dd = dtHorarioVerao[0].substring(6, 8);
                        var dataInicioHoraVerao = new Date(yyyy, MM - 1, dd);

                        yyyy = dtHorarioVerao[1].substring(0, 4);
                        MM = dtHorarioVerao[1].substring(4, 6);
                        dd = dtHorarioVerao[1].substring(6, 8);
                        var dataFinalHoraVerao = new Date(yyyy, MM - 1, dd);

                        if (dataInicioHoraVerao <= new Date() && dataFinalHoraVerao >= new Date())
                            $("#spaTipoHorarioEqp").text(getResourceItem("horarioVerao"));//+ " - BRST (GMT -2)"
                        else $("#spaTipoHorarioEqp").text(getResourceItem("horarioBrasilia"));// + " - BRT (GMT -3)"
                    } else $("#spaTipoHorarioEqp").text(getResourceItem("horarioBrasilia")); //+ " - BRT (GMT -3)"

                    document.getElementById("lblCruzamento").innerHTML = "<b>" + getResourceItem("cruzamento") + ":</b> " + eqp[0].cruzamento;

                    if (eqp[0].porta == ("1")) {
                        document.getElementById("spaPorta").innerHTML = "Aberta";
                        $("#spaPorta").css("color", "green");
                    }
                    else {
                        document.getElementById("spaPorta").innerHTML = "Fechada";
                        $("#spaPorta").css("color", "red");
                    }

                    if (eqp[0].dtManutencaoCtrl != "") {
                        $("#btnAbrirOs").css("display", "none");
                    }
                    else {
                        $("#btnAbrirOs").css("display", "");
                    }

                    if (eqp[0].tensao != "") {
                        $("#lblTensao")[0].innerHTML = eqp[0].tensao;
                        $("#itensao").show();
                    }
                    else {
                        $("#itensao").hide();
                    }

                    if (eqp[0].temperatura != "") {
                        $("#lblTemperatura")[0].innerHTML = eqp[0].temperatura;
                        $("#itemp").show();
                    }
                    else {
                        $("#itemp").hide();
                    }

                    if (eqp[0].estadofunc != "") {
                        $("#lblEstado")[0].innerHTML = eqp[0].estadofunc;
                        $("#iestado").show();
                    }
                    else {
                        $("#iestado").hide();
                    }


                    if (eqp[0].serialMestre != "") {
                        $("#lblSerialMestre")[0].innerHTML = "Controlador Mestre: " + eqp[0].serialMestre;
                        //$("#iestado").show();
                    }
                    else {
                        //$("#iestado").hide();
                    }

                    if (eqp[0].linkmap != "") {
                        $("#lblLinkMap")[0].innerHTML = '<a href="' + eqp[0].linkmap + '" style="color: #1a73e8; font - size: larger;" target="_blank">Google Maps</a>';
                        //$("#iestado").show();
                    }
                    else {
                        //$("#iestado").hide();
                    }

                    $.ajax({
                        type: 'POST',
                        url: 'WebServices/Map.asmx/GetProgramacaoEqp',
                        dataType: 'json',
                        data: "{'idEqp':'" + idPonto + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d == "") {
                                $("#lblProgramacao")[0].innerHTML = getResourceItem("semProgramacao");
                            }
                            else {
                                $("#lblProgramacao")[0].innerHTML = data.d[0].Programacao;
                                $("#lblDtHrAtualizacaoProg")[0].innerHTML = data.d[0].DtHrAtualizacaoProg;
                                $("#lblUltComunicacao")[0].innerHTML = data.d[0].ultComunicacao;
                                $("#lblTarefasPendentes")[0].innerHTML = getTraducaoTarefas(data.d[0].Tarefas);
                            }
                        },
                        error: function (data) {

                        }
                    });
                    $.ajax({
                        type: 'POST',
                        url: 'WebServices/Map.asmx/CarregaArquivosCroqui',
                        dataType: 'json',
                        data: "{'idEqp':'" + idPonto + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var i = 0;
                            if (data.d.length == 0) {
                                $("#btnCroqui").css("display", "none");
                            }
                            else {
                                $("#containerSlides").empty();
                                $("#btnCroqui").css("display", "");
                                while (data.d[i]) {
                                    var lst = data.d[i];
                                    if (data.d[i].NomeArquivo.toLowerCase().indexOf(".jpg") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".png") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".gif") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".jpeg") > -1) {

                                        var div = $("<div id=\"mySlides\" class=\"mySlides\">");
                                        //var item = "< span id =\"numberText\" class=\"numbertext\" >" + i + " / " + data.d.length + "</span >";
                                        //div.append(item);
                                        item = "<img src=\"../Register/Controller/ArquivoCroqui/" + lst.NomeArquivo + "\" style=\"width:100%\" /> ";
                                        div.append(item);

                                        $("#containerSlides").append(div);
                                    }
                                    i++;
                                }

                                $("#containerSlides").append("<a class=\"prev\" onclick =\"plusSlides(-1)\" >❮");
                                $("#containerSlides").append("<a class=\"next\" onclick =\"plusSlides(1)\" >❯");

                            }
                        }
                    });

                    iPandPort = eqp[0].hostNameCam;
                    user = eqp[0].userNameCam;
                    pwd = eqp[0].passwordCam;
                    $("#lblUltComunicacao")[0].innerHTML = eqp[0].atualizadoCtrl;// .ultComunicacao;

                    switch (eqp[0].statusComunicacao) {
                        case "True":
                            var bitsFalha = parseInt(eqp[0].falha).toString(2);
                            var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha", "");
                            document.getElementById("spaFalhas").innerHTML = verificaFalhas.falhas;
                            $("#btnSemComunicacao").css("display", "none");
                            if (verificaFalhas.falhas == "Normal") {
                                $("#spaFalhas").css("color", "green");
                            }
                            else {
                                $("#spaFalhas").css("color", "red");
                            }
                            break;
                        case "False":
                            if (eqp[0].semComunicacao == "0") {
                                document.getElementById("spaFalhas").innerHTML = getResourceItem("falhasNaComunicacao");
                                $("#btnSemComunicacao").css("display", "");
                            }
                            else {
                                document.getElementById("spaFalhas").innerHTML = getResourceItem("semComunicacao");
                                $("#btnSemComunicacao").css("display", "none");
                            }
                            $("#spaFalhas").css("color", "red");
                            break;
                    }

                }
                else {

                    $("#itensao").hide();
                    $('#itemp').hide();
                    $('#iestado').hide();
                    document.getElementById("lblCruzamento").innerHTML = "<b>" + getResourceItem("cruzamento") + ":</b> " + getResourceItem("dadoNaoCadastrado");
                    document.getElementById("lblTipo").innerHTML = getResourceItem("dadoNaoCadastrado");
                    document.getElementById("lblModelo").innerHTML = getResourceItem("dadoNaoCadastrado");
                    document.getElementById("spaNmrFases").innerHTML = getResourceItem("dadoNaoCadastrado");

                    $("#btnAbrirOs").css("display", "");
                }

                $("#hfIdEqp").val(idPonto);
                $("#btnAbrirOs").attr("data-id", idPonto);
                $("#btnVoltarManutencao").data("voltar", "#divPopupMarker");
                lastResetsCtrl(idPonto);
                $("#divPopupMarker").modal("show");
                ListaGrupos();
                ListaLogsOperacaoCentral();
                ListaImagensIterseccao();
            });
        }


        function CreateMarker(lat, lng, statusFalha, idDna, siglaFalha, statusPorta, callStatus) {

            var cor = "", icon = "";

            switch (statusFalha) {
                case "Normal":
                    icon = 'traffic-light';
                    cor = 'green';
                    break;

                case "Falha":
                    icon = 'traffic-light';
                    cor = 'red';
                    break;

                case "FalhaComunicacao":
                    icon = 'traffic-light';
                    cor = 'gray';
                    break;

                case "Imposicao":
                    icon = 'download';
                    cor = 'orange';
                    siglaFalha = "IP"
                    break;

                case "Plug":
                    icon = 'plug';
                    cor = 'blue';
                    siglaFalha = "PL"
                    break;

                case "SemComunicacao":
                    icon = 'traffic-light';
                    cor = 'black';
                    break;
                case "0":
                    icon = 'traffic-light';
                    cor = 'black';
                    break;
                case "1":
                    icon = 'traffic-light';
                    cor = 'black';
                    break;
            }

            var iconFalha = L.AwesomeMarkers.icon({ icon: icon, prefix: 'fas', markerColor: cor, iconColor: '#fff' });

            if (callStatus == "Filter") {
                for (var i = 0; i < arrMarker.length; i++) {
                    if (idDna == arrMarker[i].label._content) {
                        arrMarker[i].setLatLng([lat, lng]);
                        arrMarker[i].options.title = siglaFalha;
                        arrMarker[i].options.icon = iconFalha;
                        arrMarker[i].options.alt = statusPorta;
                        map.removeLayer(arrMarker[i]);
                        map.addLayer(arrMarker[i]);
                        //map.setZoom(map.getZoom());
                        break;
                    }
                }
            }
            else {
                marker = L.marker([lat, lng], {
                    title: siglaFalha, radius: 10, icon: iconFalha, alt: statusPorta
                }).bindLabel(idDna, { noHide: false, offset: [12, -15] }).addTo(map).on('click', onClickMarker);
                arrMarker.push(marker);
            }

        }

        function getTraducaoTarefas(tarefas) {
            var tarefaItens = tarefas.split(';');
            $.each(tarefaItens, function (index, item) {
                tarefaItens[index] = item.indexOf("Imposição de Plano") != -1 ? getResourceItem("imposicaoPlano") : tarefaItens[index];
                tarefaItens[index] = item.indexOf("Cancelamento Plano Imposto") != -1 ? getResourceItem("cancelamento") + " - " + getResourceItem("imposicaoPlano") : tarefaItens[index];
                tarefaItens[index] = item.indexOf("Enviar Programação") != -1 ? getResourceItem("enviarProgramacao") : tarefaItens[index];
                tarefaItens[index] = item.indexOf("Enviar Agenda") != -1 ? getResourceItem("enviarAgenda") : tarefaItens[index];
                tarefaItens[index] = item.indexOf("Enviar Horario de Verão") != -1 ? getResourceItem("enviarHorarioVerao") : tarefaItens[index];
                tarefaItens[index] = item.indexOf("Enviar Imagem") != -1 ? getResourceItem("enviarImagem") : tarefaItens[index];
                tarefaItens[index] = item.indexOf("Centralizar") != -1 ? getResourceItem("centralizar") : tarefaItens[index];
                tarefaItens[index] = item.indexOf("Reset Anel") != -1 ? item.replace("Anel", getResourceItem("anel")) : tarefaItens[index];
                tarefaItens[index] = item.indexOf("Nenhuma") != -1 ? getResourceItem("nenhumaTarefa") : tarefaItens[index];
            });

            return tarefaItens.toString().split(',').join('; ');
        }

        function lastResetsCtrl(idPonto) {
            callServer('WebServices/Map.asmx/GetLastResets', "{'idPonto':'" + idPonto + "'}", function (resul) {
                if (resul.toString() == "") {
                    $("#pHistReset").css("display", "block");
                    $("#HistoricoReset").css("display", "none");
                }
                else {
                    $("#pHistReset").css("display", "none");
                    $("#HistoricoReset").css("display", "block");
                    $("#tbHistReset").empty();
                    $.each(resul, function (index, item) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td>" + item.dtResetCtrl + "</td>";
                        cols += "<td>" + item.mib + "</td>";
                        cols += "<td>" + item.RetornoReset + "</td>";
                        cols += "<td>" + item.usuario + "</td>";
                        newRow.append(cols);
                        $("#tbHistoricoReset").append(newRow);
                    });

                    $("#divPopupMarker").modal("show");
                }
            });
        }

        function ListaGrupos() {
            $.ajax({
                type: 'POST',
                url: 'WebServices/Map.asmx/GetListaGrupos',
                dataType: 'json',
                data: "{'idEqp':'" + $("#hfIdEqp").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbListaGrupos").empty();
                    if (data.d != "") {
                        $.each(data.d, function (index, item) {
                            var tipo = item.Tipo.indexOf("VEICULAR") != -1 ? getResourceItem("veicular").toUpperCase() : getResourceItem("pedestre").toUpperCase();

                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='width:16%'>" + item.Grupo.replace("Anel", getResourceItem("anel")) + "</td>";
                            cols += "<td style='width:88px;'>" + tipo + "</td>";
                            cols += "<td>" + item.Endereco + "</td>";
                            newRow.append(cols);
                            $("#tbListaGrupos").append(newRow);
                        });
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='3'>" + getResourceItem("naoHaRegistros") + "</td >";
                        newRow.append(cols);
                        $("#tbListaGrupos").append(newRow);
                    }
                },
                error: function (data) {

                }
            });
        }


        function ListaLogsOperacaoCentral() {
            $.ajax({
                type: 'POST',
                url: 'WebServices/Map.asmx/GetLogsOperacaoCentral',
                dataType: 'json',
                data: "{'idEqp':'" + $("#hfIdEqp").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbLogsCentral").empty();
                    if (data.d != "") {
                        $.each(data.d, function (index, item) {
                            var newRow = $("<tr>");
                            var cols = "";
                            //cols += "<td>" + item.tipo + "</td>";
                            //cols += "<td>" + item.funcao + "</td>";

                            var bitsFalha = parseInt(item.Falha).toString(2);
                            var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha", "");

                            cols += "<td>" + verificaFalhas.falhas + "</td>";
                            cols += "<td>" + item.Alarme + "</td>";
                            cols += "<td>" + item.usuario + "</td>";
                            cols += "<td>" + item.dataHora + "</td>";
                            newRow.append(cols);
                            $("#tbLogsCentral").append(newRow);
                        });
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='4'>" + getResourceItem("naoHaRegistros") + "</td >";
                        newRow.append(cols);
                        $("#tbLogsCentral").append(newRow);
                    }
                }
            });
        }


        function ListaImagensIterseccao() {
            $('.carousel-inner, .carousel-indicators').empty()
            $.ajax({
                type: 'POST',
                url: 'WebServices/Map.asmx/CarregaImagensIterseccao',
                dataType: 'json',
                data: "{'idEqp':'" + $("#hfIdEqp").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbLogsCentral").empty();
                    if (data.d != "") {

                        var i = 0;
                        while (data.d[i]) {
                            if (i == 0) {
                                $('<div class="carousel-item active"><a href="' + data.d[i] + '" target="_blank">Ampliar</a> <br/><br/><img src="' + data.d[i] + '" class="d-block w-100"><div class="carousel-caption"></div>   </div>').appendTo('.carousel-inner');
                                $('<li data-target="#dvImagensCarousel" data-slide-to="' + i + '" class="active"></li>').appendTo('.carousel-indicators')
                            }
                            else {
                                $('<div class="carousel-item"><a href="' + data.d[i] + '" target="_blank">Ampliar</a> <br/><br/><img src="' + data.d[i] + '" class="d-block w-100"><div class="carousel-caption"></div>   </div>').appendTo('.carousel-inner');

                                $('<li data-target="#dvImagensCarousel" data-slide-to="' + i + '"></li>').appendTo('.carousel-indicators')
                            }
                            //$('<a href="' + data.d[i] + '" target="_blank">Ampliar</a> ').appendTo('.carousel-inner');
                            i++;
                        }
                        //$('.item').first().addClass('active');
                        //$('.carousel-indicators > li').first().addClass('active');
                        $('#dvImagensCarousel').carousel();
                    }
                }
            });
        }
        function Logs() {
            window.open("Controlador/Logs.aspx?idEqp=" + $("#hfIdPonto").val());
        }

        function VerAgenda() {
            window.open("Controlador/Agenda.aspx?idEqp=" + $("#hfIdPonto").val());
        }

        function VerPlanos() {
            window.open("http://187.122.100.125:90/chart/Default.aspx?idEqp=" + $("#hfIdPonto").val());
        }
        function Croqui() {
            var slideIndex = 0;
            showSlides(slideIndex);
            $("#mpCroqui").modal("show");
        }

        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        function currentSlide(n) {
            showSlides(slideIndex = n);
        }

        function showSlides(n) {
            var i;
            var slides = document.getElementsByClassName("mySlides");
            if (n > slides.length) { slideIndex = 1 }
            if (n < 1) { slideIndex = slides.length }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slides[slideIndex - 1].style.display = "block";
        }
        function AbrirMonitoramento(idEqp) {
            if (idEqp == "")
                idEqp = $("#lblIdPonto").text().replace("<%= Resources.Resource.idPonto %>", "").replace(": ", "");

            window.open("MonitoramentoCentral/Monitoramento.aspx?IdEqp=" + idEqp);
        }

        function ResetarControlador() {
            $("#divPopupMarker").modal("hide");
            $("#spaIdPontoConfirmResete").empty();
            $("#spaIdPontoConfirmResete").append(document.getElementById('hfIdPonto').value);
            document.getElementById("hfUserPermReset").value = "";

            $("#popupConfirmResetarControl").modal("show");
        }

        function HabilitarReseteControl() {
            var idPonto = $("#lblIdPonto").text().replace(getResourceItem("idPonto") + ": ", "");
            var user = document.getElementById("hfUserPermReset").value;
            $.ajax({
                type: 'POST',
                url: "WebServices/Map.asmx/ResetaControlador",
                dataType: 'json',
                data: "{'idPonto':'" + idPonto + "','userPermReset':'" + user + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#popupConfirmResetarControl").modal("hide");
                    alert(getResourceItem("reset") + " " + getResourceItem("imposicao") + " " + getResourceItem("solicitada") + "!");
                },
                error: function (data) {
                    window.location.reload(true);
                }
            });
        }

        function NoReseteControl() {
            $("#divPopupMarker").modal("show");
            $("#popupConfirmResetarControl").modal("hide");
        }
    </script>
    <script type="text/javascript" src="Scripts/distLeaflet/leaflet.zoomdisplay-src.js"></script>
    <script src="dist-leaflet-markers/leaflet.awesome-markers.js"></script>
</asp:Content>
