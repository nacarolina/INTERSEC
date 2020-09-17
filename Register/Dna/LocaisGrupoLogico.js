var map;

//$(function () {
    
//});

var globalResources;
function loadResourcesLocales() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: 'LocaisGruposSemaforicos.aspx/requestResource',
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

var markers = [];

function Geocodificacao(endereco, type, idLocal) {
    var pointGruposLogicos = [];
    markers = [];
    if (endereco == undefined || endereco == '') endereco = $("#txtCruzamento").val();

    var latlng;
    if (endereco != "") {
        geocoder = new google.maps.Geocoder();
        geocoder.geocode({ 'address': endereco }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[0]) {
                    var latitude = results[0].geometry.location.lat();
                    var longitude = results[0].geometry.location.lng();

                    $("#hdfLat").val(latitude);
                    $("#hdfLng").val(longitude);

                    latlng = new google.maps.LatLng(latitude, longitude);

                    var options = {
                        zoom: 22,
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
                    AddPointGruposLogicos(idLocal);
                    $("#map").css("visibility", "visible");
                }
                else $("#map").css("visibility", "hidden");
            }
        });
    }
}

function addMarkerType(map, latLng) {
    $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
    $("#btnSalvar").data('tipo', 'Salvar');

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

var markerEqp;

function VerificaFalhas(bitsFalha) {

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

function AddMarkerEqp(obj) {
    if (!$(obj).data("active")) {
        $(obj).data("active", true);
        callServer('../../WebServices/Map.asmx/LoadFilterMap', "{'consorcio':'','empresa':'','idPonto':'" + $("#hdfIdDna").val() + "','idPrefeitura':''}",
            function (eqp) {
                $.each(eqp, function (index, item) {
                    var statusPorta = "";
                    if (item.statusManutencao != "-1") CreateMarkerEqp(item.latitude, item.longitude, item.statusManutencao, item.idDna, "M", "");
                    else {
                        switch (item.statusComunicacao) {
                            case "True":
                                var bitsFalha = parseInt(item.falha).toString(2);
                                falhas = "";
                                var verificaFalhas = new VerificaFalhas(bitsFalha);
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
        markerEqp.setMap(null);
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
    markerEqp = marker;
    map.setCenter(latLng);
}

function AddMarkerGrupos(obj) {
    if (!$(obj).data("active")) {
        $(obj).data("active", true);
        if ($("#btnSalvar").data("tipo") == "Editar") Geocodificacao($("#hdfLocal").val(), 'editar', $("#hdfId").val());
        else Geocodificacao($("#hdfLocal").val(), 'novo');
    }
    else {
        $(obj).data("active", false);
        $.each(markers, function (i, item) {
            markers[i].setMap(null);
        });
    }
}

var circleAnel1 = [], circleAnel2 = [], circleAnel3 = [], circleAnel4 = [];
function AddAllAneis(obj) {

    if (!$(obj).data("active")) {

        $(obj).data("active", true);

        $.each(markers, function (index, item) {
            if (item.alt != "") {
                var circle = new google.maps.Circle({
                    center: item.position,
                    radius: 0.8,
                    strokeWeight: 1
                });

                switch (item.alt) {
                    case "1":
                        circle.setMap(map);
                        circle.setOptions({ fillColor: "red", strokeColor: "red" });
                        circleAnel1.push(circle);
                        break;
                    case "2":
                        circle.setMap(map);
                        circle.setOptions({ fillColor: "blue", strokeColor: "blue" });
                        circleAnel2.push(circle);
                        break;
                    case "3":
                        circle.setMap(map);
                        circle.setOptions({ fillColor: "green", strokeColor: "green" });
                        circleAnel3.push(circle);
                        break;
                    case "4":
                        circle.setMap(map);
                        circle.setOptions({ fillColor: "yellow", strokeColor: "yellow" });
                        circleAnel4.push(circle);
                        break;
                }

            }
        });
    }
    else {
        $(obj).data("active", false);
        for (var i = 1; i <= 4; i++) {
            $.each(circleAnel1, function (i, item) { circleAnel1[i].setMap(null); });
            $.each(circleAnel2, function (i, item) { circleAnel2[i].setMap(null); });
            $.each(circleAnel3, function (i, item) { circleAnel3[i].setMap(null); });
            $.each(circleAnel4, function (i, item) { circleAnel4[i].setMap(null); });
        }
    }
}

function ObterLocalGrupo(map, coords, tipo) {
    geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'latLng': coords }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            if (results[0]) {
                $("#txtCruzamento").val(results[0].formatted_address);
                $("#prelLocal").val(results[0].formatted_address);
                $("#hdfLat").val(coords.lat());
                $("#hdfLng").val(coords.lng());

                if (tipo == 'salvarLocal')
                    SalvarLocalGrupoLogico(map, coords);
                else if (tipo == 'editarLocal')
                    SalvarLocalGrupoLogico(map, coords);
            }
        }
    });
}

function listarLocais() {
    $("#lblIdEquipamento").text($("#hdfIdEqp").val() + " - " + getResourceItem("cruzamento") + ": " + $("#hdfLocal").val());
    $("#tbLocais").empty();
    $("#tfLocais").css("display", "none");

    callServer('../../WebServices/cadDna.asmx/listarLocais', "{'idEqp':'" + $("#hdfIdEqp").val() + "'}",
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td>" + lst.endereco + "</td>";

                    cols += "<td style='padding-right: 0.75rem; padding-left: 0.75rem;'><table id='tblGrupos" + lst.id + "' class='table table-bordered mb-0' style= 'margin-bottom: 0px;'> " +
                        "<thead id='thGrupos" + lst.id + "'><tr><th>" + getResourceItem("grupo") + "</th><th>" + getResourceItem("tipo") + "</th><th>" +getResourceItem("anel") + "</th><th>" +  getResourceItem("modelo") + "</th></tr></thead><tbody id='tbGrupos" + lst.id + "'></tbody>" +
                        "<tfoot id='tfGrupos" + lst.id + "' style='display: none'><tr><td colspan='3'>" + getResourceItem("naoHaRegistros") + "</td></tr></tfoot></table></td>";

                    cols += "<td style='text-align: center;'><button type='button' class='btn btn-info' data-id='" + lst.id + "' data-local='" + lst.endereco + "' data-latitude='" + lst.latitude + "' data-longitude='" + lst.longitude +
                        "' data-tipoMarcador='" + lst.tipoMarcador + "' onclick='callMapGrupoSemaforico(this)'>" + getResourceItem("detalhes") + "</button></td>";
                    newRow.append(cols);
                    $("#tblLocais").append(newRow);
                    ListarGruposVinculados(lst.id);
                });
            }
            else {
                $("#tbLocais").empty();
                $("#tfLocais").css("display", "");
            }
        });
}

function ListarGruposVinculados(idLocal) {
    $("#tbGrupos" + idLocal).empty();
    $("#tfGrupos" + idLocal).css("display", "none");

    callServer('../../WebServices/cadDna.asmx/ListarGruposSemaforicos', "{'idLocal':'" + idLocal + "','idEqp':'" + $("#hdfIdEqp").val() + "'}",
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td>" + lst.grupo + "</td>";
                    cols += "<td>" + lst.tipo + "</td>";
                    cols += "<td>" + lst.anel + "</td>";
                    cols += "<td>" + lst.modelo + "</td>";
                    newRow.append(cols);
                    $("#tblGrupos" + idLocal).append(newRow);
                });
            }
            else {
                $("#tbGrupos" + idLocal).empty();
                $("#tfGrupos" + idLocal).css("display", "");
            }
        });
}

