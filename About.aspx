<%@ Page Title="About" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="GwCentral.About" %>

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
  <%--  <script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-label/v0.2.1/leaflet.label.js'></script>
    <link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-label/v0.2.1/leaflet.label.css' rel='stylesheet' />--%>

     <script src='https://api.mapbox.com/mapbox-gl-js/v1.4.1/mapbox-gl.js'></script>
    <link href='https://api.mapbox.com/mapbox-gl-js/v1.4.1/mapbox-gl.css' rel='stylesheet' />
    <style>
        .marker {
display: block;
border: none;
border-radius: 50%;
cursor: pointer;
padding: 0;
}
    </style>


    <asp:HiddenField ID="hfIdPrefeitura" runat="server" ClientIDMode="Static"></asp:HiddenField>
    <div id="map" style="position: absolute !important; width: 100%; height: 100%; left: 0px; top:0px" class="leaflet-container leaflet-retina leaflet-fade-anim"></div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/e8cc7ed1ec.js" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="Scripts/jsts.min.js"></script>
    <script src="Scripts/leaflet/leaflet.geometryutil.js"></script>
    <script src="https://unpkg.com/three@0.106.2/build/three.min.js"></script>
<script src="https://unpkg.com/three@0.106.2/examples/js/loaders/GLTFLoader.js"></script>
    <script>
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

            /*L.mapbox.accessToken = 'pk.eyJ1IjoiemVsYW8iLCJhIjoiY2lndjU5Zmx3MGhvenZxbTNlOWQ4YXE1ZCJ9.oGn84GgkJqonGYYm5bqi8Q';
            map = L.mapbox.map('map', 'mapbox.streets')
                .addControl(L.mapbox.geocoderControl('mapbox.places', {
                    autocomplete: true
                }));*/

            if (lat == "")
                lat = -23.1543;

            if (lng == "")
                lng = -47.43877;

            if (zoom == "")
                zoom = 12;

            mapboxgl.accessToken = 'pk.eyJ1IjoiemVsYW8iLCJhIjoiY2lndjU5Zmx3MGhvenZxbTNlOWQ4YXE1ZCJ9.oGn84GgkJqonGYYm5bqi8Q';
            /*map = new mapboxgl.Map({
                style: 'mapbox://styles/mapbox/light-v10',
                center: [lng, lat],
                zoom: zoom,
                pitch: 45,
                bearing: 0,
                container: 'map',
                antialias: true
            });*/

            map = (window.map = new mapboxgl.Map({
                container: 'map',
                style: 'mapbox://styles/mapbox/streets-v11',
                zoom: 18,
                center: [-54.575373, -25.524297],
                pitch: 60,
                antialias: true // create the gl context with MSAA antialiasing, so custom layers are antialiased
            }));
                                              //streets-v11
            // The 'building' layer in the mapbox-streets vector source contains building-height
            // data from OpenStreetMap.
            map.on('load', function () {
                // Insert the layer beneath any symbol layer.
                var layers = map.getStyle().layers;

                var labelLayerId;
                for (var i = 0; i < layers.length; i++) {
                    if (layers[i].type === 'symbol' && layers[i].layout['text-field']) {
                        labelLayerId = layers[i].id;
                        break;
                    }
                }

                map.addLayer(
                    {
                        'id': '3d-buildings',
                        'source': 'composite',
                        'source-layer': 'building',
                        'filter': ['==', 'extrude', 'true'],
                        'type': 'fill-extrusion',
                        'minzoom': 15,
                        'paint': {
                            'fill-extrusion-color': '#aaa',

                            // use an 'interpolate' expression to add a smooth transition effect to the
                            // buildings as the user zooms in
                            'fill-extrusion-height': [
                                'interpolate',
                                ['linear'],
                                ['zoom'],
                                15,
                                0,
                                15.05,
                                ['get', 'height']
                            ],
                            'fill-extrusion-base': [
                                'interpolate',
                                ['linear'],
                                ['zoom'],
                                15,
                                0,
                                15.05,
                                ['get', 'min_height']
                            ],
                            'fill-extrusion-opacity': 0.6
                        }
                    },
                    labelLayerId
                );
            });

           // var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
           //     osmAttribution = 'Map data &copy; 2012 <a href="http://openstreetmap.org">OpenStreetMap</a> contributors',
           //     osm = new L.TileLayer(osmUrl, { maxZoom: 18, attribution: osmAttribution });

            //map.setView(new L.LatLng(lat, lng), zoom).addLayer(osm);

            // parameters to ensure the model is georeferenced correctly on the map
            var modelOrigin = [-54.575373, -25.524297];
            var modelAltitude = 100;
            var modelRotate = [Math.PI / 2, 0, 0];

            var modelAsMercatorCoordinate = mapboxgl.MercatorCoordinate.fromLngLat(
                modelOrigin,
                modelAltitude
            );

            // transformation parameters to position, rotate and scale the 3D model onto the map
            var modelTransform = {
                translateX: modelAsMercatorCoordinate.x,
                translateY: modelAsMercatorCoordinate.y,
                translateZ: modelAsMercatorCoordinate.z,
                rotateX: modelRotate[0],
                rotateY: modelRotate[1],
                rotateZ: modelRotate[2],
                /* Since our 3D model is in real world meters, a scale transform needs to be
                * applied since the CustomLayerInterface expects units in MercatorCoordinates.
                */
                scale: modelAsMercatorCoordinate.meterInMercatorCoordinateUnits()
            };

            var THREE = window.THREE;

            // configuration of the custom layer for a 3D model per the CustomLayerInterface
            var customLayer = {
                id: '3d-model',
                type: 'custom',
                renderingMode: '3d',
                onAdd: function (map, gl) {
                    this.camera = new THREE.Camera();
                    this.scene = new THREE.Scene();
           
                    // create two three.js lights to illuminate the model
                    var directionalLight = new THREE.DirectionalLight(0xffffff);
                    directionalLight.position.set(0, 0, 100).normalize();
                    this.scene.add(directionalLight);
                    var directionalLight2 = new THREE.DirectionalLight(0xffffff);
                    directionalLight2.position.set(100, 0, 100).normalize();
                    this.scene.add(directionalLight2);

                    // use the three.js GLTF loader to add the 3D model to the three.js scene
                    var loader = new THREE.GLTFLoader();
                    loader.load(
                        'scene.gltf',
                        function (gltf) {
                            this.scene.add(gltf.scene);
                        }.bind(this)
                    );
                    this.map = map;

                    var mroot = this.scene;
                    var bbox = new THREE.Box3().setFromObject(mroot);
                    var cent = bbox.getCenter(new THREE.Vector3());
                    var size = bbox.getSize(new THREE.Vector3());

                    //Rescale the object to normalized space
                    var maxAxis = Math.max(size.x, size.y, size.z);
                    mroot.scale.multiplyScalar(1.0 / maxAxis);
                    bbox.setFromObject(mroot);
                    bbox.getCenter(cent);
                    bbox.getSize(size);
                    //Reposition to 0,halfY,0
                    mroot.position.copy(cent).multiplyScalar(-1);
                    mroot.position.y -= (size.y * 0.5);

                    // use the Mapbox GL JS map canvas for three.js
                    this.renderer = new THREE.WebGLRenderer({
                        canvas: map.getCanvas(),
                        context: gl,
                        antialias: true
                    });
                   
                    this.renderer.autoClear = false;
                },
                render: function (gl, matrix) {
                    if (this.map.getZoom() < 15)
                        return;

                    var rotationX = new THREE.Matrix4().makeRotationAxis(
                        new THREE.Vector3(1, 0, 0),
                        modelTransform.rotateX
                    );
                    var rotationY = new THREE.Matrix4().makeRotationAxis(
                        new THREE.Vector3(0, 1, 0),
                        modelTransform.rotateY
                    );
                    var rotationZ = new THREE.Matrix4().makeRotationAxis(
                        new THREE.Vector3(0, 0, 1),
                        modelTransform.rotateZ
                    );

                    var m = new THREE.Matrix4().fromArray(matrix / 2);
                    var l = new THREE.Matrix4()
                        .makeTranslation(
                            modelTransform.translateX,
                            modelTransform.translateY,
                            modelTransform.translateZ
                        )
                        .scale(
                            new THREE.Vector3(
                                modelTransform.scale,
                                -modelTransform.scale,
                                modelTransform.scale
                            )
                        )
                        .multiply(rotationX)
                        .multiply(rotationY)
                        .multiply(rotationZ);

                    this.camera.projectionMatrix = m.multiply(l);
                    this.renderer.state.reset();
                    this.renderer.render(this.scene, this.camera);
                    this.map.triggerRepaint();
                }
            };

            map.on('style.load', function () {
                map.addLayer(customLayer, 'waterway-label');
            });

            FilterMap("", "", "", "");
            //map.on('click', onMapClick);

        }

        LoadMap("","",12)

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
            //$("#divLoad").css("display", "block");

            GetDetailsDna(idPonto);
        }



        function FilterMap(consorcio, empresa, idPonto, status) {

            var i = arrMarker.length - 1;
            if (status == undefined) {
                while (arrMarker[i]) {
                    map.removeLayer(arrMarker[i]);
                    arrMarker.pop(i);
                    i--;
                }
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
                            qtdEstacionado++;
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

           /* var iconFalha = L.AwesomeMarkers.icon({ icon: icon, prefix: 'fas', markerColor: cor, iconColor: '#fff' });*/

            if (callStatus == "Filter") {
              /*  for (var i = 0; i < arrMarker.length; i++) {
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
                }*/
            }
            else {

                
                /*// create a HTML element for each feature
                var el = document.createElement('div');
                el.className = 'marker';

                // make a marker for each feature and add to the map
                new mapboxgl.Marker(el)
                    .setLngLat([lng, lat])
                    .addTo(map);*/

               /* marker = new mapboxgl.Marker({
                    draggable: true
                })
                    .setLngLat([lng, lat])
                    .addTo(map);*/

               /* marker = L.marker([lat, lng], {
                    title: siglaFalha, radius: 10, icon: iconFalha, alt: statusPorta
                }).bindLabel(idDna, { noHide: false, offset: [12, -15] }).addTo(map).on('click', onClickMarker);*/
                //arrMarker.push(marker);
            }

        }

//window.onload = load_map;

    </script>
    <script type="text/javascript" src="Scripts/distLeaflet/leaflet.zoomdisplay-src.js"></script>
    <script src="dist-leaflet-markers/leaflet.awesome-markers.js"></script>

     
</asp:Content>
