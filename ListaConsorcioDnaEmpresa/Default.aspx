<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.ListaConsorcioDnaEmpresa.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style4 {
            width: 52px;
        }

        .auto-style7 {
            width: 178px;
        }

        .auto-style8 {
            width: 1250px;
        }

        .auto-style9 {
            width: 335px;
        }

        .auto-style11 {
            width: 177px;
        }

        .auto-style13 {
            width: 131px;
        }

        .auto-style14 {
            width: 308px;
        }

        .auto-style15 {
            width: 116px;
        }

        .auto-style16 {
            color: #333333;
        }

        #snackbar {
            visibility: hidden;
            min-width: 250px;
            margin-left: -125px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 2px;
            padding: 16px;
            position: fixed;
            z-index: 1;
            left: 50%;
            bottom: 30px;
            font-size: 17px;
        }

            #snackbar.show {
                visibility: visible;
                -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
                animation: fadein 0.5s, fadeout 0.5s 2.5s;
            }

            #snackbar_EditarEmpresa {
            visibility: hidden;
            min-width: 250px;
            margin-left: -125px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 2px;
            padding: 16px;
            position: fixed;
            z-index: 999999;
            left: 50%;
            bottom: 30px;
            font-size: 17px;
        }

            #snackbar_EditarEmpresa.show {
                visibility: visible;
                -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
                animation: fadein 0.5s, fadeout 0.5s 2.5s;
            }
            
             #snackbar_Editado {
            visibility: hidden;
            min-width: 250px;
            margin-left: -125px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 2px;
            padding: 16px;
            position: fixed;
            z-index: 999999;
            left: 50%;
            bottom: 30px;
            font-size: 17px;
        }

            #snackbar_Editado.show {
                visibility: visible;
                -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
                animation: fadein 0.5s, fadeout 0.5s 2.5s;
            }

        @-webkit-keyframes fadein {
            from {
                bottom: 0;
                opacity: 0;
            }

            to {
                bottom: 30px;
                opacity: 1;
            }
        }

        @keyframes fadein {
            from {
                bottom: 0;
                opacity: 0;
            }

            to {
                bottom: 30px;
                opacity: 1;
            }
        }

        @-webkit-keyframes fadeout {
            from {
                bottom: 30px;
                opacity: 1;
            }

            to {
                bottom: 0;
                opacity: 0;
            }
        }

        @keyframes fadeout {
            from {
                bottom: 30px;
                opacity: 1;
            }

            to {
                bottom: 0;
                opacity: 0;
            }
        }

        #tblDNAsbyConsorcio tr
        {
            background-color:white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <h2 style="margin-bottom: 15px; border-bottom: 1px solid #D8D8D8; color: black; padding-left: 12px; font-size: x-large;">Lista de DNA por Consórcio - Empresas </h2>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div id="divLoad" style="width: 100%; height: 100%; background-color: #D8D8D8; position: absolute; display: none; opacity: 0.4;">
        <p style="padding-left: 50%; padding-top: 10%; position: absolute;">
            <img id="imgLoad" alt="Carregando" src="../../Images/carregando.gif" />
        </p>
    </div>

    <table style="margin-left: 10px;">
        <tr>
            <td class="auto-style14">
                <select id="cboConsorcio" name="D1" onchange="CarregaEmpresas(this);">
                    <option value="66">Selecione o consórcio</option>
                    <option value="24">CONSORCIO SINAL PAULISTANO</option>
                    <option value="25">CONSORCIO ONDAVERDE</option>
                    <option value="23">CONSORCIO MCS</option>
                    <option value="27">CONSORCIO SEMAFORICO PAULISTANO</option>
                    <option value="0">CET</option>
                </select></td>
            <td class="auto-style15">

                <input type="button" class="btn-default" id="btnCarregar" value="Visualisar" onclick="getDNAsbyConsorcio();" /></td>
            <td class="auto-style11">

                <select id="cboEmpresas" name="D2">
                    <option value="66">Selecione a Empresa</option>
                </select></td>
            <td class="auto-style13">

                <input type="button" class="btn-default" id="btnCarregarEmpresa" value="Visualisar" onclick="getDNAsbyEmpresa();" /></td>
            <td class="auto-style11">

                <input type="text" id="txtDNA" placeholder="ID do Ponto" style="width: 150px;" />

            </td>
            <td class="auto-style13">

                <input type="button" class="btn-default" id="btnCarregarDNA" value="Visualisar" onclick="getDNAsbyIDPonto();" />

            </td>
            <td class="auto-style13">
                <span id="lblQtd">Total Filtrado: 0000</span>
            </td>
            <td>
                <span id="lblTotalGeral">Qtd Total DNA: 0000</span>
            </td>
        </tr>
    </table>

    <input type="button" class="btn-default" style="margin-left: 10px; margin-top: 10px; border-radius: 4px; display: none;" id="btnAlterar" value="Editar Selecionado(s)" onclick="AlterarSelecionados();" />
    <div id="snackbar">Selecione o(s) cruzamento(s) que deseja alterar!</div>
     <div id="snackbar_EditarEmpresa">Selecione a empresa!</div>
    <div id="snackbar_Editado">Cruzamento(s) editado(s) com Sucesso!</div>
    <table id="tblDNAsbyConsorcio" class="tblgrid" style="margin-top: 10px; width: 100%;">
        <thead>
            <tr>
                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;" class="auto-style4"></th>
                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;" class="auto-style4">#</th>
                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;" class="auto-style4">Id</th>
                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;" class="auto-style8">Endereco</th>
                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;" class="auto-style9">Consorcio</th>
                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;" class="auto-style7">Empresa</th>
                <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;"></th>
            </tr>
        </thead>
        <tbody id="tbDNAsbyConsorcio"></tbody>
        <tfoot id="tfDNAsbyConsorcio">
            <tr>
                <td><b class="auto-style16">Não há registros.</b>
                </td>
            </tr>
        </tfoot>
    </table>

    <div id="popupEditEmpresa" class="modal fade" role="dialog">
        <asp:HiddenField ID="hdfDna" runat="server" ClientIDMode="Static" />
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">
                        <img src="../Images/openDoor.png" style="width: 42px; height: 42px;" alt="" />Editar empresa</h4>
                </div>
                <div class="modal-body">
                    <p>
                        Empresa:
                           
                        <select id="cboEmpresasEditar" name="D2">
                            <option value="66">Selecione a Empresa</option>
                        </select>
                    </p>
                </div>
                <div class="modal-footer">
                    <input id="btnConfirm" type="button" value="Confirmar" style="width: 100px;" class="btn btn-default" onclick="editEmpresa();" />
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />


    <script type="text/javascript">
        var array_DnaAlterar = [];
        GetTotalGeral();
        var TipoAlterar = "";

        function AlterarSelecionados() {
            array_DnaAlterar = [];
            var table = $("#tblDNAsbyConsorcio tbody");
            table.find('tr').each(function (i, el) {
                var dna = {};
                var $tds = $(this).find('td'),
                    Chk = $tds[0].lastChild.checked,
                                    dna = $tds[2].innerHTML
                if (Chk == true) {
                    array_DnaAlterar.push(dna);
                }
            });
            if (array_DnaAlterar.length != 0) {
                $("#popupEditEmpresa").modal("show");
                TipoAlterar = "Lista";
            }
            else
            {
                var x = document.getElementById("snackbar")
                x.className = "show";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 3000);
            }
        }

        function GetTotalGeral() {
            $.ajax({
                type: 'POST',
                url: 'wService.asmx/qtdDna',
                dataType: 'json',
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var dados = data.d;
                    document.getElementById("lblTotalGeral").innerHTML = "Qtd Total DNA: " + dados;
                },
                error: function (data) {
                    alert('Erro ao obter parametros, a pagina será recarregada!');
                    window.location.reload(true);
                }
            });
        }

        function CarregaEmpresas(cboConsorcio) {
            var IdConsorcio = cboConsorcio.value;

            $.ajax({
                type: 'POST',
                url: 'wService.asmx/GetEmpresasbyConsorcio',
                dataType: 'json',
                data: "{'idConsorcio':'" + IdConsorcio + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#cboEmpresas").empty().append($("<option></option>").val("[0]").html("Selecione a Empresa"));
                    $("#cboEmpresasEditar").empty().append($("<option></option>").val("[0]").html("Selecione a Empresa"));
                    var posicao = 0;
                    while (posicao < data.d.length) {
                        $("#cboEmpresas").append($("<option></option>").val(posicao).html(data.d[posicao]));
                        $("#cboEmpresasEditar").append($("<option></option>").val(posicao).html(data.d[posicao]));
                        posicao++;
                    }

                },
                error: function (data) {
                    alert('Erro ao obter parametros, a pagina será recarregada!');
                    window.location.reload(true);
                }
            });
        }

        function getDNAsbyConsorcio() {
            var cboCons = document.getElementById("cboConsorcio");
            var idConsorcio = cboCons.options[cboCons.selectedIndex].value;

            var PermitiAlterar = true;
            var Consorcio = cboCons.options[cboCons.selectedIndex].innerText;
            $.ajax({
                type: 'POST',
                url: 'wService.asmx/PermissaoConsorcio',
                dataType: 'json',
                data: "{'Consorcio':'" + Consorcio + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d == "SIM") {
                        PermitiAlterar = true;
                    }
                    if (data.d == "NAO") {
                        PermitiAlterar = false;
                    }
                },
                error: function (data) {
                    params = data; alert('Erro ao obter parametros!');
                    window.location.reload(true);
                }
            });


            divLoad.style.display = "block";
            $.ajax({
                type: 'POST',
                url: 'wService.asmx/GetDNAbyConsorcio',
                dataType: 'json',
                data: "{'idConsorcio':'" + idConsorcio + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.length == 0) {
                        document.getElementById("btnAlterar").style.display = "none";
                    }
                    else {
                        document.getElementById("btnAlterar").style.display = "block";
                    }

                    tfDNAsbyConsorcio.style.display = "none";

                    if (data.d.toString() == "") {
                        tfDNAsbyConsorcio.style.display = "block";
                    }

                    $("#tbDNAsbyConsorcio").empty();

                    var lstDNAsbyConsorcio = data.d;
                    var qtd = 1;

                    $.each(lstDNAsbyConsorcio, function (index, lstDNAsbyConsorcio) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;text-align: center;'> <input type=\"checkbox\" class=\"btn-default\" id=\"chkAlterar\" /></td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + qtd + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyConsorcio.dna + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyConsorcio.endereco + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyConsorcio.consorcio + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyConsorcio.empresa + "</td>";
                        if (PermitiAlterar == true) {
                            cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px;"> <a style="cursor:pointer;color:#0174DF;"  data-toggle="modal" data-target="#popupEditEmpresa" onclick="selectEmpresa(this)" data-id=' + lstDNAsbyConsorcio.dna + ' data-empresa=' + lstDNAsbyConsorcio.empresa + '>Editar</a></td>';
                        }
                        newRow.append(cols);
                        $("#tblDNAsbyConsorcio").append(newRow);

                        qtd++;
                    });

                    divLoad.style.display = "none";
                    document.getElementById("lblQtd").innerText = "Total Filtrado: " + (qtd - 1);
                },
                error: function (data) {
                    params = data; alert('Erro ao obter parametros!');
                    window.location.reload(true);
                }
            });
        }

        function getDNAsbyConsorcio_SemComparar() {
            var cboCons = document.getElementById("cboConsorcio");
            var idConsorcio = cboCons.options[cboCons.selectedIndex].value;

            var PermitiAlterar = true;
            var Consorcio = cboCons.options[cboCons.selectedIndex].innerText;
            $.ajax({
                type: 'POST',
                url: 'wService.asmx/PermissaoConsorcio',
                dataType: 'json',
                data: "{'Consorcio':'" + Consorcio + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d == "SIM") {
                        PermitiAlterar = true;
                    }
                    if (data.d == "NAO") {
                        PermitiAlterar = false;
                    }
                },
                error: function (data) {
                    params = data; alert('Erro ao obter parametros!');
                    window.location.reload(true);
                }
            });


            divLoad.style.display = "block";
            $.ajax({
                type: 'POST',
                url: 'wService.asmx/GetDNAbyConsorcio_SemComparar',
                dataType: 'json',
                data: "{'idConsorcio':'" + idConsorcio + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.length == 0) {
                        document.getElementById("btnAlterar").style.display = "none";
                    }
                    else {
                        document.getElementById("btnAlterar").style.display = "block";
                    }

                    tfDNAsbyConsorcio.style.display = "none";

                    if (data.d.toString() == "") {
                        tfDNAsbyConsorcio.style.display = "block";
                    }

                    $("#tbDNAsbyConsorcio").empty();

                    var lstDNAsbyConsorcio = data.d;
                    var qtd = 1;

                    $.each(lstDNAsbyConsorcio, function (index, lstDNAsbyConsorcio) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;text-align: center;'> <input type=\"checkbox\" class=\"btn-default\" id=\"chkAlterar\" /></td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + qtd + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyConsorcio.dna + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyConsorcio.endereco + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyConsorcio.consorcio + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyConsorcio.empresa + "</td>";
                        if (PermitiAlterar == true) {
                            cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px;"> <a style="cursor:pointer;color:#0174DF;"  data-toggle="modal" data-target="#popupEditEmpresa" onclick="selectEmpresa(this)" data-id=' + lstDNAsbyConsorcio.dna + ' data-empresa=' + lstDNAsbyConsorcio.empresa + '>Editar</a></td>';
                        }
                        newRow.append(cols);
                        $("#tblDNAsbyConsorcio").append(newRow);

                        qtd++;
                    });

                    divLoad.style.display = "none";
                    document.getElementById("lblQtd").innerText = "Total Filtrado: " + (qtd - 1);
                },
                error: function (data) {
                    params = data; alert('Erro ao obter parametros!');
                    window.location.reload(true);
                }
            });
        }


        function getDNAsbyEmpresa() {
            var cboEmp = document.getElementById("cboEmpresas");
            var cboConsorcio = document.getElementById("cboConsorcio");
            var Empresa = cboEmp.options[cboEmp.selectedIndex].innerText;

            var PermitiAlterar = true;
            var Consorcio = cboConsorcio.options[cboConsorcio.selectedIndex].innerText;
            $.ajax({
                type: 'POST',
                url: 'wService.asmx/PermissaoConsorcio',
                dataType: 'json',
                data: "{'Consorcio':'" + Consorcio + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d == "SIM") {
                        PermitiAlterar = true;
                    }
                    if (data.d == "NAO") {
                        PermitiAlterar = false;
                    }
                },
                error: function (data) {
                    params = data; alert('Erro ao obter parametros!');
                    window.location.reload(true);
                }
            });

            divLoad.style.display = "block";
            $.ajax({
                type: 'POST',
                url: 'wService.asmx/GetDNAbyEmpresa',
                dataType: 'json',
                data: "{'empresa':'" + Empresa + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d.length == 0) {
                        document.getElementById("btnAlterar").style.display = "none";
                    }
                    else {
                        document.getElementById("btnAlterar").style.display = "block";
                    }

                    tfDNAsbyConsorcio.style.display = "none";

                    if (data.d.toString() == "") {
                        tfDNAsbyConsorcio.style.display = "block";
                    }

                    $("#tbDNAsbyConsorcio").empty();

                    var lstDNAsbyEmpresa = data.d;
                    var qtd = 1;

                    $.each(lstDNAsbyEmpresa, function (index, lstDNAsbyEmpresa) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;text-align: center;'> <input type=\"checkbox\" class=\"btn-default\" id=\"chkAlterar\" /></td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + qtd + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyEmpresa.dna + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyEmpresa.endereco + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyEmpresa.consorcio + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyEmpresa.empresa + "</td>";
                        if (PermitiAlterar == true) {
                            cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px;"> <a style="cursor:pointer;color:#0174DF;"  data-toggle="modal" data-target="#popupEditEmpresa" onclick="selectEmpresa(this)" data-id=' + lstDNAsbyEmpresa.dna + ' data-empresa=' + lstDNAsbyEmpresa.empresa + '>Editar</a></td>';
                        }
                        newRow.append(cols);
                        $("#tblDNAsbyConsorcio").append(newRow);

                        qtd++;
                    });

                    divLoad.style.display = "none";
                    document.getElementById("lblQtd").innerText = "Total Filtrado: " + (qtd - 1);
                },
                error: function (data) {
                    params = data; alert('Erro ao obter parametros!');
                    window.location.reload(true);
                }
            });
        }

        function getDNAsbyIDPonto() {
            var txtDNA = document.getElementById("txtDNA");
            var IdPonto = txtDNA.value;

            divLoad.style.display = "block";
            $.ajax({
                type: 'POST',
                url: 'wService.asmx/GetDNAbyIdPonto',
                dataType: 'json',
                data: "{'IdPonto':'" + IdPonto + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d.length == 0) {
                        document.getElementById("btnAlterar").style.display = "none";
                    }
                    else {
                        document.getElementById("btnAlterar").style.display = "block";
                    }

                    tfDNAsbyConsorcio.style.display = "none";

                    if (data.d.toString() == "") {
                        tfDNAsbyConsorcio.style.display = "block";
                    }

                    $("#tbDNAsbyConsorcio").empty();

                    var lstDNAsbyEmpresa = data.d;
                    var qtd = 1;

                    $.each(lstDNAsbyEmpresa, function (index, lstDNAsbyEmpresa) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;text-align: center;'> <input type=\"checkbox\" class=\"btn-default\" id=\"chkAlterar\" /></td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + qtd + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyEmpresa.dna + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyEmpresa.endereco + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyEmpresa.consorcio + "</td>";
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lstDNAsbyEmpresa.empresa + "</td>";

                        var options = document.getElementById('cboConsorcio').options;
                        var i = 0;
                        while (i < options.length) {
                            if (options[i].label == lstDNAsbyEmpresa.consorcio) {
                                options[i].selected = true;
                                i = options.length;
                            }
                            i++;
                        }

                        CarregaEmpresas(document.getElementById('cboConsorcio'));

                        var PermitiAlterar = true;

                        if (lstDNAsbyEmpresa.PermiteAlterar == "SIM") {
                            PermitiAlterar = true;
                        }
                        if (lstDNAsbyEmpresa.PermiteAlterar == "NAO") {
                            PermitiAlterar = false;
                        }

                        if (PermitiAlterar == true) {
                            cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px;"> <a style="cursor:pointer;color:#0174DF;"  data-toggle="modal" data-target="#popupEditEmpresa" onclick="selectEmpresa(this)" data-id=' + lstDNAsbyEmpresa.dna + ' data-empresa=' + lstDNAsbyEmpresa.empresa + '>Editar</a></td>';
                        }
                        newRow.append(cols);
                        $("#tblDNAsbyConsorcio").append(newRow);

                        qtd++;
                    });

                    divLoad.style.display = "none";
                    document.getElementById("lblQtd").innerText = "Total Filtrado: " + (qtd - 1);
                },
                error: function (data) {
                    params = data; alert('Erro ao obter parametros!');
                    window.location.reload(true);
                }
            });
        }



        function selectEmpresa(handler) {
            TipoAlterar = "Item";
            document.getElementById("hdfDna").value = $(handler).attr("data-id");

            var options = document.getElementById('cboEmpresasEditar').options;
            var i = 0;
            while (i < options.length) {
                if (options[i].label == $(handler).attr("data-empresa")) {
                    options[i].selected = true;
                    return;
                }
                i++;
            }
        }

        function editEmpresa() {
            var cboEmp = document.getElementById("cboEmpresasEditar");
            var empresa = cboEmp.options[cboEmp.selectedIndex].innerText;

            if (empresa == "Selecione a Empresa")
            {
                var x = document.getElementById("snackbar_EditarEmpresa");
                x.className = "show";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 3000);
                return;
            }

            if (TipoAlterar == "Item")
            {
                var dna = document.getElementById("hdfDna").value;
                $.ajax({
                    type: 'POST',
                    url: 'wService.asmx/EditEmpresa',
                    dataType: 'json',
                    data: "{'dna':'" + dna + "','empresa':'" + empresa + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                    },
                    error: function (data) {
                        $("#popupEditEmpresa").modal("hide");
                    }
                });
            }

            if (TipoAlterar == "Lista") {
                var i = 0;
                while (i < array_DnaAlterar.length)
                {
                    var dna = array_DnaAlterar[i];
                    $.ajax({
                        type: 'POST',
                        url: 'wService.asmx/EditEmpresa',
                        dataType: 'json',
                        data: "{'dna':'" + dna + "','empresa':'" + empresa + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            
                        },
                        error: function (data) {
                            $("#popupEditEmpresa").modal("hide");
                        }
                    });
                    i++;
                }    
            }
            $("#popupEditEmpresa").modal("hide");
            getDNAsbyConsorcio_SemComparar();
            var x = document.getElementById("snackbar_Editado");
                x.className = "show";
                setTimeout(function () { x.className = x.className.replace("show", ""); }, 3000);
        }

    </script>
</asp:Content>
