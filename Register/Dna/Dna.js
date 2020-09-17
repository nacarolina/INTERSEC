
function pesqCruzamento() {
    var idDna = document.getElementById("txtIdLocal").value;
    var Dna = document.getElementById("txtCruzamento").value;

    $.ajax({
        type: 'POST',
        url: '../../WebServices/cadDna.asmx/PesqDna',
        dataType: 'json',
        data: "{'idDna':'" + idDna + "','Dna':'" + Dna + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d.toString() != "") {

                var lst = data.d[0].split('@');

                document.getElementById("txtIdLocal").value = lst[0];
                document.getElementById("hdfId").value = lst[0];
                document.getElementById("txtCruzamento").value = lst[1];
                var endereco = document.getElementById("txtCruzamento").value;
                document.getElementById("txtLat").value = lst[2];
                document.getElementById("txtLong").value = lst[3];

                document.getElementById("btnSalvarCruz").value = getResourceItem("editar");
                document.getElementById("btnExcluirCruz").style.visibility = "visible";
                document.getElementById("map").style.visibility = "visible";
                var latitude = document.getElementById("txtLat").value;
                var longitude = document.getElementById("txtLong").value;

                var latlng = new google.maps.LatLng(latitude, longitude);
                var options = {
                    zoom: 5,
                    center: latlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                map = new google.maps.Map(document.getElementById("map"), options);

                geocoder = new google.maps.Geocoder();

                marker = new google.maps.Marker({
                    map: map,
                    draggable: true,
                });

                marker.setPosition(latlng);

                var location = new google.maps.LatLng(latitude, longitude);
                marker.setPosition(location);
                map.setCenter(location);
                map.setZoom(15);
                document.getElementById("map").style.visibility = "visible";


                google.maps.event.addListener(marker, 'drag', function () {
                    geocoder.geocode({ 'latLng': marker.getPosition() }, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            if (results[0]) {
                                $("#txtCruzamento").val(results[0].formatted_address);
                                $("#txtLat").val(marker.getPosition().lat());
                                $("#txtLong").val(marker.getPosition().lng());
                            }
                        }
                    });
                });
            }
            else {
                document.getElementById("btnSalvarCruz").value = getResourceItem("salvar");
                document.getElementById("map").style.visibility = "visible";
                var endereco = document.getElementById("txtCruzamento").value;
                Geocodificacao(endereco);
                document.getElementById("txtIdLocal").value = "";
            }

        },
        error: function (data) {
        }
    });
}

function clearAll() {
    document.getElementById("btnSalvarCruz").value = getResourceItem("salvar");
    document.getElementById("btnExcluirCruz").style.visibility = "hidden";
    document.getElementById("txtIdLocal").value = "";
    document.getElementById("txtCruzamento").value = "";
    document.getElementById("txtLat").value = "";
    document.getElementById("txtLong").value = "";
    //document.getElementById("txtEmpresa").value = "";
    document.getElementById("txtIdLocal").placeholder = 'Id ' + getResourceItem("cruzamento") + '...';
    document.getElementById("txtIdLocal").style.borderColor = 'rgb(169, 169, 169)';
    document.getElementById("txtCruzamento").style.borderColor = 'rgb(169, 169, 169)';
    document.getElementById("txtCruzamento").placeholder = getResourceItem("cruzamento") + '...';

}

function NewCad() {
    document.getElementById("btnSalvarCruz").value = getResourceItem("salvar");
    document.getElementById("btnExcluirCruz").style.visibility = "hidden";
    document.getElementById("txtIdLocal").value = "";
    document.getElementById("txtCruzamento").value = "";
    document.getElementById("txtLat").value = "";
    document.getElementById("txtLong").value = "";
    //document.getElementById("txtEmpresa").value = "";
    document.getElementById("map").style.visibility = "hidden";
}

$(function () {
    loadResourcesLocales();
});

var globalResources;
function loadResourcesLocales() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: 'Default.aspx/requestResource',
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


