<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DefaultBeta.aspx.cs" Inherits="GwCentral.Scoot.ConfiguracoesScoot.DefaultBeta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        @media (max-width: 3044px) {
            .proporcaoInput {
                max-width: 36% !important;
                flex: 60% !important;
                padding-right: 15px;
            }
        }

        @media (max-width: 1440px) {
            .proporcaoSelect {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
                padding-right: 15px !important;
            }
        }

        .proporcaoDivBtn {
            padding-top: 15px;
            float: right !important;
            padding-right: 0;
            max-width: 100% !important;
            flex: 60%;
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.configuracoesLacosScoot %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row" style="padding-right: 15px; padding-left: 15px; margin-bottom: 15px">
        <div class="col-6 col-md-4 proporcaoSelect proporcaoInput proporcaoSle" style="float: left; padding-left: 0;">
            <div class="col-md-9 divBtnAddPlano" id="col3" style="padding-left: 0;">
                <label style="margin-bottom: 0;"><%= Resources.Resource.controlador %>: </label>
                <select id="sleControlador" class="form-control proporcaoSle" onchange="carregarLacos()"></select>
            </div>
        </div>

        <div class="col-6 col-md-4 proporcaoDivBtn">
            <div class="proporcaoAddControlador">
                <button type="button" class="btn btn-icon btn-secondary mr-1" onclick="NovoPlano()" style="margin-right: 0 !important;"
                    data-toggle="tooltip" data-placement="left" title="<%= Resources.Resource.adicionar %> <%= Resources.Resource.novo %> <%= Resources.Resource.laco %>">
                    <i class="ft-plus-square"></i>
                </button>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="table-responsive">
            <table class="table table-bordered mb-0" id="tblLacos" style="margin-top: 2rem;">
                <thead>
                    <tr> 
                        <th style="text-align: center; width: 15rem;"><%= Resources.Resource.laco %> (Link)</th>
                        <th style="text-align: center; width: 8rem;"><%= Resources.Resource.tipo %> </th>
                        <th style="text-align: center; width: 15rem;"><%= Resources.Resource.anel %> </th>
                        <th style="text-align: center; width: 15rem;"><%= Resources.Resource.estagio %> <%= Resources.Resource.verde %> </th>
                        <th style="text-align: center; width: 15rem;"><%= Resources.Resource.area %> </th>
                        <th style="text-align: center; width: 15rem;">Link <%= Resources.Resource.anterior %> </th>
                        <th style="text-align: center; width: 15rem;">Link <%= Resources.Resource.posterior %> </th>
                        <th style="text-align: center; width: 15rem;"><%= Resources.Resource.satoPorSoftware %> </th>
                        <th style="text-align: center; width: 15rem;"></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbLacos"></tbody>
            </table>
        </div>
        <div class="form-actions right" style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem;">
            <div style="float: right; margin-top: 1rem;">
                <button type="button" class="btn btn-success btn-min-width mr-1 mb-1" id="btnSalvarLacos" style="margin-bottom: 0 !important;" onclick="salvarLacos()"><%= Resources.Resource.salvar %></button>
            </div>
        </div>

    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            loadResourcesLocales();
            carregarSleControlador();
        });

        function carregarSleControlador() {

            $("#divLoading").css("display", "block");
            $.ajax({
                url: 'DefaultBeta.aspx/loadControladores',
                data: "{}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    $("#sleControlador").empty();
                    $("#sleControlador").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                    $.each(data.d, function () {
                        $("#sleControlador").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });

                    $("#divLoading").css("display", "none");
                }
            });
        }

        function carregarLacos() {

            $("#divLoading").css("display", "block");

            document.getElementById('btnSalvarLacos').disabled = true;

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/carregarLacos',
                dataType: 'json',
                data: "{'controlador':'" + $("#sleControlador").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) { 

                    for (var i = 0; i < data.d.length; i++) {

                        var lst = data.d[i];

                        $("#divLoading").css("display", "none");
                        $("#sleAnelDetector" + lst.detector).val(lst.anel);
                        carregarEstagios($("#sleAnelDetector" + lst.detector)[0], false);
                        $("#sleEstagioDetector" + lst.detector).val(lst.estagio);
                        document.getElementById('btnExcluirDetector' + lst.detector).disabled = true;

                        if ($("#sleEstagioDetector" + lst.detector).val() != "") {

                            document.getElementById('btnExcluirDetector' + lst.detector).disabled = false;
                        }
                    }
                    verificarSelects();
                    $("#divLoading").css("display", "none"); 
                }
            });
        }

        function carregarEstagios(anel,estagio) {
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/carregarEstagios',
                dataType: 'json',
                data: "{'anel':'" + anel + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    for (var i = 1; i <= 16; i++) {

                        $("#sleEstagio" + i).empty();
                        $("#sleEstagio" + i).append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                        $.each(data.d, function () {
                            $("#sleEstagio" + i).append($("<option></option>").val(this['Text']).html(this['Text']));
                        });

                        if (estagio != "")
                            $("#sleEstagio" + i).val(anel);
                    }
                     
                    $("#divLoading").css("display", "none");
                }
            });
        }

        function carregarAnel(anel) {
            $.ajax({
                url: 'DefaultBeta.aspx/carregarAneis',
                data: "{'controlador':'" + $("#sleControlador").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    for (var i = 1; i <= 16; i++) {

                        $("#sleAnel" + i).empty();
                        $("#sleAnel" + i).append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                         $.each(data.d, function () {
                             $("#sleAnel" + i).append($("<option></option>").val(this['Text']).html(this['Text']));
                         });

                        if (anel != "")
                            $("#sleAnel" + i).val(anel);
                     }

                     for (var i = 1; i <= 16; i++) {

                         $("#sleEstagio" + i).empty();
                     } 
                 },
                 error: function (data) { 
                 }
             });
        }

        function carregarEstagios(select, exibirLoad) {

            if (exibirLoad) {

                $("#divLoading").css("display", "block");
            }

            var id = select.id;
            var idFormatado = id.replace("Anel", "Estagio");
            $.ajax({
                url: 'DefaultBeta.aspx/carregarEstagios',
                data: "{'anel':'" + select.value + "'}",
                dataType: "json",
                type: "POST",
                async: false,
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d.length != 0) {

                        $("#" + idFormatado + "").empty();
                        $("#" + idFormatado + "").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));

                        $.each(data.d, function () {
                            $("#" + idFormatado + "").append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }
                    else {
                        $("#" + idFormatado + "").empty();
                    }

                    if (exibirLoad) {

                        $("#divLoading").css("display", "none");
                    }
                }
            });
        }

        //RESOURSE/TRADUÇÃO------------------------------------------------------------------------------------------------------------------------------

        var globalResources;        function loadResourcesLocales() {            $.ajax({                type: "POST",                contentType: "application/json; charset=utf-8",                url: 'DefaultBeta.aspx/requestResource',                dataType: "json",                success: function (data) {                    globalResources = JSON.parse(data.d);                }            });        }        function getResourceItem(name) {            if (globalResources != undefined) {                for (var i = 0; i < globalResources.resource.length; i++) {                    if (globalResources.resource[i].name === name) {                        return globalResources.resource[i].value;                    }                }            }        }
    </script>
</asp:Content>
