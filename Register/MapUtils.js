var polygon = new google.maps.Polygon();
var arrPolygon = [], saveCoordsPoly = [];
var snappedPolyline = new google.maps.Polyline();
var polylines = [], snappedCoordinates = [];

var map, LatLngPoints, lng, lat, infowindow;
var drawingManager;
var title = $("#titlePag").text();

$(function () {
    loadResourcesLocales();
})

var globalResources;
function loadResourcesLocales() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: 'TrajetoGrupoSemaforico.aspx/requestResource',
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

var callServer = function (urlName, params, callback) {
    $("#divLoading").css("display", "block");
    $.ajax({
        type: 'POST',
        url: urlName,
        dataType: 'json',
        data: params,
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (callback && typeof (callback) == "function") callback(data.d);

            $("#divLoading").css("display", "none");
        },
        error: function (data) {
            $("#divLoading").css("display", "none");
        }
    });
};

function initialize(typeInitialize) {
    $("#divLoading").css("display", "block");

    var location = new google.maps.LatLng($("#hfLat").val().trim(), $("#hfLng").val().trim());
    var options = {
        center: location,
        zoom: 15,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        mapTypeControl: true,
        mapTypeControlOptions: {
            position: google.maps.ControlPosition.RIGHT_BOTTOM
        }
    };

    map = new google.maps.Map($("#map")[0], options);

    //$("#txtLocal").addresspicker({
    //    componentsFilter: 'country:BR',
    //    updateCallback: setMapCenter,
    //    mapOptions: options,
    //    elements: { map: "#map" }
    //});

    google.maps.event.addListener(map, "click", function (e) {
        if (polylines.length) {
            infowindow = new google.maps.InfoWindow({
                content: '<a href="#" data-lat="' + e.latLng.lat() + '" data-lng="' + e.latLng.lng() + '" onclick="ContinuarTrajeto(this); infowindow.setMap(null);">' + getResourceItem("continuar") + '</a>',
                map: map
            });
            infowindow.setPosition(e.latLng);
        }
    });

    var drawingModes = typeInitialize == "trajetos" ? google.maps.drawing.OverlayType.POLYLINE : google.maps.drawing.OverlayType.POLYGON;

    drawingManager = new google.maps.drawing.DrawingManager({
        drawingMode: google.maps.drawing.OverlayType.POINTER,
        drawingControl: true,
        drawingControlOptions: {
            position: google.maps.ControlPosition.LEFT_CENTER,
            drawingModes: [drawingModes]
        }
    });

    var options = { editable: true };
    if (typeInitialize == "area") {
        drawingManager.set('polygonOptions', options);
        drawingManager.setMap(map);

        drawingManager.addListener('polygoncomplete', function (polyComplete) {
            polygon = polyComplete;
            arrPolygon.push(polyComplete);
            var pathPolygon = polyComplete.getPath();
            saveCoordsPoly = [];
            for (var i = 0; i < polyComplete.getPath().getLength(); i++) {
                var coords = polygon.getPath().getAt(i).toUrlValue().split(",");
                var latlng = new google.maps.LatLng(coords[0], coords[1]);
                saveCoordsPoly.push(latlng);
            }
            google.maps.event.addListener(pathPolygon, "insert_at", getPolygonCoords);
            google.maps.event.addListener(pathPolygon, "remove_at", getPolygonCoords);
            google.maps.event.addListener(pathPolygon, "set_at", getPolygonCoords);
        });
    }
    else {
        drawingManager.set('polylineOptions', options);
        drawingManager.setMap(map);

        snappedPolyline = new google.maps.Polyline({
            editable: true,
            map: map
        });

        drawingManager.addListener('polylinecomplete', function (poly) { snappedPolyline = poly; setPolyline(); });
        google.maps.event.addListener(snappedPolyline.getPath(), "insert_at", setPolyline);
        google.maps.event.addListener(snappedPolyline.getPath(), "remove_at", setPolyline);
        google.maps.event.addListener(snappedPolyline.getPath(), "set_at", setPolyline);

        if ($("#hfCallServer").val() == "NewRegister") {
            $("#btnSalvar").data("type", "Salvar");
            $("#preArea").text(getResourceItem("areaSelecionada") + ":" + $("#hfSubarea").val());

            $("#preArea").data("area", $("#hfSubarea").val());
            $("#preArea").data("id", $("#hfIdSubarea").val());
        }
        else if ($("#hfCallServer").val() == "Datails") {
            $("#btnSalvar").data("type", "Editar");
            loadRoutes($("#hfId").val());
            loadGruposVinculados();
        }
    }

    AddMarkerEqp($("#btnMarkerEqp")[0]);

    for (var i = 1; i <= 4; i++) { AddMarkerAneis($("#btnAddAnel" + i)[0]); }

    $("#divLoading").css("display", "none");
}

