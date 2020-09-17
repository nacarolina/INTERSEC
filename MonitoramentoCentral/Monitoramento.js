
var sender = new DuplexTypedMessageSender();
sender.onResponseReceived = mensagemMonitoramento;
var timerSendMessage;

var timer;
$(function () {
    loadResourcesLocales();
    $("#divLoading").css("display", "block");
    openConnection();
    $("#spnIdEqp").text($("#hdfIdEqp").val());

    getFalhasEqp();
    timerSendMessage = setInterval(function () {
        sendMessage("ObterDados" + $("#hdfIdEqp").val());
        $("#divLoading").css("display", "none");
    }, 1000);

    timer = setInterval(function () {
        getFalhasEqp();
    }, 15000);
});

function getFalhasEqp() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: 'Monitoramento.aspx/getFalhasEqp',
        data: '{"idEqp":"' + $("#hdfIdEqp").val() + '"}',
        dataType: "json",
        success: function (data) {

            if (data.d=="SC") {
                document.getElementById("lblFalhas").innerHTML = getResourceItem("semComunicacao");
                return;
            }
            if (data.d == "FC") {
                document.getElementById("lblFalhas").innerHTML = getResourceItem("falhasNaComunicacao");
                return;
            }
            var bitsFalha = parseInt(data.d).toString(2);
            var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha", "");
            document.getElementById("lblFalhas").innerHTML = verificaFalhas.falhas;
            $("#spaFalhas").css("color", "red");
        }
    });
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

var globalResources;
function loadResourcesLocales() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: 'Monitoramento.aspx/requestResource',
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

var callServer = function (urlName, params, callback) {
    $("#divLoading").css("display", "block");
    $.ajax({
        type: 'POST',
        url: urlName,
        dataType: 'json',
        data: params,
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (callback && typeof (callback) == "function") callback(data.d);

            $("#divLoading").css("display", "none");
        },
        error: function (data) {
            $("#divLoading").css("display", "none");
        }
    });
};

function RequestMessage(solicitacaoMensagem) {
    this.solicitacaoMensagem = solicitacaoMensagem;
}

function openConnection() {
    try {
        var anOutputChannel = new WebSocketDuplexOutputChannel("ws://187.122.100.125:8091/", null);
        sender.attachDuplexOutputChannel(anOutputChannel);
    } catch (err) { clearInterval(timerSendMessage); }
};

function closeConnection() {
    sender.detachDuplexOutputChannel();
    clearInterval(timerSendMessage);
};

function sendMessage(msg) {
    if (msg.indexOf("ObterDados") == -1) msg += $("#hdfIdEqp").val();

    try {
        var requestMessage = new RequestMessage(msg);
        sender.sendRequestMessage(requestMessage);
    } catch (err) { clearInterval(timerSendMessage); }
};

