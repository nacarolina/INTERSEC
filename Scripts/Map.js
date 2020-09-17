var latLng;
var marker;
var arrMarker = [];

var qtdNormal = 0, qtdFaltaEnergia = 0, qtdSubtencao = 0, qtdDesligado = 0, qtdAmareloIntermitente = 0,
	qtdEstacionado = 0, qtdPlugManual = 0, qtdFalhaComunicacao = 0, qtdSemComunicacao = 0, qtdManutencao = 0,
	qtdFalhas = 0, qtdPortaAberta = 0, qtdImposicaoPlano = 0;

var falhas = "", Zoom = "";
var timerLoadDnaMap, timerAvisoCtrl, timerSyncTasks;
var iPandPort;
var user, pwd;

var directions;

function VerPlanos() {
	window.open("http://187.122.100.125:90/chart/Default.aspx?idEqp=" + $("#hfIdPonto").val());
}

$(document).ready(function () {
	loadResourcesLocales();

	$("#chkLabelMarker").click(function () {
		$("#divLoading").css("display", "block");
		setTimeout(function () {
			var i = 0;
			if ($("#chkLabelMarker").data("checked") == false) {
				while (arrMarker[i]) {
					arrMarker[i].setLabelNoHide(true);
					i++;
				}
				$("#chkLabelMarker").data("checked", true);
			}
			else {
				while (arrMarker[i]) {
					arrMarker[i].setLabelNoHide(false);
					i++;
				}
				$("#chkLabelMarker").data("checked", false);
			}
			$("#divLoading").css("display", "none");
			if (0) { 0(); }
		}, 0);
	});

	$("[id$=btnExcelHistoFalha]").click(function (e) {
		window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('div[id$=divListaFalhaControl]').html()));
		e.preventDefault();
	});
})

function LoadMap(lat, lng, zoom, tempoAtualizacao) {

	if (lat == "")
		lat = -23.1543;

	if (lng == "")
		lng = -47.43877;

	if (zoom == "")
		zoom = 13;

	if (tempoAtualizacao == "")
		tempoAtualizacao = 180000;

	L.mapbox.accessToken = 'pk.eyJ1IjoiemVsYW8iLCJhIjoiY2lndjU5Zmx3MGhvenZxbTNlOWQ4YXE1ZCJ9.oGn84GgkJqonGYYm5bqi8Q';

	map = L.mapbox.map('map', 'mapbox.streets', { minZoom: 0, maxZoom: 18 });

	var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
		osmAttribution = 'Map data &copy; 2012 <a href="http://openstreetmap.org">OpenStreetMap</a> contributors',
		osm = new L.TileLayer(osmUrl, { attribution: osmAttribution });

	map.setView(new L.LatLng(lat, lng), zoom).addLayer(osm);

	var hfTemEqp = document.getElementById('hfTemEqp').value;
	if (hfTemEqp == "true") {
		LoadDnaMap("");
	}
	Zoom = zoom;
	map.zoomControl.setPosition('topright');

	timerLoadDnaMap = setInterval(function () { verificaPesquisaMap('timer') }, tempoAtualizacao);
}

var callServer = function (urlName, params, callback) {
	$("#divLoading").css("display", "block");
	$.ajax({
		type: 'POST',
		url: urlName,
		dataType: 'json',
		data: params,
		contentType: "application/json; charset=utf-8",
		success: function (data) {
			if (callback && typeof (callback) == "function") {
				callback(data.d);
			}
			$("#divLoading").css("display", "none");
		},
		error: function (data) {
			params = data; alert('Erro ao obter parametros map!');
			//window.location.reload(true);
		}
	});
};

