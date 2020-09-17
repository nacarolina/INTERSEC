<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Register.Materiais.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <%--<script src="../../Scripts/jquery-1.8.2.min.js"></script>--%>
    <%--<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />--%>
    <%--<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/css/bootstrap-datepicker.css" />
    <link href="bootstrap-fileinput-master/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link href="lightbox2/dist/css/lightbox.min.css" rel="stylesheet" />
    <link href="clockpicker/bootstrap-clockpicker.css" rel="stylesheet" />
    <meta content="*" http-equiv="Access-Control-Allow-Origin" />--%>

    <style type="text/css">
        .tblgrid table {
            width: 80%;
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

        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            /* prevent horizontal scrollbar */
            overflow-x: hidden;
            width: 350px;
            margin-top: 236px;
            margin-left: 148px;
        }

        .autocomplete_endereco {
            max-height: 100px;
            overflow-y: auto;
            /* prevent horizontal scrollbar */
            overflow-x: hidden;
            width: 500px;
            margin-top: 263px;
            margin-left: 148px;
        }

        * html .ui-autocomplete {
            height: 100px;
            top: 215px;
            left: 148px;
        }

        .gallery {
            margin-top: 100px;
        }

        .gallery-item {
            margin-bottom: 30px;
        }

        .modal-footer {
            text-align: center;
        }

        .pagination {
            margin: 0;
        }



        .image-gallery-v2 {
            position: relative;
            z-index: 1;
            text-align: center;
            overflow: hidden;
            transition-duration: 400ms;
            transition-property: all;
            transition-timing-function: cubic-bezier(0.7, 1, 0.7, 1);
        }

            .image-gallery-v2 .image-gallery-v2-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(70, 70, 70, 0.61);
                opacity: 0;
                content: " ";
                transition-duration: 400ms;
                transition-property: all;
                transition-timing-function: cubic-bezier(0.7, 1, 0.7, 1);
            }

            .image-gallery-v2 .image-gallery-v2-overlay-content {
                position: absolute;
                top: 50%;
                left: 0;
                right: 0;
                padding: 20px;
                -webkit-transform: translate3d(0, -50%, 0);
                -moz-transform: translate3d(0, -50%, 0);
                transform: translate3d(0, -50%, 0);
            }

            .image-gallery-v2:hover {
                transition-duration: 400ms;
                transition-property: all;
                transition-timing-function: cubic-bezier(0.7, 1, 0.7, 1);
            }

                .image-gallery-v2:hover .image-gallery-v2-overlay {
                    opacity: 1;
                    transition-duration: 400ms;
                    transition-property: all;
                    transition-timing-function: cubic-bezier(0.7, 1, 0.7, 1);
                }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField runat="server" ID="hfIdSub" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfIdPrefeitura" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfIdLocal" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfEndereco" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfSubMestre" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfIdSubMov" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfIdPatMov" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfIdDepartamento" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfIdDna" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfIdOcorrencia" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfIdDnaGSS" ClientIDMode="Static" />

    <div id="divLoad" style="width: 100%; height: 100%; position: absolute; z-index: 1; display: none; opacity: 0.2; background-color: #d8d8d8;">
        <p style="top: 20%; left: 40%; position: absolute;">
            <img src="../Images/load.GIF" id="imgLoad" alt="Carregando" />
        </p>
    </div>
    <table style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 1000px; border-color: transparent; height: 100px;">
        <tr>
            <td style="margin-left: 100px;">&nbsp; <strong>Id do Local:</strong></td>
            <td style="margin-right: 1000px;" class="auto-style1">
                <input type="text" class="form-control" placeholder="Informe o Id do Local..." id="txtIdLocal" onkeyup="GetIdDNA()" style="width: 500px" /></td>
            <td>
                <img style="height: 28px; width: 28px; background-color: transparent; border-color: transparent;" src="../Images/search.png"
                    onclick="FindDNA()" /></td>
        </tr>
        <tr>
            <td style="width: 100px;">&nbsp; <strong>Endereço: </strong></td>
            <td style="width: 500px;">
                <input type="text" placeholder="Digite o Endereço..." class="form-control" onkeyup="GetEndereco()" style="width: 500px" id="txtEndereco" /></td>
        </tr>
    </table>

    <div id="divMateriais" class="container" style="margin-top: 15px; margin-left: 0px; display: none;">

        <br />
        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#collapse1">Visualizar detalhes do DNA</a>
                    </h4>
                </div>
                <div id="collapse1" class="panel-collapse collapse">
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <tr>
                                <td style="width: 182px;">Engº Responsável:</td>
                                <td>
                                    <input type="text" id="txtEngResponsavel" class="form-control" />
                                </td>
                            </tr>
                            <tr>
                                <td>Registro CREA:
                                </td>
                                <td>
                                    <input type="text" id="txtRegistroCREA" class="form-control" />
                                </td>
                            </tr>
                            <tr>
                                <td>Responsável pela Vistoria:
                                </td>
                                <td>
                                    <input type="text" id="txtRespVistoria" class="form-control" />
                                </td>
                            </tr>
                            <tr>
                                <td>Registro:
                                </td>
                                <td>
                                    <input type="text" id="txtRegistroCET" class="form-control" />
                                </td>
                            </tr>
                            <tr>
                                <td>Data de Deflagração:
                                </td>
                                <td>
                                    <input type="text" id="txtDtDeflagracao" class="datepicker" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="panel-footer">
                        <input type="button" id="btnSalvarDetalhesDNA" style="width: 180px;" value="Salvar" class="btn btn-default" onclick="SalvarDetalhesDNA()" />
                    </div>
                </div>
            </div>
        </div>
        <br />
        <h3><a href="#" style='cursor: pointer; color: black;' id="IdRedirectGSS" onclick="redirectGSS()"></a></h3>

        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#Controlador">Controlador</a></li>
            <li><a data-toggle="tab" href="#Nobreak">Nobreak</a></li>
            <li><a data-toggle="tab" href="#Coluna">Coluna</a></li>
            <li><a data-toggle="tab" href="#Cabos">Cabos</a></li>
            <li><a data-toggle="tab" href="#GrupoFocal">Grupo Focal</a></li>
            <li><a data-toggle="tab" href="#SistemaIluminacao">Sistema de Iluminação</a></li>
            <li><a data-toggle="tab" href="#Acessorios">Acessórios</a></li>
            <li><a data-toggle="tab" href="#Etiquetas">Etiquetas</a></li>
            <li><a data-toggle="tab" href="#ImagemCruzamento">Imagens</a></li>
            <li><a data-toggle="tab" href="#ProjetoCruzamento">Projetos</a></li>
            <li><a data-toggle="tab" href="#ArquivoCruzamento">Arquivos</a></li>
        </ul>

        <div class="tab-content" style="margin-left: -30px;">

            <div id="Controlador" class="tab-pane fade in active">
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">

                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn2.iconfinder.com/data/icons/thesquid-ink-40-free-flat-icon-pack/64/traffic-light-128.png" />&nbsp;<a data-toggle="collapse" href="#collapseDadoCtrl">Dados do controlador</a>
                                    </h4>
                                </div>
                                <div id="collapseDadoCtrl" class="panel-collapse collapse in">
                                    <div id="divAdcCtrl" style="padding-left: 10px; padding-bottom: 4px; padding-top: 4px;">
                                        <a id="lnkAdcControlador" onclick="AdcOptionCadCtrl()">Adicionar Controlador</a>
                                    </div>
                                    <div id="pnlAdcCtrl" style="display: none;">
                                        <table style="margin-left: 6px;">
                                            <tr>
                                                <td>
                                                    <a id="lnkCancelarCtrl" onclick="CancelarCtrl()">Voltar</a></td>
                                            </tr>
                                            <tr style="width: 60px;">
                                                <td>
                                                    <input id="btnAdcControlador" type="button" class="btn btn-default" onclick="AdcControladorImplantacao()" value="Por Implantação" style="width: 180px;" /></td>
                                                <td>
                                                    <input id="btnAdcCtrlMov" type="button" class="btn btn-default" value="Por Movimentação" title="Controlador" style="width: 180px;" data-toggle="modal" data-target="#modalMov" onclick="modalMovimentacao(this)" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="pnlCtrlDados" style="margin-bottom: 8px;">
                                        <table style="width: 100%; margin-left: 4px;">
                                            <tr>
                                                <td>
                                                    <table id="tblMestreIsol" style="width: 80%">
                                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                            <td><strong>Forma Operacional: </strong>
                                                                <label id="lblFormaOperacionalCtrl"></label>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                            <td><strong>Nº Patrimonio: </strong>
                                                                <label id="lblNmrPatCtrl"></label>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                            <td><strong>Modelo: </strong>
                                                                <label id="lblModeloCtrl"></label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="tblConjugado" style="width: 80%; display: none;">
                                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                            <td><strong>Mestre: </strong>
                                                                <label id="lblMestre"></label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <table style="margin-left: 8px;">
                                            <tr>
                                                <td>
                                                    <a id="lnkDetalhesCtrl" onclick="DetalhesCtrl()" style="font-size: inherit;">Detalhes do Controlador</a>
                                                    &nbsp;&nbsp;&nbsp;<a id="lnkCtrlManutencao" title="Controlador" style="cursor: pointer;" onclick="MovimentarManutencao(this)">Manutenção</a></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <table id="tblformaoperacional" style="margin-top: 4px; margin-left: 10px; display: none;">
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td>
                                                <a id="lnkVoltarCadCtrl" onclick="CancelarCtrl()">Voltar</a></td>

                                        </tr>
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td style="width: 300px;">Forma Operacional:</td>
                                            <td>
                                                <select id="ddlFormaOperacional" class="form-control" style="height: 32px; width: 190px;" onchange="ValorDrop(this)" disabled="disabled">
                                                    <option value="Selecione">Selecione</option>
                                                    <option value="MESTRE">MESTRE</option>
                                                    <option value="CONJUGADO">CONJUGADO</option>
                                                    <option value="ISOLADO">ISOLADO</option>
                                                </select></td>
                                        </tr>

                                    </table>
                                    <table id="tblSelSubMestre" style="margin-top: 4px; margin-left: 10px; display: none;">
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td style="width: 300px;">Id do Local do Controlador Mestre: </td>
                                            <td>
                                                <input type="text" id="txtIdLocalMestre" style="width: 300px" onkeyup="GetIdDNAMestre()" />
                                            </td>
                                        </tr>
                                    </table>

                                    <div id="pnlCtrlEditarDetalhes" style="display: none;">

                                        <table id="tblEditarDadosCtrl" style="margin-left: 10px;">

                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Nome Produto:</td>
                                                <td>
                                                    <input id="txtProduto" type="text" style="width: 420px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número Série:</td>
                                                <td>
                                                    <input id="txtNmrSerie" type="text" style="width: 150px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número Patrimonio:</td>
                                                <td>
                                                    <input id="txtNumPat" type="text" style="width: 150px;" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Tipo:</td>
                                                <td>
                                                    <input id="txtCtrlTipo" type="text" disabled="disabled" style="width: 150px;" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fabricante:</td>
                                                <td>
                                                    <input id="txtCtrlFabricante" type="text" style="width: 415px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Modelo:</td>
                                                <td>
                                                    <input id="txtCtrlModelo" type="text" style="width: 415px;" disabled="disabled" /><br />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fixação:</td>
                                                <td>
                                                    <select id="ddlCtrlFixacao" style="width: 200px;">
                                                        <option value="--Selecione a Fixação--">--Selecione a Fixação--</option>
                                                        <option value="BASE DE CONCRETO">BASE DE CONCRETO</option>
                                                        <option value="COLUNA BASE">COLUNA BASE</option>
                                                        <option value="COLUNA DE SEMAFORO">COLUNA DE SEMAFORO</option>
                                                    </select></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data da instalação:</td>
                                                <td>
                                                    <input id="txtCtrlDtInstalacao" type="text" class="datepicker" style="width: 150px;" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Garantia:</td>
                                                <td>
                                                    <input type="text" class="datepicker" id="txtCtrlDtGarantia" style="width: 150px" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td style="width: 300px;">Capacidade de fases suportadas:</td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 200px;">
                                                                <input type="number" value="1" min="1" max="50000" class="form-control" id="txtCapSuportada" style="width: 150px" />
                                                            </td>

                                                            <td style="width: 200px;">Capacidade de fases instaladas:</td>
                                                            <td>
                                                                <input type="number" value="1" min="1" max="50000" class="form-control" id="txtCtrlCapacidadeFaseInst" style="width: 150px" /></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Tensão de entrada:</td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 200px;">
                                                                <select id="ddlCtrlTensaoIn" class="form-control" style="width: 150px">
                                                                    <option>220V</option>
                                                                    <option>110V</option>
                                                                    <option>FULL RANGE</option>
                                                                </select></td>
                                                            <td style="width: 200px;">Tensão de saída:</td>
                                                            <td>
                                                                <select id="ddlCtrlTensaoOut" class="form-control" style="width: 150px">
                                                                    <option>220V</option>
                                                                    <option>110V</option>
                                                                    <option>FULL RANGE</option>
                                                                </select></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Estado operacional:</td>
                                                <td>
                                                    <select id="ddlEstadoOperacional" class="form-control" style="width: 200px">
                                                        <option>ATIVO</option>
                                                        <option>INATIVO</option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table id="dvBtnCtrl" style="font-size: x-small; width: 50%; margin-left: 10px; height: 60px;">
                                            <tr>
                                                <td>
                                                    <input id="btnCtrlSave" type="button" class="btn btn-default" style="width: 180px; height: 32px;" onclick="CtrlSave(this.value)" value="Salvar" /></td>
                                                <td>
                                                    <input id="btnApagarControlador" type="button" class="btn btn-default" onclick="ApagarControlador()" value="Excluir" style="width: 180px; height: 32px;" /></td>
                                                <td>
                                                    <input id="btnCancelarCtrl" type="button" style="width: 180px; height: 32px;" onclick="CancelarCtrl()" class="btn btn-default" value="Cancelar" /></td>
                                            </tr>
                                        </table>

                                        <br />
                                    </div>
                                    <div id="pnlAdcCtrlImplantacao" style="display: none;">
                                        <div style="margin-bottom: 4px; margin-left: 4px;"><a style="font-size: 14px;">Selecione o Controlador que deseja utilizar:</a> </div>
                                        <table id="tblProdCtr" class="tblgrid" style="margin-bottom: 15px; margin-left: 5px; width: 470px; border-collapse: collapse;">
                                            <thead id="thProdCtr" style="margin-top: 10px;">
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>

                                            </thead>
                                            <tbody id="tbProdCtr"></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="divCtrlConj" class="container" style="display: none;">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#Div1">Controladores conjugados</a>
                                    </h4>
                                </div>
                                <div id="Div1" class="panel-collapse collapse in">

                                    <div id="div2" style="margin-left: 10px; border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; padding: 5px; width: 800px; border-color: #f4f4f4; margin-top: 5px; margin-left: 10px;">
                                        <table id="tblConjugados" class="tblgrid" style="margin-bottom: 15px; margin-left: 5px; width: 470px; border-collapse: collapse;">
                                            <thead id="ThConj" style="margin-top: 10px;">
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Id do Local</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Endereço</th>
                                                </tr>

                                            </thead>
                                            <tbody id="tbConjugados"></tbody>
                                            <tfoot id="TfConjugados" style="display: none;">
                                                <tr>
                                                    <td>Este local não tem nenhum conjugado!
                                                    </td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="divPlacaCtrl" class="container" style="display: none;">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn3.iconfinder.com/data/icons/misc-vol-2/512/car_license_plate-128.png" />&nbsp; <a data-toggle="collapse" href="#conteudoPlacas">Placas do controlador</a>
                                    </h4>
                                </div>
                                <div id="conteudoPlacas" class="panel-collapse collapse in">
                                    <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                        <tr>
                                            <td>
                                                <a id="lnkNovaPlaca" style="cursor: pointer;" onclick="NovaPlaca()">Nova Placa</a></td>
                                        </tr>
                                    </table>
                                    <div id="pnlPlaca" style="margin-bottom: 8px;">
                                        <div id="pnlAdcPlaca" style="display: none;">
                                            <table style="margin-left: 8px;">
                                                <tr>
                                                    <td>
                                                        <a id="lnkVoltarAddTipoPlaca" style="cursor: pointer;" onclick="CancelPlaca()">Voltar</a></td>
                                                </tr>
                                                <tr style="height: 60px;">
                                                    <td>
                                                        <input id="btnImplantacaoPlacaCtrl" type="button" class="btn btn-default" onclick="ImplantacaoPlacaCtrl()" value="Por Implantação" style="width: 180px;" /></td>
                                                    <td>
                                                        <input id="btnMovimentacaoPlacaCtrl" type="button" class="btn btn-default" data-toggle="modal" data-target="#modalMov" onclick="modalMovimentacao(this)" title="Placa" value="Por Movimentação" style="width: 180px;" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div id="pnlGrdPlacaCtrl" style="display: none;">
                                            <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                                <tr>
                                                    <td>
                                                        <a id="lnkCancelarPlacaCtrl" style="cursor: pointer;" onclick="CancelPlaca()">Voltar</a></td>
                                                </tr>
                                            </table>
                                            <div style="margin-bottom: 4px; margin-left: 4px;"><a style="font-size: 14px;">Selecione a Placa que deseja utilizar:</a></div>
                                            <table id="tblAdcPlaca" class="tblgrid" style="margin-bottom: 15px; margin-left: 5px; width: 470px; border-collapse: collapse;">
                                                <thead id="Thead2" style="margin-top: 10px;">
                                                    <tr>
                                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Placa</th>
                                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                    </tr>

                                                </thead>
                                                <tbody id="tbAdcPlaca"></tbody>
                                            </table>
                                        </div>
                                        <div id="dvGrdPlacas">
                                            <p style="margin-left: 5px; width: 80%; margin-bottom: 5px; margin-top: 10px;">Nº Patrimonio:</p>
                                            <div class="input-group" style="margin-bottom: 10px; margin-left: 5px; width: 80%; border-bottom: 1px solid #d4d4d4;">
                                                <input type="text" id="txtFindNPatPlaca" class="form-control" onkeyup="FindlistRows('3',this,'tblPlaca')" placeholder="Nº Patrimonio...">
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-search" onclick="FindlistRows('3',this,'tblPlaca')"></span>
                                                </span>
                                            </div>

                                            <table id="tblPlaca" class="tblgrid" style="margin-bottom: 15px; margin-left: 5px; width: 80%;">
                                                <thead id="Thead3" style="margin-top: 10px;">
                                                    <tr>
                                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Placa</th>
                                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Nº Patrimonio</th>
                                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                    </tr>

                                                </thead>
                                                <tbody id="tbPlaca"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div id="pnlPlacaDetalhe" style="display: none;">
                                        <div id="pnlQtdPlacaCtrl">
                                            <table style="margin-left: 10px;">
                                                <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                    <td style="width: 200px;">Quantidade: </td>
                                                    <td>
                                                        <input class="form-control" type="number" id="txtQtdPlacaCtrl" title="placa" min="1" max="50000" value="1" style="width: 172px" onchange="verificaQtd(this)" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <table style="margin-left: 10px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td style="width: 200px;">Número Patrimonio:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtNmrPatlaca" style="width: 180px" /></td>
                                                <td>
                                                    <input type="button" class="btn btn-default" id="btnAdcParamPlacaCtrl" title="placa" data-toggle="modal" data-target="#mpParametro" onclick="porParametro(this)" value="Adicionar por parametro" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fabricante:</td>
                                                <td>
                                                    <input id="txtFabricantePlaca" type="text" class="form-control" disabled="disabled" style="width: 180px;" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Modelo:</td>
                                                <td>
                                                    <input id="txtPlacaModelo" type="text" class="form-control" style="width: 400px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Instalação:</td>
                                                <td>
                                                    <input type="text" id="txtPlacaDtInstal" class="datepicker" style="width: 180px;" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Garantia:</td>
                                                <td>
                                                    <input type="text" id="txtPlacaDtGarantia" class="datepicker" style="width: 180px;" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Estado operacional:</td>
                                                <td>
                                                    <select id="ddlPlacaAtivo" class="form-control" style="width: 190px;">
                                                        <option value="ATIVO">ATIVO</option>
                                                        <option value="INATIVO">INATIVO</option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table style="font-size: x-small; width: 50%; margin-left: 10px; margin-bottom: 8px;">
                                            <tr>
                                                <td>
                                                    <input id="btnPlacaSave" type="button" style="height: 32px; width: 180px;" onclick="PlacaSave(this.value)" value="Salvar" class="btn btn-default" /></td>
                                                <td>
                                                    <input id="btnApagarPlaca" type="button" class="btn btn-default" style="height: 32px; width: 180px;" onclick="ApagarPlaca()" value="Excluir" /></td>
                                                <td>
                                                    <input type="button" id="btnCancelPlaca" class="btn btn-default" style="height: 32px; width: 180px;" onclick="CancelPlaca()" value="Cancelar" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="divGprsCtrl" class="container" style="display: none;">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn2.iconfinder.com/data/icons/pittogrammi/142/04-128.png" />&nbsp; <a data-toggle="collapse" href="#conteudoGPRS">GPRS do controlador</a>
                                    </h4>
                                </div>
                                <div id="conteudoGPRS" class="panel-collapse collapse in">
                                    <table id="tblNewGprs" style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                        <tr>
                                            <td>
                                                <a id="lnkNovoGprs" style="cursor: pointer" onclick="NovoGprs()">Novo Gprs</a></td>
                                        </tr>
                                    </table>
                                    <div id="pnlAdcGprsCtrl" style="display: none;">
                                        <table style="margin-left: 8px;">
                                            <tr>
                                                <td>
                                                    <a id="lnkVoltarAdcGprsCtrl" onclick="CancelGprs()">Voltar</a></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnPorImplantacaoGPRSctrl" onclick="PorImplantacaoGPRSctrl()" value="Por Implantação" style="width: 180px;" /></td>
                                                <td>
                                                    <input id="btnPorMovimentacaoGPRSctrl" type="button" class="btn btn-default" data-toggle="modal" data-target="#modalMov" onclick="modalMovimentacao(this)" title="GPRS Controlador" value="Por Movimentação" style="width: 180px;" /></td>
                                            </tr>
                                        </table>
                                    </div>

                                    <div id="pnlSelGprs" style="display: none;">
                                        <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                            <tr>
                                                <td>
                                                    <a id="lnkCancelarGprsCtrl" onclick="CancelGprs()">Voltar</a></td>
                                            </tr>
                                        </table>
                                        <div style="margin-bottom: 4px; margin-left: 4px;"><a style="font-size: 14px;">Selecione o GPRS que deseja utilizar:</a> </div>

                                        <table id="tblAdcGprs" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="bdAdcGprs"></tbody>
                                        </table>
                                    </div>

                                    <div id="pnlDadosGprsCtrl" style="display: none;">
                                        <table style="margin-left: 4px; margin-bottom: 8px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td><strong>Nº Patrimonio: </strong>
                                                    <label id="lblNmrPatGprsCtrl"></label>
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td><strong>Modelo: </strong>
                                                    <label id="lblModeloGprsCtrl"></label>
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td><strong>Nº da Linha: </strong>
                                                    <label id="lblNmrLinhaGprsCtrl"></label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-top: 4px;">
                                                    <a id="lnkDetalhesGprsCtrl" onclick="DetalhesGprsCtrl(this)" style="font-size: inherit; cursor: pointer;">Detalhes</a>
                                                    &nbsp;&nbsp;&nbsp;<a id="linkGprsCtrlManutencao" title="Gprs" style="cursor: pointer;" onclick="MovimentarManutencao(this)">Manutenção</a></td>
                                            </tr>
                                        </table>
                                    </div>

                                    <div id="pnlEditarGprsCtrl" style="display: none;">
                                        <table style="margin-left: 10px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número Patrimonio:</td>
                                                <td>
                                                    <input type="text" id="txtGprsNumPat" class="form-control" style="width: 200px;" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número de Série:</td>
                                                <td>
                                                    <input type="text" id="txtGprsNumSerie" class="form-control" style="width: 200px" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fabricante:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtGprsFab" style="width: 200px" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Modelo:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtGprsModelo" style="width: 200px" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Nº da linha:</td>
                                                <td>
                                                    <input type="tel" class="form-control" id="txtGprsNrLinha" style="width: 200px" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Operadora:</td>
                                                <td>
                                                    <select id="ddlGprsOperadora" class="form-control" style="width: 200px;">
                                                        <option></option>
                                                        <option>CLARO</option>
                                                        <option>TIM</option>
                                                        <option>OI</option>
                                                        <option>VIVO</option>
                                                    </select></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Instalação:</td>
                                                <td>
                                                    <input type="text" class="datepicker" id="txtGprsDtInstalacao" style="width: 200px" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Garantia:</td>
                                                <td>
                                                    <input type="text" class="datepicker" id="txtGprsDtGarantia" style="width: 200px" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Estado operacional:</td>
                                                <td>
                                                    <select id="ddlGprsEstadoOperacional" class="form-control" style="width: 200px;">
                                                        <option>ATIVO</option>
                                                        <option>INATIVO</option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table style="margin-left: 10px; margin-bottom: 8px; width: 50%;">
                                            <tr>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnSalvarGpsC" style="height: 32px; width: 180px;" onclick="SalvarGprsC(this.value)" value="Salvar" /></td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnApagarGprsControl" onclick="ApagarGprsControl()" value="Excluir" style="height: 32px; width: 180px;" /></td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnCancelGprs" style="height: 32px; width: 180px;" onclick="CancelGprs()" value="Cancelar" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div id="Nobreak" class="tab-pane fade">
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn4.iconfinder.com/data/icons/energy-and-power-1-4/128/5-128.png" />&nbsp; <a data-toggle="collapse" href="#conteudoNobreakDados">Dados do Nobreak</a>
                                    </h4>
                                </div>
                                <div id="conteudoNobreakDados" class="panel-collapse collapse in">
                                    <table id="adcNbrk" style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td>
                                                <a id="lnkAdcNobreak" style="cursor: pointer;" onclick="AdcNobreak()">Adicionar Nobreak</a>
                                            </td>
                                        </tr>
                                    </table>

                                    <div id="pnlDetailsNbr" style="padding-left: 10px;">
                                        <p style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <b>Nº Patrimonio:</b>
                                            <label id="lblnmrPatNbr"></label>
                                        </p>

                                        <p style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <b>Fabricante:</b>
                                            <label id="lblFabNbr"></label>
                                        </p>

                                        <p style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <b>Modelo:</b>
                                            <label id="lblModeloNbr"></label>
                                        </p>
                                        <p style="height: 60px; border-bottom: 1px solid #d8d8d8;">

                                            <a id="lnkDetailsNbr" style="cursor: pointer;" onclick="DetailsNbr()">Detalhes</a>
                                            &nbsp;&nbsp;&nbsp;<a id="lnkManutencaoNbr" style="cursor: pointer;" title="Nobreak" onclick="MovimentarManutencao(this)">Manutenção</a>
                                        </p>
                                    </div>

                                    <div id="pnlGrdAddNobreak">
                                        <table id="Table1" style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="A1" style="cursor: pointer;" onclick="CancelNbrk()">Voltar</a></td>
                                            </tr>
                                        </table>
                                        <div style="margin-bottom: 4px; margin-left: 4px;"><a style="font-size: 14px;">Selecione o Nobreak que deseja utilizar:</a> </div>

                                        <table id="tblAdcNobreak" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbAdcNobreak"></tbody>
                                        </table>
                                    </div>

                                    <div id="pnlCadastroNobreak">
                                        <table style="margin-left: 10px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número Patrimonio:</td>
                                                <td>
                                                    <input type="text" style="width: 160px;" class="form-control" id="txtNbkNumPat" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fabricante:</td>
                                                <td>
                                                    <input type="text" style="width: 160px;" class="form-control" id="txtNbkFabricante" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Modelo:</td>
                                                <td>
                                                    <input type="text" style="width: 160px;" class="form-control" id="txtNbkModelo" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data da Instalação:</td>
                                                <td>
                                                    <input type="text" style="width: 160px;" class="datepicker" id="txtNbkDataInstal" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Garantia:</td>
                                                <td>
                                                    <input type="text" style="width: 160px;" class="datepicker" id="txtNbkDataGarantia" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Autonomia:</td>
                                                <td>
                                                    <input type="text" style="width: 160px;" class="form-control" id="txtNbkAutonomia" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Potencia:</td>
                                                <td>
                                                    <input type="text" style="width: 160px;" class="form-control" id="txtNbkPotencia" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fixação:</td>
                                                <td>
                                                    <select id="ddlNbkFixacao" style="width: 170px; height: 30px; width: 200px;" class="form-control">
                                                        <option></option>
                                                        <option value="BASE DE CONCRETO">BASE DE CONCRETO</option>
                                                        <option value="COLUNA BASE">COLUNA BASE</option>
                                                    </select></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Estado Operacional:</td>
                                                <td>
                                                    <select id="ddlNbkAtivo" style="width: 100px; height: 30px; width: 200px;" class="form-control">
                                                        <option value="Selecione">Selecione</option>
                                                        <option value="ATIVO">ATIVO</option>
                                                        <option value="INATIVO">INATIVO</option>
                                                    </select></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Monitoração:</td>
                                                <td>
                                                    <select id="ddlNbkMonitoracao" style="width: 100px; height: 30px;" class="form-control">
                                                        <option>SIM</option>
                                                        <option>NAO</option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table style="font-size: x-small; width: 50%; padding-left: 10px;">
                                            <tr>
                                                <td>
                                                    <input id="btnEditNobreak" class="btn btn-default" type="button" style="width: 180px; height: 32px;" value="Salvar" onclick="EditNobreak(this.value)" /></td>
                                                <td>
                                                    <input id="btnApagarNobreak" class="btn btn-default" type="button" style="width: 180px; height: 32px;" value="Excluir" onclick="ApagarNobreak()" /></td>
                                                <td>
                                                    <input id="btnCancelNbrk" class="btn btn-default" type="button" style="width: 180px; height: 32px;" onclick="CancelNbrk()" value="Cancelar" /><br />
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>

                                    <div id="pnlAddNbk">
                                        <table id="voltarNbk" style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="lnkCancelarAddNbk" style="cursor: pointer;" onclick="CancelNbrk()">Voltar</a></td>
                                            </tr>
                                        </table>
                                        <table style="margin-left: 6px;">
                                            <tr style="height: 60px;">
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnImplantacaoNbk" style="width: 180px; height: 32px;" value="Por Implantação" onclick="ImplantacaoNbk()" /></td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnMovimentacaoNbk" style="width: 180px; height: 32px;" value="Por Movimentação" data-toggle="modal" data-target="#modalMov" onclick="modalMovimentacao(this)" title="Nobreak" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn2.iconfinder.com/data/icons/pittogrammi/142/04-128.png" />&nbsp; <a data-toggle="collapse" href="#conteudoGPRSDados">GPRS do Nobreak</a>
                                    </h4>
                                </div>
                                <div id="conteudoGPRSDados" class="panel-collapse collapse in">
                                    <table id="adcGprs" style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td>
                                                <a id="lnkAdcGPRSnbk" onclick="AdcGPRSnbk()" style="cursor: pointer;">Adicionar GPRS</a>
                                            </td>
                                        </tr>
                                    </table>

                                    <div id="pnlAddGprsNbk">
                                        <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="A2" style="cursor: pointer" onclick="CancelGprsNbk()">Voltar</a></td>
                                            </tr>
                                        </table>
                                        <table style="margin-left: 6px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <input id="btnImplantacaoGprsNbk" class="btn btn-default" type="button" style="width: 180px; height: 32px;" value="Por Implantação" onclick="ImplantacaoGprsNbk()" /></td>
                                                <td>
                                                    <input id="btnMovimentacaoGprsNbk" class="btn btn-default" type="button" style="width: 180px; height: 32px;" value="Por Movimentação" title="Gprs Nobreak" data-toggle="modal" data-target="#modalMov" onclick="modalMovimentacao(this)" /></td>
                                            </tr>
                                        </table>
                                    </div>

                                    <div id="pnlDetailsGprs">
                                        <p style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <b>Nº Patrimonio:</b>
                                            <label id="lblnrpatGprs"></label>
                                        </p>

                                        <p style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <b>Fabricante:</b>
                                            <label id="lblFabricanteGprs"></label>
                                        </p>

                                        <p style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <b>Modelo:</b>
                                            <label id="lblModelGprs"></label>
                                        </p>
                                        <p style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <a id="lnkGprs" style="cursor: pointer;" onclick="Gprs()">Detalhes</a>
                                            &nbsp;&nbsp;&nbsp;<a id="lnkGprsMovimentar" style="cursor: pointer;" title="Gprs" onclick="MovimentarManutencao(this)">Manutenção</a>
                                        </p>
                                    </div>

                                    <div id="pnlGrdAdcGprsNbk">
                                        <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="CancelarAddGprs" style="cursor: pointer" onclick="CancelGprsNbk()">Voltar</a></td>
                                            </tr>
                                        </table>
                                        <div style="margin-bottom: 4px; margin-left: 4px;"><a style="font-size: 14px;">Selecione o GPRS que deseja utilizar:</a> </div>

                                        <table id="tblAdcGPRSNbk" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbAdcGPRSNbk"></tbody>
                                        </table>

                                    </div>

                                    <div id="pnlDadosGPRSnbk">
                                        <table style="margin-left: 10px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número Patrimonio:</td>
                                                <td>
                                                    <input type="text" id="txtNmrPatGprsNbk" class="form-control" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número de Série:</td>
                                                <td>
                                                    <input type="text" id="txtNmrSerieGprsNbk" class="form-control" style="width: 200px" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fabricante:</td>
                                                <td>
                                                    <input type="text" id="txtFabricanteGprsNbk" class="form-control" style="width: 200px" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Modelo:</td>
                                                <td>
                                                    <input type="text" id="txtModeloGprsNbk" class="form-control" style="width: 200px" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Nº da linha:</td>
                                                <td>
                                                    <input type="tel" id="txtNmrLinhaGprsNbk" class="form-control" style="width: 200px" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Operadora:</td>
                                                <td>
                                                    <select id="ddlOperadoraGprsNbk" class="form-control" style="width: 200px">
                                                        <option></option>
                                                        <option>CLARO</option>
                                                        <option>TIM</option>
                                                        <option>OI</option>
                                                        <option>VIVO</option>
                                                    </select></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Instalação:</td>
                                                <td>
                                                    <input id="txtDtInstalGprsNbk" type="text" class="datepicker" style="width: 200px" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Garantia:</td>
                                                <td>
                                                    <input id="txtDtGarantiaGprsNbk" type="text" class="datepicker" style="width: 200px" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Estado operacional:</td>
                                                <td>
                                                    <select id="ddlEstadoOperacionalGprsNbk" class="form-control" style="width: 200px">
                                                        <option>ATIVO</option>
                                                        <option>INATIVO</option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table style="margin-left: 10px; width: 50%;">
                                            <tr>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnSalvarGprsNbk" onclick="SalvarGprsNbk(this.value)" value="Salvar" style="width: 180px; height: 32px;" /></td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnExcluirGprsNbk" value="Excluir" onclick="ExcluirGprsNbk()" style="width: 180px; height: 32px;" /></td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnCancelGprsNbk" value="Cancelar" onclick="CancelGprsNbk()" style="width: 180px; height: 32px;" /></td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="Coluna" class="tab-pane fade">
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn2.iconfinder.com/data/icons/road-signs-5/135/semaphore_sign-128.png" />&nbsp; <a data-toggle="collapse" href="#conteudoColuna">Lista de colunas</a>
                                    </h4>
                                </div>
                                <div id="conteudoColuna" class="panel-collapse collapse in">
                                    <table id="tbladcNewcols" style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td>
                                                <a id="lnkAdcColuna" style="cursor: pointer;" onclick="AdcColuna()">Adicionar Coluna</a></td>
                                        </tr>
                                    </table>
                                    <div id="pnlAdcColuna">
                                        <table style="margin-left: 6px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="lnkCancelarColuna" style="cursor: pointer;" onclick="CancelarColuna()">Voltar</a></td>
                                                <td></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnImplantacaoColuna" style="width: 180px; height: 32px;" value="Por Implantação" onclick="ImplantacaoColuna()" /></td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnMovimentacaoColuna" style="width: 180px; height: 32px;" value="Por Movimentação" title="Coluna" data-toggle="modal" data-target="#modalMov" onclick="modalMovimentacao(this)" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="pnlGrdAdcColuna">
                                        <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="lnkCancelarGrdColuna" onclick="CancelarColuna()" style="cursor: pointer;">Voltar</a></td>
                                            </tr>
                                        </table>
                                        <div style="margin-bottom: 4px; margin-left: 4px;"><a style="font-size: 14px;">Selecione a Coluna que deseja utilizar:</a> </div>

                                        <table id="tblAdcColuna" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>

                                                </tr>
                                            </thead>
                                            <tbody id="tbAdcColuna"></tbody>
                                        </table>
                                    </div>
                                    <div id="pnlDadosColuna">
                                        <div id="pnlQtdColuna">
                                            <table style="margin-left: 10px;">
                                                <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                    <td>Quantidade: </td>
                                                    <td>
                                                        <input type="number" class="form-control" id="txtQtdColuna" title="coluna" min="1" max="50000" style="width: 120px;" value="1" onchange="verificaQtd(this)" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <table style="margin-left: 10px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número Patrimonio:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtNumPatColuna" style="width: 280px;" />
                                                </td>
                                                <td>
                                                    <input id="btnPorParamColuna" class="btn btn-default" type="button" style="height: 32px; width: 180px;" title="coluna" data-toggle="modal" data-target="#mpParametro" onclick="porParametro(this)" value="Adicionar por parametro" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Nº de Série:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtNrSerieColuna" style="width: 280px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fabricante:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtFabricanteColuna" style="width: 280px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Modelo:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtModeloColuna" style="width: 280px;" disabled="disabled" /><br />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fixação:</td>
                                                <td>
                                                    <select class="form-control" id="ddlFixacaoColuna" style="width: 280px;">
                                                        <option></option>
                                                        <option>ENGASTADA</option>
                                                        <option>PARAFUSADA</option>
                                                    </select></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data da Instalação:</td>
                                                <td>
                                                    <input type="text" id="txtDtInstalacaoColuna" class="datepicker" style="width: 150px;" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Garantia:</td>
                                                <td>
                                                    <input type="text" class="datepicker" id="txtDtGarantiaColuna" style="width: 150px;" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Estado Operacional:</td>
                                                <td>
                                                    <select class="form-control" id="ddlEstadoOperacionalColuna" style="width: 150px;">
                                                        <option>ATIVO</option>
                                                        <option value="INATIVO">INATIVO</option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table style="font-size: x-small; width: 50%; margin-left: 10px;">
                                            <tr>
                                                <td>
                                                    <input style="height: 32px; width: 180px;" class="btn btn-default" type="button" id="btnAddColuna" value="Salvar" onclick="AddColuna(this.value)" /></td>
                                                <td>
                                                    <input style="height: 32px; width: 180px;" class="btn btn-default" type="button" id="btnApagarColuna" value="Excluir" onclick="ApagarColuna()" />
                                                </td>
                                                <td>
                                                    <input style="height: 32px; width: 180px;" class="btn btn-default" type="button" id="btnCancelarColuna" onclick="CancelarColuna()" value="Cancelar" /></td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>
                                    <div id="pnlColunas">
                                        <p style="margin-left: 5px; width: 80%; margin-bottom: 5px; margin-top: 10px;">Nº Patrimonio:</p>
                                        <div class="input-group" style="margin-bottom: 10px; margin-left: 5px; width: 50%; border-bottom: 1px solid #d4d4d4;">
                                            <input type="text" id="txtFindColumns" class="form-control" onkeyup="FindlistRows('3',this,'tblColunas')" placeholder="Nº Patrimonio...">
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-search" onclick="FindlistRows('3',this,'tblColunas')"></span>
                                            </span>
                                        </div>
                                        <table id="tblColunas" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Estado Operacional</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Nº Patrimonio</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbColunas"></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="Cabos" class="tab-pane fade">
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn4.iconfinder.com/data/icons/crime-and-security-1-5/512/48-128.png" />&nbsp; <a data-toggle="collapse" href="#conteudoCaboDados">Lista de cabos</a>
                                    </h4>
                                </div>
                                <div id="conteudoCaboDados" class="panel-collapse collapse in">
                                    <table id="tblAdcCabo" style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td>
                                                <a id="lnkAdcCabo" style="cursor: pointer;" onclick="AdcCabo()">Adicionar Cabo</a></td>
                                        </tr>
                                    </table>

                                    <div id="pnlAdcCabo">
                                        <table style="margin-left: 6px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="lnkCancelarCabo" style="cursor: pointer;" onclick="CancelarCabo()">Voltar</a></td>
                                                <td></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <input id="btnImplantacaoCabo" class="btn btn-default" type="button" value="Por Implantação" style="width: 180px; height: 32px;" onclick="ImplantacaoCabo()" /></td>
                                                <td>
                                                    <input id="btnMovimentacaoCabo" class="btn btn-default" type="button" value="Por Movimentação" style="width: 180px; height: 32px;" title="Cabo" data-toggle="modal" data-target="#modalMov" onclick="modalMovimentacao(this)" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="pnlGrdAdcCabo">

                                        <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="lnkCancelarGrdCabo" style="cursor: pointer;" onclick="CancelarCabo()">Voltar</a></td>
                                            </tr>
                                        </table>
                                        <div style="margin-bottom: 4px; margin-left: 4px;"><a style="font-size: 14px;">Selecione o Cabo que deseja utilizar:</a> </div>

                                        <table id="tblAdcCabos" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbAdcCabos"></tbody>
                                        </table>
                                    </div>
                                    <div id="pnlDadosCabo">
                                        <div id="pnlQtdCabo">
                                            <table style="margin-left: 10px;">
                                                <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                    <td>Quantidade: </td>
                                                    <td>
                                                        <input type="number" class="form-control" min="1" max="50000" id="txtQtdCabo" title="cabo" value="1" style="width: 240px;" onchange="verificaQtd(this)" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <table style="margin-left: 10px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número Patrimonio:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtNumPatCabo" style="width: 240px;" />

                                                </td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnPorParamCabo" style="height: 32px; width: 180px;" title="cabo" data-toggle="modal" data-target="#mpParametro" onclick="porParametro(this)" value="Adicionar por parametro" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Nº de Série:</td>
                                                <td>
                                                    <input type="number" class="form-control" style="width: 240px;" id="txtNmrSerieCabo" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fabricante:</td>
                                                <td>
                                                    <input type="text" class="form-control" style="width: 240px;" id="txtFabricanteCabos" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Modelo:</td>
                                                <td>
                                                    <input type="text" class="form-control" style="width: 240px;" id="txtModeloCabos" disabled="disabled" /><br />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Instalação:</td>
                                                <td>
                                                    <input type="text" class="datepicker" style="width: 240px;" id="txtDataInstalacaoCabos" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Garantia:</td>
                                                <td>
                                                    <input type="text" class="datepicker" style="width: 240px;" id="txtDataGarantiaCabos" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Tipo de Instalação:</td>
                                                <td>
                                                    <select class="form-control" id="ddlInstalacaoCabos" style="width: 240px; height: 28px;">
                                                        <option>MISTA</option>
                                                        <option>AEREA</option>
                                                        <option>SUBTERRANEA</option>
                                                    </select></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Meio de Instalação:</td>
                                                <td>
                                                    <select class="form-control" id="ddlMeioInstalacaoCabos" style="width: 240px; height: 28px;">
                                                        <option>SUPORTES COM ROLDANAS</option>
                                                        <option>CAIXA DE PASSAGEM</option>
                                                    </select></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Metros:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtMetrosCabos" style="width: 100px;" /><br />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Estado Operacional:</td>
                                                <td>
                                                    <select class="form-control" id="ddlEstadoOperacionalCabos" style="width: 111px; height: 28px;">
                                                        <option>ATIVO</option>
                                                        <option>INATIVO</option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table style="font-size: x-small; width: 50%; margin-left: 10px;">
                                            <tr>
                                                <td>
                                                    <input id="btnSalvarCabos" class="btn btn-default" type="button" style="width: 180px; height: 32px;" onclick="AddCabos(this.value)" value="Salvar" /></td>
                                                <td>
                                                    <input id="btnApagarCabos" class="btn btn-default" type="button" style="width: 180px; height: 32px;" onclick="ApagarCabos()" value="Excluir" /></td>
                                                <td>
                                                    <input id="btnCancelarCabo" class="btn btn-default" type="button" style="width: 180px; height: 32px;" onclick="CancelarCabo()" value="Cancelar" /></td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>

                                    <div id="pnlCabos">
                                        <p style="margin-left: 5px; width: 80%; margin-bottom: 5px; margin-top: 10px;">Nº Patrimonio:</p>
                                        <div class="input-group" style="margin-bottom: 10px; margin-left: 5px; width: 80%; border-bottom: 1px solid #d4d4d4;">
                                            <input type="text" id="txtFindCabos" class="form-control" onkeyup="FindlistRows('4',this,'tblCabos')" placeholder="Nº Patrimonio...">
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-search" onclick="FindlistRows('4',this,'tblCabos')"></span>
                                            </span>
                                        </div>
                                        <table id="tblCabos" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Metros</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Nº Patrimonio</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbCabos"></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="GrupoFocal" class="tab-pane fade">
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn3.iconfinder.com/data/icons/seo-web-1/128/seo-34-2-128.png" />&nbsp; <a data-toggle="collapse" href="#conteudoGrupoFocal">Lista de Grupo Focal</a>
                                    </h4>
                                </div>
                                <div id="conteudoGrupoFocal" class="panel-collapse collapse in">
                                    <table id="tblAdcGf" style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td>
                                                <a id="lnkAdcGrupoFocal" style="cursor: pointer;" onclick="AdcGrupoFocal()">Adicionar Grupo Focal</a></td>
                                        </tr>
                                    </table>
                                    <div id="pnlAdcGrupoFocal">
                                        <table style="margin-left: 6px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="lnkCancelarGrupoFocal" style="cursor: pointer;" onclick="CancelarGF()">Voltar</a></td>
                                                <td></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <input id="btnImplantacaoGF" class="btn btn-default" type="button" style="width: 180px; height: 32px;" value="Por Implantação" onclick="ImplantacaoGF()" /></td>
                                                <td>
                                                    <input id="btnMovimentacaoGF" class="btn btn-default" type="button" style="width: 180px; height: 32px;" value="Por Movimentação" title="Grupo Focal" data-toggle="modal" data-target="#modalMov" onclick="modalMovimentacao(this)" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="pnlGrdAdcGrupoFocal">
                                        <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="lnkCancelarGrdGrupoFocal" style="cursor: pointer;" onclick="CancelarGF()">Voltar</a></td>
                                            </tr>
                                        </table>
                                        <div style="margin-bottom: 4px; margin-left: 4px;"><a style="font-size: 14px;">Selecione o Grupo Focal que deseja utilizar:</a> </div>
                                        <table id="tblAdcGrupoFocal" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbAdcGrupoFocal"></tbody>
                                        </table>

                                    </div>
                                    <div id="pnlDadosGrupoFocal">
                                        <div id="pnlQtdGF">
                                            <table style="margin-left: 10px;">
                                                <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                    <td>Quantidade: </td>
                                                    <td>
                                                        <input type="number" min="1" max="50000" class="form-control" id="txtQtdGrupoFocal" title="gf" style="width: 178px;" value="1" onchange="verificaQtd(this)" />

                                                    </td>

                                                </tr>
                                            </table>
                                        </div>
                                        <table style="margin-left: 10px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número Patrimonio:</td>
                                                <td>
                                                    <input type="text" id="txtNumPatGF" class="form-control" style="width: 178px;" />
                                                </td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnPorParamGF" style="width: 180px; height: 32px;" value="Adicionar por parametro" title="Grupo Focal" data-toggle="modal" data-target="#mpParametro" onclick="porParametro(this)" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Nº de Série:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtNrSerieGrupoFocal" style="width: 178px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fabricante:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtFabricanteGrupoFocal" style="width: 178px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Modelo:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtModeloGrupoFocal" style="width: 178px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Instalação: </td>
                                                <td>
                                                    <input type="text" class="datepicker" id="txtDtInstalacaoGrupoFocal" style="width: 178px;" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Garantia:</td>
                                                <td>
                                                    <input type="text" class="datepicker" id="txtDtGarantiaGrupoFocal" style="width: 178px;" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Estado Operacional: </td>
                                                <td>
                                                    <select id="ddlEstadoOperacionalGrupoFocal" class="form-control" style="width: 178px;">
                                                        <option>ATIVO</option>
                                                        <option>INATIVO</option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table style="margin-left: 10px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <input id="btnEditGrupoFocal" style="width: 180px; height: 32px;" class="btn btn-default" type="button" onclick="EditGrupoFocal(this.value)" value="Salvar" /></td>
                                                <td>
                                                    <input id="btnApagarGrupoFocal" style="width: 180px; height: 32px;" class="btn btn-default" type="button" onclick="ApagarGrupoFocal()" value="Excluir" /></td>
                                                <td>
                                                    <input id="btnCancelarGF" style="width: 180px; height: 32px;" class="btn btn-default" type="button" onclick="CancelarGF()" value="Cancelar" /></td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>
                                    <div id="pnlGrupoFocal">
                                        <p style="margin-left: 5px; width: 80%; margin-bottom: 5px; margin-top: 10px;">Nº Patrimonio:</p>
                                        <div class="input-group" style="margin-bottom: 10px; margin-left: 5px; width: 80%; border-bottom: 1px solid #d4d4d4;">
                                            <input type="text" id="txtfindGrupoFocal" class="form-control" onkeyup="FindlistRows('4',this,'tblGrupoFocal')" placeholder="Nº Patrimonio...">
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-search" onclick="FindlistRows('4',this,'tblGrupoFocal')"></span>
                                            </span>
                                        </div>
                                        <table id="tblGrupoFocal" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Estado Operacional</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Nº Patrimonio</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbGrupoFocal"></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="SistemaIluminacao" class="tab-pane fade">
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn3.iconfinder.com/data/icons/real-estate-volume-3-1/48/122-128.png" />&nbsp;<a data-toggle="collapse" href="#conteudoSI">Sistema de iluminação</a>
                                    </h4>
                                </div>
                                <div id="conteudoSI" class="panel-collapse collapse in">
                                    <table id="tblAdcIlu" style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td>
                                                <a id="lnkAdcIluminacao" style="cursor: pointer;" onclick="AdcIluminacao()">Adicionar Sistema de Iluminação</a></td>
                                        </tr>
                                    </table>
                                    <div id="pnlAdcIluminacao">
                                        <table style="margin-left: 6px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="lnkCancelarIlu" style="cursor: pointer;" onclick="CancelSistemaIlu()">Voltar</a></td>
                                                <td></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <input class="btn btn-default" type="button" style="width: 180px; height: 32px;" id="btnImplantacaoIlu" value="Por Implantação" onclick="ImplantacaoIlu()" /></td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnMovimentacaoIlu" style="width: 180px; height: 32px;" value="Por Movimentação" title="Sistema de Iluminação" data-toggle="modal" data-target="#modalMov" onclick="modalMovimentacao(this)" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="pnlGrdAdcIluminacao">
                                        <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a id="lnkCancelarGrdAdcIlu" style="cursor: pointer;" onclick="CancelSistemaIlu()">Voltar</a></td>
                                            </tr>
                                        </table>
                                        <div style="margin-bottom: 4px; margin-left: 4px;"><a style="font-size: 14px;">Selecione o Sistema de Iluminação que deseja utilizar:</a> </div>
                                        <table id="tblAdcIluminacao" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbAdcIluminacao"></tbody>
                                        </table>
                                    </div>
                                    <div id="pnlDadosIlu">
                                        <div id="pnlQtdIlu">
                                            <table style="margin-left: 10px;">
                                                <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                    <td>Quantidade: </td>
                                                    <td>
                                                        <input type="number" min="1" max="50000" class="form-control" id="txtQtdIlum" title="iluminacao" style="width: 180px;" onchange="verificaQtd(this)" value="1" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <table style="margin-left: 10px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número Patrimonio:</td>
                                                <td>
                                                    <input type="text" id="txtNumPatSI" class="form-control" style="width: 180px;" />
                                                </td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnPorParamSI" style="width: 180px; height: 32px;" onclick="porParametro(this)" title="sistema de iluminação" data-toggle="modal" data-target="#mpParametro" value="Adicionar por parametro" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número de Série:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtIluNumeroSerie" style="width: 160px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fabricante:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtIluFabricante" style="width: 160px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Modelo:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtIluModelo" style="width: 160px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Instalação:</td>
                                                <td>
                                                    <input type="text" class="datepicker" id="txtIluDtInstalacao" style="width: 160px;" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data de Garantia:</td>
                                                <td>
                                                    <input type="text" class="datepicker" id="txtIluDtGarantia" style="width: 160px;" />
                                                </td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Tensão instalada:</td>
                                                <td>
                                                    <select id="ddlIluTensao" class="form-control" style="width: 190px;">
                                                        <option>220V/230V</option>
                                                        <option>127V/115V</option>
                                                    </select></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Estado Operacional:</td>
                                                <td>
                                                    <select id="ddlIluAtivo" class="form-control" style="width: 190px;">
                                                        <option value="ATIVO">ATIVO</option>
                                                        <option value="INATIVO">INATIVO</option>
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <table style="font-size: x-small; width: 50%; margin-left: 10px;">
                                            <tr>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnSalvarIlu" style="width: 180px; height: 32px;" value="Salvar" onclick="SalvarIlu(this.value)" /></td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnApagarSistemaIlu" style="width: 180px; height: 32px;" value="Excluir" onclick="ApagarSistemaIlu()" /></td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnCancelIlu" style="width: 180px; height: 32px;" value="Cancelar" onclick="CancelSistemaIlu()" /></td>

                                            </tr>

                                        </table>
                                        <br />
                                    </div>
                                    <div id="pnlIluminacao">
                                        <p style="margin-left: 5px; width: 80%; margin-bottom: 5px; margin-top: 10px;">Nº Patrimonio:</p>
                                        <div class="input-group" style="margin-bottom: 10px; margin-left: 5px; width: 80%; border-bottom: 1px solid #d4d4d4;">
                                            <input type="text" id="txtFindIluminacao" class="form-control" onkeyup="FindlistRows('4',this,'tblIluminacao')" placeholder="Nº Patrimonio...">
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-search" onclick="FindlistRows('4',this,'tblIluminacao')"></span>
                                            </span>
                                        </div>
                                        <table id="tblIluminacao" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Estado operacional</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Nº Patrimonio</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbIluminacao"></tbody>
                                        </table>
                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="Acessorios" class="tab-pane fade">
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn2.iconfinder.com/data/icons/illustricon-tech-vi/512/tablet_maintenance-128.png" />&nbsp; <a data-toggle="collapse" href="#conteudoAcessorio">Lista de Acessórios</a>
                                    </h4>
                                </div>
                                <div id="conteudoAcessorio" class="panel-collapse collapse in">
                                    <table id="tblNewAcess" style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td>
                                                <a style="cursor: pointer;" id="lnkAdcAcess" onclick="AdcAcess()">Adicionar Acessórios</a></td>
                                        </tr>
                                    </table>
                                    <div id="pnlAdcAcess">
                                        <table style="margin-left: 6px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a style="cursor: pointer;" id="lnkCancelarAcess" onclick="CancelAcess()">Voltar</a></td>
                                                <td></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <input id="btnImplantacaoAcess" class="btn btn-default" type="button" style="width: 180px; height: 32px;" value="Por Implantação" onclick="ImplantacaoAcess()" /></td>
                                                <td>
                                                    <input id="btnMovimentacaoAcess" class="btn btn-default" type="button" style="width: 180px; height: 32px;" value="Por Movimentação" title="Acessorio" data-toggle="modal" data-target="#modalMov" onclick="modalMovimentacao(this)" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="pnlGrdAdcAcess">
                                        <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>
                                                    <a style="cursor: pointer;" id="lnkCancelarGrdAdcAcess" onclick="CancelAcess()">Voltar</a></td>
                                            </tr>
                                        </table>
                                        <div style="margin-bottom: 4px; margin-left: 4px;"><a style="font-size: 14px;">Selecione o Acessorio que deseja utilizar:</a> </div>
                                        <table id="tblAdcAcessorios" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbAdcAcessorios"></tbody>
                                        </table>
                                    </div>
                                    <div id="pnlDadosAcessorio">
                                        <div id="pnlQtdAcess">
                                            <table style="margin-left: 10px;">
                                                <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                    <td>Quantidade: </td>
                                                    <td>
                                                        <input type="number" min="1" max="50000" class="form-control" id="txtQtdAcess" title="acessorio" style="width: 180px;" value="1" onchange="verificaQtd(this)" /></td>

                                                </tr>
                                            </table>
                                        </div>
                                        <table style="margin-left: 10px;">
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número Patrimonio:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtNumPatAcess" style="width: 180px;" />
                                                </td>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnPorParamAcess" style="width: 180px; height: 32px;" value="Adicionar por parametro" title="acessório" data-toggle="modal" data-target="#mpParametro" onclick="porParametro(this)" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Nome do Acessório:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtNomeAcessorio" style="width: 180px;" disabled="disabled" /></td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Número de Série:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtAcessNumSerie" style="width: 180px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Fabricante:</td>
                                                <td>
                                                    <input type="text" class="form-control" id="txtFabricanteAcess" style="width: 180px;" disabled="disabled" /></td>
                                            </tr>
                                            <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                <td>Data da Instalação:</td>
                                                <td>
                                                    <input type="text" class="datepicker" id="txtDataInstalAcess" style="width: 180px;" /></td>
                                            </tr>
                                        </table>
                                        <div id="pnlLuminaria">
                                            <table style="margin-left: 10px;">
                                                <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                                    <td>Fixação: </td>
                                                    <td>
                                                        <select class="form-control" id="cboLuminariaFixacao" style="width: 180px;">
                                                            <option>PROJETADA</option>
                                                            <option>COLUNA</option>
                                                        </select></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <br />
                                        <table style="font-size: x-small; width: 50%; margin-left: 10px;">
                                            <tr>
                                                <td>
                                                    <input class="btn btn-default" type="button" id="btnSalvarAcessorio" style="height: 32px; width: 180px;" value="Salvar" onclick="AdicionarAcessorio(this.value)" /></td>
                                                <td>
                                                    <input id="btnExcluirAcessorios" type="button" class="btn btn-default" style="height: 32px; width: 180px;" value="Excluir" onclick="DeleteAcessorios()" /></td>

                                                <td>
                                                    <input id="btnCancelAcess" type="button" class="btn btn-default" style="height: 32px; width: 180px;" onclick="CancelAcess()" value="Cancelar" /></td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>
                                    <div id="pnlAcessorios">
                                        <p style="margin-left: 5px; width: 80%; margin-bottom: 5px; margin-top: 10px;">Nº Patrimonio:</p>
                                        <div class="input-group" style="margin-bottom: 10px; margin-left: 5px; width: 80%; border-bottom: 1px solid #d4d4d4;">
                                            <input type="text" id="txtFindNPatAcessorios" class="form-control" onkeyup="FindlistRows('3',this,'tblAcessorios')" placeholder="Nº Patrimonio...">
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-search" onclick="FindlistRows('3',this,'tblAcessorios')"></span>
                                            </span>
                                        </div>
                                        <table id="tblAcessorios" class="tblgrid" style="margin-top: 10px;">
                                            <thead>
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Modelo</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Fabricante</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Nº Patrimonio</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbAcessorios"></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="Etiquetas" class="tab-pane fade">
                <asp:HiddenField ID="hdfIdTag" runat="server" ClientIDMode="Static" />
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="https://cdn3.iconfinder.com/data/icons/ecommerce-11/32/46_scan_barcode_shop_shopping_scaning_rfid_tag-128.png" />&nbsp; <a data-toggle="collapse" href="#conteudoEtiqueta">Etiquetas</a>
                                    </h4>
                                </div>
                                <div id="conteudoEtiqueta" class="panel-collapse collapse in">
                                    <table style="margin-left: 10px; height: 60px; margin-top: 10px;">
                                        <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td>EPC:<input type="text" id="txtEpc" style="width: 200px; margin-left: 10px;" />
                                            </td>
                                            <td>
                                                <img id="imgPesquisar" src="../Images/search.png"
                                                    onclick="findTag();" style="width: 28px; height: 28px; cursor: pointer;" /></td>
                                        </tr>
                                        <tr id="newCad" style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                            <td>
                                                <input id="btnNew" class="btn btn-default" type="button" onclick="NewTag();" value="Nova Etiqueta" style="width: 160px; font-size: 12px;" /></td>
                                        </tr>

                                    </table>

                                    <div id="divTag" style="margin-left: 10px; border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; padding: 5px; width: 800px; border-color: #f4f4f4; margin-top: 5px; margin-left: 10px;">
                                        <p style="margin-top: 5px;">
                                            <input id="btnSaveTag" class="btn btn-default" type="button" value="Confirmar" onclick="InsertTag();" style="width: 180px; font-size: 12px;" />
                                            <input id="btnVoltar" class="btn btn-default" type="button" onclick="Voltar();" value="Voltar" style="width: 180px; font-size: 12px;" />
                                        </p>
                                        <table id="tblTag" class="tblgrid" style="margin-bottom: 15px; margin-left: 5px; width: 470px; border-collapse: collapse;">
                                            <thead id="thTag" style="margin-top: 10px;">
                                                <tr>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px; width: 150px;">EPC</th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px; width: 150px;"></th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px; width: 152px;"></th>
                                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px; width: 6px;"></th>
                                                </tr>

                                            </thead>
                                            <tbody id="tbTag" style="display: none; overflow-y: scroll; height: 300px;"></tbody>
                                            <tfoot id="tfTag">
                                                <tr>
                                                    <td colspan="4">Nenhuma Etiqueta encontrada!
                                                    </td>
                                                </tr>
                                            </tfoot>
                                        </table>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="ImagemCruzamento" class="tab-pane fade">
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="../Images/gallery.png" />&nbsp; <a data-toggle="collapse" href="#conteudoIamgens">Imagens do cruzamento</a>
                                    </h4>
                                </div>
                                <div id="conteudoIamgens" class="panel-collapse collapse in" style="padding: 10px;">


                                    <%--  <div class="container" style="width: auto;">
                                        <div class="panel-group">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" href="#divImagemLocal">Imagens do cruzamento</a>
                                                    </h4>
                                                </div>--%>

                                    <table class="table table-bordered">
                                        <tr>
                                            <td style="width: 158px;">
                                                <button id="btnAdicionarImagem" onclick="btnAdicionarImagem_Click();" type="button" class="btn btn-default">Adicionar Imagem</button></td>

                                            <%-- <td style="width: 83px;line-height: 32px;text-align: right;">
                          <span>Hora de:</span> 
                                                            </td>
                                                            <td style="width: 110px;">
                                                                <div class="input-group clockpicker" data-placement="left" data-align="top" data-autoclose="true">
    <input type="text" class="form-control" value="00:00" id="txtHoraInicioImagem">
    <span class="input-group-addon">
        <span class="glyphicon glyphicon-time"></span>
    </span>
