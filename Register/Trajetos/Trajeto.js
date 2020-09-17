
var gruposTrajeto = [];

$(function () {
    loadResourcesLocales();
});

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

function Save() {
    var idArea = "";
    if ($("#preArea").text() == getResourceItem("areaSelecionada") + ":") {
        swal(getResourceItem("atencao"), getResourceItem("selecioneArea"), "info");
        return false;
    }
    else idArea = $("#preArea").data("id");

    var Wayp = snappedCoordinates.toString(), Trajeto = $("#txtTrajeto").val(), id = $("#hfId").val();
    var routes = [];
    var routeWayPoints = { "Waypoints": Wayp, "Trajeto": Trajeto, "id": id, "idArea": idArea };
    routes.push(routeWayPoints);

    if ($("#btnSalvar").data("type") == "Salvar") {
        callServer("TrajetoGrupoSemaforico.aspx/SalvarTrajeto", JSON.stringify({ 'routes': routes }),
            function (results) {
                var id = results;
                $("#btnSalvar").data("type", "Editar");
                $("#hfId").val(id);
                $("#hfCallServer").val("Datails");
                if (gruposTrajeto.length) SalvarVinculoGrupo('vincularGrupos');
                swal(getResourceItem("informacao"), getResourceItem("salvoComSucesso"), "success");
            });
    }
    else {
        callServer("TrajetoGrupoSemaforico.aspx/EditarTrajeto", JSON.stringify({ 'routes': routes }),
            function (results) {
                var id = results;
                $("#btnSalvar").data("type", "Editar");
                $("#hfId").val(id);
                if (gruposTrajeto.length) SalvarVinculoGrupo('vincularGrupos');
                swal(getResourceItem("informacao"), getResourceItem("salvoComSucesso"), "success");
            });
    }
}

function ContinuarTrajeto(obj) {
    var latlng = new google.maps.LatLng($(obj).data("lat"), $(obj).data("lng"));
    var path = snappedPolyline.getPath();
    path.push(latlng);
    setPolyline();
}

function setPolyline() {
    polylines = [], snappedCoordinates = [];

    for (var i = 0; i < snappedPolyline.getPath().getLength(); i++) {
        var coords = snappedPolyline.getPath().getAt(i).toUrlValue().split(",");
        var latlng = new google.maps.LatLng(coords[0], coords[1]);
        snappedCoordinates.push(latlng);
    }
    polylines.push(snappedPolyline);
}

function Excluir() {
    callServer("TrajetoGrupoSemaforico.aspx/ExcluirTrajeto", "{'id':'" + $("#hfId").val() + "'}",
        function (results) {
            Cancelar('Novo');
            swal(getResourceItem("excluido"), getResourceItem("excluidoSucesso"), "success");
        });
}

function Cancelar(attr) {
    gruposTrajeto = [];
    snappedCoordinates = [];
    snappedPolyline = new google.maps.Polyline({
        editable: true,
        map: map
    });

    for (var i = 0; i < polylines.length; ++i) {
        polylines[i].setMap(null);
    }
    polylines = [];

    //$("#preArea").text(getResourceItem("areaSelecionada") + ":");

    if (attr == 'Novo') {
        $("#hfCallServer").val("NewRegister");
        $("#hfId").val("");
        $("#btnSalvar").data("type", "Salvar");
        $("#txtTrajeto").val("");
    }

    $("#tbInfo").empty();
    $("#tfInfo").css("display", "");
}

function vinculoGrupoTrajeto() {
    var position = map.location;
    if ($("#btnVincularGrupos").text().indexOf(getResourceItem("vincularGruposRota")) != -1) {
        if ($("#hfId").val() != "") {
            $.each(markers, function (index, marker) {
                marker.info.open(map, marker);
            });
        }
        else {
            swal(getResourceItem("informação"), getResourceItem("salvarTrajetoVincularGrupo"), "info");
            return false;
        }
        map.setCenter(position);
        $("#btnVincularGrupos").text(getResourceItem("cancelarVinculosRota"));
    }
    else {
        $.each(markers, function (index, marker) {
            marker.info.close(map, marker);
        });
        $("#btnVincularGrupos").text(getResourceItem("vincularGruposRota"));
    }
}

function SalvarVinculoGrupo(obj) {
    var grupos = [];

    if (obj == 'vincularGrupos') {
        $.each(gruposTrajeto, function (index, item) {
            var id = $("#hfId").val(), grupo = item.grupo, idLocal = item.idLocal;

            var infoGrupo = { "id": id, "grupo": grupo, "idLocal": idLocal };
            grupos.push(infoGrupo);
        })
    }
    else {
        $.each(markers, function (index, marker) {
            if (parseInt(marker.id) == $(obj).data("idlocal")) marker.info.close(marker, map);
        });

        var id = $("#hfId").val(), grupo = $(obj).data("grupo"), idLocal = $(obj).data("idlocal");

        var infoGrupo = { "id": id, "grupo": grupo, "idLocal": idLocal };
        grupos.push(infoGrupo);
    }

    callServer("TrajetoGrupoSemaforico.aspx/SalvarGrupoTrajeto", JSON.stringify({ 'grupos': grupos }), function (results) {
        gruposTrajeto = [];
        swal(getResourceItem("informacao"), getResourceItem("gruposVinculados"), "success");
        if (obj == 'vincularGrupos') loadGruposVinculados();
    });
}