function setMapCenter(results) {
    if (results[0]) {
        $("#txtLocal").val(results[0].formatted_address);
        map.setCenter(results[0].geometry.location);
    }
}

var markers = [];
function AddPointGruposLogicos() {
    var pointGruposLogicos = [];
    callServer("../../WebServices/Areas.asmx/getGrupoSemaforico", "",
        function (results) {
            if (results != "") {
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
                        "idEqp": lst.idEqp
                    }
                    pointGruposLogicos.push(marker);
                });

                for (var i = 0; i < pointGruposLogicos.length; i++) {
                    var data = pointGruposLogicos[i];
                    var myLatlng = new google.maps.LatLng(data.lat, data.lng);

                    if (i == 0) map.setCenter(myLatlng);

                    var grupo = data.grupo != "" ? "G" + data.grupo : "";
                    var iconLabel = getTypeMarker(data.tipoMarker, grupo);

                    var marker = new mapIcons.Marker({
                        map: map,
                        position: myLatlng,
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
                        id: data.idLocal
                    });

                    (function (marker, data) {
                        if (title.indexOf(getResourceItem("rotaGrupoSemaforico")) != -1)
                            marker.info = new google.maps.InfoWindow({
                                content: '<small class="text-muted" data-grupo="' + data.grupo + '" data-idLocal="' + data.idLocal + '" style="cursor:pointer; color:green;" onclick="SalvarVinculoGrupo(this);"> <span class="glyphicon glyphicon-ok pull-right"></span></small>'
                            });

                        google.maps.event.addListener(marker, "click", function (e) {
                            if (title.indexOf(getResourceItem("rotaGrupoSemaforico")) != -1) {
                                var path = snappedPolyline.getPath();
                                path.push(e.latLng);
                                setPolyline();
                                gruposTrajeto.push(data);
                            }
                            else {
                                marker.info = new google.maps.InfoWindow({
                                    content: '<small>Id ' + getResourceItem("controlador") + ':' + data.idEqp + ' - G' + data.grupo + ' - ' + data.tipoGrupo + ' - ' + data.endereco + '</small>'
                                });
                                marker.info.open(map, marker);
                            }
                        });
                    })(marker, data);

                    markers.push(marker);
                }
            }
        });
}

var markersEqp = [];
function AddMarkerEqp(obj) {
    if (!$(obj).data("active")) {
        $(obj).data("active", true);
        callServer('../../WebServices/Map.asmx/LoadFilterMap', "{'consorcio':'','empresa':'','idPonto':'','idPrefeitura':''}",
            function (eqp) {
                $.each(eqp, function (index, item) {
                    var statusPorta = "";
                    if (item.statusManutencao != "-1") CreateMarkerEqp(item.latitude, item.longitude, item.statusManutencao, item.idDna, "M", "");
                    else {
                        switch (item.statusComunicacao) {
                            case "True":
                                var bitsFalha = parseInt(item.falha).toString(2);
                                falhas = "";
                                var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaPonto", "");
                                CreateMarkerEqp(item.latitude, item.longitude, verificaFalhas.statusFalha, item.idDna, falhas, statusPorta + item.estadoNobreak);
                                break;
                            case "False":
                                if (item.semComunicacao == "0") CreateMarkerEqp(item.latitude, item.longitude, "FalhaComunicacao", item.idDna, "FC", statusPorta + item.estadoNobreak);
                                else CreateMarkerEqp(item.latitude, item.longitude, "SemComunicacao", item.idDna, "SC", statusPorta + item.estadoNobreak);
                                break;
                        }
                    }
                });
            });
    } else {
        $(obj).data("active", false);
        $.each(markersEqp, function (index, item) { if (item != undefined) item.setMap(null); });
    }
}