function mensagemMonitoramento(typedResponseReceivedEventArgs) {
    try {
        var msg = typedResponseReceivedEventArgs.ResponseMessage.respostaMensagem;
        if (msg != "OK") {
            msg = msg.split('PRTCL');
            $.each(msg, (i, item) => {
                /*recupera data hora do equipamento*/
                if (item.indexOf("DTHR") != -1) {
                    item = item.replace("DTHR", "");

                    var ano = item.substring(0, 4), mes = item.substring(4, 6), dia = item.substring(6, 8), hr = item.substring(8, 10), min = item.substring(10, 12),
                        seg = item.substring(12);
                    dthr = dia + "/" + mes + "/" + ano + " " + hr + ":" + min + ":" + seg;
                    $("#spnRelogio").text(dthr);
                }

                /*recupera informações para o monitoramento dos estagios */
                else if (item.indexOf("ESTAGIO") != -1) {
                    var configEstagios = item.split('BRBR');

                    var estagio, tmCiclo, ciclo, atrasoCiclo, tmEstagioCount, tmEstagio, anel, tipoPlano, executando_PlanoImposto, nome_PlanoImposto;
                    $.each(configEstagios, (i, itemEstagio) => {
                        if (itemEstagio.indexOf("TMCICLO") != -1) tmCiclo = formatMessage(itemEstagio, "TMCICLO");
                        else if (itemEstagio.indexOf("ATRASOCICLO") != -1) atrasoCiclo = formatMessage(itemEstagio, "ATRASOCICLO");
                        else if (itemEstagio.indexOf("CICLO") != -1) ciclo = formatMessage(itemEstagio, "CICLO");
                        else if (itemEstagio.indexOf("PLANOCORRENTE") != -1) $("#spnPlanoCorrente").text(formatMessage(itemEstagio, "PLANOCORRENTE"));
                        else if (itemEstagio.indexOf("TIPOPLANO") != -1) {
                            if (formatMessage(itemEstagio, "TIPOPLANO") != "") tipoPlano = formatMessage(itemEstagio, "TIPOPLANO");
                        }
                        else if (itemEstagio.indexOf("TMESTAGIOCOUNT") != -1) tmEstagioCount = formatMessage(itemEstagio, "TMESTAGIOCOUNT");
                        else if (itemEstagio.indexOf("TMESTAGIO") != -1) tmEstagio = formatMessage(itemEstagio, "TMESTAGIO");
                        else if (itemEstagio.indexOf("ESTAGIO") != -1) estagio = formatMessage(itemEstagio, "ESTAGIO");

                        else if (itemEstagio.indexOf("ANEL") != -1) {
                            anel = formatMessage(itemEstagio, "ANEL");

                            if (tipoPlano != undefined) {
                                if (tipoPlano.toUpperCase().indexOf("COORDENADO") != -1) {
                                    $("#tdTmNoCicloAnel" + anel).css("display", "");
                                    $("#tdTmCicloAnel" + anel).css("display", "");
                                    $("#tdAtrasoCicloAnel" + anel).css("display", "");
                                }
                                else {
                                    $("#tdTmNoCicloAnel" + anel).css("display", "none");
                                    $("#tdTmCicloAnel" + anel).css("display", "none");
                                    $("#tdAtrasoCicloAnel" + anel).css("display", "none");
                                }
                            }
                        }
                    });
                    setInformacoesEstagio(new informacoesEstagio(estagio, tmCiclo, ciclo, atrasoCiclo, tmEstagioCount, tmEstagio, anel, tipoPlano));
                }

                /*recupera informações para o monitoramento dos grupos */
                else if (item.indexOf("ANEL") != -1) {
                    var grupo, cor, tipo, anel;
                    var configGrupos = item.split('BRBR');

                    $.each(configGrupos, (i, itemGrupo) => {
                        if (itemGrupo.indexOf("ANEL") != -1) anel = formatMessage(itemGrupo, "ANEL");
                        else if (itemGrupo.indexOf("GF") != -1) grupo = formatMessage(itemGrupo, "GF");
                        else if (itemGrupo.indexOf("COR") != -1) cor = formatMessage(itemGrupo, "COR");
                        else if (itemGrupo.indexOf("TIPOGRUPO") != -1) tipo = formatMessage(itemGrupo, "TIPOGRUPO");
                    });
                    createGrupoSemaforico(new configGrupoFocal(grupo, cor, tipo, anel));
                }

                /*recupera o modo operacional do equipamento */
                else if (item.indexOf("MODO") != -1) $("#spnModoOperacional").text(formatMessage(item, "MODO"));

                /*recupera a programação do equipamento */
                else if (item.indexOf("PROGRAMACAO") != -1) $("#spnProgramacao").text(formatMessage(item, "PROGRAMACAO"));
            });
        }

    } catch (err) { clearInterval(timerSendMessage); }
};

function configGrupoFocal(grupoFocal, cor, tipo, anel) {
    this.GrupoFocal = grupoFocal;
    this.Cor = cor;
    this.Tipo = tipo;
    this.Anel = anel;
}

var formatMessage = function (item, msg) {
    item = item.replace(msg, "");
    return item;
}

function createGrupoSemaforico(infoGrupo) {
    $("#trInfoAnel" + infoGrupo.Anel).css("display", "");
    $("#trGruposAnel" + infoGrupo.Anel).css("display", "");

    var tdGrupo = $("<td id='tdGrupo" + infoGrupo.GrupoFocal + "' style='border:1px solid #d4d4d4; width:150px;'>");
    if ($("#tdGrupo" + infoGrupo.GrupoFocal + " > img").length == 0) {
        $("#trGruposAnel" + infoGrupo.Anel).append(tdGrupo);
        tdGrupo.append("<label>G" + infoGrupo.GrupoFocal + "</label><br/><img src='" + getImgCorGrupo(infoGrupo.Cor, infoGrupo.Tipo) + "' style='width:28px; height:58px;' />");
    }
    else $("#tdGrupo" + infoGrupo.GrupoFocal + " > img").attr("src", getImgCorGrupo(infoGrupo.Cor, infoGrupo.Tipo));
}

var getImgCorGrupo = function (cor, tipo) {
    var src = "";
    if (tipo == "VEICULAR") {
        src = cor == "AMARELOINTERMITENTE" ? "GV_AmareloInterm.gif" : src;
        src = cor == "VERDE" ? "GV_Verde.png" : src;
        src = cor == "AMARELO" ? "GV_Amarelo.png" : src;
        src = cor == "VERMELHO" ? "GV_Vermelho.png" : src;
        src = cor == "APAGADO" ? "GV_Apagado.png" : src;
    } else {
        src = cor == "VERDE" ? "GP_Verde.png" : src;
        src = cor == "VERMELHO" ? "GP_Vermelho.png" : src;
        src = cor == "APAGADO" ? "GP_Apagado.png" : src;
        src = cor == "AMARELOINTERMITENTE" ? "GP_Apagado.png" : src;
        src = cor == "VERMELHOINTERMITENTE" ? "GP_VermelhoInter.gif" : src;
    }

    return "../Images/" + src;
}

