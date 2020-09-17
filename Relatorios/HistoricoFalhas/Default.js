$(function () {
    $('.datepicker').datepicker({
        dateFormat: "dd/mm/yyyy",
        language: 'pt-BR'
    });
});

function GetBusinesses() {
    var sleConsorcio = document.getElementById("sleConsorcio");
    if (sleConsorcio.selectedIndex == 0) {
        $("#sleEmpresa").empty();
        return;
    }

    else {
        $("#divLoad").css("display", "block");

        $.ajax({
            type: 'POST',
            url: '../../Default.aspx/GetBusinesses',
            dataType: 'json',
            data: "{'consorcioId':'" + sleConsorcio.selectedIndex + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                $("#sleEmpresa").empty().append($("<option></option>").val("[0]").html("Selecione..."));
                $.each(data.d, function () {
                    $("#sleEmpresa").append($("<option></option>").val(this['Value']).html(this['Text']));
                });
                $("#divLoad").css("display", "none");
            },
            error: function (data) { params = data; alert('Erro ao obter parametros, tente novamente!'); }
        });
    }
}

function PesquisarFalhas() {
    var i = 0;

    var consorcioId = $("#sleConsorcio option:selected").val();
    var empresa = $("#sleEmpresa option:selected").text();

    var idPonto = document.getElementById("txtIdPonto").value;
    var dataInicial = document.getElementById("txtDataInicial").value;
    var dataFinal = document.getElementById("txtDataFinal").value;

    if (dataInicial == "") {
        $("#txtDataInicial").prop("placeholder", "Obrigatorio!");
        $("#txtDataInicial").addClass('valida-Data');
        $("#txtDataInicial").focus();
        return;
    }
    else {
        $("#txtDataInicial").prop("placeholder", "Inicial");
        $("#txtDataInicial").removeClass('valida-Data');
    }

    if (dataFinal == "") {
        $("#txtDataFinal").prop("placeholder", "Obrigatorio!");
        $("#txtDataFinal").addClass('valida-Data');
        $("#txtDataFinal").focus();
        return;
    }
    else {
        $("#txtDataFinal").prop("placeholder", "Final");
        $("#txtDataFinal").removeClass('valida-Data');
    }

    if (consorcioId == "0") {
        consorcioId = "";
    }
    if (empresa == "Selecione...") {
        empresa = "";
    }

    var statusFalha;

    if ($("#rdoFalha").is(":checked")) {
        statusFalha = "falha";
    }
    else {
        statusFalha = "semComunicacao";
    }

    $("#divLoad").css("display", "block");

    $.ajax({
        type: 'POST',
        url: 'HistoFalha.asmx/PesquisarFalhas',
        dataType: 'json',
        data: "{'consorcioId':'" + consorcioId + "','empresa':'" + empresa + "','idPonto':'" + idPonto + "','statusFalha':'" + statusFalha + "','dataInicial':'" + dataInicial + "','dataFinal':'" + dataFinal + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d.toString() == "") {
                document.getElementById("spaTotal").innerHTML = " 0";
            }
            var i = 0;
            $("#tbHistoricoFalhas").empty();

            while (data.d[i]) {
                var lstFalhas = data.d[i].split('@');
                var idDna = lstFalhas[0];

                var dataFalha = lstFalhas[1];
                var porta = lstFalhas[2];

                var newRow = $("<tr>");
                var cols = "";

                document.getElementById("spaTotal").innerHTML = lstFalhas[4];

                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + idDna + "</td>";
                switch (statusFalha) {
                    case "falha":
                        var falha = parseInt(lstFalhas[3]);
                        var bitsFalha = falha.toString(2);
                        var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha");
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + verificaFalhas.falhas + "</td>";
                        break;

                    case "semComunicacao":
                        var statusSemComunicacao = lstFalhas[3];
                        switch (statusSemComunicacao) {
                            case "0":
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>Falha Comunicação</td>";
                                break;
                            case "1":
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>Sem Comunicação</td>";
                                break;
                        }
                        break;
                }

                switch (porta) {
                    case "1":
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>Aberta</td>";
                        break;
                    case "0":
                        cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>Fechada</td>";
                        break;
                }
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dataFalha + "</td>";

                newRow.append(cols);
                $("#tblHistoricoFalhas").append(newRow);

                i++;
            }

            $("#divListaFalhaControl").css("display", "block");
            $("#divLoad").css("display", "none");

        },
        error: function (data) {
            window.location.reload(true);
        }
    });
}

function VerificaFalhas(bitsFalha, callName) {

    this.falhas = "";

    if (bitsFalha == 0) {
        if (callName == "CarregaFalha") {
            this.falhas = "Normal";
        }
    }
    else {
        bitsFalha = bitsFalha.split('').reverse().join('');
        for (var positionBit = 0; positionBit < bitsFalha.length; positionBit++) {
            //Falta de Energia
            if (positionBit == 0 && bitsFalha[positionBit] == "1") {
                if (callName == "CarregaFalha") {
                    this.falhas = "Falta de Energia";
                }
            }

            //Subtensao
            if (positionBit == 1 && bitsFalha[positionBit] == "1") {
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
                if (callName == "CarregaFalha") {
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
}

function Imprimir() {

    $("#scrollHistoFalhas").css("overflow-y", "hidden");
    $("#scrollHistoFalhas").css("height", "auto");
    $("#divPesquisar").css("display", "none");

    document.body.innerHTML =
      "<html><head><title></title></head><body>" +
      document.getElementById('divTitle').innerHTML + document.getElementById('divListaFalhaControl').innerHTML + "</body>";

    window.print();

    window.location.reload(true);
}

function Excel() {
    window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('div[id$=divListaFalhaControl]').html()));
}

$(document).ready(function () {
    $("#txtCruzamento").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: 'Default.aspx/GetDna',
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
});