function callMapGrupoSemaforico(obj) {

    if (obj == 'novo') {
        window.open("MapGrupoSemaforico.aspx?tipo=novo&idEqp=" + $("#hdfIdEqp").val() + "&local=" + $("#hdfLocal").val() + "&idDna=" + $("#hdfIdDna").val());
        return false;
    }
    else {
        window.open("MapGrupoSemaforico.aspx?tipo=detalhes&id=" + $(obj).data("id") + "&idEqp=" + $("#hdfIdEqp").val() +
            "&idDna=" + $("#hdfIdDna").val() + "&local=" + $("#hdfLocal").val() + "&typeMarker=" + $(obj).data("tipomarcador") +
            "&cruzamento=" + $(obj).data("local") + "&lat=" + $(obj).data("latitude") + "&lng=" + $(obj).data("longitude"));
        return false;
    }
}

function novoLocal() {
    $("#btnSalvar").data('tipo', 'Salvar');
    $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
    Geocodificacao($("#hdfLocal").val(), 'novo');
    $('#hdfTypeMarker').val('');
}

function Detalhes(local, id) {
    $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
    Geocodificacao(local, 'editar', id);
    $("#btnSalvar").data('tipo', 'Editar');
    $('#hdfTypeMarker').val('');
}

function SalvarLocalGrupoLogico(map, coords) {
    var local = $("#txtCruzamento").val().replace("'", ""), latitude = $("#hdfLat").val(), longitude = $("#hdfLng").val(),
        grupo = $("#smallGpSelecionado").text().replace(getResourceItem("grupoSemaforicoSelecionado") + ":", "");

    if ($("#btnSalvar").data("tipo") == "Salvar") {
        callServer('../../WebServices/cadDna.asmx/SalvarLocalGrupoLogico', "{'local':'" + local + "','latitude':'" + latitude + "','longitude':'" + longitude +
            "','grupo':'" + grupo + "','idEqp':'" + $("#hdfIdEqp").val() +
            "','tipoMarcador':'" + $('#hdfTypeMarker').val() + "'}",
            function (results) {
                if (results != "") {
                    $("#hdfId").val(results);
                    listarLocais();
                    addMarkerType(map, coords);
                }
            });
    } else {
        var id = $("#hdfId").val();
        callServer('../../WebServices/cadDna.asmx/EditarLocalGrupoLogico', "{'id':'" + id + "','local':'" + local + "','latitude':'" + latitude + "','longitude':'" + longitude
            + "','grupo':'" + grupo + "','idEqp':'" + $("#hdfIdEqp").val() + "'}",
            function (results) {
                listarLocais();
            });
    }
}