</div>

                                                            </td>
                                                            <td style="width: 58px;line-height: 32px;text-align: right;">
                          <span>Até:</span> 
                                                            </td>
                                                            <td style="width: 110px;"><div class="input-group date" style="width: 104px;">
                                                               <div class="input-group clockpicker" data-placement="left" data-align="top" data-autoclose="true">
    <input type="text" class="form-control" value="00:00" id="txtHoraFinalImagem">
    <span class="input-group-addon">
        <span class="glyphicon glyphicon-time"></span>
    </span>
</div>
                                                            </td>
                                                            <td><button id="btnFiltrarImagem" onclick="FiltrarImagem();" type="button" class="btn btn-primary">Filtrar</button></td>--%>
                                        </tr>
                                    </table>
                                    <div id="divImagemLocal_Upload" style="display: none; padding-top: 10px;">
                                        <label class="control-label">Selecione os Arquivo</label>
                                        <input id="input-pt-br" name="inputptbr[]" type="file" multiple class="file-loading" />
                                        <br />
                                    </div>
                                    <div id="divImagemLocal" class="panel-collapse collapse in">
                                        <%-- <hr style="margin-top: 0px;margin-bottom: 8px;" />--%>
                                        <table>
                                            <tr>
                                                <td valign="top" style="border-right: 1px solid #dddddd; padding-top: 12px; padding-right: 8px;">
                                                    <ul id="ulDataImagem" class="nav nav-pills nav-stacked nav-pills-stacked-example" style="float: left; width: 192px;">
                                                    </ul>
                                                </td>
                                                <td valign="top" style="padding-left: 8px; padding-top: 12px;">

                                                    <table id="tblImagem_Cruzamento">

                                                        <tbody id="tbImagem_Cruzamento">
                                                            <tr>
                                                                <td>Nenhuma imagem adicionada para o local!</td>
                                                            </tr>

                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>

                                        </table>

                                    </div>
                                    <%--</div>
                                        </div>
                                    </div>--%>

                                    <%-- <div class="container" style="width: auto;">
                                        <div class="panel-group">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" href="#divImagemPatrimonio">Imagens do(s) Patrimônio(s)</a>
                                                    </h4>
                                                </div>
                                                <div id="divImagemPatrimonio" class="panel-collapse collapse in" style="padding: 10px;">

                                                    <table id="tblImagemPatrimonio_Cruzamento">

                                                        <tbody id="tbImagemPatrimonio_Cruzamento">
                                                            <tr>
                                                                <td colspan="5">Nenhuma imagem adicionada!</td>
                                                            </tr>

                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="ProjetoCruzamento" class="tab-pane fade">
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="../Images/file.png" />&nbsp; <a data-toggle="collapse" href="#divProjetos">Projetos do cruzamento</a>
                                    </h4>
                                </div>
                                <div id="divProjetos" class="panel-collapse collapse in" style="padding: 10px;">

                                    <table class="table table-bordered">
                                        <tr>
                                            <td style="width: 158px;">
                                                <button id="btnAdicionarProjeto" onclick="btnAdicionarProjeto_Click();" type="button" class="btn btn-default">Adicionar Projeto</button></td>


                                        </tr>
                                    </table>
                                    <div id="divProjeto_Upload" style="display: none; padding-top: 10px;">
                                        <label class="control-label">Selecione os Arquivo</label>
                                        <input id="input-pt-br_Projeto" name="inputptbr[]" type="file" multiple class="file-loading" />
                                        <br />
                                    </div>
                                    <div id="divListaProjeto" style="padding-top: 10px;" class="panel-collapse collapse in">
                                        <%-- <hr style="margin-top: 0px;margin-bottom: 8px;" />--%>


                                        <table id="tblListaProjeto" class="table table-bordered">
                                            <thead>
                                                <tr style="background-color: #f2f2f2;">
                                                    <th>Arquivo(s)</th>
                                                    <th></th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbListaProjeto">
                                                <tr>
                                                    <td colspan="4">Nenhum projeto adicionada para esse cruzamento!</td>
                                                </tr>

                                            </tbody>
                                        </table>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="ArquivoCruzamento" class="tab-pane fade">
                <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 80%; border-color: transparent; margin-top: 5px; margin-left: 10px;">
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <img style="width: 30px; height: 30px;" src="../Images/folder.png" />&nbsp; <a data-toggle="collapse" href="#divArquivos">Arquivos do cruzamento</a>
                                    </h4>
                                </div>
                                <div id="divArquivos" class="panel-collapse collapse in" style="padding: 10px;">

                                    <table class="table table-bordered">
                                        <tr>
                                            <td style="width: 158px;">
                                                <button id="btnAdicionarArquivos" onclick="btnAdicionarArquivos_Click();" type="button" class="btn btn-default">Adicionar Arquivo</button></td>


                                        </tr>
                                    </table>
                                    <div id="divArquivo_Upload" style="display: none; padding-top: 10px;">
                                        <label class="control-label">Selecione os Arquivo</label>
                                        <input id="input-pt-br_Arquivo" name="inputptbr[]" type="file" multiple class="file-loading" />
                                        <br />
                                    </div>
                                    <div id="divListaArquivo" style="padding-top: 10px;" class="panel-collapse collapse in">
                                        <%-- <hr style="margin-top: 0px;margin-bottom: 8px;" />--%>


                                        <table id="tblListaArquivo" class="table table-bordered">
                                            <thead>
                                                <tr style="background-color: #f2f2f2;">
                                                    <th>Arquivo(s)</th>
                                                    <th></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbListaArquivo">
                                                <tr>
                                                    <td colspan="4">Nenhum arquivo adicionado para esse cruzamento!</td>
                                                </tr>

                                            </tbody>
                                        </table>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="modalMov" role="dialog">
        <div class="modal-dialog">

            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Movimentação de produtos</h4>
                </div>

                <div class="modal-body">
                    <p style="margin-top: 10px; border-bottom: 1px solid darkgray;">
                        Produto:
                        <span id="lblProd" style="padding-left: 10px;">
                        </span>
                    </p>
                    <br />

                    <p id="pController" style="display: none;">
                        Forma Operacional:
                        <select id="slFormaOperacionalControllerMovimentacao" class="form-control">
                            <option value="0">Selecione</option>
                            <option value="MESTRE">MESTRE</option>
                            <option value="ISOLADO">ISOLADO</option>
                        </select>
                    </p>

                    <div style="height: 32px; width: 100%; border-bottom: 1px solid darkgray; border-top: 1px solid darkgray; line-height: 32px; color: black;">
                        <p>Filtros de pesquisa</p>
                    </div>

                    <div>
                        <table style="margin-top: 4px; border-bottom: 1px solid darkgray; width: 100%;">
                            <tr>
                                <td style="padding-left: 4px; width: 188px;">Id do Local:
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtSubdivisaoMov" onkeyup="GetIdDNAMov()" placeholder="Informe id do local" style="width: 200px;" />
                                </td>
                                <td>
                                    <img id="img1" onclick="FindSubdivisaoMov()" style="width: 32px; height: 28px; cursor: pointer;" src="../Images/search.png" />
                                </td>
                            </tr>
                        </table>

                        <table style="margin-top: 4px; border-bottom: 1px solid darkgray; width: 100%;">
                            <tr>
                                <td style="padding-left: 4px;">Nº do Patrimonio:
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtNmrPatMov" placeholder="Informe o Nº do Patrimonio" style="width: 200px;" />
                                </td>
                                <td>
                                    <img id="imgFindNmtPat" onclick="FindNmrPatMov()" style="width: 32px; height: 28px; cursor: pointer;" src="../Images/search.png" />
                                </td>
                            </tr>
                        </table>

                        <table style="margin-top: 4px; border-bottom: 1px solid darkgray; width: 100%;">
                            <tr>
                                <td style="padding-left: 4px;">Origem do Produto:
                                </td>

                                <td style="padding-bottom: 4px;">
                                    <input class="btn btn-default" type="button" id="btnAlmox" style="height: 32px; width: 180px;"
                                        onclick="Almoxarifado()" value="Almoxarifado" />
                                </td>
                                <td style="padding-bottom: 4px;">
                                    <input class="btn btn-default" type="button" id="btnManutencao" style="height: 32px; width: 180px;"
                                        onclick="Manutencao()" value="Manutenção" />
                                </td>
                            </tr>
                        </table>
                    </div>

                    <br />
                    <label id="lblCancelar" onclick="Cancelar()" style="cursor: pointer; font-size: 15px; margin-bottom: 0px; font-weight: 100; color: #23527c;">Cancelar</label>
                    <br />

                    <div style="margin-top: 4px; display: none;" id="divSelAlmoxarifado">
                        <a id="aSelAlmoxarifado">Selecione o Almoxarifado:</a>
                    </div>
                    <table id="tblGrdSubdivisao" style="display: none; width: 90%" class="tblgrid">
                        <thead>
                            <tr>
                                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px; display: none"></th>
                                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Id do Local</th>
                                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Endereço</th>
                                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                            </tr>
                        </thead>
                        <tbody id="tbGrdSubdivisao" style="width: 100%; background-color: white;"></tbody>
                    </table>
                    <br />


                    <table id="tblDadosSub" style="display: none">
                        <tr>
                            <td>
                                <strong>Id do Local:</strong>
                            </td>
                            <td>
                                <span id="spnIdLocal" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Endereço:</strong></td>
                            <td>
                                <span id="spnEndereco" />
                            </td>
                        </tr>
                    </table>


                    <br />
                    <div id="divtblMov" style="display: none;">
                        <br />
                        <div id="divScroll" style="display: none; height: 200px; overflow: scroll;" class="scroll">
                            <table id="tblGrdProdutos" style="display: none; width: 100%;" class="tblgrid">
                                <thead>
                                    <tr>
                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px; display: none"></th>
                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Produto</th>
                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Patrimonio</th>
                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Local</th>
                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Endereço</th>
                                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">
                                            <input id="chkProducts" type="checkbox" onchange="chkAllProducts(this)" /></th>
                                    </tr>
                                </thead>
                                <tbody id="tbGrdProdutos" style="width: 90%; height: 90%; background-color: white;"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="text-align: right;">
                    <input class="btn btn-default" type="button" id="btnSalvarProd" style="display: none;" value="Salvar" onclick="SalvarProd()" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="modalManutencao" role="dialog">
        <div class="modal-dialog">

            <div class="modal-content" style="height: 650px;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Manutenção&nbsp;
                        <span id="lblprodManutencao"></span>
                    </h4>
                </div>

                <div class="modal-body" style="height: 500px;">

                    <div style="margin: -15px -15px -15px; width: 250px; padding: 8px 0 0 10px; overflow-y: scroll; overflow-x: hidden; height: 500px;">
                        <ul id="menu" class="nav nav-list">
                        </ul>
                    </div>
                    <table style="margin-left: 250px; margin-top: -480px;">
                        <tr>
                            <td>Subdivisão Selecionada:&nbsp;<span id="lblSubSelecionada"></span></td>
                        </tr>
                        <tr>
                            <td>Motivo:&nbsp;<select id="txtMotivo" class="form-control" style="width: 200px;"></select>
                                &nbsp;Ocorrência:&nbsp;<textarea id="txtOcorrencia" class="form-control" style="width: 250px; height: 100px;"></textarea>&nbsp;<br />
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="modal-footer" style="text-align: right !important">
                    <button type="button" onclick="salvarManutencao()" class="btn btn-default" data-dismiss="modal">Movimentar</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="mpParametro" role="dialog">
        <div class="modal-dialog">

            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Adicionar por parametro</h4>
                </div>
                <div class="modal-body">
                    <div style="padding-left: 4px; margin-top: 10px;">Produto:<label id="lblProdParam"></label></div>
                    <br />
                    <table>
                        <tr>
                            <td>Nº do Patrimonio:</td>
                            <td>
                                <input type="text" id="txtNumPatInicial" class="form-control" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <br />
                    <table>
                        <tr>
                            <td>
                                <input id="btnSalvarPatrimonio" class="btn btn-default" type="button" value="Salvar" onclick="SalvarPatParametro()" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="mpMensagem" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Aviso!</h4>
                </div>
                <div class="modal-body">
                    <br />
                    <table>
                        <tr>
                            <td>Realmente deseja salvar
                                <label id="lblProdNpatrimonio"></label>
                                sem o número de patrimonio?
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <button type="button" class="btn btn-default" onclick="SalvarProdutoNPat()">Salvar</button></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="modalProjeto" role="dialog">
        <div class="modal-dialog">

            <div class="modal-content" style="height: 650px;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Visualizar Projeto</h4>
                </div>
                <div class="modal-body" style="height: 530px;">
                    <object id="object_Projeto" data="your_url_to_pdf" type="application/pdf" style="width: 100%; height: 100%;">
                        <embed id="embed_Projeto" src="your_url_to_pdf" type="application/pdf" />
                    </object>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                </div>
            </div>

        </div>
    </div>


    <script src="lightbox2/dist/js/lightbox-plus-jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/locales/bootstrap-datepicker.pt-BR.min.js"></script>
    <script src="clockpicker/bootstrap-clockpicker.js"></script>
    <script src="Dna.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            $("#txtIdLocal").val(document.getElementById("hfIdDna").value);
            if ($("#hfIdOcorrencia").val() != "") {
                $("#IdRedirectGSS").text("Ocorrência: " + $("#hfIdOcorrencia").val());
                FindDNA();
            }
        });

        function redirectGSS() {
            window.location.replace("http://sistemas.cobrasin.com.br:9091/GSS/Talao/Atribuidos/Servico.aspx?IdTalao=" + $("#hfIdOcorrencia").val());
        }

        $(function () {

            $('.datepicker').datepicker({
                dateFormat: "dd/mm/yyyy",
                language: 'pt-BR'
            });


            $.ajax({
                type: 'POST',
                url: 'WebService/Materiais.asmx/GetDepartament',
                dataType: 'json',
                data: "{'idPrefeitura': '" + $("#hfIdPrefeitura").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        var lstDepartamento = [];
                        var i = 0;
                        while (data.d[i]) {
                            var lst = data.d[i].split('@');
                            var item = {};
                            item.id = lst[0];
                            item.nome = lst[1];
                            lstDepartamento.push(item);
                            i++;
                        }
                        LoadDepartamentTreeMenu(lstDepartamento);


                    }
                },
                error: function (data) {
                }
            });

        })

        function LoadDepartamentTreeMenu(Departamento) {
            $.each(Departamento, function (index, Departamento) {

                $.ajax({
                    type: 'POST',
                    url: 'WebService/Materiais.asmx/GetSub',
                    dataType: 'json',
                    data: "{'idDepartamento':'" + Departamento.id + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {
                            var lstSub = [];
                            var i = 0;
                            while (data.d[i]) {
                                var lst = data.d[i].split('@');
                                var item = {};
                                item.idsub = lst[0];
                                item.Sub = lst[1];
                                lstSub.push(item);
                                i++;
                            }
                            var newRow = $("<li style='border-bottom: 1px solid #d8d8d8;margin-bottom:20px;'>").append("<a href='#' style='height:30px;cursor:pointer;color:#999999;' data-id='" + Departamento.id + "'>" + Departamento.nome + "</a>");
                            var cols = $("<ul id=" + Departamento.id + " class='nav nav-list tree'>");
                            newRow.append(cols);
                            $("#menu").append(newRow);

                            LoadSubTreeMenu(lstSub, Departamento.id);

                        }
                        else {
                            var newRow = $("<li style='border-bottom: 1px solid #d8d8d8; margin-bottom:20px;'>").append("<a href='#' style='height:30px; cursor:pointer;color:#999999;' data-id='" + Departamento.id + "'>" + Departamento.nome + "</a>");
                            var cols = $("<ul id=" + Departamento.id + " class='nav nav-list tree'>");
                            newRow.append(cols);
                            $("#menu").append(newRow);
                        }
                    },
                    error: function (data) {
                    }
                });

            });

        }

        function LoadSubTreeMenu(subdivisao, idDep, subMestre) {

            $.each(subdivisao, function (index, subdivisao) {
                if (subMestre != undefined) {
                    var newRow = $("<li style='margin-left:10px;'>").append("<a href='#' style='cursor:pointer;' onclick='SubdivisaoClick(this)' data-id='" + subdivisao.idsub + "'>" + subdivisao.Sub + "</a>");
                    var cols = $("<ul id=" + subdivisao.idsub + " class='nav nav-list tree'>");
                    newRow.append(cols);
                    $("#" + subMestre).append(newRow);
                }
                else {
                    var newRow = $("<li style='margin-left:15px;'>").append("<a href='#' style='height:30px;cursor:pointer;color:#999999;' onclick='SubdivisaoClick(this)' data-id='" + subdivisao.idsub + "'>" + subdivisao.Sub + "</a>");
                    var cols = $("<ul id=" + subdivisao.idsub + " class='nav nav-list tree'>");
                    newRow.append(cols);
                    $("#" + idDep).append(newRow);
                }

                var subdivisaoMestre = subdivisao.idsub;
                $.ajax({
                    type: 'POST',
                    url: 'WebService/Materiais.asmx/getSubChildren',
                    dataType: 'json',
                    data: "{'idSubdivisao':'" + subdivisaoMestre + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {
                            var lstSubdivisao = [];
                            var i = 0;
                            while (data.d[i]) {
                                var lst = data.d[i].split('@');
                                var item = {};
                                item.idsub = lst[0];
                                item.Sub = lst[1];
                                lstSubdivisao.push(item);
                                i++;
                            }
                            LoadSubTreeMenu(lstSubdivisao, subdivisao.idsub, subdivisaoMestre);
                        }
                    },
                    error: function (data) {
                    }
                });

            });


        }

        function GetEndereco() {
            var str = "" + $("#txtIdLocal").val();
            var pad = "0000"
            var id = pad.substring(0, pad.length - str.length) + str
            $("#hfIdDna").val(id);
            $("#hfIdSub").val("");
            var dataDNA = [];
            $.ajax({
                type: 'POST',
                url: 'WebService/Materiais.asmx/getIdDNA',
                dataType: 'json',
                data: "{'idPrefeitura': '" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':''}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var qtd = 1;
                    var DNA = data.d;
                    $.each(DNA, function (index, DNA) {
                        dataDNA.push({
                            id: DNA.idSub,
                            nome: DNA.Subdivisao,
                            end: DNA.Endereco
                        });
                    });

                    $("#txtEndereco").autocomplete({
                        source: $.map(dataDNA, function (item) {
                            return {
                                label: item.end,
                                val: item.id,
                                sub: item.nome
                            }
                        }),
                        select: function (e, i) {
                            $("#txtIdLocal").val(i.item.sub);
                            $("#txtEndereco").val(i.item.label);
                            $("#hfIdDna").val(i.item.sub);
                            $("#hfIdSub").val(i.item.val);
                            $("#hfEndereco").val(i.item.label);
                            FindDNA();
                        },
                        minLength: 1
                    });
                },
                error: function (data) {
                }
            });
        }

        function GetIdDNA() {
            var str = "" + $("#txtIdLocal").val();
            var pad = "0000"
            var id = pad.substring(0, pad.length - str.length) + str
            $("#hfIdDna").val(id);
            $("#hfIdSub").val("");
            var dataDNA = [];
            $.ajax({
                type: 'POST',
                url: 'WebService/Materiais.asmx/getIdDNA',
                dataType: 'json',
                data: "{'idPrefeitura': '" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':''}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var qtd = 1;
                    var DNA = data.d;
                    $.each(DNA, function (index, DNA) {
                        dataDNA.push({
                            id: DNA.idSub,
                            nome: DNA.Subdivisao,
                            end: DNA.Endereco
                        });
                    });

                    $("#txtIdLocal").autocomplete({
                        source: $.map(dataDNA, function (item) {
                            return {
                                label: item.nome,
                                val: item.id,
                                end: item.end
                            }
                        }),
                        select: function (e, i) {
                            $("#txtIdLocal").val(i.item.label);
                            $("#txtEndereco").val(i.item.end);
                            $("#hfIdDna").val(i.item.label);
                            $("#hfIdSub").val(i.item.val);
                            $("#hfEndereco").val(i.item.end);
                            FindDNA();
                        },
                        minLength: 1
                    });
                },
                error: function (data) {
                }
            });
        }

        function GetIdDNAMestre() {

            var id = $("#txtIdLocalMestre").val();
            $("#txtIdLocalMestre").val(id);
            var dataDNA = [];
            $.ajax({
                type: 'POST',
                url: 'WebService/Materiais.asmx/getIdDNA',
                dataType: 'json',
                data: "{'idPrefeitura': '" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':''}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var qtd = 1;
                    var DNA = data.d;
                    $.each(DNA, function (index, DNA) {
                        dataDNA.push({
                            id: DNA.idSub,
                            nome: DNA.Subdivisao,
                            end: DNA.Endereco
                        });
                    });

                    $("#txtIdLocalMestre").autocomplete({
                        source: $.map(dataDNA, function (item) {
                            return {
                                label: item.nome,
                                val: item.id,
                                end: item.end
                            }
                        }),
                        select: function (e, i) {
                            $("#txtIdLocalMestre").val(i.item.label);
                        },
                        minLength: 1
                    });
                },
                error: function (data) {
                }
            });
        }

        function GetIdDNAMov() {

            var id = $("#txtSubdivisaoMov").val();
            $("#txtSubdivisaoMov").val(id);
            var dataDNA = [];
            $.ajax({
                type: 'POST',
                url: 'WebService/Materiais.asmx/getIdDNA',
                dataType: 'json',
                data: "{'idPrefeitura': '" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':''}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var qtd = 1;
                    var DNA = data.d;
                    $.each(DNA, function (index, DNA) {
                        dataDNA.push({
                            id: DNA.idSub,
                            nome: DNA.Subdivisao,
                            end: DNA.Endereco
                        });
                    });

                    $("#txtSubdivisaoMov").autocomplete({
                        source: $.map(dataDNA, function (item) {
                            return {
                                label: item.nome,
                                val: item.id,
                                end: item.end
                            }
                        }),
                        select: function (e, i) {
                            $("#txtSubdivisaoMov").val(i.item.label);
                        },
                        minLength: 1
                    });
                },
                error: function (data) {
                }
            });
        }
    </script>

    <script src="fileinput.js"></script>
    <script src="bootstrap-fileinput-master/js/locales/pt-BR.js"></script>

    <script>
        $(document).on('ready', function () {
            $('.clockpicker').clockpicker();

            $("#input-pt-br").fileinput({
                language: "pt-BR",
                uploadUrl: "Dna.aspx",
                maxFilePreviewSize: 10240,
                allowedFileExtensions: ["jpg", "jpeg", "png", "gif", "svg"],
                uploadAsync: true,
                elErrorContainer: '#kv-error-1'
            }).on('filebatchpreupload', function (event, data, id, index) {
                $('#kv-success-1').html('<h4>Upload Status</h4><ul></ul>').hide();
            }).on('fileuploaded', function (event, data, id, index) {
                var fname = data.files[index].name,
                    out = '<li>' + 'Uploaded file # ' + (index + 1) + ' - ' +
                        fname + ' successfully.' + '</li>';
                $('#kv-success-1 ul').append(out);
                $('#kv-success-1').fadeIn('slow');
            });

            $("#input-pt-br_Projeto").fileinput({
                language: "pt-BR",
                uploadUrl: "Dna.aspx",
                maxFilePreviewSize: 10240,
                allowedFileExtensions: ["pdf"],
                uploadAsync: true,
                elErrorContainer: '#kv-error-1'
            }).on('filebatchpreupload', function (event, data, id, index) {
                $('#kv-success-1').html('<h4>Upload Status</h4><ul></ul>').hide();
            }).on('fileuploaded', function (event, data, id, index) {
                var fname = data.files[index].name,
                    out = '<li>' + 'Uploaded file # ' + (index + 1) + ' - ' +
                        fname + ' successfully.' + '</li>';
                $('#kv-success-1 ul').append(out);
                $('#kv-success-1').fadeIn('slow');
            });

            $("#input-pt-br_Arquivo").fileinput({
                language: "pt-BR",
                uploadUrl: "Dna.aspx",
                maxFilePreviewSize: 10240,
                allowedFileExtensions: ["jpg", "jpeg", "png", "gif", "svg", "doc", "docx", "pdf", "rar", "zip", "mp4", "avi", "mpg", "txt", "xls"],
                uploadAsync: true,
                elErrorContainer: '#kv-error-1'
            }).on('filebatchpreupload', function (event, data, id, index) {
                $('#kv-success-1').html('<h4>Upload Status</h4><ul></ul>').hide();
            }).on('fileuploaded', function (event, data, id, index) {
                var fname = data.files[index].name,
                    out = '<li>' + 'Uploaded file # ' + (index + 1) + ' - ' +
                        fname + ' successfully.' + '</li>';
                $('#kv-success-1 ul').append(out);
                $('#kv-success-1').fadeIn('slow');
            });

        });
    </script>
</asp:Content>
