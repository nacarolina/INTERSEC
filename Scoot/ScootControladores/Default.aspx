<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Register.ScootControladores.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
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
                max-width: 66.6% !important;
            }

            .style-legend {
                width: 22%;
                margin-left: 1rem;
                padding-left: 1rem;
            }

            #colRoadGreensMain {
                flex: 50% !important;
                max-width: 50% !important;
                float: left;
                margin-bottom: 15px;
            }

            #colRoadGreensSide {
                flex: 50% !important;
                max-width: 50% !important;
                float: right;
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

            #colRoadGreensSide {
                flex: 50% !important;
                max-width: 50% !important;
                float: right;
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
            border: 2px solid #777777;
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
    <%= Resources.Resource.controladoresScoot %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfUsuarioLogado" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfLatitude" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfLongitude" ClientIDMode="Static" runat="server" />
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
                    <select id="sleArea" class="form-control"></select>
                    <input id="txtControladorScn" type="text" class="form-control"
                        onkeyup="validarQtdCaracter(this)"
                        onmouseout="validarCampo();" maxlength="4" />

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
                        onmouseout="validarCampo();" />
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

        <%--LISTAR ANÉIS CADASTRADOS--%>
        <div class="table-responsive">
            <table class="table table-bordered mb-0" id="tblScnAnel">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.scndoanel %> </th>
                        <th><%= Resources.Resource.cruzamento %> </th>
                        <th><%= Resources.Resource.qtdEstagios %> </th>
                        <th><%= Resources.Resource.desativarTMPE %> </th>
                        <th><%= Resources.Resource.cicloMin %> </th>
                        <th><%= Resources.Resource.cicloMax %> </th>
                        <th><%= Resources.Resource.permitirCicloDuplo %> </th>
                        <th><%= Resources.Resource.subArea %> </th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbScnAnel">
                    <tr>
                        <td colspan="9"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>

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

        <%--ANEL 1--%>
        <div class="row mb-1" id="rowScn1" style="display: none;">
            <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
                <div class="card box-shadow-0" data-appear="appear" style="margin-bottom: 0;">

                    <div class="card-header white bg-info" style="background-color: rgb(70 73 83) !important;">
                        <h4 class="card-title white" id="txtAnelAdicionado1">JXXX1</h4>
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
                                            <input id="txtNumberofStages1" type="number" min="2" max="8"
                                                class="form-control" onkeyup=""
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col1">
                                            <label class="m-0" for="txtNonCyclicCheckSequence1">
                                                Non Cyclic Check Sequence: 
                                                <span style="color: rgb(146 146 146 / 47%);">(Desativar TMPE)</span>
                                            </label>
                                            <input id="txtNonCyclicCheckSequence1" type="text" class="form-control"
                                                placeholder="Non Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDelayToIntergreen1">
                                                Delay to intergreen:
                                            </label>
                                            <input id="txtDelayToIntergreen1" type="text" class="form-control"
                                                placeholder="Delay to intergreen"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Slave Controller:
                                                <span style="color: rgb(146 146 146 / 47%);">(Escravo)</span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSlaveController1" unchecked="true" />
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtControllerType1">
                                                Controller type:
                                                <span style="color: rgb(146 146 146 / 47%);">(Modelo)</span>
                                            </label>
                                            <input id="txtControllerType1" type="text" class="form-control"
                                                placeholder="Controller type"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtLinkListNumber1">
                                                Link List Number:
                                            </label>
                                            <input id="txtLinkListNumber1" type="number" class="form-control"
                                                min="0" max="99" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Signal Stuck Inhibit:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSignalStuckInhibit1" unchecked="true" />
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtFormatType1">
                                                Format Type:
                                            </label>
                                            <input id="txtFormatType1" type="number" class="form-control"
                                                min="1" max="100"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtBitPosition1">
                                                F1/G1 Bit Position:
                                            </label>
                                            <input id="txtBitPosition1" type="number" class="form-control"
                                                min="0" max="14"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                SL Bit meaning:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMaxGreenCyclicCheckSequence1">
                                                Max Green Cyclic Check Sequence:
                                            </label>
                                            <input id="txtMaxGreenCyclicCheckSequence1" type="text"
                                                class="form-control" placeholder="Max Green Cyclic Check Sequence"
                                                onmouseout="" />
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
                                                class="form-control" placeholder="Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Smooth Plan Updates:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSmoothPlanUpdates1" unchecked="true" />
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
                                    </div>
                                </div>


                                <div class="col-md-6 style-roadGreens">
                                    <fieldset class="border-fieldset">
                                        <legend class="style-legend">Road Greens:
                                        </legend>
                                        <div class="form-group">
                                            <div class="col-md-6" id="colRoadGreensMain">
                                                <label for="txtRoadGreensMain">
                                                    Main:
                                                </label>
                                                <input type="text" id="txtRoadGreensMain1" class="form-control"
                                                    spellcheck="false" data-ms-editor="true" />
                                            </div>
                                            <div class="col-md-6" id="colRoadGreensSide">
                                                <label for="txtRoadGreensSide">
                                                    Side:
                                                </label>
                                                <input type="text" id="txtRoadGreensSide1" class="form-control"
                                                    spellcheck="false" data-ms-editor="true" />
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>

                            <%--BOTÕES DE AÇÃO--%>
                            <div class="row">
                                <div class="form-actions right" style="width: 100%;">
                                    <div class="form-actions right"
                                        style="border-top: 1px solid #e9ecef; margin-top: 1rem;">
                                        <div style="float: right; margin-top: 1rem;">
                                            <button type="button" class="btn btn-success" id="btnSalvarAnel1"
                                                onclick="">
                                                <%= Resources.Resource.salvar %>
                                            </button>
                                            <button id="btnExcluirAnel1" type="button"
                                                class="btn btn-danger btn-min-width mr-1 mb-1"
                                                style="margin-bottom: 0 !important;" onclick="">
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
        <div class="row mb-1" id="rowScn2" style="display: none;">
            <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
                <div class="card box-shadow-0" data-appear="appear" style="margin-bottom: 0;">

                    <div class="card-header white bg-info" style="background-color: rgb(70 73 83) !important;">
                        <h4 class="card-title white" id="txtAnelAdicionado2">JXXX2</h4>
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
                                            <input id="txtNumberofStages2" type="number" min="2" max="8"
                                                class="form-control" onkeyup=""
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col1">
                                            <label class="m-0" for="txtNonCyclicCheckSequence2">
                                                Non Cyclic Check Sequence: 
                                                <span style="color: rgb(146 146 146 / 47%);">(Desativar TMPE)</span>
                                            </label>
                                            <input id="txtNonCyclicCheckSequence2" type="text" class="form-control"
                                                placeholder="Non Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDelayToIntergreen2">
                                                Delay to intergreen:
                                            </label>
                                            <input id="txtDelayToIntergreen2" type="text" class="form-control"
                                                placeholder="Delay to intergreen"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Slave Controller:
                                                <span style="color: rgb(146 146 146 / 47%);">(Escravo)</span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSlaveController2" unchecked="true" />
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtControllerType2">
                                                Controller type:
                                                <span style="color: rgb(146 146 146 / 47%);">(Modelo)</span>
                                            </label>
                                            <input id="txtControllerType2" type="text" class="form-control"
                                                placeholder="Controller type"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtLinkListNumber2">
                                                Link List Number:
                                            </label>
                                            <input id="txtLinkListNumber2" type="number" class="form-control"
                                                min="0" max="99" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Signal Stuck Inhibit:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSignalStuckInhibit2" unchecked="true" />
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtFormatType2">
                                                Format Type:
                                            </label>
                                            <input id="txtFormatType2" type="number" class="form-control"
                                                min="1" max="100"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtBitPosition2">
                                                F1/G1 Bit Position:
                                            </label>
                                            <input id="txtBitPosition2" type="number" class="form-control"
                                                min="0" max="14"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                SL Bit meaning:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMaxGreenCyclicCheckSequence2">
                                                Max Green Cyclic Check Sequence:
                                            </label>
                                            <input id="txtMaxGreenCyclicCheckSequence2" type="text"
                                                class="form-control" placeholder="Max Green Cyclic Check Sequence"
                                                onmouseout="" />
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
                                                class="form-control" placeholder="Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Smooth Plan Updates:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSmoothPlanUpdates2" unchecked="true" />
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
                                    </div>
                                </div>


                                <div class="col-md-6 style-roadGreens">
                                    <fieldset class="border-fieldset">
                                        <legend class="style-legend">Road Greens:
                                        </legend>
                                        <div class="form-group">
                                            <div class="col-md-6" id="colRoadGreensMain">
                                                <label for="txtRoadGreensMain2">
                                                    Main:
                                                </label>
                                                <input type="text" id="txtRoadGreensMain2" class="form-control"
                                                    spellcheck="false" data-ms-editor="true" />
                                            </div>
                                            <div class="col-md-6" id="colRoadGreensSide">
                                                <label for="txtRoadGreensSide2">
                                                    Side:
                                                </label>
                                                <input type="text" id="txtRoadGreensSide2" class="form-control"
                                                    spellcheck="false" data-ms-editor="true" />
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>

                            <%--BOTÕES DE AÇÃO--%>
                            <div class="row">
                                <div class="form-actions right" style="width: 100%;">
                                    <div class="form-actions right"
                                        style="border-top: 1px solid #e9ecef; margin-top: 1rem;">
                                        <div style="float: right; margin-top: 1rem;">
                                            <button type="button" class="btn btn-success" id="btnSalvarAnel2"
                                                onclick="">
                                                <%= Resources.Resource.salvar %>
                                            </button>
                                            <button id="btnExcluirAnel2" type="button"
                                                class="btn btn-danger btn-min-width mr-1 mb-1"
                                                style="margin-bottom: 0 !important;" onclick="">
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
        <div class="row mb-1" id="rowScn3" style="display: none;">
            <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
                <div class="card box-shadow-0" data-appear="appear" style="margin-bottom: 0;">

                    <div class="card-header white bg-info" style="background-color: rgb(70 73 83) !important;">
                        <h4 class="card-title white" id="txtAnelAdicionado3">JXXX3</h4>
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
                                            <input id="txtNumberofStages3" type="number" min="2" max="8"
                                                class="form-control" onkeyup=""
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col1">
                                            <label class="m-0" for="txtNonCyclicCheckSequence3">
                                                Non Cyclic Check Sequence: 
                                                <span style="color: rgb(146 146 146 / 47%);">(Desativar TMPE)</span>
                                            </label>
                                            <input id="txtNonCyclicCheckSequence3" type="text" class="form-control"
                                                placeholder="Non Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDelayToIntergreen3">
                                                Delay to intergreen:
                                            </label>
                                            <input id="txtDelayToIntergreen3" type="text" class="form-control"
                                                placeholder="Delay to intergreen"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Slave Controller:
                                                <span style="color: rgb(146 146 146 / 47%);">(Escravo)</span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSlaveController3" unchecked="true" />
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtControllerType3">
                                                Controller type:
                                                <span style="color: rgb(146 146 146 / 47%);">(Modelo)</span>
                                            </label>
                                            <input id="txtControllerType3" type="text" class="form-control"
                                                placeholder="Controller type"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtLinkListNumber3">
                                                Link List Number:
                                            </label>
                                            <input id="txtLinkListNumber3" type="number" class="form-control"
                                                min="0" max="99" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Signal Stuck Inhibit:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSignalStuckInhibit3" unchecked="true" />
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtFormatType3">
                                                Format Type:
                                            </label>
                                            <input id="txtFormatType3" type="number" class="form-control"
                                                min="1" max="100"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtBitPosition3">
                                                F1/G1 Bit Position:
                                            </label>
                                            <input id="txtBitPosition3" type="number" class="form-control"
                                                min="0" max="14"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                SL Bit meaning:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMaxGreenCyclicCheckSequence3">
                                                Max Green Cyclic Check Sequence:
                                            </label>
                                            <input id="txtMaxGreenCyclicCheckSequence3" type="text"
                                                class="form-control" placeholder="Max Green Cyclic Check Sequence"
                                                onmouseout="" />
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
                                                class="form-control" placeholder="Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Smooth Plan Updates:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSmoothPlanUpdates3" unchecked="true" />
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
                                    </div>
                                </div>


                                <div class="col-md-6 style-roadGreens">
                                    <fieldset class="border-fieldset">
                                        <legend class="style-legend">Road Greens:
                                        </legend>
                                        <div class="form-group">
                                            <div class="col-md-6" id="colRoadGreensMain">
                                                <label for="txtRoadGreensMain3">
                                                    Main:
                                                </label>
                                                <input type="text" id="txtRoadGreensMain3" class="form-control"
                                                    spellcheck="false" data-ms-editor="true" />
                                            </div>
                                            <div class="col-md-6" id="colRoadGreensSide">
                                                <label for="txtRoadGreensSide3">
                                                    Side:
                                                </label>
                                                <input type="text" id="txtRoadGreensSide3" class="form-control"
                                                    spellcheck="false" data-ms-editor="true" />
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>

                            <%--BOTÕES DE AÇÃO--%>
                            <div class="row">
                                <div class="form-actions right" style="width: 100%;">
                                    <div class="form-actions right"
                                        style="border-top: 1px solid #e9ecef; margin-top: 1rem;">
                                        <div style="float: right; margin-top: 1rem;">
                                            <button type="button" class="btn btn-success" id="btnSalvarAnel3"
                                                onclick="">
                                                <%= Resources.Resource.salvar %>
                                            </button>
                                            <button id="btnExcluirAnel3" type="button"
                                                class="btn btn-danger btn-min-width mr-1 mb-1"
                                                style="margin-bottom: 0 !important;" onclick="">
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
        <div class="row" id="rowScn4" style="display: none;">
            <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
                <div class="card box-shadow-0" data-appear="appear" style="margin-bottom: 0;">

                    <div class="card-header white bg-info" style="background-color: rgb(70 73 83) !important;">
                        <h4 class="card-title white" id="txtAnelAdicionado4">JXXX4</h4>
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
                                            <input id="txtNumberofStages4" type="number" min="2" max="8"
                                                class="form-control" onkeyup=""
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col1">
                                            <label class="m-0" for="txtNonCyclicCheckSequence4">
                                                Non Cyclic Check Sequence: 
                                                <span style="color: rgb(146 146 146 / 47%);">(Desativar TMPE)</span>
                                            </label>
                                            <input id="txtNonCyclicCheckSequence4" type="text" class="form-control"
                                                placeholder="Non Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtDelayToIntergreen4">
                                                Delay to intergreen:
                                            </label>
                                            <input id="txtDelayToIntergreen4" type="text" class="form-control"
                                                placeholder="Delay to intergreen"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Slave Controller:
                                                <span style="color: rgb(146 146 146 / 47%);">(Escravo)</span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSlaveController4" unchecked="true" />
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtControllerType4">
                                                Controller type:
                                                <span style="color: rgb(146 146 146 / 47%);">(Modelo)</span>
                                            </label>
                                            <input id="txtControllerType4" type="text" class="form-control"
                                                placeholder="Controller type"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtLinkListNumber4">
                                                Link List Number:
                                            </label>
                                            <input id="txtLinkListNumber4" type="number" class="form-control"
                                                min="0" max="99" onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Signal Stuck Inhibit:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSignalStuckInhibit4" unchecked="true" />
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtFormatType4">
                                                Format Type:
                                            </label>
                                            <input id="txtFormatType4" type="number" class="form-control"
                                                min="1" max="100"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtBitPosition4">
                                                F1/G1 Bit Position:
                                            </label>
                                            <input id="txtBitPosition4" type="number" class="form-control"
                                                min="0" max="14"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                SL Bit meaning:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
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
                                    </div>
                                </div>

                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col2">
                                            <label class="m-0" for="txtMaxGreenCyclicCheckSequence4">
                                                Max Green Cyclic Check Sequence:
                                            </label>
                                            <input id="txtMaxGreenCyclicCheckSequence4" type="text"
                                                class="form-control" placeholder="Max Green Cyclic Check Sequence"
                                                onmouseout="" />
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
                                                class="form-control" placeholder="Cyclic Check Sequence"
                                                onmouseout="" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 colInteira">
                                    <div class="form-group row">
                                        <div class="col-md-9" id="col8">
                                            <label class="m-0">
                                                Smooth Plan Updates:
                                                <span style="color: rgb(146 146 146 / 47%);"></span>
                                            </label>
                                            <div>
                                                <input type="checkbox" class="switchery "
                                                    data-color="success" data-switchery="false"
                                                    id="chkSmoothPlanUpdates4" unchecked="true" />
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
                                    </div>
                                </div>


                                <div class="col-md-6 style-roadGreens">
                                    <fieldset class="border-fieldset">
                                        <legend class="style-legend">Road Greens:
                                        </legend>
                                        <div class="form-group">
                                            <div class="col-md-6" id="colRoadGreensMain">
                                                <label for="txtRoadGreensMain4">
                                                    Main:
                                                </label>
                                                <input type="text" id="txtRoadGreensMain4" class="form-control"
                                                    spellcheck="false" data-ms-editor="true" />
                                            </div>
                                            <div class="col-md-6" id="colRoadGreensSide">
                                                <label for="txtRoadGreensSide4">
                                                    Side:
                                                </label>
                                                <input type="text" id="txtRoadGreensSide4" class="form-control"
                                                    spellcheck="false" data-ms-editor="true" />
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>

                            <%--BOTÕES DE AÇÃO--%>
                            <div class="row">
                                <div class="form-actions right" style="width: 100%;">
                                    <div class="form-actions right"
                                        style="border-top: 1px solid #e9ecef; margin-top: 1rem;">
                                        <div style="float: right; margin-top: 1rem;">
                                            <button type="button" class="btn btn-success" id="btnSalvarAnel4"
                                                onclick="">
                                                <%= Resources.Resource.salvar %>
                                            </button>
                                            <button id="btnExcluirAnel4" type="button"
                                                class="btn btn-danger btn-min-width mr-1 mb-1"
                                                style="margin-bottom: 0 !important;" onclick="">
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
        autocomplete(document.getElementById("txtIRN1"));

        $(function () {

            loadResourcesLocales();
            carregarControladoresCad();
            Geocodificacao('Foz do Iguaçu,PR');
        });

        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });

        //cria um novo array vazio
        var arrayItensExcluidos = [];

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

            $("#divLoading").css("display", "block");

            //se nao foi excluido nenhum anel
            if (arrayItensExcluidos.length == 0) {

                //uma variavel para saber se tem cada anel
                var temAnel1 = false, temAnel2 = false, temAnel3 = false, temAnel4 = false;

                var table = $("#tblScnAnel tbody");
                table.find('tr').each(function (i, el) {
                    i = table.find('tr').length;
                    var $tds = $(this).find('td'),
                        statusTabela = $tds[0].innerText;

                    //se nao tem nenhum anel na tabela
                    if (statusTabela == "Não há registros!") {
                        $("#tbScnAnel").empty();
                    }

                    if (statusTabela.substring(statusTabela.length - 1) == 1) {

                        temAnel1 = true;
                    }
                    if (statusTabela.substring(statusTabela.length - 1) == 2) {

                        temAnel2 = true;
                    }
                    if (statusTabela.substring(statusTabela.length - 1) == 3) {

                        temAnel3 = true;
                    }
                    if (statusTabela.substring(statusTabela.length - 1) == 4) {

                        temAnel4 = true;
                    }
                });

                //vou verificar quais sao os aneis que eu nao tenho para poder adicionar
                if (temAnel1 == false) {

                    var scnControladorAdicionado = "J" + $("#txtControladorScn").val() + "1";
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='vertical-align: middle;'>" + scnControladorAdicionado + "</td>";
                    //CRUZAMENTO
                    cols += "<td style='padding: 5px; width: 60%;'><input type='text' id='txtCruzamentoAnel" + scnControladorAdicionado + "' class='form-control' /></td>";
                    //QTD ESTÁGIOS
                    cols += "<td style='padding: 5px; width: 1px;'><input type='number' min='2' max='8' id='txtQtdEstagios" + scnControladorAdicionado + "' class='form-control' /></td>";
                    //DESATIVAR TMPE
                    cols += "<td style='padding: 5px; width: 1px;'><input type='text' id='txtDesativarTMPE" + scnControladorAdicionado + "' data-anel='" + scnControladorAdicionado + "' style='text-transform:uppercase' onkeyup='validaDesativacaoTMPE(this)' class='form-control' /></td>";
                    //CICLO MIN
                    cols += "<td style='padding: 5px; width: 1px;'><input type='number' id='txtCicloMin" + scnControladorAdicionado + "' data-cicloMin='" + scnControladorAdicionado + "' style='text-transform:uppercase' class='form-control' /></td>";
                    //CICLO MAX
                    cols += "<td style='padding: 5px; width: 1px;'><input type='number' id='txtCicloMax" + scnControladorAdicionado + "' data-cicloMax='" + scnControladorAdicionado + "' style='text-transform:uppercase' class='form-control' /></td> ";
                    //PERMITIR CICLO DUPLO
                    cols += "<td style='width: 1px;'><div class='checkbox' style='text-align-last: center;'><label style='margin-bottom: 0; margin-top: 5px;'><input type='checkbox' id='chkPermitirCicloDuplo" + scnControladorAdicionado + "' /><span class='cr'><i class='cr-icon fa fa-check'></i></span></label></div></td>";
                    //SUBÁREA
                    cols += "<td style='padding: 5px; width: 1px;'><select class='form-control' id='sleSubArea" + scnControladorAdicionado + "'></select></td> ";
                    //BTN EXCLUIR
                    cols += "<td class='form-group' style='padding: 5px; width:1px;'><button type='button' class='btn btn-danger btn-xs' style='cursor:pointer;' onclick='removerAnel(this)' data-scnControlador='" + scnControladorAdicionado + "'><i class='ft-trash-2'></i></button></td>";

                    newRow.append(cols);
                    $("#tblScnAnel").append(newRow);

                    $("#divLoading").css("display", "none");
                    ordenarGrid();
                }
                else if (temAnel2 == false) {

                    var scnControladorAdicionado = "J" + $("#txtControladorScn").val() + "2";
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + scnControladorAdicionado + "</td>";
                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 60%;'><input type='text' id='txtCruzamentoAnel" + scnControladorAdicionado + "' class='form-control' /></td>";

                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='number' min='2' max='8' id='txtQtdEstagios" + scnControladorAdicionado + "' class='form-control' /></td>";
                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='text' id='txtDesativarTMPE" + scnControladorAdicionado + "' data-anel='" + scnControladorAdicionado + "' style='text-transform:uppercase' onkeyup='validaDesativacaoTMPE(this)' class='form-control' /></td>";

                    cols += "<td class='form-group' style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' class='btn btn-danger btn-xs' " +
                        " style='cursor:pointer;' onclick='removerAnel(this)' data-scnControlador='" + scnControladorAdicionado + "'><i class='ft-trash-2'></i></button></td>";

                    newRow.append(cols);
                    $("#tblScnAnel").append(newRow);

                    $("#divLoading").css("display", "none");
                    ordenarGrid();
                }
                else if (temAnel3 == false) {

                    var scnControladorAdicionado = "J" + $("#txtControladorScn").val() + "3";
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + scnControladorAdicionado + "</td>";
                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 60%;'><input type='text' id='txtCruzamentoAnel" + scnControladorAdicionado + "' class='form-control' /></td>";

                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='number' min='2' max='8' id='txtQtdEstagios" + scnControladorAdicionado + "' class='form-control' /></td>";
                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='text' id='txtDesativarTMPE" + scnControladorAdicionado + "' data-anel='" + scnControladorAdicionado + "' style='text-transform:uppercase' onkeyup='validaDesativacaoTMPE(this)' class='form-control' /></td>";

                    cols += "<td class='form-group' style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' class='btn btn-danger btn-xs' " +
                        " style='cursor:pointer;' onclick='removerAnel(this)' data-scnControlador='" + scnControladorAdicionado + "'><i class='ft-trash-2'></i></button></td>";

                    newRow.append(cols);
                    $("#tblScnAnel").append(newRow);

                    $("#divLoading").css("display", "none");
                    ordenarGrid();
                }
                else if (temAnel4 == false) {

                    var scnControladorAdicionado = "J" + $("#txtControladorScn").val() + "4";
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + scnControladorAdicionado + "</td>";
                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 60%;'><input type='text' id='txtCruzamentoAnel" + scnControladorAdicionado + "' class='form-control' /></td>";

                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='number' min='2' max='8' id='txtQtdEstagios" + scnControladorAdicionado + "' class='form-control' /></td>";
                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='text' id='txtDesativarTMPE" + scnControladorAdicionado + "' data-anel='" + scnControladorAdicionado + "' style='text-transform:uppercase' onkeyup='validaDesativacaoTMPE(this)' class='form-control' /></td>";

                    cols += "<td class='form-group' style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' class='btn btn-danger btn-xs' " +
                        " style='cursor:pointer;' onclick='removerAnel(this)' data-scnControlador='" + scnControladorAdicionado + "'><i class='ft-trash-2'></i></button></td>";

                    newRow.append(cols);
                    $("#tblScnAnel").append(newRow);

                    $("#divLoading").css("display", "none");
                    ordenarGrid();
                }

                //verificar se eu ja tenho as 4 linhas adicionadas no grid
                if (table[0].rows.length == 4) {

                    document.getElementById("btnAdicionarAneis").disabled = true;
                    $("#divLoading").css("display", "none");
                }
            }
            else {

                var table = $("#tblScnAnel tbody");
                if (table[0].rows.length == 1) {

                    var td = table[0].rows[0].cells;
                    var statusTabela = td[0].innerText;

                    if (statusTabela == "Não há registros!") {

                        $("#tbScnAnel").empty();
                    }
                }

                var item1 = "", indexPrimeiro;
                for (var i = 0; i < arrayItensExcluidos.length; i++) {

                    if (arrayItensExcluidos[i] != undefined && item1 == "") {

                        item1 = arrayItensExcluidos[i];
                        indexPrimeiro = i;
                    }
                }

                var scnControladorAdicionado = item1;
                var newRow = $("<tr>");
                var cols = "";
                cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + scnControladorAdicionado + "</td>";
                cols += "<td style='border-collapse: collapse; padding: 5px; width: 60%;'><input type='text' id='txtCruzamentoAnel" + scnControladorAdicionado + "' class='form-control' /></td>";

                cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='number' min='2' max='8' id='txtQtdEstagios" + scnControladorAdicionado + "' class='form-control' /></td>";
                cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='text' id='txtDesativarTMPE" + scnControladorAdicionado + "' style='text-transform:uppercase' onkeyup='validaDesativacaoTMPE(this)' class='form-control' /></td>";

                cols += "<td class='form-group' style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' class='btn btn-danger btn-xs' " +
                    " style='cursor:pointer;' onclick='removerAnel(this)' data-scnControlador='" + scnControladorAdicionado + "'><i class='ft-trash-2'></i></button></td>";

                newRow.append(cols);
                $("#tblScnAnel").append(newRow);

                delete arrayItensExcluidos[indexPrimeiro];

                var table = $("#tblScnAnel tbody");
                if (table[0].rows.length == 4) {

                    document.getElementById("btnAdicionarAneis").disabled = true;
                }
                ordenarGrid();
                $("#divLoading").css("display", "none");
                return false;
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

        function ordenarGrid() {
            var table, rows, switching, i, x, y, shouldSwitch;
            table = document.getElementById("tblScnAnel");
            switching = true;
            /*Make a loop that will continue until
            no switching has been done:*/
            while (switching) {
                //start by saying: no switching is done:
                switching = false;
                rows = table.rows;
                /*Loop through all table rows (except the
                first, which contains table headers):*/
                for (i = 1; i < (rows.length - 1); i++) {
                    //start by saying there should be no switching:
                    shouldSwitch = false;
                    /*Get the two elements you want to compare,
                    one from current row and one from the next:*/
                    x = rows[i].getElementsByTagName("TD")[0].innerText;
                    x = x.substring(x.length, x.length - 1)

                    y = rows[i + 1].getElementsByTagName("TD")[0].innerText;
                    y = y.substring(y.length, y.length - 1)

                    //check if the two rows should switch place:
                    if (Number(x) > Number(y)) {
                        //if so, mark as a switch and break the loop:
                        shouldSwitch = true;
                        break;
                    }
                }
                if (shouldSwitch) {
                    /*If a switch has been marked, make the switch
                    and mark that a switch has been done:*/
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                }
            }
        }

        function autocomplete(inp) {
            /*the autocomplete function takes two arguments,
            the text field element and an array of possible autocompleted values:*/
            var currentFocus;
            /*execute a function when someone writes in the text field:*/
            inp.addEventListener("input", function (e) {

                var a, b, i, val = this.value;
                /*close any already open lists of autocompleted values*/
                closeAllLists();
                if (!val) { return false; }
                currentFocus = -1;
                /*create a DIV element that will contain the items (values):*/
                a = document.createElement("DIV");
                a.setAttribute("id", this.id + "autocomplete-list");
                a.setAttribute("class", "autocomplete-items");
                /*append the DIV element as a child of the autocomplete container:*/
                this.parentNode.appendChild(a);


                $.ajax({
                    type: 'POST',
                    url: 'CadastroProdutoBeta.aspx/carregarFabricante',
                    dataType: 'json',
                    data: "{}",
                    //async: false,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        if (data.d != "") {

                            var i = 0;
                            while (data.d[i]) {

                                var arr = data.d;

                                /*check if the item starts with the same letters as the text field value:*/
                                if (arr[i].razaosocial.substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                                    /*create a DIV element for each matching element:*/
                                    b = document.createElement("DIV");
                                    /*make the matching letters bold:*/
                                    b.innerHTML = "<strong>" + arr[i].razaosocial.substr(0, val.length) + "</strong>";
                                    b.innerHTML += arr[i].razaosocial.substr(val.length);
                                    /*insert a input field that will hold the current array item's value:*/
                                    b.innerHTML += "<input type='hidden' data-idfabricante='" + arr[i].id + "' value='" + arr[i].razaosocial + "'>";
                                    /*execute a function when someone clicks on the item value (DIV element):*/
                                    b.addEventListener("click", function (e) {
                                        /*insert the value for the autocomplete text field:*/
                                        inp.value = this.getElementsByTagName("input")[0].value;
                                        inp.dataset.idfabricante = this.getElementsByTagName("input")[0].dataset.idfabricante;
                                        /*close the list of autocompleted values,
                                        (or any other open lists of autocompleted values:*/
                                        closeAllLists();
                                    });
                                    a.appendChild(b);
                                }

                                i++;
                            }

                            $("#divLoading").css("display", "none");
                        }

                        $("#divLoading").css("display", "none");
                    }
                });
            });
            /*execute a function presses a key on the keyboard:*/
            inp.addEventListener("keydown", function (e) {
                var x = document.getElementById(this.id + "autocomplete-list");
                if (x) x = x.getElementsByTagName("div");
                if (e.keyCode == 40) {
                    /*If the arrow DOWN key is pressed,
                    increase the currentFocus variable:*/
                    currentFocus++;
                    /*and and make the current item more visible:*/
                    addActive(x);
                } else if (e.keyCode == 38) { //up
                    /*If the arrow UP key is pressed,
                    decrease the currentFocus variable:*/
                    currentFocus--;
                    /*and and make the current item more visible:*/
                    addActive(x);
                } else if (e.keyCode == 13) {
                    /*If the ENTER key is pressed, prevent the form from being submitted,*/
                    e.preventDefault();
                    if (currentFocus > -1) {
                        /*and simulate a click on the "active" item:*/
                        if (x) x[currentFocus].click();
                    }
                }
            });
            function addActive(x) {
                /*a function to classify an item as "active":*/
                if (!x) return false;
                /*start by removing the "active" class on all items:*/
                removeActive(x);
                if (currentFocus >= x.length) currentFocus = 0;
                if (currentFocus < 0) currentFocus = (x.length - 1);
                /*add class "autocomplete-active":*/
                x[currentFocus].classList.add("autocomplete-active");
            }
            function removeActive(x) {
                /*a function to remove the "active" class from all autocomplete items:*/
                for (var i = 0; i < x.length; i++) {
                    x[i].classList.remove("autocomplete-active");
                }
            }
            function closeAllLists(elmnt) {
                /*close all autocomplete lists in the document,
                except the one passed as an argument:*/
                var x = document.getElementsByClassName("autocomplete-items");
                for (var i = 0; i < x.length; i++) {
                    if (elmnt != x[i] && elmnt != inp) {
                        x[i].parentNode.removeChild(x[i]);
                    }
                }
            }
            /*execute a function when someone clicks in the document:*/
            document.addEventListener("click", function (e) {
                closeAllLists(e.target);
            });
        }


        function validarQtdCaracter(txt) {
            if (txt.value.length < 4) {
                $("#txtQtdCaractereIdentControlador").val(3 + txt.value.length);
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

            $("#divLoading").css("display", "block");

            if (document.getElementById("btnSalvar").innerHTML == "Salvar") {

                var erro = false;
                var table = $("#tblScnAnel tbody");
                var anel1 = "", anel2 = "", anel3 = "", anel4 = "";
                var qtdEstagio1 = "", qtdEstagio2 = "", qtdEstagio3 = "", qtdEstagio4 = "",
                    cruzamentoAnel1 = "", cruzamentoAnel2 = "", cruzamentoAnel3 = "", cruzamentoAnel4 = "";

                //#region VALIDAÇÕES E ARMAZENAMENTO DE VALORES
                table.find('tr').each(function (i, el) {
                    var tds = $(this).find('td')

                    if (i == 0) {

                        anel1 = tds[0].innerHTML;
                        if (anel1 == "Não há registros!") {

                            anel1 = "";
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("informeUmAnel"),
                            })
                            erro = true;
                            return;
                        }
                        cruzamentoAnel1 = tds[1].firstElementChild.value;
                        qtdEstagio1 = tds[2].firstElementChild.value;
                        if (qtdEstagio1 == "" || parseInt(qtdEstagio1) < 2 || parseInt(qtdEstagio1) > 8) {

                            erro = true;
                            $("#txtQtdEstagios" + anel1 + "").addClass("is-invalid");
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("alertQtdEstagioVazio"),
                            })
                            return;
                        }
                        else {
                            $("#txtQtdEstagios" + anel1 + "").removeClass("is-invalid");
                        }
                        estagiosDesativarTMPE1 = tds[3].firstElementChild.value.toUpperCase();
                    }
                    if (i == 1) {

                        anel2 = tds[0].innerHTML;
                        cruzamentoAnel2 = tds[1].firstElementChild.value;
                        qtdEstagio2 = tds[2].firstElementChild.value;
                        if (qtdEstagio2 == "" || parseInt(qtdEstagio2) < 2 || parseInt(qtdEstagio2) > 8) {

                            erro = true;
                            $("#txtQtdEstagios" + anel2 + "").addClass("is-invalid");
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("alertQtdEstagioVazio"),
                            })
                            return;
                        }
                        else {
                            $("#txtQtdEstagios" + anel2 + "").removeClass("is-invalid");
                        }
                        estagiosDesativarTMPE2 = tds[3].firstElementChild.value.toUpperCase();
                    }
                    if (i == 2) {

                        anel3 = tds[0].innerHTML;
                        cruzamentoAnel3 = tds[1].firstElementChild.value;
                        qtdEstagio3 = tds[2].firstElementChild.value;
                        if (qtdEstagio3 == "" || parseInt(qtdEstagio3) < 2 || parseInt(qtdEstagio3) > 8) {

                            erro = true;
                            $("#txtQtdEstagios" + anel3 + "").addClass("is-invalid");
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("alertQtdEstagioVazio"),
                            })
                            return;
                        }
                        else {
                            $("#txtQtdEstagios" + anel3 + "").removeClass("is-invalid");
                        }
                        estagiosDesativarTMPE3 = tds[3].firstElementChild.value.toUpperCase();
                    }
                    if (i == 3) {

                        anel4 = tds[0].innerHTML;
                        cruzamentoAnel4 = tds[1].firstElementChild.value;
                        qtdEstagio4 = tds[2].firstElementChild.value;
                        if (qtdEstagio4 == "" || parseInt(qtdEstagio4) < 2 || parseInt(qtdEstagio4) > 8) {

                            erro = true;
                            $("#txtQtdEstagios" + anel4 + "").addClass("is-invalid");
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("alertQtdEstagioVazio"),
                            })
                            return;
                        }
                        else {
                            $("#txtQtdEstagios" + anel4 + "").removeClass("is-invalid");
                        }
                        estagiosDesativarTMPE4 = tds[3].firstElementChild.value.toUpperCase();
                    }
                });
                //#endregion

                if (erro == true) {

                    $("#divLoading").css("display", "none");
                    return;
                }

                var controladorScnFormatado = "X" + $("#txtControladorScn").val() + "0";
                $.ajax({
                    type: 'POST',
                    url: 'Default.aspx/salvar',
                    dataType: 'json',
                    data: "{'qtdCaracteres':'" + $("#txtQtdCaractereIdentControlador").val() + "', " +
                        " 'controladorScn':'" + controladorScnFormatado + "', " +
                        " 'ipControlador':'" + $("#txtIpControlador").val() + "', " +
                        " 'cruzamento':'" + $("#txtCruzamento").val() + "', " +
                        " 'lat':'" + $("#hfLatitude").val() + "', " +
                        " 'usuarioLogado':'" + $("#hfUsuarioLogado").val() + "', " +
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
                        " 'tempoEnvioEstagio':'" + $("#txtTempoAntesEnvioEstagio").val() + "'}",
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

                if ($("#txtCruzamento").val() == "" && $("#txtIpControlador").val() == "") {

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

                if ($("#txtIpControlador").val() == "") {

                    $("#txtIpControlador").addClass("is-invalid");
                    Swal.fire({

                        type: 'error',
                        title: getResourceItem("erroTipoAlert"),
                        text: getResourceItem("insiraIpControlador"),
                    })
                    return;
                }

                var erro = false;
                var table = $("#tblScnAnel tbody");
                var anel1 = "", anel2 = "", anel3 = "", anel4 = "";
                var qtdEstagio1 = "", qtdEstagio2 = "", qtdEstagio3 = "", qtdEstagio4 = "",
                    cruzamentoAnel1 = "", cruzamentoAnel2 = "", cruzamentoAnel3 = "", cruzamentoAnel4 = "";

                //#region VALIDAÇÕES E ARMAZENAMENTO DE VALORES
                table.find('tr').each(function (i, el) {
                    var tds = $(this).find('td')

                    if (tds[0].innerHTML.substring(tds[0].innerHTML.length - 1) == 1) {

                        anel1 = tds[0].innerHTML;
                        cruzamentoAnel1 = tds[1].firstElementChild.value;
                        qtdEstagio1 = tds[2].firstElementChild.value;
                        if (anel1 == "Não há registros!") {
                            anel1 = "";
                        }

                        if (qtdEstagio1 == "" || parseInt(qtdEstagio1) < 2 || parseInt(qtdEstagio1) > 8) {

                            erro = true;
                            $("#txtQtdEstagios" + anel1 + "").addClass("is-invalid");
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("alertQtdEstagioVazio"),
                            })
                            return;
                        }
                        else {
                            $("#txtQtdEstagios" + anel1 + "").removeClass("is-invalid");
                        }
                        estagiosDesativarTMPE1 = tds[3].firstElementChild.value.toUpperCase();
                    }
                    if (tds[0].innerHTML.substring(tds[0].innerHTML.length - 1) == 2) {

                        anel2 = tds[0].innerHTML;
                        cruzamentoAnel2 = tds[1].firstElementChild.value;
                        qtdEstagio2 = tds[2].firstElementChild.value;

                        if (qtdEstagio2 == "" || parseInt(qtdEstagio2) < 2 || parseInt(qtdEstagio2) > 8) {

                            erro = true;
                            $("#txtQtdEstagios" + anel2 + "").addClass("is-invalid");
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("alertQtdEstagioVazio"),
                            })
                            return;
                        }
                        else {
                            $("#txtQtdEstagios" + anel2 + "").removeClass("is-invalid");
                        }
                        estagiosDesativarTMPE2 = tds[3].firstElementChild.value.toUpperCase();
                    }
                    if (tds[0].innerHTML.substring(tds[0].innerHTML.length - 1) == 3) {

                        anel3 = tds[0].innerHTML;
                        cruzamentoAnel3 = tds[1].firstElementChild.value;
                        qtdEstagio3 = tds[2].firstElementChild.value;

                        if (qtdEstagio3 == "" || parseInt(qtdEstagio3) < 2 || parseInt(qtdEstagio3) > 8) {

                            erro = true;
                            $("#txtQtdEstagios" + anel3 + "").addClass("is-invalid");
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("alertQtdEstagioVazio"),
                            })
                            return;
                        }
                        else {
                            $("#txtQtdEstagios" + anel3 + "").removeClass("is-invalid");
                        }
                        estagiosDesativarTMPE3 = tds[3].firstElementChild.value.toUpperCase();
                    }
                    if (tds[0].innerHTML.substring(tds[0].innerHTML.length - 1) == 4) {

                        anel4 = tds[0].innerHTML;
                        cruzamentoAnel4 = tds[1].firstElementChild.value;
                        qtdEstagio4 = tds[2].firstElementChild.value;

                        if (qtdEstagio4 == "" || parseInt(qtdEstagio4) < 2 || parseInt(qtdEstagio4) > 8) {

                            erro = true;
                            $("#txtQtdEstagios" + anel4 + "").addClass("is-invalid");
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("alertQtdEstagioVazio"),
                            })
                            return;
                        }
                        else {
                            $("#txtQtdEstagios" + anel4 + "").removeClass("is-invalid");
                        }
                        estagiosDesativarTMPE4 = tds[3].firstElementChild.value.toUpperCase();
                    }
                });

                //#endregion

                if (erro == true) {

                    $("#divLoading").css("display", "none");
                    return;
                }

                var controladorScnFormatado = "X" + $("#txtControladorScn").val() + "0";
                $.ajax({
                    type: 'POST',
                    url: 'Default.aspx/salvarAlteracoes',
                    dataType: 'json',
                    data: "{'controladorScn':'" + controladorScnFormatado + "', " +
                        " 'ipControlador':'" + $("#txtIpControlador").val() + "', " +
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

                //document.getElementById("txtControladorScn").disabled = false;
                //document.getElementById("btnAdicionarAneis").disabled = false;
            }
        }

        function removerAnel(status) {

            var row = status.parentNode.parentNode;
            row.parentNode.removeChild(row);

            arrayItensExcluidos.push(row.cells[0].innerText);

            var table = $("#tblScnAnel tbody");
            contador = table.find('tr').length;
            if (contador < 4) {

                document.getElementById("btnAdicionarAneis").disabled = false;
            }

            if (contador == 0) {

                var newRow = $("<tr>");
                var cols = "";
                cols += "<td colspan='9' style='padding: 0.75rem 2rem;'>Não há registros!</td>";

                newRow.append(cols);
                $("#tbScnAnel").append(newRow);

                if (document.getElementById("btnSalvar").innerHTML == "Salvar Alterações") {

                    document.getElementById("txtControladorScn").disabled = true;
                }
                else {

                    document.getElementById("txtControladorScn").disabled = false;
                    document.getElementById("txtIpControlador").disabled = false;
                }

                arrayItensExcluidos = [];
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
                                " data-cruzamentoAnel4='" + lst.cruzamentoAnel4 + "'> " +
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

        var arrayIncluirAneis = [];

        function editarControladorScoot(status) {

            $("#divPesquisa").css("display", "none");
            $("#divCadastro").css("display", "block");

            var filtrarControlador = $(status).data("scncontrolador");
            var controladorFiltrado = filtrarControlador.substring(1, filtrarControlador.length - 1);

            $("#txtControladorScn").val(controladorFiltrado);
            document.getElementById("txtControladorScn").disabled = true;
            $("#txtIpControlador").val($(status).data("ipcontrolador"));
            $("#txtQtdCaractereIdentControlador").val(status.dataset.qtdcaractereidentificacaocontrolador);
            $("#txtTempoAntesEnvioEstagio").val($(status).data("tempoenvioestagio"));
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
            $("#tblScnAnel").find("tbody").empty();

            if (anel1 != "") {

                if (anel1 == "Não há registros!") {
                    anel1 = "";
                }
                else {

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + anel1 + "</td>";
                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 60%;'><input type='text' id='txtCruzamentoAnel" + anel1 + "' class='form-control' value='" + cruzamentoAnel1 + "' /></td>";

                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='number' min='2' max='8' id='txtQtdEstagios" + anel1 + "' value='" + qtdEstagio1 + "' class='form-control' /></td>";
                    cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='text' id='txtDesativarTMPE" + anel1 + "' data-anel='" + anel1 + "' value='" + tmpe1 + "' style='text-transform:uppercase' onkeyup='validaDesativacaoTMPE(this)' class='form-control' /></td>";

                    cols += "<td class='form-group' style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' class='btn btn-danger btn-xs' " +
                        " style='cursor:pointer;' onclick='removerAnel(this)' data-scnControlador='" + anel1 + "'><i class='ft-trash-2'></i></button></td>";

                    newRow.append(cols);
                    $("#tblScnAnel").append(newRow);
                }
            }
            if (anel2 != "") {
                var newRow = $("<tr>");
                var cols = "";
                cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + anel2 + "</td>";

                cols += "<td style='border-collapse: collapse; padding: 5px; width: 60%;'><input type='text' id='txtCruzamentoAnel" + anel2 + "' class='form-control' value='" + cruzamentoAnel2 + "' /></td>";
                cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='number' min='2' max='8' id='txtQtdEstagios" + anel2 + "' value='" + qtdEstagio2 + "' class='form-control' /></td>";
                cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='text' id='txtDesativarTMPE" + anel2 + "' data-anel='" + anel2 + "' value='" + tmpe2 + "' style='text-transform:uppercase' onkeyup='validaDesativacaoTMPE(this)' class='form-control' /></td>";

                cols += "<td class='form-group' style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' class='btn btn-danger btn-xs' " +
                    " style='cursor:pointer;' onclick='removerAnel(this)' data-scnControlador='" + anel2 + "'><i class='ft-trash-2'></i></button></td>";

                newRow.append(cols);
                $("#tblScnAnel").append(newRow);
            }
            if (anel3 != "") {

                var newRow = $("<tr>");
                var cols = "";
                cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + anel3 + "</td>";

                cols += "<td style='border-collapse: collapse; padding: 5px; width: 60%;'><input type='text' id='txtCruzamentoAnel" + anel3 + "' class='form-control' value='" + cruzamentoAnel3 + "' /></td>";
                cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='number' min='2' max='8' id='txtQtdEstagios" + anel3 + "' value='" + qtdEstagio3 + "' class='form-control' /></td>";
                cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='text' id='txtDesativarTMPE" + anel3 + "' data-anel='" + anel3 + "' value='" + tmpe3 + "' style='text-transform:uppercase' onkeyup='validaDesativacaoTMPE(this)' class='form-control' /></td>";

                cols += "<td class='form-group' style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' class='btn btn-danger btn-xs' " +
                    " style='cursor:pointer;' onclick='removerAnel(this)' data-scnControlador='" + anel3 + "'><i class='ft-trash-2'></i></button></td>";

                newRow.append(cols);
                $("#tblScnAnel").append(newRow);
            }
            if (anel4 != "") {

                var newRow = $("<tr>");
                var cols = "";
                cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + anel4 + "</td>";

                cols += "<td style='border-collapse: collapse; padding: 5px; width: 60%;'><input type='text' id='txtCruzamentoAnel" + anel4 + "' class='form-control' value='" + cruzamentoAnel3 + "' /></td>";
                cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='number' min='2' max='8' id='txtQtdEstagios" + anel4 + "' value='" + qtdEstagio4 + "' class='form-control' /></td>";
                cols += "<td style='border-collapse: collapse; padding: 5px; width: 1px;'><input type='text' id='txtDesativarTMPE" + anel4 + "' data-anel='" + anel4 + "' value='" + tmpe4 + "' style='text-transform:uppercase' onkeyup='validaDesativacaoTMPE(this)' class='form-control' /></td>";

                cols += "<td class='form-group' style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' class='btn btn-danger btn-xs' " +
                    " style='cursor:pointer;' onclick='removerAnel(this)' data-scnControlador='" + anel4 + "'><i class='ft-trash-2'></i></button></td>";

                newRow.append(cols);
                $("#tblScnAnel").append(newRow);
            }

            document.getElementById("btnSalvar").innerHTML = "Salvar Alterações";

            //VALIDAÇÕES
            if (anel1 == "" && anel2 == "" && anel3 == "" && anel4 == "") {

                $("#tblScnAnel").find("tbody").empty();

                var newRow = $("<tr>");
                var cols = "";
                cols += "<td colspan='9' style='padding: 0.75rem 2rem;'>Não há registros!</td>";

                newRow.append(cols);
                $("#tbScnAnel").append(newRow);
                document.getElementById("btnAdicionarAneis").disabled = false;
                arrayIncluirAneis = [];
            }
            var table = $("#tblScnAnel tbody");
            if (table[0].rows.length == 4) {

                document.getElementById("btnAdicionarAneis").disabled = true;
                document.getElementById("txtControladorScn").disabled = true;
            }
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
