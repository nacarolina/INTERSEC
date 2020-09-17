<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Versao.aspx.cs" Inherits="GwCentral.ProgramadorSemanforico.Versao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
    <style>
        .form-group input[type="checkbox"] {
            display: none;
        }

            .form-group input[type="checkbox"] + .btn-group > label span {
                width: 20px;
            }

                .form-group input[type="checkbox"] + .btn-group > label span:first-child {
                    display: none;
                }

                .form-group input[type="checkbox"] + .btn-group > label span:last-child {
                    display: inline-block;
                }

            .form-group input[type="checkbox"]:checked + .btn-group > label span:first-child {
                display: inline-block;
            }

            .form-group input[type="checkbox"]:checked + .btn-group > label span:last-child {
                display: none;
            }

        .auto-style1 {
            height: 38px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hfIdPrefeitura" ClientIDMode="Static" runat="server" />
    <h2 id="titleCad" style="margin-bottom: 15px; border-bottom: 1px solid #D8D8D8; padding: 5px; margin-left: 10px; width: 800px;">
        <%= Resources.Resource.versao %>
    </h2>
    <hr />
    <div id="dvVersao">
        <table style="width: 100%">
            <tr>
                <td style="padding-left: 10px;">
                    <input type="button" value="<%= Resources.Resource.novo %>" align="left" class="btn btn-danger" onclick="NovoCadVersao()" />
                </td>
            </tr>
        </table>
        <br />
        <table class="table table-bordered" style="width: 100%">
            <thead>
                <tr>
                    <th><%= Resources.Resource.versao %></th>
                    <th><%= Resources.Resource.data %></th>
                    <th><%= Resources.Resource.descricao %></th>
                    <th><%= Resources.Resource.ativo %></th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="tbVersao">
                <tr>
                    <td colspan="5"><%= Resources.Resource.naoHaRegistros %></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="mpCadVersao" role="dialog">
        <div class="modal-dialog" style="width: 40%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%= Resources.Resource.cadastrar %></h4>
                </div>
                <div class="modal-body">
                    <div>
                        <table class="table table-bordered" style="width: 100%">
                            <tr>
                                <td><%= Resources.Resource.versao %>:
                                        <input type="text" id="txtVersao" class="form-control" style="width: 40%" />
                                </td>
                            </tr>
                            <tr>
                                <td><%= Resources.Resource.data %>:
                                        <input type="text" id="txtData" class="form-control" style="width: 50%" maxlength="19" onblur="ValidaDataHora(this)" onkeypress="DataHora(event,this)" placeholder="00/00/0000 00:00:00" />
                                </td>
                            </tr>
                            <tr>
                                <td><%= Resources.Resource.descricao %>:
                                    <textarea id="txtDsc" class="form-control" style="width: 100%"></textarea>
                                </td>
                            </tr>
                        </table>
                        <br />
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" value="<%= Resources.Resource.salvar %>" class="btn btn-success" style="width: 100px" onclick="SalvarVersao()" />
                    <input type="button" value="<%= Resources.Resource.cancelar %>" class="btn btn-danger" style="width: 100px" onclick="FecharCadVersao()" />
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="mpEditaVersao" role="dialog">
        <div class="modal-dialog" style="width: 40%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%= Resources.Resource.editar %></h4>
                </div>
                <div class="modal-body">
                    <div>
                        <table class="table table-bordered" style="width: 100%">
                            <tr>
                                <td><%= Resources.Resource.versao %>:
                                        <input type="text" id="txtEditaVersao" class="form-control" style="width: 40%" />
                                </td>
                            </tr>
                            <tr>
                                <td><%= Resources.Resource.data %>:
                                        <input type="text" id="txtEditaData" class="form-control" style="width: 50%" maxlength="19" onblur="ValidaDataHora(this)" onkeypress="DataHora(event,this)" placeholder="00/00/0000 00:00:00" />
                                </td>
                            </tr>
                            <tr>
                                <td><%= Resources.Resource.descricao %>:
                                    <textarea id="txtEditaDsc" class="form-control" style="width: 100%"></textarea>
                                </td>
                            </tr>
                        </table>
                        <br />
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" value="<%= Resources.Resource.salvar %>" class="btn btn-success" style="width: 100px" onclick="EditarVersao()" />
                    <input type="button" value="<%= Resources.Resource.cancelar %>" class="btn btn-danger" style="width: 100px" onclick="FecharEditaVersao()" />
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
            loadMunicipio();
            GetVersao();
        });

        function GetVersao() {
            $.ajax({
                type: 'POST',
                url: 'Versao.aspx/GetVersao',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbVersao").empty();
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst.Versao + "</td>";
                            cols += "<td>" + lst.Data + "</td>";
                            cols += "<td>" + lst.Dsc + "</td>";
                            if (lst.Ativo == "True")
                                cols += "<td><input type='checkbox' checked disabled></td>";
                            else
                                cols += "<td><input type='checkbox' disabled></td>";
                            cols += "<td><button type= 'button' class='btn btn-primary' onclick= 'abrirEditarVersao(this)' data-versao='" + lst.Versao + "' data-dthr='" + lst.Data + "' data-dsc='" + lst.Dsc + "'><%= Resources.Resource.editar %></button></td>";

                            newRow.append(cols);
                            $("#tbVersao").append(newRow);
                        }
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='5'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbVersao").append(newRow);
                    }
                },
                error: function (data) {
                }
            });
        }


        function abrirEditarVersao(btn) {
            $("#mpEditaVersao").modal("show");
            $("#txtEditaVersao").val(btn.dataset.versao).attr("disabled", true);
            $("#txtEditaData").val(btn.dataset.dthr);
            $("#txtEditaDsc").val(btn.dataset.dsc);
            //$("#sleMnc").val($("#sleMnc").val());
        }

        function EditarVersao() {
            $.ajax({
                type: 'POST',
                url: 'Versao.aspx/EditarVersao',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','versao':'" + $("#txtEditaVersao").val() + "','dthr':'" + $("#txtEditaData").val() + "','dsc':'" + $("#txtEditaDsc").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "SUCESSO") {
                        //alert(data.d);
                    }
                    else {
                        alert("<%= Resources.Resource.salvoComSucesso %>");
                        $("#txtEditaVersao").val("");
                        $("#txtEditaData").val("");
                        $("#txtEditaDsc").val("");
                        GetVersao();
                        $("#mpEditaVersao").modal("hide");
                    }
                }
            });
        }

        function FecharEditaVersao() {
            $("#mpEditaVersao").modal("hide");
        }


        function NovoCadVersao() {
            $("#mpCadVersao").modal("show");
            $("#txtVersao").val("");
            $("#txtData").val("");
            $("#txtDsc").val("");
            $("#sleMnc").val($("#sleMnc").val());
        }

        function loadMunicipio(idMnc) {
            $.ajax({
                url: 'Versao.aspx/loadMunicipio',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
                dataType: "json",
                async: false,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#sleMnc").empty();
                    $.each(data.d, function () {
                        $("#sleMnc").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    if (idMnc != '') {
                        $("#sleMnc").val(idMnc);
                    }
                },
                error: function (data) {

                }
            });
        }


        function FecharCadVersao() {
            $("#mpCadVersao").modal("hide");
        }


        function SalvarVersao() {
            if ($("#txtVersao").val() == "") {
                $("#txtVersao").css("border-color", "#ff0000");
                $("#txtVersao").css("outline", "0");
                $("#txtVersao").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtVersao").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#txtVersao").focus();
                return false;
            }
            $("#txtVersao").css("border-color", "");
            $("#txtVersao").css("box-shadow", "");

            $.ajax({
                type: 'POST',
                url: 'Versao.aspx/SalvarVersao',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','versao':'" + $("#txtVersao").val() + "','data':'" + $("#txtData").val() + "','dsc':'" + $("#txtDsc").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "SUCESSO") {
                        alert(data.d);
                    }
                    else {
                        $("#txtVersao").val("");
                        GetVersao();
                        $("#sleMnc").val($("#sleMnc").val());
                        $("#mpCadVersao").modal("hide");
                        alert("<%= Resources.Resource.salvoComSucesso %>");
                    }
                },
                error: function (data) {

                }
            });
        }

        //function changeVersaoAtual(chk) {
        //    if (chk.checked == true) {

        //        $.ajax({
        //            type: 'POST',
        //            url: 'Versao.aspx/changeVersaoAtual',
        //            dataType: 'json',
        //            data: "{'email':'" + $("#lblUsuarioRegra")[0].title + "', 'nomerole':'" + chk.value + "'}",
        //            contentType: "application/json; charset=utf-8",
        //            success: function (data) {
        //                if (data.d != "SUCESSO") {
        //                    alert("Erro ao salvar no banco de dados!");
        //                }
        //            },
        //            error: function (data) {
        //            }
        //        });
        //    }
        //    else {
        //        $.ajax({
        //            type: 'POST',
        //            url: 'Versao.aspx/changeVersaoAtual',
        //            dataType: 'json',
        //            data: "{'email':'" + $("#lblUsuarioRegra")[0].title + "', 'nomerole':'" + chk.value + "'}",
        //            contentType: "application/json; charset=utf-8",
        //            success: function (data) {
        //                if (data.d != "SUCESSO") {
        //                    alert("Erro ao salvar no banco de dados!");
        //                }
        //            },
        //            error: function (data) {
        //            }
        //        });
        //    }
        //}


        //       VALIDAÇÃO  DATAHORA          //
        function Hora(evento, objeto) {
            var keypress = (window.event) ? event.keyCode : evento.which;
            campo = eval(objeto);
            caracteres = '0123456789';
            separacao1 = '/';
            separacao2 = ' ';
            separacao3 = ':';
            conjunto1 = 2;
            conjunto2 = 5;
            conjunto3 = 10;
            conjunto4 = 13;
            conjunto5 = 16;
            if ((caracteres.search(String.fromCharCode(keypress)) != -1)) {

                var digito = parseInt(String.fromCharCode(keypress));
                if (campo.value.length == 0 && (digito > 2 || digito < 0)) {
                    event.returnValue = false;
                    return;
                }
                if (campo.value.length < (8)) {
                    if (campo.value.length == conjunto1)
                        campo.value = campo.value + separacao3;
                    else if (campo.value.length == conjunto2)
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
        function validaHora(obj) {
            campo = eval(obj);
            if (campo.value.length < (8)) {
                $(obj).css("border-color", "#ff0000");
                $(obj).css("outline", "0");
                $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                obj.focus();
                $("#btnSalvar")[0].disabled = true;
                return false;
            }
            var hora = parseInt(campo.value.substring(0, 2));
            var min = parseInt(campo.value.substring(3, 5));
            var seg = parseInt(campo.value.substring(6, 8));

            if (hora > 23) {
                $(obj).css("border-color", "#ff0000");
                $(obj).css("outline", "0");
                $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                obj.focus();
                $("#btnSalvar")[0].disabled = true;
                return false;
            }
            if (hora < 10)
                hora = "0" + hora;
            if (min > 59) {
                $(obj).css("border-color", "#ff0000");
                $(obj).css("outline", "0");
                $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                obj.focus();
                $("#btnSalvar")[0].disabled = true;
                return false;
            }

            if (min < 10)
                min = "0" + min;
            if (seg > 59) {
                $(obj).css("border-color", "#ff0000");
                $(obj).css("outline", "0");
                $(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                obj.focus();
                $("#btnSalvar")[0].disabled = true;
                return false;
            }
            if (seg < 10)
                seg = "0" + seg;

            if (hora == "0")
                hora = "00";
            if (min == "0")
                min = "00";
            if (seg == "0")
                seg = "00";
            $(obj).val(hora + ":" + min + ":" + seg);
            $(obj).css("border-color", "");
            $(obj).css("outline", "");
            $(obj).css("-webkit-box-shadow", "");
            $(obj).css("box-shadow", "");
            $("#btnSalvar")[0].disabled = false;
            return true;
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
