<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Register.Controller.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="../../Scripts/jquery.mask.js"></script>

    <style type="text/css">        /*CHECKBOX*/
        input[type=checkbox].dias {
            display: block;
            margin: 0.2em;
            cursor: pointer;
            padding: 0.2em;
            opacity: 0;
            width: 18px;
            height: 18px;
            position: absolute;
        }

            input[type=checkbox].dias + label:before {
                content: "\2714";
                border: 0.1em solid #464953;
                border-radius: 0.2em;
                display: inline-block;
                width: 18px;
                height: 18px;
                font-size: small;
                padding-left: 0.2em;
                padding-bottom: 1.2em;
                margin-right: 0.2em;
                vertical-align: bottom;
                color: transparent;
                transition: .2s;
            }


            input[type=checkbox].dias:checked + label:before {
                background-color: #5c5c5d;
                border-color: #5c5c5d;
                color: #fff;
            }

            input[type=checkbox].dias:disabled + label:before {
                transform: scale(1);
                border-color: #aaa;
            }

            input[type=checkbox].dias:checked:disabled + label:before {
                transform: scale(1);
                background-color: #bfb;
                border-color: #bfb;
            }
        #myImg {
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

            #myImg:hover {
                opacity: 0.7;
            }

        .modal {
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

        .modal-content {
            margin: auto;
            display: block;
            /*width: 80%;
            max-width: 700px;*/
        }

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

        @media only screen and (max-width: 700px) {
            .modal-content {
                width: 100%;
            }
        }

        #txtsearchCamera {
            background-image: url('../../Images/1377850758_Black_Search.png');
            background-size: 20px;
            height: 32px;
            background-position: 10px;
            background-repeat: no-repeat;
            width: 100%;
            font-size: 16px;
            padding: 12px 20px 12px 40px;
            border: 1px solid #ddd;
            margin-bottom: 12px;
        }

        .tblgrid tr:nth-child(even) {
            background-color: #eee;
        }

        .tblgrid tr:nth-child(odd) {
            background-color: #fff;
        }

        .tblgrid th {
            text-align: left;
            background: #fff url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAUCAAAAABpZQh9AAAAF0lEQVQI12P4z/SP6S8Q/sOCYawPTO8Ajz0T2VT0ZeQAAAAASUVORK5CYII=') /*../../Images/bar_top.png*/ repeat-x left bottom;
            border-bottom: 1px solid #333;
        }

        .tblgrid tr:nth-child(even):hover {
            background-color: #fff;
        }

        .tblgrid tr:nth-child(odd):hover {
            background-color: #f5f5f5;
        }

        .valida-input::-webkit-input-placeholder {
            color: #ff0000;
        }

        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            overflow-x: hidden;
            width: 300px;
            background-color: #ffffff;
            cursor: pointer;
        }

        @media (max-width: 3044px) {
            .textoControladorMestre {
                width: 174px;
            }
            

            .conjugado {
                width: 30%;
                float: left;
            }

            .dvResponsive {
                width: 50%;
                float: left;
            }

            .dvEndResponsive {
                float: right;
                width: 49%;
            }
        }

        @media (max-width: 1440px) {
            .textoControladorMestre {
                width: 282px;
            }
            
            .conjugado {
                width: 100%;
                float: left;
            }
            .dvResponsive {
                width: 100%;
            }

            .dvEndResponsive {
                width: 100%;
                margin-top: 10px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.controlador %>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="index.html"><%= Resources.Resource.cadastro %></a>
        </li>
        <li class="breadcrumb-item"><a href="#"><%= Resources.Resource.controlador %></a>
        </li>
    </ol>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hfUser" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfLong" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfLat" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="HiddenField2" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hdfId" ClientIDMode="Static" runat="server" />

    <div id="divMain">
        <div id="body" style="width: 100%; padding: 5px;">

            <div class="input-group" style="display: none">
                Id <%= Resources.Resource.cruzamento %>:<br />
                <input type="text" id="txtIdLocal" placeholder="Id <%= Resources.Resource.cruzamento %>..." class="form-control" />
                <input id="txtEndereco" placeholder="<%= Resources.Resource.endereco %>..." class="form-control" type="text" style="display: none;" />
                <span class="input-group-btn">
                    <button type="button" class="btn btn-primary" onclick="pesqEqp();"><i class="ficon ft-search"></i></button>
                </span>
            </div>
            <div class="dvResponsive">

                <div id="tdSerial" style="width: 100%" class="btn-group">
                    <span style="margin-top: 10px; margin-right: 10px;">Serial:</span>
                    <input id="txtSerialCad" type="text" placeholder="Serial..." class="form-control" />
                    <button type="button" class="btn btn-secondary" onclick="pesqEqp();"><i class="ficon ft-search"></i></button>

                    <input type="button" id="btnNovo" value="<%= Resources.Resource.novo %>" class="btn btn-success" onclick="Novo()" />
                </div>
                <div id="dvModelo" style="width: 100%; margin-top: 10px; display: none" class="btn-group">
                    <span style="margin-top: 10px; margin-right: 10px;"><%= Resources.Resource.modelo %>:</span>
                    <input id="txtModelo" type="text" class="form-control" />
                </div>
            </div>
            <div id="dvGrdPesquisa" style="padding-top: 10px" class="table-responsive">
                <table class="table table-bordered mb-0">
                    <thead>
                        <tr>
                            <th>Serial</th>
                            <th><%= Resources.Resource.cruzamento %></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="tbControlador">
                        <tr>
                            <td colspan="3"><%= Resources.Resource.naoHaRegistros %></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="dvEndResponsive">
                <div id="tdPesqEnd" class="btn-group" style="display: none; width: 100%;">
                    <span style="margin-top: 10px; margin-right: 10px"><%= Resources.Resource.endereco %>:</span>
                    <input id="txtCruzamento" placeholder="<%= Resources.Resource.buscar %> <%= Resources.Resource.cruzamento %>.." <%--onblur="Geocodificacao()"--%> class="form-control" type="text" />
                    <%--<button type="button" class="btn btn-secondary" onclick="Geocodificacao();"><i class="ficon ft-search"></i></button>--%>
                </div>
            </div>
            <div class="dvEndResponsive">
                <div id="dvControladorMestre" class="btn-group" style="display: none; width: 100%; margin-top: 10px">
                    <div class="conjugado" style="margin-top:10px">
                        <input type="checkbox" id="chkConjugado" class="dias" onclick="Mestre()" />
                        <label id="lblConjugado">Conjugado</label>
                    </div>
                    <input id="txtMestre" placeholder="Serial <%= Resources.Resource.controlador %> <%= Resources.Resource.mestre %>.." disabled="disabled" class="form-control" type="text" />
                    <%--<button type="button" class="btn btn-secondary" onclick="Geocodificacao();"><i class="ficon ft-search"></i></button>--%>
                </div>
            </div>
            <p style="border-bottom: 1px solid #d8d8d8; display: none; padding: 5px;">
                <button id="btnVisualizarControl" type="button" class="btn btn-default" onclick="GetControls();"><%= Resources.Resource.visualizarControladores %></button>
                &nbsp;
                <button id="btnNovaCamera" type="button" class="btn btn-default" data-toggle="modal" data-target="#popupCamera" onclick="NovaCamera()"><%= Resources.Resource.novaCamera %></button>
                &nbsp;
                <button id="btnAbrirCamera" type="button" class="btn btn-default" onclick="VisualCamera()" data-toggle="modal" data-target="#popupVisualCamera"><%= Resources.Resource.abrirCameras %></button>
            </p>
            <div id="divEquipamento" style="display: none; font-size: 0.8em;">
                <input type="button" class="btn btn-info" id="btnGrupo" style="margin-bottom: 8px; margin-top: 16px" value="<%= Resources.Resource.gruposSemaforicos %>" onclick="VerGrupo()" />
                <input id="btnAdicionarArquivo" onclick="btnAdicionarArquivo_Click();" style="margin-bottom: 8px; margin-top: 16px" type="button" class="btn btn-primary" value="<%= Resources.Resource.anexar %> Croqui" />

                <div id="divArquivos" style="display: none; font-size: small">
                    <input type="file" id="myfile" name="inputptbr[]" onchange="UploadFile(this)" />
                    <br />
                </div>
                <div class="table-responsive">
                    <table id="tblArquivos" class="table table-bordered">
                        <thead>
                            <tr style="background-color: #f2f2f2;">
                                <th></th>
                                <th><%= Resources.Resource.arquivo %>(s)</th>
                                <%--<th></th>--%>
                                <th></th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="tbArquivos">
                            <tr>
                                <td colspan="5"><%= Resources.Resource.naoHaRegistros %></td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <br />

                <input id="btnSalvarCruz" type="button" style="" class="btn btn-success" value="<%= Resources.Resource.salvar %>" onclick="SalvarCruzamento();" />
                <input type="button" class="btn btn-warning" value="<%= Resources.Resource.cancelar %>" style="width: 130px" onclick="CancelarCad()" />
                <input id="btnExcluirCruz" type="button" style="width: 130px;" class="btn btn-danger" value="<%= Resources.Resource.excluir %>" onclick="ExcluirCruzamento();" />
                <br />
                <br />
                <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%; padding: 0px">
                    <div class="card box-shadow-0" data-appear="appear" data-animation="fadeInDown" id="divMapa">
                        <div class="card-header white bg-info white" id="dvTituloCorredor" <%--style="background-color: #ff453c !important;"--%>>
                            <h4 class="card-title white"><%= Resources.Resource.visualizarEnderecoMapa %></h4>
                        </div>
                        <div class="card-content collapse show">
                            <div class="card-body border-bottom-info white">
                                <p style="margin-left: 10px; margin-top: 5px; display: none;">
                                    <%= Resources.Resource.latitude %>:
            <input id="txtLat" placeholder="<%= Resources.Resource.latitude %>..." class="form-control" type="text" style="width: 150px; margin-left: 5px; display: inline;" disabled="disabled" />
                                    <%= Resources.Resource.longitude %>:
            <input id="txtLong" placeholder="<%= Resources.Resource.longitude %>..." class="form-control" type="text" style="width: 150px; display: inline;" disabled="disabled" />
                                </p>
                                <input class="form-control" onblur="Geocodificacao()" placeholder="<%= Resources.Resource.pesquisar %> <%= Resources.Resource.endereco %>..." type="text" id="txtPesqEndereco" style="margin-bottom: 10px" />
                                <div id="map" style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; border-color: #f4f4f4; height: 500px; visibility: hidden;">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <input id="hfSerialController" type="hidden" />
                <br />

                <label style="margin-left: 5px; display: none">
                    <b><%= Resources.Resource.cruzamento %>:</b> <span id="spaCruzamento"></span>
                </label>
            </div>
        </div>
        <div id="myModal" class="modal">
            <span class="closeImg" style="cursor: pointer;" onclick="closeModal()">&times;</span>
            <img class="modal-content" style="height: 100%" id="img01" />
            <div id="caption"></div>
        </div>
        <%--        <div id="mpCadCruzamento" class="modal fade" role="dialog">
            <div class="modal-dialog" style="width: 900px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 id="" class="modal-title">Cadastro Cruzamento</h4>
                    </div>
                    <div class="modal-body" style="width: 100%;">

                        <div class="input-group">
                            <input id="txtCruzamento" placeholder="Buscar endereço.." class="form-control" type="text" style="display: inline;" />
                            <span class="input-group-addon" onclick="Geocodificacao()" style="cursor: pointer;"><i class="glyphicon glyphicon-search"></i></span>

                        </div>
                        <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; border-color: #f4f4f4; margin-top: 5px; margin-left: 10px;">

                            <p style="margin-left: 10px; margin-top: 5px; display: none;">
                                Latitude:
            <input id="txtLat" placeholder="Latitude..." class="form-control" type="text" style="width: 150px; margin-left: 5px; display: inline;" disabled="disabled" />
                                Longitude:
            <input id="txtLong" placeholder="Longitude..." class="form-control" type="text" style="width: 150px; display: inline;" disabled="disabled" />
                            </p>
                            <div id="map" style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; width: 850px; border-color: #f4f4f4; margin-top: 20px; height: 300px; visibility: hidden;">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input id="btnExcluirCruz" type="button" style="width: 130px" class="btn btn-danger" value="Excluir" onclick="ExcluirCruzamento();" style="visibility: hidden;" />
                        <input id="btnSalvarCruz" type="button" style="width: 130px" class="btn btn-success" value="Salvar" onclick="SalvarCruzamento();" />
                    </div>
                </div>
            </div>
        </div>--%>

        <div id="popupEqp" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 id="hInfoCad" class="modal-title"><%= Resources.Resource.cadastrar %> <%= Resources.Resource.controlador %></h4>
                    </div>
                    <div class="modal-body" style="width: 100%;">
                        <div class="container" style="width: 100%;">
                            <ul class="nav nav-tabs">
                                <li class="active" style="display: none;"><a data-toggle="tab" href="#Equipamento"><%= Resources.Resource.controlador %></a></li>
                                <li id="liConj" style="display: none;"><a data-toggle="tab" href="#Conjugados"><%= Resources.Resource.conjugados %></a></li>
                            </ul>

                            <div class="tab-content">
                                <div id="Equipamento" class="tab-pane fade in active">
                                    <p id="pInfoCad" style="display: none;">
                                        <span id="spaInfoCad" style="color: red;"></span>
                                    </p>
                                    <table style="width: 100%;">
                                        <tr id="trConjugado">
                                            <td></td>
                                        </tr>
                                    </table>
                                    <table class="table table-bordered" style="display: none;">
                                        <tr>
                                            <td colspan="3">
                                                <b><%= Resources.Resource.conjugados %>:
                                    <input type="checkbox" id="chk" onclick="setConjugado(this)" /></b>
                                            </td>
                                        </tr>
                                        <tr id="tdDNAMestre" style="border-bottom: 1px solid #d8d8d8; height: 40px; display: none">
                                            <td><b>DNA <%= Resources.Resource.mestre %>:</b></td>
                                            <td style="padding-left: 85px;">
                                                <span id="spnValidaDNAMestre" style="color: red; display: none"><%= Resources.Resource.informeDnaMestre %> </span>
                                                <div class="input-group">
                                                    <input type="text" class="form-control" style="display: inline;" id="txtDNAMestre" />
                                                    <span class="input-group-btn">
                                                        <button type="button" id="aPesquisarDNA" class="btn btn-primary" onclick="PesquisarDNA()"><%= Resources.Resource.buscar %></button>
                                                    </span>
                                                </div>
                                            </td>
                                            <%--<td>&nbsp;&nbsp;<img src="../../Images/search.png" style="width: 32px; height: 32px;" id="aPesquisarDNA" onclick="PesquisarDNA()" /></td>--%>
                                        </tr>
                                        <tr id="trEnderecoDNA" style="display: none">
                                            <td colspan="3"><b><%= Resources.Resource.cruzamento %>:</b>
                                                <span id="spnEndereco"><%= Resources.Resource.naoHaRegistros %></span></td>
                                        </tr>
                                    </table>
                                    <span id="spnSerialMestre" style="display: none"></span>
                                    <table class="table table-bordered" style="width: 100%">
                                        <tr>
                                            <td>Id <%= Resources.Resource.cruzamento %>:
                                            </td>
                                            <td>

                                                <input type="text" id="txtIdDnaCad" placeholder="Id <%= Resources.Resource.cruzamento %>..." class="form-control" style="width: 150px; display: inline; /*margin-left: 40px; */" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Serial:
                                            </td>
                                            <td>
                                                <%--    <div class="input-group">
                                                    <input id="txtSerialCad" type="text" placeholder="Serial..." class="form-control" style="display: inline; /*width: 300px; */ /*margin-left: 80px; */" />
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-primary" id="imgPesqSerialControl" onclick="pesqSerialControl()">Buscar</button>
                                                    </span>
                                                </div>--%>
                                            </td>
                                        </tr>
                                        <tr style="display: none">
                                            <td>DDNS:</td>
                                            <td>
                                                <input id="txtDDNS" type="text" placeholder="DDNS..." class="form-control" style="display: inline; width: 300px; /* margin-left: 80px; */" /></td>
                                        </tr>
                                        <tr style="display: none">
                                            <td>IP: </td>
                                            <td>
                                                <input id="txtIP" type="text" placeholder="IP..." class="form-control" style="display: inline; width: 300px; /* margin-left: 105px; */" /></td>
                                        </tr>
                                        <tr style="display: none">
                                            <td>Port SNMP MIB: </td>
                                            <td>
                                                <input id="txtPortaSnmpMib" type="text" class="form-control" placeholder="Port SNMP MIB..." style="display: inline; width: 300px; /* margin-left: 10px; */" />
                                            </td>
                                        </tr>
                                        <tr style="display: none">
                                            <td>Port SNMP TRAP: </td>
                                            <td>
                                                <input id="txtPortaSnmpTrap" type="text" class="form-control" placeholder="Port SNMP TRAP..." style="display: inline; width: 300px;" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div id="divCadController" style="display: none;">
                                                    <table style="display: none;">
                                                        <tr>
                                                            <td>Port SNMP Reset:</td>
                                                            <td style="padding-left: 30px">
                                                                <input id="txtPortaReset" type="text" class="form-control" placeholder="Port SNMP Reset..." style="display: inline; width: 300px;" />
                                                            </td>
                                                        </tr>
                                                    </table>

                                                    <table style="width: 100%; display: none;">
                                                        <tr>
                                                            <td><%= Resources.Resource.habilitarCentral %>: 
                                <input id="chkHabilitaCentral" type="checkbox" checked="checked" />
                                                            </td>
                                                            <td><%= Resources.Resource.semComunicacao %>: 
                                <input id="chkSemComunicacao" type="checkbox" />
                                                            </td>
                                                            <td style="display: none">
                                                                <b><%= Resources.Resource.recebeIpPorTrap %>:</b>
                                                                <input id="chkIpTrap" type="checkbox" checked="checked" onclick="setIpPorTrap();" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3"><%= Resources.Resource.requisicao %> Reset:
                                                                <input id="chkResetPorRequisicao" type="checkbox" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="divInfoEmpCet">
                                            <td colspan="2">
                                                <div style="display: none;">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td><%= Resources.Resource.consorcio %>:</td>
                                                            <td><span id="spaConsorcio" style="margin-left: 65px;"></span></td>
                                                        </tr>
                                                        <tr>
                                                            <td><%= Resources.Resource.empresa %>:</td>
                                                            <td>
                                                                <select id="sleEmpresa" class="form-control" style="width: 250px; margin-left: 65px; display: inline;"></select></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div id="Conjugados" style="display: none;" class="tab-pane fade">
                                    <table class="table table-bordered">
                                        <tr>
                                            <td>
                                                <b><%= Resources.Resource.controlador %> <%= Resources.Resource.mestre %>:</b><span id="ctrlMestre"></span>
                                                <p id="pAddConj">
                                                    <button type="button" id="btnAddConj" class="btn btn-default" onclick="AddConj()"><%= Resources.Resource.adicionar %> <%= Resources.Resource.conjugados %></button>
                                                </p>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tblCadConj" class="table table-bordered" style="display: none;">
                                        <tr>
                                            <td>
                                                <div class="input-group">
                                                    <input id="txtIdPontoConj" class="form-control" type="text" placeholder="Id <%= Resources.Resource.cruzamento %>..." />
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-primary" id="" onclick="FindControllersConj()"><%= Resources.Resource.buscar %></button>
                                                    </span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><%= Resources.Resource.cruzamento %> DNA:&nbsp;<span id="AddressConj"></span></td>
                                        </tr>
                                        <tr>
                                            <td id="tdConfirmConj" style="display: none;">
                                                <button id="btnSalvarConj" type="button" class="btn btn-success" onclick="confirmCadConj()"><%= Resources.Resource.confirmar %></button></td>
                                            <td>
                                                <button id="btnCancelConj" type="button" class="btn btn-danger" onclick="CancelarConj()"><%= Resources.Resource.cancelar %></button>
                                            </td>
                                        </tr>
                                    </table>
                                    <h5><%= Resources.Resource.controlador %> <%= Resources.Resource.conjugados %></h5>
                                    <table id="tblConj" class="table table-bordered" style="top: 10px;">
                                        <thead>
                                            <tr>
                                                <th>Id <%= Resources.Resource.cruzamento %></th>
                                                <th><%= Resources.Resource.cruzamento %></th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbConj"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" style="width: 120px;" onclick="saveEqp();"><%= Resources.Resource.salvar %></button>
                        <button type="button" class="btn btn-danger" style="width: 120px;" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                    </div>
                </div>
            </div>
        </div>

        <div id="popupCamera" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">
                            <img src="../../Images/Security-Camera-icon.png" style="width: 32px; height: 32px;" />
                            <span id="spatitleCamera"><%= Resources.Resource.cadastrar %> <%= Resources.Resource.camera %></span></h4>
                    </div>
                    <div class="modal-body">
                        <p>
                            Id <%= Resources.Resource.cruzamento %>: <span id="spaIdPontoCam"></span>
                        </p>
                        <p id="paragraphCadPonto" style="visibility: hidden;">
                            Id <%= Resources.Resource.cruzamento %>: 
                            <input type="text" id="txtIdPonto" onkeyup="passIdPonto(this.value)" class="form-control" placeholder="Id <%= Resources.Resource.cruzamento %>..." style="width: 300px; display: inline; margin-bottom: 5px; margin-left: 3px;" />
                        </p>
                        <p>
                            Serial - <%= Resources.Resource.moduloComunicacao %>:
                            <input type="text" id="txtSerialModuloComunicacao" class="form-control" placeholder="serial..." style="width: 170px; display: inline; margin-bottom: 5px; margin-left: 3px;" />
                        </p>
                        <p>
                            HostName/IP:
                            <input type="text" id="txtHostName" class="form-control" placeholder="HostName..." style="width: 300px; display: inline; margin-bottom: 5px; margin-left: 3px;" />
                        </p>
                        <p>
                            <%= Resources.Resource.usuario %>:
                            <input type="text" id="txtUsuarioCamera" placeholder="<%= Resources.Resource.usuario %>" class="form-control" style="width: 300px; margin-bottom: 5px; display: inline; margin-left: 20px;" />
                        </p>
                        <p>
                            <%= Resources.Resource.senha %>:
                            <input type="password" id="txtSenhaCamera" placeholder="<%= Resources.Resource.senha %>" class="form-control" style="width: 200px; margin-bottom: 5px; margin-left: 30px; display: inline;" />
                        </p>
                        <p>
                            <%= Resources.Resource.comunicacaoServico %>:
                            <input type="checkbox" id="chkServicoCamera" class="form-control" style="width: 20px; height: 20px; margin-bottom: 1px; margin-left: 3px; display: inline;" />
                        </p>
                    </div>
                    <div class="modal-footer">
                        <input id="btnCadCamera" type="button" class="btn btn-default" onclick="cadCamera('Habilitado');" value="<%= Resources.Resource.confirmar %>" />
                        <input id="btnExcluirCamera" type="button" class="btn btn-default" onclick="cadCamera('');" value="<%= Resources.Resource.excluir %>" />
                        <button type="button" class="btn btn-default" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="popupControladores" role="dialog" style="font-size: 0.9em;">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 130%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%= Resources.Resource.lista %> <%= Resources.Resource.controlador %></h4>
                    </div>
                    <div class="modal-body">
                        <table id="tblPesquisaContol" style="width: 100%; height: 40px; border-spacing: 1px; border-bottom: 1px solid #cccccc;">
                            <caption style="text-align: left; font-weight: bold;"><%= Resources.Resource.pesquisar %></caption>
                            <tr>
                                <td style="width: 120px;"><b><%= Resources.Resource.disponibilidade %>:</b></td>
                                <td style="width: 260px;">
                                    <select id="sleDisponibilidade" style="height: 30px; width: 250px;">
                                        <option value="0"><%= Resources.Resource.selecione %>...</option>
                                        <option value="Online">Online</option>
                                        <option value="Off-line">Off-line</option>
                                    </select>
                                </td>
                                <td>
                                    <img id="imgPesquisarControl" src="../../Images/search.png" onclick="PesquisaControl();"
                                        style="width: 31px; cursor: pointer; background-color: white; border-color: #ffffff; border: 1px solid #fff;" />
                                </td>
                            </tr>
                        </table>
                        <div id="divRelatorio" style="display: none; margin-top: 15px;">
                            <table style="border-bottom: 1px solid #cccccc; padding: 5px;">
                                <tr>
                                    <td>
                                        <input type="button" value="<%= Resources.Resource.imprimir %>" class="btn btn-default" id="btnImprimirHistoControl" />
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-default" onclick="$('#tblControladores').tableExport({type:'excel',escape:'false'});">Excel</button>
                                        <button type="button" class="btn btn-default" onclick="$('#tblControladores').tableExport({type:'pdf',escape:'false'});">PDF</button>
                                    </td>
                                    <td>
                                        <input type="button" value="<%= Resources.Resource.excluir %> <%= Resources.Resource.controlador %>" style="display: none" class="btn btn-default" onclick="ExcluirControladores()" id="btnExcluirControladores" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divControladores" style="margin-top: 15px; width: 100%;">
                            <div id="scrollControls" style="height: 350px; overflow-x: hidden; overflow-y: scroll; width: 100%; margin-top: 10px;">
                                <table id="tblControladores" class="tblgrid" style="padding: 5px;">
                                    <caption style="text-align: left; font-weight: bold;"><%= Resources.Resource.controlador %></caption>
                                    <thead style="margin-top: 10px;">
                                        <tr>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Serial <%= Resources.Resource.controlador %></th>
                                            <th style="width: 150px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Id <%= Resources.Resource.cruzamento %></th>
                                            <th style="width: 150px; border: 1px solid black; border-collapse: collapse; padding: 5px;"><%= Resources.Resource.habilitado %></th>
                                            <th style="width: 150px; border: 1px solid black; border-collapse: collapse; padding: 5px;">IP</th>
                                            <th style="width: 150px; border: 1px solid black; border-collapse: collapse; padding: 5px;"><%= Resources.Resource.ultimaAtualizacao %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbControladores"></tbody>
                                </table>
                            </div>
                            <span id="spaInfoControl" style="color: red; display: none;"><%= Resources.Resource.naoHaRegistros %></span>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                    </div>
                </div>
            </div>
        </div>

        <div id="popupChip" class="modal fade" role="dialog" style="font-size: 0.8em;">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 700px;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">
                            <img src="../../Images/chip.png" style="width: 32px; height: 32px;" alt="" />
                            <%= Resources.Resource.cadastro %> Chip</h4>
                    </div>
                    <div class="modal-body">
                        <div id="divChipInfo">
                            <p>
                                Id <%= Resources.Resource.cruzamento %>: <span id="spaIdPontoChip"></span>
                            </p>
                            <p>
                                <%= Resources.Resource.informacao %> <%= Resources.Resource.consorcio %>?
                                <%= Resources.Resource.sim %><input id="rdoYesConcorcio" type="radio" name="consorcio" onclick="infoConsorcio('Sim');" />
                                <%= Resources.Resource.nao %><input id="rdoNoConsorcio" type="radio" name="consorcio" checked="checked" onclick="infoConsorcio('Nao');" />
                            </p>
                            <div id="divInfoConsorcioChip" style="display: none;">
                                <p>
                                    <%= Resources.Resource.consorcio %>: 
                                    <select id="sleConsorcio" class="form-control" onchange="getBusinesses();" style="width: 300px; margin-bottom: 5px; margin-left: 20px; height: 30px; display: inline;">
                                        <option value="0"><%= Resources.Resource.selecione %>...</option>
                                        <option value="1">CONSORCIO SINAL PAULISTANO</option>
                                        <option value="2">CONSORCIO ONDAVERDE</option>
                                        <option value="3">CONSORCIO MCS</option>
                                        <option value="4">CONSORCIO SEMAFORICO PAULISTANO</option>
                                    </select>
                                </p>
                                <p>
                                    <%= Resources.Resource.empresa %>: 
                                    <select id="sleEmpChip" class="form-control" style="width: 300px; margin-bottom: 5px; margin-left: 28px; height: 30px; display: inline;">
                                    </select>
                                </p>
                                <p>
                                    <%= Resources.Resource.empresa %> Inst. : 
                                    <select id="sleEmpInstaChip" class="form-control" style="width: 300px; margin-bottom: 5px; height: 30px; display: inline;">
                                    </select>
                                </p>
                            </div>
                            <div id="divEmpChip" style="">
                                <p>
                                    <%= Resources.Resource.empresa %>: 
                                <input id="txtEmpChip" class="form-control" type="text" placeholder="<%= Resources.Resource.empresa %>..." style="width: 300px; display: inline; margin-left: 27px; text-transform: uppercase;" />
                                </p>
                                <p>
                                    <%= Resources.Resource.empresa %> Inst. : 
                                <input id="txtEmpInstaChip" class="form-control" type="text" placeholder="<%= Resources.Resource.empresa %>..." style="width: 300px; display: inline; text-transform: uppercase;" />
                                </p>
                            </div>
                            <p style="margin-top: 10px;">
                                <%= Resources.Resource.operadora %>: 
                                <select id="sleOperadoraChip" class="form-control" style="width: 150px; display: inline; height: 30px; margin-bottom: 5px; margin-left: 18px;">
                                    <option></option>
                                    <option>CLARO</option>
                                    <option>VIVO</option>
                                    <option>TIM</option>
                                    <option>OI</option>
                                </select>
                                ICCID:
                                <input type="text" id="txtHexaChip" placeholder="Hexa do Chip..." class="form-control" style="width: 150px; margin-bottom: 5px; text-transform: uppercase; display: inline;" />
                            </p>
                            <p>
                                Nº Chip:
                                <input type="text" id="txtNumeroChip" placeholder="Nº Chip..." class="form-control" style="width: 150px; margin-bottom: 5px; margin-left: 30px; display: inline;" />
                                <%= Resources.Resource.plano %>:
                                <input type="text" id="txtPlanoChip" placeholder="<%= Resources.Resource.plano %> Chip..." class="form-control" style="width: 150px; margin-left: 5px; text-transform: uppercase; display: inline;" />
                            </p>
                            <p style="border-bottom: 1px solid #d8d8d8;">
                                <%= Resources.Resource.empresa %>:
                                <%= Resources.Resource.controlador %>: 
                                <input type="radio" name="tipoChip" checked="checked" id="rdoControlChip" />
                                Nobreak: 
                                <input type="radio" name="tipoChip" id="rdoNobreakChip" />
                                <input id="hfIdChip" type="hidden" />
                                <input id="hfComandChip" type="hidden" />
                            </p>
                            <p style="margin-left: 1px; border-bottom: 1px solid #d8d8d8;">
                                <a id="lkbSalvarChip" onclick="salvarChip();" style="cursor: pointer;"><%= Resources.Resource.confirmar %></a>
                                <a id="lkbCancelChip" onclick="cancelChip();" style="cursor: pointer;"><%= Resources.Resource.cancelar %></a>
                            </p>
                            <div id="divListaChip" style="overflow-y: scroll; height: 200px;">
                                <table id="tblChip" class="tblgrid" style="width: 90%; background-color: #ffffff; margin-bottom: 15px; margin-left: 5px;">
                                    <caption><%= Resources.Resource.lista %> Chips</caption>
                                    <thead style="margin-top: 10px;">
                                        <tr>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;"><%= Resources.Resource.consorcio %></th>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;"><%= Resources.Resource.empresa %></th>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;"><%= Resources.Resource.empresa %> Inst.</th>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;"><%= Resources.Resource.operadora %></th>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">ICCID</th>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Nº</th>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;"><%= Resources.Resource.plano %></th>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;"><%= Resources.Resource.tipo %></th>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                            <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbChip"></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                    </div>
                </div>
            </div>
        </div>
        <%--<asp:Button ID="btnUpload" Style="display: none;" OnClick="btnUpload_Click" UseSubmitBehavior="false" runat="server" Text="Button" />--%>

        <div id="popupVisualCamera" class="modal fade" role="dialog" style="font-size: 0.8em;">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 700px;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%= Resources.Resource.visualizar %> <%= Resources.Resource.camera %></h4>
                    </div>
                    <div class="modal-body">
                        <input type="text" id="txtsearchCamera" onkeyup="searchCamera()" class="form-control" placeholder="<%= Resources.Resource.buscar %> <%= Resources.Resource.camera %>.." />

                        <table id="tblCamera" class="tblgrid" style="width: 90%; background-color: #ffffff; margin-bottom: 15px; margin-left: 5px;">
                            <thead>
                                <tr>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">HostName</th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Id <%= Resources.Resource.cruzamento %></th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;"><%= Resources.Resource.usuario %></th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                </tr>
                            </thead>
                            <tbody id="tbCamera"></tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <script src="jquery.ui.addresspicker.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBYQJ8OSMm1XQcb2h8lla6IbG2rNeKtQ9Q" type="text/javascript"></script>
    <script src="fileinput.js"></script>
    <script src="CadEqp.js"></script>
</asp:Content>