function loadRoutes(id) {
    snappedCoordinates = [];
    for (var i = 0; i < polylines.length; ++i) {
        polylines[i].setMap(null);
    }
    polylines = [];

    callServer("TrajetoGrupoSemaforico.aspx/DetalhesTrajeto", "{'id':'" + id + "'}",
        function (results) {
            if (results != "") {
                var lst = results[0];
                var lstWayPoints = lst.WayPoints.split('@');

                $("#btnSalvar").data("type", "Editar");
                $("#hfId").val(lst.Id);
                $("#txtTrajeto").val(lst.Trajeto);
                $("#preArea").text(getResourceItem("areaSelecionada") + ":" + lst.area);

                $("#preArea").data("area", lst.area);
                $("#preArea").data("coords", lst.coords);
                $("#preArea").data("id", lst.idArea);

                AbrirArea($("#preArea")[0]);

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
                        lat = LatLngPoints[0], lng = LatLngPoints[1];
                        latlng = new google.maps.LatLng(lat, lng);
                        snappedPolyline.getPath().push(latlng);
                    }

                }
                setPolyline();
                map.setCenter(latlng);
            }
        });
}

function ListAllArea() {
    $("#treeArea").empty();
    $("#treeArea").removeClass("tree");

    callServer('../../Default.aspx/ListarAreas', "{'tipo':'area'}",
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var newArea = "<li id='area" + lst.id + "' data-id='" + lst.id + "'> " +
                        "<img src='../../Images/area.png' style='width:16px; heigth:16px;'/> - <label style='cursor:pointer;'>" + lst.nome + "</label>" +
                        "</li>";
                    $("#treeArea").append(newArea);
                });
            }
            else {
                $("#treeArea").empty();
                $("#treeArea").removeClass("tree");
            }

            listSubArea();
        });
}

function listSubArea() {
    callServer('../../Default.aspx/ListarAreas', "{'tipo':'subArea'}",
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var newSubArea = "<ul><li id='subArea" + lst.id + "' data-id='" + lst.id + "'>" +
                        "<img src='../../Images/subArea.png' style='width:16px; heigth:16px;'/> - <label data-id=" + lst.id + " data-area='" + lst.nome + "' onclick='AbrirArea(this);' style='cursor:pointer;'> " + lst.nome + "</label> " +
                        "</li></ul>";
                    $('[data-id=' + lst.idArea + ']').eq(0).append(newSubArea);
                });
            }
            reloadTree();
        });
}

function AbrirArea(attributes) {
    var id = $(attributes).data("id");
    var area = $(attributes).data("area");
    $("#preArea").text(getResourceItem("areaSelecionada") + ":" + area);

    $("#preArea").data("area", area);
    $("#preArea").data("id", id);
    loadGruposVinculadosArea(id);
}

function loadGruposVinculadosArea(idArea) {
    var pointGruposLogicos = [];
    callServer('../../WebServices/Areas.asmx/getGruposArea', "{'idArea':'" + idArea + "'}",
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
                        "anel": lst.anel
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

                    marker.info = new google.maps.InfoWindow({
                        content: '<small class="text-muted" data-grupo="' + data.grupo + '" data-idLocal="' + data.idLocal + '" style="cursor:pointer; color:green" onclick="SalvarVinculoGrupo(this)"><span class="glyphicon glyphicon-ok pull-right"></span></small>'
                    });

                    (function (marker, data) {
                        google.maps.event.addListener(marker, "click", function (e) {
                            var path = snappedPolyline.getPath();
                            path.push(e.latLng);
                            setPolyline();
                            gruposTrajeto.push(data);
                        });
                    })(marker, data);

                    markers.push(marker);
                }
            }
        });
}

function loadGruposVinculados() {
    $("#tbInfo").empty();
    $("#tfInfo").css("display", "none");
    var pointGruposLogicos = [];
    callServer('TrajetoGrupoSemaforico.aspx/getGruposVinculados', "{'idTrajeto':'" + $("#hfId").val() + "'}",
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td>" + lst.grupo + "</td>";
                    cols += "<td>" + lst.anel + "</td>";
                    cols += "<td>" + lst.Endereco + "</td>";
                    cols += "<td>" + lst.idEqp + "</td>";
                    cols += "<td><button type='button' class='btn btn-danger' data-idLocal='" + lst.idLocal +
                        "' data-grupo='" + lst.grupo + "' onclick='removeVinculoGrupos(this)'><span class='glyphicon glyphicon-trash'></span></button></td>";
                    newRow.append(cols);
                    $("#tblInfo").append(newRow);

                    var marker = {
                        "grupo": lst.grupo,
                        "tipoGrupo": lst.tipo,
                        "endereco": lst.Endereco,
                        "lat": lst.lat,
                        "lng": lst.lng,
                        "tipoMarker": lst.tipoMarcador,
                        "idLocal": lst.idLocal,
                        "anel": lst.anel
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

                    marker.info = new google.maps.InfoWindow({
                        content: '<small class="text-muted" data-grupo="' + data.grupo + '" data-idLocal="' + data.idLocal + '" style="cursor:pointer; color:green" onclick="SalvarVinculoGrupo(this)"><span class="glyphicon glyphicon-ok pull-right"></span></small>'
                    });

                    (function (marker, data) {
                        google.maps.event.addListener(marker, "click", function (e) {
                            var path = snappedPolyline.getPath();
                            path.push(e.latLng);
                            setPolyline();
                            gruposTrajeto.push(data);
                        });
                    })(marker, data);

                    markers.push(marker);
                }
            }
            else {
                $("#tbInfo").empty();
                $("#tfInfo").css("display", "");
            }
        });
}

function removeVinculoGrupos(obj) {
    callServer("TrajetoGrupoSemaforico.aspx/ExcluirVinculoGrupo", "{'grupo':'" + $(obj).data("grupo") + "','idLocal':'" + $(obj).data("idlocal") + "'}",
        function (results) {
            loadGruposVinculados();
            swal(getResourceItem("excluido"), getResourceItem("excluidoSucesso"), "success");
        });
}

function Voltar() {
    window.location.replace("../Corredor/Default.aspx");
}