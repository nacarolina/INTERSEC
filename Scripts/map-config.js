var map;
var latLng;
var marker;

$(function () {
    loadResourcesLocales();
})

var globalResources;
function loadResourcesLocales() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: '../Map/MapConfig.aspx/requestResource',
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

function LoadMap(lat, lng, zoom) {

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

    map.setView(new L.LatLng(lat, lng), zoom).addLayer(osm);

    map.on('click', onMapClick);

}

var popup = L.popup();

function onMapClick(e) {
    var btnSave = "<input type='button' class='myButton' style='margin-left:50px;margin-top:15px;' id='btnSalvar' value='" + getResourceItem("salvar") + "' onclick='Salvar();' />";
    var btnCancel = "<input type='button' class='myButton' id='btnCancel' style='margin-left:10px; margin-top:15px;' value='" + getResourceItem("cancelar") + "' onclick='Cancel();' />";
    latLng = e.latlng.toString();
    GetLatLng();

    popup
        .setLatLng(e.latlng)
        .setContent(getResourceItem("inicializacaoMapaNessaArea") + " " + e.latlng.toString() +
           "<br />" + "<table id='tblPoupap'> <tr><td>" + btnSave + "</td> <td>" + btnCancel + "</td></tr></table>")
        .openOn(map);

    map.setView([position.Lat, position.Lng], map.getZoom());
}

function Salvar() {
    map.closePopup();
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Map.asmx/SalveConfigMap',
        dataType: 'json',
        data: "{'zoom':'" + map.getZoom() + "','lat':'" + position.Lat + "','lng':'" + position.Lng + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) { params = data; alert(getResourceItem("salvoComSucesso")); }
    });
}

function Cancel() {
    map.closePopup();
}

var position = new Object();

function GetLatLng() {

    var latPosition = latLng.indexOf(",");
    var lat = latLng.substring(7, latPosition);
    var lng = latLng.substring(latPosition + 1).replace(')', '');

    position.Lat = lat;
    position.Lng = lng;

}

function GetMilissegundos(handler) {
    if (event.keyCode == 8) {
        return;
    }
    var minutes = parseInt(handler.value);
    var milliseconds = minutes * 60000;
    $("#spaTempoAtualizaMapa").empty();
    $("#spaTempoAtualizaMapa").append(milliseconds);
}

function CloseInfo() {
    $("#divInfoMessage").css("display", "none");
}

function SalvarParams() {
    var tempoFalhaComunicacao = document.getElementById("txtTempoFalhaComunicacao").value;
    var tempoAtualizaMapa = $("#spaTempoAtualizaMapa").text();

    if (tempoFalhaComunicacao == "") {
        tempoFalhaComunicacao = "15";
    }

    if (document.getElementById("txtTempoAtualizaMapa").value == "" || document.getElementById("txtTempoAtualizaMapa").value == "0") {
        $("#txtTempoAtualizaMapa").prop("placeholder", getResourceItem("campoObrigatorio"));
        $("#txtTempoAtualizaMapa").addClass('valida');
        $("#txtTempoAtualizaMapa").focus();
        return;
    }
    else {
        $("#txtTempoAtualizaMapa").prop("placeholder", getResourceItem("minutos"));
        $("#txtTempoAtualizaMapa").removeClass('valida');
    }

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Map.asmx/SalveConfigParamsMap',
        dataType: 'json',
        data: "{'tempoFalhaComunicacao':'" + tempoFalhaComunicacao + "','tempoAtualizaMapa':'" + tempoAtualizaMapa + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#popupConfigParams").modal("hide");
            params = data; alert(getResourceItem("salvoComSucesso"));
        },
        error: function (data) {
            window.location.reload(true);
        }
    });
}

function GetConfiParams() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Map.asmx/GetConfigParams',
        dataType: 'json',
        data: "",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d[0] != "" && data.d[1] != "") {
                var tempoAtualizaMapa = parseInt(data.d[0]);

                $("#spaTempoAtualizaMapa").empty();
                $("#spaTempoAtualizaMapa").append(tempoAtualizaMapa);

                document.getElementById("txtTempoFalhaComunicacao").value = data.d[1];
                document.getElementById("txtTempoAtualizaMapa").value = tempoAtualizaMapa / 60000;
            }
            else {
                $("#spaTempoAtualizaMapa").empty();
                $("#spaTempoAtualizaMapa").append("");
                document.getElementById("txtTempoFalhaComunicacao").value = 15;
                document.getElementById("txtTempoAtualizaMapa").value = "";
            }

            $("#popupConfigParams").modal("show");
        },
        error: function (data) {
            window.location.reload(true);
        }
    });
}

//window.onload = load_map;
