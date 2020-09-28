<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="link.aspx.cs" Inherits="GwCentral.Scoot.link" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
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

        .autocomplete-pesquisa-items {
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
            margin-left: 15px;
            margin-right: 15px;
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

        /*#region RESPONSIVE SIZES*/
        @media (max-width: 3044px) {
            .colFull {
                flex: 0 0 33.3% !important;
                max-width: 33.3% !important;
            }

            .proporcaoInput {
                max-width: 32% !important;
                flex: 32% !important;
            }

            .proporcaoDivBtn {
                text-align: right;
                max-width: 68% !important;
                flex: 80% !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoInputPesq {
                padding-right: 15px !important;
            }

            .colFull {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
                padding-right: 0 !important;
            }

            .proporcaoDivBtn {
                max-width: 100% !important;
                flex: 100% !important;
            }
        }
        /*#endregion*/

        /*#region BACKGROUND LINHA TABELA*/
        #tbLink tr:hover {
            background-color: #e3ebf338;
        }
        /*#endregion*/
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    Link
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hfQtdLacosPermitido" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfUsuarioLogado" ClientIDMode="Static" runat="server" />

    <div id="divStart">

        <%--PESQUISA--%>
        <div style="padding-bottom: 10px;">
            <label class="m-0">Junction:</label>
            <br />
            <div class="row espacamento" style="padding-left: 0; padding-right: 0;">
                <div class="col-6 col-md-4 proporcaoInput proporcaoInputPesq">
                    <div class="input-group">
                        <input type="text" class="form-control" id="txtPesqJunction" />
                        <div class="input-group-append">
                            <button class="btn btn-secondary">
                                <i class="ft-search" style="color: white;"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-md-4 proporcaoDivBtn">
                    <div class="proporcaoAddControlador">
                        <button type="button" class="btn btn-icon btn-secondary mr-1"
                            onclick="addNovoLink()"
                            style="margin-right: 0 !important;">
                            <i class="ft-plus-square"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <%--LIST REGISTERED LINKS--%>
        <div class="table-responsive">
            <table id="tblLinks" class="table table-bordered mb-0">
                <thead>
                    <tr>
                        <th>Junction</th>
                        <th>SCN Link</th>
                        <th>Link Type</th>
                        <th>Link Class</th>
                        <th>UTC Stage Greens</th>
                        <th>Stopline Link</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbLinks">
                    <tr>
                        <td colspan="8"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div id="divRegister" style="display: none;">

        <div class="row">
            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10 autocomplete">
                        <label class="mb-0" for="txtJunction">
                            Junction:<br />
                            <span style="color: rgb(146 146 146 / 47%);">(Cruzamento)</span>
                        </label>
                        <input id="txtJunction" type="text" class="form-control"
                            placeholder="Junction" autocomplete="off" />
                    </div>
                </div>
            </div>

            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="lblScnLink">
                            SCN Link: 
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Identificação da aproximação)</span>
                        </label>
                        <input type="text" class="form-control" id="lblScnLink"
                            readonly="readonly" value="NXXXX1A" />
                    </div>
                </div>
            </div>

            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="sleLinkType">
                            Link Type:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Tipo da aproximação)</span>
                        </label>
                        <select id="sleLinkType" class="form-control">
                            <option value="">─ SELECIONE ─</option>
                            <option value="entrada">Entrada</option>
                            <option value="saida">Saída</option>
                            <option value="normal">Normal</option>
                            <option value="filtro">Filtro</option>
                            <option value="isolado">Isolado</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="sleLinkClass">
                            Link Class:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Classe da aproximação)</span>
                        </label>
                        <select id="sleLinkClass" class="form-control">
                            <option value="">─ SELECIONE ─</option>
                            <option value="normal">Normal</option>
                            <option value="bicicleta">Bicicleta</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="txtUTCStageGreens">
                            UTC Stage Greens:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Estágios em verde)</span>
                        </label>
                        <input id="txtUTCStageGreens" type="text" class="form-control"
                            placeholder="UTC Stage Greens" />
                    </div>
                </div>
            </div>
            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" data-toggle="tooltip" data-placement="top" title="A aproximação tem laços de linha de parada - na linha de parada ou próximo (<20m).">
                            Stopline Link:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Linha de parada da aproximação)</span>
                        </label>
                        <div>
                            <input type="checkbox" class="switchery" data-color="success"
                                data-switchery="true" id="chkStoplineLink"
                                unchecked="true" style="display: none;" />
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="row">
            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="txtStoplineUplink" data-toggle="tooltip" data-placement="top" title="Para aproximação de linha de parada normal, a aproximação anterior pode ser especificada. -opcional.">
                            Stopline Uplink:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Linha de parada da aproximação anterior)</span>
                        </label>
                        <input id="txtStoplineUplink" type="text" class="form-control"
                            placeholder="Stopline Uplink" />
                    </div>
                </div>
            </div>
            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="txtUpstreamNode" data-toggle="tooltip" data-placement="top" title="Para aproximação normal, usa-se o cruzamento anterior.">
                            Upstream Node:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Cruzamento anterior)</span>
                        </label>
                        <input id="txtUpstreamNode" type="text" class="form-control"
                            placeholder="Upstream Node" />
                    </div>
                </div>
            </div>

            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="txtUpNodeThruStage" data-toggle="tooltip" data-placement="top" title="Para aproximação normal, este é o estágio do cruzamento anterior que permite o tráfego para esta aproximação.">
                            Up Node Thru Stage:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Estágio do cruzamento anterior)</span>
                        </label>
                        <input id="txtUpNodeThruStage" type="text" class="form-control"
                            placeholder="Up Node Thru Stage" />
                    </div>
                </div>
            </div>

        </div>

        <div class="row">
            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="txtDownNodeThruStage" data-toggle="tooltip" data-placement="top" title="O estágio do cruzamento posterior que deixa em verde esta aproximação. Pode ser omitido para aproximações de entrada ou de filtro.">
                            Down Node Thru Stage:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Estágio do cruzamento posterior)</span>
                        </label>
                        <input id="txtDownNodeThruStage" type="text" class="form-control"
                            placeholder="Down Node Thru Stage" />
                    </div>
                </div>
            </div>
            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="txtMainDownstreamLink" data-toggle="tooltip" data-placement="top" title="A aproximação que, se bloqueado, faria com que o fluxo de saída da aproximaçao atual cessasse - opcional.">
                            Main Downstream Link:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Cruzamento principal posterior)</span>
                        </label>
                        <input id="txtMainDownstreamLink" type="text" class="form-control"
                            placeholder="Main Downstream Link" />
                    </div>
                </div>
            </div>

            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="txtCongestionLink" data-toggle="tooltip" data-placement="top" title="opcional.">
                            Congestion Link:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Aproximação congestionada)</span>
                        </label>
                        <input id="txtCongestionLink" type="text" class="form-control"
                            placeholder="Up Node Thru Stage" />
                    </div>
                </div>
            </div>

        </div>

        <div class="row">
            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="txtBottleneckLink" data-toggle="tooltip" data-placement="top" title="opcional.">
                            Bottleneck Link:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Aproximação engarrafamento)</span>
                        </label>
                        <input id="txtBottleneckLink" type="text" class="form-control"
                            placeholder="Bottleneck Link" />
                    </div>
                </div>
            </div>
            <div class="col-md-6 colFull">
                <div class="form-group row">
                    <div class="col-md-10">
                        <label class="mb-0" for="txtBusEquipamentScn" data-toggle="tooltip" data-placement="top" title="O equipamento que pode fornecer uma indicação para ônibus detectados nesta aproximação. -opcional.">
                            Bus Equipament Scn:
                            <br />
                            <span style="color: rgb(146 146 146 / 47%);">(Identificação do detector de ônibus)</span>
                        </label>
                        <input id="txtBusEquipamentScn" type="text" class="form-control"
                            placeholder="Bus Equipament Scn" />
                    </div>
                </div>
            </div>

        </div>

        <button class="btn btn-success btn-min-width mr-1 mb-1" type="button"
            onclick="addLaco();" id="btnAddLacos"
            style="margin-top: 1rem; margin-right: 0 !important; margin-bottom: 8px !important;">
            <i class="ft-plus" style="color: white;"></i>
            <label style="padding-left: 5px; vertical-align: text-top; margin-bottom: 0; cursor: pointer;">
                <%= Resources.Resource.adicionar %> <%= Resources.Resource.laco %>
            </label>
        </button>

        <%--LISTA DE LAÇOS--%>
        <div class="table-responsive" style="margin-top: 2rem;">
            <table id="tblLacos" class="table table-bordered mb-0">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.laco %></th>
                        <th><%= Resources.Resource.tipo %></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbLacos">
                    <tr>
                        <td colspan="5"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="table-responsive">
            <div class="form-actions right"
                style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem;">
                <div style="float: right; margin-top: 1rem;">
                    <button type="button" class="btn btn-success" id="btnSalvar"
                        onclick="saveLink()">
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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>
        autocompleteJunction(document.getElementById("txtJunction"), false);
        autocompleteJunction(document.getElementById("txtPesqJunction"), true);
        autocompleteCongestionLink(document.getElementById("txtCongestionLink"));
        autocompleteBottleneckLink(document.getElementById("txtBottleneckLink"));

        $(function () {

            loadResourcesLocales();
            carregarLinks();
        });

        function addNovoLink() {

            $("#divStart").css("display", "none");
            $("#divRegister").css("display", "");
        }

        function carregarLinks() {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'link.aspx/carregarLinks',
                dataType: 'json',
                data: "{'junction':'" + $("#txtPesqJunction").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {
                        var i = 0;

                        $("#tbLinks").empty();

                        while (data.d[i]) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='padding-top: 14px;'>" + lst.junction + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst.scnlink + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst.linkType + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst.linkClass + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst.stageGreens + "</td>";

                            if (lst.stoplineLink == "True")
                                cols += "<td style='padding-top: 14px;'>Sim</td>";
                            else
                                cols += "<td style='padding-top: 14px;'>Não</td>";

                            cols += "<td style='padding: 5px; width:1px;'> " +
                                " <button class='btn btn-icon btn-info mr-1' " +
                                " style='font-size:medium; margin-right: 0 !important;' " +
                                " onclick='editLink(this)' data-id='" + lst.id + "' " +
                                " data-scnlink='" + lst.scnlink + "' " +
                                " data-linkType='" + lst.linkType + "' " +
                                " data-junction='" + lst.junction + "' " +
                                " data-linkClass='" + lst.linkClass + "' " +
                                " data-stageGreens='" + lst.stageGreens + "' " +
                                " data-stoplineLink='" + lst.stoplineLink + "' " +
                                " data-stoplineupLink='" + lst.stoplineUpLink + "' " +
                                " data-upstreamNode='" + lst.upstreamNode + "' " +
                                " data-upnodethrustage='" + lst.upNodeThruStage + "' " +
                                " data-downnodethrustage='" + lst.downNodeThruStage + "' " +
                                " data-maindownstream='" + lst.mainDownstream + "' " +
                                " data-congestionlink='" + lst.congestionLink + "' " +
                                " data-bottlenecklink='" + lst.BottleneckLink + "' " +
                                " data-busequipamentscn='" + lst.BusEquipamentScn + "'> " +
                                " <i class='ft-edit-3'></i></button></td>";

                            cols += "<td style='border-collapse: collapse; padding: 5px; width:1px;'> " +
                                " <button class='btn btn-danger btn-xs' style='font-size:medium; " +
                                " margin-right: 0!important;' onclick='deleteLink(this)' " +
                                " data-id='" + lst.id + "' " +
                                " data-junction='" + lst.junction + "' " +
                                " data-scnlink='" + lst.scnlink + "'> " +
                                " <i class='ft-trash-2'></i></button></td>";

                            newRow.append(cols);
                            $("#tbLinks").append(newRow);
                            i++;
                        }
                    }
                    else {

                        $("#tbLinks").empty();
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='8' style='padding: 0.75rem 2rem;'>Não há registros!</td>";

                        newRow.append(cols);
                        $("#tblLinks").append(newRow);
                    }

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {

                    $("#divLoading").css("display", "none");
                }
            });
        }

        function editLink(value) {

            $("#divLoading").css("display", "block");

            $("#divStart").css("display", "none");
            $("#divRegister").css("display", "block");

            $("#txtJunction").val(value.dataset.junction);
            $("#lblScnLink").val(value.dataset.scnlink);
            $("#lblScnLink").val(value.dataset.scnlink);
            $("#sleLinkType").val(value.dataset.linkType);
            $("#sleLinkClass").val(value.dataset.linkClass);
            $("#txtUTCStageGreens").val(value.dataset.stageGreens);

            if (value.dataset.stoplineLink) {

                $("#chkStoplineLink").click();
            }

            $("#txtStoplineUplink").val(value.dataset.stoplineUpLink);
            $("#txtUpstreamNode").val(value.dataset.upstreamNode);
            $("#txtUpNodeThruStage").val(value.dataset.upNodeThruStage);
            $("#txtDownNodeThruStage").val(value.dataset.downNodeThruStage);
            $("#txtMainDownstreamLink").val(value.dataset.mainDownstream);
            $("#txtCongestionLink").val(value.dataset.congestionLink);
            $("#txtBottleneckLink").val(value.dataset.BottleneckLink);
            $("#txtBusEquipamentScn").val(value.dataset.BusEquipamentScn);

            $("#divLoading").css("display", "none");
        }

        function deleteLink(value) {

            
        }

        //REGISTER
        function saveLink() {

            $("#divLoading").css("display", "block");

            //#region VALIDATION
            if ($("#txtJunction").val() == "") {

                $("#txtJunction").addClass("is-invalid");

                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                return;
            }
            else {
                $("#txtJunction").removeClass("is-invalid");
            }

            if ($("#sleLinkType").val() == "") {

                $("#sleLinkType").addClass("is-invalid");
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                return;
            }
            else {
                $("#sleLinkType").removeClass("is-invalid");
            }

            if ($("#sleLinkClass").val() == "") {

                $("#sleLinkClass").addClass("is-invalid");
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                return;
            }
            else {
                $("#sleLinkClass").removeClass("is-invalid");
            }

            if ($("#txtUTCStageGreens").val() == "") {

                $("#txtUTCStageGreens").addClass("is-invalid");
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                return;
            }
            else {
                $("#txtUTCStageGreens").removeClass("is-invalid");
            }
            //#endregion

            var junction1 = "", junction2 = "", outstation = "", node = "";
            junction1 = $("#txtJunction").val().substring(0, $("#txtJunction").val().length - 1);
            outstation = junction1.replace("J", "X") + "0";
            junction2 = $("#txtJunction").val().substring(0, $("#txtJunction").val().length);
            node = junction2.replace("J", "N");


            if (document.getElementById("btnSalvar").innerText == "Salvar") {

                $.ajax({
                    type: 'POST',
                    url: 'link.aspx/salvar',
                    async: false,
                    dataType: 'json',
                    data: "{'junction':'" + $("#txtJunction").val() + "', " +
                        " 'outstation':'" + outstation + "', " +
                        " 'node':'" + node + "', " +
                        " 'scn_link':'" + $("#lblScnLink").val() + "', " +
                        " 'link_type':'" + $("#sleLinkType").val() + "', " +
                        " 'link_class':'" + $("#sleLinkClass").val() + "', " +
                        " 'utc_stage_greens':'" + $("#txtUTCStageGreens").val() + "', " +
                        " 'stopline_link':'" + $("#chkStoplineLink")[0].checked + "', " +
                        " 'stopline_uplink':'" + $("#txtStoplineUplink").val() + "', " +
                        " 'upstream_node':'" + $("#txtUpstreamNode").val() + "', " +
                        " 'up_node_thru_stage':'" + $("#txtUpNodeThruStage").val() + "', " +
                        " 'down_node_thru_stage':'" + $("#txtDownNodeThruStage").val() + "', " +
                        " 'main_downstream_link':'" + $("#txtMainDownstreamLink").val() + "', " +
                        " 'congestion_link':'" + $("#txtCongestionLink").val() + "', " +
                        " 'bottleneck_link':'" + $("#txtBottleneckLink").val() + "', " +
                        " 'bus_equipament_scn':'" + $("#txtBusEquipamentScn").val() + "', " +
                        " 'connected_user':'" + $("#hfUsuarioLogado").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        if (data.d != "success") {

                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("controladorCadastrado"),
                            })

                            $("#divLoading").css("display", "none");
                            return;
                        }

                        Swal.fire({
                            type: 'success',
                            title: getResourceItem("salvoTipoAlert"),
                            text: getResourceItem("salvoComSucesso"),
                        });

                        $("#divRegister").css("display", "none");
                        $("#divStart").css("display", "block");
                        /*carregarControladoresCad();*/ //RECARREGA A TABELA DA PÁGINA INICIAL
                        $("#divLoading").css("display", "none");
                    },
                    error: function (data) {
                        $("#divLoading").css("display", "none");
                    }
                });
            }
            else {

                //$.ajax({
                //    type: 'POST',
                //    url: 'Default.aspx/salvarAlteracoes',
                //    dataType: 'json',
                //    data: "{'controladorScn':'" + controladorScnFormatado + "', " +
                //        " 'ipControlador':'" + $("#txtIpControlador").val() + "', " +
                //        " 'modelo':'" + $("#txtModelo").val() + "', " +
                //        " 'cruzamento':'" + $("#txtCruzamento").val() + "', " +
                //        " 'lat':'" + $("#hfLatitude").val() + "', " +
                //        " 'usuarioLogado':'" + $("#hfUsuarioLogado").val() + "', " +
                //        " 'lon':'" + $("#hfLongitude").val() + "', " +
                //        " 'anel1':'" + anel1 + "', 'anel2':'" + anel2 + "', " +
                //        " 'anel3':'" + anel3 + "','anel4':'" + anel4 + "', " +
                //        " 'qtdEstagio1':'" + qtdEstagio1 + "', " +
                //        " 'qtdEstagio2':'" + qtdEstagio2 + "', " +
                //        " 'qtdEstagio3':'" + qtdEstagio3 + "', " +
                //        " 'qtdEstagio4':'" + qtdEstagio4 + "', " +
                //        " 'tmpe1':'" + estagiosDesativarTMPE1 + "', " +
                //        " 'tmpe2':'" + estagiosDesativarTMPE2 + "', " +
                //        " 'tmpe3':'" + estagiosDesativarTMPE3 + "', " +
                //        " 'tmpe4':'" + estagiosDesativarTMPE4 + "', " +
                //        " 'id':'" + $("#hfIdControladorScoot").val() + "', " +
                //        " 'cruzamentoAnel1':'" + cruzamentoAnel1 + "', " +
                //        " 'cruzamentoAnel2':'" + cruzamentoAnel2 + "', " +
                //        " 'cruzamentoAnel3':'" + cruzamentoAnel3 + "', " +
                //        " 'cruzamentoAnel4':'" + cruzamentoAnel4 + "', " +
                //        " 'tempoEnvioEstagio':'" + $("#txtTempoAntesEnvioEstagio").val() + "'}",
                //    contentType: "application/json; charset=utf-8",
                //    success: function (data) {

                //        if (data.d != "sucesso") {

                //            Swal.fire({

                //                type: 'error',
                //                title: getResourceItem("erroTipoAlert"),
                //                text: (data.d),
                //            })

                //            $("#divLoading").css("display", "none");
                //            return;
                //        }

                //        //#region Salva dados aneis
                //        var qtdAnel = parseInt($("#hfQtdAneis").val());
                //        for (var i = 1; i <= qtdAnel; i++) {
                //            $.ajax({
                //                type: 'POST',
                //                url: 'Default.aspx/salvarAlteracoesAnel',
                //                dataType: 'json',
                //                data: "{'junction':'" + $("#lblScnAnel" + i)[0].innerHTML + "', " + " 'qtdFases':'" + $("#txtQtdFases" + i).val() + "','SlaveController':'"
                //                    + $("#chkSlaveController" + i)[0].checked + "','DelayToIntergreen':'" + $("#txtDelayToIntergreen" + i).val() + "','Signal_Stuck_Inhibit':'"
                //                    + $("#chkSignalStuckInhibit" + i)[0].checked + "','MinGreenCyclickCheckSequence':'" + $("#txtMinGreenCyclicCheckSequence" + i).val() +
                //                    "','CyclicCheckSequence':'" + $("#txtCyclicCheckSequence" + i).val() + "','NonCyclicCheckSequence':'" + $("#txtNonCyclicCheckSequence" + i).val() +
                //                    "','SL_BitMeaning':'" + $("#chkSLBitMeaning" + i)[0].checked + "','SmoothPlanChange':'" + $("#chkSmoothPlanUpdates" + i)[0].checked +
                //                    "','RoadGreens_Main':'" + $("#txtRoadGreensMain" + i).val() + "','RoadGreens_Side':'" + $("#txtRoadGreensSide" + i).val() +
                //                    "','ScnRegion':'" + $("#sleRegiao").val() + "','ScnNode':'" + $("#lblScnAnel" + i)[0].innerHTML.replace("J", "N") +
                //                    "','MaxCycleTime':'" + $("#txtMaxCycleTime" + i).val() + "','NamedStage':'" + $("#txtNamedStage" + i).val() + "','CyclicFixedTime':'"
                //                    + $("#txtCyclicFixedTime" + i).val() + "','DoubleCycling':'" + $("#chkDoubleCycling" + i)[0].checked + "','ForceSingleOrDoubleCycling':'"
                //                    + $("#chkForceSingleOrDoubleCycling" + i)[0].checked + "','FirstRemovableStage':'" + $("#txtFirstRemovedStage" + i).val() +
                //                    "','SecondRemovableStage':'" + $("#txtSecondRemovedStage" + i).val() + "','FirstStageRemoved_Plano1':'" + $("#chkFirstRemovableStagePlan1Anel" + i)[0].checked +
                //                    "','FirstStageRemoved_Plano2':'" + $("#chkFirstRemovableStagePlan2Anel" + i)[0].checked + "','FirstStageRemoved_Plano3':'" + $("#chkFirstRemovableStagePlan3Anel" + i)[0].checked +
                //                    "','FirstStageRemoved_Plano4':'" + $("#chkFirstRemovableStagePlan4Anel" + i)[0].checked + "','FirstStageRemoved_Plano5':'" + $("#chkFirstRemovableStagePlan5Anel" + i)[0].checked +
                //                    "','FirstStageRemoved_Plano6':'" + $("#chkFirstRemovableStagePlan6Anel" + i)[0].checked + "','SecondStageRemoved_Plano1':'" + $("#chkSecondRemovableStagePlan1Anel" + i)[0].checked +
                //                    "','SecondStageRemoved_Plano2':'" + $("#chkSecondRemovableStagePlan2Anel" + i)[0].checked + "','SecondStageRemoved_Plano3':'" + $("#chkSecondRemovableStagePlan3Anel" + i)[0].checked +
                //                    "','SecondStageRemoved_Plano4':'" + $("#chkSecondRemovableStagePlan4Anel" + i)[0].checked + "','SecondStageRemoved_Plano5':'" + $("#chkSecondRemovableStagePlan5Anel" + i)[0].checked +
                //                    "','SecondStageRemoved_Plano6':'" + $("#chkSecondRemovableStagePlan6Anel" + i)[0].checked + "'}",
                //                contentType: "application/json; charset=utf-8",
                //                success: function (data) {
                //                },
                //                error: function (data) {
                //                }
                //            });
                //        }
                //        //#endregion

                //        Swal.fire({
                //            type: 'success',
                //            title: getResourceItem("salvoTipoAlert"),
                //            text: getResourceItem("salvoComSucesso"),
                //        });

                //        $("#divCadastro").css("display", "none");
                //        $("#divPesquisa").css("display", "block");
                //        carregarControladoresCad();
                //        $("#divLoading").css("display", "none");
                //    },
                //    error: function (data) {
                //        $("#divLoading").css("display", "none");
                //    }
                //});

                //document.getElementById("txtControladorScn").disabled = false;
                //document.getElementById("btnAdicionarAneis").disabled = false;
            }
        }
        var qtdLacosAdd = 0;
        function addLaco() {
            if ($("#txtJunction").val() == "") {

                $("#txtJunction").addClass("is-invalid");

                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                return;
            }
            else {
                $("#txtJunction").removeClass("is-invalid");
            }
            var qtdLacosPermitido = parseInt($("#hfQtdLacosPermitido").val());

            if (qtdLacosAdd == 0) {
                $("#tbLacos").empty();
            }

            qtdLacosAdd++;

            if (qtdLacosAdd == qtdLacosPermitido) {
                $("#btnAddLacos").css("display", "none");
            }

            var newRow = $("<tr>");
            var cols = "", laco = "";
            cols += "<td style='width: 40px;padding-top:18px'>" + $("#lblScnLink").val() + qtdLacosAdd + "</td>";
            cols += "<td style='padding-top: 14px;'><select class='form-control'><option value=''>Selecione</option><option value='Saturacao'>Saturação</option><option value='Linha de Parada'>Linha de Parada</option></select></td>";

            cols += "<td style='border-collapse: collapse; padding: 5px; width:1px; padding-top:10px'><button type='button' class='btn btn-danger btn-xs' style='cursor:pointer; " +
                " font-size:medium; margin-right: 0 !important;' onclick='excluirControladorScoot(this)' ><i class='ft-trash-2'></i></button></td>";

            newRow.append(cols);
            $("#tbLacos").append(newRow);
        }
        function closeRegister() {


        }
        //#region AUTOCOMPLETE
        function autocompleteJunction(inp, pesq) {

            /*the autocomplete function takes two arguments,
            the text field element and an array of possible autocompleted values:*/
            /*a função de preenchimento automático leva dois argumentos, o elemento do
             campo de texto e uma matriz de possíveis valores de preenchimento automático*/
            var currentFocus;
            /*execute a function when someone writes in the text field:*/
            /*executa uma função quando alguém escreve no campo de texto*/
            inp.addEventListener("input", function (e) {

                var a, b, i, val = this.value;
                /*close any already open lists of autocompleted values*/
                /*feche todas as listas já abertas de valores preenchidos automaticamente*/
                closeAllLists();
                if (!val) { return false; }
                currentFocus = -1;
                /*create a DIV element that will contain the items (values):*/
                /*crie um elemento DIV que conterá os itens (valores):*/
                a = document.createElement("DIV");
                a.setAttribute("id", this.id + "autocomplete-list");
                a.setAttribute("class", "autocomplete-items");
                /*append the DIV element as a child of the autocomplete container:*/
                /*anexar o elemento DIV como filho do contêiner de preenchimento automático:*/
                this.parentNode.appendChild(a);

                $.ajax({
                    type: 'POST',
                    url: 'link.aspx/loadJunction',
                    dataType: 'json',
                    data: "{}",
                    //async: false,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        if (data.d != "") {

                            var i = 0;
                            while (data.d[i]) {

                                var arr = data.d;

                                /*verifique se o item começa com as mesmas letras do valor do campo de texto:*/
                                if (arr[i].junction.substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                                    /*crie um elemento DIV para cada elemento correspondente:*/
                                    b = document.createElement("DIV");
                                    /*faça as letras correspondentes em negrito:*/
                                    b.innerHTML = "<strong>" + arr[i].junction.substr(0, val.length) + "</strong>";
                                    b.innerHTML += arr[i].junction.substr(val.length);
                                    /*insira um campo de entrada que irá manter o valor do item da matriz atual:*/

                                    /*executa uma função quando alguém clica no valor do item (elemento DIV):*/
                                    b.addEventListener("click", function (e) {
                                        /*insira o valor para o campo de texto de preenchimento automático:*/
                                        if (pesq) {

                                        }
                                        else {
                                            $("#txtJunction").val(this.innerText);

                                            $.ajax({
                                                type: 'POST',
                                                url: 'link.aspx/getProximaAproximacao',
                                                dataType: 'json',
                                                data: "{'junction':'" + $("#txtJunction").val() + "'}",
                                                contentType: "application/json; charset=utf-8",
                                                success: function (data) {
                                                    $("#lblScnLink").val("");
                                                    if (data.d == "") {
                                                        Swal.fire({
                                                            type: 'error',
                                                            title: getResourceItem("erroTipoAlert"),
                                                            text: getResourceItem("controladorCadastrado"),
                                                        });
                                                        return;
                                                    }
                                                    else {
                                                        $("#lblScnLink").val($("#txtJunction").val().replace("J", "N") + data.d[0].Text);
                                                        $("#hfQtdLacosPermitido").val(16 - parseInt(data.d[0].Value));
                                                    }
                                                },
                                                error: function (data) {
                                                }
                                            });
                                        }
                                        /*feche a lista de valores autocompletados 
                                        (ou qualquer outra lista aberta de valores autocompletados*/
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
            /*executar uma função pressiona uma tecla no teclado:*/
            inp.addEventListener("keydown", function (e) {
                var x = document.getElementById(this.id + "autocomplete-list");
                if (x) x = x.getElementsByTagName("div");
                if (e.keyCode == 40) {
                    /*If the arrow DOWN key is pressed,
                    increase the currentFocus variable:*/
                    /*Se a tecla de seta para BAIXO for pressionada,
                    aumente a variável currentFocus*/
                    currentFocus++;
                    /*and and make the current item more visible:*/
                    /*o e torna o item atual mais visível:*/
                    addActive(x);
                } else if (e.keyCode == 38) { //up
                    /*If the arrow UP key is pressed,
                    decrease the currentFocus variable:*/
                    /*Se a tecla de seta para CIMA for pressionada,
                    diminui a variável currentFocus*/
                    currentFocus--;
                    /*and and make the current item more visible:*/
                    /*o e torna o item atual mais visível:*/
                    addActive(x);
                } else if (e.keyCode == 13) {
                    /*If the ENTER key is pressed, prevent the form from being submitted*/
                    /*Se a tecla ENTER for pressionada, evita que o formulário seja enviado*/
                    e.preventDefault();
                    if (currentFocus > -1) {
                        /*and simulate a click on the "active" item:*/
                        /*e simular um clique no item "ativo":*/
                        if (x) x[currentFocus].click();
                    }
                }
            });

            function addActive(x) {
                /*a function to classify an item as "active":*/
                /*uma função para classificar um item como "ativo":*/
                if (!x) return false;
                /*start by removing the "active" class on all items:*/
                /*comece removendo a classe "ativa" em todos os itens:*/
                removeActive(x);
                if (currentFocus >= x.length) currentFocus = 0;
                if (currentFocus < 0) currentFocus = (x.length - 1);
                /*add class "autocomplete-active":*/
                /*adicionar classe "autocomplete-active":*/
                x[currentFocus].classList.add("autocomplete-active");
            }

            function removeActive(x) {
                /*a function to remove the "active" class from all autocomplete items:*/
                /*uma função para remover a classe "ativa" de todos os itens de preenchimento automático:*/
                for (var i = 0; i < x.length; i++) {
                    x[i].classList.remove("autocomplete-active");
                }
            }

            function closeAllLists(elmnt) {
                /*close all autocomplete lists in the document,
                except the one passed as an argument:*/
                /*feche todas as listas de preenchimento automático no documento,
                exceto aquele passado como um argumento */
                var x = document.getElementsByClassName("autocomplete-items");
                for (var i = 0; i < x.length; i++) {
                    if (elmnt != x[i] && elmnt != inp) {
                        x[i].parentNode.removeChild(x[i]);
                    }
                }
            }

            /*execute a function when someone clicks in the document:*/
            /*executa uma função quando alguém clica no documento:*/
            document.addEventListener("click", function (e) {
                closeAllLists(e.target);
            });
        }

        function autocompleteCongestionLink(inp) {

            /*the autocomplete function takes two arguments,
            the text field element and an array of possible autocompleted values:*/
            /*a função de preenchimento automático leva dois argumentos, o elemento do
             campo de texto e uma matriz de possíveis valores de preenchimento automático*/
            var currentFocus;
            /*execute a function when someone writes in the text field:*/
            /*executa uma função quando alguém escreve no campo de texto*/
            inp.addEventListener("input", function (e) {

                var a, b, i, val = this.value;
                /*close any already open lists of autocompleted values*/
                /*feche todas as listas já abertas de valores preenchidos automaticamente*/
                closeAllLists();
                if (!val) { return false; }
                currentFocus = -1;
                /*create a DIV element that will contain the items (values):*/
                /*crie um elemento DIV que conterá os itens (valores):*/
                a = document.createElement("DIV");
                a.setAttribute("id", this.id + "autocomplete-list");
                a.setAttribute("class", "autocomplete-items");
                /*append the DIV element as a child of the autocomplete container:*/
                /*anexar o elemento DIV como filho do contêiner de preenchimento automático:*/
                this.parentNode.appendChild(a);

                $.ajax({
                    type: 'POST',
                    url: 'link.aspx/loadJunction',
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
                                /*verifique se o item começa com as mesmas letras do valor do campo de texto:*/
                                if (arr[i].junction.substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                                    /*create a DIV element for each matching element:*/
                                    /*crie um elemento DIV para cada elemento correspondente:*/
                                    b = document.createElement("DIV");
                                    /*make the matching letters bold:*/
                                    /*faça as letras correspondentes em negrito:*/
                                    b.innerHTML = "<strong>" + arr[i].junction.substr(0, val.length) + "</strong>";
                                    b.innerHTML += arr[i].junction.substr(val.length);
                                    /*insert a input field that will hold the current array item's value:*/
                                    /*insira um campo de entrada que irá manter o valor do item da matriz atual:*/
                                    b.innerHTML += "<input type='hidden' value='" + arr[i].junction + "'>";
                                    /*execute a function when someone clicks on the item value (DIV element):*/
                                    /*executa uma função quando alguém clica no valor do item (elemento DIV):*/
                                    b.addEventListener("click", function (e) {
                                        /*insert the value for the autocomplete text field:*/
                                        /*insira o valor para o campo de texto de preenchimento automático:*/
                                        inp.value = this.getElementsByTagName("input")[0].value;
                                        /*close the list of autocompleted values,
                                        (or any other open lists of autocompleted values:*/
                                        /*feche a lista de valores autocompletados 
                                        (ou qualquer outra lista aberta de valores autocompletados*/
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
            /*executar uma função pressiona uma tecla no teclado:*/
            inp.addEventListener("keydown", function (e) {
                var x = document.getElementById(this.id + "autocomplete-list");
                if (x) x = x.getElementsByTagName("div");
                if (e.keyCode == 40) {
                    /*If the arrow DOWN key is pressed,
                    increase the currentFocus variable:*/
                    /*Se a tecla de seta para BAIXO for pressionada,
                    aumente a variável currentFocus*/
                    currentFocus++;
                    /*and and make the current item more visible:*/
                    /*o e torna o item atual mais visível:*/
                    addActive(x);
                } else if (e.keyCode == 38) { //up
                    /*If the arrow UP key is pressed,
                    decrease the currentFocus variable:*/
                    /*Se a tecla de seta para CIMA for pressionada,
                    diminui a variável currentFocus*/
                    currentFocus--;
                    /*and and make the current item more visible:*/
                    /*o e torna o item atual mais visível:*/
                    addActive(x);
                } else if (e.keyCode == 13) {
                    /*If the ENTER key is pressed, prevent the form from being submitted*/
                    /*Se a tecla ENTER for pressionada, evita que o formulário seja enviado*/
                    e.preventDefault();
                    if (currentFocus > -1) {
                        /*and simulate a click on the "active" item:*/
                        /*e simular um clique no item "ativo":*/
                        if (x) x[currentFocus].click();
                    }
                }
            });

            function addActive(x) {
                /*a function to classify an item as "active":*/
                /*uma função para classificar um item como "ativo":*/
                if (!x) return false;
                /*start by removing the "active" class on all items:*/
                /*comece removendo a classe "ativa" em todos os itens:*/
                removeActive(x);
                if (currentFocus >= x.length) currentFocus = 0;
                if (currentFocus < 0) currentFocus = (x.length - 1);
                /*add class "autocomplete-active":*/
                /*adicionar classe "autocomplete-active":*/
                x[currentFocus].classList.add("autocomplete-active");
            }

            function removeActive(x) {
                /*a function to remove the "active" class from all autocomplete items:*/
                /*uma função para remover a classe "ativa" de todos os itens de preenchimento automático:*/
                for (var i = 0; i < x.length; i++) {
                    x[i].classList.remove("autocomplete-active");
                }
            }

            function closeAllLists(elmnt) {
                /*close all autocomplete lists in the document,
                except the one passed as an argument:*/
                /*feche todas as listas de preenchimento automático no documento,
                exceto aquele passado como um argumento */
                var x = document.getElementsByClassName("autocomplete-items");
                for (var i = 0; i < x.length; i++) {
                    if (elmnt != x[i] && elmnt != inp) {
                        x[i].parentNode.removeChild(x[i]);
                    }
                }
            }

            /*execute a function when someone clicks in the document:*/
            /*executa uma função quando alguém clica no documento:*/
            document.addEventListener("click", function (e) {
                closeAllLists(e.target);
            });
        }

        function autocompleteBottleneckLink(inp) {

            /*the autocomplete function takes two arguments,
            the text field element and an array of possible autocompleted values:*/
            /*a função de preenchimento automático leva dois argumentos, o elemento do
             campo de texto e uma matriz de possíveis valores de preenchimento automático*/
            var currentFocus;
            /*execute a function when someone writes in the text field:*/
            /*executa uma função quando alguém escreve no campo de texto*/
            inp.addEventListener("input", function (e) {

                var a, b, i, val = this.value;
                /*close any already open lists of autocompleted values*/
                /*feche todas as listas já abertas de valores preenchidos automaticamente*/
                closeAllLists();
                if (!val) { return false; }
                currentFocus = -1;
                /*create a DIV element that will contain the items (values):*/
                /*crie um elemento DIV que conterá os itens (valores):*/
                a = document.createElement("DIV");
                a.setAttribute("id", this.id + "autocomplete-list");
                a.setAttribute("class", "autocomplete-items");
                /*append the DIV element as a child of the autocomplete container:*/
                /*anexar o elemento DIV como filho do contêiner de preenchimento automático:*/
                this.parentNode.appendChild(a);

                $.ajax({
                    type: 'POST',
                    url: 'link.aspx/loadJunction',
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
                                /*verifique se o item começa com as mesmas letras do valor do campo de texto:*/
                                if (arr[i].junction.substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                                    /*create a DIV element for each matching element:*/
                                    /*crie um elemento DIV para cada elemento correspondente:*/
                                    b = document.createElement("DIV");
                                    /*make the matching letters bold:*/
                                    /*faça as letras correspondentes em negrito:*/
                                    b.innerHTML = "<strong>" + arr[i].junction.substr(0, val.length) + "</strong>";
                                    b.innerHTML += arr[i].junction.substr(val.length);
                                    /*insert a input field that will hold the current array item's value:*/
                                    /*insira um campo de entrada que irá manter o valor do item da matriz atual:*/
                                    b.innerHTML += "<input type='hidden' value='" + arr[i].junction + "'>";
                                    /*execute a function when someone clicks on the item value (DIV element):*/
                                    /*executa uma função quando alguém clica no valor do item (elemento DIV):*/
                                    b.addEventListener("click", function (e) {
                                        /*insert the value for the autocomplete text field:*/
                                        /*insira o valor para o campo de texto de preenchimento automático:*/
                                        inp.value = this.getElementsByTagName("input")[0].value;
                                        /*close the list of autocompleted values,
                                        (or any other open lists of autocompleted values:*/
                                        /*feche a lista de valores autocompletados 
                                        (ou qualquer outra lista aberta de valores autocompletados*/
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
            /*executar uma função pressiona uma tecla no teclado:*/
            inp.addEventListener("keydown", function (e) {
                var x = document.getElementById(this.id + "autocomplete-list");
                if (x) x = x.getElementsByTagName("div");
                if (e.keyCode == 40) {
                    /*If the arrow DOWN key is pressed,
                    increase the currentFocus variable:*/
                    /*Se a tecla de seta para BAIXO for pressionada,
                    aumente a variável currentFocus*/
                    currentFocus++;
                    /*and and make the current item more visible:*/
                    /*o e torna o item atual mais visível:*/
                    addActive(x);
                } else if (e.keyCode == 38) { //up
                    /*If the arrow UP key is pressed,
                    decrease the currentFocus variable:*/
                    /*Se a tecla de seta para CIMA for pressionada,
                    diminui a variável currentFocus*/
                    currentFocus--;
                    /*and and make the current item more visible:*/
                    /*o e torna o item atual mais visível:*/
                    addActive(x);
                } else if (e.keyCode == 13) {
                    /*If the ENTER key is pressed, prevent the form from being submitted*/
                    /*Se a tecla ENTER for pressionada, evita que o formulário seja enviado*/
                    e.preventDefault();
                    if (currentFocus > -1) {
                        /*and simulate a click on the "active" item:*/
                        /*e simular um clique no item "ativo":*/
                        if (x) x[currentFocus].click();
                    }
                }
            });

            function addActive(x) {
                /*a function to classify an item as "active":*/
                /*uma função para classificar um item como "ativo":*/
                if (!x) return false;
                /*start by removing the "active" class on all items:*/
                /*comece removendo a classe "ativa" em todos os itens:*/
                removeActive(x);
                if (currentFocus >= x.length) currentFocus = 0;
                if (currentFocus < 0) currentFocus = (x.length - 1);
                /*add class "autocomplete-active":*/
                /*adicionar classe "autocomplete-active":*/
                x[currentFocus].classList.add("autocomplete-active");
            }

            function removeActive(x) {
                /*a function to remove the "active" class from all autocomplete items:*/
                /*uma função para remover a classe "ativa" de todos os itens de preenchimento automático:*/
                for (var i = 0; i < x.length; i++) {
                    x[i].classList.remove("autocomplete-active");
                }
            }

            function closeAllLists(elmnt) {
                /*close all autocomplete lists in the document,
                except the one passed as an argument:*/
                /*feche todas as listas de preenchimento automático no documento,
                exceto aquele passado como um argumento */
                var x = document.getElementsByClassName("autocomplete-items");
                for (var i = 0; i < x.length; i++) {
                    if (elmnt != x[i] && elmnt != inp) {
                        x[i].parentNode.removeChild(x[i]);
                    }
                }
            }

            /*execute a function when someone clicks in the document:*/
            /*executa uma função quando alguém clica no documento:*/
            document.addEventListener("click", function (e) {
                closeAllLists(e.target);
            });
        }
        //#endregion

        //#region SCRIPT TRANSLATION ----------
        var globalResources;

        function loadResourcesLocales() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: 'link.aspx/requestResource',
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
        //#endregion
    </script>
</asp:Content>
