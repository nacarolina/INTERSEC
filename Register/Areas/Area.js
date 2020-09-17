var polygon = new google.maps.Polygon();
var map;
var arrPolygon = [];
var saveCoordsPoly = [];

$(function () {
    initialize("area");
    ListAllArea();
    loadResourcesLocales();
})

var globalResources;
function loadResourcesLocales() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: 'Area.aspx/requestResource',
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

function ListAllArea() {
    $("#tbArea").empty();
    $("#tfArea").css("display", "none");

    callServer('../../WebServices/Areas.asmx/ListAllArea', "",
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td>" + lst.Area + "</td>";
                    cols += "<td><a style='cursor:pointer;' data-toggle='modal' data-target='#modalGruposArea' onclick='loadGruposVinculadosArea(this)' data-area='" + lst.Area + "' data-idarea=" + lst.Id + ">" + getResourceItem("detalhes") + "</a></td>";
                    cols += "<td><a style='cursor:pointer;' onclick='VincularGrupos(this)' data-area='" + lst.Area + "' data-id=" + lst.Id + " data-coords='" + lst.Coordinates + "'>" + getResourceItem("vincularGrupos") + "</a></td>";
                    cols += "<td><a style='cursor:pointer;' onclick='DetalhesArea(this)' data-area='" + lst.Area + "' data-id=" + lst.Id + " data-coords='" + lst.Coordinates + "'>" + getResourceItem("detalhes") + "</a></td>";
                    cols += "<td><a style='cursor:pointer;' onclick='Excluir(this)' data-id=" + lst.Id + ">" + getResourceItem("excluir") + "</a></td>";
                    newRow.append(cols);
                    $("#tblArea").append(newRow);
                });
            }
            else {
                $("#tbArea").empty();
                $("#tfArea").css("display", "");
            }
        });
}

function Cancelar() {
    $("#btnSalvar").data("id", "");
    $("#txtNomeArea").val("");
    $("#txtArea").val("");
    for (var i = 0; i < arrPolygon.length; i++) {
        arrPolygon[i].setMap(null);
    }
    arrPolygon = [];
}

function VincularGrupos(attributes) {
    var id = $(attributes).data("id");
    var coords = $(attributes).data("coords");
    var area = $(attributes).data("area");
    var location = "";
    var pathArea = [];

    coords = coords.split(")");
    for (var i = 0; i < coords.length - 1; i++) {
        if (coords[i].charAt(0).toString() == ",") {
            var coordinates = coords[i].toString().replace(",", "");
            location = coordinates.split(",");
        }
        else location = coords[i].split(",");

        var position = new google.maps.LatLng(location[0], location[1]);
        pathArea.push(position);
    }
    var areaPolygon = new google.maps.Polygon({ paths: pathArea });

    if (markers.length == 0) swal(getResourceItem("informacao"), getResourceItem("alert_vinculoGruposAreaMapa") + "!", "info");
    else {
        var gruposVinculados = [];
        $.each(markers, function (index, item) {
            if (google.maps.geometry.poly.containsLocation(item.position, areaPolygon)) gruposVinculados.push({ "idLocal": item.id, "idArea": id });
        });

        callServer('../../WebServices/Areas.asmx/VincularGruposArea', JSON.stringify({ 'gruposVinculados': gruposVinculados }),
            function (results) {
                swal(getResourceItem("informacao"), getResourceItem("gruposVinculados") + "!", "success");
            });
    }

}

function loadGruposVinculadosArea(obj, idArea) {
    if (obj != 'reload') {
        idArea = $(obj).data("idarea");
        var area = $(obj).data("area");
        $("#preArea").text(getResourceItem("area") + ": " + area);
    }

    $("#tbGrupoArea").empty();
    $("#tfGrupoArea").css("display", "none");
    var pointGruposLogicos = [];
    callServer('../../WebServices/Areas.asmx/getGruposArea', "{'idArea':'" + idArea + "'}",
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td>" + lst.grupo + "</td>";
                    cols += "<td>" + lst.anel + "</td>";
                    cols += "<td>" + lst.Endereco + "</td>";
                    cols += "<td>" + lst.idEqp + "</td>";
                    cols += "<td><button type='button' class='btn btn-danger' data-idlocal='" + lst.idLocal + "' data-grupo='" + lst.grupo + "' data-idarea='" + idArea + "' data-idEqp='" + lst.idEqp + "' onclick='removeVinculoGruposArea(this)'> <span class='glyphicon glyphicon-trash'></span></button></td>";
                    newRow.append(cols);
                    $("#tblGrupoArea").append(newRow);

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

                $("#btnMarkerGrupos").data("active", true);
                $.each(markers, function (i, item) {
                    if (item != undefined) item.setMap(null);
                });
                markers = [];

                for (var i = 0; i < pointGruposLogicos.length; i++) {
                    var data = pointGruposLogicos[i];
                    var myLatlng = new google.maps.LatLng(data.lat, data.lng);
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
                        google.maps.event.addListener(marker, "click", function (e) {
                            marker.info = new google.maps.InfoWindow({
                                content: '<small>Id ' + getResourceItem("controlador") + ':' + data.idEqp + ' - G' + data.grupo + ' - ' + data.tipoGrupo + ' - ' + data.endereco + '</small>'
                            });
                            marker.info.open(map, marker);
                        });
                    })(marker, data);

                    markers.push(marker);
                }
            }
            else {
                $("#tbGrupoArea").empty();
                $("#tfGrupoArea").css("display", "");
            }
        });
}