function informacoesEstagio(estagio, tmCiclo, ciclo, atrasoCiclo, tmEstagioCount, tmEstagio, anel, tipoPlano) {
    this.Estagio = estagio;
    this.TmCiclo = tmCiclo;
    this.Ciclo = ciclo;
    this.AtrasoCiclo = atrasoCiclo;
    this.TmEstagioCount = tmEstagioCount;
    this.TmEstagio = tmEstagio;
    this.Anel = anel;
    this.TipoPlano = tipoPlano;
}

function setInformacoesEstagio(infoEstagio) {
    $("#spnEstagioAnel" + infoEstagio.Anel).text(infoEstagio.Estagio);
    $("#spnTmNoCicloAnel" + infoEstagio.Anel).text(infoEstagio.TmCiclo);
    $("#spnTmCicloAnel" + infoEstagio.Anel).text(infoEstagio.Ciclo);
    $("#spnAtrasoCicloAnel" + infoEstagio.Anel).text(infoEstagio.AtrasoCiclo);
    $("#spnTmEstagioRestanteAnel" + infoEstagio.Anel).text(infoEstagio.TmEstagioCount);
    $("#spnTmEstagioAnel" + infoEstagio.Anel).text(infoEstagio.TmEstagio);
    $("#spnTipoPlanoCorrenteAnel" + infoEstagio.Anel).text(infoEstagio.TipoPlano);

}

function ResetAnelEqp(anel) {
    callServer("Monitoramento.aspx/ResetAnelEqp", "{'anel':'" + anel + "','idEqp':'" + $("#hdfIdEqp").val() + "'}",
        function (results) {
            swal(getResourceItem("informacao"), getResourceItem("reinicioAnel") + ": " + anel + " " + getResourceItem("solicitado"), "success");
        });
}

function ResetEqp() {
    callServer("Monitoramento.aspx/ResetEqp", "{'idEqp':'" + $("#hdfIdEqp").val() + "'}",
        function (results) {
            swal(getResourceItem("informacao"), "Reset " + getResourceItem("solicitado") + "!", "success");
        });
}

function ObterDados() {
    window.location.reload(true);
}

function LoadImposicaoPlanos() {
    $("#tbPlanos").empty();
    $("#tfPlanos").css("display", "none");

    callServer("Monitoramento.aspx/getPlanos", "{'idEqp':'" + $("#hdfIdEqp").val() + "'}",
        function (results) {
            if (results != "") {
                $.each(results, function (index, item) {
                    var newRow = $("<tr>");
                    var cols = "<td>" + item.NomePlano + "</td>";
                    cols += "<td>" + item.Tipo + "</td>";

                    if (item.Imposicao == true)
                        cols += "<td><button type='button' class='btn btn-danger' data-tipo='cancelamento' data-plano='" + item.NomePlano + "' onclick='ImporPlano(this)'><span class='glyphicon glyphicon-remove'></span></button></td>";
                    else
                        cols += "<td><button type='button' class='btn btn-success' data-tipo='imposicao' data-plano='" + item.NomePlano + "' onclick='ImporPlano(this)'><span class='glyphicon glyphicon-ok'></span></button></td>";

                    $(newRow).append(cols);
                    $("#tblPlanos").append(newRow);
                });
            }
            else $("#tfPlanos").css("display", "");

        });

    $("#modalImposicao").modal("show");
}


function ImporPlano(obj) {
    var tipo = $(obj).data("tipo"), idEqp = $("#hdfIdEqp").val(), plano = $(obj).data("plano");

    callServer("Monitoramento.aspx/ImporPlano", "{'plano':'" + plano + "','idEqp':'" + idEqp + "','tempo':'" + $("#txtTempoImposicao").val() + "','tipo':'" + tipo + "'}",
        function (results) {
            if (results == false) {
                if (tipo == "imposicao") {
                    $(obj).attr("class", "btn btn-danger");
                    $(obj.firstChild).attr("class", "glyphicon glyphicon-remove");
                    $(obj).data("tipo", "cancelamento");
                    swal(getResourceItem("informacao"), getResourceItem("imposicao") + " " + getResourceItem("solicitada"), "success");
                } else {
                    $(obj).attr("class", "btn btn-success");
                    $(obj.firstChild).attr("class", "glyphicon glyphicon-ok");
                    $(obj).data("tipo", "imposicao");
                    swal(getResourceItem("informacao"), getResourceItem("cancelamento") + " " + getResourceItem("imposicao") + " " + getResourceItem("solicitada"), "success");
                }
            }
            else swal(getResourceItem("atencao"), getResourceItem("imposicaoAndamento"), "warning");
        });
}