<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Relatorios.TensaoEntradaNobreak.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Relatório de Tensão</title>
    <style type="text/css">
        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            overflow-x: hidden;
            width: 300px;
            background-color: #ffffff;
            cursor: pointer;
        }
    </style>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/css/bootstrap-datepicker.css" />
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/locales/bootstrap-datepicker.pt-BR.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="main" style="width: 1000px; margin-left: 10px;">
        <div id="divLoad" style="width: 100%; height: 100%; background-color: #D8D8D8; position: absolute; display: none; opacity: 0.4;">
            <p style="padding-left: 50%; padding-top: 10%; position: absolute;">
                <img id="imgLoad" alt="Carregando" src="../../Images/carregando.gif" />
            </p>
        </div>
        <h2 id="titleTensaoNobreak" style="margin-bottom: 15px; border-bottom: 1px solid #D8D8D8; color: #D8D8D8;">Gráfico dos Niveis de Tensão</h2>
        <div id="divbody" style="width: 1000px; padding: 5px; margin-top: 15px; border: 1px solid #D8D8D8; border-radius: 10px;">
            <h3 id="hpesquisar" style="border-bottom: 1px solid #D8D8D8; padding-bottom: 5px; color: #d8d8d8;">Pesquisar</h3>
            <div id="divPesquisar">
                <p style="height: 40px;">
                    <b>Data: </b>
                    <input id="txtData" class="datepicker" placeholder="Data..." style="margin-left: 85px;" type="text" />
                </p>
                <p style="height: 40px;">
                    <b>Cruzamento:</b>
                    <input id="txtCruzamento" class="form-control" style="width: 400px; display: inline; margin-left: 34px;" placeholder="Cruzamento" />
                </p>
                <p style="height: 40px;">
                    <b>Id do Ponto:</b>
                    <input id="txtIdPonto" type="text" style="width: 150px; display: inline; margin-left: 40px;" class="form-control" placeholder="Id do Ponto" />
                </p>
                <p style="height: 40px; border-bottom: 1px solid #d8d8d8;">
                    <b>Serial do Nobreak:</b>
                    <input type="text" id="txtSerialNobreak" class="form-control" placeholder="Serial do Nobreak..." style="width: 150px; display: inline;" />
                    <img id="imgPesquisar" src="../../Images/search.png" alt="Pesquisar" style="width: 36px; height: 36px; margin-left: 20px; cursor: pointer;" />
                </p>
            </div>
            <%--<div id="container" style="height: 400px; display: none; width: 950px; margin-top: 10px;"></div>--%>
            <div id="container2" style="height: 400px; display: none; width: 950px; margin-top: 10px;"></div>
            <span id="spaInfoNobreakTensao" style="color: red; display: none;">Não á Tensão para este Nobreak.</span>
        </div>
    </div>
    <script src="http://code.highcharts.com/stock/highstock.js"></script>
    <script src="http://code.highcharts.com/stock/modules/exporting.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.datepicker').datepicker({
                dateFormat: "dd/mm/yyyy",
                language: 'pt-BR'
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

            $("#imgPesquisar").click(function () {
                //if (txtIdPonto.value == "" && txtSerialNobreak.value == "") {
                if (document.getElementById("txtIdPonto").value == "" && txtSerialNobreak.value == "") {
                    alert("Informe o Serial do Nobreak ou o Id do Dna!");
                    return;
                }
                divLoad.style.display = "block";
                //getVoltageInputLine(document.getElementById("txtIdPonto").value, document.getElementById("txtSerialNobreak").value, document.getElementById("txtData").value);
                getVoltageInputLine2(document.getElementById("txtIdPonto").value, document.getElementById("txtSerialNobreak").value, document.getElementById("txtData").value);
            });

            function getVoltageInputLine(idDna, serial,data) {
                $.ajax({
                    type: 'POST',
                    url: 'LogNobreak.asmx/GetVoltageInputLine',
                    dataType: 'json',
                    data: "{'idDna':'" + idDna + "','serial':'" + serial + "','data':'" + data + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d.toString() == "") {
                            spaInfoNobreakTensao.style.display = "";
                            container.style.display = "none";
                        }
                        else {
                            spaInfoNobreakTensao.style.display = "none";
                            container.style.display = "block";
                            var lstNobreak = data.d;

                            var valuesVoltageInput = [], valuesVoltageOut = [], lstAllDates = [];

                            //#region create Chart

                            $('#container').highcharts({
                                title: {
                                    text: 'Tensão de Entrada VS Tensão Saida'
                                },
                                subtitle: {
                                    text: 'Monitoramento Diario'
                                },
                                scrollbar: {
                                    enabled: true
                                },
                                rangeSelector: {
                                    enabled: false
                                },
                                plotOptions: {
                                    series: {
                                        allowPointSelect: false
                                    }
                                },
                                series: [{
                                    name: 'Tensão de entrada',
                                    data: []
                                }, {
                                    name: 'Tensão Saida',
                                    data: []
                                }],
                                xAxis: {
                                    gridLineWidth: 1,
                                    max: 200,
                                    tickInterval: 2
                                },
                                yAxis: {
                                    gridLineWidth: 1
                                }
                            });

                            //#endregion

                            $.each(lstNobreak, function (index, item) {
                                switch (item.descricao) {
                                    case "Valor,Tensão de entrada V":
                                        valuesVoltageInput.push([parseInt(item.valor)]);
                                        break;
                                    case "Tensão de saida V":
                                        valuesVoltageOut.push([parseInt(item.valor)]);
                                        break;
                                }
                                lstAllDates.push([item.data]);
                            });

                            var lstDates = jQuery.unique(lstAllDates);

                            divLoad.style.display = "none";
                            var chart = $('#container').highcharts();
                            chart.series[0].setData(valuesVoltageInput);
                            chart.xAxis[0].setCategories(lstDates);
                            chart.yAxis[0].setCategories(lstDates);
                            chart.xAxis[0].setTickInterval(1);
                            chart.series[1].setData(valuesVoltageOut);
                        }

                    },
                    error: function (data) {
                        window.location.reload(true);
                    }
                });
            }
            function getVoltageInputLine2(idDna, serial,data) {
                $.ajax({
                    type: 'POST',
                    url: 'LogNobreak.asmx/GetVoltageInputLine',
                    dataType: 'json',
                    data: "{'idDna':'" + idDna + "','serial':'" + serial + "','data':'" + data + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d.toString() == "") {
                            spaInfoNobreakTensao.style.display = "";
                            container2.style.display = "none";
                            
                        }
                        else {
                            spaInfoNobreakTensao.style.display = "none";
                            container2.style.display = "block";
                            var lstNobreak = data.d;

                            var valuesVoltageBat = [], valuesVoltageOut = [], lstAllDates = [], valuesVoltageInput=[];

                            //#region create Chart

                            $('#container2').highcharts({
                                title: {
                                    text: 'Niveis de Tensão V'
                                },
                                subtitle: {
                                    text: 'Monitoramento Diario'
                                },
                                scrollbar: {
                                    enabled: true
                                },
                                rangeSelector: {
                                    enabled: false
                                },
                                plotOptions: {
                                    series: {
                                        allowPointSelect: false
                                    }
                                },
                                series: [{

                                        name: 'Tensão de entrada',
                                        data: []
                                    }, {
                                    name: 'Tensão das baterias V',
                                    data: []
                                }, {
                                    name: 'Tensão Saida',
                                    data: []
                                }],
                                xAxis: {
                                    type: 'datetime',
                                    gridLineWidth: 1
                                   
                                    //,tickInterval: 2
                                },
                                yAxis: {
                                    gridLineWidth: 1
                                }
                            });

                            //#endregion

                            $.each(lstNobreak, function (index, item) {
                                switch (item.descricao) {
                                    case "Valor,Tensão de entrada V":
                                        valuesVoltageInput.push([parseInt(item.valor)]);
                                        lstAllDates.push([item.data]);
                                        break;
                                    case "Tensão das baterias V":
                                        valuesVoltageBat.push([parseInt(item.valor)]);
                                        break;
                                    case "Tensão de saida V":
                                        valuesVoltageOut.push([parseInt(item.valor)]);
                                        break;
                                }
                                
                                //lstAllDates.push([item.data]);
                            });

                            var lstDates = jQuery.unique(lstAllDates);

                            divLoad.style.display = "none";
                            var chart = $('#container2').highcharts();
                            chart.series[1].setData(valuesVoltageBat);
                            chart.xAxis[0].setCategories(lstDates);
                           // chart.xAxis[0].tickInterval(3600);
                            
                           /// chart.yAxis[0].setCategories(lstDates);
                           // chart.xAxis[0].setTickInterval(1);
                            chart.series[2].setData(valuesVoltageOut);
                            chart.series[0].setData(valuesVoltageInput);
                        }

                    },
                    error: function (data) {
                        window.location.reload(true);
                    }
                });
            }
        });
    </script>
</asp:Content>
