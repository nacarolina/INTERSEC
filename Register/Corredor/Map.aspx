<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="GwCentral.Register.Corredor.Map" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
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
    <link rel="stylesheet" href="../../dist-leaflet-markers/leaflet.awesome-markers.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.mapa %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hdfTypeMarker" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfIdCorredor" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfUser" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfEndereco" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfOrigem" runat="server" ClientIDMode="Static" />

    <div id="map" style="position: absolute; width: 100%; height: 100%; overflow: hidden; top: 0px; left: 0px"></div>

   <%-- <button class="btn btn-secondary" id="dvCadastro" style="margin-top: 2%; position: absolute">
        <%= Resources.Resource.abrir %> <%= Resources.Resource.cadastro %>
    </button>--%>
    <div class="col-lg-4 col-md-6 col-sm-12" style="padding-top: 2%;left:-20px; padding-left: 0px">
        <div class="card box-shadow-0">
            <div class="card-header white bg-info">
                <h4 class="card-title white">
                    <span><%= Resources.Resource.cadastro %> <%= Resources.Resource.corredor %></span>
                    <span class="pull-right" id="slide-submenu">
                        <button class="btn btn-outline-dark btn-sm" style="margin-right: 10px; display: none" id="btnLimparDesenho" onclick="LimparDesenho()">Limpar desenho</button>
                        <%--<i class="fa fa-times"></i>--%></span>
                </h4>
            </div>
            <div class="card-content collapse show">
                <div class="card-body border-bottom-info" style="padding: 0px" <%--style="border-bottom: 2px solid #f2f222 !important;"--%>>
                    <%--<div class="list-group-item" style="height: 52px; padding-top: 0px">
                        <p style="font-size: smaller; font-style: italic; margin-top: 10px">Para desenhar a rota clique no botão localizado na parte superior-meio do mapa com o ícone: </p>
                            <div style="width: 16px; height: 16px; top: -32px; float: right; overflow: hidden; position: relative; padding-right: 40%;">
                                <img alt="" src="https://maps.gstatic.com/mapfiles/drawing.png" draggable="false" style="position: absolute; left: 0px; top: -32px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 16px; height: 192px;" />
                            </div>
                    </div>--%>
                    <div class="list-group-item">
                        <%= Resources.Resource.corredor %>:
                                <input class="form-control" id="txtCorredor" />
                    </div>
                    <div class="list-group-item" style="display:none;">
                        <%= Resources.Resource.tempoPercurso %>:
                                <input class="form-control" id="txtTempoPercurso" />
                    </div>
                    <div class="list-group-item">
                        <label><%= Resources.Resource.gruposVinculados %></label>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Eqp</th>
                                        <th><%= Resources.Resource.grupo %></th>
                                        <th><%= Resources.Resource.endereco %></th>
                                        <th><%= Resources.Resource.distancia %></th>
                                    </tr>
                                </thead>
                                <tbody id="tbGruposAdicionados">
                                </tbody>
                                <tfoot id="tfGruposAdicionados">
                                    <tr>
                                        <td colspan="4"><%= Resources.Resource.naoHaRegistros %></td>
                                    </tr>
                                </tfoot>
                            </table>

                        </div>
                    </div>
                    <div style="height: 50px; padding: 8px; background-color: white">
                        <button type="button" id="btnSalvar" onclick="SalvarCorredor()" class="btn btn-success">Salvar</button>
                        <button type="button" id="" onclick="Voltar()" class="btn btn-warning">Voltar</button>
                        
                        <button id="btnExcluir" class="btn btn-danger" style="display:none; " onclick="excluirCorredor()"><%= Resources.Resource.excluir %></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="alert alert-info" style="left: 77.6%; position: absolute; top: 9%; background-color: #e2f1fe; display: none;">
        <strong style="color: #1962a1">Info!</strong><p class="modal-title text-muted" style="display: inline-block; padding-left: 10px;" id="smallGpSelecionado"><%= Resources.Resource.grupoSemaforicoSelecionado %>: XX</p>
    </div>

    <script src="https://kit.fontawesome.com/e8cc7ed1ec.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <script src="https://maps.googleapis.com/maps/api/js?libraries=drawing,places,geometry&key=AIzaSyAEbTl1Ap78hKxlDNENs6iu8iBBJaWg2Lc"></script>
    <script>
        var map;

        var polylines = [];
        var polylinesDraw = [];
        var snappedCoordinates = [];
        var LatLngPoints;
        var markers = [];
        var snappedPolyline = new google.maps.Polyline();
        var drawingManager;

        $(function () {
            loadResourcesLocales();
            Geocodificacao("Centro, Foz do Iguaçu", '', $("#hdfId").val());
        });

        function carregarCorredor() {
            snappedCoordinates = [];
            for (var i = 0; i < polylines.length; ++i) {
                polylines[i].setMap(null);
            }
            polylines = [];
            polylinesDraw = [];
            for (var i = 0; i < markers.length; ++i) {
                markers[i].setMap(null);
            }
            snappedCoordinates = [];
            markers = [];

            $.ajax({
                type: 'POST',
                url: 'Map.aspx/CarregarCorredor',
                dataType: 'json',
                data: "{'idCorredor':'" + $("#hfIdCorredor").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        var i = 0;
                        var lst = data.d[i];
                        var lstWayPoints = data.d[i].WayPoints.split('),(');
                        $("#txtCorredor").val(lst.NomeCorredor);
                        $("#txtTempoPercurso").val(lst.TempoPercurso);

                        $("#btnExcluir").css("display", "");
                        var latlng;
                        for (i = 0; i < lstWayPoints.length; i++) {
                            if (lstWayPoints[i] != "") {
                                if (lstWayPoints[i].toString().substring(0, 1) === ",") {
                                    LatLngPoints = lstWayPoints[i].toString().replace(",", "");
                                }
                                else {
                                    LatLngPoints = lstWayPoints[i].toString();
                                }

                                LatLngPoints = LatLngPoints.split(",");
                                lat = LatLngPoints[0].replace("(", ""), lng = LatLngPoints[1].replace(")", "");

                                latlng = new google.maps.LatLng(lat, lng);
                                snappedCoordinates.push(latlng);
                            }

                        }
                        drawSnappedPolyline();
                        map.setCenter(latlng);
                        map.setZoom(16);

                    }
                    else {

                        $("#btnExcluir").css("display", "none");
                    }
                },
                error: function (data) {

                }

            });
        }

        function getPolygonCoords() {

            var len = snappedPolyline.getPath().getLength();
            var htmlStr = "";
            snappedCoordinates = [];
            for (var i = 0; i < len; i++) {
                var coords = snappedPolyline.getPath().getAt(i).toUrlValue().split(",");
                var latlng = new google.maps.LatLng(coords[0], coords[1]);
                snappedCoordinates.push(latlng);
            }
            drawSnappedPolyline();
        }

        function drawSnappedPolyline() {
            for (var i = 0; i < polylinesDraw.length; ++i) {
                polylinesDraw[i].setMap(null);
            }
            polylinesDraw = [];
            for (var i = 0; i < polylines.length; ++i) {
                polylines[i].setMap(null);
            }
            polylines = [];

            snappedPolyline = new google.maps.Polyline({
                path: snappedCoordinates,
                strokeColor: 'black',
                strokeWeight: 3,
                editable: true,
                map: map
            });

            var distance = google.maps.geometry.spherical.computeLength(snappedPolyline.getPath()) / 1000;
            $("#total").val(distance.toFixed(1));
            polylines.push(snappedPolyline);

            google.maps.event.addListener(snappedPolyline.getPath(), "insert_at", getPolygonCoords);
            google.maps.event.addListener(snappedPolyline.getPath(), "remove_at", getPolygonCoords);
            google.maps.event.addListener(snappedPolyline.getPath(), "set_at", getPolygonCoords);
            var p = snappedCoordinates.length - 1;


            clear();
            createMarkerStartEnd(snappedCoordinates[0].toUrlValue(), snappedCoordinates[p].toUrlValue());
        }

        function clear() {

            for (var i = 0; i < markers.length; ++i) {
                markers[i].setMap(null);
            }
            markers = [];
            return false;
        }

        function createMarkerStartEnd(LatLngStart, LatLngEnd) {
            if ($("#hfOrigem").val() == "novo")
                $("#btnLimparDesenho").css("display", "");

            if ($("#btnSalvar").html() == "Salvar Alterações") {

                for (var i = 0; i < markers.length; ++i) {
                    markers[i].setMap(null);
                }
                markers = [];
            }

            LatLngStart = LatLngStart.split(",");
            lat = LatLngStart[0], lng = LatLngStart[1];
            var latlngMarkerStart = new google.maps.LatLng(lat, lng);

            obtemEnderecoMarkerStart(latlngMarkerStart);
            var markerStart = new google.maps.Marker({
                icon: '/Register/Corredor/markerStart.png',
                position: latlngMarkerStart,
                title: "Ponto de Partida"
            });
            markerStart.setMap(map);
            markers.push(markerStart);

            LatLngEnd = LatLngEnd.split(",");
            lat = LatLngEnd[0], lng = LatLngEnd[1];
            var latlngMarkerEnd = new google.maps.LatLng(lat, lng);

            var markerEnd = new google.maps.Marker({
                icon: '/Register/Corredor/markerEnd.png',
                position: latlngMarkerEnd,
                title: "Ponto Final"
            });
            markerEnd.setMap(map);
            markers.push(markerEnd);
        }

        function obtemEnderecoMarkerStart(latlng) {
            geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'location': latlng }, function (results, status) {
                if (status === 'OK') {
                    if (results[0]) {
                        $("#hfEndereco").val(results[0].address_components[1].short_name);
                        $("#txtCorredor").val(results[0].address_components[1].short_name);

                        if ($("#hfIdCorredor").val() == false) {
                            carregarGruposNoMapa();
                        }
                        else {
                            carregarGruposCorredorNoMapa(true);
                        }
                    } else {
                        $("#hfEndereco").val("");
                    }
                } else {
                    window.alert('Geocoder failed due to: ' + status);
                }
            });
        }

        function Voltar() {
            location.replace("Cronologia.aspx");
        }

        function Geocodificacao(endereco, type, idLocal) {
            var pointGruposLogicos = [];
            markers = [];

            var latlng;
            if (endereco != "") {
                geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': endereco }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        if (results[0]) {
                            var latitude = results[0].geometry.location.lat();
                            var longitude = results[0].geometry.location.lng();

                            latlng = new google.maps.LatLng(latitude, longitude);

                            var options = {
                                zoom: 16,
                                center: latlng,
                                mapTypeId: google.maps.MapTypeId.ROADMAP
                            };
                            map = new google.maps.Map($("#map")[0], options);
                            map.addListener("click", function (e) {
                                $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
                                $("#btnSalvar").data('tipo', 'Salvar');
                                if ($("#hdfTypeMarker").val() == "" && $("#hdfTypeMarker").val() == '')
                                    ObterLocalGrupo(map, e.latLng);
                                else
                                    ObterLocalGrupo(map, e.latLng, 'salvarLocal');
                            });
                            $("#map").css("visibility", "visible");

                            drawingManager = new google.maps.drawing.DrawingManager({
                                drawingMode: google.maps.drawing.OverlayType.POINTER,
                                drawingControl: true,
                                drawingControlOptions: {
                                    position: google.maps.ControlPosition.TOP_CENTER,
                                    drawingModes: [
                                        google.maps.drawing.OverlayType.POLYLINE

                                    ]

                                },
                                polylineOptions: {
                                    strokeColor: 'red',
                                    strokeWeight: 2,
                                    editable: true
                                }
                            });
                            drawingManager.setMap(map);

                            drawingManager.addListener('polylinecomplete', function (poly) {
                                var path = poly.getPath();
                                polylinesDraw = [];
                                polylinesDraw.push(poly);
                                placeIdArray = [];
                                snappedPolyline = poly;
                                for (var i = 0; i < poly.getPath().getLength(); i++) {
                                    var coords = poly.getPath().getAt(i).toUrlValue().split(",");
                                    var latlng = new google.maps.LatLng(coords[0], coords[1]);
                                    snappedCoordinates.push(latlng);
                                }

                                drawSnappedPolyline();
                            });

                            if ($("#hfIdCorredor").val() != "") {
                                carregarCorredor();
                            }
                            //carregarGruposNoMapa();
                        }
                        else $("#map").css("visibility", "hidden");
                    }
                });
            }
        }

        function carregarGruposNoMapa() {
            callServer("Map.aspx/carregarGruposNoMapa", "{'endereco':'" + $("#hfEndereco").val() + "'}",
                function (results) {
                    if (results != "") {
                        var pointGruposLogicos = [];
                        $.each(results, function (index, lst) {

                            var marker = {
                                "grupo": lst.grupo,
                                "tipoGrupo": lst.tipo,
                                "endereco": lst.Endereco,
                                "lat": lst.lat,
                                "lng": lst.lng,
                                "tipoMarker": lst.tipoMarcador,
                                "idLocal": lst.idLocal,
                                "anel": lst.anel,
                                "idEqp": lst.idEqp,
                                "modelo": lst.modelo
                            }
                            pointGruposLogicos.push(marker);
                        });

                        for (var i = 0; i < pointGruposLogicos.length; i++) {
                            var data = pointGruposLogicos[i];
                            var myLatlng = new google.maps.LatLng(data.lat, data.lng);
                            var grupo = data.grupo != "" ? "G" + data.grupo : "";
                            var iconLabel = getTypeMarker(data.tipoMarker, grupo);

                            var marker = new mapIcons.Marker({
                                map: map,
                                position: myLatlng,
                                draggable: true,
                                icon: {
                                    path: mapIcons.shapes.SQUARE_PIN,
                                    fillColor: 'transparent',
                                    fillOpacity: 1,
                                    strokeColor: '',
                                    strokeWeight: 0,
                                    scale: 1 / 2
                                },
                                map_icon_label: iconLabel,
                                alt: data.anel,
                                id: data.idLocal,
                                idEqp: data.idEqp,
                                modelo: data.modelo,
                                lat: data.lat,
                                lng: data.lng
                            });

                            (function (marker, data) {
                                geocoder = new google.maps.Geocoder();

                                google.maps.event.addListener(marker, 'dragend', function () {

                                    $("#hdfId").val(data.idLocal);
                                    if (data.grupo != "") $("#smallGpSelecionado").text(getResourceItem("grupoSemaforicoSelecionado") + ":" + data.grupo);
                                    else $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
                                });

                                google.maps.event.addListener(marker, "click", function (e) {
                                    ObterLocalGrupo(map, marker.getPosition());
                                    if ($("#hfIdCorredor").val() == "") {
                                        marker.info = new google.maps.InfoWindow({
                                            content: '<h5 style="text-align: -webkit-center;">Eqp: ' + data.idEqp + '</h5><label>' + data.endereco + '</label><br/>'
                                                + '<div><label style="float:left; margin-top: 5px;"><b style="float:left;">' + getResourceItem("modelo") + ':</b> ' + data.modelo + '</label>' +
                                                '<b style="float: left; margin-left: 18px; margin-top: 5px;">Indice:</b><input style="float:left;margin-left: 5px;width:20%;" type="number" value="1" disabled id="txtIndice' + data.grupo + data.idEqp + '" class="form-control input-sm" /><button type="button" class="btn btn-info btn-sm" style="margin-left:16px;" data-lat="' + data.lat + '" data-lng="' + data.lng + '" data-idEqp="' + data.idEqp + '" data-marker="' + marker + '" data-grupo="' + data.grupo + '" data-endereco="' + data.endereco + '" onclick="AdicionarGrupo(this)">' + getResourceItem("adicionar") + '</button > <div />'
                                        });
                                    } else {
                                        var qtdLinha = $("#tbGruposAdicionados")[0].rows.length;
                                        qtdLinha++;
                                        marker.info = new google.maps.InfoWindow({
                                            content: '<h5 style="text-align: -webkit-center;">Eqp: ' + data.idEqp + '</h5><label>' + data.endereco + '</label><br/>'
                                                + '<div><label style="float:left; margin-top: 5px;"><b style="float:left;">' + getResourceItem("modelo") + ':</b> ' + data.modelo + '</label>' +
                                                '<b style="float: left; margin-left: 18px; margin-top: 5px;">Indice:</b><input style="float:left;margin-left: 5px;width:20%;" type="number" value="' + qtdLinha + '" disabled id="txtIndice' + data.grupo + data.idEqp + '" class="form-control input-sm" /><button type="button" class="btn btn-info btn-sm" style="margin-left:16px;" data-lat="' + data.lat + '" data-lng="' + data.lng + '" data-idEqp="' + data.idEqp + '" data-marker="' + marker + '" data-grupo="' + data.grupo + '" data-endereco="' + data.endereco + '" onclick="AdicionarGrupo(this)">' + getResourceItem("adicionar") + '</button > <div />'
                                        });
                                    }

                                    marker.info.open(map, marker);
                                    $("#hdfId").val(data.idLocal);
                                    if (data.grupo != "") $("#smallGpSelecionado").text(getResourceItem("grupoSemaforicoSelecionado") + ":" + data.grupo);
                                    else $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
                                });
                            })(marker, data);

                            markers.push(marker);
                        }
                    }
                });
        }

        function carregarGruposCorredorNoMapa(carregarMarcadores) {
            callServer("Map.aspx/carregarGruposCorredorNoMapa", "{'idCorredor':'" + $("#hfIdCorredor").val() + "'}",
                function (results) {
                    if (results != "") {
                        $("#tfGruposAdicionados").css("display", "none");
                        var pointGruposLogicos = [];
                        $("#tbGruposAdicionados").empty();
                        $.each(results, function (index, lst) {

                            var marker = {
                                "grupo": lst.grupo,
                                "tipoGrupo": lst.tipo,
                                "endereco": lst.Endereco,
                                "lat": lst.lat,
                                "lng": lst.lng,
                                "tipoMarker": lst.tipoMarcador,
                                "idLocal": lst.idLocal,
                                "anel": lst.anel,
                                "idEqp": lst.idEqp,
                                "modelo": lst.modelo,
                                "idCorredorAnel": lst.idCorredorAnel
                            }
                            pointGruposLogicos.push(marker);

                            var newRow = $("<tr>");
                            var cols = "<td style='text-align: center;padding-top: 6%;'>" + lst.idEqp + "</td>";
                            cols += "<td style='text-align: center;padding-top: 6%;'>" + lst.grupo + "</td>";
                            cols += "<td style='padding:6px;text-align: center;font-size:smaller;'>" + lst.Endereco + "</td>";
                            cols += "<td style='text-align: center;padding-top: 6%;'>" + lst.Distancia + "</td>";
                            //cols += "<td style='padding-right: 5px;padding-left: 5px;padding-top: 3%;'><button type='button' class='btn btn-danger btn-xs' data-id='" + lst.idCorredorAnel + "' data-grupo='" + lst.grupo + "' data-ideqp='" + lst.idEqp + "' style='cursor:pointer;' onclick='excluirGrupoCorredor(this)'><i class='ft-trash-2'></i></button></td>";
                            newRow.append(cols);
                            $("#tbGruposAdicionados").append(newRow);
                        });
                        if (carregarMarcadores) {

                            for (var i = 0; i < pointGruposLogicos.length; i++) {
                                var data = pointGruposLogicos[i];
                                var myLatlng = new google.maps.LatLng(data.lat, data.lng);
                                var grupo = data.grupo != "" ? "G" + data.grupo : "";
                                var iconLabel = getTypeMarker(data.tipoMarker, grupo);

                                var marker = new mapIcons.Marker({
                                    map: map,
                                    position: myLatlng,
                                    draggable: true,
                                    icon: {
                                        path: mapIcons.shapes.SQUARE_PIN,
                                        fillColor: 'transparent',
                                        fillOpacity: 1,
                                        strokeColor: '',
                                        strokeWeight: 0,
                                        scale: 1 / 2
                                    },
                                    map_icon_label: iconLabel,
                                    alt: data.anel,
                                    id: data.idLocal,
                                    idEqp: data.idEqp,
                                    modelo: data.modelo,
                                    lat: data.lat,
                                    lng: data.lng
                                });

                                (function (marker, data) {
                                    geocoder = new google.maps.Geocoder();

                                    google.maps.event.addListener(marker, 'dragend', function () {

                                        $("#hdfId").val(data.idLocal);
                                        if (data.grupo != "") $("#smallGpSelecionado").text(getResourceItem("grupoSemaforicoSelecionado") + ":" + data.grupo);
                                        else $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
                                    });

                                    google.maps.event.addListener(marker, "click", function (e) {
                                        ObterLocalGrupo(map, marker.getPosition());

                                        marker.info.open(map, marker);
                                        $("#hdfId").val(data.idLocal);
                                        if (data.grupo != "") $("#smallGpSelecionado").text(getResourceItem("grupoSemaforicoSelecionado") + ":" + data.grupo);
                                        else $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
                                    });
                                })(marker, data);

                                markers.push(marker);
                            }
                        }
                    }
                    else {
                        $("#tfGruposAdicionados").css("display", "");
                        $("#tbGruposAdicionados").empty();
                    }
                });
        }
        function AdicionarGrupo(btn) {

            $("#txtIndice" + btn.dataset.grupo + btn.dataset.ideqp).removeClass("is-invalid");
            if ($("#txtIndice" + btn.dataset.grupo + btn.dataset.ideqp).val() == "") {
                Swal.fire({

                    type: 'warning',
                    title: getResourceItem("atencao"),
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                $("#txtIndice" + btn.dataset.grupo + btn.dataset.ideqp).addClass("is-invalid");
                $("#txtIndice" + btn.dataset.grupo + btn.dataset.ideqp).focus();
                return;
            }

            $("#tfGruposAdicionados").css("display", "none");
            $("#tbGruposAdicionados").css("display", "");
            var erro = false;
            $("#tbGruposAdicionados").find('tr').each(function (i, el) {
                var td = $(this).find('td')[0];
                if (td) {
                    var eqp = td.innerText;
                    var grupo = $(this).find('td')[1].innerText;
                    if (btn.dataset.ideqp == eqp && btn.dataset.grupo == grupo) {
                        erro = true;
                    }
                }
            });

            if (erro) {
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("grupoJaAdicionadoCorredor"),
                })
                return;
            }
            var Wayp = snappedCoordinates.toString();
            callServer("Map.aspx/salvarGrupoNoCorredor", "{'idCorredor':'" + $("#hfIdCorredor").val() + "','corredor':'" + $("#txtCorredor").val() + "','grupo':'" + btn.dataset.grupo +
                "','idEqp':'" + btn.dataset.ideqp + "','indice':'" + $("#txtIndice" + btn.dataset.grupo + btn.dataset.ideqp).val() + "','wayPoints':'" + Wayp + "','lat':'" + btn.dataset.lat +
                "','lng':'" + btn.dataset.lng + "'}",
                function (results) {
                    if (results != "") {
                        $("#hfIdCorredor").val(results);
                    }
                    carregarGruposCorredorNoMapa(false);
                });

        }

        function excluirCorredor() {
            Swal.fire({
                title: getResourceItem("confirmarExclusaoTipoAlert"),
                text: getResourceItem("corredorSeraExcluidoPermanentemente"),
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("simExcluir")
            }).then((result) => {
                if (result.value) {

                    $.ajax({
                        url: 'Map.aspx/excluirCorredor',
                        data: "{'idCorredor':'" + $("#hfIdCorredor").val() + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("excluido"),
                                text: getResourceItem("excluidoSucesso"),
                            });
                            $("#hfOrigem").val("novo");
                            LimparDesenho();

                        }
                    });
                }
            });
        }

        function ObterLocalGrupo(map, coords) {
            geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'latLng': coords }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[0]) {
                        $("#txtCruzamento").val(results[0].formatted_address);
                        $("#prelLocal").val(results[0].formatted_address);
                        $("#hdfLat").val(coords.lat());
                        $("#hdfLng").val(coords.lng());
                    }
                }
            });
        }

        function SalvarCorredor() {
            if ($("#txtCorredor").val()=="") {
                $("#txtCorredor").addClass("is-invalid");
                $("#txtCorredor").focus();

                Swal.fire({

                    type: 'warning',
                    title: getResourceItem("atencao"),
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                return;
            }
            var Wayp = snappedCoordinates.toString();
            $("#txtCorredor").removeClass("is-invalid");
            callServer("Map.aspx/salvarCorredor", "{'idCorredor':'" + $("#hfIdCorredor").val() + "','corredor':'" + $("#txtCorredor").val() + "','wayPoints':'" + Wayp + "','tempoPercurso':'" + $("#txtTempoPercurso").val() +"'}",
                function (results) {
                    Swal.fire({

                        type: 'success',
                        title: getResourceItem("sucesso"),
                        text: getResourceItem("salvoComSucesso"),
                    });
                });
        }

        function getTypeMarker(tipoMarker, grupo) {
            var iconLabel = "";

            if (tipoMarker == "cima") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="ft ft-arrow-up"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
            else if (tipoMarker == "baixo") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="ft ft-arrow-down"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
            else if (tipoMarker == "direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="ft ft-arrow-right"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
            else if (tipoMarker == "esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="ft ft-arrow-left"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
            else if (tipoMarker == "conversão direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="ft ft-corner-up-right"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
            else if (tipoMarker == "conversão esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="ft ft-corner-up-left"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
            else if (tipoMarker == "diagonal cima direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="ft ft-arrow-up-right"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
            else if (tipoMarker == "diagonal cima esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="ft ft-arrow-up-left"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
            else if (tipoMarker == "diagonal baixo direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="ft ft-arrow-down-right"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
            else if (tipoMarker == "diagonal baixo esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="ft ft-arrow-down-left"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
            else if (tipoMarker == "pedestre") iconLabel = '<i style="font-size:16px;" class="material-icons">directions_walk</i><label style="font-family: sans-serif; font-size:12px; font-weight: bold; display:inline;">' + grupo + '</label>';

            return iconLabel;
        }

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
                    $("#divLoading").css("display", "none");
                }
            });
        };

        function addMarkerType(map, latLng) {
            $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");

            var iconLabel = getTypeMarker($('#hdfTypeMarker').val(), "");

            if (iconLabel != "") {
                var data = {
                    "tipoMarcador": $("#hdfTypeMarker").val(),
                    "id": $("#hdfId").val(),
                    "local": $("#txtCruzamento").val()
                }

                var marker = new mapIcons.Marker({
                    map: map,
                    position: latLng,
                    draggable: true,
                    icon: {
                        path: mapIcons.shapes.SQUARE_PIN,
                        fillColor: 'transparent',
                        fillOpacity: 1,
                        strokeColor: '',
                        strokeWeight: 0,
                        scale: 1 / 2
                    },
                    map_icon_label: iconLabel,
                    id: data.id
                });

                (function (marker, data) {
                    geocoder = new google.maps.Geocoder();

                    google.maps.event.addListener(marker, 'dragend', function () {
                        $("#hdfId").val(data.id);
                        $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
                        $("#btnSalvar").data('tipo', 'Editar');
                        ObterLocalGrupo(map, marker.getPosition(), 'editarLocal');
                    });

                    google.maps.event.addListener(marker, "click", function (e) {
                        $("#hdfId").val(data.id);
                        ObterLocalGrupo(map, marker.getPosition());
                        $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
                        marker.info = new google.maps.InfoWindow({
                            content: '<button type="button" class="btn btn-primary" data-tipoMarcador="' + data.tipoMarcador + '" data-id=' + data.id + ' data-local="' + data.local + '" onclick="DetalhesGrupoSemaforico(this)" data-toggle="modal" data-target="#modalGruposSemaforicos">' + getResourceItem("gruposSemaforicos") + '</button>' +
                                '<button type="button" style="margin-left:10px;" data-id="' + data.id + '" onclick="deleteLocal(this)" class="btn btn-danger">' + getResourceItem("excluir") + '</button>'
                        });
                        marker.info.open(map, marker);
                    });
                })(marker, data);

                markers.push(marker);
            }
        }

        function LimparDesenho() {
            $("#btnLimparDesenho").css("display", "none");
            $("#txtCorredor").val("");
            $("#txtTempoPercurso").val("");
            $("#hfIdCorredor").val("");
            $("#btnExcluir").css("display", "none");
            $("#tbGruposAdicionados").empty();
            $("#tfGruposAdicionados").css("display", "");
            clear();
            for (var i = 0; i < polylinesDraw.length; ++i) {
                polylinesDraw[i].setMap(null);
            }
            polylinesDraw = [];
            for (var i = 0; i < polylines.length; ++i) {
                polylines[i].setMap(null);
            }
            polylines = [];
            snappedCoordinates = [];
        }

        var globalResources;
        function loadResourcesLocales() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: 'Map.aspx/requestResource',
                dataType: "json",
                async: false,
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
    </script>
</asp:Content>