function removeVinculoGruposArea(obj) {
    var idArea = $(obj).data("idarea");

    callServer("../../WebServices/Areas.asmx/ExcluirVinculoGrupoArea", "{'grupo':'" + $(obj).data("grupo") +
        "','idLocal':'" + $(obj).data("idlocal") + "','idArea':'" + idArea + "'}",
        function (results) {
            loadGruposVinculadosArea('reload', idArea);
            swal(getResourceItem("excluido"), getResourceItem("excluidoSucesso") + "!", "success");
        });
}

function DetalhesArea(attributes) {
    var latlng = "";
    var oLatLng = [];
    var id = $(attributes).data("id");
    var coords = $(attributes).data("coords");
    var area = $(attributes).data("area");

    $("#txtNomeArea").val(area);
    $('#divNovaArea').collapse('show');
    $("#btnSalvar").data("id", id);
    $("#txtArea").val("");

    coords = coords.split(")");
    for (var i = 0; i < coords.length - 1; i++) {
        if (coords[i].charAt(0).toString() == ",") {
            var coordinates = coords[i].toString().replace(",", "");
            latlng = coordinates.split(",");
        }
        else latlng = coords[i].split(",");

        oLatLng.push(new google.maps.LatLng(latlng[0], latlng[1]));
    }

    $.each(arrPolygon, function (index, item) {
        if (item != undefined) {
            if (item.id == id) {
                item.setMap(null);
                arrPolygon.splice(index, 1);
            }
        }
    });

    polygon = new google.maps.Polygon({
        paths: oLatLng,
        editable: true,
        map: map,
        id: id
    });
    arrPolygon.push(polygon);
    map.setCenter(oLatLng[0]);
    google.maps.event.addListener(polygon.getPath(), "insert_at", getPolygonCoords);
    google.maps.event.addListener(polygon.getPath(), "remove_at", getPolygonCoords);
    google.maps.event.addListener(polygon.getPath(), "set_at", getPolygonCoords);
}

function FindlistRows(position, element) {
    var input, filter, table, tr, td, i;
    input = document.getElementById(element.id);
    filter = input.value.toUpperCase();
    table = document.getElementById("tblArea");
    tr = table.getElementsByTagName("tr");
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[parseInt(position)];
        if (td) {
            if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

function getPolygonCoords() {
    var len = polygon.getPath().getLength();
    var htmlStr = "";
    saveCoordsPoly = [];
    for (var i = 0; i < len; i++) {
        var coords = polygon.getPath().getAt(i).toUrlValue().split(",");
        var latlng = new google.maps.LatLng(coords[0], coords[1]);
        saveCoordsPoly.push(latlng);
    }
}

function Salvar() {
    var coords = saveCoordsPoly.toString(), NomeArea = $("#txtNomeArea").val();
    var AreaCollection = [];

    if (NomeArea == "") {
        $("#txtNomeArea").css("border-color", "red");
        document.getElementById("txtNomeArea").placeholder = getResourceItem("campoObrigatorio") + "!";
        return false;
    }
    else {
        $("#txtNomeArea").css("border-color", "darkgrey");
        document.getElementById("txtNomeArea").placeholder = getResourceItem("area") + "...";
    }

    AreaCollection.push({ "coords": coords, "NomeArea": NomeArea, "id": $("#btnSalvar").data("id") });
    callServer('../../WebServices/Areas.asmx/Salvar', JSON.stringify({ 'AreaCollection': AreaCollection }),
        function (results) {
            if (results != "") {
                $('#divNovaArea').collapse('hide');
                Cancelar();
                ListAllArea();
                swal(getResourceItem("informacao"), getResourceItem("salvoComSucesso") + "!", "success");
            }
            else { swal(getResourceItem("atencao"), getResourceItem("naoFoiPossivelSalvarArea") + "!", "warning"); Cancelar(); }
        });

    $("#btnSalvar").data("id", "");
}

function Excluir(attributes) {
    var id = $(attributes).data("id");
    callServer('../../WebServices/Areas.asmx/Excluir', "{'id':'" + id + "'}",
        function (results) {
            $('#divNovaArea').collapse('hide');
            Cancelar();
            ListAllArea();
            swal(getResourceItem("excluido"), getResourceItem("excluidoSucesso") + "!", "success");
        });
}