function loadModeloGrupos() {
    $.ajax({
        url: 'MapGrupoSemaforico.aspx/loadModeloGrupos',
        data: "{}",
        dataType: "json",
        async: false,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#sleModelo").empty();
            $("#sleModelo").append($("<option></option>").val("").html("Selecione.."));
            $.each(data.d, function () {
                $("#sleModelo").append($("<option></option>").val(this['Value']).html(this['Text']));
            });

        }
    });
}
function CancelarCadGrupo() {

    $("#tblGrupoSemaforico").css("display", "");
    $("#dvCadastroGrupo").css("display", "none");
}
function NovoGrupo() {
    loadModeloGrupos();
    $("#hfOperacaoCad").val("salvar");
    $("#sleGrupo").val("");
    $("#sleTipo").val("");
    $("#sleModelo").val("");
    $("#sleAnel").val("");
    $("#tblGrupoSemaforico").css("display", "none");
    $("#dvCadastroGrupo").css("display", "");
}

function SalvarGrupo() {
    if ($("#sleGrupo").val()=="") {
        $("#sleGrupo").focus();
        swal(getResourceItem("erro"), "Informe o grupo!", "error");
        return;
    }
    if ($("#sleTipo").val() == "") {
        $("#sleTipo").focus();
        swal(getResourceItem("erro"), "Informe o tipo!", "error");
        return;
    }
    if ($("#sleModelo").val() == "") {
        $("#sleModelo").focus();
        swal(getResourceItem("erro"), "Informe o modelo!", "error");
        return;
    }
    if ($("#sleAnel").val() == "") {
        $("#sleAnel").focus();
        swal(getResourceItem("erro"), "Informe o anel!", "error");
        return;
    }
    $.ajax({
        url: 'MapGrupoSemaforico.aspx/SalvarGrupo',
        data: "{'grupo':'" + $("#sleGrupo").val() + "','tipo':'" + $("#sleTipo").val() + "','modelo':'" + $("#sleModelo").val() + "','anel':'" + $("#sleAnel").val() + "','idEqp':'"
            + $("#hdfIdEqp").val() + "','idLocal':'"+$("#hfIdLocal").val()+"','tipoMarcador':'" + $('#hdfTypeMarker').val()+"','operacao':'"+$("#hfOperacaoCad").val()+"'}",
        dataType: "json",
        async: false,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d == "SUCESSO") {
                if ($("#hfOperacaoCad").val() == "salvar") {

                    $("#tblGrupoSemaforico").css("display", "");
                    $("#dvCadastroGrupo").css("display", "none");

                    Geocodificacao($("#txtCruzamento").val(), 'editar', $("#hfIdLocal").val());
                    $("#btnSalvar").data('tipo', 'Editar');
                    ListarGruposSemaforicos($("#hfIdLocal").val());
                    listarLocais();
                    swal(getResourceItem("informacao"), getResourceItem("salvoComSucesso"), "success");
                    $("#modalGruposSemaforicos").modal("hide");
                }
                else {
                    $("#tblGrupoSemaforico").css("display", "");
                    $("#dvCadastroGrupo").css("display", "none");

                    ListarGruposSemaforicos($("#hfIdLocal").val());
                }
            }
            else {
                swal(getResourceItem("erro"), "Esse grupo já está cadastrado!", "error");
            }
        }
    });
}