var globalResources;
function loadResourcesLocales() {
	$.ajax({
		type: "POST",
		contentType: "application/json; charset=utf-8",
		url: 'Default.aspx/requestResource',
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

function LoadDnaMap(status) {
	var i = 0;
	LimpaQtdFalhas();
	$("#chkLabelMarker").data("checked", false);

	callServer('WebServices/Map.asmx/GetDna', "", function (eqp) {
		var qtdNormalNob = 0, qtdFalhaNob = 0, qtdUsoNob = 0, qtdSemComunicaoNob = 0;

		$.each(eqp, function (index, item) {

			var statusPorta = "";
			if (item.statusManutencao != "-1") {
				var iconFalha = L.AwesomeMarkers.icon({ icon: 'traffic-light', prefix: 'fa', markerColor: 'black', iconColor: '#fff' });

				if (status == "Filter") {
					for (var i = 0; i < arrMarker.length; i++) {
						if (item.idDna == arrMarker[i].label._content) {
							arrMarker[i].setLatLng([item.latitude, item.longitude]),
								arrMarker[i].options.title = "M",
								arrMarker[i].options.icon.options.markerColor = iconFalha.options.markerColor,
								arrMarker[i].options.alt = "" + item.estadoNobreak;
							map.removeLayer(arrMarker[i]);
							map.addLayer(arrMarker[i]);
							break;
						}

					}
				}
				else {
					marker = L.marker([item.latitude, item.longitude], {
						title: "M", radius: 10, icon: iconFalha, alt: "" + item.estadoNobreak
					}).bindLabel(item.idDna, { noHide: false, offset: [12, -15] }).addTo(map).on('click', onClickMarker);
					arrMarker.push(marker);
				}
				qtdManutencao++;
			}
			else {
				if (item.porta == "1") {
					qtdPortaAberta++;
					statusPorta = "P";
				}
				else {
					statusPorta = "";
				}

				switch (item.statusComunicacao) {
					case "True":
						var bitsFalha = parseInt(item.falha).toString(2);
						falhas = "";
						var verificaFalhas;
						if (status == "") verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaPonto", "Load");
						else verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaPonto", "");

						CreateMarker(item.latitude, item.longitude, verificaFalhas.statusFalha, item.idDna, falhas, statusPorta + item.estadoNobreak, status);
						break;
					case "False":
						CreateMarker(item.latitude, item.longitude, "FalhaComunicacao", item.idDna, "FC", statusPorta + item.estadoNobreak, status);
						qtdFalhaComunicacao++;
						break;
				}
			}
		});
		EstatisticaFalha();

		if (status == "Filter") {
			if ($("#ckdmodoEstatisticaCtrl").is(":checked")) filterAllMapCtrl();
			else FiltraFalha();
		}

	});

}

function CreateMarker(lat, lng, statusFalha, idDna, siglaFalha, statusPorta, callStatus) {
	var cor, icon;

	switch (statusFalha) {
		case "Normal":
			icon = 'traffic-light';
			cor = 'green';
			break;

		case "Falha":
			icon = 'traffic-light';
			cor = 'red';
			break;

		case "FalhaComunicacao":
			icon = 'traffic-light';
			cor = 'gray';
			break;

		case "Imposicao":
			icon = 'download';
			cor = 'orange';
			siglaFalha = "IP"
			break;

		case "Plug":
			icon = 'plug';
			cor = 'blue';
			siglaFalha = "PL"
			break;

		case "SemComunicacao":
			icon = 'traffic-light';
			cor = 'black';
			break;
		case "0":
			icon = 'traffic-light';
			cor = 'black';
			break;
		case "1":
			icon = 'traffic-light';
			cor = 'black';
			break;
	}

	var iconFalha = L.AwesomeMarkers.icon({ icon: icon, prefix: 'fas', markerColor: cor, iconColor: '#fff' });

	if (callStatus == "Filter") {
		for (var i = 0; i < arrMarker.length; i++) {
			if (idDna == arrMarker[i].label._content) {
				arrMarker[i].setLatLng([lat, lng]);
				arrMarker[i].options.title = siglaFalha;
				arrMarker[i].options.icon = iconFalha;
				arrMarker[i].options.alt = statusPorta;
				map.removeLayer(arrMarker[i]);
				map.addLayer(arrMarker[i]);
                  //map.setZoom(map.getZoom());
				break;
			}
		}
	}
	else {
		marker = L.marker([lat, lng], {
			title: siglaFalha, radius: 10, icon: iconFalha, alt: statusPorta
		}).bindLabel(idDna, { noHide: false, offset: [12, -15] }).addTo(map).on('click', onClickMarker);
		arrMarker.push(marker);
	}

}

function EstatisticaFalha() {

	var total = qtdFalhas + qtdNormal + qtdFalhaComunicacao + qtdPlugManual + qtdImposicaoPlano;

	var resultadoFalha = (qtdFalhas * 100) / total;
	var resultadoPorta = (qtdPortaAberta * 100) / total;
	var resultadoNormal = (qtdNormal * 100) / total;
	var resulFalhaComunicacao = (qtdFalhaComunicacao * 100) / total;
	var resulSemComunicacao = (qtdSemComunicacao * 100) / total;
	var resulPlug = (qtdPlugManual * 100) / total;
	var resulImposicao = (qtdImposicaoPlano * 100) / total;

	document.getElementById("spaQtdNormalControl").innerHTML = qtdNormal;
	document.getElementById("spaQtdFalhaControl").innerHTML = qtdFalhas;
	document.getElementById("spaQtdPorta").innerHTML = qtdPortaAberta;
	document.getElementById("spaQtdFalhaComuControl").innerHTML = qtdFalhaComunicacao;
	//document.getElementById("spaQtdSemComuControl").innerHTML = qtdSemComunicacao;
	document.getElementById("spaQtdPlugManual").innerHTML = qtdPlugManual;
	document.getElementById("spaQtdImposicao").innerHTML = qtdImposicaoPlano;

	document.getElementById("spaTotalPorta").innerHTML = resultadoPorta.toFixed() + "%";
	document.getElementById("spaTotalNormal").innerHTML = resultadoNormal.toFixed() + "%";
	document.getElementById("spaTotalFalha").innerHTML = resultadoFalha.toFixed() + "%";
	document.getElementById("spaTotalFalhaComunicacao").innerHTML = resulFalhaComunicacao.toFixed() + "%";
	//document.getElementById("spaTotalSemComunicacao").innerHTML = resulSemComunicacao.toFixed() + "%";
	document.getElementById("spaTotalPlugManual").innerHTML = resulPlug.toFixed() + "%";
	document.getElementById("spaTotalImposicao").innerHTML = resulImposicao.toFixed() + "%";
	document.getElementById("spaQtdTotalControl").innerHTML = total;

}

function VerificaFalhas(bitsFalha, callName, status) {

	this.statusFalha = "";
	this.falhas = "";

	if (bitsFalha == 0) {
		if (callName == "CarregaPonto") {
			this.statusFalha = "Normal";
			falhas = "N";
			qtdNormal++;
		}
		else if (callName == "CarregaFalha") {
			this.falhas = "Normal";
		}
	}
	else {
		if (callName == "CarregaPonto") {
			this.statusFalha = "Falha";
			qtdFalhas++;
		}

		bitsFalha = bitsFalha.split('').reverse().join('');
		for (var positionBit = 0; positionBit < bitsFalha.length; positionBit++) {
			//Falta de Energia
			if (positionBit == 0 && bitsFalha[positionBit] == "1") {

				if (callName == "CarregaPonto") {
					falhas = "F";
					qtdFaltaEnergia++;
				}

				else if (callName == "CarregaFalha") {
					this.falhas = "Falta de Energia";
				}
			}

			//Subtensao
			if (positionBit == 1 && bitsFalha[positionBit] == "1") {

				if (callName == "CarregaPonto") {
					if (falhas == "") {
						falhas = "S";
					}
					else {
						falhas += ",S"
					}

					qtdSubtencao++;
				}
				if (callName == "CarregaFalha") {
					if (this.falhas == "") {
						this.falhas = "Subtensao";
					}
					else {
						this.falhas += ",Subtensao";
					}
				}
			}

			//Apagado/Desligado
			if (positionBit == 2 && bitsFalha[positionBit] == "1") {
				if (callName == "CarregaPonto") {
					if (falhas == "") {
						falhas = "D";
					}
					else {
						falhas += ",D"
					}

					qtdDesligado++;
				}
				if (callName == "CarregaFalha") {
					if (this.falhas == "") {
						this.falhas = "Apagado/Desligado";
					}
					else {
						this.falhas += ",Apagado/Desligado";
					}
				}
			}

			//Amarelo intermitente
			if (positionBit == 3 && bitsFalha[positionBit] == "1") {
				if (callName == "CarregaPonto") {
					if (falhas == "") {
						falhas = "A";
					}
					else {
						falhas += ",A"
					}

					qtdAmareloIntermitente++;
				}
				if (callName == "CarregaFalha") {
					if (this.falhas == "") {
						this.falhas += "Amarelo intermitente";
					}
					else {
						this.falhas += ",Amarelo intermitente";
					}
				}
			}

			//Estacionado
			if (positionBit == 4 && bitsFalha[positionBit] == "1") {
				if (callName == "CarregaPonto") {
					if (falhas == "") {
						falhas = "E";
					}
					else {
						falhas += ",E";
					}
					qtdEstacionado++;
				}
				if (callName == "CarregaFalha") {
					if (this.falhas == "") {
						this.falhas += "Estacionado";
					}
					else {
						this.falhas += ",Estacionado";
					}
				}
			}

			//Plug Manual
			if (positionBit == 5 && bitsFalha[positionBit] == "1") {
				this.statusFalha = "Plug"
				qtdPlugManual++;
			}

			//Imposicao Plano
			if (positionBit == 6 && bitsFalha[positionBit] == "1") {
				this.statusFalha = "Imposicao"
				qtdImposicaoPlano++;
			}
		}
	}
}

function onClickMarker(e) {
	var idPonto = this.label._content;

	if (this.options.title != "FC") {
		$("#lblModoOperacional").text(getResourceItem("centralizado"));
	}
	else $("#lblModoOperacional").text("Local");

	document.getElementById('hfIdPonto').value = idPonto;
	document.getElementById("lblIdPonto").innerHTML = "<b>" + getResourceItem("idPonto") + ":</b> " + idPonto;

	if ($("#chkModoNobreak").is(":checked")) {
		$('.nav-tabs a[href="#nobreak"]').tab('show');
	}
	else {
		$('.nav-tabs a[href="#controlador"]').tab('show');
	}
	//$("#divLoad").css("display", "block");

	GetDetailsDna(idPonto);
}

function GetDetailsDna(idPonto) {
	callServer('WebServices/Map.asmx/GetDetailsDna', "{'idPonto':'" + idPonto + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}", function (eqp) {
		if (eqp.length > 0) {
			$("#lblIP")[0].innerHTML = eqp[0].ipCtrl;
			if (eqp[0].dtManutencaoCtrl == "")
				$("#btnResetarControl").css("display", "block");
			else
				$("#btnResetarControl").css("display", "none");

			var dtHorarioVerao = eqp[0].horarioVeraoEqp.split('-');
			if (dtHorarioVerao.length > 1) {
				var yyyy = "", MM = "", dd = "";

				yyyy = dtHorarioVerao[0].substring(0, 4);
				MM = dtHorarioVerao[0].substring(4, 6);
				dd = dtHorarioVerao[0].substring(6, 8);
				var dataInicioHoraVerao = new Date(yyyy, MM - 1, dd);

				yyyy = dtHorarioVerao[1].substring(0, 4);
				MM = dtHorarioVerao[1].substring(4, 6);
				dd = dtHorarioVerao[1].substring(6, 8);
				var dataFinalHoraVerao = new Date(yyyy, MM - 1, dd);

				if (dataInicioHoraVerao <= new Date() && dataFinalHoraVerao >= new Date())
					$("#spaTipoHorarioEqp").text(getResourceItem("horarioVerao"));//+ " - BRST (GMT -2)"
				else $("#spaTipoHorarioEqp").text(getResourceItem("horarioBrasilia"));// + " - BRT (GMT -3)"
			} else $("#spaTipoHorarioEqp").text(getResourceItem("horarioBrasilia")); //+ " - BRT (GMT -3)"

			document.getElementById("lblCruzamento").innerHTML = "<b>" + getResourceItem("cruzamento") + ":</b> " + eqp[0].cruzamento;

			if (eqp[0].porta == ("1")) {
				document.getElementById("spaPorta").innerHTML = "Aberta";
				$("#spaPorta").css("color", "green");
			}
			else {
				document.getElementById("spaPorta").innerHTML = "Fechada";
				$("#spaPorta").css("color", "red");
			}

			if (eqp[0].dtManutencaoCtrl != "") {
				$("#btnAbrirOs").css("display", "none");
			}
			else {
				$("#btnAbrirOs").css("display", "");
			}

			$.ajax({
				type: 'POST',
				url: 'WebServices/Map.asmx/GetProgramacaoEqp',
				dataType: 'json',
				data: "{'idEqp':'" + idPonto + "'}",
				contentType: "application/json; charset=utf-8",
				success: function (data) {
					if (data.d == "") {
						$("#lblProgramacao")[0].innerHTML = getResourceItem("semProgramacao");
					}
					else {
						$("#lblProgramacao")[0].innerHTML = data.d[0].Programacao;
						$("#lblDtHrAtualizacaoProg")[0].innerHTML = data.d[0].DtHrAtualizacaoProg;
						$("#lblUltComunicacao")[0].innerHTML = data.d[0].ultComunicacao;
						$("#lblTarefasPendentes")[0].innerHTML = getTraducaoTarefas(data.d[0].Tarefas);
					}
				},
				error: function (data) {

				}
			});
			$.ajax({
				type: 'POST',
				url: 'WebServices/Map.asmx/CarregaArquivosCroqui',
				dataType: 'json',
				data: "{'idEqp':'" + idPonto + "'}",
				contentType: "application/json; charset=utf-8",
				success: function (data) {
					var i = 0;
					if (data.d.length == 0) {
						$("#btnCroqui").css("display", "none");
					}
					else {
						$("#containerSlides").empty();
						$("#btnCroqui").css("display", "");
						while (data.d[i]) {
							var lst = data.d[i];
							if (data.d[i].NomeArquivo.toLowerCase().indexOf(".jpg") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".png") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".gif") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".jpeg") > -1) {

								var div = $("<div id=\"mySlides\" class=\"mySlides\">");
								//var item = "< span id =\"numberText\" class=\"numbertext\" >" + i + " / " + data.d.length + "</span >";
								//div.append(item);
								item = "<img src=\"../Register/Controller/ArquivoCroqui/" + lst.NomeArquivo + "\" style=\"width:100%\" /> ";
								div.append(item);

								$("#containerSlides").append(div);
							}
							i++;
						}

						$("#containerSlides").append("<a class=\"prev\" onclick =\"plusSlides(-1)\" >❮");
						$("#containerSlides").append("<a class=\"next\" onclick =\"plusSlides(1)\" >❯");

					}
				}
			});

			iPandPort = eqp[0].hostNameCam;
			user = eqp[0].userNameCam;
			pwd = eqp[0].passwordCam;
			$("#lblUltComunicacao")[0].innerHTML = eqp[0].atualizadoCtrl;// .ultComunicacao;

			switch (eqp[0].statusComunicacao) {
				case "True":
					var bitsFalha = parseInt(eqp[0].falha).toString(2);
					var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha", "");
					document.getElementById("spaFalhas").innerHTML = verificaFalhas.falhas;
					$("#btnSemComunicacao").css("display", "none");
					if (verificaFalhas.falhas == "Normal") {
						$("#spaFalhas").css("color", "green");
					}
					else {
						$("#spaFalhas").css("color", "red");
					}
					break;
				case "False":
					if (eqp[0].semComunicacao == "0") {
						document.getElementById("spaFalhas").innerHTML = getResourceItem("falhasNaComunicacao");
						$("#btnSemComunicacao").css("display", "");
					}
					else {
						document.getElementById("spaFalhas").innerHTML = getResourceItem("semComunicacao");
						$("#btnSemComunicacao").css("display", "none");
					}
					$("#spaFalhas").css("color", "red");
					break;
			}

		}
		else {

			document.getElementById("lblCruzamento").innerHTML = "<b>" + getResourceItem("cruzamento") + ":</b> " + getResourceItem("dadoNaoCadastrado");
			document.getElementById("lblTipo").innerHTML = getResourceItem("dadoNaoCadastrado");
			document.getElementById("lblModelo").innerHTML = getResourceItem("dadoNaoCadastrado");
			document.getElementById("spaNmrFases").innerHTML = getResourceItem("dadoNaoCadastrado");

			$("#btnAbrirOs").css("display", "");
		}

		$("#hfIdEqp").val(idPonto);
		$("#btnAbrirOs").attr("data-id", idPonto);
		$("#btnVoltarManutencao").data("voltar", "#divPopupMarker");
		lastResetsCtrl(idPonto);
		$("#divPopupMarker").modal("show");
		ListaGrupos();
		ListaLogsOperacaoCentral();
	});
}

