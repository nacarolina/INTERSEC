<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cronologia.aspx.cs" Inherits="GwCentral.Register.Corredor.Cronologia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Timeline */
        .timeline,
        .timeline-horizontal {
            list-style: none;
            padding: 20px;
            position: relative;
        }

            .timeline:before {
                top: 40px;
                bottom: 0;
                position: absolute;
                content: " ";
                width: 3px;
                background-color: #eeeeee;
                left: 50%;
                margin-left: -1.5px;
            }

            .timeline .timeline-item {
                margin-bottom: 20px;
                position: relative;
            }

                .timeline .timeline-item:before,
                .timeline .timeline-item:after {
                    content: "";
                    display: table;
                }

                .timeline .timeline-item:after {
                    clear: both;
                }

                .timeline .timeline-item .timeline-badge {
                    color: #fff;
                    width: 54px;
                    height: 54px;
                    line-height: 52px;
                    font-size: 22px;
                    text-align: center;
                    position: absolute;
                    top: 18px;
                    left: 50%;
                    margin-left: -25px;
                    background-color: #333;
                    border: 3px solid #ffffff;
                    z-index: 100;
                    border-top-right-radius: 50%;
                    border-top-left-radius: 50%;
                    border-bottom-right-radius: 50%;
                    border-bottom-left-radius: 50%;
                }

                    .timeline .timeline-item .timeline-badge i,
                    .timeline .timeline-item .timeline-badge .fa,
                    .timeline .timeline-item .timeline-badge .glyphicon {
                        top: 2px;
                        left: 0px;
                    }

                    .timeline .timeline-item .timeline-badge.primary {
                        background-color: #1f9eba;
                    }

                    .timeline .timeline-item .timeline-badge.info {
                        background-color: #5bc0de;
                    }

                    .timeline .timeline-item .timeline-badge.success {
                        background-color: #59ba1f;
                    }

                    .timeline .timeline-item .timeline-badge.warning {
                        background-color: #d1bd10;
                    }

                    .timeline .timeline-item .timeline-badge.danger {
                        background-color: #ba1f1f;
                    }

                .timeline .timeline-item .timeline-badge-grupo {
                    background-color: #464953;
                }

                .timeline .timeline-item .timeline-panel {
                    position: relative;
                    width: 46%;
                    float: left;
                    right: 16px;
                    border: 1px solid #777;
                    background: #ffffff;
                    border-radius: 8px;
                    padding: 20px;
                    -webkit-box-shadow: 0 1px 6px rgba(0, 0, 0, 0.175);
                    box-shadow: 0 1px 6px rgba(0, 0, 0, 0.175);
                }

                    .timeline .timeline-item .timeline-panel:before {
                        position: absolute;
                        top: 26px;
                        right: -16px;
                        display: inline-block;
                        border-top: 16px solid transparent;
                        border-left: 16px solid #777;
                        border-right: 0 solid #777;
                        border-bottom: 16px solid transparent;
                        content: " ";
                    }

                    .timeline .timeline-item .timeline-panel .timeline-title {
                        margin-top: 0;
                        color: inherit;
                    }

                    .timeline .timeline-item .timeline-panel .timeline-body > p,
                    .timeline .timeline-item .timeline-panel .timeline-body > ul {
                        margin-bottom: 0;
                    }

                        .timeline .timeline-item .timeline-panel .timeline-body > p + p {
                            margin-top: 5px;
                        }

                .timeline .timeline-item:last-child:nth-child(even) {
                    float: right;
                }

                .timeline .timeline-item:nth-child(even) .timeline-panel {
                    float: right;
                    left: 16px;
                }

                    .timeline .timeline-item:nth-child(even) .timeline-panel:before {
                        border-left-width: 0;
                        border-right-width: 14px;
                        left: -14px;
                        right: auto;
                    }

        .timeline-horizontal {
            list-style: none;
            position: relative;
            padding: 20px 0px 20px 0px;
            display: inline-block;
        }

            .timeline-horizontal:before {
                height: 3px;
                top: auto;
                bottom: 26px;
                left: 56px;
                right: 0;
                width: 100%;
                margin-bottom: 20px;
            }

            .timeline-horizontal .timeline-item {
                display: table-cell;
                height: 280px;
                width: 20%;
                min-width: 320px;
                float: none !important;
                padding-left: 0px;
                padding-right: 20px;
                margin: 0 auto;
                vertical-align: bottom;
            }

                .timeline-horizontal .timeline-item .timeline-panel {
                    top: auto;
                    bottom: 64px;
                    display: inline-block;
                    float: none !important;
                    left: 0 !important;
                    right: 0 !important;
                    width: 100%;
                    margin-bottom: 20px;
                }

                    .timeline-horizontal .timeline-item .timeline-panel:before {
                        top: auto;
                        bottom: -16px;
                        left: 28px !important;
                        right: auto;
                        border-right: 16px solid transparent !important;
                        border-top: 16px solid #777 !important;
                        border-bottom: 0 solid #777 !important;
                        border-left: 16px solid transparent !important;
                    }

                .timeline-horizontal .timeline-item:before,
                .timeline-horizontal .timeline-item:after {
                    display: none;
                }

                .timeline-horizontal .timeline-item .timeline-badge {
                    top: auto;
                    bottom: 0px;
                    left: 43px;
                }
    </style>

    <%--<link href="../../distMarkers/css/map-icons.css" rel="stylesheet" />
    <script src="../../distMarkers/js/map-icons.js"></script>
    <link href="../../assets/icomoon/style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.corredor %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <h4><%= Resources.Resource.corredor %>:
        <select id="sleCorredor" onchange="carregarCronologia()" style="display: inline; width: 76%;" class="form-control"></select>
        <button type="button" class="btn btn-icon btn-secondary mr-1" onclick="Novo()" style="margin-right: 0 !important;"
            data-toggle="tooltip" data-placement="left" title="<%= Resources.Resource.adicionar %> <%= Resources.Resource.novo %> <%= Resources.Resource.corredor %>">
            <i class="ft-plus-square"></i>
        </button>
        <button class="btn btn-info" onclick="Mapa()" id="btnMapa" style="display: inline;"><%= Resources.Resource.mapa %></button>
    </h4>
    <p>
        <i class="ft-clock"></i>
        <%= Resources.Resource.tempoPercurso %>:
        <label id="lblTempoPercurso">--:--</label>
    </p>
    <div class="col-md-12">
        <div style="display: inline-block; width: 100%; overflow-y: auto; padding-top: 36px;">
            <ul class="timeline timeline-horizontal" id="ulCronologia" style="width: 100%; display:none;">
            </ul>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {

            $("#btnMapa").css("display", "none");
            loadResourcesLocales();
            carregarCorredores();
        });
        function carregarCorredores() {
            $.ajax({
                url: 'Cronologia.aspx/carregarCorredores',
                data: "{}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#sleCorredor").empty();
                    $("#sleCorredor").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                    $.each(data.d, function () {
                        $("#sleCorredor").append($("<option data-anel='" + this['Value'] + "'></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        }
        function carregarCronologia() {
            if ($("#sleCorredor").val() == "") {
                $("#btnMapa").css("display", "none");
                $("#lblTempoPercurso")[0].innerText = "--:--";
                $("#ulCronologia").css("display", "none");
            } else {
                $("#btnMapa").css("display", "");
                $("#ulCronologia").css("display", "");
            }

            carregarTempoPercurso();
            callServer("Cronologia.aspx/carregarCronologia", "{'idCorredor':'" + $("#sleCorredor").val() + "'}",
                function (results) {
                    if (results != "") {
                        $("#ulCronologia").empty();
                        $.each(results, function (index, lst) {
                            var posicao = index + 1;
                            var newLI = $("<li class='timeline-item'>");
                            var cols = "<div class='timeline-badge grupo'><label style='color: white;'>" + lst.indice + "</label></div>";
                            cols += "<div class='timeline-panel'>" +
                                "<div class='timeline-heading'>" +
                                "<h4 class='timeline-title'>" + lst.grupo + " - Eqp: " + lst.idEqp;
                            if (lst.indice != "1") {
                                cols += " <button class='btn btn-success btn-sm' data-id='" + lst.idCorredorAnel + "' onclick='salvarGrupoCorredor(this)'>" + getResourceItem("salvar") + "</button>";
                            }
                            cols += "</h4 > " +
                                "<p><small class='text-muted'><i class='la la-map-marker'></i><span>" + lst.Endereco + "</span></small></p>" +
                                "</div >" +
                                "<div class='timeline-body'>" +
                                "<div><b>" + getResourceItem("modelo") + ":</b> <span>" + lst.modelo + "</span><br/><b>" + getResourceItem("tipo") + ":</b> <span>" + lst.tipo + "</span>";

                            if (lst.indice != "1") {
                                var indiceAnterior = parseInt(lst.indice) - 1;
                                cols += "<b style='margin-left:10px'>" + getResourceItem("distancia") + ":</b> <span id='lblDistancia" + lst.idCorredorAnel + "'>" + lst.Distancia + "</span> <br /> <b >Velocidade média:</b>" +
                                    "<input type='number' id='txtVelocidadeMedia" + lst.idCorredorAnel + "' value='" + lst.velocidadeMedia + "' onkeyup='calcularTempo(this)' style='width:30%; display:inline;margin-left: 5px;' class='form-control input-sm' />(km/h)" +
                                    "<br /><b style='margin-top:5px'>Tempo entre o " + indiceAnterior + " e " + lst.indice + ": </b > <input type='text' data-id='" + lst.idCorredorAnel + "' value='" + lst.tempoEntreCruzamentos + "' style='width:27%;margin-top:5px; display:inline;margin-left: 5px;' class='form-control input-sm' id='txtTempoEntreGrupos" + lst.idCorredorAnel + "'/> seg.";
                            }

                            cols += "</div > </div>" +
                                "</div>";
                            newLI.append(cols);
                            $("#ulCronologia").append(newLI);
                        });
                    }
                    else {
                        $("#ulCronologia").empty();
                    }
                });
        }

        function carregarTempoPercurso() {
            callServer("Cronologia.aspx/carregarTempoPercurso", "{'idCorredor':'" + $("#sleCorredor").val() + "'}",
                function (results) {
                    $("#lblTempoPercurso")[0].innerText = results;
                });
        }

        function calcularTempo(txt) {
            var id = txt.id.replace("txtVelocidadeMedia", "");

            if (txt.value == "" || txt.value == "0") {
                $("#txtTempoEntreGrupos" + id).val("0");
                return;
            }
            var d = parseFloat($("#lblDistancia" + id)[0].innerText.replace(",", ".")) * 1000;
            var vel = txt.value * 1000;

            var velMetrosPorSegundo = vel / 3600;

            var tempoEntreGrupos = Math.round(d / velMetrosPorSegundo);

            $("#txtTempoEntreGrupos" + id).val(tempoEntreGrupos);
        }

        function Novo() {
            location.replace("Map.aspx");
            //window.open("Map.aspx");
        }

        function Mapa() {
            location.replace("Map.aspx?idCorredor=" + $("#sleCorredor").val());
        }

        function salvarGrupoCorredor(btn) {
            var idCorredorAnel = btn.dataset.id;
            if ($("#txtVelocidadeMedia" + idCorredorAnel).val() == "" || $("#txtVelocidadeMedia" + idCorredorAnel).val() == "0") {
                Swal.fire({

                    type: 'warning',
                    title: getResourceItem("atencao"),
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                $("#txtVelocidadeMedia" + idCorredorAnel).addClass("is-invalid");
                $("#txtVelocidadeMedia" + idCorredorAnel).focus();
                return;
            }
            $("#txtVelocidadeMedia" + idCorredorAnel).removeClass("is-invalid");
            if ($("#txtTempoEntreGrupos" + idCorredorAnel).val() == "" || $("#txtTempoEntreGrupos" + idCorredorAnel).val() == "0") {
                Swal.fire({

                    type: 'warning',
                    title: getResourceItem("atencao"),
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                $("#txtTempoEntreGrupos" + idCorredorAnel).addClass("is-invalid");
                $("#txtTempoEntreGrupos" + idCorredorAnel).focus();
                return;
            }
            $("#txtTempoEntreGrupos" + idCorredorAnel).removeClass("is-invalid");
            callServer("Cronologia.aspx/salvarGrupoCorredor", "{'idCorredorAnel':'" + idCorredorAnel + "','velocidadeMedia':'" + $("#txtVelocidadeMedia" + idCorredorAnel).val() +
                "','TempoEntreCruzamentos':'" + $("#txtTempoEntreGrupos" + idCorredorAnel).val() + "','idCorredor':'" + $("#sleCorredor").val() + "'}",
                function (results) {
                    carregarTempoPercurso();
                    Swal.fire({

                        type: 'success',
                        title: getResourceItem("sucesso"),
                        text: getResourceItem("salvoComSucesso"),
                    });
                });
        }

        var globalResources;
        function loadResourcesLocales() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: 'Cronologia.aspx/requestResource',
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

    </script>
</asp:Content>