function ListarGruposSemaforicos(idLocal) {
    $("#tbGrupoSemaforico").empty();
    $("#tbGrupoSemaforicoVinculados").empty();
    $("#tfGrupoSemaforico").css("display", "none");
    $("#tfGrupoSemaforicoVinculados").css("display", "none");

    callServer('../../WebServices/cadDna.asmx/ListarGruposSemaforicos', "{'idLocal':'','idEqp':'" + $("#hdfIdEqp").val() + "'}",
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='text-align:center;padding-top:16px;'>" + lst.grupo + "</td>";
                    cols += "<td style='text-align:center;padding-top:16px;'>" + lst.tipo + "</td>";
                    cols += "<td style='text-align:center;padding-top:16px;'>" + lst.modelo + "</td>";
                    cols += "<td style='text-align:center;padding-top:16px;'>" + lst.anel + "</td>";
                    cols += '<td style="text-align: center;padding:0px; padding-top: 12px;"><button class="btn mr-1 mb-1 btn-outline-info btn-sm" type="button" id="btnVinculoGrupo" data-dismiss="modal" data-tipoMarker="' + $("#hdfTypeMarker").val() + '" data-idEqp="' + lst.idEqp + '" data-idLocal="' + idLocal + '" data-grupo="' + lst.grupo + '" onclick="VincularGrupoSemaforico(this)">' + getResourceItem("vincular") + '</button></td>';
                    cols += '<td style="text-align: center;padding:0px; padding-top: 12px;"><button class="btn mr-1 mb-1 btn-outline-warning btn-sm" data-anel="' + lst.anel +'"  type="button" id="btnEditarGrupo" data-tipo="' + lst.tipo + '" data-idEqp="' + lst.idEqp + '" data-idmodelo="' + lst.idModelo + '" data-grupo="' + lst.grupo + '" onclick="EditarGrupo(this)"><i class="ft-edit-3"></i></button></td>';
                    newRow.append(cols);
                    $("#tblGrupoSemaforico").append(newRow);
                });


            } else {
                $("#tbGrupoSemaforico").empty();
                $("#tfGrupoSemaforico").css("display", "");
            }
        });

    callServer('../../WebServices/cadDna.asmx/ListarGruposSemaforicos', "{'idLocal':'" + idLocal + "','idEqp':'" + $("#hdfIdEqp").val() + "'}",
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var iconLabel = "";
                    if (lst.tipoMarcador == "cima") iconLabel = '<span class="ft ft-arrow-up"></span>';
                    else if (lst.tipoMarcador == "baixo") iconLabel = '<span class="ft ft-arrow-down2"></span>';
                    else if (lst.tipoMarcador == "direita") iconLabel = '<span class="ft ft-arrow-right"></span>';
                    else if (lst.tipoMarcador == "esquerda") iconLabel = '<span class="ft ft-arrow-left"></span>';
                    else if (lst.tipoMarcador == "conversão direita") iconLabel = '<span class="ft ft-corner-up-right"></span>';
                    else if (lst.tipoMarcador == "conversão esquerda") iconLabel = '<span class="ft ft-corner-up-left"></span>';
                    else if (lst.tipoMarcador == "diagonal cima direita") iconLabel = '<span class="ft ft-arrow-up-right"></span>';
                    else if (lst.tipoMarcador == "diagonal cima esquerda") iconLabel = '<span class="ft ft-arrow-up-left"></span>';
                    else if (lst.tipoMarcador == "diagonal baixo direita") iconLabel = '<span class="ft ft-arrow-down-right"></span>';
                    else if (lst.tipoMarcador == "diagonal baixo esquerda") iconLabel = '<span class="ft ft-arrow-down-left"></span>';
                    else if (lst.tipoMarcador == "pedestre") iconLabel = '<i class="material-icons">directions_walk</i>';

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='text-align:center;padding-top:16px;'>" + lst.grupo + "</td>";
                    cols += "<td style='text-align:center;padding-top:16px;'>" + lst.tipo + "</td>";
                    cols += "<td style='text-align:center;padding-top:16px;'>" + iconLabel + "</td>";
                    cols += "<td style='text-align:center;padding-top:16px;'>" + lst.modelo + "</td>";
                    cols += "<td style='text-align:center;padding-top:16px;'>" + lst.anel + "</td>";
                    cols += "<td style='text-align:center;padding:0px; padding-top:12px;padding-left:12px;'><button type='button' class='btn mr-1 mb-1 btn-outline-danger btn-sm' data-idEqp='" + lst.idEqp + "' data-idLocal='" + idLocal + "' data-grupo='" + lst.grupo + "' onclick='ExcluirVinculoGrupoSemaforico(this)'>" + getResourceItem("excluir") + "</button></td>";
                    cols += '<td style="text-align: center;padding:0px; padding-top: 12px;padding-left:12px;"><button class="btn mr-1 mb-1 btn-outline-warning btn-sm" type="button" data-anel="'+lst.anel+'" id="btnEditarGrupo" data-tipo="' + lst.tipo + '" data-idEqp="' + lst.idEqp + '" data-idmodelo="' + lst.idModelo + '" data-grupo="' + lst.grupo + '" onclick="EditarGrupo(this)"><i class="ft-edit-3"></i></button></td>';
                    newRow.append(cols);
                    $("#tblGrupoSemaforicoVinculados").append(newRow);
                });


            } else {
                $("#tbGrupoSemaforicoVinculados").empty();
                $("#tfGrupoSemaforicoVinculados").css("display", "");
            }
        });
}

