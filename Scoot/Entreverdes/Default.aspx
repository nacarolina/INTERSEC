<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Scoot.Entreverdes.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <style>
        @media (max-width: 1440px) {
            .proporcaoSelect {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }
        }

        /*BOTÃO ADD MOBILE*/
        @media (max-width: 1023px) {
            .proporcaoDivBtn {
                max-width: 100% !important;
                flex: 100% !important;
            }
        }

        /*BOTÃO ADD ANEL MOBILE*/
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

        /*SELECT ANEL DESKTOP E MOBILE*/
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

        table tbody tr:hover,
        table tbody tr td.backgroud {
            background-color: #e3ebf338;
        }

        #tbPlanos tr:hover {
            background-color: #e3ebf338;
        }

        /*CHECKBOX*/
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.entreverdes %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfUsuarioLogado" ClientIDMode="Static" runat="server" />

    <%--TELA INICIO--%>
    <div id="telaInicial" style="display: none;">
        <div class="row">
            <div class="col-6 col-md-4 proporcaoSelect proporcaoInput proporcaoSle">
                <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>:</label>
                <select class="form-control proporcaoSle" id="sleAnelPesq" onchange="carregarGridPlanos()"></select>
            </div>

            <div class="col-6 col-md-4 proporcaoDivBtn" style="display: none;">
                <div class="proporcaoAddControlador">
                    <button type="button" class="btn btn-icon btn-secondary mr-1" onclick="addNovoEntreverdes()" style="margin-right: 0 !important;"
                        data-toggle="tooltip" data-placement="left" title="<%= Resources.Resource.adicionar %> <%= Resources.Resource.entreverdes %>">
                        <i class="ft-plus-square"></i>
                    </button>
                </div>
            </div>
        </div>

        <div>
            <%--LISTAR ANÉIS DO BANCO--%>
            <div class="table-responsive" style="margin-top: 2rem;">
                <label id="lblPlanos" style="margin-bottom: 0;"><%= Resources.Resource.listaPlanos %> </label>
                <table id="tblPlanos" class="table table-bordered mb-0">
                    <thead>
                        <tr>
                            <th><%= Resources.Resource.plano %></th>
                            <th><%= Resources.Resource.qtdEstagios %></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="tbPlanos">
                        <tr>
                            <td colspan="3"><%= Resources.Resource.naoHaRegistros %></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <%--▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬--%>

    <%--TELA CADASTRO--%>
    <div id="telaCadEntreverdes" style="display: block;">
        <div class="row">
            <div class="col-6 col-md-4 proporcaoSelectCadAnel">
                <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>:</label>
                <select class="form-control" id="sleAnel" onchange="carregarGridEstagios()"></select>
            </div>

            <div class="col-6 col-md-4 proporcaoDivBtn" style="display: none;">
                <label style="margin-bottom: 0;"><%= Resources.Resource.plano %>:</label>
                <select class="form-control" id="slePlanos" disabled="disabled" onchange="carregarGridEstagios()"></select>
            </div>
        </div>

        <div class="table-responsive" id="divEstagios" style="margin-top: 2rem; display: block;">
            <label id="lblListaEstagios" style="margin-bottom: 0; display: none;"><%= Resources.Resource.listaEstagios %> </label>
            <table id="tblEstagios" class="table table-bordered mb-0">
                <thead id="thEstagios">
                </thead>
                <tbody id="tbEstagios">
                </tbody>
            </table>
        </div>

        <div id="botoes_de_acao" class="form-actions right" style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem; display: none;">
            <div style="float: right; margin-top: 1rem;">
                <button type="button" class="btn btn-success" id="btnSalvar" onclick="salvar();"><%= Resources.Resource.salvar %></button>
                <%--<button type="button" class="btn btn-warning btn-min-width mr-1 mb-1" style="margin-bottom: 0 !important;" onclick="fecharCadastro();"><%= Resources.Resource.cancelar %></button>--%>
            </div>
        </div>
    </div>


    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>


    <script>
        $(function () {

            carregarAneis();
            loadResourcesLocales();
            $("#slePlanos").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
        });

        //SCRIPT TELA INICIAL ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
        function carregarAneis() {
            $("#divLoading").css("display", "block");
            $.ajax({                url: 'Default.aspx/carregarAneis',                data: "{}",                dataType: "json",                async: false,                type: "POST",                contentType: "application/json; charset=utf-8",                success: function (data) {                    $("#sleAnelPesq").empty();                    $("#sleAnelPesq").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));                    $.each(data.d, function () {                        $("#sleAnelPesq").append($("<option></option>").val(this['Value']).html(this['Text']));                    });                    $("#sleAnel").empty();                    $("#sleAnel").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));                    $.each(data.d, function () {                        $("#sleAnel").append($("<option></option>").val(this['Value']).html(this['Text']));                    });

                    $("#divLoading").css("display", "none");                }            });        }        /*function carregarGridPlanos() {            $("#divLoading").css("display", "block");            $.ajax({                type: 'POST',                url: 'Default.aspx/carregarGridPlanos',                dataType: 'json',                data: "{'anel':'" + $("#sleAnelPesq").val() + "'}",                contentType: "application/json; charset=utf-8",                success: function (data) {                    $("#tbPlanos").empty();                    if (data.d.length > 0) {                        for (var i = 0; i < data.d.length; i++) {                            var lst = data.d[i];                            var newRow = $("<tr>");                            var cols = "";                            cols += "<td style='border-collapse: collapse; padding-top: 14px;'>" + lst.Text + "</td>"; //Plano                            cols += "<td style='border-collapse: collapse; padding-top: 14px;'>" + lst.Value + "</td>"; //Qtd Estagios                            cols += "<td style='border-collapse: collapse; padding: 5px; width:1px;'><button id='editarPlanos' class='btn btn-icon btn-info mr-1' style='margin-right: 0 !important;' " +                                " onclick='editarPlanos(this)' data-plano='" + lst.Text + "' data-qtdestagios='" + lst.Value + "' ><i class='ft-edit-3'></button></td>"; //" + getResourceItem("configuracoes") + "                            newRow.append(cols);                            $("#tbPlanos").append(newRow);                        }                    }                    else {                        var newRow = $("<tr>");                        var cols = "<td colspan='3' style='border-collapse: collapse; padding-top: 14px;'> " + getResourceItem("naoHaRegistros") + " </td>";                        newRow.append(cols);                        $("#tbPlanos").append(newRow);                    }                    $("#divLoading").css("display", "none");                }            });        }*/

        function carregarEntreverdes() {            $("#divLoading").css("display", "block");            $.ajax({                url: 'Default.aspx/carregarEntreverdes',                data: "{'anel':'" + $("#sleAnel").val() + "'}",                dataType: "json",                type: "POST",                contentType: "application/json; charset=utf-8",                success: function (data) {                    //PERCORRE A TABELA E INSERE OS VALORES                    var i = 0;                    while (data.d[i]) {

                        var lst = data.d[i];                        $("#txtEntreverdes" + lst.estagio1 + lst.estagio2).val(lst.entreverdes);                        if (lst.demandado == "True") {
                            $("#chk" + lst.estagio1)[0].checked = true;
                        }                        else {
                            $("#chk" + lst.estagio1)[0].checked = false;
                        }                        /*if ($("#txtEntreverdes" + lst.estagio1 + lst.estagio2).val() != "" || $("#txtEntreverdes" + lst.estagio1 + lst.estagio2).val() == "⨉") {

                            document.getElementById("btnSalvar").innerHTML = "Salvar Alterações";
                        }                        else {
                            document.getElementById("btnSalvar").innerHTML = "Salvar";
                        }*/                        i++;                    }                    $("#divLoading").css("display", "none");                }            });
        }

        function addNovoEntreverdes() {

            $("#telaInicial").css("display", "none");
            $("#telaCadEntreverdes").css("display", "block");
            $("#botoes_de_acao").css("display", "none");

            carregarAneis();
            $("#slePlanos").empty();
            $("#slePlanos").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
            $("#thEstagios").empty();            $("#tbEstagios").empty();
            $("#divEstagios").css("display", "none");
        }

        //SCRIPT CADASTRO ENTREVERDES ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

        //function fecharCadastro() {

        //    $("#telaInicial").css("display", "block");
        //    $("#telaCadEntreverdes").css("display", "none");

        //    carregarAneis();
        //    $("#tbPlanos").empty();
        //    var newRow = $("<tr>");        //    var cols = "<td colspan='3' style='border-collapse: collapse; padding-top: 14px;'> " + getResourceItem("naoHaRegistros") + " </td>";        //    newRow.append(cols);        //    $("#tbPlanos").append(newRow);
        //}

        <%--function carregarPlanos() {

            $("#divLoading").css("display", "block");

            $.ajax({                url: 'Default.aspx/carregarPlanos',                data: "{'anelSelecionado':'" + $("#sleAnel").val() + "'}",                dataType: "json",                async: false,                type: "POST",                contentType: "application/json; charset=utf-8",                success: function (data) {                    $("#slePlanos").empty();                    $("#slePlanos").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));                    $.each(data.d, function () {                        $("#slePlanos").append($("<option></option>").val(this['Value']).html(this['Text']));                    });                    $("#divLoading").css("display", "none");                }            });
        }--%>

        function carregarGridEstagios() {
            $("#divLoading").css("display", "block");            $.ajax({                type: 'POST',                url: 'Default.aspx/carregarGridEstagios',                dataType: 'json',                async: false,                data: "{'anel':'" + $("#sleAnel").val() + "'}",                contentType: "application/json; charset=utf-8",                success: function (data) {

                    //$("#divEstagios").css("display", "block");
                    //$("#botoes_de_acao").css("display", "block");

                    $("#thEstagios").empty();                    $("#tbEstagios").empty();                    //logica th                    var rowTH = $("<tr id='trCima'>");                    var colsTH = "";                    colsTH += "<th style='border-collapse: collapse; padding-top: 14px; width: 10rem;'>Disponível</th>";                    colsTH += "<th style='border-collapse: collapse; padding-top: 14px;'>&nbsp;</th>";                    rowTH.append(colsTH);                    if (data.d.length > 0) {                        var qtdEstagios = data.d.length;                        //O i É A POSIÇÃO DA MINHA LINHA NA VERTICAL                        for (var i = 0; i < data.d.length; i++) {                            //ADICIONA EM CIMA                            var lst = data.d[i];                            colsTH = "";                            colsTH += "<th id='tdSelecionado1' style='border-collapse: collapse; padding-top: 14px;text-align: center;'>" + lst.Text + "</th>";                            rowTH.append(colsTH);                            $("#thEstagios").append(rowTH);                            //ADICIONA AO LADO - logica do tb                             var rowTB = $("<tr id='trBaixo'>");                            var colsTB = "";                            colsTB += "<td style='border-collapse: collapse; padding: 0px !important; vertical-align: middle; text-align-last: center;'> <div class='checkbox'> " +                                " <label style='margin-bottom: 0; margin-top: 0.5rem;'> <input type='checkbox' id='chk" + lst.Text + "' onclick='' /> <span class='cr'> <i class='cr-icon fa fa-check'></i> </span> </label> </div> </td>";                            colsTB += "<td id='tdSelecionado1' style='border-collapse: collapse; padding-top: 10px; vertical-align: middle; text-align-last: center;'><b>" + lst.Text + "</b></td>";                            //ADD INPUTS                            //O ii É A POSIÇÃO DA LINHA NA HORIZONTAL                            for (var ii = 0; ii < qtdEstagios; ii++) {

                                //document.getElementById("controlador").maxLength = "2";
                                if (i == ii) {

                                    colsTB += "<td id='tdSelecionado1' style='border-collapse: collapse; padding-top: 14px;text-align: center;font-weight: bold;vertical-align: middle;'><label>⨉</label></td>";
                                }
                                else {

                                    colsTB += "<td id='tdSelecionado1' style='border-collapse: collapse; padding-top: 12px;'><input type='number' class='form-control' " +
                                        " id='txtEntreverdes" + lst.Text + data.d[ii].Text + "' onkeyup='validarEntreverdes(this)' min='1' max='99' data-estagio1='" + lst.Text + "' data-estagio2='" + data.d[ii].Text + "' /></td>";
                                }
                            }                            rowTB.append(colsTB);                            $("#tbEstagios").append(rowTB);                            $("#botoes_de_acao").css("display", "block");                            $("#lblListaEstagios").css("display", "block");                        }                        carregarEntreverdes();                        //ADICIONA O BACKGROUND-COLOR POR ONDE O PONTEIRO DO MOUSE PASSA
                        $('#tblEstagios tbody td').on('mouseover', function () {

                            column = $(this).index();

                            $(this).parent().siblings().each(function () {

                                $(this).children().eq(column).addClass('backgroud');
                            });
                        });

                        $('#tblEstagios tbody td').on('mouseout', function () {

                            $(this).parent().siblings().each(function () {

                                $(this).children().removeClass('backgroud');
                            });
                        });                    }
                    else {

                        $("#botoes_de_acao").css("display", "none");                        $("#lblListaEstagios").css("display", "none");
                        $("#divLoading").css("display", "none");

                        Swal.fire({

                            type: 'info',
                            title: getResourceItem("infoTipoAlert'"),
                            text: getResourceItem("naoPossuiEstagioCadastrado"),
                        })
                    }
                }
            });
        }

        function validarEntreverdes(status) {

            var texto = status.value;
            if (texto.length == 3) {

                var resultado = texto.substring(0, 2);
                status.value = resultado;
                return false;
            }
        }

        function salvar() {

            $("#divLoading").css("display", "block");

            var erro = false;
            var table = $("#tblEstagios tbody");
            table.find('tr').each(function (i, el) {
                i = table.find('tr').length;
                var $tds = $(this).find('td')

                if (erro)
                    return;
                //GRID COM DUAS LINHAS ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
                if (i == 2) {

                    txt = $tds[2].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[3].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }
                }

                //GRID COM TRÊS LINHAS ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
                if (i == 3) {

                    txt = $tds[2].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[3].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[4].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }
                }

                //GRID COM QUATRO LINHAS ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
                if (i == 4) {

                    txt = $tds[2].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[3].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[4].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[5].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }
                }

                //GRID COM CINCO LINHAS ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
                if (i == 5) {

                    txt = $tds[2].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[3].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[4].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[5].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[6].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }
                }

                //GRID COM SEIS LINHAS ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
                if (i == 6) {

                    txt = $tds[2].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[3].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[4].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[5].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[6].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[7].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }
                }

                //GRID COM SETE LINHAS ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
                if (i == 7) {

                    txt = $tds[2].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[3].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[4].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[5].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[6].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[7].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[8].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }
                }

                //GRID COM OITO LINHAS ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
                if (i == 8) {

                    txt = $tds[2].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[3].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[4].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[5].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[6].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[7].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[8].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                "'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }

                    txt = $tds[9].firstElementChild;
                    chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                    if (txt.innerText != "⨉") {

                        chkResultado = chk.checked;
                        entreverdes = txt.value;
                        posicao_do_entreverdes = txt.dataset;
                        primeiro_Estagio = posicao_do_entreverdes.estagio1;
                        segundo_Estagio = posicao_do_entreverdes.estagio2;

                        if (entreverdes == "") {
                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("entreverdesEmBranco"),
                            })
                            erro = true;
                            return;
                        }

                        if (parseInt(entreverdes) < 3 || parseInt(entreverdes) > 39) {

                            Swal.fire({
                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("minMaxEntreverdePermitido"),
                            })
                            erro = true;
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: 'Default.aspx/salvar',
                            dataType: 'json',
                            data: "{'estagio1':'" + primeiro_Estagio + "','estagio2':'" + segundo_Estagio + "','entreverdes':'" + entreverdes + "', " +
                                " 'anel':'" + $("#sleAnel").val() + "','demandado':'" + chkResultado + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                $("#divLoading").css("display", "none");
                            },
                            error: function (data) {

                                $("#divLoading").css("display", "none");
                            }
                        });
                    }
                }
            });

            if (erro == true) {

                $("#divLoading").css("display", "none");
                return;
            }

            Swal.fire({
                type: 'success',
                title: getResourceItem("salvoTipoAlert"),
                text: getResourceItem("salvoComSucesso"),
            })

            $("#divLoading").css("display", "none");

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
                    if (globalResources.resource[i].name == name) {
                        return globalResources.resource[i].value;
                    }
                }
            }
        }
    </script>
</asp:Content>