function VerificaFalhas(bitsFalha, callName, status) {

    this.statusFalha = "";
    this.falhas = "";

    if (bitsFalha == 0) {
        this.statusFalha = "Normal";
        falhas = "N";
    }
    else {
        this.statusFalha = "Falha";

        bitsFalha = bitsFalha.split('').reverse().join('');
        for (var positionBit = 0; positionBit < bitsFalha.length; positionBit++) {
            if (positionBit == 0 && bitsFalha[positionBit] == "1") falhas = "F";

            //Subtensao
            if (positionBit == 1 && bitsFalha[positionBit] == "1") {
                if (falhas == "") falhas = "S";
                else falhas += ",S"
            }

            //Apagado/Desligado
            if (positionBit == 2 && bitsFalha[positionBit] == "1") {
                if (falhas == "") falhas = "D";
                else falhas += ",D";
            }

            //Amarelo intermitente
            if (positionBit == 3 && bitsFalha[positionBit] == "1") {
                if (falhas == "") falhas = "A";
                else falhas += ",A"
            }

            //Estacionado
            if (positionBit == 4 && bitsFalha[positionBit] == "1") {
                if (falhas == "") falhas = "E";
                else falhas += ",E";
            }
        }
    }
}

function CreateMarkerEqp(lat, lng, statusFalha, idDna, siglaFalha, statusPorta) {
    var iconUrlStatus;

    switch (statusFalha) {
        case "Normal":
            iconUrlStatus = '../../Images/controlNormal.png';
            break;

        case "Falha":
            iconUrlStatus = '../../Images/controlFalha.png';
            break;

        case "FalhaComunicacao":
            iconUrlStatus = '../../Images/SemaforoCinza.png';
            break;

        case "SemComunicacao":
            iconUrlStatus = '../../Images/semComunicacao.png';
            break;
        case "0":
            iconUrlStatus = '../../Images/coneRed.png';
            break;
        case "1":
            iconUrlStatus = '../../Images/equipeM.png';
            break;
    }

    var latLng = new google.maps.LatLng(lat, lng);

    var marker = new google.maps.Marker({
        map: map,
        position: latLng,
        title: siglaFalha,
        alt: statusPorta,
        icon: {
            url: iconUrlStatus,
            scaledSize: new google.maps.Size(24, 32),
            anchor: new google.maps.Point(10, 10)
        }
    });

    google.maps.event.addListener(marker, "click", function (e) {
        marker.info = new google.maps.InfoWindow({
            content: getResourceItem("controlador") + ': ' + idDna + ' - ' + getResourceItem("falhas") + ': ' + siglaFalha
        });
        marker.info.open(map, marker);
    });

    markersEqp.push(marker);
}

function AddMarkerGrupos(obj) {
    if (!$(obj).data("active")) {
        $(obj).data("active", true);
        AddPointGruposLogicos();
        map.setOptions({ minZoom: 21, maxZoom: 21 });
    }
    else {
        $(obj).data("active", false);
        $.each(markers, function (i, item) {
            if (item != undefined) item.setMap(null);
        });
        markers = [];
        map.setOptions({ minZoom: 0, maxZoom: 21 });
    }
}

