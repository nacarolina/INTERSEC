<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Relatorios.Logs.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <%--<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />--%>

    <style>
        /*table {
            border-collapse: collapse;
            table-layout: fixed;
            width: 800px;
        }

            table td {
                border: solid 1px #fab;
                width: 100px;
                word-wrap: break-word;
            }*/

        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            /* prevent horizontal scrollbar */
            overflow-x: hidden;
            width: 350px;
            margin-top: 236px;
            margin-left: 148px;
        }

        * html .ui-autocomplete {
            height: 100px;
        }
        /*RADIO*/
        input[type=radio].permissoes {
            display: block;
            margin: 0em;
            cursor: pointer;
            padding: 0.2em;
            opacity: 0;
            height: 21px;
            width: 22px;
            position: absolute;
        }

            input[type=radio].permissoes + label:before {
                content: "\2714";
                border: 0.1em solid #464953;
                border-radius: 1.2em;
                display: inline-block;
                width: 20px;
                height: 20px;
                font-size: small;
                margin-right: 0.2em;
                vertical-align: bottom;
                color: transparent;
                text-align-last: center;
                content: "●";
            }


            input[type=radio].permissoes:checked + label:before {
                background-color: #5c5c5d;
                border-color: #5c5c5d;
                color: #fff;
                border-top: transparent;
            }

            input[type=radio].permissoes:disabled + label:before {
                transform: scale(1);
                border-color: #aaa;
            }

            input[type=radio].permissoes:checked:disabled + label:before {
                transform: scale(1);
                background-color: #bfb;
                border-color: #bfb;
            }

        @media (max-width: 1440px) {
            .divMes {
                border-left: hidden !important;
                margin-top: 8px;
                min-width: -webkit-fill-available;
            }

            .divPeriodo {
                border-left: hidden !important;
            }

            .divData {
                border-left: hidden !important;
            }

            #txtDt {
                margin-top: 10px;
            }

            #lblDtFinal {
                margin-bottom: 0.5rem;
                margin-left: 0 !important;
                margin-top: 5px;
            }

            #lblDtInicial {
                margin-top: 10px;
            }
        }

        @media (max-width: 3044px) {
            #lblDtFinal {
                margin-left: 16px;
            }

            .proporcaoRow {
                display: flex !important;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.relatorios %> Logs
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <%= Resources.Resource.relatorios %> - Logs
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfIdPrefeitura" ClientIDMode="Static" runat="server" />
    <div class="container" id="divmsg">
        <%--<div class="alert alert-success">
            <strong>Success!</strong> This alert box could indicate a successful or positive action.
        </div>--%>
        <div class="alert alert-info" id="msnInfo">
            <strong>Sua pesquisa não retornou resultados!</strong>
        </div>
        <%-- <div class="alert alert-warning">
            <strong>Warning!</strong> This alert box could indicate a warning that might need attention.
        </div>--%>
        <div class="alert alert-danger" id="msgDanger">
            <strong>Atenção!</strong> Selecione um tipo de filtro para a pesquisa.
        </div>
    </div>

    <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
        <div class="card box-shadow-0" data-appear="appear">
            <div class="card-header white bg-info">
                <h4 class="card-title white"><%= Resources.Resource.pesquisar %>&nbsp;</h4>
                <a class="heading-elements-toggle"><i class="la la-ellipsis font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                        <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                        <%--<li><a onclick="GetControladores()"><i class="ft-rotate-cw"></i></a></li>--%>
                        <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                    </ul>
                </div>
            </div>
            <div class="card-content collapse show">
                <div class="card-body border-bottom-info" <%--style="border-bottom: 2px solid #f2f222 !important;"--%>>
                    <div class="row proporcaoRow" style="align-items: center; margin-bottom: 15px;">
                        <div class="col-md-6 col-sm-12" style="max-width: fit-content;">
                            <fieldset>
                                <input type="radio" class="permissoes" id="rdbMensal" value="Mensal" name="TipoData" checked="checked" onclick="dataHora(this);" />
                                <label for="rdbMensal"><%= Resources.Resource.mensal %></label>
                            </fieldset>
                        </div>

                        <div class="col-md-6 col-sm-12" style="max-width: fit-content;">
                            <fieldset>
                                <input type="radio" class="permissoes" id="rdbPeriodo" value="Periodo" name="TipoData" onclick="dataHora(this);" />
                                <label for="rdbPeriodo"><%= Resources.Resource.periodo %></label>
                            </fieldset>
                        </div>

                        <div class="col-md-6 col-sm-12" style="max-width: fit-content;">
                            <fieldset>
                                <input type="radio" class="permissoes" id="rdbEspecifico" value="Data" name="TipoData" onclick="dataHora(this);" />
                                <label for="rdbEspecifico"><%= Resources.Resource.data %></label>
                            </fieldset>
                        </div>
                        <div class="col-md-6 col-sm-12 divMes" id="dvMensal" style="margin-bottom: 6px; display: block; border-left: outset;">
                            <fieldset>
                                <label><%= Resources.Resource.mes %> :&nbsp;</label>
                                <input type="month" id="txtMes" class="form-control" style="width: 220px; display: inline;" />
                            </fieldset>
                        </div>

                        <div class="col-md-6 col-sm-12 divPeriodo" id="dvPeriodo" style="display: none; margin-bottom: 6px; border-left: outset; flex: 0 0 60%; max-width: 60%;">
                            <fieldset>
                                <label id="lblDtInicial"><%= Resources.Resource.dataInicial %>:&nbsp; </label>
                                <input type="date" id="txtDtIni" class="form-control" style="display: inline; width: 220px;" />
                                <label id="lblDtFinal"><%= Resources.Resource.dataFinal %>:&nbsp; </label>
                                <input type="date" id="txtDtFim" class="form-control" style="display: inline; width: 220px;" />
                            </fieldset>
                        </div>

                        <div class="col-md-6 col-sm-12 divData" id="dvData" style="display: none; margin-bottom: 6px; border-left: outset;">
                            <fieldset>
                                <%= Resources.Resource.data %>:&nbsp;<input type="date" id="txtDt" class="form-control" style="display: inline; width: 220px;" />
                            </fieldset>
                        </div>
                    </div>
                    <div id="dvTelaUser" style="padding: 0px;" class="row">
                        <div class="col-md-6 col-sm-12 "style="padding-top: 10px;">
                            <%= Resources.Resource.usuario %>
                            <input id="txtUser" type="text" class="form-control" style="" />
                        </div>
                        <div class="col-md-6 col-sm-12 " style="padding-top: 10px;">
                            Tela:
            <select id="slTela" style="" class="form-control" onchange="Gerar()">
                <option value="0"><%= Resources.Resource.selecione %>...</option>
            </select>
                        </div>
                        <div class="col-md-6 col-sm-12 " style="padding-top: 10px;">
                            Palavra Chave:
                                    <input id="txtTag" type="text" style="" class="form-control" />
                        </div>
                    </div>

                    <div style="padding-top: 12px" class="btn-group">
                        <button type="button" class="btn btn-secondary" onclick="Gerar()" style="display: inline !important;"><%= Resources.Resource.gerar%></button>
                        <button id="btnXlsRel" type="button" class="btn btn-success" onclick="ExportToXls('divRelLog','RelatórioLog')" style="display: none !important;"><i class="la la-file-excel-o"></i></button>
                        <button id="btnPrintRel" type="button" class="btn btn-light" onclick="CallPrint('divRelLog')" style="display: inline !important;"><i class="la la-print"></i></button>
                    </div>
                </div>

                <%-- <div id="dvHora" class="panel-body">
            Hora Inicial:&nbsp;
            <input id="txtHrInicial" type="time" class="form-control" style="display: inline; width: 100px;" />:&nbsp;&nbsp;
            Hora Final:&nbsp;
            <input id="txtHrFinal" type="time" class="form-control" style="display: inline; width: 100px;" />
        </div>--%>
                <%--<hr />--%>
            </div>
        </div>
        <div id="divRelLog" class="table-responsive" style="overflow: auto; width: 100%;">
            <h4 id="spTitle" style="text-align: center; width: 100%; padding-top: 15px"></h4>
            <h5 style="text-align: center; width: 100%"><span id="spDtRelatorio"></span></h5>
            <hr />
            <table id="tblLog" class="table table-bordered mb-0" style="border-collapse: collapse; width: 100%;">
                <thead>
                    <tr>
                        <th style="font-size: small; border: 1px solid #ddd;"><%= Resources.Resource.data %></th>
                        <th style="font-size: small; border: 1px solid #ddd;"><%= Resources.Resource.usuario %></th>
                        <th style="font-size: small; border: 1px solid #ddd;">Log</th>
                        <th style="font-size: small; border: 1px solid #ddd;"><%= Resources.Resource.descricao %></th>
                        <th style="font-size: small; border: 1px solid #ddd;">Tela</th>
                    </tr>
                </thead>
                <tbody id="tblLogBody">
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>
        var globalResources;
        function loadResourcesLocales() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: 'Default.aspx/requestResource',
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

        function CallPrint(strid) {
            var prtContent = document.getElementById(strid);
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,dir=ltr');
            $(".amp").css('display', 'none');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            prtContent.innerHTML = strOldOne;
        }

        function ExportToXls(component) {
            var a = document.createElement('a');
            //getting data from our div that contains the HTML table
            var data_type = 'data:application/vnd.ms-excel';
            var table_div = document.getElementById(component);
            var table_html = table_div.outerHTML.replace(/ /g, '%20');
            a.href = data_type + ', ' + table_html;
            //setting the file name
            a.download = 'RelatorioLog.xls';
            //triggering the function
            a.click();
            //just in case, prevent default behaviour
            //  e.preventDefault();
        }


        $("#msgDanger").css('display', 'none');
        $("#msnInfo").css('display', 'none');

        $(function () {

            loadResourcesLocales();
            loadTela();
            $("#divRelLog").css('display', 'none');
            $("#btnPrintRel").css('display', 'none');
            $("#btnXlsRel").css('display', 'none');

            // Declare variables
            var today = new Date();
            var tomorrow = new Date(new Date().getTime() + 24 * 60 * 60 * 30000);

            // Set values
            $("#txtMes").val(getMes(today));
            $("#txtDtIni").val(getFormattedDate(today));
            $("#txtDt").val(getFormattedDate(today));
            $("#txtDtFim").val(getFormattedDate(tomorrow));

            // Get date formatted as YYYY-MM-DD
            function getMes(date) {
                return date.getFullYear()
                    + "-"
                    + ("0" + (date.getMonth() + 1)).slice(-2);
            }

            // Get date formatted as YYYY-MM-DD
            function getFormattedDate(date) {
                return date.getFullYear()
                    + "-"
                    + ("0" + (date.getMonth() + 1)).slice(-2)
                    + "-"
                    + ("0" + date.getDate()).slice(-2);
            }

        });


        $('input[type=radio][name=TipoData]').change(function () {
            if (this.value == 'Mensal') {
                $("#dvMensal").css('display', 'block');
                $("#dvPeriodo").css('display', 'none');
                $("#dvData").css('display', 'none');
            }
            else if (this.value == 'Periodo') {
                $("#dvPeriodo").css('display', 'block');
                $("#dvMensal").css('display', 'none');
                $("#dvData").css('display', 'none');
            }
            else if (this.value == 'Data') {
                $("#dvData").css('display', 'block');
                $("#dvMensal").css('display', 'none');
                $("#dvPeriodo").css('display', 'none');
            }
        });
        $("#txtUser").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: 'Default.aspx/FiltraUser',
                    data: "{ 'prefixText': '" + request.term + "', 'IdPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item,
                                //id: item.split('-')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        //alert(response.responseText);
                    },
                    failure: function (response) {
                        //alert(response.responseText);
                    }
                });
            },
            select: function (e, i) {
                $("#txtUser").val(i.item.label);
                //$("#txtUser").data('id', i.item.id);
            },
            minLength: 2
        });

        function ValidaCampo(NomeObjeto) {
            $(NomeObjeto).css("border-color", "#ff0000");
            $(NomeObjeto).css("outline", "0");
            $(NomeObjeto).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
            $(NomeObjeto).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
        }

        function LimpaValidacaoCampo(NomeObjeto) {
            $(NomeObjeto).css("border-color", "");
            $(NomeObjeto).css("outline", "");
            $(NomeObjeto).css("-webkit-box-shadow", "");
            $(NomeObjeto).css("box-shadow", "");
        }

        function Gerar() {
            //if ($('#txtHrInicial').val() == "" && $('#txtHrFinal').val() == "") {
            //    ValidaCampo("#dvHora");
            //    return true;
            //}
            //else {

            //    LimpaValidacaoCampo("#dvHora");
            //}

            //var HoraIni = $('#txtHrInicial').val()
            //var HoraFim = $('#txtHrFinal').val()

            $("#btnPrintRel").css('display', 'block');
            $("#btnXlsRel").css('display', 'none');

            //if ($('#txtUser').val() == null || $('#txtUser').val() == "") {
            //    ValidaCampo("#txtUser");
            //    return true;
            //}
            //else {
            //    LimpaValidacaoCampo("#txtViatura");
            //}

            if ($('#slTela').val() == "Selecione" || $('#slTela').val() == "0") {
                ValidaCampo("#slTela");
                return true;
            }
            else {
                LimpaValidacaoCampo("#slTela");
            }

            var tipo = $('input[name="TipoData"]:checked').val();

            var ini = "";
            var fim = "";

            if (tipo == "Mensal") {
                ini = $('#txtMes').val().substring(5, 7) + '/' + $('#txtMes').val().substring(0, 4);
                document.getElementById("spDtRelatorio").innerHTML = 'Mensal: ' + ini;
            }
            else if (tipo == "Periodo") {
                ini = $('#txtDtIni').val().substring(8, 10) + '/' + $('#txtDtIni').val().substring(5, 7) + '/' + $('#txtDtIni').val().substring(0, 4);
                fim = $('#txtDtFim').val().substring(8, 10) + '/' + $('#txtDtFim').val().substring(5, 7) + '/' + $('#txtDtFim').val().substring(0, 4);
                document.getElementById("spDtRelatorio").innerHTML = 'De: ' + ini + ' ate: ' + fim;
            }
            else {
                ini = $('#txtDt').val().substring(8, 10) + '/' + $('#txtDt').val().substring(5, 7) + '/' + $('#txtDt').val().substring(0, 4);
                document.getElementById("spDtRelatorio").innerHTML = 'Data especifica: ' + ini;
            }

            $("#divRelLog").css('display', 'block');
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/GetLogs',
                dataType: 'json',
                data: "{'IdPrefeitura':'" + $("#hfIdPrefeitura").val() + "','dtIni':'" + ini + "','dtFim':'" + fim + "','Tipo':'" + tipo + "','user':'" + $("#txtUser").val() + "','Tela':'" + $("#slTela").val() + "','tag':'" + $("#txtTag").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#spTitle").css('display', 'block');
                    document.getElementById("spTitle").innerHTML = "RELATORIO DE LOG";
                    $("#spDtRelatorio").css('display', 'block');
                    if (data.d.length == 0) {
                        $("#tblLogBody").empty();
                        var lst = data.d[i];
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='5' style='border-collapse: collapse; border:1px solid #ddd;'>Não há Registros de Log.</td>";
                        newRow.append(cols);
                        $("#tblLogBody").append(newRow);
                    }
                    else {
                        var i = 0;
                        $("#tblLogBody").empty();
                        while (data.d[i]) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='border-collapse: collapse; border:1px solid #ddd;'>" + data.d[i].DtHr + "</td>";
                            cols += "<td style='border-collapse: collapse; border:1px solid #ddd;'>" + data.d[i].user + "</td>";
                            cols += "<td style='border-collapse: collapse; border:1px solid #ddd;'>" + data.d[i].Log + "</td>";
                            cols += "<td style='border-collapse: collapse; border:1px solid #ddd;'>" + data.d[i].Descricao + "</td>";
                            cols += "<td style='border-collapse: collapse; border:1px solid #ddd;'>" + data.d[i].Tela + "</td>";
                            newRow.append(cols);
                            $("#tblLogBody").append(newRow);
                            i++;
                        }
                    }

                },
                error: function (data) {
                    params = data; alert('Erro ao obter os dados! Recarregue a página!');
                }
            });
        }

        function loadTela() {
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/loadTela',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var i = 0;
                    $("#slTela").empty();
                    $("#slTela").append("<option value='Selecione'>" + getResourceItem("selecione") + "</option>");
                    $("#slTela").append("<option value='TODAS'>" + getResourceItem("todos") + "</option>");
                    while (data.d[i]) {
                        var lst = data.d[i];
                        $("#slTela").append("<option value='" + lst.Tela + "'>" + lst.Tela + "</option>");
                        i++;
                    }
                },
                error: function (data) {
                }

            });
        }

    </script>

</asp:Content>
