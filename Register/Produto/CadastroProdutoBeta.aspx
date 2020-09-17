<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CadastroProdutoBeta.aspx.cs" Inherits="GwCentral.Register.Produto.CadastroProdutoBeta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <style>
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
            margin-left: .5em;
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

        .mt-14rem {
            margin-top: 1.4rem;
        }

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

        /*#region BACKGROUND LINHA TABELA*/
        #tbProdutosCadastrados tr:hover {
            background-color: #e3ebf338;
        }

        #tbControladores_da_Placa tr:hover {
            background-color: #e3ebf338;
        }
        /*#endregion*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    Cadastro de Produto
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <div class="row" id="divPesquisa_Produtos">
            <div class="col-md-3">
                <label class="m-0"
                    for="txtNumSerie_Pesquisa">
                    Número de Série
                </label>
                <div class="position-relative has-icon-right">
                    <input type="text" id="txtNumSerie_Pesquisa"
                        class="form-control" autocomplete="off"
                        onkeyup="pesquisarLinhasTabela('3',this,'tblProdutosCadastrados')" />
                    <div class="form-control-position">
                        <i class="ft-search"></i>
                    </div>
                </div>

            </div>
            <div class="col-md-3">
                <label class="m-0"
                    for="txtNomeProduto_Pesquisa">
                    Nome do Produto
                </label>
                <div class="position-relative has-icon-right">
                    <input type="text" id="txtNomeProduto_Pesquisa"
                        class="form-control" autocomplete="off"
                        onkeyup="pesquisarLinhasTabela('0',this,'tblProdutosCadastrados')" />
                    <div class="form-control-position">
                        <i class="ft-search"></i>
                    </div>
                </div>

            </div>

            <div class="col-md-2">
                <button type="button"
                    id="btnCadastrar_NovoProduto"
                    class="btn btn-success mt-14rem col-12"
                    onclick="cadastrar_NovoProduto()">
                    Cadastrar
                </button>
            </div>
        </div>

        <div class="table-responsive mt-14rem"
            id="divTabela_ProdutosCadastrados">
            <table class="table table-bordered"
                id="tblProdutosCadastrados">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Marca</th>
                        <th>Modelo</th>
                        <th>Número de Série</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbProdutosCadastrados">
                    <tr>
                        <td colspan="6">Não há registros</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <%--CADASTRO--%>
        <div id="divCadastrar_NovoProduto"
            style="display: none;">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="m-0"
                            for="txtNumeroSerie_cadastro">
                            Número de Série
                        </label>
                        <input type="text"
                            id="txtNumeroSerie_cadastro"
                            class="form-control"
                            placeholder="Número de Série"
                            autocomplete="off" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="m-0"
                            for="txtNomeProduto">
                            Nome do Produto
                        </label>
                        <input type="text"
                            id="txtNomeProduto"
                            class="form-control"
                            placeholder="Nome do Produto"
                            autocomplete="off" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="m-0"
                            for="txtMarca">
                            Marca
                        </label>
                        <input type="text"
                            id="txtMarca"
                            class="form-control"
                            placeholder="Marca"
                            autocomplete="off" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="m-0"
                            for="txtModelo">
                            Modelo
                        </label>
                        <input type="text" id="txtModelo"
                            class="form-control"
                            placeholder="Modelo"
                            autocomplete="off" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="m-0"
                            for="sleTipoUnidade">
                            Tipo de Unidade
                        </label>
                        <select id="sleTipoUnidade"
                            class="select2 form-control">
                            <option value="">─ SELECIONE ─</option>
                            <option>UNIDADE</option>
                            <option>KILOGRAMA</option>
                            <option>LITRO</option>
                            <option>GRAMA</option>
                            <option>FARDO</option>
                            <option>METRO</option>
                            <%--<optgroup label="">
                            </optgroup>--%>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="m-0"
                            for="txtVolume">
                            Volume
                        </label>
                        <input type="number" id="txtVolume"
                            class="form-control"
                            min="1" max=""
                            autocomplete="off" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="m-0"
                            for="sleTipoProduto">
                            Tipo do Produto
                        </label>
                        <select id="sleTipoProduto"
                            class="form-control"
                            disabled>
                            <option value="190">SEMAFORICO</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label class="m-0"
                            for="sleCategoria">
                            Categoria
                        </label>
                        <select id="sleCategoria"
                            class="form-control"
                            onchange="selecionar_Controlador()">
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="autocomplete"
                            style="width: 100%;">
                            <label class="m-0"
                                for="txtFabricante">
                                Fabricante
                            </label>
                            <input id="txtFabricante" type="text"
                                name="myCountry" placeholder="Fabricante"
                                class="form-control" data-idfabricante=""
                                autocomplete="off">
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-actions right"
                style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem;">
                <div style="float: right; margin-top: 1rem;">
                    <button type="button" class="btn btn-success"
                        id="btnSalvarProduto"
                        onclick="salvarProduto(this)">
                        Salvar
                    </button>
                    <button type="button" class="btn btn-warning"
                        id="btnCancelarProduto"
                        onclick="cancelarCadastro()">
                        Cancelar
                    </button>
                </div>
            </div>
        </div>

        <div class="table-responsive mt-14rem"
            id="divTbl_Controladores_da_Placa"
            style="display: none;">
            <label class="m-0">Selecione os controladores da placa:</label>
            <table class="table table-bordered"
                id="tblControladores_da_Placa">
                <thead>
                    <tr>
                        <th></th>
                        <th>Nome</th>
                        <th>Marca</th>
                        <th>Modelo</th>
                    </tr>
                </thead>
                <tbody id="tbControladores_da_Placa">
                    <tr>
                        <td colspan="4">Não há registros</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>
        autocomplete(document.getElementById("txtFabricante"));

        $(function () {

            $("#divLoading").css("display", "block");
            loadResourcesLocales();
            carregarProdutosCadastrados();
            carregarSelects();
        });

        function carregarSelects() {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'CadastroProdutoBeta.aspx/carregarCategorias',
                dataType: 'json',
                data: "{}",
                //async: false,
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {

                        $("#sleCategoria").empty();
                        $("#sleCategoria").append("<option value=''>─ SELECIONE ─</option>");
                        var i = 0;
                        while (data.d[i]) {

                            var lst = data.d[i];
                            $("#sleCategoria").append(
                                "<option value=" + lst.id + ">" + lst.categoria + "</option>"
                            );

                            i++;
                        }
                    }
                }
            });
        }

        function cadastrar_NovoProduto() {

            $("#txtNumeroSerie_cadastro").prop("disabled", false);
            $("#txtNomeProduto").prop("disabled", false);
            $("#txtMarca").prop("disabled", false);
            $("#txtModelo").prop("disabled", false);
            $("#sleTipoUnidade").prop("disabled", false);
            $("#txtVolume").prop("disabled", false);
            $("#sleTipoProduto").prop("disabled", true);
            $("#sleCategoria").prop("disabled", false);
            $("#txtFabricante").prop("disabled", false);

            $("#txtNumeroSerie_cadastro").val("");
            $("#txtNomeProduto").val("");
            $("#txtMarca").val("");
            $("#txtModelo").val("");
            $("#sleTipoUnidade").val("");
            $("#txtVolume").val("");
            $("#sleTipoProduto").val("190");
            $("#txtFabricante").val("");
            carregarSelects();
            carregarProdutosCadastrados();

            $("#divPesquisa_Produtos").css("display", "none");
            $("#divTabela_ProdutosCadastrados").css("display", "none");
            $("#btnSalvarProduto").html("Salvar");
            $("#divCadastrar_NovoProduto").css("display", "block");
        }

        function cancelarCadastro() {

            $("#txtNumeroSerie_cadastro").val("");
            $("#txtNomeProduto").val("");
            $("#txtMarca").val("");
            $("#txtModelo").val("");
            $("#sleTipoUnidade").val("");
            $("#txtVolume").val("");
            $("#sleTipoProduto").val("190");
            $("#txtFabricante").val("");
            carregarSelects();
            carregarProdutosCadastrados();
            $("#txtNumSerie_Pesquisa").val("");
            $("#txtNomeProduto_Pesquisa").val("");
            $("#divTbl_Controladores_da_Placa").css("display", "none");
            $("#divCadastrar_NovoProduto").css("display", "none");
            $("#divPesquisa_Produtos").css("display", "flex");
            $("#divTabela_ProdutosCadastrados").css("display", "table");
        }

        function selecionar_Controlador(valor) {

            $("#divLoading").css("display", "block");

            var idProdutoCadastrado = "";
            if ($("#sleCategoria option:selected").text() == "PLACA") {

                if (valor == undefined) {
                    idProdutoCadastrado = "";
                }
                else {
                    idProdutoCadastrado = valor.dataset.id;
                }

                $.ajax({
                    type: 'POST',
                    url: 'CadastroProdutoBeta.aspx/carregarControladores',
                    dataType: 'json',
                    data: "{'idProdutoCadastrado':'" + idProdutoCadastrado + "'}",
                    //async: false,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        if (data.d == "") {

                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("naoExisteControladorCadastrado"),
                            })
                            return;
                        }
                        else {

                            $("#tbControladores_da_Placa").empty();

                            var i = 0;
                            while (data.d[i]) {

                                var lst = data.d[i];
                                var newRow = $("<tr>");
                                var cols = "";

                                if (lst.check == true) {
                                    cols += "<td style='width: 1px;'><div class='checkbox'> " +                                        " <label style='margin-bottom: 0; margin-top: 0.5rem;'> " +
                                        " <input type='checkbox' checked " +
                                        " id='" + lst.checkbox + "' /> " +
                                        " <span class='cr'> " +
                                        " <i class='cr-icon fa fa-check'></i> " +
                                        " </span></label></div></td>";
                                }
                                else {
                                    cols += "<td style='width: 1px;'><div class='checkbox'> " +                                        " <label style='margin-bottom: 0; margin-top: 0.5rem;'> " +
                                        " <input type='checkbox' id='" + lst.checkbox + "' /> " +
                                        " <span class='cr'> " +
                                        " <i class='cr-icon fa fa-check'></i> " +
                                        " </span></label></div></td>";
                                }

                                cols += "<td style='padding-top: 18px;'>" + lst.nome + "</td>";
                                cols += "<td style='padding-top: 18px;'>" + lst.marca + "</td>";
                                cols += "<td style='padding-top: 18px;'>" + lst.modelo + "</td>";

                                newRow.append(cols);
                                $("#tbControladores_da_Placa").append(newRow);
                                i++;
                            }
                        }

                        $("#divLoading").css("display", "none");
                        $("#divTbl_Controladores_da_Placa").css("display", "table");
                    },
                    error: function (data) {

                        $("#divLoading").css("display", "none");
                    }
                });
            }
            else {

                $("#divTbl_Controladores_da_Placa").css("display", "none");
                $("#divLoading").css("display", "none");
            }
        }

        function salvarProduto(valor) {

            $("#divLoading").css("display", "block");

            if ($("#txtFabricante").val() == "") {

                $("#txtFabricante")[0].dataset.idfabricante = "0";
            }

            if ($("#btnSalvarProduto").html() == "Salvar") {

                $.ajax({
                    type: 'POST',
                    url: 'CadastroProdutoBeta.aspx/salvarProduto',
                    dataType: 'json',
                    data: "{'numeroSerie':'" + $("#txtNumeroSerie_cadastro").val() + "', " +
                        " 'nomeProduto':'" + $("#txtNomeProduto").val() + "', " +
                        " 'marca':'" + $("#txtMarca").val() + "', " +
                        " 'modelo':'" + $("#txtModelo").val() + "', " +
                        " 'tipoUnidade':'" + $("#sleTipoUnidade").val() + "', " +
                        " 'volume':'" + $("#txtVolume").val() + "', " +
                        " 'IdTipoProduto':'" + $("#sleTipoProduto").val() + "', " +
                        " 'IdCategoria':'" + $("#sleCategoria").val() + "', " +
                        " 'IdFabricante':'" + $("#txtFabricante")[0].dataset.idfabricante + "', " +
                        " 'nomeFabricante':'" + $("#txtFabricante").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        if (data.d == "numeroSerie_repetido") {

                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("numeroSerieEmUso"),
                            })

                            $("#txtNumeroSerie_cadastro").addClass("is-invalid");
                            $("#divLoading").css("display", "none");
                            return;
                        }
                        else {

                            $("#txtNumeroSerie_cadastro").removeClass("is-invalid");
                            //221 = PLACA
                            if ($("#sleCategoria").val() == "221") {

                                salvarControladoresPlaca(data.d);
                            }
                        }

                        $("#txtNumeroSerie_cadastro").val("");
                        $("#txtNomeProduto").val("");
                        $("#txtMarca").val("");
                        $("#txtModelo").val("");
                        $("#sleTipoUnidade").val("");
                        $("#txtVolume").val("");
                        carregarSelects();
                        carregarProdutosCadastrados();
                        $("#txtNumSerie_Pesquisa").val("");
                        $("#txtNomeProduto_Pesquisa").val("");
                        $("#divTbl_Controladores_da_Placa").css("display", "none");
                        $("#divCadastrar_NovoProduto").css("display", "none");
                        $("#divPesquisa_Produtos").css("display", "flex");
                        $("#divTabela_ProdutosCadastrados").css("display", "table");


                        Swal.fire({
                            type: 'success',
                            title: getResourceItem("salvoTipoAlert"),
                            text: getResourceItem("salvoComSucesso"),
                        })

                        $("#divLoading").css("display", "none");
                    },
                    error: function (data) {

                        $("#divLoading").css("display", "none");
                    }
                });
            }
            else {

                $.ajax({
                    type: 'POST',
                    url: 'CadastroProdutoBeta.aspx/alterarProduto',
                    dataType: 'json',
                    data: "{'numeroSerie':'" + $("#txtNumeroSerie_cadastro").val() + "', " +
                        " 'nomeProduto':'" + $("#txtNomeProduto").val() + "', " +
                        " 'marca':'" + $("#txtMarca").val() + "', " +
                        " 'modelo':'" + $("#txtModelo").val() + "', " +
                        " 'tipoUnidade':'" + $("#sleTipoUnidade").val() + "', " +
                        " 'volume':'" + $("#txtVolume").val() + "', " +
                        " 'IdTipoProduto':'" + $("#sleTipoProduto").val() + "', " +
                        " 'IdCategoria':'" + $("#sleCategoria").val() + "', " +
                        " 'IdFabricante':'" + $("#txtFabricante")[0].dataset.idfabricante + "', " +
                        " 'idProdutoAlterado':'" + valor.value + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        if (data.d == "numeroSerie_repetido") {

                            Swal.fire({

                                type: 'error',
                                title: getResourceItem("erroTipoAlert"),
                                text: getResourceItem("numeroSerieEmUso"),
                            })

                            $("#txtNumeroSerie_cadastro").addClass("is-invalid");
                            $("#divLoading").css("display", "none");
                            return;
                        }
                        else {

                            $("#txtNumeroSerie_cadastro").removeClass("is-invalid");
                            //221 = PLACA
                            if ($("#sleCategoria").val() == "221") {

                                salvarControladoresPlaca(valor.value);
                            }
                        }

                        $("#txtNumeroSerie_cadastro").val("");
                        $("#txtNomeProduto").val("");
                        $("#txtMarca").val("");
                        $("#txtModelo").val("");
                        $("#sleTipoUnidade").val("");
                        $("#txtVolume").val("");
                        carregarSelects();
                        carregarProdutosCadastrados();
                        $("#txtNumSerie_Pesquisa").val("");
                        $("#txtNomeProduto_Pesquisa").val("");
                        $("#divTbl_Controladores_da_Placa").css("display", "none");
                        $("#divCadastrar_NovoProduto").css("display", "none");
                        $("#divPesquisa_Produtos").css("display", "flex");
                        $("#divTabela_ProdutosCadastrados").css("display", "table");


                        Swal.fire({
                            type: 'success',
                            title: getResourceItem("salvoTipoAlert"),
                            text: getResourceItem("salvoComSucesso"),
                        })

                        $("#divLoading").css("display", "none");
                    },
                    error: function (data) {

                        $("#divLoading").css("display", "none");
                    }
                });
            }
        }

        function salvarControladoresPlaca(valor) {

            var table = $("#tblControladores_da_Placa tbody");
            table.find('tr').each(function (i, el) {
                i = table.find('tr').length;
                var $tds = $(this).find('td')

                chk = $tds[0].firstElementChild.firstElementChild.firstElementChild;
                if (chk.checked == true) {

                    var idControladorSelecionado = chk.id;
                    var idProdutoCadastrado = valor;

                    $.ajax({
                        type: 'POST',
                        url: 'CadastroProdutoBeta.aspx/salvarControladorSelecionado',
                        dataType: 'json',
                        data: "{'idControladorSelecionado':'" + idControladorSelecionado + "', " +
                            " 'idProdutoCadastrado':'" + idProdutoCadastrado + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            $("#divLoading").css("display", "none");
                        },
                        error: function (data) {

                            $("#divLoading").css("display", "none");
                        }
                    });
                }
            });
        }

        function carregarProdutosCadastrados() {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'CadastroProdutoBeta.aspx/carregarProdutosCadastrados',
                dataType: 'json',
                data: "{}",
                //async: false,
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d == "") {

                        Swal.fire({

                            type: 'error',
                            title: getResourceItem("erroTipoAlert"),
                            text: getResourceItem("naoExisteControladorCadastrado"),
                        })
                    }
                    else {

                        $("#tbProdutosCadastrados").empty();

                        var i = 0;
                        while (data.d[i]) {

                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='padding-top: 18px;'>" + lst.nomeProduto + "</td>";
                            cols += "<td style='padding-top: 18px;'>" + lst.marca + "</td>";
                            cols += "<td style='padding-top: 18px;'>" + lst.modelo + "</td>";
                            cols += "<td style='padding-top: 18px;'>" + lst.numeroSerie + "</td>";

                            cols += "<td style='padding: 5px; width: 1px;'> " +
                                " <button type='button' class='btn btn-icon btn-info' " +
                                " onclick='editarProdutoCadastrado(this)' " +
                                " data-id='" + lst.id + "' " +
                                " data-nomeproduto='" + lst.nomeProduto + "' " +
                                " data-numeroserie='" + lst.numeroSerie + "' " +
                                " data-tipounidade='" + lst.tipoUnidade + "' " +
                                " data-marca='" + lst.marca + "' " +
                                " data-modelo='" + lst.modelo + "' " +
                                " data-volume='" + lst.volume + "' " +
                                " data-tipoproduto='" + lst.tipoProduto + "' " +
                                " data-categoria='" + lst.categoria + "' " +
                                " data-fabricante='" + lst.fabricante + "' " +
                                " data-idfabricante='" + lst.idFabricante + "'> " +
                                " <i class='ft-edit-3'> " +
                                " </i></button></td>";

                            cols += "<td style='padding: 5px; width: 1px;'> " +
                                " <button type='button' class='btn btn-icon btn-danger' " +
                                " onclick='excluirProdutoCadastrado(this)' " +
                                " data-id='" + lst.id + "' " +
                                " data-categoria='" + lst.categoria + "'> " +
                                " <i class='ft-trash-2'> " +
                                " </i></button></td>";

                            newRow.append(cols);
                            $("#tbProdutosCadastrados").append(newRow);
                            i++;
                        }
                    }

                    $("#divLoading").css("display", "none");
                }
            });
        }

        function excluirProdutoCadastrado(valor) {

            var id = valor.dataset.id;
            var categoria = valor.dataset.categoria;

            Swal.fire({
                title: getResourceItem("confirmarExclusaoTipoAlert"),
                text: getResourceItem("produtoExcluido"),
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("simExcluir")
            }).then((result) => {

                if (result.value) {

                    $.ajax({
                        type: "POST",
                        url: 'CadastroProdutoBeta.aspx/excluirProdutoCadastrado',
                        data: "{'idProduto':'" + id + "'," +
                            "'categoria':'" + categoria + "'}",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            carregarProdutosCadastrados();
                            $("#txtNumSerie_Pesquisa").val("");
                            $("#txtNomeProduto_Pesquisa").val("");

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("excluido"),
                                text: getResourceItem("excluidoSucesso"),
                            });
                        }
                    });
                }
            });
        }

        function editarProdutoCadastrado(valor) {

            $("#btnSalvarProduto").html("Salvar Alterações");
            $("#btnSalvarProduto").val($(valor).data("id"));

            $("#sleCategoria").val($(valor).data("categoria"));
            //221 = PLACA && 222 = CONTROLADOR
            if ($("#sleCategoria").val() == "221" || $("#sleCategoria").val() == "222") {

                $("#sleCategoria").prop("disabled", true);

                if ($("#sleCategoria").val() == "221") {

                    $("#divTbl_Controladores_da_Placa").css("display", "table");
                    selecionar_Controlador(valor);
                }

                if ($("#sleCategoria").val() == "222") {

                    $("#divTbl_Controladores_da_Placa").css("display", "none");
                }
            }
            else {

                $("#sleCategoria").prop("disabled", false);
                $("#divTbl_Controladores_da_Placa").css("display", "none");
            }

            $("#txtNumeroSerie_cadastro").val($(valor).data("numeroserie"));
            $("#txtNomeProduto").val($(valor).data("nomeproduto"));
            $("#txtMarca").val($(valor).data("marca"));
            $("#txtModelo").val($(valor).data("modelo"));
            $("#sleTipoUnidade").val($(valor).data("tipounidade"));
            $("#txtVolume").val($(valor).data("volume"));
            $("#sleTipoProduto").val($(valor).data("tipoproduto"));
            $("#txtFabricante")[0].dataset.idfabricante = valor.dataset.idfabricante;
            $("#txtFabricante").val($(valor).data("fabricante"));

            $("#divPesquisa_Produtos").css("display", "none");
            $("#divTabela_ProdutosCadastrados").css("display", "none");
            $("#divCadastrar_NovoProduto").css("display", "block");
            //$("#divTbl_Controladores_da_Placa").css("display", "block");
        }

        function pesquisarLinhasTabela(position, element, tabela) {

            var input, filter, table, tr, td, i;
            input = document.getElementById(element.id);
            filter = input.value.toUpperCase();
            table = document.getElementById(tabela);
            tr = table.getElementsByTagName("tr");

            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[parseInt(position)];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
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

        //#region TRADUÇÃO ---------------------------------------------------------------------------------
        var globalResources;
        function loadResourcesLocales() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: 'CadastroProdutoBeta.aspx/requestResource',
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
        //#endregion
    </script>
</asp:Content>
