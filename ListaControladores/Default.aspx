<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Relatorios.ListaControladores.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Lista de Controladores</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="../../Scripts/bootstrap.min.js"></script>

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
    </style>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="main" style="margin-left: 10px;">
        <div id="divLoad" style="width: 100%; height: 100%; background-color: #D8D8D8; position: absolute; display: none; opacity: 0.4;">
            <p style="padding-left: 50%; padding-top: 10%; position: absolute;">
                <img id="imgLoad" alt="Carregando" src="../../Images/carregando.gif" />
            </p>
        </div>
        <h2 style="margin-bottom: 15px; border-bottom: 1px solid #D8D8D8; color: #D8D8D8; width: 1000px;">Lista de Controladores de Teste Semafórico
        </h2>
        <div id="divbody" style="width: 90%; padding: 5px; margin-top: 15px; border: 1px solid #D8D8D8; border-radius: 10px; overflow: scroll; height: 800px;">
            <h3 style="border-bottom: 1px solid #d8d8d8;">Detalhes
            </h3>
            <table id="tblControlador" class="tblgrid" style="margin-top: 10px; width: 100%;">
                <thead>
                    <tr>
                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">#</th>
                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Serial</th>
                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Falha</th>
                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Porta</th>
                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Porta reset</th>
                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Resposta Reset</th>
                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">IP</th>
                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Atualizado</th>
                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                        <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
                    </tr>
                </thead>
                <tbody id="tbControlador"></tbody>
                <tfoot id="tfControlador">
                    <tr>
                        <td><b style="color: #d8d8d8;">Não há registros.</b>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
    <div id="popupEditPortaReset" class="modal fade" role="dialog">
        <asp:HiddenField ID="hdfSerial" runat="server" ClientIDMode="Static" />
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">
                        <img src="../Images/openDoor.png" style="width: 42px; height: 42px;" alt="" />Editar porta reset</h4>
                </div>
                <div class="modal-body">
                    <p>
                        Porta reset:
                            <input id="txtPortaReset" type="text" class="form-control" style="width: 150px; display: inline;" />
                    </p>
                </div>
                <div class="modal-footer">
                    <input id="btnConfirm" type="button" value="Confirmar" style="width: 100px;" class="btn btn-default" onclick="editDoorReset();" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true&libraries=places"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            var timerControllers = setInterval(function () { getControllers() }, 20000);
            getControllers();
        }
        function getControllers() {
            divLoad.style.display = "block";
            $.ajax({
                type: 'POST',
                url: 'Default.asmx/GetControllers',
                dataType: 'json',
                data: "",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    tfControlador.style.display = "none";

                    if (data.d.toString() == "") {
                        tfControlador.style.display = "block";
                    }

                    $("#tbControlador").empty();

                    var lstControlador = data.d;
                    var qtd = 1;

                    $.each(lstControlador, function (index, lstControlador) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + qtd + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstControlador.serial + "</td>";

                        if (lstControlador.falha == "Falha Comunicação") {
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstControlador.falha + "</td>";
                        }
                        else {
                            var bitsFalha = parseInt(lstControlador.falha).toString(2);
                            var f = new verificaFalhas(bitsFalha);
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + f.falhas + "</td>";
                        }
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstControlador.porta + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstControlador.portaReset + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstControlador.ultimoReset + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstControlador.ip + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstControlador.atualizado + "</td>";
                        cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px;"> <a style="cursor:pointer;color:#0174DF;" onclick="habilitarResetControl(this)" data-id=' + lstControlador.serial + '>Resetar</a></td>';
                        cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px;"> <a style="cursor:pointer;color:#0174DF;"  data-toggle="modal" data-target="#popupEditPortaReset" onclick="selectDoorReset(this)" data-id=' + lstControlador.serial + ' data-portareset=' + lstControlador.portaReset + '>Editar porta reset</a></td>';
                        newRow.append(cols);
                        $("#tblControlador").append(newRow);

                        qtd++;
                    });

                    divLoad.style.display = "none";

                },
                error: function (data) {
                   // window.location.reload(true);
                }
            });
        }

        function habilitarResetControl(handler) {
            var serial = $(handler).attr("data-id");
            if (confirm("Realmente deseja resetar esse controlador?") == true) {
                $.ajax({
                    type: 'POST',
                    url: 'Default.asmx/ResetaControlador',
                    dataType: 'json',
                    data: "{'serial':'" + serial + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        $("#popupConfirmResetarControl").modal("hide");
                        $("#tblControlador tbody tr").each(function () {

                            var colunas = $(this).children();
                            if ($(colunas[1]).text() == serial) {
                                $(colunas[5]).html('Reset pendente');

                            }
                        });
                        alert("Resete solicitado com sucesso!");
                        
                    },
                    error: function (data) {
                        params = data; alert('Erro ao solicitar o resete,a pagina sera atualizada!');
                        window.location.reload(true);
                    }
                });
            }

        }

        function selectDoorReset(handler) {
            document.getElementById("hdfSerial").value = $(handler).attr("data-id");
            document.getElementById("txtPortaReset").value = $(handler).attr("data-portareset");
        }

        function editDoorReset() {
            var serial = document.getElementById("hdfSerial").value;
            var portaReset = document.getElementById("txtPortaReset").value;
            $.ajax({
                type: 'POST',
                url: 'Default.asmx/EditPortaReset',
                dataType: 'json',
                data: "{'serial':'" + serial + "','portaReset':'" + portaReset + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#popupEditPortaReset").modal("hide");
                    getControllers();
                },
                error: function (data) {
                    $("#popupEditPortaReset").modal("hide");
                }
            });
        }

        function verificaFalhas(bitsFalha) {
            this.falhas = "";

            if (bitsFalha == 0) {
                this.falhas = "Normal";
            }
            else {
                bitsFalha = bitsFalha.split('').reverse().join('');
                for (var positionBit = 0; positionBit < bitsFalha.length; positionBit++) {
                    //Falta de Energia
                    if (positionBit == 0 && bitsFalha[positionBit] == "1") {
                        this.falhas = "Falta de Energia";
                    }
                    //Subtensao
                    if (positionBit == 1 && bitsFalha[positionBit] == "1") {
                        if (this.falhas == "") {
                            this.falhas = "Subtensao";
                        }
                        else {
                            this.falhas += ",Subtensao";
                        }
                    }
                    //Apagado/Desligado
                    if (positionBit == 2 && bitsFalha[positionBit] == "1") {
                        if (this.falhas == "") {
                            this.falhas = "Apagado/Desligado";
                        }
                        else {
                            this.falhas += ",Apagado/Desligado";
                        }
                    }
                    //Amarelo intermitente
                    if (positionBit == 3 && bitsFalha[positionBit] == "1") {
                        if (this.falhas == "") {
                            this.falhas += "Amarelo intermitente";
                        }
                        else {
                            this.falhas += ",Amarelo intermitente";
                        }
                    }
                    //Estacionado
                    if (positionBit == 4 && bitsFalha[positionBit] == "1") {
                        if (this.falhas == "") {
                            this.falhas += "Estacionado";
                        }
                        else {
                            this.falhas += ",Estacionado";
                        }
                    }
                }
            }
        }
    </script>
</asp:Content>
