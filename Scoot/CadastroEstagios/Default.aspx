<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Scoot.CadastroEstagios.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
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

        @media (max-width: 1023px) {
            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
            }

            .pesquisa {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.estagios %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfUser" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfQtdMaxEstagios" ClientIDMode="Static" runat="server" />

    <div id="dvPesquisa" style="display: none;">
        <div class="btn-group pesquisa" style="margin-bottom: 10px;">
            <span style="margin-top: 10px; margin-right: 10px;"><%= Resources.Resource.anel %>:</span>
            <select class="form-control" style="border-top-right-radius: 0; border-bottom-right-radius: 0;" id="sleAnelPesq" onchange="getPlanos()"></select>
            <input type="button" id="btnNovo" value="<%= Resources.Resource.novo %>" class="btn btn-success" onclick="Novo()" />
        </div>

        <div class="table-responsive">
            <table class="table table-bordered mb-0" id="tblPlano">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.plano %></th>
                        <th><%= Resources.Resource.qtdEstagios %></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbPlano"></tbody>
            </table>
        </div>
    </div>
    <div id="dvCadastro"> 
        <table style="width: 100%; margin-bottom: 10px">
            <tr>
                <td>
                    <%= Resources.Resource.anel %>:
                <select id="sleAnel" class="form-control"  onchange="getEstagios()"></select>
                </td>
                <td id="tdAddEstagios">
                    <%= Resources.Resource.adicionar %> <%= Resources.Resource.estagio %>:
                    <select id="sleEstagio" class="form-control" onchange="AdicionarEstagio()">
                        <option value=""><%= Resources.Resource.selecione %></option>
                        <option value="1">A</option>
                        <option value="2">B</option>
                        <option value="4">C</option>
                        <option value="8">D</option>
                        <option value="10">E</option>
                        <option value="20">F</option>
                        <option value="40">G</option>
                        <option value="80">H</option>
                    </select>
                </td>
            </tr>
        </table>
        <div class="table-responsive" style="margin-bottom: 20px">
            <table class="table table-bordered mb-0" id="tblEstagios">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.estagio %></th>
                        <th><%= Resources.Resource.verdeSeguranca %></th>
                        <th><%= Resources.Resource.verdeMaximo %></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbEstagios"></tbody>
            </table>
        </div>
        <input type="button" class="btn btn-success" value="<%= Resources.Resource.salvar %>" onclick="Salvar()" />
        <input type="button" class="btn btn-warning" style="display:none;" value="<%= Resources.Resource.cancelar %>" onclick="Cancelar()" />
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        var globalResources;        function loadResourcesLocales() {            $.ajax({                type: "POST",                contentType: "application/json; charset=utf-8",                url: 'Default.aspx/requestResource',                async:false,                dataType: "json",                success: function (data) {                    globalResources = JSON.parse(data.d);                }            });        }        function getResourceItem(name) {            if (globalResources != undefined) {                for (var i = 0; i < globalResources.resource.length; i++) {                    if (globalResources.resource[i].name === name) {                        return globalResources.resource[i].value;                    }                }            }        }

        $(function () {
            loadResourcesLocales();
            loadAneis(); 
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
                        $("#sleAnel").append($("<option data-qtdestagios='" + this['Value']+"'></option>").val(this['Text']).html(this['Text'] + ' - ' + getResourceItem("qtdMaxEstagios") +': '+ this['Value']));
                    });

                    $("#sleAnelPesq").empty();
                    $("#sleAnelPesq").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                    $.each(data.d, function () {
                        $("#sleAnelPesq").append($("<option data-qtdestagios='" + this['Value'] +"'></option>").val(this['Text']).html(this['Text'] + ' - ' + getResourceItem("qtdMaxEstagios") + ': ' + this['Value']));
                    });
                }
            });
        }


        function Salvar() {
            $("#divLoading").css("display", "block");

            var table = $("#tblEstagios tbody");
            table.find('tr').each(function (i, el) {
                var $tds = $(this).find('td'),
                    estagio = $tds[0].innerHTML,
                    verdeSeguranca = $tds[1].firstChild.value,
                    verdeMax = $tds[2].firstChild.value,
                    id = $tds[0].dataset.id;

                if (verdeSeguranca == "" || verdeSeguranca == "0") {
                    $tds[1].firstChild.focus();
                    Swal.fire({
                        type: 'error',
                        title: getResourceItem("erro"),
                        text: getResourceItem("informe") + ' ' + getResourceItem("verdeSeguranca"),
                    });

                    $("#divLoading").css("display", "none");
                    return false;
                }

                if (verdeMax == "" || verdeMax == "0") {
                    $tds[2].firstChild.focus();
                    Swal.fire({
                        type: 'error',
                        title: getResourceItem("erro"),
                        text: getResourceItem("informe") + ' ' + getResourceItem("verdeMaximo"),
                    });
                    $("#divLoading").css("display", "none");
                    return false;
                }

                if (Number.parseInt(verdeSeguranca) > Number.parseInt(verdeMax)) {
                    $tds[2].firstChild.focus();
                    Swal.fire({
                        type: 'error',
                        title: getResourceItem("erro"),
                        text: getResourceItem("erroVerdeMaximoMenorVerdeSeguranca"),
                    });
                    $("#divLoading").css("display", "none");
                    return false;
                }
                $.ajax({
                    url: 'Default.aspx/SalvarEstagios',
                    data: "{'estagio':'" + estagio + "','verdeSeguranca':'" + verdeSeguranca + "','verdeMax':'" + verdeMax + "','anel':'" + $("#sleAnel").val() + "','user':'" + $("#hfUser").val() + "','id':'"+id+"'}",
                    dataType: "json", 
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        
                    }
                });
                Swal.fire({
                    type: 'success',
                    title: 'Salvo!',
                    text: getResourceItem("salvoComSucesso"),
                });
                 
                $("#divLoading").css("display", "none");
            });
        }

        function Novo() {
            $("#dvPesquisa").css("display", "none");
            $("#dvCadastro").css("display", "");
            $("#sleEstagio").val("");
            $("#sleAnel").val("");
            $("#sleAnel")[0].disabled = false;
            $("#btnSalvar").val("<%= Resources.Resource.salvarAlteracoes %>");
            $("#lblPlano")[0].innerHTML = "--";
            $("#tbEstagios").empty();

            var newRow = $("<tr>");
            var cols = "<td colspan='6' style='border-collapse: collapse; padding: 5px;'> " + getResourceItem("naoHaRegistros") + " </td>";
            newRow.append(cols);
            $("#tbEstagios").append(newRow);
        }

        function ExcluirPlano(btn) {
            var plano = btn.dataset.plano;
            $.ajax({
                url: 'Default.aspx/ExcluirPlano',
                data: "{'anel':'" + $("#sleAnelPesq").val() + "','plano':'" + plano + "','user':'" + $("#hfUser").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    Swal.fire({
                        type: 'success',
                        title: getResourceItem("excluido"),
                        text: getResourceItem("excluidoSucesso"),
                    });
                    getPlanos();
                }
            });
        }

        function EditarPlano(btn) {
            $("#dvPesquisa").css("display", "none");
            $("#dvCadastro").css("display", "");
            $("#sleAnel").val($("#sleAnelPesq").val());
            $("#btnSalvar").val("<%= Resources.Resource.salvar %>"); 
            $("#sleAnel")[0].disabled = true;
            getEstagios();
        }

        function getEstagios() {

            $("#divLoading").css("display", "block");
            $("#tbEstagios").empty();
            var posicao = $("#sleAnel")[0].selectedIndex;
            $("#hfQtdMaxEstagios").val($("#sleAnel")[0].options[posicao].dataset.qtdestagios);
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/GetEstagios',
                dataType: 'json',
                data: "{'anel':'" + $("#sleAnel").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbEstagios").empty();
                    if (data.d.length >= parseInt($("#hfQtdMaxEstagios").val())) {
                        $("#tdAddEstagios").css("display", "none");
                    } else
                        $("#tdAddEstagios").css("display", "");

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td data-id='"+lst.id+"'>" + lst.estagio + "</td>";
                            cols += "<td style='width:18%;'><input id='txtVerdeSeg" + lst.id + "' type='number' value='" + lst.verdeSeguranca + "' class='form-control'/></td>";
                            cols += "<td style='width:18%;'><input id='txtVerdeMax" + lst.id + "' type='number' value='" + lst.verdeMax + "' class='form-control'/></td>";
                            cols += "<td style='width:15%'><div class='btn-group mr-1 mb-1'><button type='button' style=''  class='btn btn-danger btn-min-width dropdown-toggle' data-toggle='dropdown'>" +
                                "<%= Resources.Resource.excluir %> </button> <div class='dropdown-menu' x-placement='bottom-start' style='position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 40px, 0px); '>" +
                                "<a href=\"#\" class='dropdown-item' onclick='ExcluirEstagio(this)'  data-id='" + lst.id + "' data-estagio='" + lst.estagio +"'><%= Resources.Resource.sim %></a></div></div></td>";

                            newRow.append(cols);
                            $("#tbEstagios").append(newRow);
                        }
                    }
                    else {

                        var newRow = $("<tr>");
                        var cols = "<td colspan='6' style='border-collapse: collapse; padding: 5px;'> " + getResourceItem("naoHaRegistros") + " </td>";
                        newRow.append(cols);
                        $("#tbEstagios").append(newRow);
                    }
                    $("#divLoading").css("display", "none");
                }
            });
        }

        function Cancelar() {
            $("#dvPesquisa").css("display", "");
            $("#dvCadastro").css("display", "none");

            $("#sleAnel").css("border-color", "");
            $("#sleAnel").css("box-shadow", "");
            $("#sleAnel").css("outline", "0");

            $("#sleAnelPesq").val("");

            $("#tbPlano").empty();
            var newRow = $("<tr>");
            var cols = "<td colspan='4' style='border-collapse: collapse; padding: 5px;'> " + getResourceItem("naoHaRegistros") + " </td>";
            newRow.append(cols);
            $("#tbPlano").append(newRow);
        }

        function AdicionarEstagio() {
            if ($("#sleAnel").val() == "") {
                $("#sleAnel").css("border-color", "#ff0000");
                $("#sleAnel").css("outline", "0");
                $("#sleAnel").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#sleAnel").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#sleAnel")[0].focus();
                $("#sleEstagio ").val("");
                return;
            }

            $("#sleAnel").css("border-color", "");
            $("#sleAnel").css("box-shadow", "");
            $("#sleAnel").css("outline", "0");

            $("#divLoading").css("display", "block");
            $.ajax({
                url: 'Default.aspx/AdicionarEstagio',
                data: "{'estagio':'" + $("#sleEstagio ").val() + "','anel':'" + $("#sleAnel").val() + "','user':'" + $("#hfUser").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "SUCESSO") {
                        Swal.fire({
                            type: 'error',
                            title: getResourceItem("erro"),
                            text: data.d,
                        });
                        $("#divLoading").css("display", "none");
                        return;
                    }

                   /* Swal.fire({
                        type: 'success',
                        title: 'Salvo!',
                        text: getResourceItem("salvoComSucesso"),
                    });*/
                    getEstagios();
                    $("#divLoading").css("display", "none");
                }
            });
        }

        function ExcluirEstagio(btn) {
            $("#divLoading").css("display", "block");
            $.ajax({
                url: 'Default.aspx/ExcluirEstagio',
                data: "{'id':'" + btn.dataset.id + "','anel':'" + $("#sleAnel").val() + "','estagio':'" + btn.dataset.estagio + "','user':'" + $("#hfUser").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    Swal.fire({
                        type: 'success',
                        title: getResourceItem("excluido"),
                        text: getResourceItem("excluidoSucesso"),
                    });
                    getEstagios();
                    $("#divLoading").css("display", "none");
                }
            });
        }
    </script>
</asp:Content>