function EditarGrupo(btn) {
    $("#hfOperacaoCad").val("editar");
    loadModeloGrupos();
    $("#sleGrupo").val(btn.dataset.grupo);
    $("#sleTipo").val(btn.dataset.tipo);
    $("#sleModelo").val(btn.dataset.idmodelo);
    $("#sleAnel").val(btn.dataset.anel);

    $("#sleGrupo")[0].disabled = true;
    $("#sleAnel")[0].disabled = true;
    $("#tblGrupoSemaforico").css("display", "none");
    $("#dvCadastroGrupo").css("display", "");

}

function DetalhesGrupoSemaforico(obj) {
    var id = $(obj).data("id");
    var local = $(obj).data("local");
    $("#prelLocal").val($("#txtCruzamento").val());
    $("#hdfTypeMarker").val($(obj).data("tipomarcador"));
    ListarGruposSemaforicos(id);
    $("#hfIdLocal").val(id);
}

function SalvarEndereco() {
    var local = $("#prelLocal").val().replace("'", ""), latitude = $("#hdfLat").val(), longitude = $("#hdfLng").val(),
        grupo = $("#smallGpSelecionado").text().replace(getResourceItem("grupoSemaforicoSelecionado") + ":", "");

    if ($("#btnSalvar").data("tipo") == "Salvar") {
        callServer('../../WebServices/cadDna.asmx/SalvarLocalGrupoLogico', "{'local':'" + local + "','latitude':'" + latitude + "','longitude':'" + longitude +
            "','grupo':'" + grupo + "','idEqp':'" + $("#hdfIdEqp").val() +
            "','tipoMarcador':'" + $('#hdfTypeMarker').val() + "'}",
            function (results) {
                swal(getResourceItem("informacao"), getResourceItem("salvoComSucesso"), "success");
            });
    } else {
        var id = $("#hdfId").val();
        callServer('../../WebServices/cadDna.asmx/EditarLocalGrupoLogico', "{'id':'" + id + "','local':'" + local + "','latitude':'" + latitude + "','longitude':'" + longitude
            + "','grupo':'" + grupo + "','idEqp':'" + $("#hdfIdEqp").val() + "'}",
            function (results) {
                swal(getResourceItem("informacao"), getResourceItem("salvoComSucesso"), "success");
            });
    }
}

