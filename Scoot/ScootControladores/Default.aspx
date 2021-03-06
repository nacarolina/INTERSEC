﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Register.ScootControladores.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script type="text/javascript" src="../../Scripts/jquery.mask.js"></script>

    <style>
        #span1:focus {
            border-color: #5f5f5f;
        }

        #span2:focus {
            border-color: #5f5f5f;
        }

        /*#region BACKGROUND LINHA TABELA*/
        #tbScnAnel tr:hover {
            background-color: #e3ebf338;
        }

        #tbControladoresCad tr:hover {
            background-color: #e3ebf338;
        }
        /*#endregion*/

        .border-fieldset {
            border-radius: calc(0.35rem - 1px);
            border: 1px solid #e9ecef;
        }

        .qtdPlanRemoved {
            margin-bottom: 0px;
            margin-top: 1px;
            margin-right: 1px;
            font-size: large;
        }

        /*#region PROPORÇÕES*/
        @media (max-width: 3044px) {
            .colInteira {
                flex: 0 0 33.3% !important;
                max-width: 33.3% !important;
            }
            /*COLUNA DOS INPUTS*/
            #col1 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col2 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col3 {
                flex: 0 0 86.33333% !important;
                max-width: 86.33333% !important;
            }

            #col4 {
                flex: 0 0 86.33333% !important;
                max-width: 86.33333% !important;
            }

            #col5 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col6 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col7 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col8 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col9 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col10 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col11 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col12 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col13 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col14 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            .style-roadGreens {
                flex: 100% !important;
                max-width: 33.3% !important;
                float: left;
            }

            .style-legend {
                width: 45%;
                margin-left: 1rem;
                padding-left: 1rem;
            }

            .colRoadGreens {
                flex: 100% !important;
                max-width: 100% !important;
                margin-bottom: 15px;
            }

            #chk-response {
                flex: 0 0 50% !important;
                max-width: 50% !important;
            }
        }

        @media (max-width: 1023px) {
            .colInteira {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }
            /*COLUNA DOS INPUTS*/
            #col1 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col2 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col3 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #col4 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            .style-roadGreens {
                flex: 100% !important;
                max-width: 100% !important;
            }

            .style-legend {
                width: 54%;
                margin-left: 1rem;
                padding-left: 1rem;
            }

            #colRoadGreensMain {
                flex: 50% !important;
                max-width: 50% !important;
                float: left;
                margin-bottom: 15px;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoAddControlador {
                margin-top: 28px;
                margin-bottom: 0px;
                float: right;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoAddControlador {
                /*margin-top: 28px;
                margin-bottom: 0px;*/
                text-align: right;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoDivBtn {
                max-width: 100% !important;
                flex: 100% !important;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoInput {
                max-width: 67% !important;
                flex: 60% !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
                padding-right: 0 !important;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoInputEnd {
                max-width: 96% !important;
                flex: 96% !important;
                padding-right: 22px !important;
            }
        }

        /*#region inputCruzamentoAneisAdicionados*/
        @media (max-width: 3044px) {
            .proporcaoInputEndAneis {
                max-width: 100% !important;
                flex: 100% !important;
                padding-right: 15px !important;
                margin-bottom: 1rem;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoCruzamentoAneis {
                padding-right: 15px !important;
                margin-bottom: 1rem;
            }
        }
        /*#endregion*/

        @media (max-width: 1023px) {
            .proporcaoDivScn {
                margin-bottom: 15px;
            }

            #divInputScn {
                width: 100% !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoCruzamento {
                padding-right: 0 !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoInputPesq {
                padding-right: 15px !important;
            }
        }

        @media (max-width: 1440px) {
            .espacamento {
                margin-bottom: 20px;
            }
        }
        /*#endregion*/

        /*#region CHECKBOX*/
        .checkbox label:after {
            content: '';
            display: table;
            clear: both;
        }

        .checkbox .cr {
            position: relative;
            display: inline-block;
            border: 1px solid #777777;
            border-radius: .25em;
            width: 1.4em;
            height: 1.4em;
            float: left;
            margin-right: .5em;
        }

            .checkbox .cr .cr-icon {
                position: absolute;
                font-size: .8em;
                line-height: 0;
                top: 50%;
                left: 15%;
            }

        .checkbox label input[type="checkbox"] {
            display: none;
        }

            .checkbox label input[type="checkbox"] + .cr > .cr-icon {
                opacity: 0;
            }

            .checkbox label input[type="checkbox"]:checked + .cr > .cr-icon {
                opacity: 1;
            }

            .checkbox label input[type="checkbox"]:disabled + .cr {
                opacity: .5;
            }
        /*#endregion*/

        /*#region AUTOCOMPLETE*/
        .autocomplete {
            /*the container must be positioned relative:*/
            position: relative;
            display: inline-block;
        }

        input {
            border: 1px solid transparent;
            background-color: #f1f1f1;
            padding: 10px;
            font-size: 16px;
        }

            input[type=text] {
                /*background-color: #f1f1f1;*/
                width: 100%;
            }

            input[type=submit] {
                background-color: DodgerBlue;
                color: #fff;
            }

        .autocomplete-items {
            position: absolute;
            border: 1px solid #d4d4d4;
            border-bottom: none;
            border-top: none;
            z-index: 99;
            /*position the autocomplete items to be the same width as the container:*/
            top: 100%;
            left: 0;
            right: 0;
        }

            .autocomplete-items div {
                padding: 10px;
                cursor: pointer;
                background-color: #fff;
                border-bottom: 1px solid #d4d4d4;
            }

                .autocomplete-items div:hover {
                    /*when hovering an item:*/
                    background-color: #e9e9e9;
                }

        .autocomplete-active {
            /*when navigating through the items using the arrow keys:*/
            background-color: DodgerBlue !important;
            color: #ffffff;
        }
        /*#endregion*/
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.cruzamento %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfUsuarioLogado" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfLatitude" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfLongitude" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfQtdAneis" Value="0" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfLinhaExcluida" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfIdControladorScoot" ClientIDMode="Static" runat="server" />

    <%--TELA CADASTRO--%>
    <div id="divCadastro" style="display: none;">
        <div class="row">
            <div class="col-md-6 colInteira proporcaoDivScn">
                <label class="m-0"><%= Resources.Resource.controladorScn %>: </label>
                <div class="input-group" style="width: 85%;" id="divInputScn">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="span1"
                            style="background: transparent; border-right-style: hidden;"><b>X</b>
                        </span>
                    </div>
                    <select id="sleRegiao" class="form-control"></select>
                    <input id="txtControladorScn" type="text" class="form-control" onmouseout="validarCampo();" maxlength="2" />

                    <div class="input-group-append">
                        <span class="input-group-text" id="span2"
                            style="background: transparent;"><b>0</b>
                        </span>
                    </div>
                </div>
            </div>

            <div class="col-md-6 colInteira">
                <div class="form-group row">
                    <div class="col-md-9" id="col3">
                        <%= Resources.Resource.ipControlador %>:
                    <input id="txtIpControlador" type="text" class="form-control"
                        onmouseout="validarCampo();"
                        placeholder="<%= Resources.Resource.ipControlador %>" />
                    </div>
                </div>
            </div>

            <div class="col-md-6 colInteira">
                <div class="form-group row">
                    <div class="col-md-9" id="col4">
                        <%= Resources.Resource.tempoAntesEnvioEstagio %>:
                    <input id="txtTempoAntesEnvioEstagio" type="number"
                        min="2" max="6" class="form-control"
                        onmouseout="" />
                    </div>
                </div>
            </div>

            <div class="col-md-6 colInteira">
                <div class="form-group row">
                    <div class="col-md-9" id="col3">
                        <%= Resources.Resource.modelo %>:
                    <input id="txtModelo" type="text" class="form-control"
                        placeholder="<%= Resources.Resource.modelo %>" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-6 col-md-4 proporcaoInputEnd proporcaoCruzamento">
                <label class="m-0"><%= Resources.Resource.cruzamento %>:</label>
                <div class="input-group">
                    <input id="txtCruzamento"
                        placeholder="<%= Resources.Resource.buscarEndereco %>"
                        onmouseout="validarCampo();" autocomplete="off"
                        onblur="Geocodificacao()" class="form-control" type="text" />
                    <div class="input-group-append">
                        <button type="button" class="btn btn-secondary"
                            onclick="Geocodificacao();">
                            <i class="ficon ft-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div id="divMapa" class="panel-group" style="margin-bottom: 16px; margin-top: 16px;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#collapse1"
                            style="color: #3C3F49;"><%= Resources.Resource.visualizarEnderecoMapa %></a>
                    </h4>
                </div>
                <div id="collapse1" class="panel-collapse collapse">
                    <div class="panel-body">
                        <p style="margin-left: 10px; margin-top: 5px; display: none;">
                            <%= Resources.Resource.latitude %>:
                        <input id="txtLat" placeholder="<%= Resources.Resource.latitude %>..."
                            class="form-control" type="text"
                            style="width: 150px; margin-left: 5px; display: inline;"
                            disabled="disabled" />
                            <%= Resources.Resource.longitude %>:
                        <input id="txtLong" placeholder="<%= Resources.Resource.longitude %>..."
                            class="form-control" type="text"
                            style="width: 150px; display: inline;"
                            disabled="disabled" />
                        </p>
                        <div id="map" style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; border-color: #f4f4f4; margin-top: 7px; height: 300px; visibility: hidden;">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <button class="btn btn-success btn-min-width mr-1 mb-1" type="button"
            onclick="addAneis();" id="btnAdicionarAneis"
            style="margin-top: 1rem; margin-right: 0 !important; margin-bottom: 8px !important;">
            <i class="ft-plus" style="color: white;"></i>
            <label style="padding-left: 5px; vertical-align: text-top; margin-bottom: 0; cursor: pointer;">
                <%= Resources.Resource.adicionar %> <%= Resources.Resource.anel %>
            </label>
        </button>

        <%--ANEL 1--%>
        <div class="row" id="rowScn1" style="display: none;">
            <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
                <div class="card box-shadow-0" data-appear="appear" style="margin-bottom: 0;">

                    <div class="card-header white bg-info" style="background-color: rgb(70, 73, 83) !important;">
                        <h4 class="card-title white">Scn Junction:
                            <span id="lblScnAnel1">JXXXX1</span>
                            <span id="lblScnNodeAnel1" style="padding-left: 28px;">Scn Node: NXXXX1</span>
                        </h4>
                        <a class="heading-elements-toggle">
                            <i class="la la-ellipsis font-medium-3"></i>
                        </a>
                        <div class="heading-elements">
                            <ul class="list-inline mb-0">
                                <li>
                                    <a data-action="collapse">
                                        <i class="ft-minus"></i>
                                    </a>
                                </li>
                                <li>
                                    <a data-action="expand">
                                        <i class="ft-maximize"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="card-content collapse show"
                        style="background: rgb(70 73 83 / 5%); border-radius: calc(0.35rem - 1px);">
                        <div class="card-body">

                            <div class="row">
                                <div class="col-6 col-md-4 proporcaoInputEndAneis proporcaoCruzamentoAneis">
                                    <label class="m-0" for="txtLocation1">
                                        Location:
                                    </label>
                                    <input id="txtLocation1" placeholder="Location"
                                        onmouseout="" autocomplete="off"
                                        onblur="" class="form-control" type="text" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col5">
                                            <label class="m-0" for="txtNumberofStages1">
                                                Number of Stages:
                                            </label>
                                            <input id="txtNumberofStages1" type="number" min="1" max="8"
                                                class="form-control" onkeyup="validateStages(this)"
                                                onkeypress="if(this.value.length==1) return false;" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtQtdFases1">
                                                Qtd. Fases:
                                            </label>
                                            <input id="txtQtdFases1" type="number" class="form-control"
                                                min="1" max="100" onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDesativarTMPE1">
                                                Desativar TMPE:
                                            </label>
                                            <input id="txtDesativarTMPE1" type="text" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtNamedStage1">
                                                Named Stage:
                                            </label>
                                            <input id="txtNamedStage1" type="text"
                                                class="form-control" placeholder="Named Stage" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDelayToIntergreen1">
                                                Delay to intergreen:
                                            </label>
                                            <input id="txtDelayToIntergreen1" type="number"
                                                class="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtCyclicCheckSequence1">
                                                Cyclic Check Sequence:
                                            </label>
                                            <input id="txtCyclicCheckSequence1" type="text"
                                                class="form-control" placeholder="Cyclic Check Sequence" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Slave Controller:
                                                <span style="color: rgb(146 146 146 / 47%);">(Escravo)</span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery" data-color="success"
                                                    data-switchery="true" id="chkSlaveController1"
                                                    unchecked="true" style="display: none;" />
                                            </div>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Signal Stuck Inhibit:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery" data-color="success"
                                                    data-switchery="true" id="chkSignalStuckInhibit1"
                                                    style="display: none;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col1">
                                            <label class="m-0" for="txtNonCyclicCheckSequence1">
                                                Non Cyclic Check Sequence:
                                            </label>
                                            <input id="txtNonCyclicCheckSequence1" type="text"
                                                class="form-control" placeholder="Non Cyclic Check Sequence" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtCyclicFixedTime1">
                                                Cyclic Fixed Time:
                                            </label>
                                            <input id="txtCyclicFixedTime1" type="number"
                                                class="form-control"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Double Cycling:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkDoubleCycling1" unchecked="true" />
                                            </div>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Force Single/Double Cycling:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkForceSingleOrDoubleCycling1" unchecked="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMinGreenCyclicCheckSequence1">
                                                Min Green Cyclic Check Sequence:
                                            </label>
                                            <input id="txtMinGreenCyclicCheckSequence1" type="text"
                                                class="form-control" placeholder="Min Green Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMaxCycleTime1">
                                                Max Cycle Time:
                                            </label>
                                            <input id="txtMaxCycleTime1" type="number"
                                                class="form-control"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                SL Bit meaning:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkSLBitMeaning1" unchecked="true" />
                                            </div>

                                            <%--<div class='checkbox'>
                                                <label style='margin-bottom: 0; margin-top: 5px;'>
                                                    <input type='checkbox' id="" />
                                                    <span class='cr'>
                                                        <i class='cr-icon fa fa-check'></i>
                                                    </span>
                                                </label>
                                            </div>--%>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Smooth Plan Updates:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkSmoothPlanUpdates1" unchecked="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label for="txtRoadGreensMain1">
                                                Road Greens Main:
                                            </label>
                                            <input type="text" id="txtRoadGreensMain1" class="form-control"
                                                spellcheck="false" data-ms-editor="true" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label for="txtRoadGreensSide1">
                                                Road Greens Side:
                                            </label>
                                            <input type="text" id="txtRoadGreensSide1" class="form-control"
                                                spellcheck="false" data-ms-editor="true" />
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtFirstRemovedStage1">
                                                First Removed Stage:
                                            </label>
                                            <input id="txtFirstRemovedStage1" type="text" class="form-control"
                                                placeholder="First Removed Stage" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0">
                                                1st Stage Removed in Plan:
                                            </label>
                                            <div class="row ml-0">
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan1Anel1">
                                                    1:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan1Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan2Anel1">
                                                    2:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan2Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan3Anel1">
                                                    3:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan3Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan4Anel1">
                                                    4:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan4Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan5Anel1">
                                                    5:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan5Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan6Anel1">
                                                    6:
                                                </label>
                                                <div class="checkbox" id="">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan6Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtSecondRemovedStage1">
                                                Second Removed Stage:
                                            </label>
                                            <input id="txtSecondRemovedStage1" type="text" class="form-control"
                                                placeholder="Second Removed Stage" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0">
                                                2nd Stage Removed in Plan:
                                            </label>
                                            <div class="row ml-0">
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan1Anel1">
                                                    1:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan1Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan2Anel1">
                                                    2:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan2Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan3Anel1">
                                                    3:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan3Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan4Anel1">
                                                    4:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan4Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan5Anel1">
                                                    5:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan5Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan6Anel1">
                                                    6:
                                                </label>
                                                <div class="checkbox" id="">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan6Anel1" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%--BOTÕES DE AÇÃO--%>
                            <div class="row">
                                <div class="form-actions right" style="width: 100%;">
                                    <div class="form-actions right"
                                        style="border-top: 1px solid #e9ecef; margin-top: 1rem;">
                                        <div style="float: right; margin-top: 1rem;">
                                            <%-- <button type="button" class="btn btn-success" id="btnSalvarAnel1"
                                                onclick="">
                                                <%= Resources.Resource.salvar %>
                                            </button>--%>
                                            <button id="btnExcluirAnel1" type="button"
                                                class="btn btn-danger btn-min-width mr-1 mb-1"
                                                style="margin-bottom: 0 !important;" onclick="removerAnel(1)">
                                                <%= Resources.Resource.excluirAnel %>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--ANEL 2--%>
        <div class="row mt-1" id="rowScn2" style="display: none;">
            <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
                <div class="card box-shadow-0" data-appear="appear" style="margin-bottom: 0;">

                    <div class="card-header white bg-info" style="background-color: rgb(70, 73, 83) !important;">
                        <h4 class="card-title white">Scn Junction:
                            <span id="lblScnAnel2">JXXXX1</span>
                            <span id="lblScnNodeAnel2" style="padding-left: 28px;">Scn Node: NXXXX1</span>
                        </h4>
                        <a class="heading-elements-toggle">
                            <i class="la la-ellipsis font-medium-3"></i>
                        </a>
                        <div class="heading-elements">
                            <ul class="list-inline mb-0">
                                <li>
                                    <a data-action="collapse">
                                        <i class="ft-minus"></i>
                                    </a>
                                </li>
                                <li>
                                    <a data-action="expand">
                                        <i class="ft-maximize"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="card-content collapse show"
                        style="background: rgb(70 73 83 / 5%); border-radius: calc(0.35rem - 1px);">
                        <div class="card-body">

                            <div class="row">
                                <div class="col-6 col-md-4 proporcaoInputEndAneis proporcaoCruzamentoAneis">
                                    <label class="m-0" for="txtLocation2">
                                        Location:
                                    </label>
                                    <input id="txtLocation2" placeholder="Location"
                                        onmouseout="" autocomplete="off"
                                        onblur="" class="form-control" type="text" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col5">
                                            <label class="m-0" for="txtNumberofStages2">
                                                Number of Stages:
                                            </label>
                                            <input id="txtNumberofStages2" type="number" min="1" max="8"
                                                class="form-control" onkeyup="validateStages(this)"
                                                onkeypress="if(this.value.length==1) return false;" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtQtdFases2">
                                                Qtd. Fases:
                                            </label>
                                            <input id="txtQtdFases2" type="number" class="form-control"
                                                min="1" max="100" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDesativarTMPE2">
                                                Desativar TMPE:
                                            </label>
                                            <input id="txtDesativarTMPE2" type="text" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtNamedStage2">
                                                Named Stage:
                                            </label>
                                            <input id="txtNamedStage2" type="text"
                                                class="form-control" placeholder="Named Stage" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDelayToIntergreen2">
                                                Delay to intergreen:
                                            </label>
                                            <input id="txtDelayToIntergreen2" type="number"
                                                class="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtCyclicCheckSequence2">
                                                Cyclic Check Sequence:
                                            </label>
                                            <input id="txtCyclicCheckSequence2" type="text"
                                                class="form-control" placeholder="Cyclic Check Sequence" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Slave Controller:
                                                <span style="color: rgb(146 146 146 / 47%);">(Escravo)</span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery" data-color="success"
                                                    data-switchery="true" id="chkSlaveController2"
                                                    unchecked="true" style="display: none;" />
                                            </div>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Signal Stuck Inhibit:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery" data-color="success"
                                                    data-switchery="true" id="chkSignalStuckInhibit2"
                                                    style="display: none;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col1">
                                            <label class="m-0" for="txtNonCyclicCheckSequence2">
                                                Non Cyclic Check Sequence:
                                            </label>
                                            <input id="txtNonCyclicCheckSequence2" type="text"
                                                class="form-control" placeholder="Non Cyclic Check Sequence" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtCyclicFixedTime2">
                                                Cyclic Fixed Time:
                                            </label>
                                            <input id="txtCyclicFixedTime2" type="number"
                                                class="form-control"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Double Cycling:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkDoubleCycling2" unchecked="true" />
                                            </div>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Force Single/Double Cycling:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkForceSingleOrDoubleCycling2" unchecked="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMinGreenCyclicCheckSequence2">
                                                Min Green Cyclic Check Sequence:
                                            </label>
                                            <input id="txtMinGreenCyclicCheckSequence2" type="text"
                                                class="form-control" placeholder="Min Green Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMaxCycleTime2">
                                                Max Cycle Time:
                                            </label>
                                            <input id="txtMaxCycleTime2" type="number"
                                                class="form-control"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                SL Bit meaning:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkSLBitMeaning2" unchecked="true" />
                                            </div>

                                            <%--<div class='checkbox'>
                                                <label style='margin-bottom: 0; margin-top: 5px;'>
                                                    <input type='checkbox' id="" />
                                                    <span class='cr'>
                                                        <i class='cr-icon fa fa-check'></i>
                                                    </span>
                                                </label>
                                            </div>--%>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Smooth Plan Updates:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkSmoothPlanUpdates2" unchecked="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label for="txtRoadGreensMain2">
                                                Road Greens Main:
                                            </label>
                                            <input type="text" id="txtRoadGreensMain2" class="form-control"
                                                spellcheck="false" data-ms-editor="true" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label for="txtRoadGreensSide2">
                                                Road Greens Side:
                                            </label>
                                            <input type="text" id="txtRoadGreensSide2" class="form-control"
                                                spellcheck="false" data-ms-editor="true" />
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtFirstRemovedStage2">
                                                First Removed Stage:
                                            </label>
                                            <input id="txtFirstRemovedStage2" type="text" class="form-control"
                                                placeholder="First Removed Stage" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0">
                                                1st Stage Removed in Plan:
                                            </label>
                                            <div class="row ml-0">
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan1Anel2">
                                                    1:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan1Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan2Anel2">
                                                    2:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan2Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan3Anel2">
                                                    3:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan3Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan4Anel2">
                                                    4:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan4Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan5Anel2">
                                                    5:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan5Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan6Anel2">
                                                    6:
                                                </label>
                                                <div class="checkbox" id="">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan6Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtSecondRemovedStage2">
                                                Second Removed Stage:
                                            </label>
                                            <input id="txtSecondRemovedStage2" type="text" class="form-control"
                                                placeholder="Second Removed Stage" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0">
                                                2nd Stage Removed in Plan:
                                            </label>
                                            <div class="row ml-0">
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan1Anel2">
                                                    1:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan1Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan2Anel2">
                                                    2:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan2Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan3Anel2">
                                                    3:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan3Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan4Anel2">
                                                    4:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan4Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan5Anel2">
                                                    5:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan5Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan6Anel2">
                                                    6:
                                                </label>
                                                <div class="checkbox" id="">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan6Anel2" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%--BOTÕES DE AÇÃO--%>
                            <div class="row">
                                <div class="form-actions right" style="width: 100%;">
                                    <div class="form-actions right"
                                        style="border-top: 1px solid #e9ecef; margin-top: 1rem;">
                                        <div style="float: right; margin-top: 1rem;">
                                            <%-- <button type="button" class="btn btn-success" id="btnSalvarAnel2"
                                                onclick="">
                                                <%= Resources.Resource.salvar %>
                                            </button>--%>
                                            <button id="btnExcluirAnel2" type="button"
                                                class="btn btn-danger btn-min-width mr-1 mb-1"
                                                style="margin-bottom: 0 !important;" onclick="removerAnel(2)">
                                                <%= Resources.Resource.excluirAnel %>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--ANEL 3--%>
        <div class="row mt-1" id="rowScn3" style="display: none;">
            <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
                <div class="card box-shadow-0" data-appear="appear" style="margin-bottom: 0;">

                    <div class="card-header white bg-info" style="background-color: rgb(70, 73, 83) !important;">
                        <h4 class="card-title white">Scn Junction:
                            <span id="lblScnAnel3">JXXXX1</span>
                            <span id="lblScnNodeAnel3" style="padding-left: 28px;">Scn Node: NXXXX1</span>
                        </h4>
                        <a class="heading-elements-toggle">
                            <i class="la la-ellipsis font-medium-3"></i>
                        </a>
                        <div class="heading-elements">
                            <ul class="list-inline mb-0">
                                <li>
                                    <a data-action="collapse">
                                        <i class="ft-minus"></i>
                                    </a>
                                </li>
                                <li>
                                    <a data-action="expand">
                                        <i class="ft-maximize"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="card-content collapse show"
                        style="background: rgb(70 73 83 / 5%); border-radius: calc(0.35rem - 1px);">
                        <div class="card-body">

                            <div class="row">
                                <div class="col-6 col-md-4 proporcaoInputEndAneis proporcaoCruzamentoAneis">
                                    <label class="m-0" for="txtLocation3">
                                        Location:
                                    </label>
                                    <input id="txtLocation3" placeholder="Location"
                                        onmouseout="" autocomplete="off"
                                        onblur="" class="form-control" type="text" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col5">
                                            <label class="m-0" for="txtNumberofStages3">
                                                Number of Stages:
                                            </label>
                                            <input id="txtNumberofStages3" type="number" min="1" max="8"
                                                class="form-control" onkeyup="validateStages(this)"
                                                onkeypress="if(this.value.length==1) return false;" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtQtdFases3">
                                                Qtd. Fases:
                                            </label>
                                            <input id="txtQtdFases3" type="number" class="form-control"
                                                min="1" max="100" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDesativarTMPE3">
                                                Desativar TMPE:
                                            </label>
                                            <input id="txtDesativarTMPE3" type="text" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtNamedStage3">
                                                Named Stage:
                                            </label>
                                            <input id="txtNamedStage3" type="text"
                                                class="form-control" placeholder="Named Stage" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDelayToIntergreen3">
                                                Delay to intergreen:
                                            </label>
                                            <input id="txtDelayToIntergreen3" type="number"
                                                class="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtCyclicCheckSequence3">
                                                Cyclic Check Sequence:
                                            </label>
                                            <input id="txtCyclicCheckSequence3" type="text"
                                                class="form-control" placeholder="Cyclic Check Sequence" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Slave Controller:
                                                <span style="color: rgb(146 146 146 / 47%);">(Escravo)</span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery" data-color="success"
                                                    data-switchery="true" id="chkSlaveController3"
                                                    unchecked="true" style="display: none;" />
                                            </div>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Signal Stuck Inhibit:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery" data-color="success"
                                                    data-switchery="true" id="chkSignalStuckInhibit3"
                                                    style="display: none;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col1">
                                            <label class="m-0" for="txtNonCyclicCheckSequence3">
                                                Non Cyclic Check Sequence:
                                            </label>
                                            <input id="txtNonCyclicCheckSequence3" type="text"
                                                class="form-control" placeholder="Non Cyclic Check Sequence" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtCyclicFixedTime3">
                                                Cyclic Fixed Time:
                                            </label>
                                            <input id="txtCyclicFixedTime3" type="number"
                                                class="form-control"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Double Cycling:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkDoubleCycling3" unchecked="true" />
                                            </div>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Force Single/Double Cycling:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkForceSingleOrDoubleCycling3" unchecked="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMinGreenCyclicCheckSequence3">
                                                Min Green Cyclic Check Sequence:
                                            </label>
                                            <input id="txtMinGreenCyclicCheckSequence3" type="text"
                                                class="form-control" placeholder="Min Green Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMaxCycleTime3">
                                                Max Cycle Time:
                                            </label>
                                            <input id="txtMaxCycleTime3" type="number"
                                                class="form-control"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                SL Bit meaning:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkSLBitMeaning3" unchecked="true" />
                                            </div>

                                            <%--<div class='checkbox'>
                                                <label style='margin-bottom: 0; margin-top: 5px;'>
                                                    <input type='checkbox' id="" />
                                                    <span class='cr'>
                                                        <i class='cr-icon fa fa-check'></i>
                                                    </span>
                                                </label>
                                            </div>--%>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Smooth Plan Updates:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkSmoothPlanUpdates3" unchecked="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label for="txtRoadGreensMain3">
                                                Road Greens Main:
                                            </label>
                                            <input type="text" id="txtRoadGreensMain3" class="form-control"
                                                spellcheck="false" data-ms-editor="true" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label for="txtRoadGreensSide3">
                                                Road Greens Side:
                                            </label>
                                            <input type="text" id="txtRoadGreensSide3" class="form-control"
                                                spellcheck="false" data-ms-editor="true" />
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtFirstRemovedStage3">
                                                First Removed Stage:
                                            </label>
                                            <input id="txtFirstRemovedStage3" type="text" class="form-control"
                                                placeholder="First Removed Stage" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0">
                                                1st Stage Removed in Plan:
                                            </label>
                                            <div class="row ml-0">
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan1Anel3">
                                                    1:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan1Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan2Anel3">
                                                    2:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan2Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan3Anel3">
                                                    3:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan3Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan4Anel3">
                                                    4:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan4Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan5Anel3">
                                                    5:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan5Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan6Anel3">
                                                    6:
                                                </label>
                                                <div class="checkbox" id="">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan6Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtSecondRemovedStage3">
                                                Second Removed Stage:
                                            </label>
                                            <input id="txtSecondRemovedStage3" type="text" class="form-control"
                                                placeholder="Second Removed Stage" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0">
                                                2nd Stage Removed in Plan:
                                            </label>
                                            <div class="row ml-0">
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan1Anel3">
                                                    1:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan1Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan2Anel3">
                                                    2:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan2Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan3Anel3">
                                                    3:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan3Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan4Anel3">
                                                    4:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan4Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan5Anel3">
                                                    5:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan5Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan6Anel3">
                                                    6:
                                                </label>
                                                <div class="checkbox" id="">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan6Anel3" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%--BOTÕES DE AÇÃO--%>
                            <div class="row">
                                <div class="form-actions right" style="width: 100%;">
                                    <div class="form-actions right"
                                        style="border-top: 1px solid #e9ecef; margin-top: 1rem;">
                                        <div style="float: right; margin-top: 1rem;">
                                            <%-- <button type="button" class="btn btn-success" id="btnSalvarAnel3"
                                                onclick="">
                                                <%= Resources.Resource.salvar %>
                                            </button>--%>
                                            <button id="btnExcluirAnel3" type="button"
                                                class="btn btn-danger btn-min-width mr-1 mb-1"
                                                style="margin-bottom: 0 !important;" onclick="removerAnel(3)">
                                                <%= Resources.Resource.excluirAnel %>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--ANEL 4--%>
        <div class="row mt-1" id="rowScn4" style="display: none;">
            <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
                <div class="card box-shadow-0" data-appear="appear" style="margin-bottom: 0;">

                    <div class="card-header white bg-info" style="background-color: rgb(70, 73, 83) !important;">
                        <h4 class="card-title white">Scn Junction:
                            <span id="lblScnAnel4">JXXXX1</span>
                            <span id="lblScnNodeAnel4" style="padding-left: 28px;">Scn Node: NXXXX1</span>
                        </h4>
                        <a class="heading-elements-toggle">
                            <i class="la la-ellipsis font-medium-3"></i>
                        </a>
                        <div class="heading-elements">
                            <ul class="list-inline mb-0">
                                <li>
                                    <a data-action="collapse">
                                        <i class="ft-minus"></i>
                                    </a>
                                </li>
                                <li>
                                    <a data-action="expand">
                                        <i class="ft-maximize"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="card-content collapse show"
                        style="background: rgb(70 73 83 / 5%); border-radius: calc(0.35rem - 1px);">
                        <div class="card-body">

                            <div class="row">
                                <div class="col-6 col-md-4 proporcaoInputEndAneis proporcaoCruzamentoAneis">
                                    <label class="m-0" for="txtLocation4">
                                        Location:
                                    </label>
                                    <input id="txtLocation4" placeholder="Location"
                                        onmouseout="" autocomplete="off"
                                        onblur="" class="form-control" type="text" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col5">
                                            <label class="m-0" for="txtNumberofStages4">
                                                Number of Stages:
                                            </label>
                                            <input id="txtNumberofStages4" type="number" min="1" max="8"
                                                class="form-control" onkeyup="validateStages(this)"
                                                onkeypress="if(this.value.length==1) return false;" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtQtdFases4">
                                                Qtd. Fases:
                                            </label>
                                            <input id="txtQtdFases4" type="number" class="form-control"
                                                min="1" max="100" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDesativarTMPE4">
                                                Desativar TMPE:
                                            </label>
                                            <input id="txtDesativarTMPE4" type="text" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtNamedStage4">
                                                Named Stage:
                                            </label>
                                            <input id="txtNamedStage4" type="text"
                                                class="form-control" placeholder="Named Stage" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDelayToIntergreen4">
                                                Delay to intergreen:
                                            </label>
                                            <input id="txtDelayToIntergreen4" type="number"
                                                class="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtCyclicCheckSequence4">
                                                Cyclic Check Sequence:
                                            </label>
                                            <input id="txtCyclicCheckSequence4" type="text"
                                                class="form-control" placeholder="Cyclic Check Sequence" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Slave Controller:
                                                <span style="color: rgb(146 146 146 / 47%);">(Escravo)</span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery" data-color="success"
                                                    data-switchery="true" id="chkSlaveController4"
                                                    unchecked="true" style="display: none;" />
                                            </div>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Signal Stuck Inhibit:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery" data-color="success"
                                                    data-switchery="true" id="chkSignalStuckInhibit4"
                                                    style="display: none;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col1">
                                            <label class="m-0" for="txtNonCyclicCheckSequence4">
                                                Non Cyclic Check Sequence:
                                            </label>
                                            <input id="txtNonCyclicCheckSequence4" type="text"
                                                class="form-control" placeholder="Non Cyclic Check Sequence" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtCyclicFixedTime4">
                                                Cyclic Fixed Time:
                                            </label>
                                            <input id="txtCyclicFixedTime4" type="number"
                                                class="form-control"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Double Cycling:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkDoubleCycling4" unchecked="true" />
                                            </div>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Force Single/Double Cycling:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkForceSingleOrDoubleCycling4" unchecked="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMinGreenCyclicCheckSequence4">
                                                Min Green Cyclic Check Sequence:
                                            </label>
                                            <input id="txtMinGreenCyclicCheckSequence4" type="text"
                                                class="form-control" placeholder="Min Green Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMaxCycleTime4">
                                                Max Cycle Time:
                                            </label>
                                            <input id="txtMaxCycleTime4" type="number"
                                                class="form-control"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                SL Bit meaning:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkSLBitMeaning4" unchecked="true" />
                                            </div>

                                            <%--<div class='checkbox'>
                                                <label style='margin-bottom: 0; margin-top: 5px;'>
                                                    <input type='checkbox' id="" />
                                                    <span class='cr'>
                                                        <i class='cr-icon fa fa-check'></i>
                                                    </span>
                                                </label>
                                            </div>--%>
                                        </div>

                                        <div class="col-md-9" id="chk-response">
                                            <label class="m-0">
                                                Smooth Plan Updates:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery"
                                                    data-color="success" data-switchery="false"
                                                    id="chkSmoothPlanUpdates4" unchecked="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label for="txtRoadGreensMain4">
                                                Road Greens Main:
                                            </label>
                                            <input type="text" id="txtRoadGreensMain4" class="form-control"
                                                spellcheck="false" data-ms-editor="true" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label for="txtRoadGreensSide4">
                                                Road Greens Side:
                                            </label>
                                            <input type="text" id="txtRoadGreensSide4" class="form-control"
                                                spellcheck="false" data-ms-editor="true" />
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtFirstRemovedStage4">
                                                First Removed Stage:
                                            </label>
                                            <input id="txtFirstRemovedStage4" type="text" class="form-control"
                                                placeholder="First Removed Stage" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0">
                                                1st Stage Removed in Plan:
                                            </label>
                                            <div class="row ml-0">
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan1Anel4">
                                                    1:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan1Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan2Anel4">
                                                    2:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan2Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan3Anel4">
                                                    3:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan3Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan4Anel4">
                                                    4:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan4Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan5Anel4">
                                                    5:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan5Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkFirstRemovableStagePlan6Anel4">
                                                    6:
                                                </label>
                                                <div class="checkbox" id="">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkFirstRemovableStagePlan6Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtSecondRemovedStage4">
                                                Second Removed Stage:
                                            </label>
                                            <input id="txtSecondRemovedStage4" type="text" class="form-control"
                                                placeholder="Second Removed Stage" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0">
                                                2nd Stage Removed in Plan:
                                            </label>
                                            <div class="row ml-0">
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan1Anel4">
                                                    1:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan1Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan2Anel4">
                                                    2:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan2Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan3Anel4">
                                                    3:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan3Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan4Anel4">
                                                    4:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan4Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan5Anel4">
                                                    5:
                                                </label>
                                                <div class="checkbox">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan5Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                                &nbsp;
                                                <label class="qtdPlanRemoved" for="chkSecondRemovableStagePlan6Anel4">
                                                    6:
                                                </label>
                                                <div class="checkbox" id="">
                                                    <label style="margin-bottom: 0; margin-top: 5px;">
                                                        <input type="checkbox" id="chkSecondRemovableStagePlan6Anel4" />
                                                        <span class="cr">
                                                            <i class="cr-icon fa fa-check"></i>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%--BOTÕES DE AÇÃO--%>
                            <div class="row">
                                <div class="form-actions right" style="width: 100%;">
                                    <div class="form-actions right"
                                        style="border-top: 1px solid #e9ecef; margin-top: 1rem;">
                                        <div style="float: right; margin-top: 1rem;">
                                            <%-- <button type="button" class="btn btn-success" id="btnSalvarAnel4"
                                                onclick="">
                                                <%= Resources.Resource.salvar %>
                                            </button>--%>
                                            <button id="btnExcluirAnel4" type="button"
                                                class="btn btn-danger btn-min-width mr-1 mb-1"
                                                style="margin-bottom: 0 !important;" onclick="removerAnel(4)">
                                                <%= Resources.Resource.excluirAnel %>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <div class="form-actions right"
                style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem;">
                <div style="float: right; margin-top: 1rem;">
                    <button type="button" class="btn btn-success" id="btnSalvar"
                        onclick="salvar();">
                        <%= Resources.Resource.salvar %>
                    </button>
                    <button type="button" class="btn btn-warning btn-min-width mr-1 mb-1"
                        style="margin-bottom: 0 !important;" onclick="fecharCadastro();">
                        <%= Resources.Resource.cancelar %>
                    </button>
                </div>
            </div>
        </div>

    </div>

    <%--▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬--%>

    <%--TELA INICIO--%>
    <div id="divPesquisa" style="display: block;">
        <%--PESQUISA--%>
        <div>
            <label class="m-0"><%= Resources.Resource.controladorScn %>:</label>
            <br />
            <div class="row espacamento" style="padding-left: 0; padding-right: 0;">
                <div class="col-6 col-md-4 proporcaoInput proporcaoInputPesq">
                    <div class="input-group">
                        <input type="text" class="form-control" id="txtPesqControladorScn"
                            onkeyup="filtroDeBusca()" />
                        <div class="input-group-append">
                            <button class="btn btn-secondary" onkeydown="FindUsers()">
                                <i class="ft-search" style="color: white;"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-md-4 proporcaoDivBtn">
                    <div class="proporcaoAddControlador">
                        <button type="button" class="btn btn-icon btn-secondary mr-1"
                            onclick="addNovoControlador()"
                            style="margin-right: 0 !important;">
                            <i class="ft-plus-square"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <%--LISTAR ANÉIS DO BANCO--%>
        <div class="table-responsive" style="margin-top: 2rem;">
            <label class="m-0"><%= Resources.Resource.lista %> - <%= Resources.Resource.controladorScn %></label>
            <table id="tblControladoresCad" class="table table-bordered mb-0">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.controladorScn %></th>
                        <th><%= Resources.Resource.ipControlador %></th>
                        <th><%= Resources.Resource.cruzamento %></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbControladoresCad">
                    <tr>
                        <td colspan="5"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>


    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBYQJ8OSMm1XQcb2h8lla6IbG2rNeKtQ9Q" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>


    <script>
        $(function () {

            loadResourcesLocales();
            carregarControladoresCad();
            loadRegiao();
            Geocodificacao('Foz do Iguaçu,PR');
        });

        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });

        function loadRegiao() {

            $.ajax({
                url: 'Default.aspx/loadRegiao',
                data: "{}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#sleRegiao").empty();
                    $("#sleRegiao").append($("<option></option>").val('').html('--'));
                    $.each(data.d, function () {
                        $("#sleRegiao").append($("<option></option>").val(this['Text']).html(this['Text']));
                    });
                }
            });
        }

        //SCRIPT CADASTRO ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
        function addAneis() {
            //VALIDAÇÕES
            if ($("#txtControladorScn").val() == "") {

                $("#txtControladorScn").addClass("is-invalid");
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("insiraControlador"),
                })
                return;
            }

            document.getElementById("txtControladorScn").disabled = true;
            $("#sleRegiao")[0].disabled = true;

            var qtd = parseInt($("#hfQtdAneis").val());
            qtd++;

            $("#lblScnAnel" + qtd)[0].innerHTML = "J" + $("#sleRegiao").val() + $("#txtControladorScn").val() + qtd;
            $("#lblScnNodeAnel" + qtd)[0].innerHTML = "Scn Node: N" + $("#sleRegiao").val() + $("#txtControladorScn").val() + qtd;
            $("#hfQtdAneis").val(qtd);
            $("#btnExcluirAnel1").css("display", "none");
            $("#btnExcluirAnel2").css("display", "none");
            $("#btnExcluirAnel3").css("display", "none");
            $("#btnExcluirAnel4").css("display", "none");

            $("#btnExcluirAnel" + qtd).css("display", "");
            $("#rowScn" + qtd).css("display", "block");

            $('html, body').animate({
                scrollTop: $("#rowScn" + qtd).offset().top - 140
            }, 1000);

            limpaCamposAnel(qtd);

            if ($("#hfQtdAneis").val() == 4) {
                $("#btnAdicionarAneis").css("display", "none");
            }

        }

        function validateStages(value) {

            var stageScn = value.id.replace("txtNumberofStages", "");
            if (parseInt(value.value) < 1 || parseInt(value.value) > 8) {

                $("#txtNumberofStages" + stageScn).addClass("is-invalid");
            }
            else {
                $("#txtNumberofStages" + stageScn).removeClass("is-invalid");
            }
        }

        function limpaCamposAnel(anel) {
            //for (var i = 1; i <= 4; i++) {

            $("#txtLocation" + anel).val("");
            $("#txtNumberofStages" + anel).val("");
            $("#txtNonCyclicCheckSequence" + anel).val("");
            $("#txtDelayToIntergreen" + anel).val("");
            $("#txtQtdFases" + anel).val("");

            if ($("#chkSLBitMeaning" + anel)[0].checked)
                $("#chkSLBitMeaning" + anel).click();
            if ($("#chkSmoothPlanUpdates" + anel)[0].checked)
                $("#chkSmoothPlanUpdates" + anel).click();
            if ($("#chkSlaveController" + anel)[0].checked)
                $("#chkSlaveController" + anel).click();
            if ($("#chkSignalStuckInhibit" + anel)[0].checked)
                $("#chkSignalStuckInhibit" + anel).click();
            if ($("#chkDoubleCycling" + anel)[0].checked)
                $("#chkDoubleCycling" + anel).click();
            if ($("#chkForceSingleOrDoubleCycling" + anel)[0].checked)
                $("#chkForceSingleOrDoubleCycling" + anel).click();

            $("#txtRoadGreensMain" + anel).val("");
            $("#txtRoadGreensSide" + anel).val("");
            $("#txtNamedStage" + anel).val("");
            $("#txtCyclicFixedTime" + anel).val("");
            $("#txtMaxCycleTime" + anel).val("");
            $("#txtMinGreenCyclicCheckSequence" + anel).val("");
            $("#txtCyclicCheckSequence" + anel).val("");
            $("#txtFirstRemovedStage" + anel).val("");
            $("#txtSecondRemovedStage" + anel).val("");
            for (var ii = 1; ii <= 6; ii++) {
                $("#chkFirstRemovableStagePlan" + ii + "Anel" + anel)[0].checked = false;
                $("#chkSecondRemovableStagePlan" + ii + "Anel" + anel)[0].checked = false;
            }
        }

        function validaDesativacaoTMPE(input) {

            var tmpe = input.value.toUpperCase();
            var inputQtdEstagios = input.dataset.anel;
            var valorInputQtdEstagios = $("#txtQtdEstagios" + inputQtdEstagios).val();

            var compararTmpe = tmpe.substring(tmpe.length - 1, tmpe.length);
            if (compararTmpe != "A" && compararTmpe != "B" && compararTmpe != "C" && compararTmpe != "D" && compararTmpe != "E" && compararTmpe != "F" && compararTmpe != "G" && compararTmpe != "H") {

                if (tmpe.length == 1) {

                    $("#txtDesativarTMPE" + inputQtdEstagios).val("");
                }
                else {
                    var resultado = tmpe.substring(0, tmpe.length - 1);
                    input.value = resultado;
                    $("#txtDesativarTMPE" + inputQtdEstagios).removeClass("is-invalid");
                    return;
                }
            }

            if (tmpe.length > valorInputQtdEstagios) {

                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("validaTmpeInformado") + valorInputQtdEstagios,
                })
                $("#txtDesativarTMPE" + inputQtdEstagios).addClass("is-invalid");
                document.getElementById("btnSalvar").disabled = true;
                return;
            }
            else {
                $("#txtDesativarTMPE" + inputQtdEstagios).removeClass("is-invalid");
                document.getElementById("btnSalvar").disabled = false;
            }
        }

        function validaCampoVazioInputQtdEstagio() {

            if ($("#txtQtdEstagios").val() == "") {

                $("#txtQtdEstagios").addClass("is-invalid");
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("insiraIpControlador"),
                })
                return;
            }
            else {
                $("#txtQtdEstagios").removeClass("is-invalid");
            }
        }

        var estagiosDesativarTMPE1 = "", estagiosDesativarTMPE2 = "",
            estagiosDesativarTMPE3 = "", estagiosDesativarTMPE4 = "";

        function salvar() {

            //#region VALIDAÇÕES
            if ($("#txtCruzamento").val() == "" && $("#txtIpControlador").val() == "" &&
                $("#txtTempoAntesEnvioEstagio").val() == "") {

                $("#txtCruzamento").addClass("is-invalid");
                $("#txtIpControlador").addClass("is-invalid");

                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("preenchaCamposEmBranco"),
                })
                return;
            }

            if ($("#txtCruzamento").val() == "") {

                $("#txtCruzamento").addClass("is-invalid");
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("insiraEndereco"),
                })
                return;
            }

            if ($("#sleRegiao").val() == "") {

                $("#sleRegiao").addClass("is-invalid");
                return;
            }
            else {
                $("#sleRegiao").removeClass("is-invalid");
            }

            if ($("#txtIpControlador").val() == "") {

                $("#txtIpControlador").addClass("is-invalid");
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("insiraIpControlador"),
                })
                return;
            }

            if ($("#txtTempoAntesEnvioEstagio").val() == "") {

                $("#txtTempoAntesEnvioEstagio").addClass("is-invalid");
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("insiraTempoEnvioEstagio"),
                })
                return;
            }
            else {
                $("#txtTempoAntesEnvioEstagio").removeClass("is-invalid");
            }

            var valorTempoEnvioEstagio = parseInt($("#txtTempoAntesEnvioEstagio").val());
            if (valorTempoEnvioEstagio < 2) {

                $("#txtTempoAntesEnvioEstagio").addClass("is-invalid");
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("insiraTempoEnvioEstagio"),
                })
                return;
            }
            else {
                $("#txtTempoAntesEnvioEstagio").removeClass("is-invalid");
            }
            //#endregion

            var erro = false;

            var anel1 = "", anel2 = "", anel3 = "", anel4 = "";
            var qtdEstagio1 = "", qtdEstagio2 = "", qtdEstagio3 = "", qtdEstagio4 = "",
                cruzamentoAnel1 = "", cruzamentoAnel2 = "", cruzamentoAnel3 = "", cruzamentoAnel4 = "";

            //#region VALIDAÇÕES E ARMAZENAMENTO DE VALORES
            var qtdAnel = parseInt($("#hfQtdAneis").val());
            for (var i = 1; i <= qtdAnel; i++) {
                if (erro)
                    return;
                if (i == 1) {
                    anel1 = $("#lblScnAnel1")[0].innerHTML;
                    qtdEstagio1 = $("#txtNumberofStages1").val();
                    cruzamentoAnel1 = $("#txtLocation1").val();
                    estagiosDesativarTMPE1 = $("#txtDesativarTMPE1").val();
                }
                if (i == 2) {
                    anel2 = $("#lblScnAnel2")[0].innerHTML;
                    qtdEstagio2 = $("#txtNumberofStages2").val();
                    cruzamentoAnel2 = $("#txtLocation2").val();
                    estagiosDesativarTMPE2 = $("#txtDesativarTMPE2").val();
                }
                if (i == 3) {
                    anel3 = $("#lblScnAnel3")[0].innerHTML;
                    qtdEstagio3 = $("#txtNumberofStages3").val();
                    cruzamentoAnel3 = $("#txtLocation3").val();
                    estagiosDesativarTMPE3 = $("#txtDesativarTMPE3").val();
                }
                if (i == 4) {
                    anel4 = $("#lblScnAnel4")[0].innerHTML;
                    qtdEstagio4 = $("#txtNumberofStages4").val();
                    cruzamentoAnel4 = $("#txtLocation4").val();
                    estagiosDesativarTMPE4 = $("#txtDesativarTMPE4").val();
                }

                if ($("#txtLocation" + i).val() == "") {
                    erro = true;
                    $("#txtLocation" + i).addClass("is-invalid");
                    $("#txtLocation" + i).focus();
                    Swal.fire({

                        type: 'error',
                        title: getResourceItem("erroTipoAlert"),
                        text: getResourceItem("preenchaCamposEmBranco"),
                    });
                    return;
                }
                else
                    $("#txtLocation" + i).removeClass("is-invalid");

                if ($("#txtNumberofStages" + i).val() == "") {
                    erro = true;
                    $("#txtNumberofStages" + i).addClass("is-invalid");
                    $("#txtNumberofStages" + i).focus();
                    Swal.fire({

                        type: 'error',
                        title: getResourceItem("erroTipoAlert"),
                        text: getResourceItem("preenchaCamposEmBranco"),
                    });
                    return;
                }
                else
                    $("#txtNumberofStages" + i).removeClass("is-invalid");

                if ($("#txtQtdFases" + i).val() == "") {
                    erro = true;
                    $("#txtQtdFases" + i).addClass("is-invalid");
                    $("#txtQtdFases" + i).focus();
                    Swal.fire({

                        type: 'error',
                        title: getResourceItem("erroTipoAlert"),
                        text: getResourceItem("preenchaCamposEmBranco"),
                    });
                    return;
                }
                else
                    $("#txtQtdFases" + i).removeClass("is-invalid");


                if ($("#txtNamedStage" + i).val() == "") {
                    erro = true;
                    $("#txtNamedStage" + i).addClass("is-invalid");
                    $("#txtNamedStage" + i).focus();
                    Swal.fire({

                        type: 'error',
                        title: getResourceItem("erroTipoAlert"),
                        text: getResourceItem("preenchaCamposEmBranco"),
                    });
                    return;
                }
                else
                    $("#txtNamedStage" + i).removeClass("is-invalid");

                if ($("#txtDelayToIntergreen" + i).val() == "") {
                    erro = true;
                    $("#txtDelayToIntergreen" + i).addClass("is-invalid");
                    $("#txtDelayToIntergreen" + i).focus();
                    Swal.fire({

                        type: 'error',
                        title: getResourceItem("erroTipoAlert"),
                        text: getResourceItem("preenchaCamposEmBranco"),
                    });
                    return;
                }
                else
                    $("#txtDelayToIntergreen" + i).removeClass("is-invalid");
            }
            //#endregion

            if (erro == true) {

                $("#divLoading").css("display", "none");
                return;
            }


            $("#divLoading").css("display", "block");
            var controladorScnFormatado = "X" + $("#sleRegiao").val() + $("#txtControladorScn").val() + "0";
            if (document.getElementById("btnSalvar").innerHTML == "Salvar") {

                $.ajax({
                    type: 'POST',
                    url: 'Default.aspx/salvar',
                    dataType: 'json',
                    data: "{'qtdCaracteres':'" + $("#txtQtdCaractereIdentControlador").val() + "', " +
                        " 'controladorScn':'" + controladorScnFormatado + "', " +
                        " 'ipControlador':'" + $("#txtIpControlador").val() + "', " +
                        " 'cruzamento':'" + $("#txtCruzamento").val() + "', " +
                        " 'tempoEnvioEstagio':'" + $("#txtTempoAntesEnvioEstagio").val() + "', " +
                        " 'modelo':'" + $("#txtModelo").val() + "', " +
                        " 'usuarioLogado': '" + $("#hfUsuarioLogado").val() + "', " +
                        " 'lon':'" + $("#hfLongitude").val() + "', " +
                        " 'anel1':'" + anel1 + "','anel2':'" + anel2 + "', " +
                        " 'anel3':'" + anel3 + "','anel4':'" + anel4 + "', " +
                        " 'qtdEstagio1':'" + qtdEstagio1 + "', " +
                        " 'qtdEstagio2':'" + qtdEstagio2 + "', " +
                        " 'qtdEstagio3':'" + qtdEstagio3 + "', " +
                        " 'qtdEstagio4':'" + qtdEstagio4 + "', " +
                        " 'tmpe1':'" + estagiosDesativarTMPE1 + "', " +
                        " 'tmpe2':'" + estagiosDesativarTMPE2 + "', " +
                        " 'tmpe3':'" + estagiosDesativarTMPE3 + "', " +
                        " 'tmpe4':'" + estagiosDesativarTMPE4 + "', " +
                        " 'cruzamentoAnel1':'" + cruzamentoAnel1 + "', " +
                        " 'cruzamentoAnel2':'" + cruzamentoAnel2 + "', " +
                        " 'cruzamentoAnel3':'" + cruzamentoAnel3 + "', " +
                        " 'cruzamentoAnel4':'" + cruzamentoAnel4 + "', " +
                        " 'lat':'" + $("#hfLatitude").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        if (data.d == "Este controlador já está cadastrado") {

                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("controladorCadastrado"),
                            })

                            $("#divLoading").css("display", "none");
                            return;
                        }

                        if (data.d == "Este IP já está cadastrado") {

                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("ipCadastrado"),
                            })

                            $("#divLoading").css("display", "none");
                            return;
                        }

                        //#region Salva dados aneis
                        var qtdAnel = parseInt($("#hfQtdAneis").val());
                        for (var i = 1; i <= qtdAnel; i++) {
                            $.ajax({
                                type: 'POST',
                                url: 'Default.aspx/salvarAnel',
                                dataType: 'json',
                                data: "{'junction':'" + $("#lblScnAnel" + i)[0].innerHTML + "', " + " 'qtdFases':'" + $("#txtQtdFases" + i).val() + "','SlaveController':'"
                                    + $("#chkSlaveController" + i)[0].checked + "','DelayToIntergreen':'" + $("#txtDelayToIntergreen" + i).val() + "','Signal_Stuck_Inhibit':'"
                                    + $("#chkSignalStuckInhibit" + i)[0].checked + "','MinGreenCyclickCheckSequence':'" + $("#txtMinGreenCyclicCheckSequence" + i).val() +
                                    "','CyclicCheckSequence':'" + $("#txtCyclicCheckSequence" + i).val() + "','NonCyclicCheckSequence':'" + $("#txtNonCyclicCheckSequence" + i).val() +
                                    "','SL_BitMeaning':'" + $("#chkSLBitMeaning" + i)[0].checked + "','SmoothPlanChange':'" + $("#chkSmoothPlanUpdates" + i)[0].checked +
                                    "','RoadGreens_Main':'" + $("#txtRoadGreensMain" + i).val() + "','RoadGreens_Side':'" + $("#txtRoadGreensSide" + i).val() +
                                    "','ScnRegion':'" + $("#sleRegiao").val() + "','ScnNode':'" + $("#lblScnAnel" + i)[0].innerHTML.replace("J", "N") +
                                    "','MaxCycleTime':'" + $("#txtMaxCycleTime" + i).val() + "','NamedStage':'" + $("#txtNamedStage" + i).val() + "','CyclicFixedTime':'"
                                    + $("#txtCyclicFixedTime" + i).val() + "','DoubleCycling':'" + $("#chkDoubleCycling" + i)[0].checked + "','ForceSingleOrDoubleCycling':'"
                                    + $("#chkForceSingleOrDoubleCycling" + i)[0].checked + "','FirstRemovableStage':'" + $("#txtFirstRemovedStage" + i).val() +
                                    "','SecondRemovableStage':'" + $("#txtSecondRemovedStage" + i).val() + "','FirstStageRemoved_Plano1':'" + $("#chkFirstRemovableStagePlan1Anel" + i)[0].checked +
                                    "','FirstStageRemoved_Plano2':'" + $("#chkFirstRemovableStagePlan2Anel" + i)[0].checked + "','FirstStageRemoved_Plano3':'" + $("#chkFirstRemovableStagePlan3Anel" + i)[0].checked +
                                    "','FirstStageRemoved_Plano4':'" + $("#chkFirstRemovableStagePlan4Anel" + i)[0].checked + "','FirstStageRemoved_Plano5':'" + $("#chkFirstRemovableStagePlan5Anel" + i)[0].checked +
                                    "','FirstStageRemoved_Plano6':'" + $("#chkFirstRemovableStagePlan6Anel" + i)[0].checked + "','SecondStageRemoved_Plano1':'" + $("#chkSecondRemovableStagePlan1Anel" + i)[0].checked +
                                    "','SecondStageRemoved_Plano2':'" + $("#chkSecondRemovableStagePlan2Anel" + i)[0].checked + "','SecondStageRemoved_Plano3':'" + $("#chkSecondRemovableStagePlan3Anel" + i)[0].checked +
                                    "','SecondStageRemoved_Plano4':'" + $("#chkSecondRemovableStagePlan4Anel" + i)[0].checked + "','SecondStageRemoved_Plano5':'" + $("#chkSecondRemovableStagePlan5Anel" + i)[0].checked +
                                    "','SecondStageRemoved_Plano6':'" + $("#chkSecondRemovableStagePlan6Anel" + i)[0].checked + "','usuarioLogado':'" + $("#hfUsuarioLogado").val() + "'}",
                                contentType: "application/json; charset=utf-8",
                                success: function (data) {
                                },
                                error: function (data) {
                                }
                            });
                        }
                        //#endregion
                        Swal.fire({
                            type: 'success',
                            title: getResourceItem("salvoTipoAlert"),
                            text: getResourceItem("salvoComSucesso"),
                        })

                        $("#divCadastro").css("display", "none");
                        $("#divPesquisa").css("display", "block");
                        carregarControladoresCad();
                        $("#divLoading").css("display", "none");
                    },
                    error: function (data) {
                        $("#divLoading").css("display", "none");
                    }
                });

                if (erro == true) {

                    $("#divLoading").css("display", "none");
                    return;
                }

                document.getElementById("txtControladorScn").disabled = false;
                document.getElementById("btnAdicionarAneis").disabled = false;
            }
            else {

                $.ajax({
                    type: 'POST',
                    url: 'Default.aspx/salvarAlteracoes',
                    dataType: 'json',
                    data: "{'controladorScn':'" + controladorScnFormatado + "', " +
                        " 'ipControlador':'" + $("#txtIpControlador").val() + "', " +
                        " 'modelo':'" + $("#txtModelo").val() + "', " +
                        " 'cruzamento':'" + $("#txtCruzamento").val() + "', " +
                        " 'lat':'" + $("#hfLatitude").val() + "', " +
                        " 'usuarioLogado':'" + $("#hfUsuarioLogado").val() + "', " +
                        " 'lon':'" + $("#hfLongitude").val() + "', " +
                        " 'anel1':'" + anel1 + "', 'anel2':'" + anel2 + "', " +
                        " 'anel3':'" + anel3 + "','anel4':'" + anel4 + "', " +
                        " 'qtdEstagio1':'" + qtdEstagio1 + "', " +
                        " 'qtdEstagio2':'" + qtdEstagio2 + "', " +
                        " 'qtdEstagio3':'" + qtdEstagio3 + "', " +
                        " 'qtdEstagio4':'" + qtdEstagio4 + "', " +
                        " 'tmpe1':'" + estagiosDesativarTMPE1 + "', " +
                        " 'tmpe2':'" + estagiosDesativarTMPE2 + "', " +
                        " 'tmpe3':'" + estagiosDesativarTMPE3 + "', " +
                        " 'tmpe4':'" + estagiosDesativarTMPE4 + "', " +
                        " 'id':'" + $("#hfIdControladorScoot").val() + "', " +
                        " 'cruzamentoAnel1':'" + cruzamentoAnel1 + "', " +
                        " 'cruzamentoAnel2':'" + cruzamentoAnel2 + "', " +
                        " 'cruzamentoAnel3':'" + cruzamentoAnel3 + "', " +
                        " 'cruzamentoAnel4':'" + cruzamentoAnel4 + "', " +
                        " 'tempoEnvioEstagio':'" + $("#txtTempoAntesEnvioEstagio").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        if (data.d != "sucesso") {

                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: (data.d),
                            })

                            $("#divLoading").css("display", "none");
                            return;
                        }

                        //#region Salva dados aneis
                        var qtdAnel = parseInt($("#hfQtdAneis").val());
                        for (var i = 1; i <= qtdAnel; i++) {
                            $.ajax({
                                type: 'POST',
                                url: 'Default.aspx/salvarAnel',
                                dataType: 'json',
                                data: "{'junction':'" + $("#lblScnAnel" + i)[0].innerHTML + "', " + " 'qtdFases':'" + $("#txtQtdFases" + i).val() + "','SlaveController':'"
                                    + $("#chkSlaveController" + i)[0].checked + "','DelayToIntergreen':'" + $("#txtDelayToIntergreen" + i).val() + "','Signal_Stuck_Inhibit':'"
                                    + $("#chkSignalStuckInhibit" + i)[0].checked + "','MinGreenCyclickCheckSequence':'" + $("#txtMinGreenCyclicCheckSequence" + i).val() +
                                    "','CyclicCheckSequence':'" + $("#txtCyclicCheckSequence" + i).val() + "','NonCyclicCheckSequence':'" + $("#txtNonCyclicCheckSequence" + i).val() +
                                    "','SL_BitMeaning':'" + $("#chkSLBitMeaning" + i)[0].checked + "','SmoothPlanChange':'" + $("#chkSmoothPlanUpdates" + i)[0].checked +
                                    "','RoadGreens_Main':'" + $("#txtRoadGreensMain" + i).val() + "','RoadGreens_Side':'" + $("#txtRoadGreensSide" + i).val() +
                                    "','ScnRegion':'" + $("#sleRegiao").val() + "','ScnNode':'" + $("#lblScnAnel" + i)[0].innerHTML.replace("J", "N") +
                                    "','MaxCycleTime':'" + $("#txtMaxCycleTime" + i).val() + "','NamedStage':'" + $("#txtNamedStage" + i).val() + "','CyclicFixedTime':'"
                                    + $("#txtCyclicFixedTime" + i).val() + "','DoubleCycling':'" + $("#chkDoubleCycling" + i)[0].checked + "','ForceSingleOrDoubleCycling':'"
                                    + $("#chkForceSingleOrDoubleCycling" + i)[0].checked + "','FirstRemovableStage':'" + $("#txtFirstRemovedStage" + i).val() +
                                    "','SecondRemovableStage':'" + $("#txtSecondRemovedStage" + i).val() + "','FirstStageRemoved_Plano1':'" + $("#chkFirstRemovableStagePlan1Anel" + i)[0].checked +
                                    "','FirstStageRemoved_Plano2':'" + $("#chkFirstRemovableStagePlan2Anel" + i)[0].checked + "','FirstStageRemoved_Plano3':'" + $("#chkFirstRemovableStagePlan3Anel" + i)[0].checked +
                                    "','FirstStageRemoved_Plano4':'" + $("#chkFirstRemovableStagePlan4Anel" + i)[0].checked + "','FirstStageRemoved_Plano5':'" + $("#chkFirstRemovableStagePlan5Anel" + i)[0].checked +
                                    "','FirstStageRemoved_Plano6':'" + $("#chkFirstRemovableStagePlan6Anel" + i)[0].checked + "','SecondStageRemoved_Plano1':'" + $("#chkSecondRemovableStagePlan1Anel" + i)[0].checked +
                                    "','SecondStageRemoved_Plano2':'" + $("#chkSecondRemovableStagePlan2Anel" + i)[0].checked + "','SecondStageRemoved_Plano3':'" + $("#chkSecondRemovableStagePlan3Anel" + i)[0].checked +
                                    "','SecondStageRemoved_Plano4':'" + $("#chkSecondRemovableStagePlan4Anel" + i)[0].checked + "','SecondStageRemoved_Plano5':'" + $("#chkSecondRemovableStagePlan5Anel" + i)[0].checked +
                                    "','SecondStageRemoved_Plano6':'" + $("#chkSecondRemovableStagePlan6Anel" + i)[0].checked + "','usuarioLogado':'" + $("#hfUsuarioLogado").val() + "'}",
                                contentType: "application/json; charset=utf-8",
                                success: function (data) {
                                },
                                error: function (data) {
                                }
                            });
                        }
                        //#endregion

                        Swal.fire({
                            type: 'success',
                            title: getResourceItem("salvoTipoAlert"),
                            text: getResourceItem("salvoComSucesso"),
                        });

                        $("#divCadastro").css("display", "none");
                        $("#divPesquisa").css("display", "block");
                        carregarControladoresCad();
                        $("#divLoading").css("display", "none");
                    },
                    error: function (data) {
                        $("#divLoading").css("display", "none");
                    }
                });

                //document.getElementById("txtControladorScn").disabled = false;
                //document.getElementById("btnAdicionarAneis").disabled = false;
            }
        }

        //VALIDAÇÕES
        function validarCampo() {

            if ($("#txtControladorScn").val() != "") {

                $("#txtControladorScn").removeClass("is-invalid");
            }

            if ($("#txtCruzamento").val() != "") {

                $("#txtCruzamento").removeClass("is-invalid");
            }

            if ($("#txtIpControlador").val() != "") {

                $("#txtIpControlador").removeClass("is-invalid");
            }
        }

        //SCRIPT PESQUISA ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
        function addNovoControlador() {

            $("#txtControladorScn").val("");
            $("#txtIpControlador").val("");
            $("#txtCruzamento").val("");
            $("#txtTempoAntesEnvioEstagio").val("");
            $("#txtModelo").val("");

            $("#hfQtdAneis").val("0");
            $("#rowScn1").css("display", "none");
            $("#rowScn2").css("display", "none");
            $("#rowScn3").css("display", "none");
            $("#rowScn4").css("display", "none");

            $("#sleRegiao")[0].disabled = false;
            $("#sleRegiao").val("");
            document.getElementById("txtControladorScn").disabled = false;
            document.getElementById("btnAdicionarAneis").disabled = false;
            document.getElementById("btnSalvar").innerHTML = "Salvar";
            $("#txtControladorScn").removeClass("is-invalid");
            $("#txtIpControlador").removeClass("is-invalid");
            $("#txtCruzamento").removeClass("is-invalid");

            var table = $("#tblScnAnel tbody");
            table.find('tr').each(function (i, el) {
                var $tds = $(this).find('td'),
                    statusTabela = $tds[0].innerText;

                if (statusTabela != "Não há registros!") {

                    $("#tblScnAnel").find("tbody").empty();

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td colspan='9' style='padding: 0.75rem 2rem;'>Não há registros!</td>";

                    newRow.append(cols);
                    $("#tbScnAnel").append(newRow);
                    return false;
                }
            });

            $("#divPesquisa").css("display", "none");
            $("#divCadastro").css("display", "block");
        }

        function fecharCadastro() {

            $("#divCadastro").css("display", "none");
            $("#divPesquisa").css("display", "block");

            $("#tblScnAnel").find("tbody").empty();

            var newRow = $("<tr>");
            var cols = "";
            cols += "<td colspan='9' style='padding: 0.75rem 2rem;'>Não há registros!</td>";

            newRow.append(cols);
            $("#tbScnAnel").append(newRow);
        }

        function Geocodificacao(endereco) {

            if (endereco == undefined || endereco == '') {

                endereco = document.getElementById("txtCruzamento").value;
            }
            if (endereco != "") {

                geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': endereco + ', Brasil', 'region': 'BR' }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        if (results[0]) {
                            var latitude = results[0].geometry.location.lat();
                            var longitude = results[0].geometry.location.lng();

                            document.getElementById("hfLatitude").value = latitude;
                            document.getElementById("hfLongitude").value = longitude;

                            var latlng = new google.maps.LatLng(latitude, longitude);

                            var options = {
                                zoom: 5,
                                center: latlng,
                                mapTypeId: google.maps.MapTypeId.ROADMAP
                            };

                            map = new google.maps.Map(document.getElementById("map"), options);

                            marker = new google.maps.Marker({
                                map: map,
                                draggable: true,
                                position: latlng
                            });
                            map.setZoom(15);
                            document.getElementById("map").style.visibility = "visible";

                            geocoder = new google.maps.Geocoder();
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
                            document.getElementById("map").style.visibility = "hidden";
                        }
                    }
                });
            }
        }

        //CARREGAR O GRID DIRETO DO BANCO
        function carregarControladoresCad() {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/carregarControladoresCad',
                dataType: 'json',
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        var i = 0;

                        $("#tbControladoresCad").empty();

                        while (data.d[i]) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='padding-top: 14px;'>" + lst.scnControlador + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst.ipControlador + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst.cruzamento + "</td>";

                            cols += "<td style='border-collapse: collapse; padding: 5px; width:1px;'> " +
                                " <button type='button' class='btn btn-icon btn-info mr-1' " +
                                " style='cursor:pointer; font-size:medium; margin-right: 0 !important;' " +
                                " onclick='editarControladorScoot(this)' data-id='" + lst.id + "' " +
                                " data-scnControlador='" + lst.scnControlador + "' " +
                                " data-ipControlador='" + lst.ipControlador + "' " +
                                " data-tempoEnvioEstagio='" + lst.tempoEnvioEstagio + "' " +
                                " data-cruzamento='" + lst.cruzamento + "' " +
                                " data-anel1='" + lst.anel1 + "' data-anel2='" + lst.anel2 + "' " +
                                " data-anel3='" + lst.anel3 + "' data-anel4='" + lst.anel4 + "' " +
                                " data-qtdestagio1='" + lst.qtdEstagio1 + "' " +
                                " data-qtdestagio2='" + lst.qtdEstagio2 + "' " +
                                " data-qtdestagio3='" + lst.qtdEstagio3 + "' " +
                                " data-qtdestagio4='" + lst.qtdEstagio4 + "' " +
                                " data-qtdCaractereIdentificacaoControlador='" + lst.qtdCaractereIdentificacaoControlador + "'" +
                                " data-tmpe1='" + lst.estagiosDesativarTMPE1 + "' " +
                                " data-tmpe2='" + lst.estagiosDesativarTMPE2 + "' " +
                                " data-tmpe3='" + lst.estagiosDesativarTMPE3 + "' " +
                                " data-tmpe4='" + lst.estagiosDesativarTMPE4 + "' " +
                                " data-cruzamentoAnel1='" + lst.cruzamentoAnel1 + "' " +
                                " data-cruzamentoAnel2='" + lst.cruzamentoAnel2 + "' " +
                                " data-cruzamentoAnel3='" + lst.cruzamentoAnel3 + "' " +
                                " data-cruzamentoAnel4='" + lst.cruzamentoAnel4 + "' " +
                                " data-modelo='" + lst.modelo + "'> " +
                                " <i class='ft-edit-3'></i></button></td>";

                            cols += "<td style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' class='btn btn-danger btn-xs' style='cursor:pointer; " +
                                " font-size:medium; margin-right: 0 !important;' onclick='excluirControladorScoot(this)' data-id='" + lst.id + "' data-anel1='" + lst.anel1 + "' " +
                                " data-anel2='" + lst.anel2 + "' data-anel3='" + lst.anel3 + "' data-anel4='" + lst.anel4 + "' data-scncontrolador='" + lst.scnControlador + "'><i class='ft-trash-2'></i></button></td>";

                            newRow.append(cols);
                            $("#tblControladoresCad").append(newRow);
                            i++;
                        }
                    }
                    else {
                        $("#tbControladoresCad").empty();
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='9' style='padding: 0.75rem 2rem;'>Não há registros!</td>";

                        newRow.append(cols);
                        $("#tblControladoresCad").append(newRow);
                    }

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {

                    $("#divLoading").css("display", "none");
                }
            });
        }

        function editarControladorScoot(status) {

            $("#divPesquisa").css("display", "none");
            $("#divCadastro").css("display", "block");


            $("#hfQtdAneis").val("0");
            $("#rowScn1").css("display", "none");
            $("#rowScn2").css("display", "none");
            $("#rowScn3").css("display", "none");
            $("#rowScn4").css("display", "none");

            $("#sleRegiao")[0].disabled = false;
            $("#sleRegiao").val("");

            var filtrarControlador = $(status).data("scncontrolador");
            var controladorFiltrado = filtrarControlador.substring(3, filtrarControlador.length - 1);

            $("#sleRegiao").val(filtrarControlador.substring(1, filtrarControlador.length - 3));
            $("#sleRegiao")[0].disabled = true;
            $("#txtControladorScn").val(controladorFiltrado);
            document.getElementById("txtControladorScn").disabled = true;
            $("#txtIpControlador").val($(status).data("ipcontrolador"));
            $("#txtQtdCaractereIdentControlador").val(status.dataset.qtdcaractereidentificacaocontrolador);
            $("#txtTempoAntesEnvioEstagio").val($(status).data("tempoenvioestagio"));
            $("#txtModelo").val($(status).data("modelo"));
            $("#txtCruzamento").val($(status).data("cruzamento"));
            Geocodificacao();
            $("#hfIdControladorScoot").val($(status).data("id"));

            anel1 = $(status).data("anel1");
            anel2 = $(status).data("anel2");
            anel3 = $(status).data("anel3");
            anel4 = $(status).data("anel4");

            qtdEstagio1 = $(status).data("qtdestagio1");
            qtdEstagio2 = $(status).data("qtdestagio2");
            qtdEstagio3 = $(status).data("qtdestagio3");
            qtdEstagio4 = $(status).data("qtdestagio4");

            tmpe1 = $(status).data("tmpe1");
            tmpe2 = $(status).data("tmpe2");
            tmpe3 = $(status).data("tmpe3");
            tmpe4 = $(status).data("tmpe4");

            cruzamentoAnel1 = $(status).data("cruzamentoanel1");
            cruzamentoAnel2 = $(status).data("cruzamentoanel2");
            cruzamentoAnel3 = $(status).data("cruzamentoanel3");
            cruzamentoAnel4 = $(status).data("cruzamentoanel4");
            var qtd = 0;

            //#region carrega anel 1
            if (anel1 != "") {
                qtd++;
                limpaCamposAnel(qtd);
                $("#lblScnAnel" + qtd)[0].innerHTML = anel1;
                $("#lblScnNodeAnel" + qtd)[0].innerHTML = "Scn Node: " + anel1.replace("J", "N");
                $("#txtLocation" + qtd).val(cruzamentoAnel1);
                $("#txtNumberofStages" + qtd).val(qtdEstagio1);
                $("#txtDesativarTMPE" + qtd).val(tmpe1);

                $("#btnExcluirAnel" + qtd).css("display", "");
                $("#rowScn" + qtd).css("display", "block");
                carregarDadosAnel(qtd, anel1);
            }
            //#endregion

            //#region carrega anel 2
            if (anel2 != "") {
                qtd++;

                $("#btnExcluirAnel1").css("display", "none");

                limpaCamposAnel(qtd);
                $("#lblScnAnel" + qtd)[0].innerHTML = anel2;
                $("#lblScnNodeAnel" + qtd)[0].innerHTML = "Scn Node: " + anel2.replace("J", "N");
                $("#txtLocation" + qtd).val(cruzamentoAnel2);
                $("#txtNumberofStages" + qtd).val(qtdEstagio2);
                $("#txtDesativarTMPE" + qtd).val(tmpe2);

                $("#btnExcluirAnel" + qtd).css("display", "");
                $("#rowScn" + qtd).css("display", "block");
                carregarDadosAnel(qtd, anel2);
            }
            //#endregion

            //#region carrega anel 3
            if (anel3 != "") {
                qtd++;

                $("#btnExcluirAnel1").css("display", "none");
                $("#btnExcluirAnel2").css("display", "none");

                limpaCamposAnel(qtd);
                $("#lblScnAnel" + qtd)[0].innerHTML = anel3;
                $("#lblScnNodeAnel" + qtd)[0].innerHTML = "Scn Node: " + anel3.replace("J", "N");
                $("#txtLocation" + qtd).val(cruzamentoAnel3);
                $("#txtNumberofStages" + qtd).val(qtdEstagio3);
                $("#txtDesativarTMPE" + qtd).val(tmpe3);

                $("#btnExcluirAnel" + qtd).css("display", "");
                $("#rowScn" + qtd).css("display", "block");
                carregarDadosAnel(qtd, anel3);
            }
            //#endregion

            //#region carrega anel 4
            if (anel4 != "") {
                qtd++;

                $("#btnExcluirAnel1").css("display", "none");
                $("#btnExcluirAnel2").css("display", "none");
                $("#btnExcluirAnel3").css("display", "none");

                limpaCamposAnel(qtd);
                $("#lblScnAnel" + qtd)[0].innerHTML = anel4;
                $("#lblScnNodeAnel" + qtd)[0].innerHTML = "Scn Node: " + anel4.replace("J", "N");
                $("#txtLocation" + qtd).val(cruzamentoAnel4);
                $("#txtNumberofStages" + qtd).val(qtdEstagio4);
                $("#txtDesativarTMPE" + qtd).val(tmpe4);

                $("#btnExcluirAnel" + qtd).css("display", "");
                $("#rowScn" + qtd).css("display", "block");
                carregarDadosAnel(qtd, anel4);
            }
            //#endregion

            $("#hfQtdAneis").val(qtd);

            if (qtd == 4) {
                $("#btnAdicionarAneis").css("display", "none");
            }  
            document.getElementById("btnSalvar").innerHTML = "Salvar Alterações";
        }

        function carregarDadosAnel(index, anel) {

            $("#divLoading").css("display", "block");
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/carregarDadosAnel',
                dataType: 'json',
                data: "{'junction':'" + anel + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var i = 0;
                    while (data.d[i]) {
                        var lst = data.d[i];

                        $("#txtDelayToIntergreen" + index).val(lst.DelayToIntergreen);
                        $("#txtRoadGreensMain" + index).val(lst.RoadGreensMain);
                        $("#txtRoadGreensSide" + index).val(lst.RoadGreensSide);
                        $("#txtNamedStage" + index).val(lst.NamedStage);
                        $("#txtCyclicFixedTime" + index).val(lst.CyclicFixedTime);
                        $("#txtMaxCycleTime" + index).val(lst.MaxCycleTime);
                        $("#txtMinGreenCyclicCheckSequence" + index).val(lst.MinGreenCyclicCheckSequence);
                        $("#txtCyclicCheckSequence" + index).val(lst.CyclicCheckSequence);
                        $("#txtLinkListNumber" + index).val(lst.LinkListNumber);
                        $("#txtFirstRemovedStage" + index).val(lst.FirstRemovableStage);
                        $("#txtSecondRemovedStage" + index).val(lst.SecondRemovableStage);
                        $("#txtQtdFases" + index).val(lst.QtdFases);

                        if (lst.SlaveController)
                            $("#chkSlaveController" + index).click();

                        if (lst.SignalStuckInhibit)
                            $('#chkSignalStuckInhibit' + index).click();
                        if (lst.SlBitMeaning)
                            $("#chkSLBitMeaning" + index).click();
                        if (lst.SmoothPlanChange)
                            $("#chkSmoothPlanUpdates" + index).click();
                        if (lst.DoubleCycling)
                            $("#chkDoubleCycling" + index).click();
                        if (lst.ForceSingleOrDoubleCycling)
                            $("#chkForceSingleOrDoubleCycling" + index).click();

                        $("#chkFirstRemovableStagePlan1Anel" + index)[0].checked = lst.FirstStageRemovedPlan1;
                        $("#chkFirstRemovableStagePlan2Anel" + index)[0].checked = lst.FirstStageRemovedPlan2;
                        $("#chkFirstRemovableStagePlan3Anel" + index)[0].checked = lst.FirstStageRemovedPlan3;
                        $("#chkFirstRemovableStagePlan4Anel" + index)[0].checked = lst.FirstStageRemovedPlan4;
                        $("#chkFirstRemovableStagePlan5Anel" + index)[0].checked = lst.FirstStageRemovedPlan5;
                        $("#chkFirstRemovableStagePlan6Anel" + index)[0].checked = lst.FirstStageRemovedPlan6;
                        $("#chkSecondRemovableStagePlan1Anel" + index)[0].checked = lst.SecondStageRemovedPlan1;
                        $("#chkSecondRemovableStagePlan2Anel" + index)[0].checked = lst.SecondStageRemovedPlan2;
                        $("#chkSecondRemovableStagePlan3Anel" + index)[0].checked = lst.SecondStageRemovedPlan3;
                        $("#chkSecondRemovableStagePlan4Anel" + index)[0].checked = lst.SecondStageRemovedPlan4;
                        $("#chkSecondRemovableStagePlan5Anel" + index)[0].checked = lst.SecondStageRemovedPlan5;
                        $("#chkSecondRemovableStagePlan6Anel" + index)[0].checked = lst.SecondStageRemovedPlan6;
                        i++;
                    }

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {

                    $("#divLoading").css("display", "none");
                }
            });
        }

        function excluirControladorScoot(status) {

            Swal.fire({
                title: getResourceItem("confirmarExclusaoTipoAlert"),
                text: getResourceItem("controladorProgramacoesSeraoExcluidas"),
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("simExcluir")
            }).then((result) => {
                if (result.value) {

                    $("#divLoading").css("display", "block");

                    $.ajax({
                        type: 'POST',
                        url: 'Default.aspx/excluirControladorScoot',
                        dataType: 'json',
                        data: "{'idControlador':'" + status.dataset.id + "','scnControlador':'" + status.dataset.scncontrolador + "','anel1':'" + status.dataset.anel1 + "','anel2':'" + status.dataset.anel2 + "', " +
                            " 'anel3':'" + status.dataset.anel3 + "','anel4':'" + status.dataset.anel4 + "','usuarioLogado':'" + $("#hfUsuarioLogado").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire(

                                getResourceItem("excluidoTipoAlert"),
                                getResourceItem("controladorProgramacoesExcluidas"),
                                'success'
                            )

                            carregarControladoresCad();
                            $("#divLoading").css("display", "none");
                        }
                    });
                }
            });
        }

        function removerAnel(anel) {

            Swal.fire({
                title: getResourceItem("confirmarExclusaoTipoAlert"),
                text: getResourceItem("ExclusaoAnel"),
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("simExcluir")
            }).then((result) => {
                if (result.value) {

                    $("#divLoading").css("display", "block");

                    $.ajax({
                        type: 'POST',
                        url: 'Default.aspx/ExcluirAnel',
                        dataType: 'json',
                        data: "{'junction':'" + $("#lblScnAnel" + anel)[0].innerHTML + "','usuarioLogado':'" + $("#hfUsuarioLogado").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            $("#rowScn" + anel).css("display", "none");
                            var qtd = parseInt($("#hfQtdAneis").val());
                            qtd--;

                            $("#hfQtdAneis").val(qtd); 
                            if (qtd == 1) {
                                $("#btnExcluirAnel1").css("display", "");
                            }
                            if (qtd == 2) {
                                $("#btnExcluirAnel2").css("display", "");
                            }
                            if (qtd == 3) {
                                $("#btnExcluirAnel3").css("display", "");
                                $("#btnAdicionarAneis").css("display", "");
                            }
                            $("#divLoading").css("display", "none");
                        }
                    });
                }
            });
        }

        function filtroDeBusca() {

            var input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("txtPesqControladorScn");
            filter = input.value.toUpperCase();
            table = document.getElementById("tbControladoresCad");
            tr = table.getElementsByTagName("tr");

            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        //SCRIPT TRADUÇÃO ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

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

        //SCRIPT TOOLTIP ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

        //$(function () {

        //    $('[data-toggle="tooltip"]').tooltip()
        //})
    </script>
</asp:Content>