function getTraducaoTarefas(tarefas) {
	var tarefaItens = tarefas.split(';');
	$.each(tarefaItens, function (index, item) {
		tarefaItens[index] = item.indexOf("Imposição de Plano") != -1 ? getResourceItem("imposicaoPlano") : tarefaItens[index];
		tarefaItens[index] = item.indexOf("Cancelamento Plano Imposto") != -1 ? getResourceItem("cancelamento") + " - " + getResourceItem("imposicaoPlano") : tarefaItens[index];
		tarefaItens[index] = item.indexOf("Enviar Programação") != -1 ? getResourceItem("enviarProgramacao") : tarefaItens[index];
		tarefaItens[index] = item.indexOf("Enviar Agenda") != -1 ? getResourceItem("enviarAgenda") : tarefaItens[index];
		tarefaItens[index] = item.indexOf("Enviar Horario de Verão") != -1 ? getResourceItem("enviarHorarioVerao") : tarefaItens[index];
		tarefaItens[index] = item.indexOf("Enviar Imagem") != -1 ? getResourceItem("enviarImagem") : tarefaItens[index];
		tarefaItens[index] = item.indexOf("Centralizar") != -1 ? getResourceItem("centralizar") : tarefaItens[index];
		tarefaItens[index] = item.indexOf("Reset Anel") != -1 ? item.replace("Anel", getResourceItem("anel")) : tarefaItens[index];
		tarefaItens[index] = item.indexOf("Nenhuma") != -1 ? getResourceItem("nenhumaTarefa") : tarefaItens[index];
	});

	return tarefaItens.toString().split(',').join('; ');
}

function Croqui() {
	var slideIndex = 0;
	showSlides(slideIndex);
	$("#mpCroqui").modal("show");
}

function plusSlides(n) {
	showSlides(slideIndex += n);
}

function currentSlide(n) {
	showSlides(slideIndex = n);
}

function showSlides(n) {
	var i;
	var slides = document.getElementsByClassName("mySlides");
	if (n > slides.length) { slideIndex = 1 }
	if (n < 1) { slideIndex = slides.length }
	for (i = 0; i < slides.length; i++) {
		slides[i].style.display = "none";
	}
	slides[slideIndex - 1].style.display = "block";
}

function ListaGrupos() {
	$.ajax({
		type: 'POST',
		url: 'WebServices/Map.asmx/GetListaGrupos',
		dataType: 'json',
		data: "{'idEqp':'" + $("#hfIdEqp").val() + "'}",
		contentType: "application/json; charset=utf-8",
		success: function (data) {
			$("#tbListaGrupos").empty();
			if (data.d != "") {
				$.each(data.d, function (index, item) {
					var tipo = item.Tipo.indexOf("VEICULAR") != -1 ? getResourceItem("veicular").toUpperCase() : getResourceItem("pedestre").toUpperCase();

					var newRow = $("<tr>");
					var cols = "";
					cols += "<td style='width:88px;'>" + item.Grupo.replace("Anel", getResourceItem("anel")) + "</td>";
					cols += "<td style='width:88px;'>" + tipo + "</td>";
					cols += "<td>" + item.Endereco + "</td>";
					newRow.append(cols);
					$("#tbListaGrupos").append(newRow);
				});
			}
			else {
				var newRow = $("<tr>");
				var cols = "";
				cols += "<td colspan='3'>" + getResourceItem("naoHaRegistros") + "</td >";
				newRow.append(cols);
				$("#tbListaGrupos").append(newRow);
			}
		},
		error: function (data) {

		}
	});
}

function ListaLogsOperacaoCentral() {
	$.ajax({
		type: 'POST',
		url: 'WebServices/Map.asmx/GetLogsOperacaoCentral',
		dataType: 'json',
		data: "{'idEqp':'" + $("#hfIdEqp").val() + "'}",
		contentType: "application/json; charset=utf-8",
		success: function (data) {
			$("#tbLogsCentral").empty();
			if (data.d != "") {
				$.each(data.d, function (index, item) {
					var newRow = $("<tr>");
					var cols = "";
					//cols += "<td>" + item.tipo + "</td>";
                    //cols += "<td>" + item.funcao + "</td>";

                    var bitsFalha = parseInt(item.Falha).toString(2);
                    var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha", "");

                    cols += "<td>" + verificaFalhas.falhas + "</td>";

					cols += "<td>" + item.usuario + "</td>";
					cols += "<td>" + item.dataHora + "</td>";
					newRow.append(cols);
					$("#tbLogsCentral").append(newRow);
				});
			}
			else {
				var newRow = $("<tr>");
				var cols = "";
				cols += "<td colspan='4'>" + getResourceItem("naoHaRegistros") + "</td >";
				newRow.append(cols);
				$("#tbLogsCentral").append(newRow);
			}
		}
	});
}

function getChipDna(idPonto) {
	callServer('WebServices/CadEqp.asmx/GetChipDna', "{'idDna':'" + idPonto + "'}", function (lstChip) {
		if (lstChip.toString() == "") {
			$("#pInfoChip").css("display", "block");
			$("#divChip").css("display", "none");
		}
		else {
			$("#pInfoChip").css("display", "none");
			$("#divChip").css("display", "block");
			$("#tbChip").empty();
			$.each(lstChip, function (index, item) {
				var newRow = $("<tr>");
				var cols = "";
				cols += "<td>" + item.consorcio + "</td>";
				cols += "<td>" + item.empresa + "</td>";
				cols += "<td>" + item.empresaInsta + "</td>";
				cols += "<td>" + item.operadora + "</td>";
				cols += "<td>" + item.hexa + "</td>";
				cols += "<td>" + item.numero + "</td>";
				cols += "<td>" + item.plano + "</td>";
				cols += "<td>" + item.tipo + "</td>";
				newRow.append(cols);
				$("#tblChip").append(newRow);
			});
		}
		$("#divPopupMarker").modal("show");
	});
}

function GetAvisoFalhaDna(idPonto) {
	callServer('WebServices/Map.asmx/GetAvisoFalha', "{'idPonto':'" + idPonto + "'}", function (lst) {
		if (lst.toString() == "") {
			$("#pInfoAvisoFalha").css("display", "block");
			$("#divAvisoFalha").css("display", "none");
		}
		else {
			$("#pInfoAvisoFalha").css("display", "none");
			$("#divAvisoFalha").css("display", "block");
			$("#tbAvisoFalha").empty();
			var i;
			for (i = 0; i < lst.length; ++i) {
				var newRow = $("<tr>");
				var cols = "";
				var row = lst[i].split('|');
				cols += "<td>" + row[0] + "</td>";
				cols += "<td>" + row[1] + "</td>";
				cols += "<td>" + row[2] + "</td>";
				cols += "<td>" + row[3] + "</td>";
				cols += "<td>" + row[4] + "</td>";
				newRow.append(cols);
				$("#tblAvisoFalha").append(newRow);
			}
		}
		$("#divPopupMarker").modal("show");
	});
}

function getTaloesDna(idPonto) {
	$("#tblAtrinuicoesTalao").css("display", "none");
	$("#tblDetalheTalao").css("display", "none");
	callServer('WebServices/Map.asmx/GetTaloes', "{'idPonto':'" + idPonto + "'}", function (lstTaloes) {
		if (lstTaloes.length == 0) {
			$("#pInfoTalao").css("display", "block");
			$("#divSmee").css("display", "none");
		}
		else {
			$("#pInfoTalao").css("display", "none");
			$("#divSmee").css("display", "block");
			$("#tbTalao").empty();
			var i;
			for (i = 0; i < lstTaloes.length; ++i) {
				var newRow = $("<tr>");
				var cols = "";
				cols += '<td> <a style="cursor:pointer;color:#0174DF;" onclick="GetDetalheTalao(this)"; data-id=' + lstTaloes[i] + ';> ' + lstTaloes[i] + '</a></td>';
				newRow.append(cols);
				$("#tblTalao").append(newRow);
			}
		}
		$("#divPopupMarker").modal("show");
	});
}

