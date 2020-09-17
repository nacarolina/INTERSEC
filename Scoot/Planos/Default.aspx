<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Scoot.Planos.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

    <style>
        @media (max-width: 3044px) {
            .camposCadastro {
                max-width: 25% !important;
                margin-bottom: 15px;
            }

            .pesquisa {
                width: 48%;
            }

            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
            }

            .proporcaoAddControlador {
                margin-top: 20px;
                margin-bottom: 0px;
                float: right;
            }
        }

        @media (max-width: 1023px) {
            .camposCadastro {
                max-width: 100% !important;
                margin-bottom: 15px;
            }

            .proporcaoAddControlador {
                margin-top: 0px;
                margin-bottom: 0px;
                float: left;
            }

            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
            }

            .pesquisa {
                width: 100%;
            }

            .proporcaoDivBtn {
                max-width: 100% !important;
                flex: 100% !important;
                float: right;
            }

            .proporcaoInputPesq {
                padding-right: 15px !important;
            }

            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
                padding-right: 0 !important;
            }
        }


        /*NOVO STYLE*/

        @media (max-width: 1440px) {
            .proporcaoSelect {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }
        }

        @media (max-width: 1440px) {
            .proporcaoSelectCadAnel {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
                padding-bottom: 15px;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoInput {
                max-width: 67% !important;
                flex: 60% !important;
                padding-right: 15px;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
                padding-right: 15px !important;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoSle {
                width: 40% !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoSle {
                width: 100% !important;
                padding-right: 0 !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoDivBtn {
                max-width: 100% !important;
                flex: 100% !important;
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
                margin-top: 20px;
                text-align: right;
            }
        }

        @media (max-width: 1023px) {
            .divBtnAddPlano {
                padding-right: 0 !important;
            }
        }

        @media (max-width: 1440px) {
            .camposCadastro {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }
            /*COLUNA DOS INPUTS*/
            #coluna1 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #coluna2 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #coluna3 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            #coluna4 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }
        }

        #tbPlanos tr:hover {
            background-color: #e3ebf338;
        }

        #tbEstagios tr:hover {
            background-color: #e3ebf338;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.planos %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfUsuarioLogado" ClientIDMode="Static" runat="server" />

    <div id="dvPesquisa">

        <div class="row" style="padding-right: 15px; padding-left: 15px; margin-bottom: 15px">
            <div class="col-6 col-md-4 proporcaoSelect proporcaoInput proporcaoSle" style="float: left; padding-left: 0;">
                <div class="col-md-9 divBtnAddPlano" id="col3" style="padding-left: 0;">
                    <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                    <select id="sleAnelPesq" class="form-control proporcaoSle" onchange="getPlanos()"></select>
                </div>
            </div>

            <div class="col-6 col-md-4 proporcaoDivBtn" style="float: right; padding-right: 0;">
                <div class="proporcaoAddControlador">
                    <button type="button" class="btn btn-icon btn-secondary mr-1" onclick="NovoPlano()" style="margin-right: 0 !important;"
                        data-toggle="tooltip" data-placement="left" title="<%= Resources.Resource.adicionar %> <%= Resources.Resource.novo %> <%= Resources.Resource.plano %>">
                        <i class="ft-plus-square"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="table-responsive" style="margin-bottom: 20px">
            <table class="table table-bordered mb-0" id="tblPlanos">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.plano %></th>
                        <th><%= Resources.Resource.qtdEstagios %></th>
                        <th><%= Resources.Resource.tempoCiclo %></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbPlanos"></tbody>
            </table>
        </div>

    </div>

    <div id="dvCadastro" style="display: none">

        <div class="row">
            <div class="col-md-6 camposCadastro">
                <div class="form-group row">
                    <div class="col-md-9" id="coluna1">
                        <%= Resources.Resource.anel %>:
                <select id="sleAnel" class="form-control" onchange="loadEstagios()"></select>
                    </div>
                </div>
            </div>
            <div class="col-md-6 camposCadastro">
                <div class="form-group row">
                    <div class="col-md-9" id="coluna2">
                        <%= Resources.Resource.plano %>:<br />
                        <input type="number" id="txtPlano" disabled="disabled" value="2" class="form-control" />
                    </div>
                </div>
            </div>
            <div class="col-md-6 camposCadastro">
                <div class="form-group row">
                    <div class="col-md-9" id="coluna3">
                        <%= Resources.Resource.tempoCiclo %> (<b id="lblTempoCicloEstimado" style="margin-bottom: 0;">0</b>) :
                    <input type="number" id="txtCiclo" class="form-control" />
                    </div>
                </div>
            </div>
            <div class="col-md-6 camposCadastro">
                <div class="form-group row">
                    <div class="col-md-9" id="coluna4">
                        <%= Resources.Resource.adicionar %> <%= Resources.Resource.estagio %>:
                    <select id="sleEstagios" onchange="AdicionarEstagio()" class="form-control"></select>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-responsive" style="margin-bottom: 20px">
            <table class="table table-bordered mb-0" id="tblEstagios">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.estagio %></th>
                        <th><%= Resources.Resource.verdeSeguranca %></th>
                        <th><%= Resources.Resource.verdeMaximo %></th>
                        <th><%= Resources.Resource.tmpe %></th>
                        <th><%= Resources.Resource.momentoAbertura %></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbEstagios"></tbody>
            </table>
        </div>

        <div class="form-actions right" style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem;">
            <div style="float: right; margin-top: 1rem;">
                <input type="button" class="btn btn-success" id="btnSalvar" onclick="salvar()" value="<%= Resources.Resource.salvar %>" />
                <button type="button" class="btn btn-warning" onclick="Cancelar()"><%= Resources.Resource.voltar %></button>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>
        var globalResources;        function loadResourcesLocales() {            $.ajax({                type: "POST",                contentType: "application/json; charset=utf-8",                url: 'Default.aspx/requestResource',                async: false,                dataType: "json",                success: function (data) {                    globalResources = JSON.parse(data.d);                }            });        }        function getResourceItem(name) {            if (globalResources != undefined) {                for (var i = 0; i < globalResources.resource.length; i++) {                    if (globalResources.resource[i].name === name) {                        return globalResources.resource[i].value;                    }                }            }        }

        $(function () {

            loadResourcesLocales();
            loadAneis();
            getPlanos();
        });

        function loadAneis() {

            $.ajax({
                url: 'Default.aspx/loadAneis',
                data: "{}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#sleAnel").empty();
                    $("#sleAnel").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                    $.each(data.d, function () {
                        $("#sleAnel").append($("<option data-anel='" + this['Value'] + "'></option>").val(this['Text']).html(this['Text']));
                    });

                    $("#sleAnelPesq").empty();
                    $("#sleAnelPesq").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                    $.each(data.d, function () {
                        $("#sleAnelPesq").append($("<option data-anel='" + this['Value'] + "'></option>").val(this['Text']).html(this['Text']));
                    });
                }
            });
        }

        function getPlanos() {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/GetPlanos',
                dataType: 'json',
                data: "{'anel':'" + $("#sleAnelPesq").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbPlanos").empty();
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='vertical-align: middle;'>" + lst.plano + "</td>";
                            cols += "<td style='vertical-align: middle;'>" + lst.qtdEstagios + "</td>";
                            cols += "<td style='vertical-align: middle;'>" + lst.ciclo + "</td>";                            cols += "<td style='border-collapse: collapse; padding: 5px; width:1px;'><button id='editarPlanos' class='btn btn-icon btn-info mr-1' " +                                " style='cursor:pointer; font-size:medium; margin-right: 0 !important;' onclick='editarPlano(this)' " +
                                " data-plano='" + lst.plano + "' data-ciclo='" + lst.ciclo + "' ><i class='ft-edit-3'></button></td>";

                            cols += "<td style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' style='cursor:pointer; font-size:medium; margin-right: 0 !important;' " +
                                " class='btn btn-danger btn-xs' onclick='excluirPlano(this)' data-plano='" + lst.plano + "'><i class='ft-trash-2'></i></button></td>";

                            newRow.append(cols);
                            $("#tbPlanos").append(newRow);
                        }
                    }
                    else {

                        var newRow = $("<tr>");
                        var cols = "<td colspan='6' style='border-collapse: collapse; padding: 0.75rem 2rem;'> " + getResourceItem("naoHaRegistros") + " </td>";
                        newRow.append(cols);
                        $("#tbPlanos").append(newRow);
                    }

                    $("#divLoading").css("display", "none");
                }
            });
        }

        function excluirPlano(btn) {

            Swal.fire({
                title: getResourceItem("confirmarExclusaoTipoAlert"),
                text: getResourceItem("planoProgramacoesSeraoExcluidos"),
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("simExcluir")
            }).then((result) => {
                if (result.value) {

                    $("#divLoading").css("display", "block");

                    var anel = $("#sleAnelPesq").val();
                    var plano = btn.dataset.plano;

                    $.ajax({
                        type: 'POST',
                        url: 'Default.aspx/excluirPlano',
                        dataType: 'json',
                        data: "{'anel':'" + anel + "','plano':'" + plano + "','usuarioLogado':'" + $("#hfUsuarioLogado").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire(

                                getResourceItem("excluidoTipoAlert"),
                                getResourceItem("planoExcluidoComSucesso"),
                                'success'
                            )

                            getPlanos();
                            $("#divLoading").css("display", "none");
                        }
                    });
                }
            });
        }

        function NovoPlano() {

            $("#sleAnel").val("");
            $("#sleEstagios").empty();
            $("#dvCadastro").css("display", "");
            $("#dvPesquisa").css("display", "none");
            $("#txtPlano").val("");
            $("#txtCiclo").val("");
            $("#btnSalvar").val("<%= Resources.Resource.salvar %>");
            $("#tbEstagios").empty();
            var newRow = $("<tr>");
            var cols = "<td colspan='6' style='border-collapse: collapse; padding: 0.75rem 2rem;'> " + getResourceItem("naoHaRegistros") + " </td>";
            newRow.append(cols);
            $("#tbEstagios").append(newRow);
        }

        function loadEstagios() {

            if ($("#btnSalvar").val() == "<%= Resources.Resource.salvar %>") {
                getProxPlano();
            }

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/GetEstagios',
                dataType: 'json',
                data: "{'anel':'" + $("#sleAnel").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    $("#sleEstagios").empty();
                    $("#sleEstagios").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            $("#sleEstagios").append($("<option data-verdeSeg='" + lst.verdeSeguranca + "' data-verdeMax='" + lst.verdeMax + "'></option>").val(lst.estagio).html(lst.estagio));
                        }
                    }
                }
            });
        }

        function getProxPlano() {

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/getProxPlano',
                dataType: 'json',
                data: "{'anel':'" + $("#sleAnel").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d.length > 0) {
                        $("#txtPlano").val(data.d);
                    }
                }
            });
        }

        function AdicionarEstagio() {

            if ($("#sleEstagios").val() != "") {

                $.ajax({
                    type: 'POST',
                    url: 'Default.aspx/SalvarEstagio',
                    dataType: 'json',
                    data: "{'anel':'" + $("#sleAnel").val() + "','estagio':'" + $("#sleEstagios").val() + "','plano':'" + $("#txtPlano").val() + "','ciclo':'','momentoAbertura':''}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "estagio") {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("JaExtisteEsseEstagioNoPlano"),
                            });
                            return;
                        }

                        getEstagiosPlano();
                        document.getElementById("sleAnel").disabled = true;
                    }
                });
            }
        }

        function getEstagiosPlano() {

            $("#divLoading").css("display", "block");

            $("#tbEstagios").empty();
            var posicao = $("#sleAnel")[0].selectedIndex;
            var nmrAnel = $("#sleAnel")[0].options[posicao].dataset.anel;
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/GetEstagiosPlano',
                dataType: 'json',
                async: false,
                data: "{'anel':'" + $("#sleAnel").val() + "','plano':'" + $("#txtPlano").val() + "','nmrAnel':'" + nmrAnel + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbEstagios").empty();
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='vertical-align: middle;' data-id='" + lst.id + "'>" + lst.estagio + "</td>";
                            cols += "<td style='width:18%; vertical-align: middle;'>" + lst.verdeSeguranca + "</td>";
                            cols += "<td style='width:18%; vertical-align: middle;'>" + lst.verdeMax + "</td>";

                            if (lst.desativarTMPE == true) {
                                cols += "<td style='border-collapse: collapse; padding: 16px; width:1px; text-align-last: center;' data-desativartmpe='true'><span class='fa fa-circle' style='color:#fa626b; font-size: large;'></span></td>";
                            }
                            else {
                                cols += "<td style='border-collapse: collapse; padding: 16px; width:1px; text-align-last: center;' data-desativartmpe='false'><span class='fa fa-circle' style='color:#11cf77; font-size: large;'></span></td>";
                            }

                            cols += "<td style='padding: 5px; width: 1rem;'><input id='txtMomentoAbertura" + lst.id + "' type='number' onkeyup='verificarTemploCiclo()' value='" + lst.momentoAbertura + "' class='form-control'/></td>";

                            cols += "<td style='border-collapse: collapse; padding: 5px; width:1px;'><button type='button' onclick='ExcluirEstagioPlano(this)' data-id='" + lst.id + "' data-estagio='" + lst.estagio + "' style='cursor:pointer; font-size:medium; margin-right: 0 !important;' " +
                                " class='btn btn-danger btn-xs'><i class='ft-trash-2'></i></button></td>";

                            newRow.append(cols);
                            $("#tbEstagios").append(newRow);
                        }
                    }
                    else {

                        document.getElementById("sleAnel").disabled = false;
                        var newRow = $("<tr>");
                        var cols = "<td colspan='6' style='border-collapse: collapse; padding: 0.75rem 2rem;'> " + getResourceItem("naoHaRegistros") + " </td>";
                        newRow.append(cols);
                        $("#tbEstagios").append(newRow);
                    }

                    $("#divLoading").css("display", "none");
                }
            });
        }

        function verificarTemploCiclo() {

            var maiorValor = "", verdeMaximo = "";

            var table = $("#tblEstagios tbody");
            table.find('tr').each(function (i, el) {
                var tr = $(this).find('td')

                if (maiorValor == "") {

                    maiorValor = tr[4].firstElementChild.value;
                    verdeMaximo = tr[2].innerText;
                }
                else if (parseInt(maiorValor) < parseInt(tr[4].firstElementChild.value)) {

                    maiorValor = tr[4].firstElementChild.value;
                    verdeMaximo = tr[2].innerText;
                }
            });

            var resultado = parseInt(maiorValor) + parseInt(verdeMaximo);

            $("#lblTempoCicloEstimado")[0].innerText = resultado;
        }

        function salvar() {

            if ($("#txtCiclo").val() == "" || $("#txtCiclo").val() == "0") {

                $("#txtCiclo").addClass("is-invalid");
                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("informe") + " " + getResourceItem("tempoCiclo"),
                })
                return;
            }
            $("#txtCiclo").removeClass("is-invalid");

            var minimoAnterior = "", maximoAnterior = "", desativarTMPE = "", momentoAberturaAnterior = "", estagioAnterior = "", erro = false;
            var table = $("#tblEstagios tbody");
            table.find('tr').each(function (i, el) {
                qtdLinhas = table.find('tr').length;
                var tr = $(this).find('td')

                if (erro) {
                    return;
                }

                //#region VALIDAÇÕES
                var id = "";
                if (tr[4].firstElementChild.value == "") {

                    id = tr[0].dataset.id;
                    $("#txtMomentoAbertura" + id).addClass("is-invalid");
                    Swal.fire({

                        type: 'error',
                        title: getResourceItem("erroTipoAlert"),
                        text: getResourceItem("preenchaCamposEmBranco"),
                    })

                    erro = true;
                    return;
                }
                else {
                    id = tr[0].dataset.id;
                    $("#txtMomentoAbertura" + id).removeClass("is-invalid");
                }

                if (minimoAnterior == "" && maximoAnterior == "" && desativarTMPE == "" && momentoAberturaAnterior == "") { // Estagio anterior

                    minimoAnterior = tr[1].innerText;
                    maximoAnterior = tr[2].innerText;
                    desativarTMPE = tr[3].dataset.desativartmpe;
                    momentoAberturaAnterior = tr[4].firstElementChild.value;
                    estagioAnterior = tr[0].textContent;
                }
                else {

                    var id = tr[0].dataset.id;
                    var estagioAtual = tr[0].textContent;
                    var momentoAberturaAtual = parseInt(tr[4].firstElementChild.value); // Momento de abetura atual
                    var resultadoAberturaMinimaPermitido = parseInt(momentoAberturaAnterior) + parseInt(minimoAnterior) + 1; // Soma do mínimo do anterior com o momento de abertura anterior
                    var resultadoAberturaMaximaPermitido = parseInt(momentoAberturaAnterior) + parseInt(maximoAnterior) + 1; // Soma do máximo do anterior com o momento de abertura anterior

                    if (momentoAberturaAtual < resultadoAberturaMinimaPermitido) {

                        $("#txtMomentoAbertura" + id).addClass("is-invalid");
                        Swal.fire({

                            type: 'error',
                            title: getResourceItem("erroTipoAlert"),
                            text: getResourceItem("momentoAberturaNaoPodeSerMenorQue") + resultadoAberturaMinimaPermitido,
                        })

                        erro = true;
                        return;
                    }

                    if (momentoAberturaAtual > resultadoAberturaMaximaPermitido && desativarTMPE == "false") {

                        $("#txtMomentoAbertura" + id).addClass("is-invalid");
                        Swal.fire({

                            type: 'error',
                            title: getResourceItem("erroTipoAlert"),
                            text: getResourceItem("momentoAberturaNaoPodeSerMaiorQue") + resultadoAberturaMaximaPermitido,
                        })

                        erro = true;
                        return;
                    }

                    $("#txtMomentoAbertura" + id).removeClass("is-invalid");
                    minimoAnterior = tr[1].innerText;
                    maximoAnterior = tr[2].innerText;
                    desativarTMPE = tr[3].dataset.desativartmpe;
                    momentoAberturaAnterior = tr[4].firstElementChild.value;
                    estagioAnterior = tr[0].textContent;

                    if (i == qtdLinhas - 1) {

                        var tempoCiclo = parseInt($("#txtCiclo").val());

                        var id = tr[0].dataset.id;
                        var estagioAtual = tr[0].textContent;
                        var momentoAberturaAtual = parseInt(tr[4].firstElementChild.value); // Momento de abetura atual
                        var resultadoAberturaMinimaPermitido = parseInt(momentoAberturaAnterior) + parseInt(minimoAnterior); // Soma do mínimo do anterior com o momento de abertura anterior
                        var resultadoAberturaMaximaPermitido = parseInt(momentoAberturaAnterior) + parseInt(maximoAnterior); // Soma do máximo do anterior com o momento de abertura anterior

                        if (tempoCiclo < resultadoAberturaMinimaPermitido) {

                            $("#txtCiclo").addClass("is-invalid");
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("tempoCicloNaoPodeSerMenorQue") + resultadoAberturaMinimaPermitido,
                            })

                            erro = true;
                            return;
                        }

                        if (tempoCiclo > resultadoAberturaMaximaPermitido && desativarTMPE == "false") {

                            $("#txtCiclo").addClass("is-invalid");
                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("tempoCicloNaoPodeSerMaiorQue") + resultadoAberturaMaximaPermitido,
                            })

                            erro = true;
                            return;
                        }
                    }
                }
                //#endregion

                if (erro == false) {

                    $.ajax({
                        type: 'POST',
                        url: 'Default.aspx/salvarPlano',
                        dataType: 'json',
                        data: "{'anel':'" + $("#sleAnel").val() + "','plano':'" + $("#txtPlano").val() + "','ciclo':'" + $("#txtCiclo").val() + "', 'estagio':'" + tr[0].innerText + "', " +
                            " 'momentoAbertura':'" + tr[4].firstElementChild.value + "','usuarioLogado':'" + $("#hfUsuarioLogado").val() + "', 'id':'" + tr[0].dataset.id + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                        },
                        error: function (data) {

                            $("#divLoading").css("display", "none");
                        }
                    });
                }
            });

            if (erro == false) {
                Swal.fire(

                    getResourceItem("salvoTipoAlert"),
                    getResourceItem("planoSalvoComSucesso"),
                    'success'
                )
                $("#divLoading").css("display", "none");
            }
        }

        function ExcluirEstagioPlano(btn) {

            Swal.fire({
                title: getResourceItem("confirmarExclusaoTipoAlert"),
                text: getResourceItem("estagioExcluidoPlano"),
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("simExcluir")
            }).then((result) => {
                if (result.value) {

                    $("#divLoading").css("display", "block");

                    var idEstagio = btn.dataset.id;
                    var estagio = btn.dataset.estagio;
                    var anel = $("#sleAnel").val();
                    var plano = $("#txtPlano").val();

                    $.ajax({
                        type: 'POST',
                        url: 'Default.aspx/excluirEstagioPlano',
                        dataType: 'json',
                        data: "{'id':'" + idEstagio + "','estagio':'" + estagio + "','anel':'" + anel + "','plano':'" + plano + "','usuarioLogado':'" + $("#hfUsuarioLogado").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire(

                                getResourceItem("excluidoTipoAlert"),
                                getResourceItem("estagioPlanoExcluidos"),
                                'success'
                            )

                            getEstagiosPlano();
                            $("#divLoading").css("display", "none");
                        }
                    });
                }
            });
        }

        function Cancelar() {

            $("#dvCadastro").css("display", "none");
            $("#dvPesquisa").css("display", "");
            loadAneis();
            $("#tbPlanos").empty();
            var newRow = $("<tr>");
            var cols = "<td colspan='6' style='border-collapse: collapse; padding: 0.75rem 2rem;'> " + getResourceItem("naoHaRegistros") + " </td>";
            newRow.append(cols);
            $("#tbPlanos").append(newRow);
            document.getElementById("sleAnel").disabled = false;
            $("#lblTempoCicloEstimado")[0].innerText = "0";
        }

        function editarPlano(btn) {

            $("#dvCadastro").css("display", "");
            $("#dvPesquisa").css("display", "none");

            document.getElementById("sleAnel").disabled = true;
            $("#sleAnel").val($("#sleAnelPesq").val());
            $("#txtPlano").val(btn.dataset.plano);
            $("#txtCiclo").val(btn.dataset.ciclo);
            $("#btnSalvar").val("<%= Resources.Resource.salvarAlteracoes %>");

            loadEstagios();
            getEstagiosPlano();
            verificarTemploCiclo();
        }

    </script>
</asp:Content>