var polygonAnel1 = [], polygonAnel2 = [], polygonAnel3 = [], polygonAnel4 = [];
var markersAnel1 = [], markersAnel2 = [], markersAnel3 = [], markersAnel4 = [];

function AddMarkerAneis(obj) {
    var overviewPathGeo = [], pathMarkers = [];

    if (!$(obj).data("active")) {
        $(obj).data("active", true);

        var idEqp = "";
        var sizeItens = 0;
        var textAnel_replace = getResourceItem("anel") + " ";
        callServer('../../WebServices/Areas.asmx/LoadAnel', "{'anel':'" + obj.innerText.replace(textAnel_replace, "") + "'}",
            function (results) {

                sizeItens = results.length;

                $.each(results, function (index, item) {
                    if (index == 0) idEqp = item.idEqp;

                    if (idEqp == item.idEqp) {
                        var position = new google.maps.LatLng(item.lat, item.lng);
                        pathMarkers.push(position); overviewPathGeo.push([position.lng(), position.lat()]);
                    }

                    if (idEqp != item.idEqp || index == (sizeItens - 1)) {
                        if (pathMarkers.length == 0) return true;

                        var distance = (google.maps.geometry.spherical.computeLength(pathMarkers) / 1000) / 2000;

                        var geoReader = new jsts.io.GeoJSONReader(), geoWriter = new jsts.io.GeoJSONWriter();
                        var geometry = geoReader.read({ type: "LineString", coordinates: overviewPathGeo }).buffer(distance);
                        var oCoordinates = geoWriter.write(geometry).coordinates[0];

                        var oLanLng = [];
                        for (i = 0; i < oCoordinates.length; i++) {
                            var oItem;
                            oItem = oCoordinates[i];
                            oLanLng.push(new google.maps.LatLng(oItem[1], oItem[0]));
                        }

                        var polygonAnel = new google.maps.Polygon({
                            paths: oLanLng,
                            strokeWeight: 1,
                            map: map
                        });

                        var bounds = new google.maps.LatLngBounds();
                        for (i = 0; i < oLanLng.length; i++) { bounds.extend(oLanLng[i]); }

                        var marker = new mapIcons.Marker({
                            map: map,
                            position: bounds.getCenter(),
                            map_icon_label: '<span class="map-icon map-icon-crosshairs" style="font-size: 16px; padding-top: 50px; padding-right:0.5px;"></span>',
                            title: obj.innerText
                        });

                        google.maps.event.addListener(marker, "click", function (e) {
                            var infoMarkerAnel = new google.maps.InfoWindow({
                                content: obj.innerText + ' - ' + item.idEqp,
                                map: map
                            });
                            infoMarkerAnel.setPosition(e.latLng);
                        });

                        switch (obj.innerText) {
                            case getResourceItem("anel") + " 1":
                                marker.setOptions({
                                    icon: {
                                        path: mapIcons.shapes.MAP_PIN,
                                        fillColor: 'red',
                                        fillOpacity: 1,
                                        strokeColor: 'red',
                                        strokeWeight: 0,
                                        scale: 1.5 / 2
                                    }
                                });
                                markersAnel1.push(marker);
                                polygonAnel.setOptions({ fillColor: "red", strokeColor: "red" });
                                polygonAnel1.push(polygonAnel);
                                break;
                            case getResourceItem("anel") + " 2":
                                marker.setOptions({
                                    icon: {
                                        path: mapIcons.shapes.MAP_PIN,
                                        fillColor: 'blue',
                                        fillOpacity: 1,
                                        strokeColor: 'blue',
                                        strokeWeight: 0,
                                        scale: 1.5 / 2
                                    }
                                });
                                markersAnel2.push(marker);
                                polygonAnel.setOptions({ fillColor: "blue", strokeColor: "blue" });
                                polygonAnel2.push(polygonAnel);
                                break;
                            case getResourceItem("anel") + " 3":
                                marker.setOptions({
                                    icon: {
                                        path: mapIcons.shapes.MAP_PIN,
                                        fillColor: 'green',
                                        fillOpacity: 1,
                                        strokeColor: 'green',
                                        strokeWeight: 0,
                                        scale: 1.5 / 2
                                    }
                                });
                                markersAnel3.push(marker);
                                polygonAnel.setOptions({ fillColor: "green", strokeColor: "green" });
                                polygonAnel3.push(polygonAnel);
                                break;
                            case getResourceItem("anel") + " 4":
                                marker.setOptions({
                                    icon: {
                                        path: mapIcons.shapes.MAP_PIN,
                                        fillColor: 'yellow',
                                        fillOpacity: 1,
                                        strokeColor: 'yellow',
                                        strokeWeight: 0,
                                        scale: 1.5 / 2
                                    }
                                });
                                markersAnel4.push(marker);
                                polygonAnel.setOptions({ fillColor: "yellow", strokeColor: "yellow" });
                                polygonAnel4.push(polygonAnel);
                                break;
                        }

                        overviewPathGeo = [], pathMarkers = [];
                        idEqp = item.idEqp;
                    }
                });
            });
    }
    else {
        $(obj).data("active", false);
        switch (obj.innerText) {
            case getResourceItem("anel") + " 1":
                $.each(markersAnel1, function (i, item) {
                    markersAnel1[i].setMap(null);
                });
                markersAnel1 = [];

                $.each(polygonAnel1, function (i, item) {
                    polygonAnel1[i].setMap(null);
                });
                polygonAnel1 = [];
                break;
            case getResourceItem("anel") + " 2":
                $.each(markersAnel2, function (i, item) {
                    markersAnel2[i].setMap(null);
                });
                markersAnel2 = [];

                $.each(polygonAnel2, function (i, item) {
                    polygonAnel2[i].setMap(null);
                });
                polygonAnel2 = [];
                break;
            case getResourceItem("anel") + " 3":
                $.each(markersAnel3, function (i, item) {
                    markersAnel3[i].setMap(null);
                });
                markersAnel3 = [];

                $.each(polygonAnel3, function (i, item) {
                    polygonAnel3[i].setMap(null);
                });
                polygonAnel3 = [];
                break;
            case getResourceItem("anel") + " 4":
                $.each(markersAnel4, function (i, item) {
                    markersAnel4[i].setMap(null);
                });
                markersAnel4 = [];

                $.each(polygonAnel4, function (i, item) {
                    polygonAnel4[i].setMap(null);
                });
                polygonAnel4 = [];
                break;
        }
    }
}