function GetDetalheTalao(handler) {
	var talao = $(handler).data("id").replace(';', '');
	callServer('WebServices/Map.asmx/GetDetalheTalao', "{'Talao':'" + talao + "'}", function (data) {
		if (data != "") {
			var lst = data.split('|');

			if (lst.length > 0) {
				$("#tblDetalheTalao").css("display", "block");
				var detalhes = lst[0].split('@');

				document.getElementById("spaTalaoFalha").innerHTML = detalhes[0];
				document.getElementById("spaTalaoCausa").innerHTML = detalhes[1];
				document.getElementById("spaTalaoComplemento").innerHTML = detalhes[2];
				document.getElementById("spaTalaoTalao").innerHTML = detalhes[3];
				document.getElementById("spaTalaoPrioridade").innerHTML = detalhes[4];
				document.getElementById("spaTalaoEstado").innerHTML = detalhes[5];
				document.getElementById("spaTalaoLocal").innerHTML = detalhes[6];
				document.getElementById("spaTalaoObs").innerHTML = detalhes[7];

				if (lst.length > 1) {
					$("#tblAtrinuicoesTalao").css("display", "block");
					$("#tbAtrinuicoesTalao").empty();
					var i;
					for (i = 1; i < lst.length; ++i) {

						var item = lst[i].split('@');
						var newRow = $("<tr>");
						var cols = "";
						cols += "<td>" + item[0] + "</td>";
						cols += "<td>" + item[1] + "</td>";
						cols += "<td>" + item[2] + "</td>";

						newRow.append(cols);
						$("#tblAtrinuicoesTalao").append(newRow);
					}
				}
			}
		}
	});
}

function getEventsNobreak(idPonto) {
	callServer('WebServices/Map.asmx/GetEventsNobreak', "{'idPonto':'" + idPonto + "','tipo':'TRAP'}", function (lstEventos) {
		$("#tbEventosNobreak").empty();
		$.each(lstEventos, function (index, evt) {
			var newRow = $("<tr>");
			var cols = "";
			cols += "<td>" + evt.MIB + "</td>";
			cols += "<td>" + evt.descricao + "</td>";
			cols += "<td>" + evt.valor + "</td>";
			cols += "<td>" + evt.data + "</td>";
			newRow.append(cols);
			$("#tblEventosNobreak").append(newRow);
		});
		getChipDna(idPonto);
	});
}

function loadFalhasNobreak(idPonto) {
    /*$.ajax({
        type: 'POST',
        url: 'WebServices/Map.asmx/GetEventsNobreak',
        dataType: 'json',
        data: "{'idPonto':'" + idPonto + "','tipo':'ping'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var lstFalhas = data.d;

            $("#tbFalhasNobreak").empty();

            $.each(lstFalhas, function (index, f) {
                var newRow = $("<tr>");
                var cols = "";

                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + f.descricao + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + f.valor + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + f.data + "</td>";

                newRow.append(cols);
                $("#tblFalhasNobreak").append(newRow);

            });
        },
        error: function (data) {
            window.location.reload(true);
        }
    });*/
}

function getAllNobreaks() {
	$("#chkNormalNobreak").prop("checked", false);
	$("#chkFalhaNobreak").prop("checked", false);
	$("#chkSemComuNobreak").prop("checked", false);
	$("#chkEmUsoNobreak").prop("checked", false);

	$("#tbAllNobreaks").empty();
	$("#spaAllNobreaks").empty();

	$.ajax({
		type: 'POST',
		url: 'WebServices/Map.asmx/GetAllNobreak',
		dataType: 'json',
		data: "{'idPonto':''}",
		contentType: "application/json; charset=utf-8",
		success: function (data) {
			var lstNobreaks = data.d;
			var imgProblema = "";
			var qtd = 0;

			$.each(lstNobreaks, function (index, nob) {
				var newRow = $("<tr>");
				var cols = "";

				switch (nob.estado) {
					case "Normal":
						imgProblema = "Images/nobreakNormal.png";
						$("#chkNormalNobreak").prop("checked", true);
						break;
					case "Falha":
						imgProblema = "Images/nobreakFalha.png";
						$("#chkFalhaNobreak").prop("checked", true);
						break;
					case "EmUso":
						imgProblema = "Images/nobreakEmUso.png";
						$("#chkEmUsoNobreak").prop("checked", true);
						break;
					case "SC":
						imgProblema = "Images/nobreakFalhaComunicacao.png";
						$("#chkSemComuNobreak").prop("checked", true);
						break;
				}

				cols += "<td><img src='" + imgProblema + "' alt='" + nob.estado + "' style='width:20px;height:20px;' /></td>"
				cols += "<td>" + nob.serial + "</td>";
				cols += "<td>" + nob.idDna + "</td>";
				cols += "<td>" + nob.estado + "</td>";
				cols += "<td>" + nob.dtAtualizacao + "</td>";

				newRow.append(cols);
				$("#tblAllNobreaks").append(newRow);

				qtd++;
			});

			$("#spaAllNobreaks").append(qtd);
		},
		error: function (data) {
			window.location.reload(true);
		}
	});
}

function filtrarNobreaks() {
	$("#tblAllNobreaks tbody tr").each(function () {

		var colunas = $(this).children();
		var estado = $(colunas[3]).text();
		var tr = this;

		switch (estado) {
			case "Normal":
				if ($("#chkNormalNobreak").is(":checked")) {
					$(tr).show();
				}
				else {
					$(tr).hide();
				}
				break;
			case "Falha":
				if ($("#chkFalhaNobreak").is(":checked")) {
					$(tr).show();
				}
				else {
					$(tr).hide();
				}
				break;
			case "EmUso":
				if ($("#chkEmUsoNobreak").is(":checked")) {
					$(tr).show();
				}
				else {
					$(tr).hide();
				}
				break;
			case "SC":
				if ($("#chkSemComuNobreak").is(":checked")) {
					$(tr).show();
				}
				else {
					$(tr).hide();
				}
				break;
		}

	});
}

function getHistoricoComunicacao(retorno) {
	var i = 0;

	$("#divPopupMarker").modal("hide");
	var Data = document.getElementById('txtDtHistoComunicacao').value.replace("/", "").replace("/", "");
	var idPonto = document.getElementById('hfIdPonto').value;

	var Dia = Data.substring(0, 2);
	var Mes = Data.substring(2, 4);
	var Ano = Data.substring(4, 8);
	Data = + Dia + '/' + Mes + '/' + Ano;

	$("#spaIdPontoComunicacao").empty();
	$("#spaIdPontoComunicacao").append(idPonto);

	callServer('WebServices/Map.asmx/HistorComunicacao_QtdFalhas', "{'idPonto':'" + idPonto + "','Data':'" + Data + "'}", function (resul) {
		if (resul.toString() == "" || resul.toString() == null) document.getElementById("spnQtdFalhasComunicacao").value = "0000";
		else document.getElementById("spnQtdFalhasComunicacao").innerHTML = resul[0];
	});


	callServer('WebServices/Map.asmx/HistorComunicacao', "{'idPonto':'" + idPonto + "','Data':'" + Data + "','retorno':'" + retorno + "'}", function (resul) {
		if (resul.toString() == "") {
			$("#divListaComunicacao").css("display", "none");
			$("#spaAlertaHistoricoComunicacao").css("display", "block");

		}
		else {
			$("#divListaComunicacao").css("display", "block");
			$("#spaAlertaHistoricoComunicacao").css("display", "none");

			$("#tbHistoricoComunicacao").empty();

			while (resul[i]) {
				var lstHistoricoComunicacao = resul[i].split('@');
				var UltimaComunicacao = lstHistoricoComunicacao[0];
				var TentativaComunicacao = lstHistoricoComunicacao[1]
				var TempoSemComunicar = lstHistoricoComunicacao[2];

				var newRow = $("<tr>");
				var cols = "";
				cols += "<td>" + lstHistoricoComunicacao[0] + "</td>";
				cols += "<td>" + lstHistoricoComunicacao[1] + "</td>";
				cols += "<td>" + lstHistoricoComunicacao[2] + "</td>";
				newRow.append(cols);
				$("#tblHistoricoComunicacao").append(newRow);

				i++;
			}
		}

		$("#popupHistoricoComunicacao").modal("show");
	});
}

function getHistoricalFailure() {
	var i = 0;

	$("#divPopupMarker").modal("hide");
	var idPonto = document.getElementById('hfIdPonto').value;
	document.getElementById('txtDataIni').value = "";
	document.getElementById('txtDataFinal').value = "";

	$("#spaIdPontoFalha").empty();
	$("#spaIdPontoFalha").append(idPonto);

	callServer('WebServices/Map.asmx/HistorFailureControlador', "{'idPonto':'" + idPonto + "'}", function (resul) {
		if (resul.toString() == "") {
			$("#divListaFalhaControl").css("display", "none");
			$("#spaAlertaHistoricoFalhas").css("display", "block");
		}
		else {
			$("#divListaFalhaControl").css("display", "block");
			$("#spaAlertaHistoricoFalhas").css("display", "none");

			$("#tbHistoricoFalhas").empty();

			while (resul[i]) {
				var lstHistoricalFailure = resul[i].split('@');
				var numberFailure = parseInt(lstHistoricalFailure[0]);
				var bitsFalha = numberFailure.toString(2);
				var dataFalha = lstHistoricalFailure[1];
				var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha");

				var newRow = $("<tr>");
				var cols = "";
				cols += "<td>" + verificaFalhas.falhas + "</td>";
				cols += "<td>" + lstHistoricalFailure[2] + "</td>";
				cols += "<td>" + dataFalha + "</td>";
				newRow.append(cols);
				$("#tblHistoricoFalhas").append(newRow);

				i++;
			}
		}

		$("#popupHistoricoFalhas").modal("show");
	});
}

