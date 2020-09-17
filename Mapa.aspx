<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="Mapa.aspx.cs" Inherits="GwCentral.Mapa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title><%= Resources.Resource.mapa %></title>

    <link href='https://api.mapbox.com/mapbox.js/v2.2.3/mapbox.css' rel='stylesheet' />
    <link href="Styles/forms-styles.css" rel="stylesheet" />
    <script src="Scripts/mapbox.js"></script>
    <script src="lightbox2/dist/js/lightbox-plus-jquery.min.js"></script>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <link href="lightbox2/dist/css/lightbox.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/css/bootstrap-datepicker.css" />
    <link href="Styles/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="Styles/menuVertical.css" />
    <script src="assets/sweetalert-dev.js"></script>
    <link href="assets/sweetalert.css" rel="stylesheet" />
    <style type="text/css">
        /* The Modal (background) */
        .modalImg {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.9); /* Black w/ opacity */
        }

        /* Modal Content (image) */
        .modal-content {
            margin: auto;
            display: block;
            width: 80%;
            max-width: 700px;
        }

        /* Caption of Modal Image */
        #caption {
            margin: auto;
            display: block;
            width: 80%;
            max-width: 700px;
            text-align: center;
            color: #ccc;
            padding: 10px 0;
            height: 150px;
        }

        /* Add Animation */
        .modal-content, #caption {
            -webkit-animation-name: zoom;
            -webkit-animation-duration: 0.6s;
            animation-name: zoom;
            animation-duration: 0.6s;
        }

        @-webkit-keyframes zoom {
            from {
                -webkit-transform: scale(0)
            }

            to {
                -webkit-transform: scale(1)
            }
        }

        @keyframes zoom {
            from {
                transform: scale(0)
            }

            to {
                transform: scale(1)
            }
        }

        /* The Close Button */
        .closeImg {
            position: absolute;
            top: 15px;
            right: 35px;
            color: #f1f1f1;
            font-size: 40px;
            font-weight: bold;
            transition: 0.3s;
        }

        .close:hover,
        .close:focus {
            color: #bbb;
            text-decoration: none;
            cursor: pointer;
        }

        /* 100% Image Width on Smaller Screens */
        /*@media only screen and (max-width: 700px) {
            .modal-content {
                width: 100%;
            }
        }*/

        img {
            vertical-align: middle;
        }

        /* Position the image container (needed to position the left and right arrows) */
        .container {
            position: relative;
        }

        /* Hide the images by default */
        .mySlides {
            display: none;
        }

        /* Add a pointer when hovering over the thumbnail images */
        .cursor {
            cursor: pointer;
        }

        /* Next & previous buttons */
        .prev,
        .next {
            background-color: #00000029;
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -50px;
            color: white;
            font-weight: bold;
            font-size: 35px;
            border-radius: 0 3px 3px 0;
            user-select: none;
            -webkit-user-select: none;
        }

        /* Position the "next button" to the right */
        .next {
            right: 15px;
            border-radius: 3px 0 0 3px;
        }

            /* On hover, add a black background color with a little bit see-through */
            .prev:hover,
            .next:hover {
                background-color: rgba(0, 0, 0, 0.8);
                color: white;
            }

        /* Number text (1/3 etc) */
        .numbertext {
            color: #f2f2f2;
            font-size: 12px;
            padding: 8px 12px;
            position: absolute;
            top: 0;
        }

        /* Container for image text */
        .caption-container {
            text-align: center;
            background-color: #222;
            padding: 2px 16px;
            color: white;
        }

        .row:after {
            content: "";
            display: table;
            clear: both;
        }

        /* Six columns side by side */
        .column {
            float: left;
            width: 16.66%;
        }

        /* Add a transparency effect for thumnbail images */
        .demo {
            opacity: 0.6;
        }

            .active,
            .demo:hover {
                opacity: 1;
            }

        #divDetalhesDna p:hover {
            background-color: #eee;
        }

        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            overflow-x: hidden;
            width: 300px;
            background-color: #ffffff;
            cursor: pointer;
        }

        .valida {
            border-color: red;
        }

        @media screen and (max-height: 900px) {
            #divAvisoContent, #divOptions, #popupProblemas, #modalTarefasPendentes {
                height: 800px;
            }
        }

        @media screen and (max-height: 768px) {
            #divAvisoContent, #divOptions, #popupProblemas, #modalTarefasPendentes {
                height: 600px;
            }
        }

        @media screen and (min-height: 1050px) {
            #divAvisoContent, #divOptions, #popupProblemas, #modalTarefasPendentes {
                height: 950px;
            }
        }

        .loading {
            position: absolute;
            background: #fff;
            width: 150px;
            height: 150px;
            border-radius: 100%;
            border: 10px solid #5cb85c;
            z-index: 10;
            padding-top: 52px;
            font-size: large;
            color: #5cb85c;
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
                box-shadow: #5cb85c -4px -5px 3px -3px;
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

        .popover {
            width: 450px !important;
            max-width: 500px !important;
        }
    </style>

    <link href="Register/Areas/treeView.css" rel="stylesheet" />
    <link href="assets/icomoon/style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link rel="stylesheet" href="dist-leaflet-markers/leaflet.awesome-markers.css" />
    <link href="Styles/sideBar.css" rel="stylesheet" />
    <script src="Scripts/sideBar.js"></script>
</asp:Content>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
    </section>
    <br />
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div id="divLoading" style="display: none;">
        <div style="z-index: 9999; background-color: rgba(0,0,0,.4); position: fixed; width: 100%; height: 100%; transition: background-color .1s; top: 0;">
            <div style="background-color: #fff; width: 300px; height: 320px; text-align: center; z-index: 10; padding-left: 75px; padding-top: 30px; border-radius: 10px; position: absolute; margin: auto; top: 0; right: 0; bottom: 0; left: 0;">
                <div class="loading"><%= Resources.Resource.aguarde %> ...</div>
                <div style="font-size: large; color: #5cb85c; font-size: x-large; color: #5cb85c; margin-top: 192px; margin-left: -60px;">
                    <img src="../Images/logoGW.png" />
                </div>
            </div>
        </div>
    </div>
    <script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-label/v0.2.1/leaflet.label.js'></script>
    <link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-label/v0.2.1/leaflet.label.css' rel='stylesheet' />

    <div id="pnlMap" runat="server" visible="false">
        <div id="map" style="position: absolute; top: 45px; left: 0px; width: 100%; height: 100%;"></div>
        <asp:HiddenField ID="hfTemEqp" runat="server" ClientIDMode="Static" />
        <input type="hidden" id="hfIdPonto" />
        <asp:HiddenField ID="hfResetaControlador" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hfIdPrefeitura" runat="server" ClientIDMode="Static"></asp:HiddenField>
        <input id="hfUserPermReset" type="hidden" />

        <div id="popupResetUser" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">
                            <img src="Images/warning-128.png" style="width: 42px; height: 42px;" alt="" /><%= Resources.Resource.permissaoParaReset %></h4>
                    </div>
                    <div class="modal-body">
                        <p style="color: blue;"><%= Resources.Resource.infoUserPermissaoReset %></p>
                        <p id="infoUserReset" style="display: none;"><b style="color: red;"><%= Resources.Resource.infoUserInvalido %></b></p>
                        <p>
                            <%= Resources.Resource.usuario %>:
                            <input id="txtUserReset" type="text" placeholder="<%= Resources.Resource.usuario %>..." class="form-control" style="width: 200px; display: inline;" />
                        </p>
                        <p>
                            <%= Resources.Resource.senha %>:
                            <input id="txtSenhaUserReset" type="password" placeholder="<%= Resources.Resource.senha %>..." class="form-control" style="width: 150px; display: inline; margin-left: 8px;" />
                        </p>
                    </div>
                    <div class="modal-footer">
                        <input id="btnConfirmUser" value="<%= Resources.Resource.confirmar %>" style="width: 100px;" class="btn btn-default" onclick="verificaUserReset();" />
                        <button type="button" class="btn btn-default" data-dismiss="modal"><%= Resources.Resource.cancelar %></button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="divPopupMarker" role="dialog" style="font-family: Arial; font-size: 0.9em;">
            <div class="modal-dialog" style="width: 900px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%= Resources.Resource.controlador %></h4>
                    </div>
                    <div class="modal-body">
                        <div id="divDetalhesDna">
                            <table class="table table-bordered" style="margin-top: -10px;">
                                <tr>
                                    <td colspan="2">
                                        <span id="lblIdPonto"></span>- <span id="lblCruzamento"></span>
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
                                        <button type="button" id="btnMonitoramento" class="btn btn-primary" onclick="AbrirMonitoramento('');">
                                            <img src="../Images/TempoReal.png" />
                                            <%= Resources.Resource.abrirMonitoramento %></button>

                                        <button type="button" class="btn btn-primary" onclick="VerAgenda();">
                                            <img src="Images/if_document-08_1622828 (1).png" />
                                            <%= Resources.Resource.verAgenda %></button>
                                        <button type="button" class="btn btn-info" onclick="VerPlanos();">
                                            <img src="Images/analytics_bar_chart32.png" />
                                            <%= Resources.Resource.verPlanos %></button>

                                        <button type="button" class="btn btn-danger" onclick="Logs()">
                                            <img src="Images/lists.png" style="width: 32px;" />
                                            <%= Resources.Resource.logs %></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <button type="button" id="btnCroqui" class="btn btn-warning" onclick="Croqui()">
                                            <img src="Images/iconfinder_folder-project_287298.png" style="width: 32px;" />
                                            <%= Resources.Resource.croqui %></button></td>
                                </tr>
                            </table>
                            <hr style="border-bottom: 1px solid #d8d8d8;" />

                            <ul class="nav nav-tabs">
                                <li class="active"><a data-toggle="tab" href="#divListaGrupos"><%= Resources.Resource.gruposSemaforicos %></a></li>
                                <li><a data-toggle="tab" href="#divLogsCentral">Logs <%= Resources.Resource.controlador %> </a></li>
                                <li><a data-toggle="tab" href="#HistReset">Status Reset</a></li>
                            </ul>

                            <div class="tab-content">
                                <div id="divListaGrupos" class="tab-pane fade in active">
                                    <table style="margin-top: 10px;" class="table table-bordered table-striped table-hover">
                                        <caption><%= Resources.Resource.listaGrupoSemaforico %></caption>
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
                                <div id="divLogsCentral" class="tab-pane fade">
                                    <div style="overflow: auto; height: 250px;">
                                        <table id="tblLogsCentral" style="margin-top: 10px; height: 250px;" class="table table-bordered table-striped table-hover">
                                            <caption><%= Resources.Resource.lista %> Logs - <%= Resources.Resource.controlador %></caption>
                                            <thead>
                                                <tr>
                                                    <%--<th><%= Resources.Resource.tipo %></th>--%>
                                                    <th><%= Resources.Resource.falhas %></th>
                                                    <th><%= Resources.Resource.usuario %></th>
                                                    <th><%= Resources.Resource.data %>/<%= Resources.Resource.hora %></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbLogsCentral"></tbody>
                                        </table>
                                    </div>
                                </div>
                                <div id="HistReset" class="tab-pane fade" style="margin-top: 15px; width: 95%;">
                                    <p>
                                        <input type="button" id="btnResetarControl" style="height: 24px; padding-top: 1px;" onclick="ResetarControlador();" class="btn btn-default" value="Resetar Controlador" />
                                    </p>
                                    <p id="pHistReset" style="display: none;">
                                        <b style="color: #ff0000">Não há histórico de Reset para este controlador!</b>
                                    </p>
                                    <p id="pReseteControlador" style="border-bottom: 1px solid #cccccc; display: none;">
                                        <span id="spaReseteControlador"></span>
                                    </p>
                                    <div id="HistoricoReset" style="display: none; height: 200px; overflow-y: scroll;">
                                        <table id="tbHistoricoReset" class="table table-bordered table-striped table-hover;">
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
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
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
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%= Resources.Resource.atencao %></h4>
                </div>
                <div class="modal-body">
                    <p><%= Resources.Resource.idPonto %>: <span id="spaIdPontoConfirmResete"></span></p>
                    <p><%= Resources.Resource.desejaRestarEqp %></p>
                </div>
                <div class="modal-footer">
                    <button type="button" onclick="HabilitarReseteControl();" class="btn btn-default"><%= Resources.Resource.sim %></button>
                    <button type="button" class="btn btn-default" onclick="NoReseteControl();"><%= Resources.Resource.nao %></button>
                </div>
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hfIdEqp" ClientIDMode="Static" runat="server" />

    <div id="popupSemComunicacao" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%= Resources.Resource.atencao %></h4>
                </div>
                <div class="modal-body">
                    <p><%= Resources.Resource.idPonto %>: <span id="spaIdPontoSemComu"></span></p>
                    <p><%= Resources.Resource.desejaSetarSCEqp %></p>
                </div>
                <div class="modal-footer">
                    <button type="button" onclick="HabilitarSemComunicacao();" class="btn btn-default"><%= Resources.Resource.sim %></button>
                    <button type="button" class="btn btn-default" onclick="NoSemComuni();"><%= Resources.Resource.nao %></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="popupHistoricoFalhas" role="dialog" style="font-size: 0.8em;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button id="btnClosePopupFalhas" type="button" class="close" onclick="ClosePopupFalhas();">&times;</button>
                    <h4 class="modal-title"><%= Resources.Resource.historicoFalhas %></h4>
                </div>
                <div class="modal-body">
                    <div id="DetalhesPopupHistoricoFalhas">
                        <div id="divHistoricoFalhas">
                            <div id="divPesquisaFalhaControl" style="border: 1px solid #cccccc; -moz-border-radius: 10px; -webkit-border-radius: 10px; border-radius: 10px;">
                                <table style="margin-left: 10px; height: 100px;">
                                    <caption style="text-align: left; color: #cccccc;"><b><%= Resources.Resource.pesquisar %></b></caption>
                                    <tr>
                                        <td style="width: 110px;"><b><%= Resources.Resource.dataInicial %>:</b></td>
                                        <td>
                                            <input id="txtDataIni" type="text" class="form-control datepicker" placeholder="<%= Resources.Resource.dataInicial %>" /></td>
                                    </tr>
                                    <tr>
                                        <td><b><%= Resources.Resource.dataFinal %>:</b></td>
                                        <td style="width: 220px;">
                                            <input id="txtDataFinal" type="text" class="form-control datepicker" placeholder="<%= Resources.Resource.dataFinal %>" /></td>
                                        <td>
                                            <img id="imgPesquisarHistoFalhasControl" src="Images/search.png" alt="<%= Resources.Resource.pesquisar %>" style="cursor: pointer; width: 24px; height: 24px;" onclick="PesquisarFalhaControl();" /></td>
                                    </tr>
                                </table>
                            </div>
                            <p style="margin-top: 5px;">
                                <input type="button" value="Excel" style="height: 30px;" class="btn btn-default" id="btnExcelHistoFalha" />
                                <input id="btnVoltarDetalhesPonto" style="height: 30px;" type="button" value="<%= Resources.Resource.voltar %>" onclick="VoltarDetalhesPonto();" class="btn btn-default" />
                            </p>
                            <div id="divListaFalhaControl" style="margin-top: 10px; padding: 5px; border: 1px solid #cccccc; -moz-border-radius: 10px; -webkit-border-radius: 10px; border-radius: 10px; width: 100%; height: 200px;">
                                <div id="scrollHistoFalhas" style="overflow-x: hidden; overflow-y: scroll; height: 190px; width: 95%;">
                                    <table id="tblHistoricoFalhas" class="table table-bordered table-striped table-hover" style="width: 95%; margin-left: 10px; margin-top: 10px;">
                                        <caption style="text-align: left;">
                                            <b><%= Resources.Resource.historicoFalhas %></b> - <b><%= Resources.Resource.idPonto %>: </b>
                                            <span id="spaIdPontoFalha"></span>
                                        </caption>
                                        <thead style="margin-top: 5px;">
                                            <tr>
                                                <th><%= Resources.Resource.falhas %></th>
                                                <th><%= Resources.Resource.porta %></th>
                                                <th><%= Resources.Resource.data %></th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbHistoricoFalhas"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <span id="spaAlertaHistoricoFalhas" style="display: none; color: red;"><%= Resources.Resource.naoTemHistoricoFalhaEqp %></span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="ClosePopupFalhas();"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="popupHistoricoComunicacao" role="dialog" style="font-size: 0.8em;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button id="btnClosePopupComunicacao" type="button" class="close" onclick="ClosePopupComunicacao();">&times;</button>
                    <h4 class="modal-title"><%= Resources.Resource.historicoComunicacao %></h4>
                </div>
                <div class="modal-body">
                    <div id="DetalhesPopupHistoricoComunicacao">
                        <div id="divHistoricoComunicacao">
                            <div id="divPesquisaHistoricoComunicacao" style="border: 1px solid #cccccc; -moz-border-radius: 10px; -webkit-border-radius: 10px; border-radius: 10px;">
                                <table style="margin-left: 10px; height: 100px;">
                                    <caption style="text-align: left; color: #cccccc;"><b><%= Resources.Resource.pesquisar %></b></caption>
                                    <tr>
                                        <td><b><%= Resources.Resource.data %>:</b></td>
                                        <td style="width: 220px;">
                                            <input id="txtDtHistoComunicacao" type="text" class="form-control datepicker" placeholder="<%= Resources.Resource.data %>" /></td>
                                        <td>
                                            <img id="imgPesquisarHistoComunicacao" src="Images/search.png" alt="<%= Resources.Resource.pesquisar %>" style="cursor: pointer; width: 24px; height: 24px;" onclick="getHistoricoComunicacao('Pesq');" /></td>
                                    </tr>
                                </table>
                            </div>

                            <div id="divListaComunicacao" style="margin-top: 10px; padding: 5px; border: 1px solid #cccccc; -moz-border-radius: 10px; -webkit-border-radius: 10px; border-radius: 10px; width: 100%; height: 200px;">
                                <div id="scrollHistoComunicacao" style="overflow-x: hidden; overflow-y: scroll; height: 190px; width: 95%;">
                                    <table id="tblHistoricoComunicacao" class="table table-bordered table-striped table-hover" style="width: 95%; margin-left: 10px; margin-top: 10px;">
                                        <caption style="text-align: left;">
                                            <b><%= Resources.Resource.historicoComunicacao %></b> - <b><%= Resources.Resource.idPonto %>: </b>
                                            <span id="spaIdPontoComunicacao"></span>
                                            <br />
                                            <b><%= Resources.Resource.falhasNaComunicacao %>: </b><span id="spnQtdFalhasComunicacao"></span>
                                        </caption>
                                        <thead style="margin-top: 5px;">
                                            <tr>
                                                <th><%= Resources.Resource.ultimaComunicacao %></th>
                                                <th><%= Resources.Resource.tentativaConexao %></th>
                                                <th><%= Resources.Resource.tempoSemComunicar %></th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbHistoricoComunicacao"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <span id="spaAlertaHistoricoComunicacao" style="display: none; color: red;"><%= Resources.Resource.naoTemHistoricoComunicacaoEqp %></span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="ClosePopupComunicacao();"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>

    <div id="popupManutencao" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">
                        <img src="Images/ordemServi%c3%a7o.png" style="width: 36px; height: 36px;" />
                        <%= Resources.Resource.abrirOrdemServico %></h4>
                </div>
                <div class="modal-body">
                    <p style="border-bottom: 1px solid #D8D8D8;">
                        <b><%= Resources.Resource.idPonto %>:</b> <span id="spaIdPontoManutencao"></span>
                    </p>
                    <table>
                        <tr style="height: 60px;">
                            <td style="width: 100px;"><b><%= Resources.Resource.falhas %>:</b></td>
                            <td style="width: 220px;">
                                <select id="sleFalha" style="width: 250px;" data-toggle="falha" data-placement="right" title="<%= Resources.Resource.selecioneFalha %>" class="form-control">
                                    <option value="0"><%= Resources.Resource.selecione %>...</option>
                                    <option value="520"><%= Resources.Resource.falhaDeNobreak %></option>
                                    <option value="553"><%= Resources.Resource.moduloDeComunicacao %></option>
                                    <option value="561"><%= Resources.Resource.semaforoApagado %></option>
                                    <option value="563"><%= Resources.Resource.semaforoEstacionado %></option>
                                    <option value="565"><%= Resources.Resource.semaforoAmareloIntermitente %></option>
                                    <option value="586"><%= Resources.Resource.controladorAberto %></option>
                                </select>
                            </td>
                        </tr>
                    </table>
                    <p style="margin-top: 15px;">
                        <b><%= Resources.Resource.complemento %>:</b>
                        <textarea id="txtComplemento" style="width: 500px;" placeholder="<%= Resources.Resource.complemento %>" class="form-control" rows="5"></textarea>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="confirmOs();"><%= Resources.Resource.confirmar %></button>
                    <input id="btnVoltarManutencao" type="text" value="<%= Resources.Resource.voltar %>" style="width: 100px;" data-voltar="" onclick="VoltarManutencao();" class="btn btn-default" />
                    <button type="button" class="btn btn-default" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>

    <div class="page-wrapper chiller-theme toggled">
        <a id="show-sidebar" class="btn btn-sm btn-dark" href="#">
            <i class="fas fa-bars" style="padding-top: 3px;"></i>
        </a>
        <nav id="sidebar" class="sidebar-wrapper">
            <div class="sidebar-content">
                <div class="sidebar-brand">
                    <a href="#"><%= Resources.Resource.opcoes %></a>
                    <div id="close-sidebar">
                        <i class="fas fa-times"></i>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul>
                        <li class="sidebar-dropdown" style="border-bottom: 1px solid #2b2b2b;">
                            <a href="#">
                                <i class="fas fa-search-location"></i>
                                <span><%= Resources.Resource.buscarControlador %></span>
                            </a>
                            <div class="sidebar-submenu inner bg-light lter">
                                <p style="padding-left: 15px; padding-top: 10px;"><%= Resources.Resource.identificacao %></p>
                                <div class="input-group" style="padding-left: 15px;">
                                    <asp:TextBox ID="txtIdPonto" ClientIDMode="Static" runat="server" CssClass="form-control"></asp:TextBox>
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-primary" onclick="verificaPesquisaMap('');"><i class="fas fa-search"></i></button>
                                    </span>
                                </div>
                                <p style="padding-left: 15px; padding-top: 5px;"><%= Resources.Resource.endereco %></p>
                                <div class="input-group" style="padding-left: 15px;">
                                    <input type="text" id="txtCruzamento" class="form-control" />
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-primary" onclick="verificaPesquisaMap('');"><i class="fas fa-search-location"></i></button>
                                    </span>
                                </div>
                                <br />
                            </div>
                        </li>
                        <li class="sidebar-dropdown" style="border-bottom: 1px solid #2b2b2b;">
                            <a href="#">
                                <i class="fas fa-fw fa-map-marked-alt"></i>
                                <span><%= Resources.Resource.areaSubArea %></span>
                            </a>
                            <div class="sidebar-submenu inner bg-light lter">
                                <ul id="treeArea"></ul>
                            </div>
                        </li>
                        <li class="sidebar-dropdown" style="border-bottom: 1px solid #2b2b2b;">
                            <a href="#">
                                <i class="fas fa-chart-bar"></i>
                                <span><%= Resources.Resource.estatisticaStatusControlador %></span>
                            </a>
                            <div class="sidebar-submenu inner bg-light lter">
                                <div class="material-switch pull-left" style="margin-top: 10px; margin-bottom: 10px;">
                                    <small class="text-muted"><%= Resources.Resource.filtrarPorEstatistica %>:</small>
                                    <input id="ckdmodoEstatisticaCtrl" type="checkbox" onclick="filterAllMapCtrl('init');" />
                                    <label for="ckdmodoEstatisticaCtrl" class="label-primary"></label>
                                </div>
                                <br />
                                <table id="tblEstatisticaFalhas" style="font-size: 12px;" class="table table-bordered table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>Status</th>
                                            <th><%= Resources.Resource.falhas %></th>
                                            <th><%= Resources.Resource.total %></th>
                                            <th>%</th>
                                            <th>#</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="awesome-marker-icon-green awesome-marker" style="width: 35px; height: 45px; position: unset !important;"><i style="color: #fff; font-size: 15px;" class="fas fa-traffic-light"></i></div>
                                            </td>
                                            <td><%= Resources.Resource.normal %></td>
                                            <td>
                                                <span id="spaQtdNormalControl">0</span>
                                            </td>
                                            <td>
                                                <span id="spaTotalNormal">0%</span>
                                            </td>
                                            <td>
                                                <input id="chkFilterNormMapCtrl" type="checkbox" disabled="disabled" onclick="filterAllMapCtrl();" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="awesome-marker-icon-red awesome-marker" style="width: 35px; height: 45px; position: unset !important;"><i style="color: #fff; font-size: 15px;" class="fas fa-traffic-light"></i></div>
                                            </td>
                                            <td><%= Resources.Resource.falhas %></td>
                                            <td>
                                                <span id="spaQtdFalhaControl">0</span>
                                            </td>
                                            <td>
                                                <span id="spaTotalFalha">0%</span>
                                            </td>
                                            <td>
                                                <input id="chkFilterFalhaMapCtrl" disabled="disabled" type="checkbox" onclick="filterAllMapCtrl();" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="awesome-marker-icon-gray awesome-marker" style="width: 35px; height: 45px; position: unset !important;"><i style="color: #fff; font-size: 15px;" class="fas fa-traffic-light"></i></div>
                                            </td>
                                            <td><%= Resources.Resource.falhasNaComunicacao %></td>
                                            <td>
                                                <span id="spaQtdFalhaComuControl">0</span>
                                            </td>
                                            <td>
                                                <span id="spaTotalFalhaComunicacao">0%</span>
                                            </td>
                                            <td>
                                                <input id="chkFilterFcMapCtrl" type="checkbox" disabled="disabled" onclick="filterAllMapCtrl();" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="awesome-marker-icon-blue awesome-marker" style="width: 35px; height: 45px; position: unset !important;"><i style="color: #fff; font-size: 15px;" class="fas fa-plug"></i></div>
                                            </td>
                                            <td>Plug</td>
                                            <td>
                                                <span id="spaQtdPlugManual">0</span>
                                            </td>
                                            <td>
                                                <span id="spaTotalPlugManual">0%</span>
                                            </td>
                                            <td>
                                                <input id="chkFilterPlugManual" disabled="disabled" type="checkbox" onclick="filterAllMapCtrl();" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="awesome-marker-icon-orange awesome-marker" style="width: 35px; height: 45px; position: unset !important;"><i style="color: #fff; font-size: 15px;" class="fas fa-download"></i></div>
                                            </td>
                                            <td><%= Resources.Resource.imposicaoPlano %></td>
                                            <td>
                                                <span id="spaQtdImposicao">0</span>
                                            </td>
                                            <td>
                                                <span id="spaTotalImposicao">0%</span>
                                            </td>
                                            <td>
                                                <input id="chkFilterImposicao" disabled="disabled" type="checkbox" onclick="filterAllMapCtrl();" />
                                            </td>
                                        </tr>
										<tr>
											<td></td>
											<td>
												<%= Resources.Resource.portaAberta %>
											</td>
                                            <td>
                                                <span id="spaQtdPorta">0</span>
                                            </td>
                                            <td>
                                                <span id="spaTotalPorta">0%</span>
                                            </td>
                                            <td>
                                                <input id="chkFilterPorta" disabled="disabled" type="checkbox" onclick="filterAllMapCtrl();" />
                                            </td>
										</tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="5"><%= Resources.Resource.total %>:<span id="spaQtdTotalControl">0</span></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="sidebar-footer">
                <a href="#" style="margin-left: -48px;" onclick="getAvisosCtrl()">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span style="background-color: red; color: white; font-size: x-small" onclick="getAvisosCtrl()" title="<%= Resources.Resource.alarmeFalha %>" class="badge badge-pill badge-warning notification"><%= Resources.Resource.alarmes %></span>
                </a>
                <a href="#" style="margin-left: -35px;" onclick="getLacosFalha()">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span style="background-color: #9f0404; color: white; font-size: x-small" onclick="getLacosFalha()" title="<%= Resources.Resource.lacosEmFalha %>" class="badge badge-pill badge-warning notification"><%= Resources.Resource.lacosEmFalha %></span>
                </a>
                <a id="chkLabelMarker" data-checked="false" style="margin-left: 3px;" href="#">
                    <i class="fa fa-bookmark"></i>
                    <span style="background-color: green; color: white; font-size: x-small" class="badge badge-pill badge-warning notification">Id.</span>
                </a>
                <a href="#" style="margin-left: -65px;">
                    <i class="fa fa-clock"></i>
                    <span id="spaDtAtualizacaoMapa" title="<%= Resources.Resource.ultimaAtualizacao %>" style="background-color: blue; color: white; font-size: x-small" class="badge badge-pill badge-warning notification"></span>
                </a>
            </div>
        </nav>
    </div>

    <div style="position: absolute; right: 0.5%; top: 18%;">
        <span style="background-color: black; color: white; font-size: 9px; right: 85%; margin-top: -4px; position: absolute;" class="badge badge-pill badge-warning notification"><%= Resources.Resource.tarefas %></span>
        <button type="button" class="btn btn-sm btn-danger" onclick="initTarefasPendentes();"><i class="fas fa-bell"></i></button>
    </div>

    <div id="modalVinculoSubArea" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">
                        <img src="Images/subArea.png" alt="" />
                        <%= Resources.Resource.vinculoSubArea %></h4>
                </div>
                <div class="modal-body">
                    <table>
                        <tr>
                            <td>
                                <button id="btnPendencias" type="button" class="btn btn-danger" data-tipo="subArea" data-placement="bottom" data-toggle="popover" onclick="getPendencias(this)"><%= Resources.Resource.sincronizacoesPendentes %></button></td>
                            <td style="padding-left: 10px;">
                                <button id="btnImposicaoPlanos" type="button" data-tipo="subArea" class="btn btn-primary" data-placement="bottom" data-toggle="popover" onclick="getPlanoSubArea(this)"><%= Resources.Resource.imposicaoPlano %></button></td>
                        </tr>
                    </table>

                    <hr />

                    <div id="divAneisVinculados" style="width: 100%; border: 1px solid rgb(212, 212, 212); overflow: auto; height: 250px;">
                        <div style="border-bottom: 1px solid #d4d4d4;">
                            <p style="margin: 10px">
                                <span class="glyphicon glyphicon-list-alt" style="padding-right: 10px;"></span>- <%= Resources.Resource.listaAneisVinculados %> - <%= Resources.Resource.subArea %>:
                                    <label id="lblSubArea"></label>
                            </p>
                        </div>
                        <div class="panel-body">
                            <table id="tblVinculoSubArea" class="table table-bordered" style="font-size: 11px;">
                                <thead>
                                    <tr>
                                        <th><%= Resources.Resource.cruzamento %></th>
                                        <th><%= Resources.Resource.controlador %> / <%= Resources.Resource.anel %> </th>
                                        <th><%= Resources.Resource.modoOperacional %></th>
                                        <th><%= Resources.Resource.abrirMonitoramento %></th>
                                    </tr>
                                </thead>
                                <tbody id="tbVinculoSubArea"></tbody>
                                <tfoot id="tfVinculoSubArea" style="display: none;">
                                    <tr>
                                        <td colspan="4">* <%= Resources.Resource.naoHaRegistros %></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalCorredorSubArea" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">
                        <img src="Images/subArea.png" alt="" />
                        <%= Resources.Resource.corredor %> <%= Resources.Resource.subArea %></h4>
                </div>
                <div class="modal-body">
                    <p style="border-bottom: 1px solid #d4d4d4;">
                        <%= Resources.Resource.subArea %>:
                            <label id="lblSubAreaCorredor"></label>
                    </p>

                    <small class="text-muted">* <%= Resources.Resource.opcoes %> <%= Resources.Resource.subArea %></small>

                    <table>
                        <tr>
                            <td>
                                <button id="btnPendenciasCorredor" type="button" class="btn btn-danger" data-tipo="corredor" data-placement="bottom" data-toggle="popover" onclick="getPendencias(this)"><%= Resources.Resource.sincronizacoesPendentes %></button></td>
                            <td style="padding-left: 10px;">
                                <button id="btnImposicaoPlanoCorredor" type="button" data-tipo="corredor" title="Imposição Planos" class="btn btn-primary" data-placement="bottom" data-toggle="popover" onclick="getPlanoSubArea(this)"><%= Resources.Resource.imposicaoPlano %></button></td>
                        </tr>
                    </table>

                    <hr />

                    <small class="text-muted">* <%= Resources.Resource.corredor %> <%= Resources.Resource.subArea %></small>
                    <div id="divCorredorSubArea" class="list-group"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" onclick="LimparCorredor()"><%= Resources.Resource.limpar %> <%= Resources.Resource.corredor %></button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>

    <%--    <div id="mpAvisos" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="height: 50px;">
                    <button type="button" class="close" onclick="closeAviso();">&times;</button>
                    <h5><%= Resources.Resource.alarmes %> </h5>
                </div>
                <div class="modal-body">
                    <div id="" style="border-bottom: 1px solid #cccccc;">
                        <div id="" style="border-bottom: 1px solid #cccccc; background-color: #eee; border-bottom: 1px; font-size: small">
                            <table class="table table-bordered">
                                <tr>
                                    <td>
                                        <%= Resources.Resource.dataInicial %>:
                                        <input type="text" class="form-control" id="txtDtInicialAvisos" maxlength="10" onblur="ValidaData(this)" onkeypress="Data(event,this)" />
                                    </td>
                                    <td>
                                        <%= Resources.Resource.dataFinal %>:
                                        <input type="text" class="form-control" id="txtDtFinalAvisos"maxlength="10" onblur="ValidaData(this)" onkeypress="Data(event,this)"  />
                                    </td>
                                    <td>
                                        <input type="button" id="btnFiltrarAvisos" class="btn btn-primary" style="margin-top:18px" onclick="FiltraAvisos(this.value,'periodo')" value="<%= Resources.Resource.pesquisar %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">Id Eqp:
                                     <input id="txtIdEqp" type="text" onkeyup="FiltraAvisos(this.value,'ideqp')" class="form-control" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3"><%= Resources.Resource.falhas %>:
                                         <input id="txtFalha" type="text" onkeyup="FiltraAvisos(this.value,'falha')" class="form-control" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div id="divAvisos" style="height: 310px; overflow-y: scroll; margin-top: 10px;">
                        <table id="tblAvisosControlador" class="table table-bordered table-striped table-hover" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th>Id Eqp.</th>
                                    <th><%= Resources.Resource.falhas %></th>
                                    <th><%= Resources.Resource.data %> - <%= Resources.Resource.falhas %></th>
                                </tr>
                            </thead>
                            <tbody id="tbAvisos"></tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeAviso();"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>--%>

    <div id="modalImposicaoPlano" class="modal fade" role="dialog">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">
                        <span class="glyphicon glyphicon-list-alt"></span>
                        <%= Resources.Resource.imposicaoPlano %></h4>
                </div>
                <div class="modal-body">
                    <p style="border-bottom: 1px solid #d4d4d4;">
                        <%= Resources.Resource.subArea %>:
                            <label id="lblSubAreaImposicao"></label>
                    </p>
                    <hr />

                    <%= Resources.Resource.minutos %> <%= Resources.Resource.imposicao %>:
                        <p style="border-bottom: 1px solid #d4d4d4; height: 40px;">
                            <input id="txtTempoImposicao" type="number" class="form-control" value="1" min="1" />
                        </p>
                    <br />
                    <p><small class="text-muted"><%= Resources.Resource.planos %> <%= Resources.Resource.imposicao %></small></p>

                    <div style="height: 200px; overflow: auto;">
                        <table id="tblPlanos" class="table table-bordered table-striped table-hover" style="font-size: 11px;">
                            <thead>
                                <tr>
                                    <th><%= Resources.Resource.planos %></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="tbPlanos"></tbody>
                            <tfoot id="tfPlanos">
                                <tr>
                                    <td colspan="2"><%= Resources.Resource.naoHaRegistros %></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="popupProblemas" role="dialog" style="width: 430px; top: 30px; overflow-y: hidden; font-size: 0.7em;">
        <div class="modal-dialog" style="float: left; width: 430px; overflow-y: hidden; height: auto;">
            <div class="modal-content">
                <div class="modal-header" style="height: 50px;">
                    <button type="button" class="close" onclick="closeProblemas();">&times;</button>
                    <h4><%= Resources.Resource.diagnosticoCampo %></h4>
                </div>
                <div class="modal-body">
                    <div id="divPesquisar" style="border-bottom: 1px solid #cccccc;">
                        <img id="imgFilterProblem" style="width: 20px; height: 20px; cursor: pointer;" src="Images/minus.png" onclick="openFilters('#divFiltersProblems');" />&nbsp;<b><%= Resources.Resource.pesquisar %></b>
                        <div id="divFiltersProblems" style="border-bottom: 1px solid #cccccc; display: none; background-color: #eee; border-bottom: 1px;">
                            <ul style="list-style: none; margin-left: -30px; margin-top: 1px;">
                                <li style="display: inline-block; padding: 5px;">
                                    <input id="chkNormalProblem" type="checkbox" onclick="FiltraProblemas('filtro');" /><%= Resources.Resource.normal %>
                                </li>
                                <li style="display: inline-block; padding: 5px;">
                                    <input id="chkFaltaEnergiProblem" type="checkbox" onclick="FiltraProblemas('filtro');" /><%= Resources.Resource.faltaEnergia %>
                                </li>
                                <li style="display: inline-block; padding: 5px;">
                                    <input id="chkSubtencaoProblem" type="checkbox" onclick="FiltraProblemas('filtro');" /><%= Resources.Resource.subtensao %>
                                </li>
                                <li style="display: inline-block; padding: 5px;">
                                    <input id="chkDesligadoProblem" type="checkbox" onclick="FiltraProblemas('filtro');" /><%= Resources.Resource.apagado %>/<%= Resources.Resource.desligado %>
                                </li>
                                <li style="display: inline-table; padding: 5px;">
                                    <input id="chkAmareloInterProblem" type="checkbox" onclick="FiltraProblemas('filtro');" /><%= Resources.Resource.semaforoAmareloIntermitente %>
                                </li>
                                <li style="display: inline-block; padding: 5px;">
                                    <input id="chkEstaProblem" type="checkbox" onclick="FiltraProblemas('filtro');" /><%= Resources.Resource.semaforoEstacionado %>
                                </li>
                                <li style="display: inline-block; padding: 5px;">
                                    <input id="chkFalhaComuProblem" type="checkbox" onclick="FiltraProblemas('filtro');" /><%= Resources.Resource.falhasNaComunicacao %>
                                </li>
                                <li style="display: inline-block; padding: 5px;">
                                    <input id="chkSemComuProblem" type="checkbox" onclick="FiltraProblemas('filtro');" /><%= Resources.Resource.semComunicacao %>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div id="divProblemas" style="height: 200px; overflow-y: scroll; margin-top: 10px;">
                        <table id="tblProblemas" class="table table-bordered table-striped table-hover" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%= Resources.Resource.semaforo %></th>
                                    <th><%= Resources.Resource.falhas %></th>
                                    <th><%= Resources.Resource.porta %></th>
                                    <th><%= Resources.Resource.data %></th>
                                    <th>OS</th>
                                </tr>
                            </thead>
                            <tbody id="tbProblemas"></tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div id="modalTarefasPendentes" class="modal fade" role="dialog" style="overflow: hidden !important; padding-right: 12px; height: 100%;">
        <div class="modal-dialog" style="float: right; margin-top: 4%; height: 100%;">
            <div class="modal-content" style="height: 91%">
                <div id="divLoadTarefas" style="display: none;">
                    <div style="z-index: 9999; background-color: rgba(0,0,0,.4); position: fixed; width: 100%; height: 100%; top: 0;">
                        <div style="text-align: center; padding-top: 50%; position: absolute; margin: auto; top: 0; right: 0; bottom: 0; left: 0;">
                            <img src="Images/carregando.gif" />
                        </div>
                    </div>
                </div>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" onclick="closeTarefasPendentes();">&times;</button>
                    <i class="fas fa-bell"></i>
                    <%= Resources.Resource.tarefasPendentes %>
                </div>
                <div class="modal-body" style="height: 80%">
                    <div class="input-group" style="padding: 5px 5px;">
                        <input type="text" id="txtFiltraTarefas" class="form-control" placeholder="<%= Resources.Resource.buscar %>..." />
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-primary"><i class="fas fa-search"></i></button>
                        </span>
                    </div>
                    <hr />
                    <div style="height: 85%; overflow: scroll;">
                        <table id="tblTarefasPendentes" class="table table-bordered table-striped table-hover" style="font-size: 11px;">
                            <caption>* <%= Resources.Resource.lista %> <%= Resources.Resource.tarefasPendentes %></caption>
                            <thead>
                                <tr>
                                    <th><%= Resources.Resource.controlador %></th>
                                    <th><%= Resources.Resource.tarefas %></th>
                                    <th><%= Resources.Resource.modoOperacional %></th>
                                </tr>
                            </thead>
                            <tbody id="tbTarefasPendentes"></tbody>
                            <tfoot id="tfTarefasPendentes" style="display: none;">
                                <tr>
                                    <td colspan="3">* <%= Resources.Resource.naoHaRegistros %></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="closeTarefasPendentes();"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>

    <div id="divSincPendentes" style="display: none"></div>

    <script src="Register/Areas/treeViewAreas.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/locales/bootstrap-datepicker.pt-BR.min.js"></script>
    <script src="Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="Scripts/jquery-ui1.12.2.js"></script>
    <script src="Scripts/jsts.min.js"></script>
    <script src="Scripts/leaflet/leaflet.geometryutil.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?libraries=drawing,places,geometry&key=AIzaSyAEbTl1Ap78hKxlDNENs6iu8iBBJaWg2Lc"></script>


    <script type="text/javascript">
        $(function () {
            $(".page-wrapper").removeClass("toggled");
            listArea();
            loadTreeView();

            $('#btnPendencias').popover({
                placement: 'bottom',
                html: true,
                title: "<%= Resources.Resource.tarefasPendentes %>",
                content: function () {
                    return $('#divSincPendentes').html();
                },
                template: '<div class="popover" role="tooltip">' +
                    '<div class="arrow"></div>' +
                    '<button type="button" style="padding:5px;" class="close" onclick="$(\'.popover\').popover(\'hide\')">&times;</button>' +
                    '<h3 class="popover-title"></h3>' +
                    '<div class="popover-content"></div>' +
                    '</div>'
            });

            $('.datepicker').datepicker({
                dateFormat: "dd/mm/yyyy",
                language: 'pt-BR'
            });

            $('#divSearchDatetime').datetimepicker({ language: 'pt-BR' });

            $("#modalTarefasPendentes").draggable({
                handle: ".modal-header"
            });

            $('#txtFiltraTarefas').keyup(function () {
                $("#tblTarefasPendentes tbody tr").each(function () {

                    var colunas = $(this).children();
                    var idEqp = $(colunas[0]).text();
                    var tarefas = $(colunas[1]).text().replace("ã", "a").replace("é", "e").replace("õ", "o").replace("í", "i").replace("á", "a");
                    var modoOperacional = $(colunas[2]).text();
                    var tr = this;
                    if (idEqp.includes($('#txtFiltraTarefas').val().toUpperCase()) || tarefas.toUpperCase().includes($('#txtFiltraTarefas').val().toUpperCase()) || modoOperacional.toUpperCase().includes($('#txtFiltraTarefas').val().toUpperCase()) || $('#txtFiltraTarefas').val() == "") {
                        $(tr).show();
                    }
                    else {
                        $(tr).hide();
                    }

                });
                //$("#tbTarefasPendentes tr:contains('" + $(this).val() + "')").show();
                // $("#tbTarefasPendentes tr:not(:contains('" + $(this).val() + "'))").hide();
            });

            document.getElementById("spaDtAtualizacaoMapa").innerHTML = new Date().toString().substring(0, 25);
            $("#imgFilterProblem").attr("src", "Images/minus.png");
            $("#divFiltersProblems").animate({ "height": 'show' }, "fast");

            $("#imgFilterNobreak").attr("src", "Images/minus.png");
            $("#divFiltersNobreak").animate({ "height": 'show' }, "fast");

            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!
            var yyyy = today.getFullYear();

            if (dd < 10) {
                dd = '0' + dd
            }

            if (mm < 10) {
                mm = '0' + mm
            }

            today = dd + '/' + mm + '/' + yyyy;
            document.getElementById("txtDtHistoComunicacao").value = today;
        });

        function ShowDetailOptions(options) {
            switch (options) {
                case 'Filtros':
                    if ($("#divFiltros").is(':visible')) {
                        $("#imgFiltros").attr("src", "Images/plus.png");
                        $("#divFiltros").animate({ "height": 'hide' }, "fast");
                    }
                    else {
                        $("#imgFiltros").attr("src", "Images/minus.png");
                        $("#divFiltros").animate({ "height": 'show' }, "fast");
                    }
                    break;

                case 'Exibir':
                    if ($("#divExibir").is(':visible')) {
                        $("#imgExibir").attr("src", "Images/plus.png");
                        $("#divExibir").animate({ "height": 'hide' }, "fast");
                    }
                    else {
                        $("#imgExibir").attr("src", "Images/minus.png");
                        $("#divExibir").animate({ "height": 'show' }, "fast");
                    }
                    break;

                case 'UltimosEventos':
                    if ($("#divUltimosEventos").is(':visible')) {
                        $("#imgUltimosEventos").attr("src", "Images/plus.png");
                        $("#divUltimosEventos").animate({ "height": 'hide' }, "fast");
                    }
                    else {
                        $("#imgUltimosEventos").attr("src", "Images/minus.png");
                        $("#divUltimosEventos").animate({ "height": 'show' }, "fast");
                    }
                    break;
            }
        }

        function ShowOptions() {
            if ($("#divOptions").is(':visible')) {
                $("#divOptions").animate({ "width": 'hide' }, "slow");
                $("#divImgPosition").animate({ width: "48px" }, "slow");
                $("#divMapOptionsImg").css("right", "-10px");
                $("#imgOptions").prop("src", "Images/find.png");
            }

            else {
                $("#divOptions").animate({ width: "show", 'left': 0 }, "slow");
                $("#divImgPosition").animate({ width: "405px" }, "slow");
                $("#divMapOptionsImg").css("right", "0px");
                $("#imgOptions").prop("src", "Images/arrowDouble.png");
            }
        }

        function PesquisarFalhaControl() {
            var dataIni = document.getElementById('txtDataIni').value;
            var dataFinal = document.getElementById('txtDataFinal').value;

            if (dataIni == "") {
                $("#txtDataIni").addClass('valida');
                $("#txtDataIni").focus();
                return;
            }
            else $("#txtDataIni").removeClass('valida');

            if (dataFinal == "") {
                $("#txtDataFinal").addClass('valida');
                $("#txtDataFinal").focus();
                return;
            }
            else $("#txtDataFinal").removeClass('valida');

            var i = 0;
            $.ajax({
                type: 'POST',
                url: 'WebServices/Map.asmx/SearchFailureControlador',
                dataType: 'json',
                data: "{'dataIni':'" + dataIni + "','dataFinal':'" + dataFinal + "','idPonto':'" + document.getElementById('hfIdPonto').value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.toString() == "") {
                        $("#divListaFalhaControl").css("display", "none");
                        $("#spaAlertaHistoricoFalhas").css("display", "block");

                    }
                    else {
                        $("#divListaFalhaControl").css("display", "block");
                        $("#spaAlertaHistoricoFalhas").css("display", "none");

                        $("#tbHistoricoFalhas").empty();

                        while (data.d[i]) {
                            var lstHistoricalFailure = data.d[i].split('@');
                            var numberFailure = parseInt(lstHistoricalFailure[0]);
                            var bitsFalha = numberFailure.toString(2);
                            var dataFalha = lstHistoricalFailure[1];
                            var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha");

                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + verificaFalhas.falhas + "</td>";
                            cols += "<td>" + lstHistoricalFailure[2] + "</td>";
                            cols += "<td>" + dataFalha + "</td>";
                            newRow.append(cols);
                            $("#tblHistoricoFalhas").append(newRow);

                            i++;
                        }
                    }
                },
                error: function (data) {
                    params = data; alert('Erro ao obter Historico de Falhas, tente novamente!');
                }
            });
        }

        function openFilters(divName) {
            if (divName == "#divFiltersProblems") {
                if ($("#divFiltersProblems").is(':visible')) {
                    $("#imgFilterProblem").attr("src", "Images/plus.png");
                    $("#divFiltersProblems").animate({ "height": 'hide' }, "fast");
                }
                else {
                    $("#imgFilterProblem").attr("src", "Images/minus.png");
                    $("#divFiltersProblems").animate({ "height": 'show' }, "fast");

                }

            }
        }

        $(document).ready(function () {
            $("#txtCruzamento").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: 'Mapa.aspx/GetDna',
                        data: "{ 'prefixText': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                var lstDna = item.split('@');
                                return {
                                    label: lstDna[1],
                                    val: lstDna[0]
                                }
                            }))
                        },
                        error: function (response) {
                        },
                        failure: function (response) {
                        }
                    });
                },
                select: function (e, i) {
                    $("#txtCruzamento").val(i.item.label);
                    document.getElementById("txtIdPonto").value = i.item.val;
                },
                minLength: 1

            });

        });

        var callServer = function (urlName, params, callback) {
            $.ajax({
                type: 'POST',
                url: urlName,
                dataType: 'json',
                data: params,
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (callback && typeof (callback) == "function") callback(data.d);
                },
                error: function (data) { }
            });
        };

        function listArea() {
            $("#treeArea").empty();
            $("#treeArea").removeClass("tree");

            callServer('Mapa.aspx/ListarAreas', "{'tipo':'area'}",
                function (results) {
                    if (results != "") {
                        $.each(results, function (index, lst) {
                            var newArea = "<li id='area" + lst.id + "' data-id='" + lst.id + "'> " +
                                "<img src='Images/area.png' style='width:16px; heigth:16px;'/> - <label style='cursor:pointer;'>" + lst.nome + "</label>" +
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
            callServer('Mapa.aspx/ListarAreas', "{'tipo':'subArea'}",
                function (results) {
                    if (results != "") {
                        $.each(results, function (index, lst) {
                            var newSubArea = "<ul><li id='subArea" + lst.id + "' data-id='" + lst.id + "'>" +
                                "<img src='Images/subArea.png' style='width:16px; heigth:16px;'/> - <label data-id=" + lst.id + " onclick='loadGruposSubArea(this);' style='cursor:pointer;'>" + lst.nome + "</label>" +
                                "<div class='input-group' style='display:inline-block !important; padding-left:20px; padding-bottom:5px;'><div class='btn-group'>" +
                                "<span style='cursor:pointer;' class='btn btn-primary btn-sm' data-id=" + lst.id + " onclick='loadAnelSubArea(this);' style='color:#fff;'><%= Resources.Resource.anel %></span>" +
                                "<span style='cursor:pointer;' class='btn btn-primary btn-sm' data-id=" + lst.id + " onclick='loadCorredorSubArea(this);' style='color:#fff;'><%= Resources.Resource.corredor %></span>" +
                                "</div></div>" +
                                "</li></ul>";
                            $('[data-id=' + lst.idArea + ']').eq(0).append(newSubArea);
                        });
                    }
                    reloadTree();
                });
        }

        var polygonAnel = [], markersAnel = [], overviewPathGeo = [], pathMarkers = [];

        function LimparAneisMap() {
            var i = markersAnel.length - 1;
            while (markersAnel[i]) {
                map.removeLayer(markersAnel[i]);
                markersAnel.pop(i);
                i--;
            }

            i = polygonAnel.length - 1;
            while (polygonAnel[i]) {
                map.removeLayer(polygonAnel[i]);
                polygonAnel.pop(i);
                i--;
            }
        }

        function loadAnelSubArea(obj) {

            if (markersAnel.length) LimparAneisMap();
            else {
                callServer('Mapa.aspx/LoadAnel', "{'idArea':'" + $(obj).data("id") + "'}",
                    function (results) {

                        $.each(results, function (index, item) {

                            var iconMarker, colorPolygon;
                            switch (item.anel) {
                                case "1":
                                    var position = new L.LatLng(item.lat, item.lng);
                                    pathMarkers.push(position); overviewPathGeo.push([position.lat, position.lng]);
                                    iconMarker = 'Images/marker-red.png';
                                    colorPolygon = "red";
                                    break;
                                case "2":
                                    var position = new L.LatLng(item.lat, item.lng);
                                    pathMarkers.push(position); overviewPathGeo.push([position.lat, position.lng]);
                                    iconMarker = 'Images/marker-blue.png';
                                    colorPolygon = "blue";
                                    break;
                                case "3":
                                    var position = new L.LatLng(item.lat, item.lng);
                                    pathMarkers.push(position); overviewPathGeo.push([position.lat, position.lng]);
                                    iconMarker = 'Images/marker-green.png';
                                    colorPolygon = "green";
                                    break;
                                case "4":
                                    var position = new L.LatLng(item.lat, item.lng);
                                    pathMarkers.push(position); overviewPathGeo.push([position.lat, position.lng]);
                                    iconMarker = 'Images/marker-yellow.png';
                                    colorPolygon = "yellow";
                                    break;
                            }

                            if ((results.length - 1) == index) printSubAreaAnel(iconMarker, colorPolygon, item);
                            else if (item.anel != results[(index + 1)].anel || item.idEqp != results[(index + 1)].idEqp) printSubAreaAnel(iconMarker, colorPolygon, item);

                        });
                    });
            }
        }

        function printSubAreaAnel(iconMarker, colorPolygon, item) {
            var distance = (L.GeometryUtil.length(pathMarkers) / 1000) / 1000;
            var geoReader = new jsts.io.GeoJSONReader(), geoWriter = new jsts.io.GeoJSONWriter();
            var geometry = geoReader.read({ type: "LineString", coordinates: overviewPathGeo }).buffer(distance);
            var oCoordinates = geoWriter.write(geometry).coordinates[0];

            var oLanLng = [];
            for (i = 0; i < oCoordinates.length; i++) {
                var oItem;
                oItem = oCoordinates[i];
                oLanLng.push(new L.LatLng(oItem[0], oItem[1]));
            }

            var polygon = new L.polygon(oLanLng, { weight: 1, color: colorPolygon }).addTo(map);
            polygonAnel.push(polygon);

            var iconAnel = L.icon({
                iconUrl: iconMarker, shadowUrl: 'Images/marker-shadow.png', iconSize: [24, 32],
                iconAnchor: [12, 41], popupAnchor: [1, -34], shadowSize: [41, 41]
            });

            var markerAnel = new L.marker(polygon.getBounds().getCenter(), {
                icon: iconAnel
            }).addTo(map).bindPopup("<%= Resources.Resource.subArea %>: " + item.nomeSubArea + " - <%= Resources.Resource.anel %>: " + item.anel + " - <%= Resources.Resource.idPonto %>:" + item.idEqp);
            markersAnel.push(markerAnel);

            map.setView(polygon.getBounds().getCenter(), 18);
            overviewPathGeo = [], pathMarkers = [];
        }

        function loadCorredorSubArea(obj) {

            $("#divCorredorSubArea").empty();

            callServer("Mapa.aspx/getCorredor", "{'idArea':'" + $(obj).data("id") + "'}",
                function (results) {
                    if (results != "") {
                        $.each(results, function (index, item) {

                            if (index == 0) $("#lblSubAreaCorredor").text(item.nomeSubArea);

                            var item = "<a href='#' onclick='corredorSubAreaMap(this)' data-dismiss='modal' data-id=" + $(obj).data("id") + " data-idCorredor=" + item.idCorredor + " class='list-group-item'>" + item.Corredor + "</a>";
                            $("#divCorredorSubArea").append(item);
                        });
                    }

                    $("#modalCorredorSubArea").modal("show");
                });
        }

        var directionsService = new google.maps.DirectionsService();

        var corredorPolyline = [], grupoCorredorMarker = [];

        function corredorSubAreaMap(obj) {

            var itemCorredor = [], coordsCorredor = [];
            var idEqp = "", corredor = "", tmpPercurso = "", distancia = "";
            limparCorredor();

            callServer("Mapa.aspx/getCorredorSubArea", "{'idArea':'" + $(obj).data("id") + "','idCorredor':'" + $(obj).data("idcorredor") + "'}",
                function (results) {
                    if (results != "") {

                        var iconPolyline = L.icon({
                            iconUrl: "Images/measle_blue.png", iconSize: [7, 7], iconAnchor: [4, 4]
                        });

                        $.each(results, function (i, item) {

                            var marker = L.marker(new L.LatLng(item.latitude, item.longitude), {
                                title: "G" + item.GrupoLogico, icon: iconPolyline
                            }).bindPopup("<small class='text-muted'><%= Resources.Resource.subArea %>: " + $("#lblSubAreaCorredor").text() + " - <%= Resources.Resource.idPonto %>:" + item.IdEqp + "</small><br>" +
                                "<table class='table table-bordered table-striped' style='width:500px; font-size: x-small;'><thead><tr><th><%= Resources.Resource.grupo %></th><th><%= Resources.Resource.anel %></th><th><%= Resources.Resource.endereco %></th><th>Min. Próx. <%= Resources.Resource.grupo %></th></tr></thead>" +
                                "<tbody><tr><td>G" + item.GrupoLogico + " - " + item.TipoGrupo + "</td>" +
                                "<td>" + item.Anel + "</td><td>" + item.Endereco + "</td><td>" + item.TempoEntreCruzamentos + "</td></tr></tbody></table>", {
                                    maxWidth: 550
                                }).addTo(map);
                            grupoCorredorMarker.push(marker);

                            coordsCorredor.push({
                                location: new google.maps.LatLng(item.latitude, item.longitude)
                            });

                            idEqp = item.IdEqp;
                            corredor = item.Corredor;
                            tmpPercurso = item.TempoPercurso;
                            distancia = item.Distancia;
                        });

                        var countResults = (results.length - 1);
                        itemCorredor.push({
                            origin: new google.maps.LatLng(results[0].latitude, results[0].longitude),
                            destination: new google.maps.LatLng(results[countResults].latitude, results[countResults].longitude),
                            waypoints: coordsCorredor
                        });

                        directionsService.route({
                            origin: itemCorredor[0].origin,
                            destination: itemCorredor[0].destination,
                            waypoints: itemCorredor[0].waypoints,
                            travelMode: google.maps.TravelMode.DRIVING
                        }, function (response, status) {
                            if (status === google.maps.DirectionsStatus.OK) {

                                var polyline = new L.polyline([], { color: 'red' })
                                    .bindPopup("<small class='text-muted'><%= Resources.Resource.subArea %>: " + $("#lblSubAreaCorredor").text() + " - <%= Resources.Resource.idPonto %>:" + idEqp + "</small><br>" +
                                        "<table class='table table-bordered table-striped' style='width:500px; font-size: x-small;'><thead><tr><th><%= Resources.Resource.corredor %></th><th><%= Resources.Resource.tempoPercurso %></th><th><%= Resources.Resource.distancia %></th></tr></thead>" +
                                        "<tbody><tr><td>" + corredor + "</td><td>" + tmpPercurso + "</td><td>" + distancia + "</td></tr></tbody></table>", {
                                            maxWidth: 550
                                        });

                                    var bounds = new google.maps.LatLngBounds();


                                    var legs = response.routes[0].legs;
                                    for (i = 0; i < legs.length; i++) {
                                        var steps = legs[i].steps;
                                        for (j = 0; j < steps.length; j++) {
                                            var nextSegment = steps[j].path;
                                            for (k = 0; k < nextSegment.length; k++) {
                                                polyline.addLatLng(new L.LatLng(nextSegment[k].lat(), nextSegment[k].lng()));
                                                bounds.extend(nextSegment[k]);
                                            }
                                        }
                                    }
                                    map.addLayer(polyline);
                                    corredorPolyline.push(polyline);
                                    map.setView(polyline.getBounds().getCenter(), 18);
                                }
                            });
                        itemCorredor = [], coordsCorredor = [];

                    }
                });
        }

        function limparCorredor() {
            if (corredorPolyline.length) {
                var i = corredorPolyline.length - 1;
                while (corredorPolyline[i]) {
                    map.removeLayer(corredorPolyline[i]);
                    corredorPolyline.pop(i);
                    i--;
                }
            }

            if (grupoCorredorMarker.length) {
                var i = grupoCorredorMarker.length - 1;
                while (grupoCorredorMarker[i]) {
                    map.removeLayer(grupoCorredorMarker[i]);
                    grupoCorredorMarker.pop(i);
                    i--;
                }
            }
        }

        function getTypeMarker(tipoMarker, grupo) {
            var iconLabel = "";

            if (tipoMarker == "cima") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-up2"><label style="font-family: sans-serif; display:inline;">' + grupo + '</label></span>';
            else if (tipoMarker == "baixo") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-down2"><label style="font-family: sans-serif; display:inline;">' + grupo + '</label></span>';
            else if (tipoMarker == "direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-right2"><label style="font-family: sans-serif; display:inline;">' + grupo + '</label></span>';
            else if (tipoMarker == "esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-left2"><label style="font-family: sans-serif; display:inline;">' + grupo + '</label></span>';
            else if (tipoMarker == "conversão direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-redo"><label style="font-family: sans-serif; display:inline;">' + grupo + '</label></span>';
            else if (tipoMarker == "conversão esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-undo"><label style="font-family: sans-serif; display:inline;">' + grupo + '</label></span>';
            else if (tipoMarker == "diagonal cima direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-up-right2"><label style="font-family: sans-serif; display:inline;">' + grupo + '</label></span>';
            else if (tipoMarker == "diagonal cima esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-up-left2"><label style="font-family: sans-serif; display:inline;">' + grupo + '</label></span>';
            else if (tipoMarker == "diagonal baixo direita") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-down-right2"><label style="font-family: sans-serif; display:inline;">' + grupo + '</label></span>';
            else if (tipoMarker == "diagonal baixo esquerda") iconLabel = '<span style="font-size:12px; font-weight: bold;" class="icon-arrow-down-left2"><label style="font-family: sans-serif; display:inline;">' + grupo + '</label></span>';
            else if (tipoMarker == "pedestre") iconLabel = '<i style="font-size:16px;" class="material-icons">directions_walk</i><label style="font-family: sans-serif; font-size:12px; font-weight: bold; display:inline;">' + grupo + '</label>';

            return iconLabel;
        }

        function getPendencias(obj) {
            var idElm = "#" + obj.id;
            var elmSubArea = $(obj).data("tipo") == "subArea" ? "#lblSubArea" : "#lblSubAreaCorredor";
            $("#divSincPendentes").empty();

            callServer("Mapa.aspx/getPendencias", "{'subArea':'" + $(elmSubArea).text() + "'}",
                function (results) {
                    if (results != "") {
                        $.each(results, function (index, item) {
                            var row = "";
                            var binary = (item.Byte1 >>> 0).toString(2);

                            var pad = "00000000";
                            binary = (pad.substring(0, pad.length - binary.length) + binary).split('').reverse();

                            row += "<div class='well well-sm' style='font-size:12px;'><%= Resources.Resource.idPonto %>:" + item.IdControlador + "</div>";
                            if (binary[0] == "1") row += "<p style='border-bottom:1px solid #d4d4d4; font-size:12px;'><span class='glyphicon glyphicon-refresh'></span> - <%= Resources.Resource.reset %> <%= Resources.Resource.pendente %>.</p>";
                            if (binary[1] == "1") row += "<p style='border-bottom:1px solid #d4d4d4; font-size:12px;'><span class='glyphicon glyphicon-edit'></span> - <%= Resources.Resource.imposicao %> <%= Resources.Resource.pendente %>.</p>";
                            if (binary[2] == "1") row += "<p style='border-bottom:1px solid #d4d4d4; font-size:12px;'><span class='glyphicon glyphicon-remove'></span> - <%= Resources.Resource.cancelamento %> <%= Resources.Resource.imposicao %> <%= Resources.Resource.pendente %>.</p>";
                            if (binary[3] == "1") row += "<p style='border-bottom:1px solid #d4d4d4; font-size:12px;'><span class='glyphicon glyphicon-list-alt'></span> - <%= Resources.Resource.envio %> <%= Resources.Resource.planos %> <%= Resources.Resource.pendente %>.</p>";
                            if (binary[4] == "1") row += "<p style='border-bottom:1px solid #d4d4d4; font-size:12px;'><span class='glyphicon glyphicon-calendar'></span> - <%= Resources.Resource.envio %> <%= Resources.Resource.agenda %> <%= Resources.Resource.pendente %>.</p>";
                            if (binary[5] == "1") row += "<p style='border-bottom:1px solid #d4d4d4; font-size:12px;'><span class='glyphicon glyphicon-dashboard'></span> - <%= Resources.Resource.envio %> <%= Resources.Resource.horarioVerao %> <%= Resources.Resource.pendente %>.</p>";
                            if (binary[6] == "1") row += "<p style='border-bottom:1px solid #d4d4d4; font-size:12px;'><span class='glyphicon glyphicon-camera'></span> - <%= Resources.Resource.solicitacao %> <%= Resources.Resource.imagem %> <%= Resources.Resource.pendente %>.</p>";
                            if (binary[7] == "1") row += "<p style='border-bottom:1px solid #d4d4d4; font-size:12px;'><span class='glyphicon glyphicon-refresh'></span> - <%= Resources.Resource.imposicao %> <%= Resources.Resource.modoOperacional %>.</p>";

                            if (binary[0] == "0" && binary[1] == "0" && binary[2] == "0" && binary[3] == "0" && binary[4] == "0"
                                && binary[5] == "0" && binary[6] == "0" && binary[7] == "0")
                                row = "<div class='well well-sm' style='font-size:12px;'><%= Resources.Resource.idPonto %>:" + item.IdControlador + " - <%= Resources.Resource.naoHaRegistros %></div>";

                            $("#divSincPendentes").append(row);
                        });
                        loadPopover($("#divSincPendentes").html(), idElm);
                    }
                });
        }

        function loadPopover(html, elm) {
            $(elm).popover({
                html: true,
                content: html,
                placement: 'bottom',
                template: '<div class="popover" role="tooltip">' +
                    '<div class="arrow"></div>' +
                    '<button type="button" style="padding:5px;" class="close" onclick="$(\'.popover\').popover(\'hide\')">&times;</button>' +
                    '<h3 class="popover-title"></h3>' +
                    '<div class="popover-content"></div>' +
                    '</div>'
            }).popover('show');
        }

        function getPlanoSubArea(obj) {
            var elmSubArea = $(obj).data("tipo") == "subArea" ? "#lblSubArea" : "#lblSubAreaCorredor";
            $("#tbPlanos").empty();
            $("#tfPlanos").css("display", "none");

            $("#lblSubAreaImposicao").text($(elmSubArea).text());
            callServer("Mapa.aspx/getPlanoSubArea", "{'subArea':'" + $(elmSubArea).text() + "'}",
                function (results) {
                    if (results != "") {
                        $.each(results, function (index, item) {
                            var newRow = $("<tr>");
                            var cols = "<td>" + item.NomePlano + "</td>";
                            if (item.Imposicao == true)
                                cols += "<td><a data-tipo='cancelamento' data-plano='" + item.NomePlano + "' data-subarea='" + $(elmSubArea).text() + "' onclick='ImporPlano(this)'><%= Resources.Resource.cancelar %></a></td>";
                            else
                                cols += "<td><a data-tipo='imposicao' data-plano='" + item.NomePlano + "' data-subarea='" + $(elmSubArea).text() + "' onclick='ImporPlano(this)'><%= Resources.Resource.impor %></a></td>";

                            $(newRow).append(cols);
                            $("#tblPlanos").append(newRow);
                        });
                    }
                    else $("#tfPlanos").css("display", "");

                });

            $("#modalImposicaoPlano").modal("show");
        }

        function ImporPlano(obj) {
            var plano = $(obj).data("plano"), subArea = $(obj).data("subarea"), tipo = $(obj).data("tipo");

            var modoOperacional = "Centralizado";
            $('#tbVinculoSubArea > tr').each(function (i, tr) {
                if (tr.cells[2].innerText.indexOf("Local") != -1) {
                    modoOperacional = "Local";
                    return false;
                }
            });

            if (modoOperacional == "Centralizado") {
                callServer("Mapa.aspx/ImporPlanoSubArea", "{'plano':'" + plano + "','tempo':'" + $("#txtTempoImposicao").val() +
                    "','subArea':'" + subArea + "','tipo':'" + tipo + "'}",
                    function (results) {
                        if (results == false)
                            swal("<%= Resources.Resource.atencao %>", "<%= Resources.Resource.planoImposicaoNaoExiste %>", "warning");
                        if (tipo == "imposicao") {
                            $(obj).text("<%= Resources.Resource.cancelar %>");
                            $(obj).data("tipo", "cancelamento");
                            swal("<%= Resources.Resource.sucesso %>", "<%= Resources.Resource.imposicao %> <%= Resources.Resource.solicitada %>!", "success");
                        } else {
                            $(obj).text("<%= Resources.Resource.impor %>");
                            $(obj).data("tipo", "imposicao");
                            swal("<%= Resources.Resource.sucesso %>", "<%= Resources.Resource.imposicao %> <%= Resources.Resource.cancelamento %> <%= Resources.Resource.solicitada %>!", "success");
                        }
                    });
            } else swal("<%= Resources.Resource.atencao %>", "<%= Resources.Resource.msgErroEqpNaoCentralizado %>", "warning");
        }

        function ImporModoOperacional(obj) {
            var tipo = $(obj).data("tipo"), idEqp = $(obj).data("ideqp"), anel = $(obj).data("anel");

            callServer("Mapa.aspx/ImporModoOperacional", "{'anel':'" + anel + "','idEqp':'" + idEqp + "','tipo':'" + tipo + "'}",
                function (results) {
                    if (tipo == "imposicao") {
                        $(obj).text("<%= Resources.Resource.cancelar %> <%= Resources.Resource.centralizacao %>");
                        $(obj).data("tipo", "cancelamento");
                        swal("<%= Resources.Resource.sucesso %>", "<%= Resources.Resource.centralizacao %> <%= Resources.Resource.solicitada %>!", "success");
                    } else {
                        $(obj).text("<%= Resources.Resource.centralizar %>");
                        $(obj).data("tipo", "imposicao");
                        swal("<%= Resources.Resource.sucesso %>", "<%= Resources.Resource.cancelamento %> <%= Resources.Resource.imposicao %> <%= Resources.Resource.solicitada %>!", "success");
                    }
                });
        }
        function AbrirMonitoramento(idEqp) {
            if (idEqp == "")
                idEqp = $("#lblIdPonto").text().replace("<%= Resources.Resource.idPonto %>", "").replace(": ", "");

            window.open("MonitoramentoCentral/Monitoramento.aspx?IdEqp=" + idEqp);
        }
    </script>
    <script type="text/javascript" src="Scripts/distLeaflet/leaflet.zoomdisplay-src.js"></script>
    <script src="dist-leaflet-markers/leaflet.awesome-markers.js"></script>
    <script src="Scripts/Map.js"></script>
</asp:Content>
