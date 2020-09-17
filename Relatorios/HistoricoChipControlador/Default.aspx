<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Relatorios.HistoricoChipControlador.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Relatório de Chip Controlador e Nobreak</title>
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
            background: #fff url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAUCAAAAABpZQh9AAAAF0lEQVQI12P4z/SP6S8Q/sOCYawPTO8Ajz0T2VT0ZeQAAAAASUVORK5CYII=') /*../../Images/bar_top.png*/ repeat-x left bottom;
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
        <h2 id="titleChip" style="margin-bottom: 15px; border-bottom: 1px solid #D8D8D8; color: #D8D8D8;">
            <img src="../../Images/gsm-sim-card.png" alt="Chip do Controlador" style="width: 42px; height: 42px;" />
            Relatório de Chip do Controlador e Nobreak
        </h2>
        <div id="divbody" style="width: 1000px; padding: 5px; margin-top: 15px; border: 1px solid #D8D8D8; border-radius: 10px;">
            <h3 id="hpesquisar" style="border-bottom: 1px solid #D8D8D8;">Pesquisar</h3>
            <div style="margin-top: 10px;">
                <div id="divPesquisar">
                    <div id="divChipInfo">
                        <p>
                            Informar Consorcio?
                                Sim<input id="rdoYesConcorcio" type="radio" name="consorcio" onclick="infoConsorcio('Sim');" />
                            Não<input id="rdoNoConsorcio" type="radio" name="consorcio" checked="checked" onclick="infoConsorcio('Nao');" />
                        </p>
                        <div id="divInfoConsorcioChip" style="display: none;">
                            <p>
                                Consorcio: 
                                    <select id="sleConsorcio" class="form-control" onchange="getBusinesses();" style="width: 300px; margin-bottom: 5px; margin-left: 27px; height: 30px; display: inline;">
                                        <option value="0">Selecione um consorcio...</option>
                                        <option value="1">CONSORCIO SINAL PAULISTANO</option>
                                        <option value="2">CONSORCIO ONDAVERDE</option>
                                        <option value="3">CONSORCIO MCS</option>
                                        <option value="4">CONSORCIO SEMAFORICO PAULISTANO</option>
                                    </select>
                            </p>
                            <p>
                                Empresa: 
                                    <select id="sleEmpChip" class="form-control" style="width: 300px; margin-bottom: 5px; margin-left: 35px; height: 30px; display: inline;">
                                    </select>
                            </p>
                            <p>
                                Empresa Insta: 
                                    <select id="sleEmpInstaChip" class="form-control" style="width: 300px; margin-bottom: 5px; height: 30px; display: inline;">
                                    </select>
                            </p>
                        </div>
                        <div id="divEmpChip" style="">
                            <p>
                                Empresa: 
                                <input id="txtEmpChip" class="form-control" type="text" placeholder="Empresa..." style="width: 300px; display: inline; margin-left: 35px; text-transform: uppercase;" />
                            </p>
                            <p>
                                Empresa Insta: 
                                <input id="txtEmpInstaChip" class="form-control" type="text" placeholder="Empresa Instaladora..." style="width: 300px; display: inline; text-transform: uppercase;" />
                            </p>
                        </div>

                    </div>
                    <p style="height: 40px;">
                        Data:
                        <input id="txtDataInicial" class="datepicker" data-toggle="dataIni" data-placement="right" title="Preencha a Data Inicial!" style="margin-left: 60px;" type="text" placeholder="Inicial" />
                        <input id="txtDataFinal" class="datepicker" data-toggle="dataFini" data-placement="right" title="Preencha a Data Final!" style="margin-left: 30px;" type="text" placeholder="Final" />
                    </p>

                    <p style="height: 40px;">
                        Id do Ponto:
                        <input id="txtIdPonto" type="text" style="width: 150px; margin-left: 16px; display: inline;" class="form-control" placeholder="Id do Ponto" />&nbsp;&nbsp;
                        Cruzamento:
                        <input id="txtCruzamento" class="form-control" style="width: 400px; display: inline;" placeholder="Cruzamento" />
                    </p>
                    <p style="height: 40px;">
                        Operadora:
                        <select id="sleOperadoraChip" class="form-control" style="width: 150px; margin-left: 19px; display: inline;">
                            <option></option>
                            <option>CLARO</option>
                            <option>VIVO</option>
                            <option>TIM</option>
                            <option>OI</option>
                        </select>&nbsp;&nbsp;
                        Plano:
                        <input type="text" id="txtPlanoChip" class="form-control" placeholder="Plano do Chip..." style="width: 150px; display: inline; margin-left: 45px;" />
                        <img id="imgPesquisar" src="../../Images/search.png" alt="Pesquisar" onclick="pesquisar();" style="width: 36px; height: 36px; margin-left: 20px; cursor: pointer;" />
                    </p>


                </div>

                <h3 style="border-bottom: 1px solid #d8d8d8;">Detalhes
                </h3>
                <div id="divChip">
                    Total:<span id="spaTotal"></span>
                    <div id="divScrollChip" style="height: 350px; overflow-y: scroll; margin-top: 10px; font-size: 0.8em;">
                        <p style="border-bottom: 1px solid #d8d8d8; margin-bottom: 15px;">
                            <img id="imgExcel" src="../../Images/excel.png" alt="Excel" style="width: 36px; height: 32px; cursor: pointer;" onclick="excel();" />
                            <img id="imgImprimir" src="../../Images/print.png" alt="Imprimir" style="width: 56px; height: 56px; cursor: pointer;" onclick="imprimir();" />
                        </p>
                        <table id="tblChip" class="tblgrid" style="width: 90%; background-color: #ffffff; margin-bottom: 15px; margin-left: 5px;">
                            <caption>Lista de Chips</caption>
                            <thead style="margin-top: 10px;">
                                <tr>
                                    <th style="width: 50px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Id Dna</th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Consorcio</th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Empresa</th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Empresa Insta</th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Operadora</th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">ICCID</th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Numero</th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Plano</th>
                                    <th style="width: 200px; border: 1px solid black; border-collapse: collapse; padding: 5px;">Tipo</th>
                                </tr>
                            </thead>
                            <tbody id="tbChip"></tbody>
                            <tfoot id="tfChip">
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
            if (txtDataInicial.value == "") {
                $("[data-toggle='dataIni']").tooltip('show');
                return;
            }
            if (txtDataFinal.value == "") {
                $("[data-toggle='dataFini']").tooltip('show');
                return;
            }

            var Empresa = "";
            var EmpInsta = "";
            var Consorcio = "";

            if ($("#rdoYesConcorcio").is(":checked")) {
                Empresa = $('[id*=sleEmpChip] option:selected').text();
                if (Empresa == "Selecione...") {
                    Empresa = "";
                }
                EmpInsta = $('[id*=sleEmpInstaChip] option:selected').text();
                if (EmpInsta == "Selecione...") {
                    EmpInsta = "";
                }
            }
            else {
                Empresa = document.getElementById("txtEmpChip").value;
                EmpInsta = document.getElementById("txtEmpInstaChip").value;
            }
            Consorcio = $('[id*=sleConsorcio] option:selected').text();
            if (Consorcio == "Selecione um consorcio...") {
                Consorcio = "";
            }

            divLoad.style.display = "block";
            $.ajax({
                type: 'POST',
                url: 'Default.asmx/PesquisarChip',
                dataType: 'json',
                data: "{'dataIni':'" + txtDataInicial.value + "','dataFini':'" + txtDataFinal.value + "','idPonto':'" + txtIdPonto.value + "','operadora':'" + document.getElementById('sleOperadoraChip').value + "','planoChip':'" + txtPlanoChip.value + "','Consorcio':'" + Consorcio + "','Empresa':'" + Empresa + "','EmpInsta':'" + EmpInsta + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    tfChip.style.display = "none";

                    if (data.d.toString() == "") {
                        tfChip.style.display = "block";
                    }

                    $("#tbChip").empty();

                    var lstChip = data.d;
                    var qtd = 0;

                    $.each(lstChip, function (index, item) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + item.idDna + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + item.consorcio + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + item.empresa + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + item.empresainsta + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + item.operadora + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + item.hexa + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + item.numero + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + item.plano + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + item.tipo + "</td>";

                        newRow.append(cols);
                        $("#tblChip").append(newRow);

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
            divScrollChip.style.overflowY = "hidden";
            divScrollChip.style.height = "auto";
            divPesquisar.style.display = "none";
            hpesquisar.style.display = "none";
            document.body.innerHTML =
              "<html><head><title></title></head><body>" +
              titleChip.innerHTML + divChip.innerHTML + "</body>";

            window.print();
            window.location.reload(true);
        }

        function excel() {
            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('div[id$=divChip]').html()));
        }

        function infoConsorcio(status) {
            switch (status) {
                case "Sim":
                    document.getElementById("divInfoConsorcioChip").style.display = "";
                    document.getElementById("divEmpChip").style.display = "none";
                    break;
                case "Nao":
                    document.getElementById("divInfoConsorcioChip").style.display = "none";
                    document.getElementById("divEmpChip").style.display = "";
                    break;
            }
        }

        function getBusinesses() {
            var sleConsorcio = $get('sleConsorcio');
            if (sleConsorcio.selectedIndex == 0) {
                $("#sleEmpChip").empty();
                $("#sleEmpInstaChip").empty();
                return;
            }
            else {
                $.ajax({
                    type: 'POST',
                    url: 'Default.asmx/GetBusinesses',
                    dataType: 'json',
                    data: "{'consorcioId':'" + sleConsorcio.selectedIndex + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        $("#sleEmpChip").empty().append($("<option></option>").val("[0]").html("Selecione..."));
                        $("#sleEmpInstaChip").empty().append($("<option></option>").val("[0]").html("Selecione..."));
                        var i = 0;

                        while (data.d[i]) {
                            var lst = data.d[i].split('@');
                            var Nome = lst[0];
                            var id = lst[1];
                            var idconsorcio = lst[2];

                            if (Nome == "CET") {
                                if (idconsorcio == sleConsorcio.selectedIndex) {
                                    $("#sleEmpChip").append($("<option></option>").val(id).html(Nome));
                                    $("#sleEmpInstaChip").append($("<option></option>").val(id).html(Nome));
                                }
                            }
                            else {
                                $("#sleEmpChip").append($("<option></option>").val(id).html(Nome));
                                $("#sleEmpInstaChip").append($("<option></option>").val(id).html(Nome));
                            }
                            

                            i++;
                        }
                    },
                    error: function (data) {
                    }

                });
            }
        }
    </script>
</asp:Content>