function lastResetsCtrl(idPonto) {
	callServer('WebServices/Map.asmx/GetLastResets', "{'idPonto':'" + idPonto + "'}", function (resul) {
		if (resul.toString() == "") {
			$("#pHistReset").css("display", "block");
			$("#HistoricoReset").css("display", "none");
		}
		else {
			$("#pHistReset").css("display", "none");
			$("#HistoricoReset").css("display", "block");
			$("#tbHistReset").empty();
			$.each(resul, function (index, item) {
				var newRow = $("<tr>");
				var cols = "";
				cols += "<td>" + item.dtResetCtrl + "</td>";
				cols += "<td>" + item.mib + "</td>";
				cols += "<td>" + item.RetornoReset + "</td>";
				cols += "<td>" + item.usuario + "</td>";
				newRow.append(cols);
				$("#tbHistoricoReset").append(newRow);
			});

			$("#divPopupMarker").modal("show");
		}
	});
}

function VoltarDetalhesPonto() {

	$("#popupHistoricoFalhas").modal("hide");

	var idPonto = $("#spaIdPontoFalha").text();

	document.getElementById('hfIdPonto').value = idPonto;
	$("#lblIdPonto").append("<b>" + getResourceItem("idPonto") + "</b> " + idPonto);

	GetDetailsDna(idPonto);
}

function NoSemComuni() {
	$("#popupSemComunicacao").modal("hide");
	$("#divPopupMarker").modal("show");
}

function ResetarControlador() {
	$("#divPopupMarker").modal("hide");
	$("#spaIdPontoConfirmResete").empty();
	$("#spaIdPontoConfirmResete").append(document.getElementById('hfIdPonto').value);
	document.getElementById("hfUserPermReset").value = "";

	$("#popupConfirmResetarControl").modal("show");
	//var resetaControler = document.getElementById("hfResetaControlador").value;
	//switch (resetaControler) {
	//    case "True":
	//        $("#popupConfirmResetarControl").modal("show");
	//        break;
	//    case "False":
	//        document.getElementById("infoUserReset").style.display = "none";
	//        document.getElementById("txtUserReset").value = "";
	//        document.getElementById("txtSenhaUserReset").value = "";
	//        $("#popupResetUser").modal("show");
	//        break;
	//}
}

var verificaUserReset = function () {
	var user = document.getElementById("txtUserReset").value;
	var password = document.getElementById("txtSenhaUserReset").value;

	if (user == "") {
		alert(getResourceItem("informeUsuario") + "!");
		return;
	}
	if (password == "") {
		alert(getResourceItem("informeSenha") + "!");
		return;
	}

	document.getElementById("hfUserPermReset").value = user;
	//$("#popupResetUser").modal("hide");
	$("#popupConfirmResetarControl").modal("show");

	//callServer("WebServices/Map.asmx/ValidaUserReset", "{'user':'" + user + "','password':'" + password + "'}", function (resul) {
	//    if (resul == "True") {
	//        $("#popupResetUser").modal("hide");
	//        $("#popupConfirmResetarControl").modal("show");
	//    }
	//    else {
	//        document.getElementById("infoUserReset").style.display = "";
	//    }
	//});
}

function HabilitarReseteControl() {
	var idPonto = $("#lblIdPonto").text().replace(getResourceItem("idPonto") + ": ", "");
	var user = document.getElementById("hfUserPermReset").value;
	$.ajax({
		type: 'POST',
		url: "WebServices/Map.asmx/ResetaControlador",
		dataType: 'json',
		data: "{'idPonto':'" + idPonto + "','userPermReset':'" + user + "'}",
		contentType: "application/json; charset=utf-8",
		success: function (data) {
			$("#popupConfirmResetarControl").modal("hide");
			alert(getResourceItem("reset") + " " + getResourceItem("imposicao") + " " + getResourceItem("solicitada") + "!");
		},
		error: function (data) {
			window.location.reload(true);
		}
	});
}

function NoReseteControl() {
	$("#divPopupMarker").modal("show");
	$("#popupConfirmResetarControl").modal("hide");
}

function Logs() {
	window.open("Controlador/Logs.aspx?idEqp=" + $("#hfIdPonto").val());
}

function VerAgenda() {
	window.open("Controlador/Agenda.aspx?idEqp=" + $("#hfIdPonto").val());
}

function verificaPesquisaMap(status) {

	if (status == "timer") {
		document.getElementById("spaDtAtualizacaoMapa").innerHTML = new Date().toString().substring(0, 25);
	}

	var idPonto = document.getElementById("txtIdPonto").value;

	//if (idPonto == "")
	//    LoadDnaMap("Filter");

	//else {
	LimpaQtdFalhas();
	if (status == "timer")
		FilterMap("", "", idPonto, "Filter");
	else
		FilterMap("", "", idPonto);
	//}
}

function closeAviso() {
	clearInterval(timerAvisoCtrl);
	$("#mpAvisos").modal("hide");
}
function getLacosFalha() {
	window.open("ImprimirLacosComFalha.aspx");
}

function getAvisosCtrl() {
	window.open("Aviso.aspx");
}

function initTarefasPendentes() {
	$("#modalTarefasPendentes").modal({ keyboard: false, backdrop: false });
	getTarefasPendentes();

	timerSyncTasks = setInterval(function () {
		getTarefasPendentes();
	}, 60000);
}

function closeTarefasPendentes() {
	clearInterval(timerSyncTasks);
}

function getTarefasPendentes() {
	$("#divLoadTarefas").css("display", "block");
	$("#tfTarefasPendentes").css("display", "none");
	$("#tbTarefasPendentes").empty();

	$.ajax({
		type: 'POST',
		url: "Default.aspx/getTarefasPendentes",
		dataType: 'json',
		data: "",
		contentType: "application/json; charset=utf-8",
		success: function (data) {
			if (data.d != "") {
				$.each(data.d, function (index, item) {
					var TarefasPendentes = [];
					var binary1 = (item.Byte1 >>> 0).toString(2);
					var binary2 = (item.Byte2 >>> 0).toString(2);

					var pad = "00000000";
					binary1 = (pad.substring(0, pad.length - binary1.length) + binary1).split('').reverse();
					binary2 = (pad.substring(0, pad.length - binary2.length) + binary2).split('').reverse();

					if (binary1 == "0,0,0,0,0,0,0,0" && binary2 == "0,0,0,0,0,0,0,0") return true;

					if (binary1[0] == "1") TarefasPendentes.push("* " + getResourceItem("reset"));
					if (binary1[1] == "1") TarefasPendentes.push("* " + getResourceItem("imposicao"));
					if (binary1[2] == "1") TarefasPendentes.push("* " + getResourceItem("cancelamento") + " " + getResourceItem("imposicao"));
					if (binary1[3] == "1") TarefasPendentes.push("* " + getResourceItem("envio") + " " + getResourceItem("planos"));
					if (binary1[4] == "1") TarefasPendentes.push("* " + getResourceItem("envio") + " " + getResourceItem("agenda"));
					if (binary1[5] == "1") TarefasPendentes.push("*  " + getResourceItem("envio") + " " + getResourceItem("horarioVerao"));
					if (binary1[6] == "1") TarefasPendentes.push("* " + getResourceItem("solicitacao") + " " + getResourceItem("imagem"));
					if (binary1[7] == "1") TarefasPendentes.push("* " + getResourceItem("imposicao") + " " + getResourceItem("modoOperacional"));

					if (binary2[0] == "1") TarefasPendentes.push("* " + getResourceItem("reset") + " " + getResourceItem("anel") + " 1");
					if (binary2[1] == "1") TarefasPendentes.push("* " + getResourceItem("reset") + " " + getResourceItem("anel") + " 2");
					if (binary2[2] == "1") TarefasPendentes.push("* " + getResourceItem("reset") + " " + getResourceItem("anel") + " 3");
					if (binary2[3] == "1") TarefasPendentes.push("* " + getResourceItem("reset") + " " + getResourceItem("anel") + " 4");

					var newRow = $("<tr>");
					var cols = "";

					cols += "<td>" + item.IdControlador + "</td>";
					cols += "<td>" + TarefasPendentes.toString().replace(",", "; ") + "</td>";

					var modoOperacional = getResourceItem("centralizado");
					$.each(arrMarker, function (i, marker) {
						if (arrMarker[i].label._content == item.IdControlador) {
							if (arrMarker[i].options.title == "FC") {
								modoOperacional = "Local";
								return false;
							}
						}
					});
					cols += "<td>" + modoOperacional + "</td>";
					newRow.append(cols);
					$("#tblTarefasPendentes").append(newRow);
				});
			}
			else $("#tfTarefasPendentes").css("display", "");
			$("#divLoadTarefas").css("display", "none");
		},
		error: function (data) {
			$("#divLoadTarefas").css("display", "none");
		}
	});
}

