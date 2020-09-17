<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GruposSemaforicos.aspx.cs" Inherits="GwCentral.Controlador.GruposSemaforicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.listaGrupoSemaforico %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="index.html">Início</a>
        </li>
        <li class="breadcrumb-item"><a href="#">Lista de Grupos Semafóricos</a>
        </li>
    </ol>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hfIdEqp" ClientIDMode="Static" runat="server" />

    <div class="">

        <form class="form form-horizontal">
            <div class="form-body" id="divDetalhesDna">
                <h5 class="form-section" style="border-bottom: 1px solid #e9ecef;"><i class="ft-map-pin"></i>
                    <%= Resources.Resource.controlador %> -
                    <label id="lblEqp">1234 - Av. Parana, 234</label></h5>

                <div id="divListaGrupos" class="table-responsive">
                    <table class="table table-bordered mb-0">
                        <thead>
                            <tr>
                                <th><%= Resources.Resource.grupo %></th>
                                <th><%= Resources.Resource.tipo %></th>
                                <th><%= Resources.Resource.endereco %></th>
                            </tr>
                        </thead>
                        <tbody id="tbListaGrupos"></tbody>
                    </table>
                </div>
            </div>
        </form>

    </div>
    

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>

        var globalResources;
        function loadResourcesLocales() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: 'GruposSemaforicos.aspx/requestResource',
                async: false,
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
        $(function () {
            loadResourcesLocales();
            $("#lblEqp")[0].innerText = $("#hfIdEqp").val();
            ListaGrupos();
        });
        function ListaGrupos() {
            $.ajax({
                type: 'POST',
                url: 'GruposSemaforicos.aspx/GetListaGrupos',
                dataType: 'json',
                data: "{'idEqp':'" + $("#hfIdEqp").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbListaGrupos").empty();
                    if (data.d != "") {
                        $.each(data.d, function (index, item) {
                            var tipo = item.Tipo.indexOf("VEICULAR") != -1 ? getResourceItem("veicular").toUpperCase() : getResourceItem("pedestre").toUpperCase();

                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='width:88px;'>" + item.Grupo.replace("Anel", getResourceItem("anel")) + "</td>";
                            cols += "<td style='width:88px;'>" + tipo + "</td>";
                            cols += "<td>" + item.Endereco + "</td>";
                            newRow.append(cols);
                            $("#tbListaGrupos").append(newRow);
                        });
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='3'>" + getResourceItem("naoHaRegistros") + "</td >";
                        newRow.append(cols);
                        $("#tbListaGrupos").append(newRow);
                    }
                },
                error: function (data) {

                }
            });
        }

</script>
</asp:Content>
