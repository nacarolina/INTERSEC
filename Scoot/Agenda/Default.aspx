<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Scoot.Agenda.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /*CHECKBOX*/
        input[type=checkbox] {
            display: block;
            margin: 0.2em;
            cursor: pointer;
            padding: 0.2em;
        }

        input[type=checkbox] {
            opacity: 0;
            width: 20px;
            height: 20px;
            position: absolute;
        }

            input[type=checkbox] + label:before {
                content: "\2714";
                border: 0.1em solid #464953;
                border-radius: 0.2em;
                display: inline-block;
                width: 20px;
                height: 20px;
                padding-left: 0.2em;
                padding-bottom: 0.5em;
                margin-right: 0.2em;
                vertical-align: bottom;
                color: transparent;
                transition: .2s;
            }


            input[type=checkbox]:checked + label:before {
                background-color: #464953;
                border-color: #464953;
                color: #fff;
            }

            input[type=checkbox]:disabled + label:before {
                transform: scale(1);
                border-color: #aaa;
            }

            input[type=checkbox]:checked:disabled + label:before {
                transform: scale(1);
                background-color: #bfb;
                border-color: #bfb;
            }

        /*SELECT PREFEITURA DESKTOP*/
        @media (max-width: 3044px) {
            .proporcaoInput {
                max-width: 30% !important;
                flex: 30% !important;
            }

            .pesquisa {
                width: 48%;
            }
        }

        #tbPlanos tr:hover {
            background-color: #e3ebf338;
        }

        #tbAgendaControlador tr:hover {
            background-color: #e3ebf338;
        }

        @media (max-width: 3044px) {

            .proporcaoAddControlador {
                margin-top: 20px;
                text-align: right;
            }

            .proporcaoSwit {
                float: right;
            }

            .proporcaoSwitcheryAgruparDias {
                max-width: 100% !important;
                flex: 37% !important;
            }

            .ds {
                max-width: 16% !important;
            }

            .horarioEntrada {
                max-width: 14% !important;
            }

            .botoes {
                flex: 0 0 80% !important;
                max-width: 80% !important;
            }
        }

        @media (max-width: 1023px) {

            .botoes {
                flex: 0 0 80% !important;
                max-width: 80% !important;
            }

            .horarioEntrada {
                max-width: 70% !important;
            }

            .ds {
                max-width: 70% !important;
            }

            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
            }

            .pesquisa {
                width: 100%;
            }

            .sle1 {
                padding-right: 0 !important;
            }

            .sle2 {
                padding-right: 0 !important;
            }

            .proporcaoAddControlador {
                margin-bottom: 0px;
                float: right;
            }

            .proporcaoSwitcheryAgruparDias {
                min-width: fit-content;
                max-width: 30% !important;
                flex: 0% !important;
            }

            .proporcaoDivBtn {
                max-width: 100% !important;
                flex: 100% !important;
            }
        }

        /*AJUSTA A TBL DIAS SEMANA QUANDO A TELA É REDUZIDA*/
        @media (max-width: 3044px) {
            .proporcao {
                display: flex;
            }
        }

        @media (max-width: 1440px) {
            .proporcao {
                display: table;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.agenda %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfUser" ClientIDMode="Static" runat="server" />

    <div id="divPesquisa" style="display: block;">

        <div class="row" style="padding-right: 15px; padding-left: 15px; margin-bottom: 15px">
            <div class="col-md-6 sle1" style="padding-left: 0; max-width: 50%">
                <%= Resources.Resource.controlador %>:
            <select class="form-control" style="width: 25rem;" id="sleControladorPesq" onchange="carregarDiasAgenda()"></select>
            </div>
            <div class="col-md-6 proporcaoAddControlador">
                <button type="button" id="btnNovo" class="btn btn-icon btn-secondary mr-1" onclick="adicionarNovaAgenda()" style="margin-right: 0 !important;"
                    <%--data-toggle="tooltip" data-placement="left" title="<%= Resources.Resource.adicionar %> "--%>>
                    <%--<i class="ft-plus-square"></i>--%>
                    <%= Resources.Resource.novaAgenda %>
                </button>
            </div>



        </div>

        <div id="dvCadastro" class="row" style="padding-right: 15px; padding-left: 15px; margin-bottom: 15px; display: none;">

            <div class="col-6 col-md-4" style="padding-left: 0; margin-bottom: 15px;">
                <%= Resources.Resource.plano %>:
            <select class="form-control" style="" id="slePlanos"></select>
            </div>

            <%--<div class="col-6 col-md-4 ds" style="padding-left: 0;">
                <%= Resources.Resource.dias %>:
            <select class="form-control" style="" id="sleDiaSemana" onchange="">
                <option value="">─ SELECIONE ─</option>
                <option value="Domingo">Domingo</option>
                <option value="Segunda">Segunda</option>
                <option value="Terça">Terça</option>
                <option value="Quarta">Quarta</option>
                <option value="Quinta">Quinta</option>
                <option value="Sexta">Sexta</option>
                <option value="Sábado">Sábado</option>
            </select>
            </div>--%>

            <div class="col-6 col-md-4 horarioEntrada" style="padding-left: 0; padding-right: 0;">
                <%= Resources.Resource.horarioEntrada %>:
            <input class="form-control" type="time" id="txtHorarioEntrada" onblur='validaHora(this)' onkeypress='Hora(event,this)' />
            </div>

            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                <label id="tituloDiasSemana" style="margin-bottom: 0px;"><%= Resources.Resource.dias %>/<%= Resources.Resource.semana %>:</label>
                <table id="tblDiasSemana" class="table table-bordered" style="width: 100%">
                    <tr>
                        <td style="width: 50%; padding-left: 11px; padding-right: inherit;">
                            <div class="proporcao">
                                <div>
                                    <input type="checkbox" id="chkTodoDia" value="TodoDia" onclick="GetDiasSemana(this)" />
                                    <label><%= Resources.Resource.todosOsDias%> &nbsp</label>
                                </div>

                                <div>
                                    <input type="checkbox" id="chkSegSab" value="SegSab" onclick="GetDiasSemana(this)" />
                                    <label><%= Resources.Resource.segunda %> - <%= Resources.Resource.sabado %> &nbsp</label>
                                </div>

                                <div>
                                    <input type="checkbox" id="chkSegSex" value="SegSex" onclick="GetDiasSemana(this)" />
                                    <label><%= Resources.Resource.segunda %> - <%= Resources.Resource.sexta %> &nbsp</label>
                                </div>

                                <div>
                                    <input type="checkbox" id="chkSabDom" value="SabDom" onclick="GetDiasSemana(this)" />
                                    <label><%= Resources.Resource.sabado %> - <%= Resources.Resource.domingo %> &nbsp</label>
                                </div>
                            </div>
                        </td>

                        <td style="width: 50%; padding-left: 11px; padding-right: 43px;">
                            <div class="proporcao">
                                <div>
                                    <input type="checkbox" id="chkDomingo" value="Domingo" />
                                    <label><%= Resources.Resource.domingo %> &nbsp</label>
                                </div>

                                <div>
                                    <input type="checkbox" id="chkSegunda" value="Segunda" />
                                    <label><%= Resources.Resource.segunda %> &nbsp</label>
                                </div>

                                <div>
                                    <input type="checkbox" id="chkTerca" value="Terca" />
                                    <label><%= Resources.Resource.terca %> &nbsp</label>
                                </div>

                                <div>
                                    <input type="checkbox" id="chkQuarta" value="Quarta" />
                                    <label><%= Resources.Resource.quarta %> &nbsp</label>
                                </div>

                                <div>
                                    <input type="checkbox" id="chkQuinta" value="Quinta" />
                                    <label><%= Resources.Resource.quinta %> &nbsp</label>
                                </div>

                                <div>
                                    <input type="checkbox" id="chkSexta" value="Sexta" />
                                    <label><%= Resources.Resource.sexta %> &nbsp</label>
                                </div>

                                <div>
                                    <input type="checkbox" id="chkSabado" value="Sabado" />
                                    <label><%= Resources.Resource.sabado %> &nbsp</label>
                                </div>

                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="col-6 col-md-4 botoes" style="padding-left: 0; margin-top: 20px">
                <button type="button" id="btnSalvarAgenda" class="btn btn-success" onclick="SalvarPlano()"><%= Resources.Resource.salvar %></button>
                <button type="button" class="btn btn-warning btn-min-width mr-1 mb-1" style="margin-bottom: 0 !important;" onclick="fecharCadastro()"><%= Resources.Resource.cancelar %></button>
            </div>

        </div>

        <div class="row" style="padding-right: 15px; padding: 15px;">
            <div class="col-6 col-md-4 proporcaoSwitcheryAgruparDias" style="padding-top: 20px;">
                <div id="swit" class="proporcaoSwit" onclick="carregarDiasAgenda()">
                    <input type="checkbox" class="switchery " data-color="success" data-switchery="true" id="chkAgruparDias" checked="" />
                    <label class="card-title ml-1"><%= Resources.Resource.agrupar %> <%= Resources.Resource.dias %></label>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered mb-0" id="tblAgendaControlador">
                    <thead>
                        <tr>
                            <th style="border-collapse: collapse; padding-top: 14px;"><%= Resources.Resource.plano %></th>
                            <th style="border-collapse: collapse; padding-top: 14px;"><%= Resources.Resource.dias %></th>
                            <th style="border-collapse: collapse; padding-top: 14px;"><%= Resources.Resource.horarioEntrada %></th>
                            <%--<th></th>--%>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="tbAgendaControlador">
                        <tr>
                            <td colspan="5">
                                <%= Resources.Resource.naoHaRegistros %>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <div id="divCadastro" style="display: none;">
        <div class="btn-group pesquisa" style="margin-bottom: 10px;">
            <div class="col-md-9 sle1" style="padding-left: 0;">
                <%= Resources.Resource.controlador %>:
            <select class="form-control" style="" id="sleControladorCad" onchange="getAgenda()"></select>
                <%--<input type="button" style="float:right;" value="<%= Resources.Resource.validar %> <%= Resources.Resource.planos %>" class="btn btn-info" />--%>
            </div>
        </div>

        <div class="btn-group pesquisa" style="margin-bottom: 10px;">
            <div class="col-md-9 sle2" style="padding-left: 0;">
                <%= Resources.Resource.dias %>:
            <select class="form-control" style="" id="sleDia" onchange="">
                <option value="">─ SELECIONE ─</option>
                <option value="Domingo">Domingo</option>
                <option value="Segunda">Segunda</option>
                <option value="Terça">Terça</option>
                <option value="Quarta">Quarta</option>
                <option value="Quinta">Quinta</option>
                <option value="Sexta">Sexta</option>
                <option value="Sábado">Sábado</option>
            </select>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered mb-0" id="tblPlano" style="margin-top: 2rem;">
                <thead>
                    <tr>
                        <th style="border-collapse: collapse; padding-top: 14px;"><%= Resources.Resource.plano %></th>
                        <th style="border-collapse: collapse; padding-top: 14px;"><%= Resources.Resource.horarioEntrada %></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbPlanos">
                    <tr>
                        <td colspan="5">
                            <%= Resources.Resource.naoHaRegistros %>
                        </td>
                    </tr>
                </tbody>
            </table>

            <div class="form-actions right" style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem;">
                <div style="float: right; margin-top: 1rem;">
                    <%--<button type="button" class="btn btn-warning btn-min-width mr-1 mb-1" style="margin-bottom: 0 !important;" onclick="fecharCadastro()"><%= Resources.Resource.voltar %></button>--%>
                </div>
            </div>
        </div>
    </div>

    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>
        $(function () {

            loadResourcesLocales();
            loadControladores();
        });

        function loadControladores() {

            $.ajax({
                url: 'Default.aspx/loadControladores',
                data: "{}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    $("#sleControladorCad").empty();
                    $("#sleControladorCad").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                    $.each(data.d, function () {
                        $("#sleControladorCad").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });

                    $("#sleControladorPesq").empty();
                    $("#sleControladorPesq").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                    $.each(data.d, function () {
                        $("#sleControladorPesq").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        }

        function carregarDiasAgenda() {

            loadPlanosControlador();
            $("#divLoading").css("display", "block");
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/carregarDiasAgenda',
                dataType: 'json',
                data: "{'controlador':'" + $("#sleControladorPesq").val() + "','agruparDias':'" + $("#chkAgruparDias")[0].checked + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbAgendaControlador").empty();

                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {

                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            if (lst.id != "") {

                                cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + lst.Plano + "</td>";
                                cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + lst.Dia + "</td>";
                                cols += "<td style='border-collapse: collapse; vertical-align: middle;'>" + lst.HorarioEntrada + "</td>";

                                if ($("#chkAgruparDias")[0].checked == false) {
                                    //cols += "<td style='border-collapse: collapse; padding: 5px; width:1px;'><button class='btn btn-icon btn-info' type='button' onclick='editarAgenda(this)' data-diasemana='" + lst.Dia + "'><i class='ft-edit-3'></i></button>";
                                    cols += "<td style='border-collapse: collapse; padding: 5px; width:1px;'><button class='btn btn-danger btn-xs' " +
                                        " type='button' onclick='excluirDiasAgenda(this)' data-diasemana='" + lst.Dia + "' data-plano='"+lst.Plano+"' data-horarioentrada='"+lst.HorarioEntrada+"' data-id='"+lst.Id+"' " +
                                        " data-controlador='" + $("#sleControladorPesq").val() + "'><i class='ft-trash-2'></i></button>";
                                }
                                else {
                                    cols += "<td style='border-collapse: collapse; vertical-align: middle; padding-top: 0; padding-bottom: 0;'></td>";
                                }
                                newRow.append(cols);
                                $("#tbAgendaControlador").append(newRow);
                            }
                        }
                    }
                    else {

                        var newRow = $("<tr>");
                        var cols = "<td colspan='5' style='padding: 0.75rem 2rem;'> " + getResourceItem("naoHaRegistros") + " </td>";
                        newRow.append(cols);
                        $("#tbAgendaControlador").append(newRow);
                    }

                    $("#divLoading").css("display", "none");
                }
            });
        }

        function adicionarNovaAgenda() {

            $("#dvCadastro").css("display", "");
            $("#btnNovo").css("display", "none");
            $("#txtHorarioEntrada").val("");
            $("#sleDiaSemana").val("");

            $("#sleControladorPesq").removeClass("is-invalid");
            $("#slePlanos").removeClass("is-invalid");
            $("#sleDiaSemana").removeClass("is-invalid");
            $("#txtHorarioEntrada").removeClass("is-invalid");

            $("#chkTodoDia")[0].checked = false;
            $("#chkSegSab")[0].checked = false;
            $("#chkSegSex")[0].checked = false;
            $("#chkSabDom")[0].checked = false;

            $("#chkSegunda")[0].checked = false;
            $("#chkTerca")[0].checked = false;
            $("#chkQuarta")[0].checked = false;
            $("#chkQuinta")[0].checked = false;
            $("#chkSexta")[0].checked = false;
            $("#chkSabado")[0].checked = false;
            $("#chkDomingo")[0].checked = false;
        }

        function editarAgenda(btn) {

            $("#divPesquisa").css("display", "none");
            $("#divCadastro").css("display", "block");

            $("#sleControladorCad").val($("#sleControladorPesq").val());
            document.getElementById("sleControladorCad").disabled = true;
            $("#sleDiasSemana").val(btn.dataset.diasemana);
            getAgenda();
        }

        function loadPlanosControlador() {

            $("#divLoading").css("display", "block");
            $("#tbEstagios").empty();
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/loadPlanosControlador',
                dataType: 'json',
                data: "{'controlador':'" + $("#sleControladorPesq").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbPlanos").empty();

                    $("#slePlanos").empty();
                    $("#slePlanos").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                    if (data.d.length > 0) {

                        $.each(data.d, function () {
                            $("#slePlanos").append($("<option></option>").val(this['Value']).html(this['Text']));
                        });

                    }

                    $("#divLoading").css("display", "none");
                }
            });
        }

        function excluirDiasAgenda(btn) {

            Swal.fire({
                title: getResourceItem("confirmarExclusaoTipoAlert"),
                text: getResourceItem("agendaScootSeraExcluida"),
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("simExcluir")
            }).then((result) => {
                if (result.value) {

                    $.ajax({
                        url: 'Default.aspx/Excluir',
                        data: "{'plano':'" + btn.dataset.plano + "','id':'" + btn.dataset.id + "','controlador':'" + btn.dataset.controlador + "','user':'" + $("#hfUser").val() + "','horarioEntrada':'" + btn.dataset.horarioentrada + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("excluido"),
                                text: getResourceItem("excluidoSucesso"),
                            });

                            carregarDiasAgenda();
                        }
                    });
                }
            });
        }

        function fecharCadastro() {

            $("#dvCadastro").css("display", "none");
            $("#btnNovo").css("display", "");
            $("#txtHorarioEntrada").val("");
            $("#sleDiaSemana").val("");
            $("#sleControladorPesq").removeClass("is-invalid");
        }

        function ExcluirAgenda(btn) {

            Swal.fire({
                title: getResourceItem("confirmarExclusaoTipoAlert"),
                text: getResourceItem("planoAgendaSeraExcluida"),
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("simExcluir")
            }).then((result) => {
                if (result.value) {

                    var id = btn.dataset.id;
                    var horarioEntrada = btn.dataset.horario;
                    var plano = btn.dataset.plano;
                    $.ajax({
                        url: 'Default.aspx/Excluir',
                        data: "{'plano':'" + plano + "','id':'" + id + "','controlador':'" + $("#sleControladorCad").val() + "','user':'" + $("#hfUser").val() + "','horarioEntrada':'" + horarioEntrada + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("excluido"),
                                text: getResourceItem("excluidoSucesso"),
                            });

                            getAgenda();
                        }
                    });
                }
            });
        }

        function SalvarPlano() {

            if ($("#sleControladorPesq").val() == "") {

                $("#sleControladorPesq").addClass("is-invalid");
                Swal.fire({
                    type: 'warning',
                    title: getResourceItem("atencao") + '!',
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                return false;
            }
            else {
                $("#sleControladorPesq").removeClass("is-invalid");
            }

            if ($("#slePlanos").val() == "") {

                $("#slePlanos").addClass("is-invalid");
                Swal.fire({
                    type: 'warning',
                    title: getResourceItem("atencao") + '!',
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                return false;
            }
            else {
                $("#slePlanos").removeClass("is-invalid");
            }

            if ($("#sleDiaSemana").val() == "") {

                $("#sleDiaSemana").addClass("is-invalid");
                Swal.fire({
                    type: 'warning',
                    title: getResourceItem("atencao") + '!',
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                return false;
            }
            else {
                $("#sleDiaSemana").removeClass("is-invalid");
            }

            if ($("#txtHorarioEntrada").val() == "") {

                $("#txtHorarioEntrada").addClass("is-invalid");
                Swal.fire({
                    type: 'warning',
                    title: getResourceItem("atencao") + '!',
                    text: getResourceItem("preenchaCamposEmBranco"),
                });
                return false;
            }
            else {
                $("#txtHorarioEntrada").removeClass("is-invalid");
            }

            var diasSemana = [];
            if ($("#chkDomingo")[0].checked) {
                diasSemana.push("Domingo");
            }
            if ($("#chkSegunda")[0].checked) {
                diasSemana.push("Segunda");
            }
            if ($("#chkTerca")[0].checked) {
                diasSemana.push("Terça");
            }
            if ($("#chkQuarta")[0].checked) {
                diasSemana.push("Quarta");
            }
            if ($("#chkQuinta")[0].checked) {
                diasSemana.push("Quinta");
            }
            if ($("#chkSexta")[0].checked) {
                diasSemana.push("Sexta");
            }
            if ($("#chkSabado")[0].checked) {
                diasSemana.push("Sábado");
            }

            if (diasSemana.length == 0) {

                Swal.fire({
                    type: 'info',
                    title: 'ATENÇÃO!',
                    text: getResourceItem("selecioneDiaSemana"),
                })
                return;
            }

            var horarioEntradaFormatado = $("#txtHorarioEntrada").val().replace(":", "");

            $.ajax({
                url: 'Default.aspx/Salvar',
                data: "{'plano':'" + $("#slePlanos").val() + "','horarioEntrada':'" + horarioEntradaFormatado + "', " +
                    " 'controlador':'" + $("#sleControladorPesq").val() + "','user':'" + $("#hfUser").val() + "','diasSemana':'" + diasSemana + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d == "SUCESSO") {

                        Swal.fire({
                            type: 'success',
                            title: 'Salvo!',
                            text: getResourceItem("salvoComSucesso"),
                        });
                        fecharCadastro();
                        carregarDiasAgenda();
                    }
                    else {

                        Swal.fire({
                            type: 'error',
                            title: getResourceItem("erroTipoAlert"),
                            text: getResourceItem("jaExistePlanoNesseHorario"),
                        });

                    }
                }
            });
        }

        function SalvarAgenda(btn) {

            var id = btn.dataset.id;
            var plano = btn.dataset.plano;
            var index = btn.dataset.index;

            var horario = $("#txtHorarioEntrada" + index).val();
            var horarioFormatado = horario.replace(":", "");
            var hora = horarioFormatado.substring(0, 2);
            var minuto = horarioFormatado.substring(2, 4);
            var minutoConvertido = parseInt(hora) * 60;
            var minutoTotal = parseInt(minutoConvertido) + parseInt(minuto);

            var erro = false;
            var table = $("#tblPlano tbody");
            table.find('tr').each(function (i, el) {
                if (i != index) {

                    if (erro == false) {

                        var tr = $(this).find('td')

                        var planoPercorrido = tr[0].innerText;
                        var inputHrEntradaP = tr[1].firstElementChild;
                        var horarioP = inputHrEntradaP.value;
                        var horarioFormatadoP = horarioP.replace(":", "");
                        var horaP = horarioFormatadoP.substring(0, 2);
                        var minutoP = horarioFormatadoP.substring(2, 4);
                        var minutoConvertidoP = parseInt(horaP) * 60;
                        var minutoTotalP = parseInt(minutoConvertidoP) + parseInt(minutoP);

                        var resultado = minutoTotal - minutoTotalP;

                        try {
                            resultado = resultado.toString().replace("-", "");
                        } catch (exception) {

                        }

                        if (resultado <= 2) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erro"),
                                text: getResourceItem("intervaloPlano") + planoPercorrido + ", " + plano + getResourceItem("intervaloPlanoMinuto"),
                            });

                            erro = true;
                            return false;
                        }
                    }
                }
            });

            if (erro) {

                return;
            }

            var horarioEntrada = $("#txtHorarioEntrada" + index).val();
            if (horarioEntrada == "") {

                $("#txtHorarioEntrada" + index).addClass("is-invalid");
                return;
            }
            else {
                $("#txtHorarioEntrada" + index).removeClass("is-invalid");
            }

            if (id == "") {

                $.ajax({
                    url: 'Default.aspx/Salvar',
                    data: "{'plano':'" + plano + "','horarioEntrada':'" + horarioEntrada + "','controlador':'" + $("#sleControladorCad").val() + "','user':'" + $("#hfUser").val() + "','diaSemana':'" + $("#sleDiasSemana").val() + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "SUCESSO") {

                            Swal.fire({
                                type: 'success',
                                title: 'Salvo!',
                                text: getResourceItem("salvoComSucesso"),
                            });

                            getAgenda();
                        }
                        else if (data.d == "plano") {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erro"),
                                text: getResourceItem("jaExistePlanoNesseHorario"),
                            });

                            getAgenda();
                        }
                    }
                });

            } else {
                $.ajax({
                    url: 'Default.aspx/SalvarAlteracao',
                    data: "{'id':'" + id + "','horarioEntrada':'" + horarioEntrada + "','user':'" + $("#hfUser").val() + "','plano':'" + plano + "','controlador':'" + $("#sleControladorCad").val() + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "SUCESSO") {
                            Swal.fire({
                                type: 'success',
                                title: 'Salvo!',
                                text: getResourceItem("salvoComSucesso"),
                            });
                            getAgenda();
                        }

                        else if (data.d == "plano") {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erro"),
                                text: getResourceItem("jaExistePlanoNesseHorario"),
                            });
                            getAgenda();
                        }
                    }
                });
            }
        }

        function GetDiasSemana(chk) {

            if (chk.value == "TodoDia") {
                $("#chkSegSab")[0].checked = false;
                $("#chkSegSex")[0].checked = false;
                $("#chkSabDom")[0].checked = false;

                $("#chkSegunda")[0].checked = true;
                $("#chkTerca")[0].checked = true;
                $("#chkQuarta")[0].checked = true;
                $("#chkQuinta")[0].checked = true;
                $("#chkSexta")[0].checked = true;
                $("#chkSabado")[0].checked = true;
                $("#chkDomingo")[0].checked = true;
            } else if (chk.value == "SegSab") {
                $("#chkTodoDia")[0].checked = false;
                $("#chkSegSex")[0].checked = false;
                $("#chkSabDom")[0].checked = false;

                $("#chkSegunda")[0].checked = true;
                $("#chkTerca")[0].checked = true;
                $("#chkQuarta")[0].checked = true;
                $("#chkQuinta")[0].checked = true;
                $("#chkSexta")[0].checked = true;
                $("#chkSabado")[0].checked = true;
                $("#chkDomingo")[0].checked = false;
            } else if (chk.value == "SegSex") {
                $("#chkSegSab")[0].checked = false;
                $("#chkTodoDia")[0].checked = false;
                $("#chkSabDom")[0].checked = false;

                $("#chkSegunda")[0].checked = true;
                $("#chkTerca")[0].checked = true;
                $("#chkQuarta")[0].checked = true;
                $("#chkQuinta")[0].checked = true;
                $("#chkSexta")[0].checked = true;
                $("#chkSabado")[0].checked = false;
                $("#chkDomingo")[0].checked = false;
            } else if (chk.value == "SabDom") {
                $("#chkSegSab")[0].checked = false;
                $("#chkSegSex")[0].checked = false;
                $("#chkTodoDia")[0].checked = false;

                $("#chkSegunda")[0].checked = false;
                $("#chkTerca")[0].checked = false;
                $("#chkQuarta")[0].checked = false;
                $("#chkQuinta")[0].checked = false;
                $("#chkSexta")[0].checked = false;
                $("#chkSabado")[0].checked = true;
                $("#chkDomingo")[0].checked = true;
            }
            if (chk.checked == false) {
                $("#chkSegunda")[0].checked = false;
                $("#chkTerca")[0].checked = false;
                $("#chkQuarta")[0].checked = false;
                $("#chkQuinta")[0].checked = false;
                $("#chkSexta")[0].checked = false;
                $("#chkSabado")[0].checked = false;
                $("#chkDomingo")[0].checked = false;
            }
        }

        function validaHora(obj) {

            campo = eval(obj);
            if (campo.value.length < (5)) {

                $(obj).addClass("is-invalid");

                document.getElementById("btnSalvarAgenda").disabled = true;
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("preenchaHorarioCorretamente"),
                })
                return false;
            }
            else {
                $(obj).removeClass("is-invalid");
            }

            var hora = parseInt(campo.value.substring(0, 2));
            if (hora > 23) {

                $(obj).addClass("is-invalid");

                document.getElementById("btnSalvarAgenda").disabled = true;
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("preenchaHorarioCorretamente"),
                })
                return false;
            }
            else {
                $(obj).removeClass("is-invalid");
            }
            if (hora < 10)
                hora = "0" + hora;

            var min = parseInt(campo.value.substring(3, 5));
            if (min > 59) {

                $(obj).addClass("is-invalid");

                document.getElementById("btnSalvarAgenda").disabled = true;
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("preenchaHorarioCorretamente"),
                })
                return false;
            }
            else {
                $(obj).removeClass("is-invalid");
            }
            if (min < 10)
                min = "0" + min;

            if (hora == "0")
                hora = "00";
            if (min == "0")
                min = "00";
            $(obj).removeClass("is-invalid");
            document.getElementById("btnSalvarAgenda").disabled = false;

            return true;
        }

        //-------------------------------------------------------------------------------------------------------------------------------------

        var globalResources;        function loadResourcesLocales() {            $.ajax({                type: "POST",                contentType: "application/json; charset=utf-8",                url: 'Default.aspx/requestResource',                dataType: "json",                success: function (data) {                    globalResources = JSON.parse(data.d);                }            });        }        function getResourceItem(name) {            if (globalResources != undefined) {                for (var i = 0; i < globalResources.resource.length; i++) {                    if (globalResources.resource[i].name === name) {                        return globalResources.resource[i].value;                    }                }            }        }

        //CÓDIGO INATIVO--------------------------------------------------------------------------------------------------------------------------

        //function isNumber(evt) {

        //    evt = (evt) ? evt : window.event;
        //    var charCode = (evt.which) ? evt.which : evt.keyCode;
        //    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        //        return false;
        //    }
        //}

        //function validaHora(evt) {
        //    if (window.event.key == "Backspace")
        //        return true;

        //    if (evt.value.length == 2)
        //        evt.value += ":";
        //}

        //function validaHoraa(obj) {

        //    campo = eval(obj);
        //    if (campo.value.length < (5)) {
        //        $(obj).css("border-color", "#ff0000");
        //        $(obj).css("outline", "0");
        //        $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
        //        $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
        //        obj.focus();
        //        $("#btnSalvar")[0].disabled = true;
        //        return false;
        //    }

        //    var hora = parseInt(campo.value.substring(0, 2));
        //    var min = parseInt(campo.value.substring(3, 5));
        //    //var seg = parseInt(campo.value.substring(6, 8));

        //    if (hora > 23) {
        //        $(obj).css("border-color", "#ff0000");
        //        $(obj).css("outline", "0");
        //        $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
        //        $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
        //        obj.focus();
        //        $("#btnSalvar")[0].disabled = true;
        //        return false;
        //    }
        //    if (hora < 10)
        //        hora = "0" + hora;
        //    if (min > 59) {
        //        $(obj).css("border-color", "#ff0000");
        //        $(obj).css("outline", "0");
        //        $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
        //        $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
        //        obj.focus();
        //        $("#btnSalvar")[0].disabled = true;
        //        return false;
        //    }

        //    if (min < 10)
        //        min = "0" + min;

        //    //if (seg > 59) {
        //    //    $(obj).css("border-color", "#ff0000");
        //    //    $(obj).css("outline", "0");
        //    //    $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
        //    //    $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
        //    //    obj.focus();
        //    //    $("#btnSalvar")[0].disabled = true;
        //    //    return false;
        //    //}

        //    //if (seg < 10)
        //    //    seg = "0" + seg;

        //    if (hora == "0")
        //        hora = "00";
        //    if (min == "0")
        //        min = "00";
        //    //if (seg == "0")
        //    //    seg = "00";
        //    $(obj).val(hora + ":" + min); //$(obj).val(hora + ":" + min + ":" + seg);
        //    $(obj).css("border-color", "");
        //    $(obj).css("outline", "");
        //    $(obj).css("-webkit-box-shadow", "");
        //    $(obj).css("box-shadow", "");
        //    $("#btnSalvar")[0].disabled = false;
        //    return true;
        //}

        //function Hora(evento, objeto) {

        //    var keypress = (window.event) ? event.keyCode : evento.which;
        //    campo = eval(objeto);
        //    caracteres = '0123456789';
        //    separacao1 = '/';
        //    separacao2 = ' ';
        //    separacao3 = ':';
        //    conjunto1 = 2;
        //    conjunto2 = 5;
        //    conjunto3 = 10;
        //    conjunto4 = 13;
        //    conjunto5 = 16;

        //    if ((caracteres.search(String.fromCharCode(keypress)) != -1)) {

        //        var digito = parseInt(String.fromCharCode(keypress));
        //        if (campo.value.length == 0 && (digito > 2 || digito < 0)) {
        //            event.returnValue = false;
        //            return;
        //        }

        //        if (campo.value.length < (5)) {

        //            if (campo.value.length == conjunto1)
        //                campo.value = campo.value + separacao3;
        //            else if (campo.value.length == conjunto2)
        //                campo.value = campo.value + separacao3;
        //        }
        //        else {
        //            event.returnValue = false;
        //        }
        //    }
        //    else {
        //        event.returnValue = false;
        //    }
        //}
    </script>
</asp:Content>