function GetProblems() {
	$("#mpAvisos").modal("hide");
	$("#divLoading").css("display", "block");
	$.ajax({
		type: 'POST',
		url: 'WebServices/Map.asmx/GetProblems',
		dataType: 'json',
		data: "",
		contentType: "application/json; charset=utf-8",
		success: function (data) {
			var i = 0;
			$("#tbProblemas").empty();
			while (data.d[i]) {
				var lstProblems = data.d[i].split('@');
				var idDna = lstProblems[0];
				var falha = parseInt(lstProblems[1]);
				var dataAtualizacao = lstProblems[2];
				var statusComunicacao = lstProblems[3];
				var porta = lstProblems[4];
				var semComunicacao = lstProblems[5];

				var newRow = $("<tr>");
				var cols = "";

				var problema;
				var imgProblema;

				if (lstProblems[7] != "") {
					problema = "Manutenção";
					imgProblema = "Images/coneRed.png";
				}
				else {
					switch (statusComunicacao) {
						case "True":
							var bitsFalha = falha.toString(2);
							falhas = "";
							var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha", "");
							if (verificaFalhas.falhas == "Normal") {
								problema = verificaFalhas.falhas;
								imgProblema = "Images/semaforoNormal.png";
							}
							else {
								problema = verificaFalhas.falhas;
								imgProblema = "Images/semaforoFalha.png";
							}
							break;
						case "False":
							if (semComunicacao == "0") {
								problema = "Falha Comunicação";
								imgProblema = "Images/semaforoFalhaComunicacao.png";
							}
							else {
								problema = "Sem Comunicação";
								imgProblema = "Images/semComunicacao.png";
							}
							break;
					}
				}

				cols += "<td>" + idDna + "</td>";
				cols += "<td>" + problema + "</td>";
				cols += "<td>" + porta + "</td>";
				cols += "<td>" + dataAtualizacao + "</td>";
				if (lstProblems[7] != "") cols += "<td>" + getResourceItem("aberto") + "</td>";
				else cols += "<td> <a style='cursor:pointer;color:#0174DF;' onclick='AbrirOs(this,\"#popupProblemas\")' data-id=" + idDna + ">" + getResourceItem("abrir") + "</a></td>";
				newRow.append(cols);
				$("#tblProblemas").append(newRow);
				i++;
			}

			EstatisticaFalha();

			$("#divLoading").css("display", "none");
			FiltraProblemas("Inicial");
			$("#popupProblemas").modal({ keyboard: false, backdrop: false });

			$("#btnVoltarManutencao").data("voltar", "#popupProblemas");
			getAllNobreaks();
		},
		error: function (data) {
			window.location.reload(true);
		}
	});
}

function AbrirOs(handler, callName) {
	var idDna = $(handler).data("id");
	$("#sleFalha").selectedIndex = 0;
	document.getElementById("txtComplemento").value = "";

	$("#spaIdPontoManutencao").empty();
	$("#spaIdPontoManutencao").append(idDna);
	$("#popupManutencao").modal("show");
	$(callName).modal("hide");

}

function VoltarManutencao() {
	var popup = $("#btnVoltarManutencao").data(getResourceItem("voltar"));
	$(popup).modal("show");
	$("#popupManutencao").modal("hide");
}

function confirmOs() {
	var idFalha = $("#sleFalha").find(":selected").val();
	var complemento = document.getElementById("txtComplemento").value;
	var idPonto = $("#spaIdPontoManutencao").text();

	if (idFalha == "0") {
		$("[data-toggle='falha']").tooltip('show');
		return;
	}

	$.ajax({
		type: 'POST',
		url: 'WebServices/Map.asmx/OpenOs',
		dataType: 'json',
		data: "{'idFalha':'" + idFalha + "','idPonto':'" + idPonto + "','causa':'7','complemento':'" + complemento + "'}",
		contentType: "application/json; charset=utf-8",
		success: function (data) {
			$("#popupManutencao").modal("hide");
			window.location.reload(true);
		},
		error: function (data) {
			window.location.reload(true);
		}
	});
}

function AbrirPonto(handler, callName) {
	var idDna = document.getElementById("lblIdPonto").innerText.substring(13);
	$("#spIdPonto_VisualizarPonto").empty();
	$("#spIdPonto_VisualizarPonto").append(idDna);

	$(callName).modal("hide");

}
function FiltraProblemas(status) {
	$("#tblProblemas tbody tr").each(function () {

		var colunas = $(this).children();
		var falhas = $(colunas[1]).text();
		var porta = $(colunas[2]).text();
		var z = $(colunas[0]).text();
		var t = $(colunas[3]).text();
		var c = $(colunas[4]).text();
		var tr = this;

		if (falhas.search(",") != -1) {
			var lstFalhas = falhas.split(",");
			var i = 0;
			while (lstFalhas[i]) {
				switch (lstFalhas[i]) {
					case "Falta de Energia":
						if (status == "Inicial") {
							$("#chkFaltaEnergiProblem").prop("checked", true);
							$(tr).show();
						}
						else {
							if ($("#chkFaltaEnergiProblem").is(":checked")) {
								$(tr).show();
								return;
							}
							else {
								$(tr).hide();
							}
						}
						break;
					case "Subtensao":
						if (status == "Inicial") {
							$("#chkSubtencaoProblem").prop("checked", true);
							$(tr).show();
						}
						else {
							if ($("#chkSubtencaoProblem").is(":checked")) {
								$(tr).show();
								return;
							}
							else {
								$(tr).hide();
							}
						}
						break;
					case "Apagado/Desligado":
						if (status == "Inicial") {
							$("#chkDesligadoProblem").prop("checked", true);
							$(tr).show();
						}
						else {
							if ($("#chkDesligadoProblem").is(":checked")) {
								$(tr).show();
								return;
							}
							else {
								$(tr).hide();
							}
						}
						break;
					case "Amarelo intermitente":
						if (status == "Inicial") {
							$("#chkAmareloInterProblem").prop("checked", true);
							$(tr).show();
						}
						else {
							if ($("#chkAmareloInterProblem").is(":checked")) {
								$(tr).show();
								return;
							}
							else {
								$(tr).hide();
							}
						}
						break;
					case "Estacionado":
						if (status == "Inicial") {
							$("#chkEstaProblem").prop("checked", true);
							$(tr).show();
						}
						else {
							if ($("#chkEstaProblem").is(":checked")) {
								$(tr).show();
								return;
							}
							else {
								$(tr).hide();
							}
						}
						break;
				}

				i++;
			}
		}
		else {
			switch (falhas) {
				case "Normal":
					if (status == "Inicial") {
						$("#chkNormalProblem").prop("checked", true);
					}
					if ($("#chkNormalProblem").is(":checked")) {
						$(tr).show();
					}
					else {
						$(tr).hide();
					}
					break;
				case "Falta de Energia":
					if (status == "Inicial") {
						$("#chkFaltaEnergiProblem").prop("checked", true);
					}
					if ($("#chkFaltaEnergiProblem").is(":checked")) {
						$(tr).show();
					}
					else {
						$(tr).hide();
					}
					break;
				case "Subtensao":
					if (status == "Inicial") {
						$("#chkSubtencaoProblem").prop("checked", true);
					}
					if ($("#chkSubtencaoProblem").is(":checked")) {
						$(tr).show();
					}
					else {
						$(tr).hide();
					}
					break;
				case "Apagado/Desligado":
					if (status == "Inicial") {
						$("#chkDesligadoProblem").prop("checked", true);
					}
					if ($("#chkDesligadoProblem").is(":checked")) {
						$(tr).show();
					}
					else {
						$(tr).hide();
					}
					break;
				case "Amarelo intermitente":
					if (status == "Inicial") {
						$("#chkAmareloInterProblem").prop("checked", true);
					}
					if ($("#chkAmareloInterProblem").is(":checked")) {
						$(tr).show();
					}
					else {
						$(tr).hide();
					}
					break;
				case "Estacionado":
					if (status == "Inicial") {
						$("#chkEstaProblem").prop("checked", true);
					}
					if ($("#chkEstaProblem").is(":checked")) {
						$(tr).show();
					}
					else {
						$(tr).hide();
					}
					break;
				case "Falha Comunicação":
					if (status == "Inicial") {
						$("#chkFalhaComuProblem").prop("checked", true);
					}
					if ($("#chkFalhaComuProblem").is(":checked")) {
						$(tr).show();
					}
					else {
						$(tr).hide();
					}
					break;

				case "Sem Comunicação":
					if (status == "Inicial") {
						$("#chkSemComuProblem").prop("checked", true);
					}
					if ($("#chkSemComuProblem").is(":checked")) {
						$(tr).show();
					}
					else {
						$(tr).hide();
					}
					break;
			}
		}

	});
}

function closeProblemas() {
	$("#popupProblemas").modal("hide");
	$("#rdoPortaAberta").prop("checked", true);

	$("#chkNormalProblem").prop("checked", false);
	$("#chkFaltaEnergiProblem").prop("checked", false);
	$("#chkSubtencaoProblem").prop("checked", false);
	$("#chkDesligadoProblem").prop("checked", false);
	$("#chkAmareloInterProblem").prop("checked", false);
	$("#chkEstaProblem").prop("checked", false);
	$("#chkFalhaComuProblem").prop("checked", false);
	$("#chkSemComuProblem").prop("checked", false);
	$("#chkEstaProblem").prop("checked", false);
}

function ClosePopupFalhas() {
	$("#popupHistoricoFalhas").modal("hide");
}

function ClosePopupComunicacao() {
	$("#popupHistoricoComunicacao").modal("hide");
}

function SetarSemComuni() {
	$("#divPopupMarker").modal("hide");
	$("#popupSemComunicacao").modal("show");
	$("#spaIdPontoSemComu").empty();
	$("#spaIdPontoSemComu").append(document.getElementById('hfIdPonto').value);
}

function HabilitarSemComunicacao() {
	$.ajax({
		type: 'POST',
		url: 'WebServices/Map.asmx/HabilitarSemComunicacao',
		dataType: 'json',
		data: "{'idPonto':'" + $("#spaIdPontoSemComu").text() + "','statusSemComunicacao':'1'}",
		contentType: "application/json; charset=utf-8",
		success: function (data) {
			window.location.reload(true);
		},
		error: function (data) {
			window.location.reload(true);
		}
	});
}

