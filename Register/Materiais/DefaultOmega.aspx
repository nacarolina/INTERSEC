<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DefaultOmega.aspx.cs" Inherits="GwCentral.Register.Materiais.DefaultOmega" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <%--STYLE--%>

    <%--<script src="../../Scripts/jquery-1.8.2.min.js"></script>--%>
    <%--<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />--%>
    <%--<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/css/bootstrap-datepicker.css" />
    <%--<link href="bootstrap-fileinput-master/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />--%>
    <link href="lightbox2/dist/css/lightbox.min.css" rel="stylesheet" />
    <link href="clockpicker/bootstrap-clockpicker.css" rel="stylesheet" />

    <%--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" crossorigin="anonymous">
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.0.9/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />--%>
    <meta content="*" http-equiv="Access-Control-Allow-Origin" />

    <style type="text/css">
        /*#region CSS SICAPP ANTIGO*/
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
        /*#endregion*/

        /*#region COLLAPSE*/
        * {
            outline: 0;
            box-sizing: border-box;
        }

        section {
            max-width: var(--sectionWidth);
            /*margin: 40px auto;*/
            width: 97%;
            color: #6b6f80;
            width: 100%;
            margin-top: 1rem;
            margin-bottom: 1rem;
        }

        summary {
            display: block;
            cursor: pointer;
            padding: 10px;
            font-size: 22px;
            -webkit-transition: .3s;
            transition: .3s;
            border-bottom: 2px solid;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            font-family: "Comfortaa", cursive, "Times New Roman", Times, serif;
            font-weight: bold;
        }

        details > div {
            display: -webkit-box;
            display: flex;
            flex-wrap: wrap;
            overflow: auto;
            height: 100%;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            padding: 0 15px;
            line-height: 1.5;
        }

            details > div > img {
                align-self: flex-start;
                max-width: 100%;
                margin-top: 20px;
            }

            details > div > p {
                -webkit-box-flex: 1;
                flex: 1;
            }

        details[open] > summary {
            color: #6b6f80;
        }

        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            overflow-x: hidden;
            width: 300px;
            background-color: #ffffff;
            cursor: pointer;
        }

        @media (min-width: 768px) {
            details[open] > div > p {
                opacity: 0;
                -webkit-animation-name: showContent;
                animation-name: showContent;
                -webkit-animation-duration: 0.6s;
                animation-duration: 0.6s;
                -webkit-animation-delay: 0.2s;
                animation-delay: 0.2s;
                -webkit-animation-fill-mode: forwards;
                animation-fill-mode: forwards;
                margin: 0;
                padding-left: 20px;
            }

            details[open] > div {
                -webkit-animation-name: slideDown;
                animation-name: slideDown;
                -webkit-animation-duration: 0.3s;
                animation-duration: 0.3s;
                -webkit-animation-fill-mode: forwards;
                animation-fill-mode: forwards;
            }

                details[open] > div > img {
                    opacity: 0;
                    height: 100%;
                    margin: 0;
                    -webkit-animation-name: showImage;
                    animation-name: showImage;
                    -webkit-animation-duration: 0.3s;
                    animation-duration: 0.3s;
                    -webkit-animation-delay: 0.15s;
                    animation-delay: 0.15s;
                    -webkit-animation-fill-mode: forwards;
                    animation-fill-mode: forwards;
                }
        }

        @-webkit-keyframes slideDown {
            from {
                opacity: 0;
                height: 0;
                padding: 0;
            }

            to {
                opacity: 1;
                height: var(--contentHeight);
                padding: 20px;
            }
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                height: 0;
                padding: 0;
            }

            to {
                opacity: 1;
                height: var(--contentHeight);
                padding: 20px;
            }
        }

        @-webkit-keyframes showImage {
            from {
                opacity: 0;
                -webkit-clip-path: inset(50% 0 50% 0);
                clip-path: inset(50% 0 50% 0);
                -webkit-transform: scale(0.4);
                transform: scale(0.4);
            }

            to {
                opacity: 1;
                -webkit-clip-path: inset(0 0 0 0);
                clip-path: inset(0 0 0 0);
            }
        }

        @keyframes showImage {
            from {
                opacity: 0;
                -webkit-clip-path: inset(50% 0 50% 0);
                clip-path: inset(50% 0 50% 0);
                -webkit-transform: scale(0.4);
                transform: scale(0.4);
            }

            to {
                opacity: 1;
                -webkit-clip-path: inset(0 0 0 0);
                clip-path: inset(0 0 0 0);
            }
        }

        @-webkit-keyframes showContent {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }

        @keyframes showContent {
            from {
                opacity: 0;
            }

            to {
                opacity: 1;
            }
        }
        /*#endregion */

        /*#region BACKGROUND LINHA TABELA*/
        #tbProdCtr tr:hover {
            background-color: #e3ebf338;
        }

        #tbAdcPlaca tr:hover {
            background-color: #e3ebf338;
        }

        #tbPlaca tr:hover {
            background-color: #e3ebf338;
        }

        #bdAdcGprs tr:hover {
            background-color: #e3ebf338;
        }

        #tbAdcNobreak tr:hover {
            background-color: #e3ebf338;
        }

        #tbConjugados tr:hover {
            background-color: #e3ebf338;
        }

        #tbAdcGPRSNbk tr:hover {
            background-color: #e3ebf338;
        }

        #tbAdcColuna tr:hover {
            background-color: #e3ebf338;
        }

        #tbColunas tr:hover {
            background-color: #e3ebf338;
        }

        #tbAdcCabos tr:hover {
            background-color: #e3ebf338;
        }

        #tbCabos tr:hover {
            background-color: #e3ebf338;
        }

        #tbAdcGrupoFocal tr:hover {
            background-color: #e3ebf338;
        }

        #tbGrupoFocal tr:hover {
            background-color: #e3ebf338;
        }

        #tbAdcIluminacao tr:hover {
            background-color: #e3ebf338;
        }

        #tbIluminacao tr:hover {
            background-color: #e3ebf338;
        }

        #tbAdcAcessorios tr:hover {
            background-color: #e3ebf338;
        }

        #tbAcessorios tr:hover {
            background-color: #e3ebf338;
        }

        #tbTag tr:hover {
            background-color: #e3ebf338;
        }
        /*#endregion*/
        /* Just add this CSS to your project */

        .dropzone {
            border: 2px dashed #dedede;
            border-radius: 5px;
            background: #f5f5f5;
        }

            .dropzone i {
                font-size: 5rem;
            }

            .dropzone .dz-message {
                color: rgba(0,0,0,.54);
                font-weight: 500;
                font-size: initial;
                text-transform: uppercase;
            }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.2.0/min/dropzone.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.2.0/min/dropzone.min.css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.Materiais %>
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
    <asp:HiddenField ID="hdfIdTag" runat="server" ClientIDMode="Static" />

    <div id="divLoad" style="width: 100%; height: 100%; position: absolute; z-index: 1; display: none; opacity: 0.2; background-color: #d8d8d8;">
        <p style="top: 20%; left: 40%; position: absolute;">
            <img src="../../Images/load.GIF" id="imgLoad" alt="Carregando" />
        </p>
    </div>

    <table style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 1000px; border-color: transparent; height: 100px;">
        <tr>
            <td style="margin-left: 100px;">&nbsp; <strong>Id do Local:</strong>
            </td>
            <td style="margin-right: 1000px;" class="auto-style1">
                <input type="text" class="form-control" placeholder="Informe o Id do Local..."
                    id="txtIdLocal" style="width: 500px" />
            </td>
            <td>
                <img style="height: 32px; width: 32px; background-color: transparent; border-color: transparent;"
                    src="../../Images/search.png" onclick="FindDNA()" />
            </td>
        </tr>
        <tr>
            <td style="width: 100px;">&nbsp; <strong>Endereço: </strong>
            </td>
            <td style="width: 500px;">
                <input type="text" placeholder="Digite o Endereço..." class="form-control"
                    onkeyup="<%--GetEndereco()--%>" style="width: 500px" id="txtEndereco" />
            </td>
        </tr>
    </table>

    <div id="divMateriais" class="container" style="margin-top: 15px; margin-left: 0px; display: none;">
        <br />
        <%--<div class="panel-group">
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
                        <input type="button" id="btnSalvarDetalhesDNA" style="width: 180px;"
                            value="Salvar" class="btn btn-default" onclick="SalvarDetalhesDNA()" />
                    </div>
                </div>
            </div>
        </div>--%>
        <br />

        <h3>
            <a href="#" style='cursor: pointer; color: black;'
                id="IdRedirectGSS" onclick="redirectGSS()"></a>
        </h3>

        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#Controlador">Controlador</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#Nobreak">Nobreak</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#Coluna">Coluna</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#Cabos">Cabos</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#GrupoFocal">Grupo Focal</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#SistemaIluminacao">Sistema de Iluminação</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#Acessorios">Acessórios</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#Etiquetas" style="display: none;">Etiquetas</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#ImagemCruzamento">Imagens</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#ProjetoCruzamento" style="display: none;">Projetos</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#ArquivoCruzamento">Arquivos</a>
            </li>
        </ul>

        <div class="tab-content px-1 pt-1">
            <div id="Controlador" role="tabpanel"
                class="tab-pane active">
                <section>
                    <details open>
                        <summary>Dados do Controlador</summary>
                        <%--COMPONENTES--%>
                        <div id="collapseDadoCtrl" class="panel-collapse">
                            <div id="divAdcCtrl" style="padding-left: 10px; padding-bottom: 4px; padding-top: 4px;">
                                <button id="lnkAdcControlador" type="button" class="btn btn-success"
                                    onclick="AdcOptionCadCtrl()">
                                    Adicionar Controlador
                                </button>
                            </div>
                            <div id="pnlAdcCtrl" style="display: none;">
                                <table style="margin-left: 6px;">
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarCtrl" type="button"
                                                class="btn btn-secondary"
                                                style="margin-bottom: 1rem;"
                                                onclick="CancelarCtrl()">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                    <tr style="width: 60px;">
                                        <td>
                                            <button id="btnAdcControlador" type="button"
                                                class="btn btn-outline-secondary"
                                                onclick="AdcControladorImplantacao()"
                                                value="Por Implantação">
                                                Por Implantação
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnAdcCtrlMov" type="button"
                                                class="btn btn-outline-secondary" value="Por Movimentação"
                                                title="Controlador" data-toggle="modal" data-target="#modalMov"
                                                onclick="modalMovimentacao(this)">
                                                Por Movimentação
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="pnlCtrlDados" style="margin-bottom: 8px;">
                                <table style="width: 100%;">
                                    <tr>
                                        <td>
                                            <table id="tblMestreIsol">
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
                                            <table id="tblConjugado" style="display: none;">
                                                <tr style="height: 60px;">
                                                    <td><strong>Mestre: </strong>
                                                        <label id="lblMestre"></label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table style="margin-top: 10px;">
                                    <tr>
                                        <td>
                                            <button type="button" class="btn btn-outline-secondary"
                                                id="lnkDetalhesCtrl"
                                                onclick="DetalhesCtrl()">
                                                Detalhes do Controlador
                                            </button>
                                            &nbsp;&nbsp;&nbsp;
                                            <button type="button" class="btn btn-outline-secondary"
                                                id="lnkCtrlManutencao"
                                                title="Controlador"
                                                onclick="MovimentarManutencao(this)">
                                                Manutenção
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <table id="tblformaoperacional" style="display: none;">
                                <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                    <td>
                                        <button id="lnkVoltarCadCtrl" type="button"
                                            class="btn btn-secondary"
                                            onclick="CancelarCtrl()">
                                            Voltar
                                        </button>
                                    </td>

                                </tr>
                                <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                    <td style="width: 300px;">Forma Operacional:</td>
                                    <td>
                                        <select id="ddlFormaOperacional" class="form-control"
                                            onchange="ValorDrop(this)" disabled="disabled">
                                            <option value="Selecione">Selecione</option>
                                            <option value="MESTRE">MESTRE</option>
                                            <option value="CONJUGADO">CONJUGADO</option>
                                            <option value="ISOLADO">ISOLADO</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                            <table id="tblSelSubMestre" style="display: none;">
                                <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                    <td style="width: 300px;">Id do Local do Controlador Mestre: </td>
                                    <td>
                                        <input type="text" class="form-control"
                                            id="txtIdLocalMestre" />
                                    </td>
                                </tr>
                            </table>

                            <div id="pnlCtrlEditarDetalhes" style="display: none;">
                                <table id="tblEditarDadosCtrl">
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Nome Produto:</td>
                                        <td>
                                            <input id="txtProduto" type="text" class="form-control" disabled="disabled" /></td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número Série:</td>
                                        <td>
                                            <input id="txtNmrSerie" type="text" class="form-control" disabled="disabled" /></td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número Patrimonio:</td>
                                        <td>
                                            <input id="txtNumPat" type="text" class="form-control" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Tipo:</td>
                                        <td>
                                            <input id="txtCtrlTipo" type="text" class="form-control" disabled="disabled" /></td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fabricante:</td>
                                        <td>
                                            <input id="txtCtrlFabricante" class="form-control" type="text" disabled="disabled" /></td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Modelo:</td>
                                        <td>
                                            <input id="txtCtrlModelo" class="form-control" type="text" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fixação:</td>
                                        <td>
                                            <select id="ddlCtrlFixacao" class="form-control">
                                                <option value="--Selecione a Fixação--">--Selecione a Fixação--</option>
                                                <option value="BASE DE CONCRETO">BASE DE CONCRETO</option>
                                                <option value="COLUNA BASE">COLUNA BASE</option>
                                                <option value="COLUNA DE SEMAFORO">COLUNA DE SEMAFORO</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data da instalação:</td>
                                        <td>
                                            <input id="txtCtrlDtInstalacao" type="datetime-local" class="form-control" style="width: 16rem;" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Garantia:</td>
                                        <td>
                                            <input type="datetime-local" class="form-control" id="txtCtrlDtGarantia" style="width: 16rem;" />
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
                                            <select id="ddlEstadoOperacional" class="form-control" style="width: 16rem">
                                                <option>ATIVO</option>
                                                <option>INATIVO</option>
                                            </select></td>
                                    </tr>
                                </table>
                                <br />
                                <table id="dvBtnCtrl" style="font-size: x-small; width: 50%; margin-left: 10px; height: 60px;">
                                    <tr>
                                        <td>
                                            <button id="btnCtrlSave" type="button" class="btn btn-success"
                                                onclick="CtrlSave(this.value)" value="Salvar">
                                                Salvar
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnApagarControlador" type="button" class="btn btn-danger"
                                                onclick="ApagarControlador()" value="Excluir">
                                                Excluir
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnCancelarCtrl" type="button" class="btn btn-warning"
                                                onclick="CancelarCtrl()" value="Cancelar">
                                                Cancelar
                                            </button>
                                        </td>
                                    </tr>
                                </table>

                                <br />
                            </div>
                            <div id="pnlAdcCtrlImplantacao" style="display: none; margin-top: 2rem;">
                                <div style="margin-bottom: 4px; margin-left: 4px;">
                                    <a style="font-size: 14px;">Selecione o Controlador que deseja utilizar:</a>
                                </div>
                                <table id="tblProdCtr" class="table table-bordered mb-0">
                                    <thead id="thProdCtr" style="margin-top: 10px;">
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th></th>
                                        </tr>

                                    </thead>
                                    <tbody id="tbProdCtr"></tbody>
                                </table>
                            </div>
                        </div>
                    </details>
                </section>

                <section id="divCtrlConj" style="display: none;">
                    <details open>
                        <summary>Controladores conjugados</summary>
                        <%--COMPONENTES--%>
                        <table id="tblConjugados" class="table table-bordered mb-0"
                            style="margin-top: 2rem;">
                            <thead id="ThConj">
                                <tr>
                                    <th>Id do Local</th>
                                    <th>Endereço</th>
                                </tr>

                            </thead>
                            <tbody id="tbConjugados"></tbody>
                            <tfoot id="TfConjugados" style="display: none;">
                                <tr>
                                    <td colspan="2">Este local não tem nenhum conjugado!
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </details>
                </section>

                <section id="divPlacaCtrl" style="display: none;">
                    <details open>
                        <summary>Placas do controlador</summary>
                        <%--COMPONENTES--%>
                        <div id="conteudoPlacas" class="panel-collapse">
                            <table style="margin-left: 8px; margin-top: 4px; margin-bottom: 4px;">
                                <tr>
                                    <td>
                                        <button type="button" class="btn btn-success"
                                            id="lnkNovaPlaca"
                                            onclick="NovaPlaca()">
                                            Nova Placa
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <div id="pnlPlaca" style="margin-bottom: 8px;">
                                <div id="pnlAdcPlaca" style="display: none;">
                                    <table style="margin-left: 8px;">
                                        <tr>
                                            <td>
                                                <button id="lnkVoltarAddTipoPlaca" type="button"
                                                    class="btn btn-secondary"
                                                    onclick="CancelPlaca()">
                                                    Voltar
                                                </button>
                                            </td>
                                        </tr>
                                        <tr style="height: 60px;">
                                            <td>
                                                <button id="btnImplantacaoPlacaCtrl" type="button"
                                                    class="btn btn-outline-secondary" onclick="ImplantacaoPlacaCtrl()"
                                                    value="Por Implantação">
                                                    Por Implantação
                                                </button>
                                            </td>
                                            <td>
                                                <button id="btnMovimentacaoPlacaCtrl" type="button"
                                                    class="btn btn-outline-secondary" data-toggle="modal"
                                                    data-target="#modalMov" onclick="modalMovimentacao(this)"
                                                    title="Placa" value="Por Movimentação">
                                                    Por Movimentação
                                                </button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div id="pnlGrdPlacaCtrl" style="display: none;">
                                    <table style="margin-bottom: 2rem;">
                                        <tr>
                                            <td>
                                                <button id="lnkCancelarPlacaCtrl" type="button"
                                                    class="btn btn-secondary" onclick="CancelPlaca()">
                                                    Voltar
                                                </button>
                                            </td>
                                        </tr>
                                    </table>
                                    <div>
                                        <a>Selecione a Placa que deseja utilizar:</a>
                                    </div>
                                    <table id="tblAdcPlaca" class="table table-bordered mb-0">
                                        <thead id="Thead2" style="margin-top: 10px;">
                                            <tr>
                                                <th>Placa</th>
                                                <th>Modelo</th>
                                                <th>Fabricante</th>
                                                <th></th>
                                            </tr>

                                        </thead>
                                        <tbody id="tbAdcPlaca"></tbody>
                                    </table>
                                </div>

                                <div id="dvGrdPlacas">
                                    <p style="margin-left: 5px; width: 80%; margin-bottom: 5px; margin-top: 10px;">Nº Patrimonio:</p>
                                    <div class="input-group">
                                        <input type="text" id="txtFindNPatPlaca" class="form-control"
                                            onkeyup="FindlistRows('3',this,'tblPlaca')" placeholder="Nº Patrimonio...">
                                        <div class="input-group-append">
                                            <button class="btn btn-secondary" onclick="FindlistRows('3',this,'tblPlaca')">
                                                <i class="ficon ft-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <table id="tblPlaca" class="table table-bordered mb-0"
                                        style="margin-top: 1rem;">
                                        <thead id="Thead3">
                                            <tr>
                                                <th style="padding-top: 14px;">Placa</th>
                                                <th style="padding-top: 14px;">Modelo</th>
                                                <th style="padding-top: 14px;">Fabricante</th>
                                                <th style="padding-top: 14px;">Nº Patrimonio</th>
                                                <th style="padding-top: 14px;"></th>
                                                <th style="padding-top: 14px;"></th>
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
                                            <td style="width: 200px;">Quantidade:</td>
                                            <td>
                                                <input class="form-control" type="number" id="txtQtdPlacaCtrl" title="placa"
                                                    min="1" max="50000" value="1" onchange="verificaQtd(this)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <table style="margin-left: 10px;">
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td style="width: 200px;">Número Patrimonio:</td>
                                        <td>
                                            <input type="text" class="form-control" id="txtNmrPatlaca" />
                                        </td>
                                        <td>
                                            <input type="button" class="btn btn-secondary" id="btnAdcParamPlacaCtrl"
                                                title="placa" data-toggle="modal" data-target="#mpParametro"
                                                onclick="porParametro(this)" value="Adicionar por parametro" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fabricante:</td>
                                        <td>
                                            <input id="txtFabricantePlaca" type="text" class="form-control"
                                                disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Modelo:</td>
                                        <td>
                                            <input id="txtPlacaModelo" type="text" class="form-control"
                                                disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Instalação:</td>
                                        <td>
                                            <input type="datetime-local" id="txtPlacaDtInstal" class="form-control" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Garantia:</td>
                                        <td>
                                            <input type="datetime-local" id="txtPlacaDtGarantia" class="form-control" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Estado operacional:</td>
                                        <td>
                                            <select id="ddlPlacaAtivo" class="form-control">
                                                <option value="ATIVO">ATIVO</option>
                                                <option value="INATIVO">INATIVO</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table style="font-size: x-small; width: 50%; margin-left: 10px; margin-bottom: 8px;">
                                    <tr>
                                        <td>
                                            <button id="btnPlacaSave" type="button" class="btn btn-success"
                                                onclick="PlacaSave(this.value)" value="Salvar">
                                                Salvar
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnApagarPlaca" type="button" class="btn btn-danger"
                                                onclick="ApagarPlaca()" value="Excluir">
                                                Excluir
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnCancelPlaca" type="button" class="btn btn-warning"
                                                onclick="CancelPlaca()" value="Cancelar">
                                                Cancelar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </details>
                </section>

                <section id="divGprsCtrl" style="display: none;">
                    <details open>
                        <summary>GPRS do controlador</summary>
                        <div id="conteudoGPRS" class="panel-collapse">
                            <table id="tblNewGprs">
                                <tr>
                                    <td>
                                        <button id="lnkNovoGprs" type="button"
                                            class="btn btn-success"
                                            onclick="NovoGprs()">
                                            Novo Gprs
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <div id="pnlAdcGprsCtrl" style="display: none;">
                                <table style="margin-left: 8px;">
                                    <tr>
                                        <td>
                                            <button id="lnkVoltarAdcGprsCtrl" type="button"
                                                class="btn btn-secondary" style="margin-bottom: 1rem;"
                                                onclick="CancelGprs()">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <button id="btnPorImplantacaoGPRSctrl" type="button"
                                                class="btn btn-outline-secondary"
                                                onclick="PorImplantacaoGPRSctrl()"
                                                value="Por Implantação">
                                                Por Implantação
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnPorMovimentacaoGPRSctrl" type="button"
                                                class="btn btn-outline-secondary" data-toggle="modal"
                                                data-target="#modalMov" onclick="modalMovimentacao(this)"
                                                title="GPRS Controlador" value="Por Movimentação">
                                                Por Movimentação
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div id="pnlSelGprs" style="display: none;">
                                <table style="margin-bottom: 1rem;">
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarGprsCtrl"
                                                type="button"
                                                class="btn btn-secondary"
                                                onclick="CancelGprs()">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <label>Selecione o GPRS que deseja utilizar:</label>
                                </div>
                                <table id="tblAdcGprs" class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th></th>
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
                                            <button id="lnkDetalhesGprsCtrl" type="button"
                                                class="btn btn-outline-secondary"
                                                onclick="DetalhesGprsCtrl(this)">
                                                Detalhes
                                            </button>
                                            &nbsp;&nbsp;&nbsp;
                                            <button id="linkGprsCtrlManutencao" title="Gprs"
                                                class="btn btn-outline-secondary"
                                                onclick="MovimentarManutencao(this)">
                                                Manutenção
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div id="pnlEditarGprsCtrl" style="display: none;">
                                <table style="margin-left: 10px;">
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número Patrimonio:</td>
                                        <td>
                                            <input type="text" id="txtGprsNumPat" class="form-control" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número de Série:</td>
                                        <td>
                                            <input type="text" id="txtGprsNumSerie" class="form-control" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fabricante:</td>
                                        <td>
                                            <input type="text" class="form-control" id="txtGprsFab" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Modelo:</td>
                                        <td>
                                            <input type="text" class="form-control" id="txtGprsModelo" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Nº da linha:</td>
                                        <td>
                                            <input type="tel" class="form-control" id="txtGprsNrLinha" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Operadora:</td>
                                        <td>
                                            <select id="ddlGprsOperadora" class="form-control">
                                                <option></option>
                                                <option>CLARO</option>
                                                <option>TIM</option>
                                                <option>OI</option>
                                                <option>VIVO</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Instalação:</td>
                                        <td>
                                            <input type="datetime-local" class="form-control"
                                                id="txtGprsDtInstalacao" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Garantia:</td>
                                        <td>
                                            <input type="datetime-local" class="form-control"
                                                id="txtGprsDtGarantia" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Estado operacional:</td>
                                        <td>
                                            <select id="ddlGprsEstadoOperacional" class="form-control">
                                                <option>ATIVO</option>
                                                <option>INATIVO</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table style="margin-left: 10px; margin-bottom: 8px; width: 50%;">
                                    <tr>
                                        <td>
                                            <button class="btn btn-success" type="button"
                                                id="btnSalvarGpsC"
                                                onclick="SalvarGprsC(this.value)"
                                                value="Salvar">
                                                Salvar
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-danger" type="button"
                                                id="btnApagarGprsControl"
                                                onclick="ApagarGprsControl()"
                                                value="Excluir">
                                                Excluir
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-warning" type="button"
                                                id="btnCancelGprs" onclick="CancelGprs()"
                                                value="Cancelar">
                                                Cancelar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </details>
                </section>
            </div>

            <div id="Nobreak" role="tabpanel"
                class="tab-pane">
                <section>
                    <details open>
                        <summary>Dados do Nobreak</summary>
                        <div id="conteudoNobreakDados" class="panel-collapse">
                            <table id="adcNbrk">
                                <tr>
                                    <td>
                                        <button id="lnkAdcNobreak" type="button"
                                            class="btn btn-success"
                                            onclick="AdcNobreak()">
                                            Adicionar Nobreak
                                        </button>
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
                                <p>
                                    <button id="lnkDetailsNbr" type="button"
                                        class="btn btn-outline-secondary"
                                        onclick="DetailsNbr()">
                                        Detalhes
                                    </button>
                                    &nbsp;&nbsp;&nbsp;
                                    <button id="lnkManutencaoNbr" type="button"
                                        class="btn btn-outline-secondary" title="Nobreak"
                                        onclick="MovimentarManutencao(this)">
                                        Manutenção
                                    </button>
                                </p>
                            </div>

                            <div id="pnlGrdAddNobreak">
                                <table id="Table1">
                                    <tr>
                                        <td>
                                            <button id="A1" type="button"
                                                class="btn btn-secondary"
                                                style="margin-bottom: 1rem;"
                                                onclick="CancelNbrk()">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <a style="font-size: 14px;">Selecione o Nobreak que deseja utilizar:</a>
                                </div>

                                <table id="tblAdcNobreak" class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th></th>
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
                                            <input type="text" class="form-control" id="txtNbkNumPat" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fabricante:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtNbkFabricante" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Modelo:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtNbkModelo" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data da Instalação:</td>
                                        <td>
                                            <input type="datetime-local"
                                                class="form-control" id="txtNbkDataInstal" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Garantia:</td>
                                        <td>
                                            <input type="datetime-local"
                                                class="form-control" id="txtNbkDataGarantia" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Autonomia:</td>
                                        <td>
                                            <input type="text" class="form-control" id="txtNbkAutonomia" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Potencia:</td>
                                        <td>
                                            <input type="text" class="form-control" id="txtNbkPotencia" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fixação:</td>
                                        <td>
                                            <select id="ddlNbkFixacao" class="form-control">
                                                <option></option>
                                                <option value="BASE DE CONCRETO">BASE DE CONCRETO</option>
                                                <option value="COLUNA BASE">COLUNA BASE</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Estado Operacional:</td>
                                        <td>
                                            <select id="ddlNbkAtivo" class="form-control">
                                                <option value="Selecione">Selecione</option>
                                                <option value="ATIVO">ATIVO</option>
                                                <option value="INATIVO">INATIVO</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Monitoração:</td>
                                        <td>
                                            <select id="ddlNbkMonitoracao" class="form-control">
                                                <option>SIM</option>
                                                <option>NAO</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table style="font-size: x-small; width: 50%; padding-left: 10px;">
                                    <tr>
                                        <td>
                                            <button id="btnEditNobreak" class="btn btn-success"
                                                type="button" onclick="EditNobreak(this.value)"
                                                value="Salvar">
                                                Salvar
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnApagarNobreak" class="btn btn-danger"
                                                type="button" value="Excluir"
                                                onclick="ApagarNobreak()">
                                                Excluir
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnCancelNbrk" class="btn btn-warning"
                                                type="button" onclick="CancelNbrk()"
                                                value="Cancelar">
                                                Cancelar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </div>

                            <div id="pnlAddNbk">
                                <table id="voltarNbk">
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarAddNbk" type="button"
                                                class="btn btn-secondary"
                                                style="margin-bottom: 1rem;"
                                                onclick="CancelNbrk()">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <button class="btn btn-outline-secondary" type="button"
                                                id="btnImplantacaoNbk" value="Por Implantação"
                                                onclick="ImplantacaoNbk()">
                                                Por Implantação
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-outline-secondary" type="button"
                                                id="btnMovimentacaoNbk" value="Por Movimentação"
                                                data-toggle="modal" data-target="#modalMov"
                                                onclick="modalMovimentacao(this)"
                                                title="Nobreak">
                                                Por Movimentação
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </details>
                </section>

                <section>
                    <details open>
                        <summary>GPRS do Nobreak</summary>
                        <div id="conteudoGPRSDados" class="panel-collapse">
                            <table id="adcGprs">
                                <tr>
                                    <td>
                                        <button id="lnkAdcGPRSnbk" type="button"
                                            class="btn btn-success"
                                            onclick="AdcGPRSnbk()">
                                            Adicionar GPRS
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <div id="pnlAddGprsNbk">
                                <table>
                                    <tr>
                                        <td>
                                            <button id="A2" type="button"
                                                class="btn btn-secondary"
                                                onclick="CancelGprsNbk()"
                                                style="margin-bottom: 1rem;">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <button id="btnImplantacaoGprsNbk" type="button"
                                                class="btn btn-outline-secondary"
                                                value="Por Implantação"
                                                onclick="ImplantacaoGprsNbk()">
                                                Por Implantação
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnMovimentacaoGprsNbk" type="button"
                                                class="btn btn-outline-secondary"
                                                value="Por Movimentação" title="Gprs Nobreak"
                                                data-toggle="modal" data-target="#modalMov"
                                                onclick="modalMovimentacao(this)">
                                                Por Movimentação
                                            </button>
                                        </td>
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
                                <p style="height: 60px;">
                                    <button id="lnkGprs" type="button"
                                        class="btn btn-outline-secondary"
                                        onclick="Gprs()">
                                        Detalhes
                                    </button>
                                    &nbsp;&nbsp;&nbsp;
                                    <button id="lnkGprsMovimentar" title="Gprs"
                                        type="button" class="btn btn-outline-secondary"
                                        onclick="MovimentarManutencao(this)">
                                        Manutenção
                                    </button>
                                </p>
                            </div>

                            <div id="pnlGrdAdcGprsNbk">
                                <table>
                                    <tr>
                                        <td>
                                            <button id="CancelarAddGprs" type="button"
                                                class="btn btn-secondary"
                                                onclick="CancelGprsNbk()"
                                                style="margin-bottom: 1rem;">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <a style="font-size: 14px;">Selecione o GPRS que deseja utilizar:</a>
                                </div>
                                <table id="tblAdcGPRSNbk" class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th></th>
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
                                            <input type="text" id="txtNmrPatGprsNbk"
                                                class="form-control" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número de Série:</td>
                                        <td>
                                            <input type="text" id="txtNmrSerieGprsNbk"
                                                class="form-control" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fabricante:</td>
                                        <td>
                                            <input type="text" id="txtFabricanteGprsNbk"
                                                class="form-control" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Modelo:</td>
                                        <td>
                                            <input type="text" id="txtModeloGprsNbk"
                                                class="form-control" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Nº da linha:</td>
                                        <td>
                                            <input type="tel" id="txtNmrLinhaGprsNbk"
                                                class="form-control" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Operadora:</td>
                                        <td>
                                            <select id="ddlOperadoraGprsNbk" class="form-control">
                                                <option></option>
                                                <option>CLARO</option>
                                                <option>TIM</option>
                                                <option>OI</option>
                                                <option>VIVO</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Instalação:</td>
                                        <td>
                                            <input id="txtDtInstalGprsNbk" type="datetime-local"
                                                class="form-control" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Garantia:</td>
                                        <td>
                                            <input id="txtDtGarantiaGprsNbk" type="datetime-local"
                                                class="form-control" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Estado operacional:</td>
                                        <td>
                                            <select id="ddlEstadoOperacionalGprsNbk" class="form-control">
                                                <option>ATIVO</option>
                                                <option>INATIVO</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table style="margin-left: 10px; width: 50%;">
                                    <tr>
                                        <td>
                                            <button class="btn btn-success" type="button"
                                                id="btnSalvarGprsNbk"
                                                onclick="SalvarGprsNbk(this.value)"
                                                value="Salvar">
                                                Salvar
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-danger" type="button"
                                                id="btnExcluirGprsNbk" value="Excluir"
                                                onclick="ExcluirGprsNbk()">
                                                Excluir
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-warning" type="button"
                                                id="btnCancelGprsNbk" value="Cancelar"
                                                onclick="CancelGprsNbk()">
                                                Cancelar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </div>
                        </div>
                    </details>
                </section>
            </div>

            <div id="Coluna" role="tabpanel"
                class="tab-pane">
                <section>
                    <details open>
                        <summary>Lista de colunas</summary>

                        <div id="conteudoColuna" class="panel-collapse">
                            <table id="tbladcNewcols">
                                <tr>
                                    <td>
                                        <button id="lnkAdcColuna" type="button"
                                            class="btn btn-success"
                                            onclick="AdcColuna()">
                                            Adicionar Coluna
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <div id="pnlAdcColuna">
                                <table>
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarColuna" type="button"
                                                class="btn btn-secondary"
                                                onclick="CancelarColuna()"
                                                style="margin-bottom: 1rem;">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <button class="btn btn-outline-secondary"
                                                type="button" id="btnImplantacaoColuna"
                                                onclick="ImplantacaoColuna()"
                                                value="Por Implantação">
                                                Por Implantação
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-outline-secondary"
                                                type="button" id="btnMovimentacaoColuna"
                                                data-target="#modalMov"
                                                title="Coluna" data-toggle="modal"
                                                onclick="modalMovimentacao(this)"
                                                value="Por Movimentação">
                                                Por Movimentação
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div id="pnlGrdAdcColuna">
                                <table>
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarGrdColuna"
                                                class="btn btn-secondary"
                                                onclick="CancelarColuna()"
                                                style="margin-bottom: 1rem;"
                                                type="button">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <a style="font-size: 14px;">Selecione a Coluna que deseja utilizar:</a>
                                </div>
                                <table id="tblAdcColuna" class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th></th>
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
                                                <input type="number" class="form-control"
                                                    id="txtQtdColuna" title="coluna" min="1"
                                                    max="50000" style="width: 120px;"
                                                    value="1" onchange="verificaQtd(this)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <table style="margin-left: 10px;">
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número Patrimonio:</td>
                                        <td>
                                            <input type="text" class="form-control" id="txtNumPatColuna" />
                                        </td>
                                        <td>
                                            <button id="btnPorParamColuna" class="btn btn-secondary"
                                                type="button" title="coluna" data-toggle="modal"
                                                data-target="#mpParametro" onclick="porParametro(this)"
                                                value="Adicionar por parametro">
                                                Adicionar por parâmetro
                                            </button>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Nº de Série:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtNrSerieColuna"
                                                disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fabricante:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtFabricanteColuna" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Modelo:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtModeloColuna" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fixação:</td>
                                        <td>
                                            <select class="form-control" id="ddlFixacaoColuna">
                                                <option></option>
                                                <option>ENGASTADA</option>
                                                <option>PARAFUSADA</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data da Instalação:</td>
                                        <td>
                                            <input type="datetime-local"
                                                id="txtDtInstalacaoColuna"
                                                class="form-control" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Garantia:</td>
                                        <td>
                                            <input type="datetime-local"
                                                class="form-control"
                                                id="txtDtGarantiaColuna" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Estado Operacional:</td>
                                        <td>
                                            <select class="form-control"
                                                id="ddlEstadoOperacionalColuna">
                                                <option>ATIVO</option>
                                                <option value="INATIVO">INATIVO</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table style="font-size: x-small; width: 50%; margin-left: 10px;">
                                    <tr>
                                        <td>
                                            <button class="btn btn-success"
                                                type="button"
                                                id="btnAddColuna"
                                                onclick="AddColuna(this.value)"
                                                value="Salvar">
                                                Salvar
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-danger"
                                                type="button"
                                                id="btnApagarColuna"
                                                onclick="ApagarColuna()"
                                                value="Excluir">
                                                Excluir
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-warning"
                                                type="button"
                                                id="btnCancelarColuna"
                                                onclick="CancelarColuna()"
                                                value="Cancelar">
                                                Cancelar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </div>

                            <div id="pnlColunas">
                                <p style="margin-bottom: 0;">Nº Patrimonio:</p>
                                <div class="input-group">
                                    <input type="text" id="txtFindColumns"
                                        class="form-control"
                                        onkeyup="FindlistRows('3',this,'tblColunas')"
                                        placeholder="Nº Patrimônio...">
                                    <div class="input-group-append">
                                        <button class="btn btn-secondary"
                                            onclick="FindlistRows('3',this,'tblColunas')">
                                            <i class="ficon ft-search"></i>
                                        </button>
                                    </div>
                                </div>

                                <table id="tblColunas" style="margin-top: 1rem;"
                                    class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Estado Operacional</th>
                                            <th>Nº Patrimonio</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbColunas"></tbody>
                                </table>
                            </div>
                        </div>
                    </details>
                </section>
            </div>

            <div id="Cabos" role="tabpanel"
                class="tab-pane">
                <section>
                    <details open>
                        <summary>Lista de cabos</summary>

                        <div id="conteudoCaboDados" class="panel-collapse">
                            <table id="tblAdcCabo">
                                <tr>
                                    <td>
                                        <button id="lnkAdcCabo" type="button"
                                            class="btn btn-success"
                                            onclick="AdcCabo()">
                                            Adicionar Cabo
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <div id="pnlAdcCabo">
                                <table>
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarCabo" type="button"
                                                class="btn btn-secondary"
                                                style="margin-bottom: 1rem;"
                                                onclick="CancelarCabo()">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <button id="btnImplantacaoCabo" type="button"
                                                class="btn btn-outline-secondary"
                                                onclick="ImplantacaoCabo()"
                                                value="Por Implantação">
                                                Por Implantação
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnMovimentacaoCabo" type="button"
                                                class="btn btn-outline-secondary"
                                                title="Cabo" data-toggle="modal"
                                                data-target="#modalMov"
                                                onclick="modalMovimentacao(this)"
                                                value="Por Movimentação">
                                                Por Movimentação
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div id="pnlGrdAdcCabo">
                                <table>
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarGrdCabo"
                                                class="btn btn-secondary"
                                                onclick="CancelarCabo()"
                                                style="margin-bottom: 1rem;"
                                                type="button">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <a style="font-size: 14px;">Selecione o Cabo que deseja utilizar:</a>
                                </div>
                                <table id="tblAdcCabos" class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th></th>
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
                                                <input type="number" class="form-control"
                                                    min="1" max="50000" id="txtQtdCabo"
                                                    title="cabo" value="1"
                                                    onchange="verificaQtd(this)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <table style="margin-left: 10px;">
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número Patrimonio:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtNumPatCabo" />
                                        </td>
                                        <td>
                                            <button class="btn btn-secondary"
                                                id="btnPorParamCabo" title="cabo"
                                                data-toggle="modal"
                                                data-target="#mpParametro"
                                                onclick="porParametro(this)"
                                                value="Adicionar por parametro"
                                                type="button">
                                                Adicionar por parâmetro
                                            </button>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Nº de Série:</td>
                                        <td>
                                            <input type="number" class="form-control"
                                                id="txtNmrSerieCabo" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fabricante:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtFabricanteCabos" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Modelo:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtModeloCabos" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Instalação:</td>
                                        <td>
                                            <input type="datetime-local"
                                                class="form-control"
                                                id="txtDataInstalacaoCabos" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Garantia:</td>
                                        <td>
                                            <input type="datetime-local"
                                                class="form-control"
                                                id="txtDataGarantiaCabos" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Tipo de Instalação:</td>
                                        <td>
                                            <select class="form-control" id="ddlInstalacaoCabos">
                                                <option>MISTA</option>
                                                <option>AEREA</option>
                                                <option>SUBTERRANEA</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Meio de Instalação:</td>
                                        <td>
                                            <select class="form-control"
                                                id="ddlMeioInstalacaoCabos">
                                                <option>SUPORTES COM ROLDANAS</option>
                                                <option>CAIXA DE PASSAGEM</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Metros:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtMetrosCabos" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Estado Operacional:</td>
                                        <td>
                                            <select class="form-control"
                                                id="ddlEstadoOperacionalCabos">
                                                <option>ATIVO</option>
                                                <option>INATIVO</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table style="font-size: x-small; width: 50%; margin-left: 10px;">
                                    <tr>
                                        <td>
                                            <button id="btnSalvarCabos" class="btn btn-success"
                                                type="button" onclick="AddCabos(this.value)"
                                                value="Salvar">
                                                Salvar
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnApagarCabos" class="btn btn-danger"
                                                type="button" onclick="ApagarCabos()"
                                                value="Excluir">
                                                Excluir
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnCancelarCabo" class="btn btn-warning"
                                                type="button" onclick="CancelarCabo()"
                                                value="Cancelar">
                                                Cancelar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </div>

                            <div id="pnlCabos">
                                <p style="margin-bottom: 0; margin-top: 1rem;">Nº Patrimonio:</p>
                                <div class="input-group">
                                    <input type="text" id="txtFindCabos"
                                        class="form-control"
                                        onkeyup="FindlistRows('4',this,'tblCabos')"
                                        placeholder="Nº Patrimonio...">
                                    <div class="input-group-append">
                                        <button class="btn btn-secondary"
                                            onclick="FindlistRows('4',this,'tblCabos')">
                                            <i class="ficon ft-search"></i>
                                        </button>
                                    </div>
                                </div>
                                <table id="tblCabos" style="margin-top: 1rem;"
                                    class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th>Metros</th>
                                            <th>Nº Patrimonio</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbCabos"></tbody>
                                </table>
                            </div>
                        </div>
                    </details>
                </section>
            </div>

            <div id="GrupoFocal" role="tabpanel"
                class="tab-pane">
                <section>
                    <details open>
                        <summary>Lista de Grupo Focal</summary>

                        <div id="conteudoGrupoFocal" class="panel-collapse">
                            <table id="tblAdcGf">
                                <tr>
                                    <td>
                                        <button id="lnkAdcGrupoFocal"
                                            class="btn btn-success"
                                            onclick="AdcGrupoFocal()"
                                            type="button">
                                            Adicionar Grupo Focal
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <div id="pnlAdcGrupoFocal">
                                <table>
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarGrupoFocal"
                                                class="btn btn-secondary"
                                                onclick="CancelarGF()"
                                                style="margin-bottom: 1rem;"
                                                type="button">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <button id="btnImplantacaoGF"
                                                class="btn btn-outline-secondary"
                                                value="Por Implantação"
                                                onclick="ImplantacaoGF()"
                                                type="button">
                                                Por Implantação
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnMovimentacaoGF"
                                                class="btn btn-outline-secondary"
                                                value="Por Movimentação"
                                                title="Grupo Focal"
                                                data-toggle="modal"
                                                data-target="#modalMov"
                                                onclick="modalMovimentacao(this)"
                                                type="button">
                                                Por Movimentação
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div id="pnlGrdAdcGrupoFocal">
                                <table>
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarGrdGrupoFocal"
                                                type="button"
                                                style="margin-bottom: 1rem;"
                                                class="btn btn-secondary"
                                                onclick="CancelarGF()">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <a style="font-size: 14px;">Selecione o Grupo Focal que deseja utilizar:</a>
                                </div>
                                <table id="tblAdcGrupoFocal" class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th></th>
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
                                                <input type="number" min="1" max="50000"
                                                    class="form-control"
                                                    id="txtQtdGrupoFocal"
                                                    title="gf" value="1"
                                                    onchange="verificaQtd(this)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <table style="margin-left: 10px;">
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número Patrimonio:</td>
                                        <td>
                                            <input type="text" id="txtNumPatGF"
                                                class="form-control" />
                                        </td>
                                        <td>
                                            <button class="btn btn-secondary"
                                                id="btnPorParamGF"
                                                value="Adicionar por parametro"
                                                title="Grupo Focal"
                                                data-toggle="modal"
                                                data-target="#mpParametro"
                                                onclick="porParametro(this)"
                                                type="button">
                                                Adicionar por parâmetro
                                            </button>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Nº de Série:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtNrSerieGrupoFocal"
                                                disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fabricante:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtFabricanteGrupoFocal"
                                                disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Modelo:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtModeloGrupoFocal"
                                                disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Instalação: </td>
                                        <td>
                                            <input type="datetime-local" class="form-control"
                                                id="txtDtInstalacaoGrupoFocal" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Garantia:</td>
                                        <td>
                                            <input type="datetime-local" class="form-control"
                                                id="txtDtGarantiaGrupoFocal" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Estado Operacional: </td>
                                        <td>
                                            <select id="ddlEstadoOperacionalGrupoFocal"
                                                class="form-control">
                                                <option>ATIVO</option>
                                                <option>INATIVO</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table style="margin-left: 10px;">
                                    <tr style="height: 60px;">
                                        <td>
                                            <button id="btnEditGrupoFocal"
                                                class="btn btn-success"
                                                type="button"
                                                onclick="EditGrupoFocal(this.value)"
                                                value="Salvar">
                                                Salvar
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnApagarGrupoFocal"
                                                class="btn btn-danger" type="button"
                                                onclick="ApagarGrupoFocal()"
                                                value="Excluir">
                                                Excluir
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnCancelarGF"
                                                class="btn btn-warning"
                                                type="button"
                                                onclick="CancelarGF()"
                                                value="Cancelar">
                                                Cancelar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </div>

                            <div id="pnlGrupoFocal">
                                <p style="margin-bottom: 0; margin-top: 1rem;">Nº Patrimonio:</p>
                                <div class="input-group">
                                    <input type="text" id="txtfindGrupoFocal"
                                        class="form-control"
                                        onkeyup="FindlistRows('4',this,'tblGrupoFocal')"
                                        placeholder="Nº Patrimonio...">
                                    <div class="input-group-append">
                                        <button class="btn btn-secondary"
                                            onclick="FindlistRows('4',this,'tblGrupoFocal')">
                                            <i class="ficon ft-search"></i>
                                        </button>
                                    </div>
                                </div>
                                <table id="tblGrupoFocal" class="table table-bordered mb-0"
                                    style="margin-top: 1rem;">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th>Estado Operacional</th>
                                            <th>Nº Patrimonio</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbGrupoFocal"></tbody>
                                </table>
                            </div>
                        </div>
                    </details>
                </section>
            </div>

            <div id="SistemaIluminacao" role="tabpanel"
                class="tab-pane">
                <section>
                    <details open>
                        <summary>Sistema de Iluminação</summary>

                        <div id="conteudoSI" class="panel-collapse">
                            <table id="tblAdcIlu">
                                <tr>
                                    <td>
                                        <button id="lnkAdcIluminacao"
                                            onclick="AdcIluminacao()"
                                            class="btn btn-success"
                                            type="button">
                                            Adicionar Sistema de Iluminação
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <div id="pnlAdcIluminacao">
                                <table>
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarIlu"
                                                class="btn btn-secondary"
                                                onclick="CancelSistemaIlu()"
                                                style="margin-bottom: 1rem;"
                                                type="button">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <button class="btn btn-outline-secondary"
                                                id="btnImplantacaoIlu"
                                                value="Por Implantação"
                                                onclick="ImplantacaoIlu()"
                                                type="button">
                                                Por Implantação
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-outline-secondary"
                                                id="btnMovimentacaoIlu"
                                                value="Por Movimentação"
                                                title="Sistema de Iluminação"
                                                data-toggle="modal"
                                                data-target="#modalMov"
                                                onclick="modalMovimentacao(this)"
                                                type="button">
                                                Por Movimentação
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div id="pnlGrdAdcIluminacao">
                                <table>
                                    <tr>
                                        <td>
                                            <button id="lnkCancelarGrdAdcIlu"
                                                class="btn btn-secondary"
                                                onclick="CancelSistemaIlu()"
                                                style="margin-bottom: 1rem;"
                                                type="button">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <a style="font-size: 14px; margin-bottom: 0;">Selecione o Sistema de Iluminação que deseja utilizar:</a>
                                </div>
                                <table id="tblAdcIluminacao" class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th></th>
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
                                                <input type="number" min="1" max="50000"
                                                    class="form-control" id="txtQtdIlum"
                                                    title="iluminacao"
                                                    onchange="verificaQtd(this)"
                                                    value="1" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <table style="margin-left: 10px;">
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número Patrimonio:</td>
                                        <td>
                                            <input type="text" id="txtNumPatSI"
                                                class="form-control" />
                                        </td>
                                        <td>
                                            <button class="btn btn-secondary"
                                                id="btnPorParamSI"
                                                onclick="porParametro(this)"
                                                title="sistema de iluminação"
                                                data-toggle="modal"
                                                data-target="#mpParametro"
                                                value="Adicionar por parametro"
                                                type="button">
                                                Adicionar por parâmetro
                                            </button>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número de Série:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtIluNumeroSerie" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fabricante:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtIluFabricante" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Modelo:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtIluModelo" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Instalação:</td>
                                        <td>
                                            <input type="datetime-local" class="form-control"
                                                id="txtIluDtInstalacao" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data de Garantia:</td>
                                        <td>
                                            <input type="datetime-local" class="form-control"
                                                id="txtIluDtGarantia" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Tensão instalada:</td>
                                        <td>
                                            <select id="ddlIluTensao" class="form-control">
                                                <option>220V/230V</option>
                                                <option>127V/115V</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px;">
                                        <td>Estado Operacional:</td>
                                        <td>
                                            <select id="ddlIluAtivo" class="form-control">
                                                <option value="ATIVO">ATIVO</option>
                                                <option value="INATIVO">INATIVO</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table style="font-size: x-small; width: 50%; margin-left: 10px;">
                                    <tr>
                                        <td>
                                            <button class="btn btn-success"
                                                id="btnSalvarIlu" value="Salvar"
                                                onclick="SalvarIlu(this.value)"
                                                type="button">
                                                Salvar
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-danger"
                                                id="btnApagarSistemaIlu"
                                                value="Excluir"
                                                onclick="ApagarSistemaIlu()"
                                                type="button">
                                                Excluir
                                            </button>
                                        </td>
                                        <td>
                                            <button class="btn btn-warning"
                                                id="btnCancelIlu"
                                                value="Cancelar"
                                                onclick="CancelSistemaIlu()"
                                                type="button">
                                                Cancelar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </div>

                            <div id="pnlIluminacao">
                                <p style="margin-bottom: 0; margin-top: 1rem;">Nº Patrimonio:</p>
                                <div class="input-group">
                                    <input type="text" id="txtFindIluminacao"
                                        class="form-control"
                                        onkeyup="FindlistRows('4',this,'tblIluminacao')"
                                        placeholder="Nº Patrimonio...">
                                    <div class="input-group-append">
                                        <button class="btn btn-secondary"
                                            onclick="FindlistRows('4',this,'tblIluminacao')">
                                            <i class="ficon ft-search"></i>
                                        </button>
                                    </div>
                                </div>
                                <table id="tblIluminacao" class="table table-bordered mb-0"
                                    style="margin-top: 1rem;">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th>Estado operacional</th>
                                            <th>Nº Patrimonio</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbIluminacao"></tbody>
                                </table>
                                <br />
                            </div>
                        </div>
                    </details>
                </section>
            </div>

            <div id="Acessorios" role="tabpanel"
                class="tab-pane">
                <section>
                    <details open>
                        <summary>Lista de Acessórios</summary>

                        <div id="conteudoAcessorio" class="panel-collapse">
                            <table id="tblNewAcess">
                                <tr>
                                    <td>
                                        <button type="button"
                                            class="btn btn-success"
                                            id="lnkAdcAcess"
                                            onclick="AdcAcess()">
                                            Adicionar Acessórios
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <div id="pnlAdcAcess">
                                <table>
                                    <tr>
                                        <td>
                                            <button type="button"
                                                class="btn btn-secondary"
                                                id="lnkCancelarAcess"
                                                style="margin-bottom: 1rem;"
                                                onclick="CancelAcess()">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <button id="btnImplantacaoAcess"
                                                class="btn btn-outline-secondary"
                                                value="Por Implantação"
                                                onclick="ImplantacaoAcess()"
                                                type="button">
                                                Por Implantação
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnMovimentacaoAcess"
                                                class="btn btn-outline-secondary"
                                                value="Por Movimentação"
                                                title="Acessorio"
                                                data-toggle="modal"
                                                data-target="#modalMov"
                                                onclick="modalMovimentacao(this)"
                                                type="button">
                                                Por Movimentação
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div id="pnlGrdAdcAcess">
                                <table style="margin-top: 4px; margin-bottom: 4px;">
                                    <tr>
                                        <td>
                                            <button type="button" class="btn btn-secondary"
                                                id="lnkCancelarGrdAdcAcess"
                                                style="margin-bottom: 1rem;"
                                                onclick="CancelAcess()">
                                                Voltar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <div style="margin-bottom: 0;">
                                    <a style="font-size: 14px;">Selecione o Acessorio que deseja utilizar:</a>
                                </div>
                                <table id="tblAdcAcessorios" class="table table-bordered mb-0">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th></th>
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
                                                <input type="number" min="1" max="50000"
                                                    class="form-control" id="txtQtdAcess"
                                                    title="acessorio" value="1"
                                                    onchange="verificaQtd(this)" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <table style="margin-left: 10px;">
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número Patrimonio:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtNumPatAcess" />
                                        </td>
                                        <td>
                                            <button class="btn btn-secondary"
                                                id="btnPorParamAcess"
                                                value="Adicionar por parametro"
                                                title="acessório" data-toggle="modal"
                                                data-target="#mpParametro"
                                                onclick="porParametro(this)"
                                                type="button">
                                                Adicionar por parâmetro
                                            </button>
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Nome do Acessório:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtNomeAcessorio" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Número de Série:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtAcessNumSerie" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Fabricante:</td>
                                        <td>
                                            <input type="text" class="form-control"
                                                id="txtFabricanteAcess" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr style="height: 60px; border-bottom: 1px solid #d8d8d8;">
                                        <td>Data da Instalação:</td>
                                        <td>
                                            <input type="datetime-local" class="form-control"
                                                id="txtDataInstalAcess" />
                                        </td>
                                    </tr>
                                </table>
                                <div id="pnlLuminaria">
                                    <table style="margin-left: 10px; border-bottom: 1px solid #d8d8d8;">
                                        <tr style="height: 60px;">
                                            <td>Fixação: </td>
                                            <td>
                                                <select class="form-control" id="cboLuminariaFixacao">
                                                    <option>PROJETADA</option>
                                                    <option>COLUNA</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <br />
                                <table style="font-size: x-small; width: 50%; margin-left: 10px;">
                                    <tr>
                                        <td>
                                            <button id="btnSalvarAcessorio" type="button"
                                                class="btn btn-success"
                                                onclick="AdicionarAcessorio(this.value)"
                                                value="Salvar">
                                                Salvar
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnExcluirAcessorios" type="button"
                                                class="btn btn-danger" value="Excluir"
                                                onclick="DeleteAcessorios()">
                                                Excluir
                                            </button>
                                        </td>
                                        <td>
                                            <button id="btnCancelAcess" type="button"
                                                class="btn btn-warning"
                                                onclick="CancelAcess()"
                                                value="Cancelar">
                                                Cancelar
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </div>

                            <div id="pnlAcessorios">
                                <p style="margin-bottom: 0; margin-top: 1rem;">Nº Patrimonio:</p>
                                <div class="input-group">
                                    <input type="text" id="txtFindNPatAcessorios"
                                        class="form-control"
                                        onkeyup="FindlistRows('3',this,'tblAcessorios')"
                                        placeholder="Nº Patrimonio...">
                                    <div class="input-group-append">
                                        <button class="btn btn-secondary"
                                            onclick="FindlistRows('3',this,'tblAcessorios')">
                                            <i class="ficon ft-search"></i>
                                        </button>
                                    </div>
                                </div>
                                <table id="tblAcessorios" class="table table-bordered mb-0"
                                    style="margin-top: 1rem;">
                                    <thead>
                                        <tr>
                                            <th>Produto</th>
                                            <th>Modelo</th>
                                            <th>Fabricante</th>
                                            <th>Nº Patrimonio</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbAcessorios"></tbody>
                                </table>
                            </div>
                        </div>
                    </details>
                </section>
            </div>

            <div id="Etiquetas" role="tabpanel"
                class="tab-pane">
                <section>
                    <details open>
                        <summary>Etiquetas</summary>

                        <div id="conteudoEtiqueta" class="panel-collapse">
                            <table style="margin-left: 10px; height: 60px; margin-top: 10px;">
                                <tr style="height: 60px;">
                                    <td>EPC:
                                        <input type="text" id="txtEpc"
                                            class="form-control" />
                                    </td>
                                    <td>
                                        <img id="imgPesquisar" src="../../Images/search.png"
                                            onclick="findTag();"
                                            style="width: 32px; height: 32px; cursor: pointer; margin-top: 1.4rem;" />
                                    </td>
                                </tr>
                                <tr id="newCad" style="height: 60px;">
                                    <td>
                                        <button id="btnNew" class="btn btn-success"
                                            type="button" onclick="NewTag();"
                                            style="margin-top: 1rem;"
                                            value="Nova Etiqueta">
                                            Nova Etiqueta
                                        </button>
                                    </td>
                                </tr>
                            </table>

                            <div id="divTag">
                                <p style="margin-top: 5px;">
                                    <button id="btnSaveTag" class="btn btn-success"
                                        type="button" value="Confirmar"
                                        onclick="InsertTag();">
                                        Confirmar
                                    </button>
                                    <button id="btnVoltar" class="btn btn-warning"
                                        type="button" onclick="Voltar();"
                                        value="Voltar">
                                        Voltar
                                    </button>
                                </p>
                                <table id="tblTag" class="table table-bordered mb-0">
                                    <thead id="thTag">
                                        <tr>
                                            <th>EPC</th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbTag" style="display: none;"></tbody>
                                    <tfoot id="tfTag">
                                        <tr>
                                            <td colspan="3">Nenhuma Etiqueta encontrada!
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </details>
                </section>
            </div>

            <div id="ImagemCruzamento" role="tabpanel"
                class="tab-pane">
                <section>
                    <details open>
                        <summary>Imagens do Cruzamento</summary>

                        <div id="conteudoIamgens" class="panel-collapse" style="padding: 10px;">
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
                            <div id="divImagemLocal_Upload" style="display: none; padding-top: 10px; width: 100%">
                                <%-- <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="customFile" lang="pt-br">
                                    <label class="custom-file-label" for="customFile" data-browse="Buscar">Selecione os Arquivos</label>
                                </div>--%>
                                <div id="actions" class="row">
                                    <div class="col-lg-7">
                                        <!-- The fileinput-button span is used to style the file input field as button -->
                                        <span class="btn btn-success fileinput-button" id="btnAddImagem">
                                            <i class="glyphicon glyphicon-plus"></i>
                                            <span>Add arquivos...</span>
                                        </span>
                                        <button id="btnIniciarUpload" style="display: none;" type="submit" class="btn btn-primary start">
                                            <i class="glyphicon glyphicon-upload"></i>
                                            <span>Iniciar upload</span>
                                        </button>
                                        <button id="btnCancelarUpload" style="display: none;" type="reset" class="btn btn-warning cancel">
                                            <i class="glyphicon glyphicon-ban-circle"></i>
                                            <span>Cancelar upload</span>
                                        </button>
                                    </div>

                                    <div class="col-lg-5" style="display: none">
                                        <!-- The global file processing state -->
                                        <span class="fileupload-process">
                                            <div id="total-progress" class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                                <div class="progress-bar progress-bar-success" style="width: 0%;" data-dz-uploadprogress></div>
                                            </div>
                                        </span>
                                    </div>
                                </div>

                                <div class="table table-striped files" id="previews">
                                    <div id="template" class="file-row">
                                        <!-- This is used as the file preview template -->
                                        <div>
                                            <span class="preview">
                                                <img data-dz-thumbnail /></span>
                                        </div>
                                        <div>
                                            <p class="name" data-dz-name></p>
                                            <strong class="error text-danger" data-dz-errormessage></strong>
                                        </div>
                                        <div>
                                            <p class="size" data-dz-size></p>
                                            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                                <div class="progress-bar progress-bar-success" style="width: 0%;" data-dz-uploadprogress></div>
                                            </div>
                                        </div>
                                        <div>
                                            <button style="display: none;" class="btn btn-primary start">
                                                <i class="glyphicon glyphicon-upload"></i>
                                                <span>Iniciar</span>
                                            </button>
                                            <button style="display: none;" data-dz-remove class="btn btn-warning cancel">
                                                <i class="glyphicon glyphicon-ban-circle"></i>
                                                <span>Cancelar</span>
                                            </button>
                                            <button data-dz-remove class="btn btn-danger delete">
                                                <i class="glyphicon glyphicon-trash"></i>
                                                <span>Excluir</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div id="divImagemLocal" class="">
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
                    </details>
                </section>
            </div>

            <div id="ProjetoCruzamento" role="tabpanel"
                class="tab-pane">
                <section>
                    <details open>
                        <summary>Projetos do Cruzamento</summary>

                        <div id="divProjetos" class="panel-collapse" style="padding: 10px;">
                            <table class="table table-bordered">
                                <tr>
                                    <td style="width: 158px;">
                                        <button id="btnAdicionarProjeto" onclick="btnAdicionarProjeto_Click();" type="button" class="btn btn-default">Adicionar Projeto</button></td>
                                </tr>
                            </table>
                            <div id="divProjeto_Upload" style="display: none; padding-top: 10px; width: 100%">

                                <div id="actionsProjeto" class="row">
                                    <div class="col-lg-7">
                                        <!-- The fileinput-button span is used to style the file input field as button -->
                                        <span class="btn btn-success fileinput-button-projeto" id="btnAddImagemProjeto">
                                            <i class="glyphicon glyphicon-plus"></i>
                                            <span>Add arquivos...</span>
                                        </span>
                                        <button id="btnIniciarUploadProjeto" style="display: none;" type="submit" class="btn btn-primary start">
                                            <i class="glyphicon glyphicon-upload"></i>
                                            <span>Iniciar upload</span>
                                        </button>
                                        <button id="btnCancelarUploadProjeto" style="display: none;" type="reset" class="btn btn-warning cancel">
                                            <i class="glyphicon glyphicon-ban-circle"></i>
                                            <span>Cancelar upload</span>
                                        </button>
                                    </div>

                                    <div class="col-lg-5" style="display: none">
                                        <!-- The global file processing state -->
                                        <span class="fileupload-process">
                                            <div id="total-progressProjeto" class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                                <div class="progress-bar progress-bar-success" style="width: 0%;" data-dz-uploadprogress></div>
                                            </div>
                                        </span>
                                    </div>
                                </div>

                                <div class="table table-striped files" id="previewsProjeto">
                                    <div id="templateProjeto" class="file-row">
                                        <!-- This is used as the file preview template -->
                                        <div>
                                            <span class="preview">
                                                <img data-dz-thumbnail /></span>
                                        </div>
                                        <div>
                                            <p class="name" data-dz-name></p>
                                            <strong class="error text-danger" data-dz-errormessage></strong>
                                        </div>
                                        <div>
                                            <p class="size" data-dz-size></p>
                                            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                                <div class="progress-bar progress-bar-success" style="width: 0%;" data-dz-uploadprogress></div>
                                            </div>
                                        </div>
                                        <div>
                                            <button style="display: none;" class="btn btn-primary start">
                                                <i class="glyphicon glyphicon-upload"></i>
                                                <span>Iniciar</span>
                                            </button>
                                            <button style="display: none;" data-dz-remove class="btn btn-warning cancel">
                                                <i class="glyphicon glyphicon-ban-circle"></i>
                                                <span>Cancelar</span>
                                            </button>
                                            <button data-dz-remove class="btn btn-danger delete">
                                                <i class="glyphicon glyphicon-trash"></i>
                                                <span>Excluir</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="divListaProjeto" style="padding-top: 10px; display: block;" class="panel-collapse collapse in">
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
                    </details>
                </section>
            </div>

            <div id="ArquivoCruzamento" role="tabpanel"
                class="tab-pane">
                <section>
                    <details open>
                        <summary>Arquivos do Cruzamento</summary>

                        <div id="divArquivos" class="panel-collapse" style="padding: 10px;">
                            <table class="table table-bordered">
                                <tr>
                                    <td style="width: 158px;">
                                        <button id="btnAdicionarArquivos" onclick="btnAdicionarArquivos_Click();" type="button" class="btn btn-default">Adicionar Arquivo</button></td>


                                </tr>
                            </table>
                            <div id="divArquivo_Upload" style="display: none; padding-top: 10px;">

                                <div id="actionsArquivo" class="row">
                                    <div class="col-lg-7">
                                        <!-- The fileinput-button span is used to style the file input field as button -->
                                        <span class="btn btn-success fileinput-button-arquivo" id="btnAddImagemArquivo">
                                            <i class="glyphicon glyphicon-plus"></i>
                                            <span>Add arquivos...</span>
                                        </span>
                                        <button id="btnIniciarUploadArquivo" style="display: none;" type="submit" class="btn btn-primary start">
                                            <i class="glyphicon glyphicon-upload"></i>
                                            <span>Iniciar upload</span>
                                        </button>
                                        <button id="btnCancelarUploadArquivo" style="display: none;" type="reset" class="btn btn-warning cancel">
                                            <i class="glyphicon glyphicon-ban-circle"></i>
                                            <span>Cancelar upload</span>
                                        </button>
                                    </div>

                                    <div class="col-lg-5" style="display: none">
                                        <!-- The global file processing state -->
                                        <span class="fileupload-process">
                                            <div id="total-progressArquivo" class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                                <div class="progress-bar progress-bar-success" style="width: 0%;" data-dz-uploadprogress></div>
                                            </div>
                                        </span>
                                    </div>
                                </div>

                                <div class="table table-striped files" id="previewsArquivo">
                                    <div id="templateArquivo" class="file-row">
                                        <!-- This is used as the file preview template -->
                                        <div>
                                            <span class="preview">
                                                <img data-dz-thumbnail /></span>
                                        </div>
                                        <div>
                                            <p class="name" data-dz-name></p>
                                            <strong class="error text-danger" data-dz-errormessage></strong>
                                        </div>
                                        <div>
                                            <p class="size" data-dz-size></p>
                                            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                                <div class="progress-bar progress-bar-success" style="width: 0%;" data-dz-uploadprogress></div>
                                            </div>
                                        </div>
                                        <div>
                                            <button style="display: none;" class="btn btn-primary start">
                                                <i class="glyphicon glyphicon-upload"></i>
                                                <span>Iniciar</span>
                                            </button>
                                            <button style="display: none;" data-dz-remove class="btn btn-warning cancel">
                                                <i class="glyphicon glyphicon-ban-circle"></i>
                                                <span>Cancelar</span>
                                            </button>
                                            <button data-dz-remove class="btn btn-danger delete">
                                                <i class="glyphicon glyphicon-trash"></i>
                                                <span>Excluir</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="divListaArquivo" style="padding-top: 10px; display:block" class="panel-collapse collapse in">
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

                    </details>
                </section>
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
                    <p style="margin-top: 10px; border-bottom: 1px solid darkgray;">Produto:<span id="lblProd" style="padding-left: 10px;"></span></p>
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
                                    <input type="text" class="form-control" id="txtSubdivisaoMov" placeholder="Informe id do local" style="width: 200px;" />
                                </td>
                                <td>
                                    <img id="img1" onclick="FindSubdivisaoMov()" style="width: 32px; height: 28px; cursor: pointer;" src="../../Images/search.png" />
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
                                    <img id="imgFindNmtPat" onclick="FindNmrPatMov()" style="width: 32px; height: 28px; cursor: pointer;" src="../../Images/search.png" />
                                </td>
                            </tr>
                        </table>
                        <table style="margin-top: 4px; border-bottom: 1px solid darkgray; width: 100%;">
                            <tr>
                                <td style="padding-left: 4px;">Origem do Produto:
                                </td>
                                <td style="padding-bottom: 4px;">
                                    <input class="btn btn-default" type="button" id="btnAlmox" style="height: 32px; width: 180px;" onclick="Almoxarifado()" value="Almoxarifado" />
                                </td>
                                <td style="padding-bottom: 4px;">
                                    <input class="btn btn-default" type="button" id="btnManutencao" style="height: 32px; width: 180px;" onclick="Manutencao()" value="Manutenção" />
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
            <div class="modal-content">
                <div class="modal-header" style="border-bottom: 1px solid rgba(0,0,0,.1);">
                    <h4 class="modal-title">Manutenção&nbsp;
                        <span id="lblprodManutencao"></span>
                    </h4>
                    <button type="button" class="close" data-dismiss="modal">
                        &times;
                    </button>
                </div>
                <div class="modal-body" style="height: 500px;">

                    <div style="margin: -15px -15px -15px; width: 250px; padding: 8px 0 0 10px; overflow-y: scroll; overflow-x: hidden; height: 500px;">
                        <ul id="menu" class="nav nav-list">
                        </ul>
                    </div>
                    <table style="margin-left: 250px; margin-top: -480px;">
                        <tr>
                            <td>Subdivisão Selecionada:&nbsp;<span id="lblSubSelecionada"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Motivo:&nbsp;
                                <select id="txtMotivo" class="form-control">
                                </select>
                                &nbsp;Ocorrência:&nbsp;
                                <textarea id="txtOcorrencia" class="form-control">
                                </textarea>&nbsp;<br />
                            </td>
                        </tr>
                    </table>

                </div>
                <div class="modal-footer" style="border-top: 1px solid rgba(0,0,0,.1);">
                    <button type="button" class="btn btn-success" onclick="salvarManutencao()"
                        data-dismiss="modal">
                        Movimentar
                    </button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        Fechar
                    </button>
                </div>
            </div>
        </div>
    </div>

    <%--MODAL ADICIONAR POR PARÂMETRO--%>
    <div class="modal fade" id="mpParametro" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="border-bottom: 1px solid rgba(0,0,0,.1);">
                    <h4 class="modal-title">Adicionar por Parâmetro</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <div class="modal-body">
                    <div style="padding-left: 4px; margin-top: 10px;">
                        <b>Produto:</b>
                        <label id="lblProdParam"></label>
                    </div>
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
                                <button id="btnSalvarPatrimonio" class="btn btn-success"
                                    type="button" value="Salvar" onclick="SalvarPatParametro()">
                                    Salvar
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer" style="border-top: 1px solid rgba(0,0,0,.1);">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        Fechar
                    </button>
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

    <%-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1"></script>
    --%>

    <%--<script src="lightbox2/dist/js/lightbox-plus-jquery.min.js"></script>--%>


    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>--%>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.0.9/js/plugins/piexif.min.js" type="text/javascript"></script>--%>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>


    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.0.9/js/plugins/piexif.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.0.9/js/plugins/sortable.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.0.9/js/fileinput.min.js"></script>--%>
    <%--<script src="dropzone-5.7.0/dist/dropzone.js"></script>--%>
    <%--<script src="../../app-assets/js/scripts/extensions/dropzone.min.js"></script>--%>
    <%--<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/locales/bootstrap-datepicker.pt-BR.min.js"></script>--%>
    <%--<script src="clockpicker/bootstrap-clockpicker.js"></script>--%>
    <script src="DnaOmega.js"></script>
    <script type="text/javascript">
        $(function () {

            $("#txtIdLocal").val(document.getElementById("hfIdDna").value);
            if ($("#hfIdOcorrencia").val() != "") {
                $("#IdRedirectGSS").text("Ocorrência: " + $("#hfIdOcorrencia").val());
                FindDNA();
            }
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/GetDepartament',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
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

            //#region upload image
            // Get the template HTML and remove it from the doumenthe template HTML and remove it from the doument
            var previewNode = document.querySelector("#template");
            previewNode.id = "";
            var previewTemplate = previewNode.parentNode.innerHTML;
            previewNode.parentNode.removeChild(previewNode);

            var myDropzone = new Dropzone(document.getElementById("btnAddImagem"), { // Make the whole body a dropzone
                url: 'DefaultOmega.aspx', // Set the url
                thumbnailWidth: 30,
                thumbnailHeight: 30,
                parallelUploads: 20,
                previewTemplate: previewTemplate,
                maxFilesize: 2,
                autoQueue: false, // Make sure the files aren't queued until manually added
                previewsContainer: "#previews", // Define the container to display the previews
                clickable: ".fileinput-button" // Define the element that should be used as click trigger to select files.
            });

            myDropzone.on("addedfile", function (file) {
                // Hookup the start button
                file.previewElement.querySelector(".start").onclick = function () { myDropzone.enqueueFile(file); };
                $("#btnIniciarUpload").css("display", "inline");
            });

            // Update the total progress bar
            myDropzone.on("totaluploadprogress", function (progress) {
                document.querySelector("#total-progress .progress-bar").style.width = progress + "%";
            });

            myDropzone.on("sending", function (file) {
                // Show the total progress bar when upload starts
                document.querySelector("#total-progress").style.opacity = "1";
                // And disable the start button
                file.previewElement.querySelector(".start").setAttribute("disabled", "disabled");

                var name = file.name;
                var reader = new FileReader();
                reader.onload = function (e) {
                    var base64 = e.target.result;
                    base64 = base64.replace(/^[^,]*,/, '');
                    if (TipoUpload == "Imagem") {
                        $.ajax({
                            type: 'POST',
                            async: true,
                            //Chamar o webmethod SalvarImagem em webservice.asmx
                            url: '../../WebServices/Materiais.asmx/SalvarImagemCruzamento',
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            //enviar o base64 como parâmetro
                            data: "{'base64':'" + JSON.stringify(base64) + "','NomeArquivo':'" + name + "','IdDepartamento':'" + idDepartamento + "','IdSubDivisao':'" + document.getElementById("hfIdSub").value + "'}",
                            success: function (data) {
                            }
                            , error: function (xmlHttpRequest, status, err) {
                            }
                        });
                    }

                }
                reader.readAsDataURL(file);

            });

            // Hide the total progress bar when nothing's uploading anymore
            myDropzone.on("queuecomplete", function (progress) {
                document.querySelector("#total-progress").style.opacity = "0";
                if (TipoUpload == "Imagem") {
                    CarregarListaDatasImagem();
                }
                btnAdicionarImagem_Click();
                myDropzone.removeAllFiles(true);
            });

            // Setup the buttons for all transfers
            // The "add files" button doesn't need to be setup because the config
            // `clickable` has already been specified.
            document.querySelector("#actions .start").onclick = function () {
                myDropzone.enqueueFiles(myDropzone.getFilesWithStatus(Dropzone.ADDED));
            };
            document.querySelector("#actions .cancel").onclick = function () {
                myDropzone.removeAllFiles(true);
            };
            //#endregion

            //#region upload Projeto
            // Get the template HTML and remove it from the doumenthe template HTML and remove it from the doument
            var previewNode = document.querySelector("#templateProjeto");
            previewNode.id = "";
            var previewTemplate = previewNode.parentNode.innerHTML;
            previewNode.parentNode.removeChild(previewNode);

            var myDropzoneProjeto = new Dropzone(document.getElementById("btnAddImagemProjeto"), { // Make the whole body a dropzone
                url: 'DefaultOmega.aspx', // Set the url
                thumbnailWidth: 30,
                thumbnailHeight: 30,
                parallelUploads: 20,
                previewTemplate: previewTemplate,
                maxFilesize: 2,
                autoQueue: false, // Make sure the files aren't queued until manually added
                previewsContainer: "#previewsProjeto", // Define the container to display the previews
                clickable: ".fileinput-button-projeto" // Define the element that should be used as click trigger to select files.
            });

            myDropzoneProjeto.on("addedfile", function (file) {
                // Hookup the start button
                file.previewElement.querySelector(".start").onclick = function () { myDropzoneProjeto.enqueueFile(file); };
                $("#btnIniciarUploadProjeto").css("display", "inline");
            });

            // Update the total progress bar
            myDropzoneProjeto.on("totaluploadprogress", function (progress) {
                document.querySelector("#total-progressProjeto .progress-bar").style.width = progress + "%";
            });

            myDropzoneProjeto.on("sending", function (file) {
                // Show the total progress bar when upload starts
                document.querySelector("#total-progressProjeto").style.opacity = "1";
                // And disable the start button
                file.previewElement.querySelector(".start").setAttribute("disabled", "disabled");

                var name = file.name;
                var reader = new FileReader();
                reader.onload = function (e) {
                    var base64 = e.target.result;
                    base64 = base64.replace(/^[^,]*,/, '');
                    if (TipoUpload == "Projeto") {
                        $.ajax({
                            type: 'POST',
                            async: true,
                            //Chamar o webmethod SalvarImagem em webservice.asmx
                            url: '../../WebServices/Materiais.asmx/SalvarProjetoCruzamento',
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            //enviar o base64 como parâmetro
                            data: "{'base64':'" + JSON.stringify(base64) + "','NomeArquivo':'" + name + "','IdDepartamento':'" + idDepartamento + "','IdSubDivisao':'" + document.getElementById("hfIdSub").value + "'}",
                            success: function (data) {
                            }
                            , error: function (xmlHttpRequest, status, err) {
                            }
                        });
                    }

                }
                reader.readAsDataURL(file);

            });

            // Hide the total progress bar when nothing's uploading anymore
            myDropzoneProjeto.on("queuecomplete", function (progress) {
                document.querySelector("#total-progressProjeto").style.opacity = "0";
                if (TipoUpload == "Projeto") {
                    CarregarListaProjeto();
                }
                btnAdicionarProjeto_Click();
                myDropzoneProjeto.removeAllFiles(true);
            });

            // Setup the buttons for all transfers
            // The "add files" button doesn't need to be setup because the config
            // `clickable` has already been specified.
            document.querySelector("#actionsProjeto .start").onclick = function () {
                myDropzoneProjeto.enqueueFiles(myDropzoneProjeto.getFilesWithStatus(Dropzone.ADDED));
            };
            document.querySelector("#actionsProjeto .cancel").onclick = function () {
                myDropzoneProjeto.removeAllFiles(true);
            };
            //#endregion

            //#region upload Arquivo
            // Get the template HTML and remove it from the doumenthe template HTML and remove it from the doument
            var previewNode = document.querySelector("#templateArquivo");
            previewNode.id = "";
            var previewTemplate = previewNode.parentNode.innerHTML;
            previewNode.parentNode.removeChild(previewNode);

            var myDropzoneProjeto = new Dropzone(document.getElementById("btnAddImagemArquivo"), { // Make the whole body a dropzone
                url: 'DefaultOmega.aspx', // Set the url
                thumbnailWidth: 30,
                thumbnailHeight: 30,
                parallelUploads: 20,
                previewTemplate: previewTemplate,
                maxFilesize: 2,
                autoQueue: false, // Make sure the files aren't queued until manually added
                previewsContainer: "#previewsArquivo", // Define the container to display the previews
                clickable: ".fileinput-button-arquivo" // Define the element that should be used as click trigger to select files.
            });

            myDropzoneProjeto.on("addedfile", function (file) {
                // Hookup the start button
                file.previewElement.querySelector(".start").onclick = function () { myDropzoneProjeto.enqueueFile(file); };
                $("#btnIniciarUploadArquivo").css("display", "inline");
            });

            // Update the total progress bar
            myDropzoneProjeto.on("totaluploadprogress", function (progress) {
                document.querySelector("#total-progressArquivo .progress-bar").style.width = progress + "%";
            });

            myDropzoneProjeto.on("sending", function (file) {
                // Show the total progress bar when upload starts
                document.querySelector("#total-progressArquivo").style.opacity = "1";
                // And disable the start button
                file.previewElement.querySelector(".start").setAttribute("disabled", "disabled");

                var name = file.name;
                var reader = new FileReader();
                reader.onload = function (e) {
                    var base64 = e.target.result;
                    base64 = base64.replace(/^[^,]*,/, '');

                    if (TipoUpload == "Arquivo") {
                        $.ajax({
                            type: 'POST',
                            async: true,
                            //Chamar o webmethod SalvarImagem em webservice.asmx
                            url: '../../WebServices/Materiais.asmx/SalvarArquivoCruzamento',
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            //enviar o base64 como parâmetro
                            data: "{'base64':'" + JSON.stringify(base64) + "','NomeArquivo':'" + name + "','IdDepartamento':'" + idDepartamento + "','IdSubDivisao':'" + document.getElementById("hfIdSub").value + "'}",
                            success: function (data) { 
                            }
                            , error: function (xmlHttpRequest, status, err) {
                            }
                        });

                    }

                }
                reader.readAsDataURL(file);

            });

            // Hide the total progress bar when nothing's uploading anymore
            myDropzoneProjeto.on("queuecomplete", function (progress) {
                document.querySelector("#total-progressArquivo").style.opacity = "0";
                if (TipoUpload == "Arquivo") {
                    CarregarListaArquivo();
                }
                btnAdicionarArquivos_Click();
                myDropzoneProjeto.removeAllFiles(true);
            });

            // Setup the buttons for all transfers
            // The "add files" button doesn't need to be setup because the config
            // `clickable` has already been specified.
            document.querySelector("#actionsArquivo .start").onclick = function () {
                myDropzoneProjeto.enqueueFiles(myDropzoneProjeto.getFilesWithStatus(Dropzone.ADDED));
            };
            document.querySelector("#actionsArquivo .cancel").onclick = function () {
                myDropzoneProjeto.removeAllFiles(true);
            };
            //#endregion
        })

        function LoadDepartamentTreeMenu(Departamento) {
            $.each(Departamento, function (index, Departamento) {

                $.ajax({
                    type: 'POST',
                    url: '../../WebServices/Materiais.asmx/GetSub',
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
                    url: '../../WebServices/Materiais.asmx/getSubChildren',
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

        $("#txtEndereco").autocomplete({
            source: function (request, response) {

                var str = "" + $("#txtIdLocal").val();
                var pad = "0000"
                var id = pad.substring(0, pad.length - str.length) + str
                $("#hfIdDna").val(id);
                $("#hfIdSub").val("");
                var dataDNA = [];

                $.ajax({
                    url: '../../WebServices/Materiais.asmx/getIdDNA',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':'','end':'" + request.term + "'}",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.Endereco,
                                val: item.idSub,
                                sub: item.Subdivisao
                            }
                        }))
                    }
                });
            },
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

        $("#txtIdLocal").autocomplete({
            source: function (request, response) {

                var str = "" + $("#txtIdLocal").val();
                var pad = "0000"
                var id = pad.substring(0, pad.length - str.length) + str
                $("#hfIdDna").val(id);
                $("#hfIdSub").val("");

                $.ajax({
                    url: '../../WebServices/Materiais.asmx/getIdDNA',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':'" + request.term + "','end':''}",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.Subdivisao,
                                val: item.idSub,
                                end: item.Endereco
                            }
                        }))
                    }
                });
            },
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

        $("#txtIdLocalMestre").autocomplete({
            source: function (request, response) {

                var id = $("#txtIdLocalMestre").val();
                $("#txtIdLocalMestre").val(id);

                $.ajax({
                    url: '../../WebServices/Materiais.asmx/getIdDNA',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':'" + request.term + "','end':''}",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.Subdivisao,
                                val: item.idSub,
                                end: item.Endereco
                            }
                        }))
                    }
                });
            },
            select: function (e, i) {
                $("#txtIdLocalMestre").val(i.item.label);
            },
            minLength: 1
        });

        $("#txtSubdivisaoMov").autocomplete({
            source: function (request, response) {
                var id = $("#txtSubdivisaoMov").val();
                $("#txtSubdivisaoMov").val(id);

                $.ajax({
                    url: '../../WebServices/Materiais.asmx/getIdDNA',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':'" + request.term + "','end':''}",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.Subdivisao,
                                val: item.idSub,
                                end: item.Endereco
                            }
                        }))
                    }
                });
            },
            select: function (e, i) {
                $("#txtSubdivisaoMov").val(i.item.label);
            },
            minLength: 1
        });
    </script>


    <script>
        $(document).on('ready', function () {
            //$('.clockpicker').clockpicker();

        });

    </script>
</asp:Content>