function VincularGrupoSemaforico(obj) {
    var idEqp = $(obj).data("ideqp");
    var idLocal = $(obj).data("idlocal");
    var grupo = $(obj).data("grupo");
    var tipoMarker = $(obj).data("tipomarker");

    callServer('../../WebServices/cadDna.asmx/VincularGrupoSemaforico', "{'idLocal':'" + idLocal + "','grupo':'" + grupo + "','idEqp':'" + idEqp +
        "','tipoMarcador':'" + tipoMarker + "'}",
        function (results) {
            $('#hdfTypeMarker').val(tipoMarker);
            $("#hdfId").val(idLocal);
            Geocodificacao($("#txtCruzamento").val(), 'editar', idLocal);
            $("#btnSalvar").data('tipo', 'Editar');
            ListarGruposSemaforicos(idLocal);
            listarLocais();
            swal(getResourceItem("informacao"), getResourceItem("salvoComSucesso"), "success");
        });
}

function ExcluirVinculoGrupoSemaforico(obj) {
    var idEqp = $(obj).data("ideqp");
    var idLocal = $(obj).data("idlocal");
    var grupo = $(obj).data("grupo");

    callServer('../../WebServices/cadDna.asmx/ExcluirVinculoGrupoSemaforico', "{'idLocal':'" + idLocal + "','grupo':'" + grupo + "','idEqp':'" + idEqp + "'}",
        function (results) {
            $("#hdfId").val(idLocal);
            Geocodificacao($("#txtCruzamento").val(), 'editar', idLocal);
            $("#btnSalvar").data('tipo', 'Editar');
            ListarGruposSemaforicos(idLocal);
            listarLocais();
            swal(getResourceItem("excluido"), getResourceItem("excluidoSucesso"), "success");
        });
}

function AddPointGruposLogicos(idLocal) {
    if (idLocal == undefined) idLocal = "";
    var pointGruposLogicos = [];

    callServer("../../WebServices/cadDna.asmx/getGruposLocais", "{'idEqp':'" + $("#hdfIdEqp").val() + "','idLocal':'" + idLocal + "'}",
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {

                    if (idLocal == lst.idLocal) {
                        if (lst.grupo != "") $("#smallGpSelecionado").text(getResourceItem("grupoSemaforicoSelecionado") + ":" + lst.grupo);
                        else $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
                        map.setCenter(new google.maps.LatLng(lst.lat, lst.lng));
                    }

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
                        id: data.idLocal
                    });

                    (function (marker, data) {
                        geocoder = new google.maps.Geocoder();

                        google.maps.event.addListener(marker, 'dragend', function () {
                            $("#btnSalvar").data('tipo', 'Editar');
                            $("#hdfId").val(data.idLocal);
                            if (data.grupo != "") $("#smallGpSelecionado").text(getResourceItem("grupoSemaforicoSelecionado") + ":" + data.grupo);
                            else $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
                            ObterLocalGrupo(map, marker.getPosition(), 'editarLocal');
                        });

                        google.maps.event.addListener(marker, "click", function (e) {
                            $("#hdfId").val(data.idLocal);
                            ObterLocalGrupo(map, marker.getPosition());
                            if (data.grupo != "") $("#smallGpSelecionado").text(getResourceItem("grupoSemaforicoSelecionado") + ":" + data.grupo);
                            else $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
                            marker.info = new google.maps.InfoWindow({
                                content: '<button type="button" class="btn btn-primary" data-tipoMarcador="' + data.tipoMarker + '" data-id=' + data.idLocal + ' data-local="' + data.endereco + '" onclick="DetalhesGrupoSemaforico(this)" data-toggle="modal" data-target="#modalGruposSemaforicos">' + getResourceItem("grupo") + '</button>' +
                                    '<button type="button" style="margin-left:10px;" data-id="' + data.idLocal + '" onclick="deleteLocal(this)" class="btn btn-danger">' + getResourceItem("excluir") + '</button>'
                            });
                            marker.info.open(map, marker);
                        });
                    })(marker, data);

                    markers.push(marker);
                }
            }
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

function deleteLocal(obj) {
    var idLocal = $(obj).data("id");
    var marker = markers.filter(function (value) { return value.id == idLocal });
    marker["0"].setMap(null);

    callServer("../../WebServices/cadDna.asmx/deleteLocal", "{'idLocal':'" + idLocal + "'}",
        function (results) {
            $("#smallGpSelecionado").text(getResourceItem("naoHaGrupoVinculadoDna") + "!");
            $('#hdfTypeMarker').val('');
            listarLocais();
            swal(getResourceItem("excluido"), getResourceItem("excluidoSucesso"), "success");
        });
}