function LimpaQtdFalhas() {
	qtdAmareloIntermitente = 0, qtdDesligado = 0, qtdEstacionado = 0, qtdPlugManual = 0, qtdFaltaEnergia = 0, qtdNormal = 0, qtdSubtencao = 0,
		qtdFalhaComunicacao = 0, qtdSemComunicacao = 0, qtdManutencao = 0, qtdFalhas = 0, qtdPortaAberta = 0, qtdImposicaoPlano = 0;

	document.getElementById("spaTotalNormal").innerHTML = 0;
	document.getElementById("spaTotalFalha").innerHTML = 0;
	document.getElementById("spaTotalFalhaComunicacao").innerHTML = 0;
	document.getElementById("spaTotalPlugManual").innerHTML = 0;
	document.getElementById("spaTotalImposicao").innerHTML = 0;
	document.getElementById("spaQtdTotalControl").innerHTML = 0;
}

function FilterMap(consorcio, empresa, idPonto, status) {

	var i = arrMarker.length - 1;
	if (status == undefined) {
		while (arrMarker[i]) {
			map.removeLayer(arrMarker[i]);
			arrMarker.pop(i);
			i--;
		}
	}
	$("#chkLabelMarker").data("checked", false);

	callServer('WebServices/Map.asmx/LoadFilterMap', "{'consorcio':'" + consorcio + "','empresa':'" + empresa + "','idPonto':'" + idPonto + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','endereco':'" + $("#txtCruzamento").val() + "'}", function (eqp) {
		var qtdNormalNob = 0, qtdFalhaNob = 0, qtdUsoNob = 0, qtdSemComunicaoNob = 0;
		$.each(eqp, function (index, item) {
			var statusPorta = "";

			if (item.statusManutencao != "-1") {
				CreateMarker(item.latitude, item.longitude, item.statusManutencao, item.idDna, "M", "" + item.estadoNobreak, status);
				qtdManutencao++;
				$("#btnAbrirOs").css("display", "none");
			}
			else {
				$("#btnAbrirOs").css("display", "");
				if (item.porta == "1") {
					qtdPortaAberta++;
					statusPorta = "P";
				}
				else {
					statusPorta = "";
				}

				switch (item.statusComunicacao) {
					case "True":
						var bitsFalha = parseInt(item.falha).toString(2);
						falhas = "";
						var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaPonto", "");
						CreateMarker(item.latitude, item.longitude, verificaFalhas.statusFalha, item.idDna, falhas, statusPorta + item.estadoNobreak, status);
						break;
					case "False":
						CreateMarker(item.latitude, item.longitude, "FalhaComunicacao", item.idDna, "FC", statusPorta + item.estadoNobreak, status);
						qtdFalhaComunicacao++;
						break;
				}
			}
			switch (item.estadoNobreak) {
				case "Normal":
					qtdNormalNob++;
					break;
				case "Falha":
					qtdFalhaNob++;
					break;
				case "EmUso":
					qtdUsoNob++;
					break;
				case "SC":
					qtdSemComunicaoNob++;
					break;
			}
            //map.setView(new L.LatLng(item.latitude, item.longitude), 13);
		});
		EstatisticaFalha();

		if ($("#chkModoNobreak").is(":checked")) {
			filterNobreakMap("init");
		}
		if ($("#ckdmodoEstatisticaCtrl").is(":checked")) {
			filterAllMapCtrl();
		}
		else {
			FiltraFalha();
		}
	});

}

function filterNobreakMap(tipo) {
	$("#divLoading").css("display", "block");
	setTimeout(function () {
		if ($("#chkModoNobreak").is(":checked")) {

			$("#chkNormalFilterNobreak").prop("disabled", false);
			$("#chkFalhaFilterNobreak").prop("disabled", false);
			$("#chkSCFilterNobreak").prop("disabled", false);
			$("#chkEmUsoFilterNobreak").prop("disabled", false);

			for (var i = 0; i < arrMarker.length; i++) {
				var estado = arrMarker[i].options.alt;
				if (estado.search("Camera") != -1) {
					estado = estado.replace('Camera', '');
				}
				if (estado.search("-") != -1) {
					estado = estado.replace('-', '');
				}
				if (estado.search("P") != -1) {
					estado = estado.replace('P', '');
				}
				switch (estado) {
					case "Normal":
						arrMarker[i].options.icon.options.iconUrl = 'Images/nobreakNormal.png';
						if (tipo == "init") {
							map.removeLayer(arrMarker[i]);
							map.addLayer(arrMarker[i]);
							$("#chkNormalFilterNobreak").prop("checked", true);
						}
						else {
							if ($("#chkNormalFilterNobreak").is(":checked")) {
								map.removeLayer(arrMarker[i]);
								map.addLayer(arrMarker[i]);
							}
							else {
								map.removeLayer(arrMarker[i]);
							}
						}
						break;
					case "Falha":
						arrMarker[i].options.icon.options.iconUrl = 'Images/nobreakFalha.png';
						if (tipo == "init") {
							map.removeLayer(arrMarker[i]);
							map.addLayer(arrMarker[i]);
							$("#chkFalhaFilterNobreak").prop("checked", true);
						}
						else {
							if ($("#chkFalhaFilterNobreak").is(":checked")) {
								map.removeLayer(arrMarker[i]);
								map.addLayer(arrMarker[i]);
							}
							else {
								map.removeLayer(arrMarker[i]);
							}
						}
						break;
					case "EmUso":
						arrMarker[i].options.icon.options.iconUrl = 'Images/nobreakEmUso.png';
						if (tipo == "init") {
							map.removeLayer(arrMarker[i]);
							map.addLayer(arrMarker[i]);
							$("#chkEmUsoFilterNobreak").prop("checked", true);
						}
						else {
							if ($("#chkEmUsoFilterNobreak").is(":checked")) {
								map.removeLayer(arrMarker[i]);
								map.addLayer(arrMarker[i]);
							}
							else {
								map.removeLayer(arrMarker[i]);
							}
						}
						break;
					case "SC":
						arrMarker[i].options.icon.options.iconUrl = 'Images/nobreakFalhaComunicacao.png';
						if (tipo == "init") {
							map.removeLayer(arrMarker[i]);
							map.addLayer(arrMarker[i]);
							$("#chkSCFilterNobreak").prop("checked", true);
						}
						else {
							if ($("#chkSCFilterNobreak").is(":checked")) {
								map.removeLayer(arrMarker[i]);
								map.addLayer(arrMarker[i]);
							}
							else {
								map.removeLayer(arrMarker[i]);
							}
						}
						break;
				}

			}
		}
		else {
			$("#chkNormalFilterNobreak").prop("disabled", true);
			$("#chkFalhaFilterNobreak").prop("disabled", true);
			$("#chkSCFilterNobreak").prop("disabled", true);
			$("#chkEmUsoFilterNobreak").prop("disabled", true);

			$("#chkNormalFilterNobreak").prop("checked", false);
			$("#chkFalhaFilterNobreak").prop("checked", false);
			$("#chkSCFilterNobreak").prop("checked", false);
			$("#chkEmUsoFilterNobreak").prop("checked", false);

			FiltraFalha();
		}
		$("#divLoading").css("display", "none");
		if (0) { 0(); }
	}, 0);
}

function FiltraFalha() {
	var i = 0;
	while (arrMarker[i]) {

		var markerFalhas = arrMarker[i].options.title;

		if (markerFalhas.search(",") != -1) {
			var lstFalhas = markerFalhas.split(',');
			var f = 0;
			var percorreFalha = true;
			while (lstFalhas[f] && percorreFalha == true) {
				arrMarker[i].options.icon.options.markerColor = 'red';

				switch (lstFalhas[f]) {
					//Falta de Energia f
					case "F":
						map.removeLayer(arrMarker[i]);
						map.addLayer(arrMarker[i]);
						percorreFalha = false;
						break;
					//Subtensão s
					case "S":
						map.removeLayer(arrMarker[i]);
						map.addLayer(arrMarker[i]);
						percorreFalha = false;
					//Apagado/Desligado d
					case "D":
						map.removeLayer(arrMarker[i]);
						map.addLayer(arrMarker[i]);
						percorreFalha = false;
						break;
					//Amarelo intermitente ai
					case "A":
						map.removeLayer(arrMarker[i]);
						map.addLayer(arrMarker[i]);
						percorreFalha = false;
						break;
					//Estacionado e
					case "E":
						map.removeLayer(arrMarker[i]);
						map.addLayer(arrMarker[i]);
						percorreFalha = false;
						break;
				}

				f++;
			}
		}
		else {
			switch (markerFalhas) {
				//Normal
				case "N":
					arrMarker[i].options.icon.options.markerColor = 'green';
					map.removeLayer(arrMarker[i]);
					map.addLayer(arrMarker[i]);
					break;
				//Falha Comunicacao
				case "FC":
					arrMarker[i].options.icon.options.markerColor = 'gray';
					map.removeLayer(arrMarker[i]);
					map.addLayer(arrMarker[i]);
					break;
				//Falta de Energia f
				case "F":
					arrMarker[i].options.icon.options.markerColor = 'red';
					map.removeLayer(arrMarker[i]);
					map.addLayer(arrMarker[i]);
					break;
				//Subtensão s
				case "S":
					arrMarker[i].options.icon.options.markerColor = 'red';
					map.removeLayer(arrMarker[i]);
					map.addLayer(arrMarker[i]);
					break;
				//Apagado/Desligado d
				case "D":
					map.removeLayer(arrMarker[i]);
					map.addLayer(arrMarker[i]);
					arrMarker[i].options.icon.options.markerColor = 'red';
					break;
				//Amarelo intermitente ai
				case "A":
					arrMarker[i].options.icon.options.markerColor = 'red';
					map.removeLayer(arrMarker[i]);
					map.addLayer(arrMarker[i]);
					break;
				//Estacionado e
				case "E":
					arrMarker[i].options.icon.options.markerColor = 'red';
					map.removeLayer(arrMarker[i]);
					map.addLayer(arrMarker[i]);
					break;
			}
		}

		i++;
	}
}

