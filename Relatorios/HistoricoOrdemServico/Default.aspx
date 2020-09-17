<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Relatorios.HistoricoOrdemServico.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Relatório de Ordem de Serviço</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>

    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/css/bootstrap-datepicker.css" />
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/locales/bootstrap-datepicker.pt-BR.min.js"></script>

    <style type="text/css">
        .tblgrid tr:nth-child(even) {
            background-color: #eee;
        }

        .tblgrid tr:nth-child(odd) {
            background-color: #fff;
        }

        .tblgrid th {
            text-align: left;
            background: #fff url(../../Images/bar_top.png) repeat-x left bottom;
            border-bottom: 1px solid #333;
        }

        .tblgrid tr:nth-child(even):hover {
            background-color: #fff;
        }

        .tblgrid tr:nth-child(odd):hover {
            background-color: #f5f5f5;
        }

        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            overflow-x: hidden;
            width: 300px;
            background-color: #ffffff;
            cursor: pointer;
        }

        * html .ui-autocomplete {
            height: 100px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div id="divMain" style="width: 1000px; margin-left: 10px;">
        <div id="divLoad" style="width: 100%; height: 100%; background-color: #D8D8D8; position: absolute; display: none; opacity: 0.4;">
            <p style="padding-left: 50%; padding-top: 10%; position: absolute;">
                <img id="imgLoad" alt="Carregando" src="../../Images/carregando.gif" />
            </p>
        </div>
        <h2 id="titleOs" style="margin-bottom: 15px; border-bottom: 1px solid #D8D8D8; color: #D8D8D8;">
            <img src="../../Images/ordemServi%c3%a7o.png" alt="Ordem de Serviço" style="width: 42px; height: 42px;" />
            Relatório de Ordem de Serviço
        </h2>

        <div id="divbody" style="width: 1000px; padding: 5px; margin-top: 15px; border: 1px solid #D8D8D8; -moz-border-radius: 10px; -webkit-border-radius: 10px; border-radius: 10px;">
            <h3 id="hpesquisar" style="border-bottom: 1px solid #D8D8D8;">Pesquisar</h3>
            <div style="margin-top: 10px;">
                <div id="divPesquisar">
                    <p style="height: 40px;">
                        <b>Data:</b>
                        <input id="txtDataInicial" class="datepicker" data-toggle="dataIni" data-placement="right" title="Preencha a Data Inicial!" style="margin-left: 50px;" type="text" placeholder="Inicial" />
                        <input id="txtDataFinal" class="datepicker" data-toggle="dataFini" data-placement="right" title="Preencha a Data Final!" style="margin-left: 30px;" type="text" placeholder="Final" />
                    </p>
                    <p style="height: 40px;">
                        <b>Cruzamento:</b>
                        <input id="txtCruzamento" class="form-control" style="width: 400px; display: inline;" placeholder="Cruzamento" />
                    </p>
                    <p style="height: 40px;">
                        <b>Id do Ponto:</b>
                        <input id="txtIdPonto" type="text" style="width: 150px; display: inline;" class="form-control" placeholder="Id do Ponto" />

                        <b style="margin-left: 30px;">Falha:</b>
                        <select id="cboFalha" style="width: 250px; display: inline;" title="Selecione a Falha!" class="form-control"></select>
                    </p>
                    <p style="height: 40px;">
                        <b>Status Atendimento:</b>
                        <input id="rdoAtendidos" type="radio" name="statusOs" />Atendidos
                    <input type="radio" id="rdoNaoAtendidos" name="statusOs" />Não atendidos
                    <img id="imgPesquisar" src="../../Images/search.png" alt="Pesquisar" onclick="pesquisar();" style="width: 36px; height: 36px; margin-left: 20px; cursor: pointer;" />
                    </p>
                    <p style="border-bottom: 1px solid #d8d8d8; margin-bottom: 15px;">
                        <img id="imgExcel" src="../../Images/excel.png" alt="Excel" style="width: 36px; height: 32px; cursor: pointer;" onclick="excel();" />
                        <img id="imgImprimir" src="../../Images/print.png" alt="Imprimir" style="width: 56px; height: 56px; cursor: pointer;" onclick="imprimir();" />
                    </p>
                </div>

                <h3 style="border-bottom: 1px solid #d8d8d8;">Detalhes
                </h3>
                <div id="divOs">
                    <b>Total:</b><span id="spaTotal"></span>
                    <div id="divScrollOs" style="height: 200px; overflow-y: scroll; margin-top: 10px;">
                        <table id="tblOs" class="tblgrid" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Id do Ponto</th>
                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Cruzamento</th>
                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Falha</th>
                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Causa</th>
                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Data</th>
                                    <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Atendido</th>
                                </tr>
                            </thead>
                            <tbody id="tbOs"></tbody>
                            <tfoot id="tfOs">
                                <tr>
                                    <td><b style="color: #d8d8d8;">Não há registros.</b>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $('.datepicker').datepicker({
                dateFormat: "dd/mm/yyyy",
                language: 'pt-BR'
            });
            $.ajax({
                type: 'POST',
                url: '../../Default.aspx/GetFailures',
                dataType: 'json',
                data: "",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#cboFalha").empty().append($("<option></option>").val("[0]").html("Selecione..."));
                    $.each(data.d, function () {
                        $("#cboFalha").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    $("#divLoad").css("display", "none");
                },
                error: function (data) { params = data; alert('Erro ao carregar falhas, tente novamente!'); }
            });
        });

        $("#txtCruzamento").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: '../../Default.aspx/GetDna',
                    data: "{ 'prefixText': '" + request.term + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            var lstDna = item.split('@');
                            return {
                                label: lstDna[1],
                                val: lstDna[0]
                            }
                        }))
                    },
                    error: function (response) {
                    },
                    failure: function (response) {
                    }
                });
            },
            select: function (e, i) {
                $("#txtCruzamento").val(i.item.label);
                document.getElementById("txtIdPonto").value = i.item.val;
            },
            minLength: 1

        });

        function pesquisar() {
            var idFalha = "", statusAtendimento = "";
            divLoad.style.display = "block";

            if (txtDataInicial.value == "") {
                $("[data-toggle='dataIni']").tooltip('show');
                return;
            }
            if (txtDataFinal.value == "") {
                $("[data-toggle='dataFini']").tooltip('show');
                return;
            }
            if (cboFalha.value != "[0]") {
                idFalha = cboFalha.value;
            }
            if (rdoAtendidos.checked) {
                statusAtendimento = "1";
            }
            if (rdoNaoAtendidos.checked) {
                statusAtendimento = "0";
            }
            $.ajax({
                type: 'POST',
                url: 'Default.asmx/PesquisarOs',
                dataType: 'json',
                data: "{'dataIni':'" + txtDataInicial.value + "','dataFini':'" + txtDataFinal.value + "','idPonto':'" + txtIdPonto.value + "','idFalha':'" + idFalha + "','statusAtendimento':'" + statusAtendimento + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    tfOs.style.display = "none";

                    if (data.d.toString() == "") {
                        tfOs.style.display = "block";
                    }
                    $("#tbOs").empty();

                    var lstOs = data.d;
                    var qtd = 0;

                    $.each(lstOs, function (index, os) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + os.idPonto + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + os.cruzamento + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + os.falha + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + os.causa + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + os.data + "</td>";

                        switch (os.atendido) {
                            case "False":
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>Não</td>";
                                break;
                            case "True":
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>Sim</td>";
                                break;
                        }

                        newRow.append(cols);
                        $("#tblOs").append(newRow);

                        qtd++;
                    });

                    $("#spaTotal").empty();
                    $("#spaTotal").append(qtd);

                    divLoad.style.display = "none";

                },
                error: function (data) {
                    window.location.reload(true);
                }
            });
        }

        function imprimir() {
            divScrollOs.style.overflowY = "hidden";
            divScrollOs.style.height = "auto";
            divPesquisar.style.display = "none";
            hpesquisar.style.display = "none";

            document.body.innerHTML =
              "<html><head><title></title></head><body>" +
              titleOs.innerHTML + divOs.innerHTML + "</body>";

            window.print();
            window.location.reload(true);
        }

        function excel() {
            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('div[id$=divOs]').html()));
        }
    </script>
</asp:Content>
