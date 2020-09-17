<%@ Page Title="Horario de Verão" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Admin.HorarioVerao.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hfId" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfUser" ClientIDMode="Static" runat="server" />
    <h2 id="titleCad" style="margin-bottom: 15px; border-bottom: 1px solid #D8D8D8; padding: 5px; margin-left: 10px; width: 800px;"><%= Resources.Resource.horarioVerao %>
    </h2>
    <hr />
    <div id="dvPesquisa">
        <div class="btn-group">
            <button type="button" class="btn btn-primary dropdown-toggle" style="width:130px;" data-toggle="dropdown">
                <%= Resources.Resource.gerar %> <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#" onclick="Gerar()"><%= Resources.Resource.horarioVerao %></a></li>
            </ul>
        </div>
        <div class="btn-group">
            <button type="button" class="btn btn-danger dropdown-toggle"data-toggle="dropdown">
                <%= Resources.Resource.enviarTodosControladores %> <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#" onclick="Enviar()"><%= Resources.Resource.sim %></a></li>
            </ul>
        </div>
        <br />
        <br />
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th><%= Resources.Resource.ano %></th>
                    <th><%= Resources.Resource.dataInicial %></th>
                    <th><%= Resources.Resource.dataFinal %></th>
                    <th><%= Resources.Resource.usuario %></th>
                    <th><%= Resources.Resource.ultimaAtualizacao %></th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="tbHorarioVerao">
            </tbody>
        </table>
    </div>
    <div class="container">
        <div class="modal fade" id="mpCad" role="dialog">
            <div class="modal-dialog" style="width: 80%">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%= Resources.Resource.horarioVerao %></h4>

                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <tr>
                                <td><%= Resources.Resource.ano %>:
                <input type="text" class="form-control" maxlength="4" id="txtAno" />
                                </td>
                                <td><%= Resources.Resource.dataInicial %>:
                <input type="text" class="form-control" maxlength="19" onblur="ValidaDataHora(this)" onkeypress="DataHora(event,this)" id="txtDtInicial" />
                                </td>
                                <td><%= Resources.Resource.dataFinal %>:
                <input type="text" class="form-control" id="txtDtFinal" maxlength="19" onblur="ValidaDataHora(this)" onkeypress="DataHora(event,this)" />
                                </td>
                            </tr>
                        </table>
                        <input type="button" class="btn btn-success" value="<%= Resources.Resource.salvar %>" onclick="Salvar()" id="btnSalvar" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <script type="text/javascript">

        $(function () {
            pesquisa();
        });

        function pesquisa() {
            $.ajax({
                url: 'Default.aspx/getHorarioVerao',
                data: "{}",
                dataType: "json",
                async: false,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbHorarioVerao").empty();
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst.Ano + "</td>";
                            cols += "<td>" + lst.DataInicial + "</td>";
                            cols += "<td>" + lst.DataFinal + "</td>";
                            cols += "<td>" + lst.User + "</td>";
                            cols += "<td>" + lst.DtHrAtualizacao + "</td>";

                            cols += "<td style='border-collapse: collapse; padding: 5px; width:150px'><input type=\"button\" style=\"width:150px;\" class=\"btn btn-warning\" value=\"<%= Resources.Resource.editar %>\" onclick=\"Editar(this)\" data-Ano='" + lst.Ano + "' data-dtinicial='" + lst.DataInicial + "' data-dtfinal='" + lst.DataFinal + "' data-id='" + lst.Id + "'/></td>";

                            newRow.append(cols);
                            $("#tbHorarioVerao").append(newRow);
                        }
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='7' style='border-collapse: collapse; padding: 5px;'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbHorarioVerao").append(newRow);
                    }

                },
                error: function (data) {
                }
            });
        }
        function Gerar() {
            $("#txtAno").val("");
            $("#txtDataInicial").val("");
            $("#txtDataFinal").val("");
            $("#hfId").val("");
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/Gerar',
                dataType: 'json',
                data: "{'user':'" + $("#hfUser").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    alert("<%= Resources.Resource.salvoComSucesso %>");
                    $("#mpCad").modal("hide");
                    pesquisa();
                },
                error: function (data) {

                }

            });
        }
        function Salvar() {
            if ($("#txtAno").val() == "" || $("#txtAno").val() == "0000") {
                $("#txtAno").css("border-color", "#ff0000");
                $("#txtAno").css("outline", "0");
                $("#txtAno").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtAno").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                return;
            }
            if ($("#txtDataInicial").val() == "") {
                $("#txtDataFinal").css("border-color", "");
                $("#txtDataFinal").css("box-shadow", "");

                $("#txtDataInicial").css("border-color", "#ff0000");
                $("#txtDataInicial").css("outline", "0");
                $("#txtDataInicial").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtDataInicial").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                return;
            }
            if ($("#txtDataFinal").val() == "") {
                $("#txtDataInicial").css("border-color", "");
                $("#txtDataInicial").css("box-shadow", "");

                $("#txtDataFinal").css("border-color", "#ff0000");
                $("#txtDataFinal").css("outline", "0");
                $("#txtDataFinal").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtDataFinal").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                return;
            }

            $("#txtDataInicial").css("border-color", "");
            $("#txtDataInicial").css("box-shadow", "");
            $("#txtAno").css("border-color", "");
            $("#txtAno").css("box-shadow", "");
            $("#txtDataFinal").css("border-color", "");
            $("#txtDataFinal").css("box-shadow", "");

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/Salvar',
                dataType: 'json',
                data: "{'Id':'" + $("#hfId").val() + "','Ano':'" + $("#txtAno").val() + "','DtInicial':'" + $("#txtDtInicial").val() + "','DtFinal':'" + $("#txtDtFinal").val() + "','user':'" + $("#hfUser").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        alert(data.d);
                        return;
                    }
                    
                    alert("<%= Resources.Resource.salvoComSucesso %>");
                    $("#mpCad").modal("hide");
                    pesquisa();
                },
                error: function (data) {

                }

            });
        }

        function Editar(btn) {
            $("#hfId").val(btn.dataset.id);
            $("#txtAno").val(btn.dataset.ano);
            $("#txtDtInicial").val(btn.dataset.dtinicial);
            $("#txtDtFinal").val(btn.dataset.dtfinal);
            $("#btnSalvar")[0].value = "<%= Resources.Resource.editar %>";
            $("#mpCad").modal("show");
        }
        function Enviar() {
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/Enviar',
                dataType: 'json',
                data: "{'user':'" + $("#hfUser").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    alert("<%= Resources.Resource.enviadoSucesso %>");
                },
                error: function (data) {

                }

            });
        }
        function validaData(stringData) {
            /******** VALIDA DATA NO FORMATO DD/MM/AAAA *******/

            var regExpCaracter = /[^\d]/;     //Expressão regular para procurar caracter não-numérico.
            var regExpEspaco = /^\s+|\s+$/g;  //Expressão regular para retirar espaços em branco.

            if (stringData.length != 10) {
                alert('<%= Resources.Resource.dataInvalida %> DD/MM/AAAA');
                return false;
            }

            splitData = stringData.split('/');

            if (splitData.length != 3) {
                alert('<%= Resources.Resource.dataInvalida %> DD/MM/AAAA');
                return false;
            }

            /* Retira os espaços em branco do início e fim de cada string. */
            splitData[0] = splitData[0].replace(regExpEspaco, '');
            splitData[1] = splitData[1].replace(regExpEspaco, '');
            splitData[2] = splitData[2].replace(regExpEspaco, '');

            if ((splitData[0].length != 2) || (splitData[1].length != 2) || (splitData[2].length != 4)) {
                //<!-- alert('Data fora do padrão DD/MM/AAAA'); -->
                return false;
            }

            /* Procura por caracter não-numérico. EX.: o "x" em "28/09/2x11" */
            if (regExpCaracter.test(splitData[0]) || regExpCaracter.test(splitData[1]) || regExpCaracter.test(splitData[2])) {
                //<!-- alert('Caracter inválido encontrado!'); -->
                return false;
            }

            dia = parseInt(splitData[0], 10);
            mes = parseInt(splitData[1], 10) - 1; //O JavaScript representa o mês de 0 a 11 (0->janeiro, 1->fevereiro... 11->dezembro)
            ano = parseInt(splitData[2], 10);

            var novaData = new Date(ano, mes, dia);

            /* O JavaScript aceita criar datas com, por exemplo, mês=14, porém a cada 12 meses mais um ano é acrescentado à data
                 final e o restante representa o mês. O mesmo ocorre para os dias, sendo maior que o número de dias do mês em
                 questão o JavaScript o converterá para meses/anos.
                 Por exemplo, a data 28/14/2011 (que seria o comando "new Date(2011,13,28)", pois o mês é representado de 0 a 11)
                 o JavaScript converterá para 28/02/2012.
                 Dessa forma, se o dia, mês ou ano da data resultante do comando "new Date()" for diferente do dia, mês e ano da
                 data que está sendo testada esta data é inválida. */
            if ((novaData.getDate() != dia) || (novaData.getMonth() != mes) || (novaData.getFullYear() != ano)) {
                //<!-- alert('Data Inválida!'); -->
                return false;
            }
            else {
                return true;
            }
        }

        function DataHora(evento, objeto) {
            var keypress = (window.event) ? event.keyCode : evento.which;
            campo = eval(objeto);
            if (campo.value == '00/00/0000 00:00:00') {
                campo.value = "";
            }
            if (campo.value.length == 11 && campo.value.substring(10, 11) == ' ') {
                campo.value = campo.value.substring(0, 10);
            }
            if (campo.value.length == 14 && campo.value.substring(13, 14) == ':') {
                campo.value = campo.value.substring(0, 13);
            }
            caracteres = '0123456789';
            separacao1 = '/';
            separacao2 = ' ';
            separacao3 = ':';
            conjunto1 = 2;
            conjunto2 = 5;
            conjunto3 = 10;
            conjunto4 = 13;
            conjunto5 = 16;
            conjunto6 = 19;
            if ((caracteres.search(String.fromCharCode(keypress)) != -1)) {

                if (campo.value.length >= 10) {
                    if (!validaData(campo.value.substring(0, 10))) {
                        $(objeto).css("border-color", "#ff0000");
                        $(objeto).css("outline", "0");
                        $(objeto).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                        $(objeto).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                        event.returnValue = false;
                    }
                    else {
                        $(objeto).css("border-color", "");
                        $(objeto).css("outline", "");
                        $(objeto).css("-webkit-box-shadow", "");
                        $(objeto).css("box-shadow", "");
                    }
                }
                var digito = parseInt(String.fromCharCode(keypress));
                if (campo.value.length == 3 && (digito > 1 || digito < 0)) {
                    event.returnValue = false;
                    return;
                }
                if ((campo.value.length == 5 || campo.value.length == 6) && (digito > 2 || digito < 2)) {
                    event.returnValue = false;
                    return;
                }
                if (campo.value.length == 7 && (digito > 0 || digito < 0)) {
                    event.returnValue = false;
                    return;
                }
                if (campo.value.length == 10 && (digito > 2 || digito < 0)) {
                    event.returnValue = false;
                    return;
                }
                if (campo.value.length == 12) {
                    var d2 = parseInt(campo.value.substring(11, 12));
                    if (d2 == 2 && digito > 3) {
                        event.returnValue = false;
                        return;
                    }
                }
                if (campo.value.length == 13 && (digito > 5 || digito < 0)) {
                    event.returnValue = false;
                    return;
                }

                if (campo.value.length < (19)) {
                    if (campo.value.length == conjunto1)
                        campo.value = campo.value + separacao1;
                    else if (campo.value.length == conjunto2)
                        campo.value = campo.value + separacao1;
                    else if (campo.value.length == conjunto3)
                        campo.value = campo.value + separacao2;
                    else if (campo.value.length == conjunto4)
                        campo.value = campo.value + separacao3;
                    else if (campo.value.length == conjunto5)
                        campo.value = campo.value + separacao3;
                    else if (campo.value.length == conjunto6)
                        campo.value = campo.value + separacao3;
                }
                else {
                    event.returnValue = false;
                }
            }
            else {
                event.returnValue = false;
            }
        }
        function ValidaDataHora(obj) {
            campo = eval(obj);
            if (campo.value.length < (16)) {
                $(obj).css("border-color", "#ff0000");
                $(obj).css("outline", "0");
                $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                obj.focus();
                $("#btnSalvar")[0].disabled = true;
                return false;
            }
            if (!validaData(campo.value.substring(0, 10))) {
                $(obj).css("border-color", "#ff0000");
                $(obj).css("outline", "0");
                $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                obj.focus();
                $("#btnSalvar")[0].disabled = true;
                return false;
            }
            var hora = parseInt(campo.value.substring(11, 13));
            var min = parseInt(campo.value.substring(14, 16));
            var seg = parseInt(campo.value.substring(17, 19));

            if (hora > 23) {
                $(obj).css("border-color", "#ff0000");
                $(obj).css("outline", "0");
                $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                obj.focus();
                $("#btnSalvar")[0].disabled = true;
                return false;
            }

            if (min > 59) {
                $(obj).css("border-color", "#ff0000");
                $(obj).css("outline", "0");
                $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                obj.focus();
                $("#btnSalvar")[0].disabled = true;
                return false;
            }

            if (seg > 59) {
                $(obj).css("border-color", "#ff0000");
                $(obj).css("outline", "0");
                $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                obj.focus();
                $("#btnSalvar")[0].disabled = true;
                return false;
            }
            $(obj).css("border-color", "");
            $(obj).css("outline", "");
            $(obj).css("-webkit-box-shadow", "");
            $(obj).css("box-shadow", "");
            $("#btnSalvar")[0].disabled = false;
            return true;
        }
    </script>
</asp:Content>