function filterAllMapCtrl(tipo) {
	$("#divLoading").css("display", "block");
	setTimeout(function () {
		if (document.getElementById("ckdmodoEstatisticaCtrl").checked == true) {
			var i = 0;

			document.getElementById("chkFilterNormMapCtrl").disabled = false;
			document.getElementById("chkFilterFalhaMapCtrl").disabled = false;
			document.getElementById("chkFilterFcMapCtrl").disabled = false;
			document.getElementById("chkFilterPlugManual").disabled = false;
			document.getElementById("chkFilterImposicao").disabled = false;
			document.getElementById("chkFilterPorta").disabled = false;

			var check = "true";
			if ($("#chkFilterNormMapCtrl").is(":checked")) {
				check = "false";
			}
			if ($("#chkFilterFalhaMapCtrl").is(":checked")) {
				check = "false";
			}
			if ($("#chkFilterFcMapCtrl").is(":checked")) {
				check = "false";
			}
			if ($("#chkFilterPlugManual").is(":checked")) {
				check = "false";
			}
			if ($("#chkFilterImposicao").is(":checked")) {
				check = "false";
			}
			if ($("#chkFilterPorta").is(":checked")) {
				check = "false";
			}

			while (arrMarker[i]) {

				var markerFalhas = arrMarker[i].options.title;
				var porta = arrMarker[i].options.alt.substring(0, 1);

				if ($("#chkModoNobreak").is(":checked") && arrMarker[i].options.icon.options.iconUrl.search("nobreak") != -1) {
					if (i != arrMarker.length) {
						i++;
					}
					else {
						break;
					}
					continue;
				}
				if (markerFalhas.search(",") != -1) {
					var lstFalhas = markerFalhas.split(',');
					var f = 0;

					while (lstFalhas[f]) {
						arrMarker[i].options.icon.options.markerColor = 'red';
						switch (lstFalhas[f]) {
							case "F":
							case "S":
							case "D":
							case "A":
							case "E":
								if (document.getElementById("chkFilterFalhaMapCtrl").checked == false) {
									map.removeLayer(arrMarker[i]);
								}
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
									break;
								}
								break;
						}

						f++;
					}
				}
				else {
					switch (markerFalhas) {
						case "N":
							if (tipo == 'init') {
								if (check == "true") $("#chkFilterNormMapCtrl").prop("checked", true);

								if (!$("#chkFilterNormMapCtrl").is(":checked")) map.removeLayer(arrMarker[i]);
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
								}
							}
							else {
								if (!$("#chkFilterNormMapCtrl").is(":checked")) {
									map.removeLayer(arrMarker[i]);
								}
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
								}
							}

							if ($("#chkFilterPorta").is(":checked") && porta == "P") {
								map.removeLayer(arrMarker[i]);
								map.addLayer(arrMarker[i]);
							} else if ($("#chkFilterPorta").is(":checked") && porta != "P") {
								map.removeLayer(arrMarker[i]);
							}
							break;
						case "PL":
							if (tipo == 'init') {
								if (check == "true") $("#chkFilterPlugManual").prop("checked", true);

								if (!$("#chkFilterPlugManual").is(":checked")) map.removeLayer(arrMarker[i]);
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
								}
							}
							else {
								if (!$("#chkFilterPlugManual").is(":checked")) map.removeLayer(arrMarker[i]);
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
								}
							}

							if ($("#chkFilterPorta").is(":checked") && porta == "P") {
								map.removeLayer(arrMarker[i]);
								map.addLayer(arrMarker[i]);
							} else if ($("#chkFilterPorta").is(":checked") && porta != "P") {
								map.removeLayer(arrMarker[i]);
							}
							break;
						case "IP":
							if (tipo == 'init') {
								if (check == "true") $("#chkFilterImposicao").prop("checked", true);

								if (!$("#chkFilterImposicao").is(":checked")) map.removeLayer(arrMarker[i]);
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
								}
							}
							else {
								if (!$("#chkFilterImposicao").is(":checked")) map.removeLayer(arrMarker[i]);
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
								}
							}

							if ($("#chkFilterPorta").is(":checked") && porta == "P") {
								map.removeLayer(arrMarker[i]);
								map.addLayer(arrMarker[i]);
							} else if ($("#chkFilterPorta").is(":checked") && porta != "P") {
								map.removeLayer(arrMarker[i]);
							}
							break;
						case "FC":
							arrMarker[i].options.icon.options.markerColor = 'gray';
							if (tipo == 'init') {
								if (check == "true") {
									$("#chkFilterFcMapCtrl").prop("checked", true);
								}
								arrMarker[i].options.icon.options.markerColor = 'gray';
								if (!$("#chkFilterFcMapCtrl").is(":checked")) {
									map.removeLayer(arrMarker[i]);
								}
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
								}
							}
							else {
								arrMarker[i].options.icon.options.markerColor = 'gray';
								if (!$("#chkFilterFcMapCtrl").is(":checked")) {
									map.removeLayer(arrMarker[i]);
								}
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
								}
							}

							if ($("#chkFilterPorta").is(":checked") && porta == "P") {
								map.removeLayer(arrMarker[i]);
								map.addLayer(arrMarker[i]);
							} else if ($("#chkFilterPorta").is(":checked") && porta != "P") {
								map.removeLayer(arrMarker[i]);
							}
							break;
						case "M":
							if (tipo == 'init') {
								if (check == "true") {
									$("#chkFilterMMapCtrl").prop("checked", true);
								}
								if (!$("#chkFilterMMapCtrl").is(":checked")) {
									map.removeLayer(arrMarker[i]);
								}
								else {
									map.addLayer(arrMarker[i]);
								}
							}
							else {
								if (!$("#chkFilterMMapCtrl").is(":checked")) {
									map.removeLayer(arrMarker[i]);
								}
								else {
									map.addLayer(arrMarker[i]);
								}
							}

							if ($("#chkFilterPorta").is(":checked") && porta == "P") {
								map.removeLayer(arrMarker[i]);
								map.addLayer(arrMarker[i]);
							} else if ($("#chkFilterPorta").is(":checked") && porta != "P") {
								map.removeLayer(arrMarker[i]);
							}
							break;
						case "F":
						case "S":
						case "D":
						case "A":
						case "E":
							arrMarker[i].options.icon.options.markerColor = 'red';
							if (tipo == 'init') {
								if (check == "true") {
									$("#chkFilterFalhaMapCtrl").prop("checked", true);
								}
								arrMarker[i].options.icon.options.markerColor = 'red';
								if (!$("#chkFilterFalhaMapCtrl").is(":checked")) {
									map.removeLayer(arrMarker[i]);
								}
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
								}
							}
							else {
								arrMarker[i].options.icon.options.markerColor = 'red';
								if (!$("#chkFilterFalhaMapCtrl").is(":checked")) {
									map.removeLayer(arrMarker[i]);
								}
								else {
									map.removeLayer(arrMarker[i]);
									map.addLayer(arrMarker[i]);
								}
							}

							if ($("#chkFilterPorta").is(":checked") && porta == "P") {
								map.removeLayer(arrMarker[i]);
								map.addLayer(arrMarker[i]);
							} else if ($("#chkFilterPorta").is(":checked") && porta != "P") {
								map.removeLayer(arrMarker[i]);
							}
							break;
					}
				}

				i++;
			}
		}
		else {
			document.getElementById("chkFilterNormMapCtrl").disabled = true;
			document.getElementById("chkFilterFalhaMapCtrl").disabled = true;
			document.getElementById("chkFilterFcMapCtrl").disabled = true;
			document.getElementById("chkFilterPlugManual").disabled = true;
			document.getElementById("chkFilterImposicao").disabled = true;
			document.getElementById("chkFilterPorta").disabled = true;
			FiltraFalha();
		}
		$("#divLoading").css("display", "none");
		if (0) { 0(); }
	}, 0);

}

function loadGruposSubArea(obj) {
	LimparAneisMap();
	loadAnelSubArea(obj);

	$("#tbVinculoSubArea").empty();
	$("#tfVinculoSubArea").css("display", "none");

	callServer("Default.aspx/getAneisVinculados", "{'idArea':'" + $(obj).data("id") + "'}",
		function (results) {
			if (results != "") {
				$.each(results, function (index, item) {
					var newRow = $("<tr>");
					var cols = "";

					if (index == 0) $("#lblSubArea").text(item.nomeSubArea);

					cols += "<td>" + item.Endereco + "</td>";
					cols += "<td>" + item.idEqp + " / " + item.anel + "</td>";

					var modoOperacional = getResourceItem("centralizado");
					$.each(arrMarker, function (i, marker) {
						if (arrMarker[i].label._content == item.idDna) {
							if (arrMarker[i].options.title == "FC") {
								modoOperacional = "Local";
								return false;
							}
						}
					});
					cols += "<td>" + modoOperacional + "</td>";
					cols += "<td><a class='btn btn-primary' onclick='AbrirMonitoramento(" + item.idEqp + ");'><img style='width:20px;' src='../Images/TempoReal.png' /></a ></td > ";
					$(newRow).append(cols);
					$("#tblVinculoSubArea").append(newRow);
				});
			}
			else $("#tfVinculoSubArea").css("display", "");

			$("#modalVinculoSubArea").modal("show");
		});
}
