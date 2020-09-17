<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Aviso.aspx.cs" Inherits="GwCentral.Aviso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />

    <script src="assets/sweetalert-dev.js"></script>
    <link href="assets/sweetalert.css" rel="stylesheet" />
    <script src="eneter-messaging-6.0.1.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
	<h2 style="margin-bottom: 15px; border-bottom: 1px solid #D8D8D8; padding: 5px; margin-left: 10px; width: 800px;">
		<asp:HiddenField ID="hfUser" ClientIDMode="Static" runat="server" />
		<img src="Images/warning-128.png" style="width: 42px; height: 42px;" />
		<%= Resources.Resource.alarmes %></h2>
	<hr />
	<div>
		<table class="table table-bordered">
			<tr>
				<td>
					<%= Resources.Resource.dataInicial %>:
                                        <input type="text" class="form-control" id="txtDtInicialAvisos" maxlength="10" onblur="ValidaData(this)" onkeypress="Data(event,this)" />
				</td>
				<td>
					<%= Resources.Resource.dataFinal %>:
                                        <input type="text" class="form-control" id="txtDtFinalAvisos" maxlength="10" onblur="ValidaData(this)" onkeypress="Data(event,this)" />
				</td>
				<td>Id Eqp:
                                     <input id="txtIdEqp" type="text" onkeyup="FiltraAvisos(this.value,'ideqp')" class="form-control" />
				</td>
			</tr>
			<tr>
				<td colspan="3"><%= Resources.Resource.falhas %> ou <%= Resources.Resource.funcao %>:
                                         <input id="txtFalha" type="text" class="form-control" />
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<input type="button" id="btnFiltrarAvisos" class="btn btn-primary" style="margin-top: 18px" onclick="FiltraAvisos(this.value, 'pesquisa')" value="<%= Resources.Resource.pesquisar %>" />
					<input type="button" id="" class="btn btn-default" style="margin-top: 18px" onclick="Imprimir()" value="<%= Resources.Resource.imprimir %>" />
				</td>
			</tr>
		</table>

	</div>
	<div id="divAvisos" style="overflow-y: scroll; margin-top: 10px;">
		<label id="lblQtd">Qtd:</label>
		<table id="tblAvisos" class="table table-bordered table-striped table-hover" style="width: 100%; border-collapse: collapse;">
			<thead>
				<tr>
					<th style='line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left;'>Id Eqp.</th>
					<th style='line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left;'><%= Resources.Resource.falhas %></th>
					<th style='line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left;'><%= Resources.Resource.funcao %> </th>
					<th style='line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left;'><%= Resources.Resource.data %> - <%= Resources.Resource.falhas %></th>
					<th style='line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left;'></th>
				</tr>
			</thead>
			<tbody id="tbAvisos"></tbody>
		</table>
	</div>
	<div id="divLoading" style="display: none;">
		<div style="z-index: 9999; background-color: rgba(0,0,0,.4); position: fixed; width: 100%; height: 100%; transition: background-color .1s; top: 0;">
			<div style="background-color: #fff; width: 300px; height: 320px; text-align: center; z-index: 10; padding-left: 75px; padding-top: 30px; border-radius: 10px; position: absolute; margin: auto; top: 0; right: 0; bottom: 0; left: 0;">
				<div class="loading"><%= Resources.Resource.aguarde %> ...</div>
				<div style="font-size: large; color: #5cb85c; font-size: x-large; color: #5cb85c; margin-top: 192px; margin-left: -60px;">
					<img src="Images/logoGW.png" />
				</div>
			</div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>

	<script>
		$(function () {
			loadResourcesLocales();
			FiltraAvisos('', 'pesquisa');
		});


		function FiltraAvisos(text, origem) {
			if (origem == "pesquisa") {

				if (!ValidaData("txtDtInicialAvisos") && $("#txtDtInicialAvisos").val() != "") {
					$("#txtDtInicialAvisos").css("border-color", "#ff0000");
					$("#txtDtInicialAvisos").css("outline", "0");
					$("#txtDtInicialAvisos").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
					$("#txtDtInicialAvisos").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
					return;
				}

				if (!ValidaData("txtDtFinalAvisos") && $("#txtDtFinalAvisos").val() != "") {
					$("#txtDtFinalAvisos").css("border-color", "#ff0000");
					$("#txtDtFinalAvisos").css("outline", "0");
					$("#txtDtFinalAvisos").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
					$("#txtDtFinalAvisos").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
					return;
				}
				if ($("#txtDtInicialAvisos").val() != "" && $("#txtDtFinalAvisos").val() == "") {
					$("#txtDtFinalAvisos").css("border-color", "#ff0000");
					$("#txtDtFinalAvisos").css("outline", "0");
					$("#txtDtFinalAvisos").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
					$("#txtDtFinalAvisos").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
					return;
				}
				else if ($("#txtDtInicialAvisos").val() == "" && $("#txtDtFinalAvisos").val() != "") {
					$("#txtDtInicialAvisos").css("border-color", "#ff0000");
					$("#txtDtInicialAvisos").css("outline", "0");
					$("#txtDtInicialAvisos").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
					$("#txtDtInicialAvisos").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
					return;
				}
				$("#txtDtInicialAvisos").css("border-color", "");
				$("#txtDtInicialAvisos").css("outline", "");
				$("#txtDtInicialAvisos").css("-webkit-box-shadow", "");
				$("#txtDtInicialAvisos").css("box-shadow", "");
				$("#txtDtFinalAvisos").css("border-color", "");
				$("#txtDtFinalAvisos").css("outline", "");
				$("#txtDtFinalAvisos").css("-webkit-box-shadow", "");
				$("#txtDtFinalAvisos").css("box-shadow", "");
				$("#divLoading").css("display", "block");
				$.ajax({
					type: 'POST',
					url: 'Aviso.aspx/GetAvisosControlador',
					dataType: 'json',
					data: "{'dtInicial':'" + $("#txtDtInicialAvisos").val() + "','dtFinal':'" + $("#txtDtFinalAvisos").val() + "','idEqp':'" + $("#txtIdEqp").val() + "','falha':'" + $("#txtFalha").val() + "'}",
					contentType: "application/json; charset=utf-8",
					success: function (data) {
						var i = 0;
						$("#lblQtd")[0].innerText = "Qtd: " + data.d.length;
						$("#tbAvisos").empty();
						if (data.d.length == 0) {
							var newRow = $("<tr>");
							var cols = "<td colspan='4'>" + getResourceItem("naoHaRegistros") + "</td>";
							newRow.append(cols);
							$("#tbAvisos").append(newRow);
						}
						while (data.d[i]) {
							var lst = data.d[i].split('@');
							var idEqp = lst[0];
							var falha = lst[1];
							var dtHrFalha = lst[2];
							var funcao = lst[3];
							var id = lst[4];

							var newRow = $("<tr>");
							var cols = "";
							cols += "<td style='line-height: 32px;border-bottom-width: 1px;border: 1px solid #ddd;padding: 8px;text-align: left;'>" + idEqp + "</td>";
							cols += "<td style='line-height: 32px;border-bottom-width: 1px;border: 1px solid #ddd;padding: 8px;text-align: left;'>" + falha + "</td>";
							cols += "<td style='line-height: 32px;border-bottom-width: 1px;border: 1px solid #ddd;padding: 8px;text-align: left;'>" + funcao + "</td>";
							cols += "<td style='line-height: 32px;border-bottom-width: 1px;border: 1px solid #ddd;padding: 8px;text-align: left;'>" + dtHrFalha + "</td>";
							cols += "<td>" +
								"<div class='btn-group'>" +
								"<button type='button' class='btn btn-success dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>" +
                                "<span class='	glyphicon glyphicon-ok' style='padding-right: 10px;'></span><%= Resources.Resource.falhaSolucionada %> <span class='caret'></span></button>" +
								"<ul class='dropdown-menu'>" +
								"<li><a href='#' data-id='" + id + "' data-ideqp='" + idEqp + "' onclick='SolucionarFalha(this)'><%= Resources.Resource.sim %></a></li></ul></div></td>";


							newRow.append(cols);
							$("#tbAvisos").append(newRow);
							i++;
						}
					}
				});
				$("#divLoading").css("display", "none");
			}// else {
			//    $("#tblAvisosControlador tbody tr").each(function () {

			//        var colunas = $(this).children();
			//        var falhas = $(colunas[1]).text();
			//        var idEqp = $(colunas[0]).text();
			//        var tr = this;
			//        if ((origem == "ideqp" && idEqp.includes(text.toUpperCase())) || (origem == "falha" && falhas.toUpperCase().includes(text.toUpperCase())) || text == "") {
			//            $(tr).show();
			//        }
			//        else {
			//            $(tr).hide();
			//        }

			//    });
			//}
		}
		function SolucionarFalha(btn) {
			$.ajax({
				url: 'Aviso.aspx/SolucionarFalha',
				data: "{'id':'" + btn.dataset.id + "','user':'"+$("#hfUser").val()+"','idEqp':'"+btn.dataset.ideqp+"'}",
				dataType: "json",
				type: "POST",
				contentType: "application/json; charset=utf-8",
				success: function (data) {
					swal(getResourceItem("informacao"), getResourceItem("falhaSolucionadaComSucesso") , "success");
					FiltraAvisos('', 'pesquisa');
				},
				error: function (response) {
				}
			});

		}
		function Imprimir() {

			var date = new Date();
			var day = date.getDate();
			var monthIndex = date.getMonth() + parseInt(1);
			var year = date.getFullYear();

			mywindow = window.open("", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=900,height=800");

			mywindow.document.write('<html><head><title>' + getResourceItem("alarmes") + '</title>');
			mywindow.document.write('</head><body style="font-family:Arial;">');
			mywindow.document.write('<div style="padding-left:12px;padding-right:12px;"><img id="Image1" alt="" src="assets/img/logo.png" style="width: 120px;position: absolute;">');
			mywindow.document.write('<div style="width:100%; text-align:center;">');
			mywindow.document.write('<h2 style="padding-top:18px">' + getResourceItem("alarmes") + '</h2>');
			mywindow.document.write('<span style="font-weight:50;">' + str_pad_left(day, '0', 2) + "/" + str_pad_left(monthIndex, '0', 2) + "/" + str_pad_left(year, '0', 2) + " " + str_pad_left(date.getHours(), '0', 2) + ":" + str_pad_left(date.getMinutes(), '0', 2) + ":" + str_pad_left(date.getSeconds(), '0', 2) + '</span>');
			mywindow.document.write('</div>');
			mywindow.document.write('<hr/>');

			mywindow.document.write(' <table style="width: 100%; background-color:#eeeded">');
			if ($("#txtDtInicialAvisos").val() != "" && $("#txtDtFinalAvisos").val() != "" || $("#txtIdEqp").val() != "" || $("#txtFalha").val() != "") {
				mywindow.document.write('<tr><td style="line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left;" colspan="6"><b style="font-size:large;">Filtros</b></td></tr>');
				mywindow.document.write('<tr>');
			}
			if ($("#txtDtInicialAvisos").val() != "" && $("#txtDtFinalAvisos").val() != "") {
				mywindow.document.write(' <td style="line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left; width:90px;"><b><%= Resources.Resource.dataInicial %>:</b></td>');
				mywindow.document.write(' <td style="line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left;">' + $("#txtDtInicialAvisos").val() + '</td>');
				mywindow.document.write(' <td style="line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left; width:95px;"><b><%= Resources.Resource.dataFinal %>:</b></td>');
				mywindow.document.write(' <td style="line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left;">' + $("#txtDtFinalAvisos").val() + '</td>');
			}
			if ($("#txtIdEqp").val() != "") {
				mywindow.document.write(' <td style="line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left; width:55px;"><b>Id Eqp:</b></td>');
				mywindow.document.write(' <td style="line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left;">' + $("#txtIdEqp").val() + '</td>');
			}
			mywindow.document.write('</tr >');
			if ($("#txtFalha").val() != "") {
				mywindow.document.write('<tr>');
				mywindow.document.write(' <td  style="line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left; width:142px;"><b><%= Resources.Resource.falhas %> ou <%= Resources.Resource.funcao %>:</b></td>');
				mywindow.document.write(' <td  style="line-height: 32px; border-bottom-width: 1px; border: 1px solid #ddd; padding: 8px; text-align: left;" colspan="5">' + $("#txtFalha").val() + '</td></tr>');

			}
			mywindow.document.write('</table>');

			mywindow.document.write('<div style="margin-top:24px;margin-bottom:10px;">');
			mywindow.document.write('<span id="">' + $("#lblQtd").text() + '</span>');
			mywindow.document.write('</div>');
			mywindow.document.write('<div style="margin-top:10px;margin-bottom:10px;">');
			//mywindow.document.write('<span><b>Data/Hora Inicial: </b></span><span id="spDtInicio">' + $("#txtDataIni").val() + '</span>  <span> - </span><span><b>Data/Hora Final: </b></span><span id="spDtFim">' + $("#txtDataFim").val() + '</span></div>');
			//mywindow.document.write('<div style="margin-top:10px;margin-bottom:10px;"><span><b>Veículo(Prefixo): </b></span>' + $("#txtPrefixo").val() + '</div>');;
			mywindow.document.write($('#tblAvisos').prop('outerHTML'));
			mywindow.document.write('</div>');
			mywindow.document.write('</body></html>');

			//  mywindow.document.close();
			//  mywindow.focus();
			timeOut = setTimeout(function () { ImprimirHorarioProgramado(); }, 500);
			//  mywindow.close();

		}

		function ImprimirHorarioProgramado() {
			mywindow.print();
			clearTimeout(timeOut);
		}

		function str_pad_left(string, pad, length) {
			return (new Array(length + 1).join(pad) + string).slice(-length);
		}

		var globalResources;
		function loadResourcesLocales() {
			$.ajax({
				type: "POST",
				contentType: "application/json; charset=utf-8",
				url: 'Aviso.aspx/requestResource',
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


		function Data(evento, objeto) {
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

				if (campo.value.length < (10)) {
					if (campo.value.length == conjunto1)
						campo.value = campo.value + separacao1;
					else if (campo.value.length == conjunto2)
						campo.value = campo.value + separacao1;
					else if (campo.value.length == conjunto3)
						campo.value = campo.value + separacao2;
					//else if (campo.value.length == conjunto4)
					//    campo.value = campo.value + separacao3;
					//else if (campo.value.length == conjunto5)
					//    campo.value = campo.value + separacao3;
					//else if (campo.value.length == conjunto6)
					//    campo.value = campo.value + separacao3;
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
			if (stringData == "") {
				return true;
			}
			var regExpCaracter = /[^\d]/;     //Expressão regular para procurar caracter não-numérico.
			var regExpEspaco = /^\s+|\s+$/g;  //Expressão regular para retirar espaços em branco.

			if (stringData.length != 10) {
				alert('<%= Resources.Resource.data %> <%= Resources.Resource.invalida %> DD/MM/AAAA');
				return false;
			}

			splitData = stringData.split('/');

			if (splitData.length != 3) {
				alert('<%= Resources.Resource.data %> <%= Resources.Resource.invalida %> DD/MM/AAAA');
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
		function ValidaData(obj) {
			campo = eval(obj);
			if (campo.value == "") {
				return true;
			}
			if (campo.value.length < (10)) {
				$(obj).css("border-color", "#ff0000");
				$(obj).css("outline", "0");
				$(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
				$(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
				$(obj).focus();
				return false;
			}
			if (!validaData(campo.value.substring(0, 10))) {
				$(obj).css("border-color", "#ff0000");
				$(obj).css("outline", "0");
				$(obj).css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
				$(obj).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
				$(obj).focus();
				return false;
			}
			$(obj).css("border-color", "");
			$(obj).css("outline", "");
			$(obj).css("-webkit-box-shadow", "");
			$(obj).css("box-shadow", "");
			return true;
		}

	</script>
</asp:Content>