function AddAllAneis(obj) {
    for (var i = 1; i <= 4; i++) { AddMarkerAneis($("#btnAddAnel" + i)[0]); }
}

function getTypeMarker(tipoMarker, grupo) {
    var iconLabel = "";

    if (tipoMarker == "cima") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-up2"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
    else if (tipoMarker == "baixo") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-down2"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
    else if (tipoMarker == "direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-right2"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
    else if (tipoMarker == "esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-left2"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
    else if (tipoMarker == "conversão direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-redo"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
    else if (tipoMarker == "conversão esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-undo"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
    else if (tipoMarker == "diagonal cima direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-up-right2"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
    else if (tipoMarker == "diagonal cima esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-up-left2"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
    else if (tipoMarker == "diagonal baixo direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-down-right2"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
    else if (tipoMarker == "diagonal baixo esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-down-left2"><label style="font-family: sans-serif;">' + grupo + '</label></span>';
    else if (tipoMarker == "pedestre") iconLabel = '<i style="font-size:16px;" class="material-icons">directions_walk</i><label style="font-family: sans-serif; font-size:12px; font-weight: bold; display:inline;">' + grupo + '</label>';

    return iconLabel;
}

function searchAddress() {
    if ($("#txtLocal").val() != "") {
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode({ 'address': $("#txtLocal").val() }, setMapCenter);
    }
}