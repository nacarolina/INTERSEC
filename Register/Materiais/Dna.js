//---------------------------------------------------------------------------------------

$(document).ready(function () {

    //$('.clockpicker').clockpicker();

    //$("#input-pt-br").fileinput({
    //    language: "pt-BR",
    //    uploadUrl: "Dna.aspx",
    //    maxFilePreviewSize: 10240,
    //    allowedFileExtensions: ["jpg", "jpeg", "png", "gif", "svg"],
    //    uploadAsync: true,
    //    elErrorContainer: '#kv-error-1'
    //}).on('filebatchpreupload', function (event, data, id, index) {
    //    $('#kv-success-1').html('<h4>Upload Status</h4><ul></ul>').hide();
    //}).on('fileuploaded', function (event, data, id, index) {
    //    var fname = data.files[index].name,
    //        out = '<li>' + 'Uploaded file # ' + (index + 1) + ' - ' +
    //            fname + ' successfully.' + '</li>';
    //    $('#kv-success-1 ul').append(out);
    //    $('#kv-success-1').fadeIn('slow');
    //});

    //$("#input-pt-br_Projeto").fileinput({
    //    language: "pt-BR",
    //    uploadUrl: "Dna.aspx",
    //    maxFilePreviewSize: 10240,
    //    allowedFileExtensions: ["pdf"],
    //    uploadAsync: true,
    //    elErrorContainer: '#kv-error-1'
    //}).on('filebatchpreupload', function (event, data, id, index) {
    //    $('#kv-success-1').html('<h4>Upload Status</h4><ul></ul>').hide();
    //}).on('fileuploaded', function (event, data, id, index) {
    //    var fname = data.files[index].name,
    //        out = '<li>' + 'Uploaded file # ' + (index + 1) + ' - ' +
    //            fname + ' successfully.' + '</li>';
    //    $('#kv-success-1 ul').append(out);
    //    $('#kv-success-1').fadeIn('slow');
    //});

    //$("#input-pt-br_Arquivo").fileinput({
    //    language: "pt-BR",
    //    uploadUrl: "Dna.aspx",
    //    maxFilePreviewSize: 10240,
    //    allowedFileExtensions: ["jpg", "jpeg", "png", "gif", "svg", "doc", "docx", "pdf", "rar", "zip", "mp4", "avi", "mpg", "txt", "xls"],
    //    uploadAsync: true,
    //    elErrorContainer: '#kv-error-1'
    //}).on('filebatchpreupload', function (event, data, id, index) {
    //    $('#kv-success-1').html('<h4>Upload Status</h4><ul></ul>').hide();
    //}).on('fileuploaded', function (event, data, id, index) {
    //    var fname = data.files[index].name,
    //        out = '<li>' + 'Uploaded file # ' + (index + 1) + ' - ' +
    //            fname + ' successfully.' + '</li>';
    //    $('#kv-success-1 ul').append(out);
    //    $('#kv-success-1').fadeIn('slow');
    //});
    $("#txtIdentificacao").val(document.getElementById("hfIdDna").value);

    if ($("#hfIdOcorrencia").val() != "") {
        $("#IdRedirectGSS").text("Ocorrência: " + $("#hfIdOcorrencia").val());
        FindDNA();
    }
});

function redirectGSS() {
    window.location.replace("http://sistemas.cobrasin.com.br:9091/GSS/Talao/Atribuidos/Servico.aspx?IdTalao=" + $("#hfIdOcorrencia").val());
}

$(function () {

    //$('.datepicker').datepicker({
    //    dateFormat: "dd/mm/yyyy",
    //    language: 'pt-BR'
    //});
    loadResourcesLocales();

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/GetDepartament',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lstDepartamento = [];
                var i = 0;
                while (data.d[i]) {
                    var lst = data.d[i].split('@');
                    var item = {};
                    item.id = lst[0];
                    item.nome = lst[1];
                    lstDepartamento.push(item);
                    i++;
                }

                LoadDepartamentTreeMenu(lstDepartamento);
            }
        },
        error: function (data) {
        }
    });
})

var globalResources;
function loadResourcesLocales() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: 'DefaultBeta.aspx/requestResource',
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

function LoadDepartamentTreeMenu(Departamento) {
    $.each(Departamento, function (index, Departamento) {

        $.ajax({
            type: 'POST',
            url: '../../../../WebServicess/Materiais.asmx/GetSub',
            dataType: 'json',
            data: "{'idDepartamento':'" + Departamento.id + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d != "") {
                    var lstSub = [];
                    var i = 0;
                    while (data.d[i]) {
                        var lst = data.d[i].split('@');
                        var item = {};
                        item.idsub = lst[0];
                        item.Sub = lst[1];
                        lstSub.push(item);
                        i++;
                    }
                    var newRow = $("<li style='border-bottom: 1px solid #d8d8d8;margin-bottom:20px;'>").append("<a href='#' style='height:30px;cursor:pointer;color:#999999;' data-id='" + Departamento.id + "'>" + Departamento.nome + "</a>");
                    var cols = $("<ul id=" + Departamento.id + " class='nav nav-list tree'>");
                    newRow.append(cols);
                    $("#treeviewManutencao").append(newRow);

                    LoadSubTreeMenu(lstSub, Departamento.id);

                }
                else {
                    var newRow = $("<li style='border-bottom: 1px solid #d8d8d8; margin-bottom:20px;'>").append("<a href='#' style='height:30px; cursor:pointer;color:#999999;' data-id='" + Departamento.id + "'>" + Departamento.nome + "</a>");
                    var cols = $("<ul id=" + Departamento.id + " class='nav nav-list tree'>");
                    newRow.append(cols);
                    $("#treeviewManutencao").append(newRow);
                }
            },
            error: function (data) {
            }
        });
    });
}

function LoadSubTreeMenu(subdivisao, idDep, subMestre) {

    $.each(subdivisao, function (index, subdivisao) {
        if (subMestre != undefined) {
            var newRow = $("<li style='margin-left:10px;'>").append("<a href='#' style='cursor:pointer;' onclick='SubdivisaoClick(this)' data-id='" + subdivisao.idsub + "'>" + subdivisao.Sub + "</a>");
            var cols = $("<ul id=" + subdivisao.idsub + " class='nav nav-list tree'>");
            newRow.append(cols);
            $("#" + subMestre).append(newRow);
        }
        else {
            var newRow = $("<li style='margin-left:15px;'>").append("<a href='#' style='height:30px;cursor:pointer;color:#999999;' onclick='SubdivisaoClick(this)' data-id='" + subdivisao.idsub + "'>" + subdivisao.Sub + "</a>");
            var cols = $("<ul id=" + subdivisao.idsub + " class='nav nav-list tree'>");
            newRow.append(cols);
            $("#" + idDep).append(newRow);
        }

        var subdivisaoMestre = subdivisao.idsub;
        $.ajax({
            type: 'POST',
            url: '../../WebServices/Materiais.asmx/getSubChildren',
            dataType: 'json',
            data: "{'idSubdivisao':'" + subdivisaoMestre + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d != "") {
                    var lstSubdivisao = [];
                    var i = 0;
                    while (data.d[i]) {
                        var lst = data.d[i].split('@');
                        var item = {};
                        item.idsub = lst[0];
                        item.Sub = lst[1];
                        lstSubdivisao.push(item);
                        i++;
                    }
                    LoadSubTreeMenu(lstSubdivisao, subdivisao.idsub, subdivisaoMestre);
                }
            },
            error: function (data) {
            }
        });

    });
}

function GetEndereco() {

    var str = "" + $("#txtIdentificacao").val();
    var pad = "0000"
    var id = pad.substring(0, pad.length - str.length) + str
    $("#hfIdDna").val(id);
    $("#hfIdSub").val("");
    var dataDNA = [];
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getIdDNA',
        dataType: 'json',
        data: "{'idPrefeitura': '" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':''}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var qtd = 1;
            var DNA = data.d;
            $.each(DNA, function (index, DNA) {
                dataDNA.push({
                    id: DNA.idSub,
                    nome: DNA.Subdivisao,
                    end: DNA.Endereco
                });
            });

            $("#txtCruzamento").autocomplete({
                source: $.map(dataDNA, function (item) {
                    return {
                        label: item.end,
                        val: item.id,
                        sub: item.nome
                    }
                }),
                select: function (e, i) {
                    $("#txtIdentificacao").val(i.item.sub);
                    $("#txtCruzamento").val(i.item.label);
                    $("#hfIdDna").val(i.item.sub);
                    $("#hfIdSub").val(i.item.val);
                    $("#hfEndereco").val(i.item.label);
                    FindDNA();
                },
                minLength: 1
            });
        },
        error: function (data) {
        }
    });
}

function GetIdDNA() {

    var str = "" + $("#txtIdentificacao").val();
    var pad = "0000"
    var id = pad.substring(0, pad.length - str.length) + str
    $("#hfIdDna").val(id);
    $("#hfIdSub").val("");
    var dataDNA = [];
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getIdDNA',
        dataType: 'json',
        data: "{'idPrefeitura': '" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':''}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            var qtd = 1;
            var DNA = data.d;
            $.each(DNA, function (index, DNA) {
                dataDNA.push({
                    id: DNA.idSub,
                    nome: DNA.Subdivisao,
                    end: DNA.Endereco
                });
            });

            $("#txtIdentificacao").autocomplete({
                source: $.map(dataDNA, function (item) {
                    return {
                        label: item.nome,
                        val: item.id,
                        end: item.end
                    }
                }),
                select: function (e, i) {
                    $("#txtIdentificacao").val(i.item.label);
                    $("#txtCruzamento").val(i.item.end);
                    $("#hfIdDna").val(i.item.label);
                    $("#hfIdSub").val(i.item.val);
                    $("#hfEndereco").val(i.item.end);

                    FindDNA();
                },

                minLength: 1
            });
        },
        error: function (data) {
        }
    });
}

function GetIdDNAMestre() {

    var id = $("#txtIdLocalControladorMestre").val();
    $("#txtIdLocalControladorMestre").val(id);
    var dataDNA = [];

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getIdDNA',
        dataType: 'json',
        data: "{'idPrefeitura': '" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':''}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            var qtd = 1;
            var DNA = data.d;
            $.each(DNA, function (index, DNA) {
                dataDNA.push({
                    id: DNA.idSub,
                    nome: DNA.Subdivisao,
                    end: DNA.Endereco
                });
            });

            $("#txtIdLocalControladorMestre").autocomplete({
                source: $.map(dataDNA, function (item) {
                    return {
                        label: item.nome,
                        val: item.id,
                        end: item.end
                    }
                }),
                select: function (e, i) {
                    $("#txtIdLocalControladorMestre").val(i.item.label);
                },
                minLength: 1
            });
        },
        error: function (data) {
        }
    });
}

function GetIdDNAMov() {

    var id = $("#txtIdLocal1").val();
    $("#txtIdLocal1").val(id);
    var dataDNA = [];
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getIdDNA',
        dataType: 'json',
        data: "{'idPrefeitura': '" + document.getElementById("hfIdPrefeitura").value + "','Subdivisao':''}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var qtd = 1;
            var DNA = data.d;
            $.each(DNA, function (index, DNA) {
                dataDNA.push({
                    id: DNA.idSub,
                    nome: DNA.Subdivisao,
                    end: DNA.Endereco
                });
            });

            $("#txtIdLocal1").autocomplete({
                source: $.map(dataDNA, function (item) {
                    return {
                        label: item.nome,
                        val: item.id,
                        end: item.end
                    }
                }),
                select: function (e, i) {
                    $("#txtIdLocal1").val(i.item.label);
                },
                minLength: 1
            });
        },
        error: function (data) {
        }
    });
}


//---------------------------------------------------------------------------------------


function movimentarManutencao(valor) {
    document.getElementById("lblProdManutencao").innerHTML = valor.title;
    idPatrimonio = $(valor).data("id");
    $("#modalManutencao").modal("show");
}

function modalMovimentacao(value) {
    //document.getElementById("lblprodManutencao").innerHTML = value.title;
    //idPatrimonio = $(value).data("id");
    $("#modalMovimentacao").modal("show");

    var Produto = valor.title.toString();
    document.getElementById("lblProduto1").innerHTML = Produto;
    if (Produto == "Controlador")
        $("#divSleFormaOp").css("display", "");
    else
        $("#divSleFormaOp").css("display", "none");
}

//function modalMovimentacao(valor) {
//    var Produto = valor.title.toString();
//    document.getElementById("lblProd").innerHTML = Produto;
//    if (Produto == "Controlador")
//        $("#pController").css("display", "");
//    else
//        $("#pController").css("display", "none");
//}

function modalAddEpc(value) {
    //document.getElementById("lblprodManutencao").innerHTML = value.title;
    //idPatrimonio = $(value).data("id");
    $("#modalAddEpc").modal("show");
}

//function tblAlmoxarifado() {

//    $("#divAlmoxarifado").removeClass("dNone");
//    $("#divAlmoxarifado").addClass("dBlock");

//    $("#divSubdivisaoManutencao").removeClass("dBlock");
//    $("#divSubdivisaoManutencao").addClass("dNone");
//}

//function tblManutencao() {

//    $("#divSubdivisaoManutencao").removeClass("dNone");
//    $("#divSubdivisaoManutencao").addClass("dBlock");

//    $("#divAlmoxarifado").removeClass("dBlock");
//    $("#divAlmoxarifado").addClass("dNone");
//}

//function ocultarTabelas() {

//    if (document.getElementById("divAlmoxarifado").display == block) {

//        $("#divAlmoxarifado").removeClass("dBlock");
//        $("#divAlmoxarifado").addClass("dNone");
//    }

//    if ($("#divAlmoxarifado").css("display") == "block") {

//        $("#divAlmoxarifado").removeClass("dBlock");
//        $("#divAlmoxarifado").addClass("dNone");
//    }
//}

//--------------------------------------------------------------------------------------

var idDepartamento = "";
var idPatrimonio = "";
var idProduto = "";
var idSubdivisaoMov = "";
var SubdivisaoMov = "";
var idPatrimonioCtrl = "";

function FindDNA() {

    document.getElementById("sleFormaOperacionalCadastro").disabled = false;

    $("#divBtnVoltarDadosControlador").css("display", "none");
    $("#divCadastrado_DadosControlador").css("display", "none");

    $("#divFormaOperacionalCadastro").css("display", "none");
    $("#txtIdentificacao").val(document.getElementById("hfIdDna").value);

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getSubdivisao',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "'," +
            "'idLocal':'" + document.getElementById("hfIdDna").value + "'," +
            "'Endereco':'" + document.getElementById("hfEndereco").value + "'}",
        contentType: "application/json; charset=utf-8",
        async: true,
        success: function (data) {

            if (data.d != "") {
                var getSub = data.d;
                document.getElementById("hfIdSub").value = getSub[0].idSub;

                //$("#txtDtDeflagracao").val(getSub[0].DtDeflagracao);
                //$("#txtRespVistoria").val(getSub[0].ResponsavelVistoria);
                //$("#txtRegistroCET").val(getSub[0].RegistroCET);
                //$("#txtRegistroCREA").val(getSub[0].RegistroCREA);
                //$("#txtEngResponsavel").val(getSub[0].EngResponsavel);

                if (getSub[0].Endereco != null || getSub[0].Endereco != undefined) {
                    document.getElementById("hfEndereco").value = getSub[0].Endereco;
                    $("#txtCruzamento").val(getSub[0].Endereco);
                }

                idDepartamento = getSub[0].idDepartamento;
                $("#hfIdDepartamento").val(idDepartamento);
                if (getSub[0].Subdivisao != null || getSub[0].Subdivisao != undefined) {
                    document.getElementById("hfIdDna").value = getSub[0].Subdivisao;
                    $("#txtIdentificacao").val(getSub[0].Subdivisao);
                }

                $("#divMateriais").css("display", "block");
            }
            else {
                alert("Esse cruzamento não foi encontrado!");
                $("#divMateriais").css("display", "none");
            }

            //CONTROLADOR
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findControllers',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idLocal':'" + document.getElementById("hfIdDna").value + "', " +
                    " 'Endereco':'" + document.getElementById("hfEndereco").value + "', " +
                    " 'idDepartamento':'" + idDepartamento + "', " +
                    " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {
                        document.getElementById("btnDetalhesDadosControlador").innerHTML = "Detalhes";
                        $("#divBtnVoltarDadosControlador").css("display", "none");
                        $("#divBotoesImplantacao_Movimentacao").css("display", "none");
                        $("#divtblSelControladorDesejado").css("display", "none");

                        var lst = data.d[0].split('@');
                        $("#btnDetalhesDadosControlador").data("IdPatrimonio", lst[1]);
                        $("#btnManutencaoDadosControlador").data("id", lst[1]);
                        idPatrimonioCtrl = lst[1];
                        idPatrimonio = lst[1];
                        idDepartamento = lst[2];
                        var nmrSerie = lst[3];
                        $("#txtNumSerie").val(nmrSerie);
                        document.getElementById("lblNumPatrimonioCadastrado1").innerHTML = lst[4]; /*4 NumPatrimonio*/
                        document.getElementById("lblModeloCadastrado1").innerHTML = lst[5]; /*5 Modelo*/

                        if (lst[0] == "CONJUGADO") {
                            $("#divCadastrado_DadosControlador").css("display", "none");
                            $("#divDadosControlador_Cadastrado").css("display", "none");
                            //$("#pnlCtrlDados").css("display", "block");
                            $("#divIdLocalControladorMestreCadastrado").css("display", "none");
                            $("#divControladorConjugado").css("display", "block");
                            document.getElementById("lblMestreSelecionado").innerHTML = lst[1];
                            $("#lblModeloCtrl").html(lst[5]);
                            $("#lblModeloCtrl").value(lst[5]);

                            var subdivisao = lst[1];
                            var n = subdivisao.indexOf("-");
                            if (n > 0) {
                                document.getElementById(
                                    "txtIdLocalControladorMestre"
                                ).value = subdivisao.substring(0, n).trim();
                            }
                            else {
                                document.getElementById(
                                    "txtIdLocalControladorMestre"
                                ).value = subdivisao;
                            }

                            document.getElementById(
                                "lblFormaOpCadastrada1"
                            ).innerHTML = "CONJUGADO";
                            document.getElementById(
                                "btnDetalhesDadosControlador"
                            ).innerHTML = "Editar";
                            $("#tabControladoresConjugados").css("display", "none");
                            $("#tabPlacasControlador").css("display", "none");
                            $("#tabGprsControlador").css("display", "none");
                        }
                        else if (lst[0] == "MESTRE") {

                            $("#tabControladoresConjugados").css("display", "block");
                            $("#tabPlacasControlador").css("display", "block");
                            $("#tabGprsControlador").css("display", "block");
                            $("#divControladorConjugado").css("display", "none");
                            $("#divIdLocalControladorMestreCadastrado").css("display", "none");
                            $("#divDadosControlador_Cadastrado").css("display", "block");
                            $("#divBtn_Detalhes_e_Manutencao").css("display", "block");

                            $("#divCadastrado_DadosControlador").css("display", "none");
                            document.getElementById(
                                "lblFormaOpCadastrada1"
                            ).innerHTML = "MESTRE";

                            var i = 0;
                            $("#tabControladoresConjugados").css("display", "block");
                            $("#tfConjugados").css("display", "none");
                            $("#tbConjugados").empty();

                            while (data.d[i]) {

                                var lst = data.d[i].split('@');
                                var newRow = $("<tr>");
                                var cols = "";
                                if (lst[6] != undefined && lst[7] != undefined) {
                                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                        " color: #4CA2BF;'>" + lst[8] + "</td>";
                                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                        " color: #4CA2BF;'>" + lst[7] + "</td>";

                                    newRow.append(cols);
                                    $("#tbConjugados").append(newRow);
                                }
                                else {
                                    $("#tfConjugados").css("display", "block");
                                    $("#tbConjugados").empty();
                                }

                                i++
                            }
                        }
                        else {
                            $("#divDadosControlador_Cadastrado").css("display", "block");
                            $("#divBtn_Detalhes_e_Manutencao").css("display", "block");
                            $("#tabPlacasControlador").css("display", "block");
                            $("#tabGprsControlador").css("display", "block");

                            $("#divControladorConjugado").css("display", "none");
                            $("#tabControladoresConjugados").css("display", "none");
                            $("#divIdLocalControladorMestreCadastrado").css("display", "none");
                            $("#divCadastrado_DadosControlador").css("display", "none");

                            document.getElementById(
                                "lblFormaOpCadastrada1"
                            ).innerHTML = "ISOLADO";
                        }
                    }
                    else {
                        $("#divBotoesImplantacao_Movimentacao").css("display", "block");
                        $("#divIdLocalControladorMestreCadastrado").css("display", "none");
                        $("#divDadosControlador_Cadastrado").css("display", "none");
                        $("#divBtn_Detalhes_e_Manutencao").css("display", "none");
                        $("#divtblSelControladorDesejado").css("display", "none");

                        $("#tabControladoresConjugados").css("display", "none");
                        $("#tabPlacasControlador").css("display", "none");
                        $("#tabGprsControlador").css("display", "none");
                    }

                    //PLACAS CONTROLADOR
                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/findPlacaCtrl',
                        dataType: 'json',
                        data: "{'idDepartamento':'" + idDepartamento + "', " +
                            " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            if (data.d != "") {
                                var i = 0;
                                $("#tblPlacasControladores").css("display", "");
                                $("#tbPlacasControladores").empty();
                                while (data.d[i]) {

                                    var lst = data.d[i].split('@');
                                    var newRow = $("<tr>");
                                    var cols = "";
                                    cols += "<td style='padding-top: 14px;'>" + lst[0] + "</td>";
                                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                                    cols += "<td style='padding: 5px; width: 1px;'> " +
                                        " <button type='button' class='btn btn-icon btn-info' " +
                                        " onclick='SelectPlacaCtrl(this)' " +
                                        " data-idpatrimonioplaca='" + lst[4] + "'> " +
                                        " <i class='ft-edit-3'> " +
                                        " </i></button></td>";
                                    cols += "<td style='padding: 5px; width: 1px'> " +
                                        " <button type='button' class='btn btn-outline-secondary' " +
                                        " title='Placa' onclick='movimentarManutencao(this)' " +
                                        " data-id='" + lst[5] + "'>Manutenção</button></td>";

                                    newRow.append(cols);
                                    $("#tbPlacasControladores").append(newRow);
                                    i++
                                }

                                $("#btnNovaPlaca").css("display", "block");
                                $("#divNumPatrimonioPlacasControlador").css("display", "flex");
                                $("#divTblPlacasCadastradas").css("display", "");
                            }
                            else {
                                $("#divNumPatrimonioPlacasControlador").css("display", "none");
                                $("#divTblPlacasCadastradas").css("display", "none");
                                $("#tblPlacasControladores").css("display", "none");
                                $("#tbPlacasControladores").empty();

                                $("#divCadastrar_PlacasControlador").css("display", "none");
                                $("#divBtnVoltarPlacasControlador").css("display", "none");
                                $("#divTblPlacasUtilizar").css("display", "block");
                            }

                            $("#divTblPlacasUtilizar").css("display", "none");
                            $("#divCadastrar_PlacasControlador").css("display", "none");
                            //$("#btnNovaPlaca").css("display", "block");
                            //$("#divNumPatrimonioPlacasControlador").css("display","flex");
                            //$("#divTblPlacasCadastradas").css("display","block");
                        },
                        error: function (data) {
                        }
                    });

                    //GPRS CONTROLADOR
                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/findGprsCtrl',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                            " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            if (data.d != "") {
                                var lstGprs = data.d[0].split('@');
                                $("#btnDetalhesGPRS").data("id", lstGprs[0]);
                                $("#btnManutencaoGPRS").data("id", lstGprs[0]);

                                document.getElementById("txtDataGarantiaGPRS").value = lstGprs[1];
                                document.getElementById("txtDataInstalacaoGPRS").value = lstGprs[2];
                                document.getElementById("txtFabricanteGPRS").value = lstGprs[3];
                                $("#txtNumPatrimonioGPRS")[0].value = lstGprs[6];
                                $("#txtModeloGPRS")[0].value = lstGprs[4];
                                $("#txtNumLinhaGPRS")[0].value = lstGprs[5];

                                $("#lblModeloGPRS")[0].innerHTML = lstGprs[4];
                                $("#lblNumLinhaGPRS")[0].innerHTML = lstGprs[5];
                                $("#lblNumPatrimonioGPRS")[0].innerHTML = lstGprs[6];

                                document.getElementById("txtNumSerieGPRS").value = lstGprs[7];

                                $("#sleEstadoOperacionalGPRS").val(lstGprs[8]);
                                $("#sleOperadoraGPRS").val(lstGprs[9]);
                                //$("#grpsCadastrado").css("display", "none");
                                $("#divAdd_NovoGPRS").css("display", "none");
                                $("#divSelGprsDesejado").css("display", "none");
                                $("#divCadastrar_GPRS").css("display", "none");
                                $("#grpsCadastrado").css("display", "block");
                                $("#divDetalhe_e_Manutencao_GprsControlador").css("display", "block");
                                $("#btnSalvarGPRS_Controlador").html("Salvar");
                            }
                            else {
                                $("#divAdd_NovoGPRS").css("display", "block");

                                $("#grpsCadastrado").css("display", "none");
                                $("#divDetalhe_e_Manutencao_GprsControlador").css("display", "none");
                                $("#divSelGprsDesejado").css("display", "none");
                                $("#divCadastrar_GPRS").css("display", "none");
                                $("#divSelGprsDesejado").css("display", "none");
                                $("#btnSalvarGPRS_Controlador").val("Salvar");
                            }
                        },
                        error: function (data) {
                        }
                    });
                },
                error: function (data) {
                }
            });

            //NOBREAK
            $.ajax({
                type: 'POST',
                url: 'WebService/Materiais.asmx/findNobreak',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        var lst = data.d[0].split('@');
                        idPatrimonio = lst[0];
                        $("#lnkManutencaoNbr").data("id", lst[0]);
                        $("#txtNbkAutonomia").val(lst[1]);
                        $("#txtNbkDataGarantia").val(lst[2]);
                        document.getElementById("lblFabNbr").innerHTML = lst[3];
                        $("#txtNbkFabricante").val(lst[3]);
                        $("#txtNbkDataInstal").val(lst[4]);
                        $("#txtNbkModelo").val(lst[5]);
                        document.getElementById("lblModeloNbr").innerHTML = lst[5];
                        $("#txtNbkNumPat").val(lst[6]);
                        document.getElementById("lblnmrPatNbr").innerHTML = lst[6];
                        $("#txtNbkPotencia").val(lst[7]);
                        $("#ddlNbkAtivo").val(lst[8]);
                        $("#ddlNbkFixacao").val(lst[9]);
                        $("#ddlNbkMonitoracao").val(lst[10]);
                        $("#pnlDetailsNbr").css("display", "block");
                        $("#adcNbrk").css("display", "none");
                        $("#pnlGrdAddNobreak").css("display", "none");
                        $("#pnlCadastroNobreak").css("display", "none");
                        $("#pnlAddNbk").css("display", "none");
                    }
                    else {
                        $("#adcNbrk").css("display", "block");
                        $("#pnlDetailsNbr").css("display", "none");
                        $("#pnlGrdAddNobreak").css("display", "none");
                        $("#pnlCadastroNobreak").css("display", "none");
                        $("#pnlAddNbk").css("display", "none");
                    }
                    $("#btnEditNobreak").val("Salvar");

                    $.ajax({
                        type: 'POST',
                        url: 'WebService/Materiais.asmx/findGprsNbrk',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','idSub':'" + document.getElementById("hfIdSub").value + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d != "") {
                                var lst = data.d[0].split('@');
                                idPatrimonio = lst[0];
                                $("#lnkGprsMovimentar").data("id", lst[0]);
                                $("#txtFabricanteGprsNbk").val(lst[1]);
                                document.getElementById("lblFabricanteGprs").innerHTML = lst[1];
                                $("#txtNmrPatGprsNbk").val(lst[2]);
                                document.getElementById("lblnrpatGprs").innerHTML = lst[2];
                                $("#txtNmrLinhaGprsNbk").val(lst[3]);
                                $("#txtDtGarantiaGprsNbk").val(lst[4]);
                                $("#txtDtInstalGprsNbk").val(lst[5]);
                                $("#txtModeloGprsNbk").val(lst[6]);
                                document.getElementById("lblModelGprs").innerHTML = lst[6];
                                $("#ddlOperadoraGprsNbk").val(lst[7]);
                                $("#ddlEstadoOperacionalGprsNbk").val(lst[8]);
                                $("#adcGprs").css("display", "none");
                                $("#pnlAddGprsNbk").css("display", "none");
                                $("#pnlDetailsGprs").css("display", "block");
                                $("#pnlGrdAdcGprsNbk").css("display", "none");
                                $("#pnlDadosGPRSnbk").css("display", "none");

                            }
                            else {
                                $("#adcGprs").css("display", "block");
                                $("#pnlAddGprsNbk").css("display", "none");
                                $("#pnlDetailsGprs").css("display", "none");
                                $("#pnlGrdAdcGprsNbk").css("display", "none");
                                $("#pnlDadosGPRSnbk").css("display", "none");

                            }
                            $("#SalvarGprsNbk").val("Salvar");
                        },
                        error: function (data) {
                        }
                    });
                },
                error: function (data) {
                }
            });

            //COLUNA
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findColuna',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {
                        //$("#tbladcNewcols").css("display", "block");
                        $("#divBtn_AddColunas").css("display", "none");
                        $("#divBtnVoltarColuna").css("display", "none");
                        $("#divTblSelColunaDesejada").css("display", "none");
                        $("#divCadastroColunas").css("display", "none");
                        $("#div_Pesquisar_NumPatrimonio").css("display", "block");
                        $("#divTblColunasCadastradas").css("display", "block");
                        $("#btnSalvarColuna").val("Salvar");
                        $("#tblListaColunasCadastradas").css("display", "block");
                        $("#tbListaColunasCadastradas").empty();

                        var i = 0;
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[1] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[2] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[3] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[4] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'> <a style='cursor:pointer;color:#0174DF;' onclick='selColuna(this)' " +
                                " data-id='" + lst[0] + "'>Selecionar</a></td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'> <a style='cursor:pointer;color:#0174DF;' " +
                                " title='Coluna' onclick='movimentarManutencao(this)' " +
                                " data-id='" + lst[0] + "'>Manutenção</a></td>";

                            newRow.append(cols);
                            $("#tblListaColunasCadastradas").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblListaColunasCadastradas").css("display", "none");
                        //$("#tbladcNewcols").css("display", "block");
                        $("#divBtn_AddColunas").css("display", "none");
                        $("#divTblSelColunaDesejada").css("display", "none");
                        $("#divCadastroColunas").css("display", "none");
                        $("#div_Pesquisar_NumPatrimonio").css("display", "none");
                        $("#divTblColunasCadastradas").css("display", "none");
                        $("#btnSalvarColuna").val("Salvar");
                    }
                },
                error: function (data) {
                }
            });

            //CABO
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findCabo',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {
                        //$("#tblAdcCabo").css("display", "block");
                        $("#divBtn_AddCabos").css("display", "none");
                        $("#divTblSelCaboDesejado").css("display", "none");
                        $("#divBtnVoltarCabos").css("display", "none");
                        $("#divCadastroCabos").css("display", "none");
                        $("#divPesq_Cabos_Cadastrados").css("display", "block");
                        $("#divTblCabosCadastrados").css("display", "block");

                        $("#btnSalvarCabo").val("Salvar");
                        var i = 0;
                        $("#tblListaCabosCadastrados").css("display", "block");
                        $("#tbListaCabosCadastrados").empty();
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');

                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[1] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[2] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[3] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[4] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[5] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;' > <a style='cursor:pointer;color:#0174DF;' " +
                                " onclick='selCaboCadastrado(this)' data-id='" + lst[0] + "'>Selecionar</a></td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;' > <a style='cursor:pointer;color:#0174DF;' title='Cabo' " +
                                " onclick='movimentarManutencao(this)' data-id='" + lst[0] + "'>Manutenção</a></td>";

                            newRow.append(cols);
                            $("#tblListaCabosCadastrados").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblListaCabosCadastrados").css("display", "none");
                        //$("#tblAdcCabo").css("display", "block");
                        $("#divBtn_AddCabos").css("display", "none");
                        $("#pnlGrdAdcCabo").css("display", "none");
                        $("#divCadastroCabos").css("display", "none");
                        $("#divPesq_Cabos_Cadastrados").css("display", "none");
                        $("#divTblCabosCadastrados").css("display", "block");
                        $("#btnSalvarCabo").val("Salvar");
                    }
                },
                error: function (data) {
                }
            });

            //GRUPO FOCAL
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findGrupoFocal',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        //$("#tblAdcGf").css("display", "block");
                        $("#divBtn_AddGrupoFocal").css("display", "none");
                        $("#divTbl_SelGrupoFocalDesejado").css("display", "none");
                        $("#divCadastro_GrupoFocal").css("display", "none");
                        $("#divPesq_GrupoFocalCadastrado").css("display", "block");
                        $("#divTbl_GruposFocaisCadastrados").css("display", "block");
                        $("#btnSalvarGrupoFocal").val("Salvar");
                        $("#tblGruposFocaisCadastrados").css("display", "block");
                        $("#tbGruposFocaisCadastrados").empty();

                        var i = 0;
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');
                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[1] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[2] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[3] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[4] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[5] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;' > <a style='cursor:pointer;color:#0174DF;' " +
                                " onclick='selGrupoFocal(this)' data-id='" + lst[0] + "'>Selecionar</a></td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;' > <a style='cursor:pointer;color:#0174DF;' title='Grupo Focal' " +
                                " onclick='movimentarManutencao(this)' data-id='" + lst[0] + "'>Manutenção</a></td>";

                            newRow.append(cols);
                            $("#tblGruposFocaisCadastrados").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblGruposFocaisCadastrados").css("display", "none");
                        //$("#tblAdcGf").css("display", "block");
                        $("#divBtn_AddGrupoFocal").css("display", "none");
                        $("#divTbl_SelGrupoFocalDesejado").css("display", "none");
                        $("#divCadastro_GrupoFocal").css("display", "none");
                        $("#divPesq_GrupoFocalCadastrado").css("display", "none");
                        $("#divTbl_GruposFocaisCadastrados").css("display", "none");
                        $("#btnSalvarGrupoFocal").val("Salvar");
                    }
                },
                error: function (data) {
                }
            });

            //SISTEMA ILUMINAÇÃO
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findSistemaIlu',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        //$("#tblAdcIlu").css("display", "block");
                        $("#divAdd_SistemaIluminacao").css("display", "none");
                        $("#divTbl_SelSistemaIluminacao").css("display", "none");
                        $("#divCadastro_SistemaIluminacao").css("display", "none");
                        $("#pnlIluminacao").css("display", "block");
                        $("#btnSalvarSistemaIluminacao").val("Salvar");
                        var i = 0;
                        $("#tblSistemasIlumicacaoCadastrados").css("display", "block");
                        $("#tbSistemasIlumicacaoCadastrados").empty();
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');

                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[1] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[2] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[3] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[4] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[5] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;' > <a style='cursor:pointer;color:#0174DF;' " +
                                " onclick='selSistemaIluminacao(this)' data-id='" + lst[0] + "'>Selecionar</a></td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;' > <a style='cursor:pointer;color:#0174DF;' title='Sistema de Iluminação' " +
                                " onclick='movimentarManutencao(this)' data-id='" + lst[0] + "'>Manutenção</a></td>";

                            newRow.append(cols);
                            $("#tblSistemasIlumicacaoCadastrados").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblSistemasIlumicacaoCadastrados").css("display", "none");
                        //$("#tblAdcIlu").css("display", "block");
                        $("#divAdd_SistemaIluminacao").css("display", "none");
                        $("#divTbl_SelSistemaIluminacao").css("display", "none");
                        $("#divCadastro_SistemaIluminacao").css("display", "none");
                        $("#divPesq_NumPatrimonio_S_Iluminacao").css("display", "none");
                        $("#divTbl_SistemaIluminacaoCadastrado").css("display", "none");
                        $("#btnSalvarSistemaIluminacao").val("Salvar");
                    }
                },
                error: function (data) {
                }
            });

            //ACESSÓRIOS
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findAcessorio',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        //$("#tblNewAcess").css("display", "block");
                        $("#divBtn_AddAcessorios").css("display", "none");
                        $("#divTbl_AcessorioDesejado").css("display", "none");
                        $("#divCadastro_Acessorio").css("display", "none");
                        $("#divPesq_NumPatrimonioAcessorios").css("display", "block");
                        $("#divTbl_AcessoriosCadastrados").css("display", "block");
                        $("#btnSalvarAcessorio").val("Salvar");
                        $("#tblAcessoriosCadastrados").css("display", "block");
                        $("#tbAcessoriosCadastrados").empty();

                        var i = 0;
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');
                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[1] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[2] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[3] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'>" + lst[4] + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;' > <a style='cursor:pointer;color:#0174DF;' onclick='selAcessorio(this)' " +
                                " data-id='" + lst[0] + "'>Selecionar</a></td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF;'> <a style='cursor:pointer;color:#0174DF;' title='Acessório' " +
                                " onclick='movimentarManutencao(this)' data-id='" + lst[0] + "'>Manutenção</a></td>";

                            newRow.append(cols);
                            $("#tblAcessoriosCadastrados").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblAcessoriosCadastrados").css("display", "none");
                        //$("#tblNewAcess").css("display", "block");
                        $("#divBtn_AddAcessorios").css("display", "none");
                        $("#divTbl_AcessorioDesejado").css("display", "none");
                        $("#divCadastro_Acessorio").css("display", "none");
                        $("#divPesq_NumPatrimonioAcessorios").css("display", "block");
                        $("#divTbl_AcessoriosCadastrados").css("display", "block");
                        $("#btnSalvarAcessorio").val("Salvar");
                    }
                },
                error: function (data) {
                }
            });

            $("#btnAddNovaEtiqueta").css("display", "block");
            //$("#imgPesquisar").css("display", "block");
            //document.getElementById("btnSaveTag").value = "Confirmar";
            //document.getElementById("btnSaveTag").style.visibility = "hidden";
            //document.getElementById("btnVoltar").style.visibility = "hidden";
            //var EPC = document.getElementById("txtEpc").value;

            //ETIQUETAS
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findTag',
                dataType: 'json',
                data: "{'EPC':'" + EPC + "','idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idsubdivisao':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {
                        $("#tblEtiquetasCadastradas").css("display", "block");
                        $("#tbEtiquetasCadastradas").css("display", "block");
                        //$("#tfTag").css("display", "none");
                        $("#tbEtiquetasCadastradas").empty();

                        var i = 0;
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');
                            var Id = lst[0];
                            var EPC = lst[1];

                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF; width:150px;'>" + EPC + "</td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF; width:150px;'> <a style='cursor:pointer;color:#0174DF;' " +
                                " onclick='modalAddEpc()' data-id='" + Id + "' data-epc='" + EPC + "'>Editar</a></td>";
                            cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                " color: #4CA2BF; width:150px;'> <a style='cursor:pointer;color:#0174DF;' " +
                                " onclick='excluirEPC(this)' data-id='" + Id + "'>Excluir</a></td>";

                            newRow.append(cols);
                            $("#tblEtiquetasCadastradas").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblEtiquetasCadastradas").css("display", "block");
                        $("#thEtiquetasCadastradas").css("display", "block");
                        //$("#tfTag").css("display", "block");
                        $("#tbEtiquetasCadastradas").css("display", "none");
                        $("#tbEtiquetasCadastradas").empty();
                    }

                    document.getElementById("txtEpc").value = "";
                    //document.getElementById("btnSaveTag").value = "Confirmar";
                },
                error: function (data) {
                }
            });

            CarregarListaDatasImagem();
            CarregarListaProjeto();
            CarregarListaArquivo();

            /*$.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/GetUploadImages_Patrimonio',
                dataType: 'json',
                data: "{'idLocal':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var i = 0;
                    $("#tbImagemPatrimonio_Cruzamento").empty();
                    if (data.d.length == 0) {
                        var newRow = $("<tr>");
                        var cols = "<td>Nenhuma imagem adicionada!</td>";
                        cols += "</td>";
                        newRow.append(cols);
                        $("#tbImagemPatrimonio_Cruzamento").append(newRow);
                    }
                    var newRow = $("<tr>");
                    var cols = "<td>";
                    while (data.d[i]) {

                        var div = "";
                        cols += "<div class=\"galeria\">";
                        cols += "<a class=\"example-image-link\" style=\"display: block; max-width: 100%;height: auto;\" onclick='divGallery(this)' data-toggle='modal' data-target='#modalGallery' data-lightbox=\"example-set\" data-title=\"" + data.d[i].NomeArquivo + "\">";
                        cols += "<img src=\"../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" alt=\"" + data.d[i].NomeArquivo + "\" width=\"300\" height=\"200\"></a>";

                      //  cols += "<div class=\"desc\"><a style=\"width:100%\" class=\"btn btn-success\" target=\"_blank\"  href=\"../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" download id=\"download\"><span class=\"glyphicon glyphicon-download-alt\" style=\"padding-right: 4px;\"></span>Baixar</a></div>";
                        cols += "</div>";
                        i++;
                    }
                    cols += "</td>";
                    newRow.append(cols);
                    $("#tbImagemPatrimonio_Cruzamento").append(newRow);
                },
                error: function (data) { params = data; }
            });*/

            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/getMotivo',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        var i = 0;
                        $("#sleMotivoManutencao1").empty();
                        $("#sleMotivoManutencao1").append($("<option></option>").val(0).html("Selecione"));
                        while (data.d[i]) {
                            var lst = data.d[i].split('@');
                            var Motivo = lst[0];
                            var id = lst[1];
                            $("#sleMotivoManutencao1").append($("<option></option>").val(id).html(Motivo));
                            i++;
                        }
                    }
                },
                error: function (data) {
                }
            });

            Clear();
        },
        error: function (data) {
        }
    });
}

function SalvarDetalhesDNA() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SalvarDetalhesDNA',
        dataType: 'json',
        data: "{'idSub':'" + document.getElementById("hfIdSub").value + "','EngResponsavel':'" + $("#txtEngResponsavel").val() + "','DtDeflagracao':'" + $("#txtDtDeflagracao").val() + "','RegistroCREA':'" + $("#txtRegistroCREA").val() + "','RegistroCET':'" + $("#txtRegistroCET").val() + "','ResponsavelVistoria':'" + $("#txtRespVistoria").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            alert("Salvo com sucesso!");
        },
        error: function (data) {
        }
    })
}

var TipoUpload = "";
function btnAdicionarImagem_Click() {
    if (document.getElementById("btnAdicionarImagem").innerHTML == "Adicionar Imagem") {
        document.getElementById("btnAdicionarImagem").innerHTML = "Voltar";
        TipoUpload = "Imagem";
    } else {
        document.getElementById("btnAdicionarImagem").innerHTML = "Adicionar Imagem";
    }
    $(".fileinput-remove-button").click();
    $("#divImagemLocal_Upload").slideToggle();
    $("#divImagemLocal").slideToggle();

}

function CarregarListaDatasImagem() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/CarregarListaDatasImagem',
        dataType: 'json',
        data: "{'idLocal':'" + document.getElementById("hfIdSub").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var i = 0;
            $("#ulDataImagem").empty();

            var newli = $("<li role=\"presentation\">");
            $("#tbImagem_Cruzamento").empty();
            if (data.d.length == 0) {
                var newRow = $("<tr>");
                var cols = "<td>Nenhuma imagem encontrada para esse cruzamento!</td>";
                cols += "</td>";
                newRow.append(cols);
                $("#tbImagem_Cruzamento").append(newRow);


            }
            while (data.d[i]) {

                if (i == 0) {
                    newli = $("<li role=\"presentation\" class=\"active\">");
                    CarregarListaImagem(data.d[i], this);
                }
                else {
                    newli = $("<li role=\"presentation\">");
                }
                var a = "<a style=\"cursor:pointer;\" onclick=\"CarregarListaImagem('" + data.d[i] + "',this)\">" + data.d[i] + "</a>";
                newli.append(a);
                $("#ulDataImagem").append(newli);
                i++;
            }


        },
        error: function (data) { params = data; }
    });
}

var DataSelecionadaImagem;
function CarregarListaImagem(Data, li) {
    DataSelecionadaImagem = Data;
    $("#ulDataImagem > li").each(function (i, e) {
        $(e).removeClass("active");
    });

    $(li.parentNode).removeClass("active");
    $(li.parentNode).addClass("active");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/GetUploadImages',
        dataType: 'json',
        data: "{'idLocal':'" + document.getElementById("hfIdSub").value + "','Data':'" + Data + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var i = 0;
            $("#tbImagem_Cruzamento").empty();
            if (data.d.length == 0) {
                var newRow = $("<tr>");
                var cols = "<td>Nenhuma imagem encontrada!</td>";
                cols += "</td>";
                newRow.append(cols);
                $("#tbImagem_Cruzamento").append(newRow);
            }
            var newRow = $("<tr>");
            var cols = "<td>";
            while (data.d[i]) {

                var div = "";
                cols += "<div style=\" float: left;width: 300px;padding:4px;\">";

                cols += "<div class=\"image-gallery-v2 margin-b-10\">";
                cols += "<img class=\"img-responsive\" src=\"../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" alt=\"\">";
                cols += "<div style=\"width: 292px;background-color: #e4e4e4;height: 24px;bottom: 0px;z-index: 99999;position: absolute;padding-top: 3px;/* border: 1px solid darkgrey; */\"><span>" + data.d[i].Hora + "</span></div>";
                cols += "<div class=\"image-gallery-v2-overlay\">";
                cols += "<div class=\"image-gallery-v2-overlay-content\">";
                cols += "    <div class=\"theme-icons-wrap\">";

                cols += "<div class=\"btn-group\">";
                cols += "<a class=\"btn btn-success\"  data-tooltip=\"tooltip\" title=\"Baixar\" target=\"_blank\"  href=\"../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" download id=\"download\"><span class=\"glyphicon glyphicon-download-alt\"></span></a>";
                cols += " <a class=\"btn btn-primary\" data-tooltip=\"tooltip\" title=\"Expandir\" class=\"example-image-link\" href=\"../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" data-toggle='modal' data-target='#modalGallery' data-lightbox=\"example-set\" data-title=\"" + data.d[i].NomeArquivo + "\"><img  style=\"display:none;\" class=\"img-responsive\" src=\"../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" alt=\"\"><span class=\"glyphicon glyphicon-fullscreen\"></span></a>";
                cols += '<div class="btn-group dropup"><button type="button" data-tooltip=\"tooltip\" title=\"Apagar\" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">';
                cols += "   <span class=\"glyphicon glyphicon-remove-circle\"></span></button><ul class=\"dropdown-menu dropdown-menu-right\">";
                cols += "   <li><a style=\"cursor:pointer;\" onclick=\"ExcluirImagem('" + data.d[i].Id + "','" + data.d[i].NomeArquivo + "')\">Apagar</a></li></ul></div>";
                cols += "</div>";

                cols += "    </div>";
                cols += " </div>";
                cols += "</div>";
                cols += "</div>";

                cols += "</div>";
                i++;
            }
            cols += "</td>";
            newRow.append(cols);
            $("#tbImagem_Cruzamento").append(newRow);
            $('[data-tooltip="tooltip"]').tooltip();
        },
        error: function (data) { params = data; }
    });
}

function FiltrarImagem() {
    var HoraInicio = document.getElementById("txtHoraInicioImagem").value;
    var HoraFinal = document.getElementById("txtHoraFinalImagem").value;

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/GetUploadImages_Hora',
        dataType: 'json',
        data: "{'idLocal':'" + document.getElementById("hfIdSub").value + "','Data':'" + DataSelecionadaImagem + "','HoraInicio':'" + HoraInicio + "','HoraFinal':'" + HoraFinal + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var i = 0;
            $("#tbImagem_Cruzamento").empty();
            if (data.d.length == 0) {
                var newRow = $("<tr>");
                var cols = "<td>Nenhuma imagem encontrada!</td>";
                cols += "</td>";
                newRow.append(cols);
                $("#tbImagem_Cruzamento").append(newRow);
            }
            var newRow = $("<tr>");
            var cols = "<td>";
            while (data.d[i]) {

                var div = "";
                cols += "<div style=\" float: left;width: 300px;padding:4px;\">";

                cols += "<div class=\"image-gallery-v2 margin-b-10\">";
                cols += "<img class=\"img-responsive\" src=\"../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" alt=\"\">";
                cols += "<div style=\"width: 292px;background-color: #e4e4e4;height: 24px;bottom: 0px;z-index: 99999;position: absolute;padding-top: 3px;/* border: 1px solid darkgrey; */\"><span>" + data.d[i].Hora + "</span></div>";
                cols += "<div class=\"image-gallery-v2-overlay\">";
                cols += "<div class=\"image-gallery-v2-overlay-content\">";
                cols += "    <div class=\"theme-icons-wrap\">";

                cols += "<div class=\"btn-group\">";
                cols += "<a class=\"btn btn-success\" target=\"_blank\"  href=\"../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" download id=\"download\"><span class=\"glyphicon glyphicon-download-alt\"></span></a>";
                cols += " <a class=\"btn btn-primary\" class=\"example-image-link\" href=\"../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" data-toggle='modal' data-target='#modalGallery' data-lightbox=\"example-set\" data-title=\"" + data.d[i].NomeArquivo + "\"><img  style=\"display:none;\" class=\"img-responsive\" src=\"../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" alt=\"\"><span class=\"glyphicon glyphicon-fullscreen\"></span></a>";
                cols += '<div class="btn-group dropup"><button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">';
                cols += "   <span class=\"glyphicon glyphicon-remove-circle\"></span></button><ul class=\"dropdown-menu dropdown-menu-right\">";
                cols += "   <li><a style=\"cursor:pointer;\" onclick=\"ExcluirImagem('" + data.d[i].Id + "','" + data.d[i].NomeArquivo + "')\">Excluir</a></li></ul></div>";
                cols += "</div>";

                cols += "    </div>";
                cols += " </div>";
                cols += "</div>";
                cols += "</div>";

                cols += "</div>";
                i++;
            }
            cols += "</td>";
            newRow.append(cols);
            $("#tbImagem_Cruzamento").append(newRow);
        },
        error: function (data) { params = data; }
    });
}

function ExcluirImagem(Id, NomeArquivo) {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ExcluirImagem',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: "{'IdArquivo':'" + Id + "','NomeArquivo':'" + NomeArquivo + "','IdDepartamento':'" + idDepartamento + "'}",
        success: function (data) {
            CarregarListaDatasImagem();
        }
        , error: function (xmlHttpRequest, status, err) {
        }
    });
}

function btnAdicionarProjeto_Click() {
    if (document.getElementById("btnAdicionarProjeto").innerHTML == "Adicionar Projeto") {
        document.getElementById("btnAdicionarProjeto").innerHTML = "Voltar";
        TipoUpload = "Projeto";
    } else {
        document.getElementById("btnAdicionarProjeto").innerHTML = "Adicionar Projeto";
    }
    $(".fileinput-remove-button").click();
    $("#divProjeto_Upload").slideToggle();
    $("#divListaProjeto").slideToggle();

}

function CarregarListaProjeto() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/GetUploadProjetos',
        dataType: 'json',
        data: "{'idLocal':'" + document.getElementById("hfIdSub").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var i = 0;
            $("#tbListaProjeto").empty();
            if (data.d.length == 0) {
                var newRow = $("<tr>");
                var cols = "<td colspan=\"4\">Nenhum projeto adicionada para esse cruzamento!</td>";
                cols += "</td>";
                newRow.append(cols);
                $("#tbListaProjeto").append(newRow);
            }

            while (data.d[i]) {
                var newRow = $("<tr>");
                var cols = "";
                cols += "<td style=\"line-height: 34px;white-space: -moz-pre-wrap !important;white-space: -webkit-pre-wrap;white-space: -pre-wrap; white-space: -o-pre-wrap;  white-space: pre-wrap;word-wrap: break-word;word-break: break-all;white-space: normal;\">" + data.d[i].NomeArquivo + "</td>";
                cols += "<td style=\"width: 1px;\"><button type=\"button\" class=\"btn btn-info\" onclick=\"VisualizarProjeto('" + data.d[i].IdDepartamento + "','" + data.d[i].NomeArquivo + "');\"><span class=\"glyphicon glyphicon-info-sign\" style=\"padding-right: 4px;\"></span>Visualizar</button></td>";
                cols += "<td style=\"width: 1px;\"><a class=\"btn btn-success\" target=\"_blank\" href=\"../ProjetoDepartamento/arqs/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" download=\"\" id=\"download\"><span class=\"glyphicon glyphicon-download-alt\" style=\"padding-right: 4px;\"></span>Baixar</a></td>";
                cols += "<td style=\"width: 1px;\">";
                cols += "<div class=\"btn-group\">";
                cols += "<button type=\"button\" class=\"btn btn-danger dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\"><span class=\"glyphicon glyphicon-remove-circle\" style=\"padding-right: 4px;\"></span>Excluir <span class=\"caret\"></span></button>";
                cols += "<ul class=\"dropdown-menu\"><li><a href=\"#\" onclick=\"ExcluirProjeto('" + data.d[i].Id + "','" + data.d[i].NomeArquivo + "')\">SIM</a></li></ul></div></td>";

                newRow.append(cols);
                $("#tbListaProjeto").append(newRow);
                i++;
            }
        },
        error: function (data) { params = data; }
    });
}

function ExcluirProjeto(Id, NomeArquivo) {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ExcluirProjeto',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: "{'IdArquivo':'" + Id + "','NomeArquivo':'" + NomeArquivo + "','IdDepartamento':'" + idDepartamento + "'}",
        success: function (data) {
            CarregarListaProjeto();
        }
        , error: function (xmlHttpRequest, status, err) {
        }
    });
}

function VisualizarProjeto(IdDepartamento, NomeArquivo) {
    window.open('../ProjetoDepartamento/arqs/' + IdDepartamento + "/" + NomeArquivo);
    //$("#modalProjeto").modal("show");
    //document.getElementById("object_Projeto").setAttribute('data', '../ProjetoDepartamento/arqs/' + IdDepartamento + "/" + NomeArquivo);
    //document.getElementById("embed_Projeto").src = "../ProjetoDepartamento/arqs/" + IdDepartamento + "/" + NomeArquivo;
}

function btnAdicionarArquivos_Click() {
    if (document.getElementById("btnAdicionarArquivos").innerHTML == "Adicionar Arquivo") {
        document.getElementById("btnAdicionarArquivos").innerHTML = "Voltar";
        TipoUpload = "Arquivo";
    } else {
        document.getElementById("btnAdicionarArquivos").innerHTML = "Adicionar Arquivo";
    }
    $(".fileinput-remove-button").click();
    $("#divArquivo_Upload").slideToggle();
    $("#divListaArquivo").slideToggle();
}

function CarregarListaArquivo() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/GetUploadArquivos',
        dataType: 'json',
        data: "{'idLocal':'" + document.getElementById("hfIdSub").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var i = 0;
            $("#tbListaArquivo").empty();
            if (data.d.length == 0) {
                var newRow = $("<tr>");
                var cols = "<td colspan=\"4\">Nenhum arquivo adicionado para esse cruzamento!</td>";
                cols += "</td>";
                newRow.append(cols);
                $("#tbListaArquivo").append(newRow);
            }

            while (data.d[i]) {
                var newRow = $("<tr>");
                var cols = "";
                cols += "<td style=\"line-height: 34px;white-space: -moz-pre-wrap !important;white-space: -webkit-pre-wrap;white-space: -pre-wrap; white-space: -o-pre-wrap;  white-space: pre-wrap;word-wrap: break-word;word-break: break-all;white-space: normal;\">" + data.d[i].NomeArquivo + "</td>";
                cols += "<td style=\"width: 1px;\"><a class=\"btn btn-success\" target=\"_blank\" href=\"../ArquivosDoc/arqs/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" download=\"\" id=\"download\"><span class=\"glyphicon glyphicon-download-alt\" style=\"padding-right: 4px;\"></span>Baixar</a></td>";
                cols += "<td style=\"width: 1px;\">";
                cols += "<div class=\"btn-group\">";
                cols += "<button type=\"button\" class=\"btn btn-danger dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\"><span class=\"glyphicon glyphicon-remove-circle\" style=\"padding-right: 4px;\"></span>Excluir <span class=\"caret\"></span></button>";
                cols += "<ul class=\"dropdown-menu\"><li><a href=\"#\" onclick=\"ExcluirArquivo('" + data.d[i].Id + "','" + data.d[i].NomeArquivo + "')\">SIM</a></li></ul></div></td>";

                newRow.append(cols);
                $("#tbListaArquivo").append(newRow);
                i++;
            }
        },
        error: function (data) { params = data; }
    });
}

function ExcluirArquivo(Id, NomeArquivo) {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ExcluirArquivo',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: "{'IdArquivo':'" + Id + "','NomeArquivo':'" + NomeArquivo + "','IdDepartamento':'" + idDepartamento + "'}",
        success: function (data) {
            CarregarListaArquivo();
        }
        , error: function (xmlHttpRequest, status, err) {
        }
    });
}

function FindlistRows(position, element, tabela) {
    var input, filter, table, tr, td, i;
    input = document.getElementById(element.id);
    filter = input.value.toUpperCase();
    table = document.getElementById(tabela);
    tr = table.getElementsByTagName("tr");
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[parseInt(position)];
        if (td) {
            if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

function chkAllProducts(element) {
    var checked = element.checked;
    $("#tblSelSubdivisaoManutencao1 tbody").find('tr').each(function (i, el) {
        var $tds = $(this).find('td');
        if (checked)
            $tds[5].childNodes[0].checked = true;
        else
            $tds[5].childNodes[0].checked = false;
    });

}

//function divGallery(e) {
//    $(".carousel-inner").empty();
//    $(".pagination").empty();
//    var galleryId = $(e).attr('data-target');
//    var currentLinkIndex = $(e).index('a[data-target="' + galleryId + '"]');

//    createGallery(galleryId, currentLinkIndex);
//    createPagination(galleryId, currentLinkIndex);

//    $(galleryId).on('hidden.bs.modal', function () {
//        destroyGallry(galleryId);
//        destroyPagination(galleryId);
//    });

//    $(galleryId + ' .carousel').on('slid.bs.carousel', function () {
//        var currentSlide = $(galleryId + ' .carousel .item.active');
//        var currentSlideIndex = currentSlide.index(galleryId + ' .carousel .item');

//    })
//}

//function createGallery(galleryId, currentSlideIndex) {
//    var galleryBox = $(galleryId + ' .carousel-inner');

//    $('a[data-target="' + galleryId + '"]').each(function () {
//        var img = this.children[0].src.toString();
//        var galleryItem = $('<div class="item"><div class="container"><img class="img-responsive img-gallery" src="' + img + '"/></div>');
//        galleryItem.appendTo(galleryBox);
//    });

//    galleryBox.children('.item').eq(currentSlideIndex).addClass('active');
//}

//function destroyGallry(galleryId) {
//    $(galleryId + ' .carousel-inner').html("");
//}

//function createPagination(galleryId, currentSlideIndex) {
//    var pagination = $(galleryId + ' .pagination');
//    var carouselId = $(galleryId).find('.carousel').attr('id');
//    var prevLink = $('<li><a href="#' + carouselId + '" data-slide="prev">«</a></li>');
//    var nextLink = $('<li><a href="#' + carouselId + '" data-slide="next">»</a></li>');

//    prevLink.appendTo(pagination);
//    nextLink.appendTo(pagination);

//}

//function destroyPagination(galleryId) {
//    $(galleryId + ' .pagination').html("");
//}

function AdcOptionCadCtrl() {
    $("#divBotoesImplantacao_Movimentacao").css("display", "none");
    $("#divBtnVoltarDadosControlador").css("display", "block");
}

//function NovoGprs() {
//    $("#divAdd_NovoGPRS").css("display", "block");
//    $("#pnlSelGprs").css("display", "none");
//    $("#grpsCadastrado").css("display", "none");
//    $("#divCadastrar_GPRS").css("display", "none");
//}

function cancelarGprsControlador() {

    if ($("#btnSalvarGPRS_Controlador").html() == "Salvar Alterações") {

        $("#txtNumSerieGPRS").attr("disabled", false);
        $("#txtFabricanteGPRS").attr("disabled", false);
        $("#txtModeloGPRS").attr("disabled", false);
        $("#divCadastrar_GPRS").css("display", "none");
        $("#divBtnVoltar_NovoGPRS").css("display", "none");
        $("#divSelGprsDesejado").css("display", "none");
        $("#grpsCadastrado").css("display", "block");
        $("#divDetalhe_e_Manutencao_GprsControlador").css("display", "block");
        //$("#divTblPlacasCadastradas").css("display", "");
        //$("#btnSalvarPlcControladorCad").html("Salvar");

        //implantacaoPlacaControlador();
    }
    else {

        $("#divCadastrar_GPRS").css("display", "none");
        $("#divBtnVoltar_NovoGPRS").css("display", "block");
        $("#divSelGprsDesejado").css("display", "block");
    }
    //FindDNA();
}

function excluirGprsControlador() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ApagarGprsControl',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "', " +
            " 'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
            " 'idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "', " +
            " 'idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            FindDNA();
        },
        error: function (data) {
        }
    });
}

function porImplantacaoGPRS_Controlador() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getGprsCtrl',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {

                $("#divAdd_NovoGPRS").css("display", "none");
                $("#divBtnVoltar_NovoGPRS").css("display", "block");
                $("#divSelGprsDesejado").css("display", "block");
                $("#tbSelGPRSparaUtilizar").empty();
                //$("#grpsCadastrado").css("display", "none");
                //$("#divCadastrar_GPRS").css("display", "none");

                var i = 0;
                while (data.d[i]) {

                    var lst = data.d[i].split('@');
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border-collapse: collapse; padding-top: 14px;'>"
                        + lst[1] + "</td>";
                    cols += "<td style='border-collapse: collapse; padding-top: 14px;'>"
                        + lst[2] + "</td>";
                    cols += "<td style='border-collapse: collapse; padding-top: 14px;'>"
                        + lst[3] + "</td>";
                    cols += "<td style='width: 1px; padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectGprsCtrlCad(this)' data-idpatrimonio='" + lst[0] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tbSelGPRSparaUtilizar").append(newRow);
                }
            }
        },
        error: function (data) {
        }
    })
}

function SelectGprsCtrlCad(value) {

    $("#divBtnVoltar_NovoGPRS").css("display", "none");
    $("#divSelGprsDesejado").css("display", "none");
    $("#btnExcluirGPRS_Controlador").css("display", "none");
    $("#txtNumSerieGPRS").attr("disabled", true);
    $("#txtFabricanteGPRS").attr("disabled", true);
    $("#txtModeloGPRS").attr("disabled", true);
    $("#btnSalvarGPRS_Controlador").html("Salvar");
    //$("#grpsCadastrado").css("display", "none");
    $("#txtGprsNumPat").val("");
    $("#txtNumLinhaGPRS").val("");
    $("#sleOperadoraGPRS").val("─ SELECIONE ─");
    $("#sleEstadoOperacionalGPRS").val("─ SELECIONE ─");
    $("#divCadastrar_GPRS").css("display", "flex");

    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();
    var hh = today.getHours();
    var MM = today.getMinutes();
    var ss = today.getSeconds();
    var t = "T";

    if (dd < 10) {
        dd = '0' + dd
    }

    if (mm < 10) {
        mm = '0' + mm
    }

    if (MM < 10) {
        MM = '0' + MM;
    }

    if (hh < 10) {
        hh = '0' + hh;
    }

    if (ss < 10) {
        ss = '0' + ss;
    }

    var hoje = yyyy + '-' + mm + '-' + dd + t + hh + ':' + MM;
    var garantia = (parseInt(yyyy) + 1).toString() + '-' + mm + '-' + dd + t + hh + ':' + MM;

    document.getElementById("txtDataInstalacaoGPRS").value = hoje;
    document.getElementById("txtDataGarantiaGPRS").value = garantia;
    idProduto = $(value).data("idpatrimonio");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectGprsCtrlCad',
        dataType: 'json',
        data: "{'idProduto':'" + idProduto + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {

                var lst = data.d[0].split('@');
                $("#txtModeloGPRS").val(lst[0]);
                $("#txtFabricanteGPRS").val(lst[1]);
                $("#txtNumSerieGPRS").val(lst[2]);

            }
        },
        error: function (data) {
        }
    })

}

function salvarGprsControlador(value) {

    var nmrPat = $("#txtNumPatrimonioGPRS").val();
    if (nmrPat == "") {

        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {

            $("#modalConfirmacaoNmrPatrimonio").modal("show");
            document.getElementById("lblProdNpatrimonio").title = "Gprs Controlador"
            document.getElementById("lblProdNpatrimonio").innerHTML = "Gprs Controlador";
            return;
        }
    }
    else {
        document.getElementById("txtNumPatrimonioGPRS").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatrimonioGPRS").style.placeholder = "";
    }

    //#region VALIDAÇÕES
    if ($("#txtNumLinhaGPRS").val() == "" && $("#sleOperadoraGPRS").val() == "─ SELECIONE ─"
        && $("#sleEstadoOperacionalGPRS").val() == "─ SELECIONE ─") {

        $("#txtNumLinhaGPRS").addClass("is-invalid");
        $("#sleOperadoraGPRS").addClass("is-invalid");
        $("#sleEstadoOperacionalGPRS").addClass("is-invalid");
        Swal.fire({
            type: 'error',
            title: getResourceItem("erroTipoAlert"),
            text: getResourceItem("preenchaCamposEmBranco"),
        })
        return;
    }
    else {
        $("#txtNumLinhaGPRS").removeClass("is-invalid");
        $("#sleOperadoraGPRS").removeClass("is-invalid");
        $("#sleEstadoOperacionalGPRS").removeClass("is-invalid");
    }

    if ($("#txtNumLinhaGPRS").val() == "") {

        $("#txtNumLinhaGPRS").addClass("is-invalid");
        Swal.fire({
            type: 'error',
            title: getResourceItem("erroTipoAlert"),
            text: getResourceItem("naoPossivelSalvar ") +
                getResourceItem("numLinha") +
                getResourceItem(" emBranco"),
        })
        return;
    }
    else {
        $("#txtNumLinhaGPRS").removeClass("is-invalid");
    }

    if ($("#sleOperadoraGPRS").val() == "─ SELECIONE ─") {

        $("#sleOperadoraGPRS").addClass("is-invalid");
        Swal.fire({
            type: 'error',
            title: getResourceItem("erroTipoAlert"),
            text: getResourceItem("naoPossivelSalvar") +
                getResourceItem("operadora") +
                getResourceItem("emBranco"),
        })
        return;
    }
    else {
        $("#sleOperadoraGPRS").removeClass("is-invalid");
    }

    if ($("#sleEstadoOperacionalGPRS").val() == "─ SELECIONE ─") {

        $("#sleEstadoOperacionalGPRS").addClass("is-invalid");
        Swal.fire({
            type: 'error',
            title: getResourceItem("erroTipoAlert"),
            text: getResourceItem("naoPossivelSalvar") +
                getResourceItem("estadoOperacional") +
                getResourceItem("emBranco"),
        })
        return;
    }
    else {
        $("#sleEstadoOperacionalGPRS").removeClass("is-invalid");
    }
    //#endregion

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'nmrPatrimonio':'" + nmrPat + "','idPatrimonio':'" + idPatrimonio + "', " +
            " 'value':'" + value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                alert("Esse número de patrimonio já está vinculado a um produto!");
                return;
            }
            else {
                if (value.innerHTML == "Salvar Alterações") {

                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/EditGprsCtrl',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                            " 'NumeroPatrimonio':'" + nmrPat + "', " +
                            " 'idPatrimonio':'" + idPatrimonio + "', " +
                            " 'DataGarantia':'" + $("#txtDataGarantiaGPRS").val() + "', " +
                            " 'DataInstalacao':'" + $("#txtDataInstalacaoGPRS").val() + "', " +
                            " 'NmrDaLinha':'" + $("#txtNumLinhaGPRS").val() + "', " +
                            " 'Operadora':'" + $("#sleOperadoraGPRS").val() + "', " +
                            " 'EstadoOperacional':'" + $("#sleEstadoOperacionalGPRS").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("salvoTipoAlert"),
                                text: getResourceItem("salvoComSucesso"),
                            })

                            FindDNA();
                        },
                        error: function (data) {
                        }
                    });
                }
                else {

                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/InsertGprsCtrl',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                            " 'NumeroPatrimonio':'" + nmrPat + "', " +
                            " 'idPatrimonio':'" + idPatrimonio + "', " +
                            " 'DataGarantia':'" + $("#txtDataGarantiaGPRS").val() + "', " +
                            " 'Fabricante':'" + $("#txtFabricanteGPRS").val() + "', " +
                            " 'IdDepartamento':'" + idDepartamento + "', " +
                            " 'idProduto':'" + idProduto + "', " +
                            " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                            " 'modelo':'" + $("#txtModeloGPRS").val() + "', " +
                            " 'NumeroSerie':'" + $("#txtNumSerieGPRS").val() + "', " +
                            " 'NmrDaLinha':'" + $("#txtNumLinhaGPRS").val() + "', " +
                            " 'Operadora':'" + $("#sleOperadoraGPRS").val() + "', " +
                            " 'DataInstalacao':'" + $("#txtDataInstalacaoGPRS").val() + "', " +
                            " 'EstadoOperacional':'" + $("#sleEstadoOperacionalGPRS").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("salvoTipoAlert"),
                                text: getResourceItem("salvoComSucesso"),
                            })

                            FindDNA();
                        },
                        error: function (data) {
                        }
                    });
                }
            }
        },
        error: function (data) {
        }
    });
}

function detalhesGprsControlador(valor) {

    idPatrimonio = $(valor).data("id");
    $("#grpsCadastrado").css("display", "none");
    $("#divDetalhe_e_Manutencao_GprsControlador").css("display", "none");

    $("#txtNumSerieGPRS").attr("disabled", true);
    $("#txtFabricanteGPRS").attr("disabled", true);
    $("#txtModeloGPRS").attr("disabled", true);
    $("#btnSalvarGPRS_Controlador").html("Salvar Alterações");
    $("#btnExcluirGPRS_Controlador").css("display", "block");
    $("#divCadastrar_GPRS").css("display", "block");
}

function addControladorImplantacao(valor) {

    $("#divBotoesImplantacao_Movimentacao").css("display", "none");
    $("#divFormaOperacionalCadastro").css("display", "block");
    $("#divBtnVoltarDadosControlador").css("display", "block");
    //$("#divBtnVoltarDadosControlador").css("display", "none");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getControllers',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {

                var i = 0;
                $("#tblSelControladorDesejadoCad").css("display", "block");
                $("#tbSelControladorDesejadoCad").empty();

                if (valor == "valorDrop") {
                    $("#divtblSelControladorDesejado").css("display", "");
                }
                else {
                    $("#divtblSelControladorDesejado").css("display", "none");
                }

                while (data.d[i]) {

                    var lst = data.d[i].split('@');
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border-collapse: collapse; padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='border-collapse: collapse; padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='border-collapse: collapse; padding-top: 14px;'>" + lst[3] + "</td>";

                    cols += "<td style='border-collapse: collapse; padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' style='font-size:medium;' " +
                        " onclick='SelectCtrlCad(this)' data-idpatrimonio='" + lst[0] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblSelControladorDesejadoCad").append(newRow);
                }
            }
        },
        error: function (data) {
        }
    });
}

function SelectCtrlCad(value) {

    $("#divBtnVoltarDadosControlador").css("display", "none");
    $("#divFormaOperacionalCadastro").css("display", "none");
    $("#divtblSelControladorDesejado").css("display", "none");
    $("#btnExcluir").css("display", "none");
    document.getElementById("btnSalvar").value = "Salvar";
    idProduto = $(value).data("idpatrimonio");
    $("#divCadastrado_DadosControlador").css("display", "flex");
    $("#divFormaOperacionalCadastro").css("display", "block");

    //$("#divFormaOperacionalCadastro").css("display", "block");
    //$("#tblEditarDadosCtrl").css("display", "block");
    //$("#dvBtnCtrl").css("display", "block");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectCadControllers',
        dataType: 'json',
        data: "{'idProduto':'" + idProduto + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                var lst = data.d[0].split('@');
                $("#txtNomeProduto").val(lst[0]);
                $("#txtModelo").val(lst[1]);
                $("#txtFabricante").val(lst[2]);
                $("#txtNumSerie").val(lst[3]);
                $("#txtTipo").val(lst[4]);
            }
        },
        error: function (data) {
        }
    });
}

function SelectPlacaCtrl(value) {

    idPatrimonio = $(value).data("idpatrimonioplaca");

    $("#txtFabricantePlcControladorCad").attr("disabled", true);
    $("#txtModeloPlcControladorCad").attr("disabled", true);
    $("#btnNovaPlaca").css("display", "none");
    $("#divNumPatrimonioPlacasControlador").css("display", "none");
    $("#divTblPlacasCadastradas").css("display", "none");
    $("#inputQuantidade").css("display", "none");
    $("#inputNumPatrimonio").css("margin-left", "0px");
    $("#divCadastrar_PlacasControlador").css("display", "block");
    $("#btnSalvarPlcControladorCad").html("Salvar Alterações");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectPlacaControllers',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                var lst = data.d[0].split('@');
                idproduto = lst[0];
                $("#txtFabricantePlcControladorCad").val(lst[1]);
                $("#txtModeloPlcControladorCad").val(lst[2]);
                $("#txtDataInstalacaoPlcControladorCad").val(lst[3]);
                $("#txtDataGarantiaPlcControladorCad").val(lst[4]);
                $("#txtNumPatrimonioPlcControladorCad").val(lst[5]);
                $("#sleEstadoOperacionalPlcControladorCad").val(lst[6]);

                $("#txtQuantidadePlcControladorCad").val("");
            }
        },
        error: function (data) {
        }
    });
}

//O componente que mostra Por implantação ou Por movimentação
//é diferente, quem vai deixar as coisas block ou none é o
//onclick do botão Por implementação

//function NovaPlaca() {
//    $("#pnlAdcPlaca").css("display", "block");
//    $("#pnlGrdPlacaCtrl").css("display", "none");
//    $("#dvGrdPlacas").css("display", "none");
//    $("#pnlPlaca").css("display", "block");
//    $("#pnlPlacaDetalhe").css("display", "none");
//    $("#pnlQtdPlacaCtrl").css("display", "block");
//}

function cancelarPlacaControlador() {

    FindDNA();
}

function salvarPlacaControlador(value) {

    var nmrPat = $("#txtNumPatrimonioPlcControladorCad").val();
    if (nmrPat == "") {

        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            $("#mpMensagem").modal("show");
            document.getElementById("lblProdNpatrimonio").innerHTML = "Placa Controlador";
            document.getElementById("lblProdNpatrimonio").title = "Placa Controlador"
            return;
        }
    }
    else {

        document.getElementById("txtNumPatrimonioPlcControladorCad").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatrimonioPlcControladorCad").style.placeholder = "";
    }

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'nmrPatrimonio':'" + nmrPat + "','idPatrimonio':'" + idPatrimonio + "', " +
            " 'value':'" + value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                alert("Esse número de patrimonio já está vinculado a um produto!");
                return;
            }
            else {
                if (value.textContent == "Salvar Alterações") {
                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/EditPlacaCtrl',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                            " 'NumeroPatrimonio':'" + nmrPat + "', " +
                            " 'DataGarantia':'" + $("#txtDataGarantiaPlcControladorCad").val() + "', " +
                            " 'idPatrimonio':'" + idPatrimonio + "', " +
                            " 'DataInstalacao':'" + $("#txtDataInstalacaoPlcControladorCad").val() + "', " +
                            " 'EstadoOperacional':'" + $("#sleEstadoOperacionalPlcControladorCad").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("salvoTipoAlert"),
                                text: getResourceItem("salvoComSucesso"),
                            })

                            FindDNA();
                        },
                        error: function (data) {
                        }
                    });
                }
                else {
                    var quantidade = $("#txtQuantidadePlcControladorCad").val();
                    var i = 0;
                    if (nmrPat != "") {

                        $.ajax({
                            type: 'POST',
                            url: '../../WebServices/Materiais.asmx/verificaNrPat',
                            dataType: 'json',
                            data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                                " 'nmrPatrimonio':'" + $("#txtNumPatrimonioPlcControladorCad").val() + "', " +
                                " 'NmrPat':'" + nmrPat + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                if (data.d != "") {
                                    alert("Existem Nºs de Patrimonios sendo usado no intervalo de " +
                                        " " + $("#txtNumPatrimonioPlcControladorCad").val() + " " +
                                        " a " + (nmrPat - 1) + "!");
                                    return;
                                }
                                else {
                                    nmrPat = $("#txtNumPatrimonioPlcControladorCad").val();
                                    i = 0;
                                }
                            },
                            error: function (data) {
                            }
                        });
                    }

                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/InsertPlacaCtrl',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                            " 'idProduto':'" + idProduto + "','NmrPat':'" + nmrPat + "', " +
                            " 'quantidade':'" + quantidade + "', " +
                            " 'DataGarantia':'" + $("#txtDataGarantiaPlcControladorCad").val() + "', " +
                            " 'Fabricante':'" + $("#txtFabricantePlcControladorCad").val() + "', " +
                            " 'IdDepartamento':'" + idDepartamento + "', " +
                            " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                            " 'modelo':'" + $("#txtModeloPlcControladorCad").val() + "', " +
                            " 'NumeroSerie':'" + $("#txtNumSerie").val() + "', " +
                            " 'idPatrimonio':'" + idPatrimonio + "', " +
                            " 'DataInstalacao':'" + $("#txtDataInstalacaoPlcControladorCad").val() + "', " +
                            " 'EstadoOperacional':'" + $("#sleEstadoOperacionalPlcControladorCad").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("salvoTipoAlert"),
                                text: getResourceItem("salvoComSucesso"),
                            })

                            FindDNA();
                        },
                        error: function (data) {
                        }
                    });
                }
            }
        },
        error: function (data) {
        }
    });
}

function excluirPlacaControlador() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/DeletePlacaControllers',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','quantidade':'" + $("#txtQuantidadeGrupoFocal").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
        },
        error: function (data) {
        }
    });
}

function implantacaoPlacaControlador() {

    $("#btnNovaPlaca").css("display", "none");
    $("#divBtnVoltarPlacasControlador").css("display", "block");
    $("#divTblPlacasUtilizar").css("display", "block");
    $("#divNumPatrimonioPlacasControlador").css("display", "none");
    $("#divTblPlacasCadastradas").css("display", "none");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getPlacaControllers',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'IdPatrimonio':'" + idPatrimonioCtrl + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {

                var i = 0;
                $("#tblPlacaDesejaUtilizar").css("display", "block");
                $("#tbPlacaDesejaUtilizar").empty();
                while (data.d[i]) {

                    var lst = data.d[i].split('@');
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border-collapse: collapse; padding-top: 14px'>" + lst[1] + "</td>";
                    cols += "<td style='border-collapse: collapse; padding-top: 14px'>" + lst[2] + "</td>";
                    cols += "<td style='border-collapse: collapse; padding-top: 14px'>" + lst[3] + "</td>";
                    cols += "<td style='border-collapse: collapse; padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' style='font-size:medium' " +
                        " onclick='SelectPlacaCtrlCad(this)' data-id='" + lst[0] + "' " +
                        " data-modelo='" + lst[2] + "' data-fabricante='" + lst[3] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tbPlacaDesejaUtilizar").append(newRow);
                }
            }
        },
        error: function (data) {
        }
    });
}

function SelectPlacaCtrlCad(value) {

    $("#divBtnVoltarPlacasControlador").css("display", "none");
    $("#divTblPlacasUtilizar").css("display", "none");
    $("#btnExcluirPlcControladorCad").css("display", "none");

    if ($("#btnSalvarPlcControladorCad").html() == "Salvar") {

        $("#inputQuantidade").css("display", "block");
        $("#inputNumPatrimonio").css("margin-left", "2rem");
    }

    idProduto = $(value).data("id");
    $("#txtModeloPlcControladorCad").val($(value).data("modelo"));
    $("#txtFabricantePlcControladorCad").val($(value).data("fabricante"));
    $("#btnSalvarPlcControladorCad").html("Salvar");
    $("#sleEstadoOperacionalPlcControladorCad").val("─ SELECIONE ─");
    $("#txtFabricantePlcControladorCad").attr("disabled", true);
    $("#txtModeloPlcControladorCad").attr("disabled", true);

    $("#divCadastrar_PlacasControlador").css("display", "block");
}

function cancelarDadosControlador() {

    FindDNA();
}

function salvarDadosControlador(value) {

    if ($("#sleFormaOperacionalCadastro").val() == "CONJUGADO") {

        var idLocalMestre = $("#txtIdLocalControladorMestre").val();
        if (idLocalMestre == "") {
            //adicionar nesses campos a classe invalid do template
            document.getElementById("txtIdLocalControladorMestre").style.placeholder = "Obrigatório!";
            document.getElementById("txtIdLocalControladorMestre").style.borderColor = "red";
            return;
        }
        else {
            //adicionar nesses campos a classe invalid do template
            document.getElementById("txtIdLocalControladorMestre").style.borderColor = 'rgb(169, 169, 169)';
            document.getElementById("txtIdLocalControladorMestre").style.placeholder = "";

            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/EditMestreCtrl',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                    " 'idLocalMestre':'" + $("#txtIdLocalControladorMestre").val() + "', " +
                    " 'idsubdivisao':'" + $("#hfIdSub").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {
                        alert("Local não encontrado!");
                        return;
                    }

                    FindDNA();
                },
                error: function (data) {
                }
            })
        }
    }
    else {
        //Valida nmrPatrimonio
        $.ajax({
            type: 'POST',
            url: '../../WebServices/Materiais.asmx/validaNrPat',
            dataType: 'json',
            data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                " 'nmrPatrimonio':'" + document.getElementById("txtNumPatrimonio").value + "', " +
                " 'idPatrimonio':'" + idPatrimonio + "','value':'" + value + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {

                if (data.d != "") {
                    alert("Esse número de patrimônio já está vinculado a um produto!");
                    return;
                }
                else {

                    if ($("#sleFormaOperacionalCadastro").val() == "MESTRE" ||
                        $("#sleFormaOperacionalCadastro").val() == "ISOLADO") {

                        var nmrPat = $("#txtNumPatrimonio").val();
                        if (nmrPat == "") {
                            if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
                                $("#modalConfirmacaoNmrPatrimonio").modal("show");
                                document.getElementById("lblProdNpatrimonio").innerHTML = "Controlador";
                                document.getElementById("lblProdNpatrimonio").title = "Controlador"
                                return;
                            }
                        }
                        else {
                            //adicionar nesses campos a classe invalid do template
                            document.getElementById("txtNumPatrimonio").style.borderColor = 'rgb(169, 169, 169)';
                            document.getElementById("txtNumPatrimonio").style.placeholder = "";
                        }

                        if (value == "Salvar Alterações") {

                            $.ajax({
                                type: 'POST',
                                url: '../../WebServices/Materiais.asmx/EditCtrl',
                                dataType: 'json',
                                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                                    " 'nmrPatrimonio':'" + $("#txtNumPatrimonio").val() + "', " +
                                    " 'DataGarantia':'" + $("#txtDataGarantia").val() + "', " +
                                    " 'idPatriomonio':'" + idPatrimonio + "', " +
                                    " 'Fixacao':'" + $("#sleFixacao").val() + "', " +
                                    " 'DataInstalacao':'" + $("#txtDataInstalacao").val() + "', " +
                                    " 'TensaoEntrada':'" + $("#sleTensaoEntrada").val() + "', " +
                                    " 'TensaoSaida':'" + $("#sleTensaoSaida").val() + "', " +
                                    " 'CapacidadeFasesSuportadas':'" + $("#txtCapacidadeFaseSuportada").val() + "', " +
                                    " 'CapacidadeFasesInstaladas':'" + $("#txtCapacidadeFasesInstaladas").val() + "', " +
                                    " 'EstadoOperacional':'" + $("#sleEstadoOperacional").val() + "', " +
                                    " 'FormaOperacional':'" + $("#sleFormaOperacionalCadastro").val() + "', " +
                                    " 'IdDepartamento':'" + idDepartamento + "', " +
                                    " 'IdSubdivisao':'" + $("#hfIdSub").val() + "'}",
                                contentType: "application/json; charset=utf-8",
                                success: function (data) {
                                },
                                error: function (data) {
                                }
                            });

                            FindDNA();
                            return;
                        }

                        $.ajax({
                            type: 'POST',
                            url: '../../WebServices/Materiais.asmx/InsertProdPatrimonio',
                            dataType: 'json',
                            data: "{'DataGarantia':'" + $("#txtDataGarantia").val() + "', " +
                                " 'Fabricante':'" + $("#txtFabricante").val() +
                                "','IdDepartamento':'" + idDepartamento + "', " +
                                " 'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                                " 'IdProduto':'" + idProduto + "', " +
                                " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                                " 'modelo':'" + $("#txtModelo").val() + "', " +
                                " 'NumeroSerie':'" + $("#txtNumSerie").val() + "', " +
                                " 'NumeroPatrimonio':'" + $("#txtNumPatrimonio").val() + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                if (data.d != "") {
                                    var lst = data.d[0].split('@');
                                    if (lst[0] != "") {
                                        idPatrimonio = lst[0];
                                    }
                                }

                                $.ajax({
                                    type: 'POST',
                                    url: '../../WebServices/Materiais.asmx/InsertCtrl',
                                    dataType: 'json',
                                    data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                                        " 'nmrPatrimonio':'" + $("#txtNumPatrimonio").val() + "', " +
                                        " 'DataGarantia':'" + $("#txtDataGarantia").val() + "', " +
                                        " 'idPatriomonio':'" + idPatrimonio + "', " +
                                        " 'Fixacao':'" + $("#sleFixacao").val() + "', " +
                                        " 'DataInstalacao':'" + $("#txtDataInstalacao").val() + "', " +
                                        " 'TensaoEntrada':'" + $("#sleTensaoEntrada").val() + "', " +
                                        " 'TensaoSaida':'" + $("#sleTensaoSaida").val() + "', " +
                                        " 'CapacidadeFasesSuportadas':'" + $("#txtCapacidadeFaseSuportada").val() + "', " +
                                        " 'CapacidadeFasesInstaladas':'" + $("#txtCapacidadeFasesInstaladas").val() + "', " +
                                        " 'EstadoOperacional':'" + $("#sleEstadoOperacional").val() + "', " +
                                        " 'FormaOperacional':'" + $("#sleFormaOperacionalCadastro").val() + "', " +
                                        " 'IdDepartamento':'" + idDepartamento + "', " +
                                        " 'IdSubdivisao':'" + $("#hfIdSub").val() + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    success: function (data) {
                                    },
                                    error: function (data) {
                                    }
                                });

                                FindDNA();
                            },
                            error: function (data) {
                            }
                        });
                    }
                }
            },
            error: function (data) {
            }
        });
    }
}

function DetalhesDadosControlador() {

    var detalhes = "";
    document.getElementById("sleFormaOperacionalCadastro").disabled = true;
    $("#divDadosControlador_Cadastrado").css("display", "none");
    $("#divBtn_Detalhes_e_Manutencao").css("display", "none");
    $("#divCadastrado_DadosControlador").css("display", "flex");


    //$("#divControladorConjugado").css("display", "none");
    //$("#divBtnVoltarDadosControlador").css("display", "none");
    //$("#pnlDadoSubMestre").css("display", "none");
    //$("#tblDadoSubMestre").css("display", "none");
    //$("#btnExcluir").css("display", "block");

    if (document.getElementById("btnDetalhesDadosControlador").innerHTML == "Detalhes") {
        detalhes = "Controlador";
        $.ajax({
            type: 'POST',
            url: '../../WebServices/Materiais.asmx/DetalhesCtrl',
            dataType: 'json',
            data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                " 'idsubdivisao': '" + document.getElementById("hfIdSub").value + "', " +
                " 'Endereco': '" + document.getElementById("hfEndereco").value + "', " +
                " 'IdLocal': '" + document.getElementById("hfIdDna").value + "', " +
                " 'Detalhes': '" + detalhes + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {

                if (data.d != "") {
                    $("#divCadastrado_DadosControlador").css("display", "flex");
                    var lst = data.d[0].split('@');
                    idPatrimonio = lst[0];
                    idDepartamento = lst[1]
                    $("#txtCapacidadeFaseSuportada").val(lst[2]);
                    $("#txtNomeProduto").val(lst[3]);
                    $("#sleFormaOperacionalCadastro").val(lst[4]);
                    var FormaOperacional = lst[4];
                    $("#sleFixacao").val(lst[5]);
                    $("#txtNumSerie").val(lst[6]);
                    $("#txtNumPatrimonio").val(lst[7]);
                    $("#txtDataGarantia").val(lst[8]);
                    $("#txtDataInstalacao").val(lst[9]);
                    $("#txtFabricante").val(lst[10]);
                    $("#txtModelo").val(lst[11]);
                    $("#txtTipo").val(lst[12]);
                    $("#sleTensaoEntrada").val(lst[13]);
                    $("#sleTensaoSaida").val(lst[14]);
                    $("#txtCapacidadeFaseSuportada").val(lst[15]);
                    $("#txtCapacidadeFasesInstaladas").val(lst[16]);
                    $("#sleEstadoOperacional").val(lst[17]);

                    if (FormaOperacional == "CONJUGADO") {
                        $("#divControladorConjugado").css("display", "block");
                        document.getElementById("lblMestreSelecionado").innerHTML = lst[18];
                        document.getElementById("lblModeloMestre").innerHTML = lst[19];
                    }
                    else if (lst[0] == "MESTRE") {

                        $("#pnlConjugados").css("display", "block");
                        document.getElementById("lblFormaOpCadastrada1").innerHTML = "MESTRE";

                        var i = 0;
                        $("#tabControladoresConjugados").css("display", "block");
                        $("#tfConjugados").css("display", "none");
                        $("#tbConjugados").empty();
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');

                            var newRow = $("<tr>");
                            var cols = "";
                            if (lst[18] != undefined && lst[19] != undefined) {
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; " +
                                    " padding: 5px; color: #4CA2BF;'>" + lst[19] + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; " +
                                    " padding: 5px; color: #4CA2BF;'>" + lst[20] + "</td>";
                            }
                            else {
                                $("#tfConjugados").css("display", "block");
                                $("#tbConjugados").empty();
                            }

                            newRow.append(cols);
                            $("#tbConjugados").append(newRow);
                            i++
                        }
                    }
                    else {
                        document.getElementById("lblFormaOpCadastrada1").innerHTML = "ISOLADO";
                    }
                }
            },
            error: function (data) {
            }
        });
    }
    else {
        detalhes = "CONJUGADO";
        $.ajax({
            type: 'POST',
            url: '../../WebServices/Materiais.asmx/DetalhesCtrl',
            dataType: 'json',
            data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                " 'idsubdivisao':'" + document.getElementById("hfIdSub").value + "', " +
                " 'Endereco':'" + document.getElementById("hfEndereco").value + "', " +
                " 'IdLocal':'" + document.getElementById("hfIdDna").value + "', " +
                " 'Detalhes':'" + detalhes + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {

                if (data.d != "") {
                    var lst = data.d[0].split('@');
                    document.getElementById("lblMestreSelecionado").innerHTML = lst[0];
                    $("#sleFormaOperacionalCadastro").val("CONJUGADO");
                    $("#divControladorConjugado").css("display", "block");
                    $("#divIdLocalControladorMestreCadastrado").css("display", "block");
                    $("#tblDadoSubMestre").css("display", "none");
                    $("#tblEditarDadosCtrl").css("display", "none");
                    $("#divtblSelControladorDesejado").css("display", "none");
                    $("#divCadastrado_DadosControlador").css("display", "flex");
                    $("#divFormaOperacionalCadastro").css("display", "block");
                    $("#dvBtnCtrl").css("display", "block");
                }
            },
            error: function (data) {
            }
        });
    }

    $("#btnSalvar").html("Salvar Alterações");
    $("#btnExcluir").css("display", "block");
    $("#btnCancelar").css("display", "block");

    $("#divtblSelControladorDesejado").css("display", "none");
    $("#divBtnVoltarDadosControlador").css("display", "none");
    $("#divBotoesImplantacao_Movimentacao").css("display", "none");
}

function excluirDadosControlador() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/DeleteControllers',
        dataType: 'json',
        data: "{'idSubdivisao':'" + $("#hfIdSub").val() + "', " +
            " 'idPatrimonio':'" + idPatrimonio + "', " +
            " 'formaOperacional':'" + $("#sleFormaOperacionalCadastro").val() + "', " +
            " 'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
            " 'idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "', " +
            " 'idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            FindDNA();
        },
        error: function (data) {
        }
    });
}

function voltarOpcoes_de_cadastro() {

    $("#divtblSelControladorDesejado").css("display", "none");
    $("#divIdLocalControladorMestreCadastrado").css("display", "none");
    $("#divBtnVoltarDadosControlador").css("display", "none");
    $("#divFormaOperacionalCadastro").css("display", "none");
    $("#divBotoesImplantacao_Movimentacao").css("display", "block");
}

function voltarPlacasControlador() {

    $("#divBtnVoltarPlacasControlador").css("display", "none");
    $("#divTblPlacasUtilizar").css("display", "none");
    $("#btnNovaPlaca").css("display", "block");
    //$("#divNumPatrimonioPlacasControlador").css("display", "flex");
    //$("#divTblPlacasCadastradas").css("display", "block");
    FindDNA();
}

function voltarGprsControlador() {

    $("#divBtnVoltar_NovoGPRS").css("display", "none");
    $("#divSelGprsDesejado").css("display", "none");
    $("#divAdd_NovoGPRS").css("display", "block");
    //$("#divNumPatrimonioPlacasControlador").css("display", "flex");
    //$("#divTblPlacasCadastradas").css("display", "block");
    FindDNA();
}

function cancelarCad_PlacasControlador() {

    if ($("#btnSalvarPlcControladorCad").html() == "Salvar Alterações") {

        $("#txtFabricantePlcControladorCad").attr("disabled", false);
        $("#txtModeloPlcControladorCad").attr("disabled", false);
        $("#divCadastrar_PlacasControlador").css("display", "none");
        $("#btnNovaPlaca").css("display", "block");
        $("#divNumPatrimonioPlacasControlador").css("display", "flex");
        $("#divTblPlacasCadastradas").css("display", "");
        $("#btnSalvarPlcControladorCad").html("Salvar");

        //implantacaoPlacaControlador();
    }
    else {

        $("#divCadastrar_PlacasControlador").css("display", "none");
        $("#divBtnVoltarPlacasControlador").css("display", "block");
        $("#divTblPlacasUtilizar").css("display", "block");
    }
}

function formaOperacionalSelecionada(valor) {

    var formaOperacional = valor.value;
    switch (formaOperacional) {

        case "MESTRE":
            $("#divtblSelControladorDesejado").css("display", "");
            $("#divIdLocalControladorMestreCadastrado").css("display", "none");
            //$("#divIdLocalControladorMestreCadastrado").css("display", "none");
            //$("#divCadastrado_DadosControlador").css("display", "none");
            addControladorImplantacao("valorDrop");
            break;

        case "CONJUGADO":
            $("#divtblSelControladorDesejado").css("display", "none");
            $("#divIdLocalControladorMestreCadastrado").css("display", "block");
            $("#divCadastrado_DadosControlador").css("display", "none");

            //$("#divIdLocalControladorMestreCadastrado").css("display", "block");
            //$("#tblDadoSubMestre").css("display", "none");
            //$("#tblEditarDadosCtrl").css("display", "none");
            //$("#divtblSelControladorDesejado").css("display", "none");
            //$("#divCadastrado_DadosControlador").css("display", "block");
            //$("#divFormaOperacionalCadastro").css("display", "block");
            //$("#dvBtnCtrl").css("display", "block");
            break;
        default:
            $("#divtblSelControladorDesejado").css("display", "");
            $("#divIdLocalControladorMestreCadastrado").css("display", "none");
            //$("#divIdLocalControladorMestreCadastrado").css("display", "none");
            //$("#divCadastrado_DadosControlador").css("display", "none");
            addControladorImplantacao("valorDrop");
    }
}

//function AdcNobreak() {

//    $("#divDadosNobreakCadastrado").css("display", "none");
//    $("#pnlAddNbk").css("display", "block");
//    $("#divCadastroDadosNobreak").css("display", "none");
//    $("#divTblSelNobreakDesejado").css("display", "none");
//    $("#divBtn_AddNobreak").css("display", "block");

//}

function salvarDadosNobreak(value) {

    var nmrPat = $("#txtNumPatrimonioDadosNobreak").val();
    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            $("#mpMensagem").modal("show");
            document.getElementById("lblProdNpatrimonio").innerHTML = "Nobreak";
            document.getElementById("lblProdNpatrimonio").title = "Nobreak";
            return;
        }
    }
    else {
        document.getElementById("txtNumPatrimonioDadosNobreak").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatrimonioDadosNobreak").style.placeholder = "";
    }

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','nmrPatrimonio':'" + nmrPat + "','idPatrimonio':'" + idPatrimonio + "','value':'" + value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                alert("Esse número de patrimonio já está vinculado a um produto!");
                return;
            }
            else {
                $.ajax({
                    type: 'POST',
                    url: '../../WebServices/Materiais.asmx/EditNobreak',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','NumeroPatrimonio':'" + nmrPat +
                        "','idPatrimonio':'" + idPatrimonio + "','idProduto':'" + idProduto +
                        "','DataGarantia':'" + $("#txtDataGarantiaDadosNobreak").val() + "','Fabricante':'" + $("#txtFabricanteDadosNobreak").val() +
                        "','IdDepartamento':'" + idDepartamento + "','idSubDivisao':'" + $("#hfIdSub").val() + "','modelo':'" + $("#txtModeloDadosNobreak").val() +
                        "','Fixacao':'" + $("#sleFixacaoDadosNobreak").val() + "','DataInstalacao':'" + $("#txtPotenciaDadosNobreak").val() +
                        "','EstadoOperacional':'" + $("#sleEstadoOperacionalDadosNobreak").val() + "','Autonomia':'" + $("#txtAutonomiaDadosNobreak").val() +
                        "','Potencia':'" + $("#txtPotenciaDadosNobreak").val() + "','Monitoracao':'" + $("#sleMonitoracaoDadosNobreak").val() +
                        "','value':'" + value + "','idLocal':'" + document.getElementById("hfIdDna").value +
                        "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        FindDNA();

                    },
                    error: function (data) {
                    }
                });
            }
        },
        error: function (data) {
        }
    });

}

function excluirDadosNobreak() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ApagarNobreak',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            FindDNA();

        },
        error: function (data) {
        }
    });
}

function cancelarDadosNobreak() {

    FindDNA();
}

function implantacaoNobreak() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoNbrk',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#tblSelNobreakDesejado").css("display", "block");
                $("#tbSelNobreakDesejado").empty();
                $("#divTblSelNobreakDesejado").css("display", "block");
                $("#divDadosNobreakCadastrado").css("display", "none");
                $("#pnlAddNbk").css("display", "none");
                $("#divCadastroDadosNobreak").css("display", "none");
                $("#divBtn_AddNobreak").css("display", "none");
                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[1] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[2] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[3] + "</td>";
                    cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;"> <a style="cursor:pointer;color:#0174DF;" onclick="selNobreakCadastrado(this)" data-id="' + lst[0] + '" data-model="' + lst[2] + '"  data-fab="' + lst[3] + '">Selecionar</a></td>';

                    i++;
                    newRow.append(cols);
                    $("#tblSelNobreakDesejado").append(newRow);
                }

            }
        },
        error: function (data) {
        }
    });
}

function selNobreakCadastrado(valor) {

    idProduto = $(valor).data("id");
    $("#txtModeloDadosNobreak").val($(valor).data("model"));
    $("#txtFabricanteDadosNobreak").val($(valor).data("fab"));
    $("#btnExcluirDadosNobreak").css("display", "none");
    $("#divDadosNobreakCadastrado").css("display", "none");
    $("#pnlAddNbk").css("display", "none");
    $("#divCadastroDadosNobreak").css("display", "block");
    $("#divTblSelNobreakDesejado").css("display", "none");
    $("#divBtn_AddNobreak").css("display", "none");
    $("#btnSalvarDadosNobreak").val("Salvar");
}

function detalhesDadosNobreak() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/DetailsNbr',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idSubdivisao':'" + $("#hfIdSub").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lst = data.d[0].split('@');
                idPatrimonio = lst[0];
                $("#txtAutonomiaDadosNobreak").val(lst[1]);
                $("#txtDataGarantiaDadosNobreak").val(lst[2]);
                $("#txtFabricanteDadosNobreak").val(lst[3]);
                $("#txtPotenciaDadosNobreak").val(lst[4]);
                $("#txtModeloDadosNobreak").val(lst[5]);
                $("#txtNumPatrimonioDadosNobreak").val(lst[6]);
                $("#txtPotenciaDadosNobreak").val(lst[7]);
                $("#sleEstadoOperacionalDadosNobreak").val(lst[8]);
                $("#sleFixacaoDadosNobreak").val(lst[9]);
                $("#sleMonitoracaoDadosNobreak").val(lst[10]);
                $("#divDadosNobreakCadastrado").css("display", "none");
                $("#pnlAddNbk").css("display", "none");
                $("#divCadastroDadosNobreak").css("display", "block");
                $("#divTblSelNobreakDesejado").css("display", "none");
                $("#divBtn_AddNobreak").css("display", "none");
                $("#btnSalvarDadosNobreak").val("Salvar Alterações");
                $("#btnExcluirDadosNobreak").css("display", "block");
            }
        },
        error: function (data) {
        }
    });
}

//function AdcGPRSnbk() {

//    $("#adcGprs").css("display", "none");
//    $("#divBtn_AddGprs").css("display", "block");
//    $("#divDadosGprsCadastrado").css("display", "none");
//    $("#divTblSelGprsDesejado").css("display", "none");
//    $("#divCadastroGprsNobreak").css("display", "none");
//}

function implantacaoGprsNobreak() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoGprsNbk',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#tblSelecioneGprsDesejado").css("display", "block");
                $("#tbSelecioneGprsDesejado").empty();
                $("#adcGprs").css("display", "none");
                $("#divBtn_AddGprs").css("display", "none");
                $("#divDadosGprsCadastrado").css("display", "none");
                $("#divTblSelGprsDesejado").css("display", "block");
                $("#divCadastroGprsNobreak").css("display", "none");
                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[1] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[2] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[3] + "</td>";
                    cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;"> <a style="cursor:pointer;color:#0174DF;" onclick="selGprsNobreakCadastrado(this)" data-id="' + lst[0] + '" data-model="' + lst[2] + '"  data-fab="' + lst[3] + '">Selecionar</a></td>';

                    i++;
                    newRow.append(cols);
                    $("#tblSelecioneGprsDesejado").append(newRow);
                }

            }
        },
        error: function (data) {
        }
    });
}

function selGprsNobreakCadastrado(valor) {

    $("#btnExcluirGprsNobreak").css("display", "none");
    idProduto = $(valor).data("id");
    $("#txtModeloGprsNbk").val($(valor).data("model"));
    $("#txtFabricanteGprsNbk").val($(valor).data("fab"));
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectGprsNbrkCad',
        dataType: 'json',
        data: "{'idProduto':'" + idProduto + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lst = data.d[0].split('@');
                $("#txtNumSerieGprsNobreak").val(lst[0]);
            }
        },
        error: function (data) {
        }
    });
    $("#adcGprs").css("display", "none");
    $("#divBtn_AddGprs").css("display", "none");
    $("#divDadosGprsCadastrado").css("display", "none");
    $("#divTblSelGprsDesejado").css("display", "none");
    $("#divCadastroGprsNobreak").css("display", "block");
    $("#btnSalvarGprsNobreak").val("Salvar");

}

function cancelarGprsNobreak() {

    FindDNA();
}

function detalhesGprsNobreak() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/DetailsNbrGprs',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idSubdivisao':'" + $("#hfIdSub").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lst = data.d[0].split('@');
                idPatrimonio = lst[0];
                $("#txtFabricanteGprsNbk").val(lst[1]);
                $("#lblFabricanteGprsNobreak").val(lst[1]);
                $("#txtNumPatrimonioGprsNobreak").val(lst[2]);
                $("#lblNumPatrimonioGprsNobreak").val(lst[2]);
                $("#txtNumLinhaGprsNobreak").val(lst[3]);
                $("#txtDtGarantiaGprsNbk").val(lst[4]);
                $("#txtDataInstalacaoGprsNobreak").val(lst[5]);
                $("#txtModeloGprsNbk").val(lst[6]);
                $("#lblModeloGprsNobreak").val(lst[6]);
                $("#sleOperadoraGprsNobreak").val(lst[7]);
                $("#sleEstadoOperacionalGprsNobreak").val(lst[8]);
                $("#adcGprs").css("display", "none");
                $("#divBtn_AddGprs").css("display", "none");
                $("#divDadosGprsCadastrado").css("display", "none");
                $("#divTblSelGprsDesejado").css("display", "none");
                $("#divCadastroGprsNobreak").css("display", "block");
                $("#btnSalvarGprsNobreak").val("Salvar Alterações");
                $("#btnExcluirGprsNobreak").css("display", "block");
            }
        },
        error: function (data) {
        }
    });
}

function salvarGprsNobreak(value) {
    var nmrPat = $("#txtNumPatrimonioGprsNobreak").val();

    if (nmrPat == "") {

        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            $("#mpMensagem").modal("show");
            document.getElementById("lblProdNpatrimonio").innerHTML = "Gprs Nobreak";
            document.getElementById("lblProdNpatrimonio").title = "Gprs Nobreak";
            return;
        }
    }
    else {
        document.getElementById("txtNumPatrimonioGprsNobreak").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatrimonioGprsNobreak").style.placeholder = "";
    }

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','nmrPatrimonio':'" + nmrPat + "','idPatrimonio':'" + idPatrimonio + "','value':'" + value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                alert("Esse número de patrimonio já está vinculado a um produto!");
                return;
            }
            else {
                $.ajax({
                    type: 'POST',
                    url: '../../WebServices/Materiais.asmx/EditGprsNobreak',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','NumeroPatrimonio':'" + nmrPat +
                        "','idPatrimonio':'" + idPatrimonio + "','idProduto':'" + idProduto +
                        "','DataGarantia':'" + $("#txtDtGarantiaGprsNbk").val() + "','Fabricante':'" + $("#txtFabricanteGprsNbk").val() +
                        "','IdDepartamento':'" + idDepartamento + "','idSubDivisao':'" + $("#hfIdSub").val() + "','modelo':'" + $("#txtModeloGprsNbk").val() +
                        "','NumeroSerie':'" + $("#txtNumSerieGprsNobreak").val() + "','NmrDaLinha':'" + $("#txtNumLinhaGprsNobreak").val() +
                        "','Operadora':'" + $("#sleOperadoraGprsNobreak").val() + "','DataInstalacao':'" + $("#txtDataInstalacaoGprsNobreak").val() +
                        "','EstadoOperacional':'" + $("#sleEstadoOperacionalGprsNobreak").val() + "','value':'" + value + "','idLocal':'" + document.getElementById("hfIdDna").value +
                        "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        FindDNA();

                    },
                    error: function (data) {
                    }
                });
            }
        },
        error: function (data) {
        }
    });

}

function excluirGprsNobreak() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ExcluirGprsNbk',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            FindDNA();

        },
        error: function (data) {
        }
    });

}

//function AdcColuna() {

//    $("#tbladcNewcols").css("display", "none");
//    $("#divBtn_AddColunas").css("display", "block");
//    $("#divTblSelColunaDesejada").css("display", "none");
//    $("#divCadastroColunas").css("display", "none");
//    $("#pnlColunas").css("display", "none");
//}

function cancelarColuna() {

    FindDNA();
}

function implantacaoListaColuna() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoColuna',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#tblSelColunaDesejaUtilizar").css("display", "block");
                $("#tbSelColunaDesejaUtilizar").empty();
                $("#tbladcNewcols").css("display", "none");
                $("#divBtn_AddColunas").css("display", "none");
                $("#divTblSelColunaDesejada").css("display", "block");
                $("#divCadastroColunas").css("display", "none");
                $("#pnlColunas").css("display", "none");
                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[1] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[2] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[3] + "</td>";
                    cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;"> <a style="cursor:pointer;color:#0174DF;" onclick="selNovaColuna(this)" data-id="' + lst[0] + '">Selecionar</a></td>';

                    i++;
                    newRow.append(cols);
                    $("#tblSelColunaDesejaUtilizar").append(newRow);
                }

            }
        },
        error: function (data) {
        }
    });
}

function selNovaColuna(valor) {

    $("#pnlQtdColuna").css("display", "block");
    idProduto = $(valor).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectNewCols',
        dataType: 'json',
        data: "{'idProduto':'" + idProduto + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lst = data.d[0].split('@');
                $("#txtNumSerieColuna").val(lst[0]);
                $("#txtFabricanteColuna").val(lst[1]);
                $("#txtModeloColuna").val(lst[2]);
                $("#tbladcNewcols").css("display", "none");
                $("#divBtn_AddColunas").css("display", "none");
                $("#divTblSelColunaDesejada").css("display", "none");
                $("#divCadastroColunas").css("display", "block");
                $("#pnlColunas").css("display", "none");
                $("#btnSalvarColuna").val("Salvar");
                $("#btnExcluirColuna").css("display", "none");
            }
        },
        error: function (data) {
        }
    });
}

function salvarColuna(value) {

    var nmrPat = $("#txtNumPatrimonioColuna").val();

    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            document.getElementById("lblProdNpatrimonio").innerHTML = "Coluna";
            document.getElementById("lblProdNpatrimonio").title = "Coluna";
            $("#mpMensagem").modal("show");
            return;
        }
    }
    else {
        document.getElementById("txtNumPatrimonioColuna").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatrimonioColuna").style.placeholder = "";
    }

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','nmrPatrimonio':'" + nmrPat + "','idPatrimonio':'" + idPatrimonio + "','value':'" + value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                alert("Esse número de patrimonio já está vinculado a um produto!");
                return;
            }
            else {
                if (value != "Salvar") {
                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/EditCols',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','NumeroPatrimonio':'" + nmrPat +
                            "','idPatrimonio':'" + idPatrimonio + "','idProduto':'" + idProduto +
                            "','DataGarantia':'" + $("#txtDataGarantiaColuna").val() + "','DataInstalacao':'" + $("#txtDataInstalacaoColuna").val() +
                            "','Fixacao':'" + $("#sleFixacaoColuna").val() + "','EstadoOperacional':'" + $("#sleEstadoOperacionalColuna").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            FindDNA();

                        },
                        error: function (data) {
                        }
                    });
                }
                else {
                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/SaveCols',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','NumeroPatrimonio':'" + nmrPat +
                            "','idPatrimonio':'" + idPatrimonio + "','idProduto':'" + idProduto + "','quantidade':'" + $("#txtQuantidadeColuna").val() +
                            "','DataGarantia':'" + $("#txtDataGarantiaColuna").val() + "','Fabricante':'" + $("#txtFabricanteColuna").val() +
                            "','IdDepartamento':'" + idDepartamento + "','idSubDivisao':'" + $("#hfIdSub").val() +
                            "','modelo':'" + $("#txtModeloColuna").val() +
                            "','Fixacao':'" + $("#sleFixacaoColuna").val() + "','DataInstalacao':'" + $("#txtDataInstalacaoColuna").val() +
                            "','EstadoOperacional':'" + $("#sleEstadoOperacionalColuna").val() + "','idLocal':'" + document.getElementById("hfIdDna").value +
                            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d != "") {
                                var lst = data.d.split('@');
                                alert(lst[0]);
                                return;
                            }
                            FindDNA();

                        },
                        error: function (data) {
                        }
                    });
                }
            }
        },
        error: function (data) {
        }
    });
}

function excluirColuna() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ApagarColuna',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','quantidade':'" + $("#txtQuantidadeColuna").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
        },
        error: function (data) {
        }
    });
}

function selColuna(valor) {

    $("#pnlQtdColuna").css("display", "none");
    idPatrimonio = $(valor).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectColuna',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#btnSalvarColuna").val("Salvar Alterações");
            if (data.d != "") {
                var lst = data.d[0].split('@');
                $("#txtNumPatrimonioColuna").val(lst[0]);
                $("#txtFabricanteColuna").val(lst[1]);
                $("#txtNumSerieColuna").val(lst[2]);
                $("#txtDataGarantiaColuna").val(lst[3]);
                $("#txtDataInstalacaoColuna").val(lst[4]);
                idProduto = lst[5];
                $("#txtModeloColuna").val(lst[6]);
                $("#sleEstadoOperacionalColuna").val(lst[7]);
                $("#sleFixacaoColuna").val(lst[8]);
                idPatrimonio = lst[9];
                $("#tbladcNewcols").css("display", "none");
                $("#divBtn_AddColunas").css("display", "none");
                $("#divTblSelColunaDesejada").css("display", "none");
                $("#divCadastroColunas").css("display", "block");
                $("#pnlColunas").css("display", "none");
                $("#btnExcluirColuna").css("display", "block");
            }
        },
        error: function (data) {
        }
    });
}

//function AdcCabo() {
//    $("#tblAdcCabo").css("display", "none");
//    $("#divBtn_AddCabos").css("display", "block");
//    $("#pnlGrdAdcCabo").css("display", "none");
//    $("#divCadastroCabos").css("display", "none");
//    $("#pnlCabos").css("display", "none");
//}

function cancelarCabo() {

    FindDNA();
}

function implantacaoCabos() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoCabo',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#tblSelCaboDesejado").css("display", "block");
                $("#tbSelCaboDesejado").empty();

                $("#tblAdcCabo").css("display", "none");
                $("#divBtn_AddCabos").css("display", "none");
                $("#pnlGrdAdcCabo").css("display", "block");
                $("#divCadastroCabos").css("display", "none");
                $("#divPesq_Cabos_Cadastrados").css("display", "none");
                $("#divTblCabosCadastrados").css("display", "block");

                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[1] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[2] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[3] + "</td>";
                    cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;"> <a style="cursor:pointer;color:#0174DF;" onclick="selNovoCabo(this)" data-id="' + lst[0] + '">Selecionar</a></td>';

                    i++;
                    newRow.append(cols);
                    $("#tblSelCaboDesejado").append(newRow);
                }

            }
        },
        error: function (data) {
        }
    });
}

function selNovoCabo(valor) {

    $("#pnlQtdCabo").css("display", "block");
    $("#btnExcluirCabo").css("display", "none");
    idProduto = $(valor).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectNewCabo',
        dataType: 'json',
        data: "{'idProduto':'" + idProduto + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lst = data.d[0].split('@');

                $("#txtNumSerieCabos").val(lst[0]);
                $("#txtFabricanteCabos").val(lst[1]);
                $("#txtModeloCabos").val(lst[2]);

                $("#tblAdcCabo").css("display", "none");
                $("#divBtn_AddCabos").css("display", "none");
                $("#pnlGrdAdcCabo").css("display", "none");
                $("#divCadastroCabos").css("display", "block");
                $("#divPesq_Cabos_Cadastrados").css("display", "none");
                $("#divTblCabosCadastrados").css("display", "block");
                $("#btnSalvarCabo").val("Salvar");
            }
        },
        error: function (data) {
        }
    });
}

function salvarCabo(value) {

    var nmrPat = $("#txtNumPatrimonioCabos").val();

    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            document.getElementById("lblProdNpatrimonio").innerHTML = "Cabos";
            document.getElementById("lblProdNpatrimonio").title = "Cabos";
            $("#mpMensagem").modal("show");
            return;
        }
    }
    else {
        document.getElementById("txtNumPatrimonioCabos").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatrimonioCabos").style.placeholder = "";
    }

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','nmrPatrimonio':'" + nmrPat + "','idPatrimonio':'" + idPatrimonio + "','value':'" + value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                alert("Esse número de patrimonio já está vinculado a um produto!");
                return;
            }
            else {
                $.ajax({
                    type: 'POST',
                    url: '../../WebServices/Materiais.asmx/SaveCabos',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','NumeroPatrimonio':'" + nmrPat +
                        "','idPatrimonio':'" + idPatrimonio + "','idProduto':'" + idProduto + "','quantidade':'" + $("#txtQtdCabo").val() +
                        "','DataGarantia':'" + $("#txtDataGarantiaCabos").val() + "','Fabricante':'" + $("#txtFabricanteCabos").val() +
                        "','idDepartamento':'" + idDepartamento + "','idSubDivisao':'" + $("#hfIdSub").val() +
                        "','modelo':'" + $("#txtModeloCabos").val() + "','QtdUni':'" + $("#txtMetrosCabos").val() +
                        "','DataInstalacao':'" + $("#txtDataInstalacaoCabos").val() +
                        "','EstadoOperacional':'" + $("#sleEstadoOperacionalCabos").val() +
                        "','TipoInstalacao':'" + $("#sleTipoInstalacaoCabos").val() + "','MeioInstalacao':'" + $("#sleMeioInstalacaoCabos").val() +
                        "','value':'" + value + ",'idLocal':'" + document.getElementById("hfIdDna").value +
                        "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "', " +
                        " 'descricao':'" + $("#sleEstadoOperacionalCabos").val() + "' '}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        FindDNA();
                    },
                    error: function (data) {
                    }
                });
            }
        },
        error: function (data) {
        }
    });

}

function excluirCabo() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ApagarCabos',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','quantidade':'" + $("#txtQtdCabo").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
        },
        error: function (data) {
        }
    });
}

function selCaboCadastrado(valor) {

    $("#pnlQtdCabo").css("display", "none");
    $("#btnExcluirCabo").css("display", "block");
    idPatrimonio = $(valor).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectCabo',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#btnSalvarCabo").val("Salvar Alterações");
            if (data.d != "") {
                var lst = data.d[0].split('@');
                $("#txtNumSerieCabos").val(lst[0]);
                $("#txtFabricanteCabos").val(lst[1]);
                $("#txtModeloCabos").val(lst[2]);
                idProduto = lst[3];
                $("#txtDataInstalacaoCabos").val(lst[4]);
                $("#txtDataGarantiaCabos").val(lst[5]);
                $("#txtNumPatrimonioCabos").val(lst[6]);
                idPatrimonio = lst[7];
                $("#sleTipoInstalacaoCabos").val(lst[8]);
                $("#sleMeioInstalacaoCabos").val(lst[9]);
                $("#txtMetrosCabos").val(lst[10]);
                $("#sleEstadoOperacionalCabos").val(lst[11]);
                $("#txtDescricaoCabos").val(lst[12]);

                $("#tblAdcCabo").css("display", "none");
                $("#divBtn_AddCabos").css("display", "none");
                $("#pnlGrdAdcCabo").css("display", "none");
                $("#divCadastroCabos").css("display", "block");
                $("#divPesq_Cabos_Cadastrados").css("display", "none");
                $("#divTblCabosCadastrados").css("display", "block");
            }
        },
        error: function (data) {
        }
    });
}

//function AdcGrupoFocal() {
//    $("#tblAdcGf").css("display", "none");
//    $("#divBtn_AddGrupoFocal").css("display", "block");
//    $("#divTbl_SelGrupoFocalDesejado").css("display", "none");
//    $("#divCadastro_GrupoFocal").css("display", "none");
//    $("#pnlGrupoFocal").css("display", "none");
//}

function cancelarGrupoFocal() {

    FindDNA();
}

function implantacaoGrupoFocal() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoGF',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#tblSelGrupoFocalDesejaUtilizar").css("display", "block");
                $("#tbSelGrupoFocalDesejaUtilizar").empty();

                $("#tblAdcGf").css("display", "none");
                $("#divBtn_AddGrupoFocal").css("display", "none");
                $("#divTbl_SelGrupoFocalDesejado").css("display", "block");
                $("#divCadastro_GrupoFocal").css("display", "none");
                $("#pnlGrupoFocal").css("display", "none");

                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[1] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[2] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[3] + "</td>";
                    cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;"> <a style="cursor:pointer;color:#0174DF;" onclick="selNovoGrupoFocal(this)" data-id="' + lst[0] + '">Selecionar</a></td>';

                    i++;
                    newRow.append(cols);
                    $("#tblSelGrupoFocalDesejaUtilizar").append(newRow);
                }

            }
        },
        error: function (data) {
        }
    });
}

function selNovoGrupoFocal(valor) {

    $("#pnlQtdGF").css("display", "block");
    $("#btnExcluirGrupoFocal").css("display", "none");
    idProduto = $(valor).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectNewGf',
        dataType: 'json',
        data: "{'idProduto':'" + idProduto + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lst = data.d[0].split('@');

                $("#txtNumSerieGrupoFocal").val(lst[0]);
                $("#txtFabricanteGrupoFocal").val(lst[1]);
                $("#txtModeloGrupoFocal").val(lst[2]);

                $("#tblAdcGf").css("display", "none");
                $("#divBtn_AddGrupoFocal").css("display", "none");
                $("#divTbl_SelGrupoFocalDesejado").css("display", "none");
                $("#divCadastro_GrupoFocal").css("display", "block");
                $("#pnlGrupoFocal").css("display", "none");
                $("#btnSalvarGrupoFocal").val("Salvar");
            }
        },
        error: function (data) {
        }
    });
}

function salvarGrupoFocal(value) {
    var nmrPat = $("#txtNumPatrimonioGrupoFocal").val();

    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            document.getElementById("lblProdNpatrimonio").innerHTML = "Grupo Focal";
            document.getElementById("lblProdNpatrimonio").title = "Grupo Focal";
            $("#mpMensagem").modal("show");
            return;
        }
    }
    else {
        document.getElementById("txtNumPatrimonioGrupoFocal").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatrimonioGrupoFocal").style.placeholder = "";
    }

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','nmrPatrimonio':'" + nmrPat + "','idPatrimonio':'" + idPatrimonio + "','value':'" + value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                alert("Esse número de patrimonio já está vinculado a um produto!");
                return;
            }
            else {
                $.ajax({
                    type: 'POST',
                    url: '../../WebServices/Materiais.asmx/EditGrupoFocal',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','NumeroPatrimonio':'" + nmrPat +
                        "','idPatrimonio':'" + idPatrimonio + "','idProduto':'" + idProduto + "','quantidade':'" + $("#txtQuantidadeGrupoFocal").val() +
                        "','DataGarantia':'" + $("#txtDataGarantiaGrupoFocal").val() + "','Fabricante':'" + $("#txtFabricanteGrupoFocal").val() +
                        "','idDepartamento':'" + idDepartamento + "','idSubDivisao':'" + $("#hfIdSub").val() +
                        "','modelo':'" + $("#txtModeloGrupoFocal").val() +
                        "','DataInstalacao':'" + $("#txtDataInstalacaoGrupoFocal").val() +
                        "','EstadoOperacional':'" + $("#sleEstadoOperacionalGrupoFocal").val() + "','value':'" + value + "','idLocal':'" + document.getElementById("hfIdDna").value +
                        "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {
                            var lst = data.d[0].split('@');
                            alert(lst[0]);
                            return;
                        }
                        else {
                            FindDNA();
                        }

                    },
                    error: function (data) {
                    }
                });
            }
        },
        error: function (data) {
        }
    });

}

function excluirGrupoFocal() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ApagarGrupoFocal',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','quantidade':'" + $("#txtQuantidadeGrupoFocal").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
        },
        error: function (data) {
        }
    });
}

function selGrupoFocal(valor) {

    $("#pnlQtdGF").css("display", "none");
    $("#btnExcluirGrupoFocal").css("display", "block");
    idPatrimonio = $(valor).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectGrupoFocal',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#btnSalvarGrupoFocal").val("Salvar Alterações");
            if (data.d != "") {
                var lst = data.d[0].split('@');
                $("#txtModeloGrupoFocal").val(lst[0]);
                $("#txtFabricanteGrupoFocal").val(lst[1]);
                $("#sleEstadoOperacionalGrupoFocal").val(lst[2]);
                $("#txtNumPatrimonioGrupoFocal").val(lst[3]);
                idProduto = lst[4];
                $("#txtDataGarantiaGrupoFocal").val(lst[5]);
                $("#txtDataInstalacaoGrupoFocal").val(lst[6]);
                idPatrimonio = lst[7];

                $("#tblAdcGf").css("display", "none");
                $("#divBtn_AddGrupoFocal").css("display", "none");
                $("#divTbl_SelGrupoFocalDesejado").css("display", "none");
                $("#divCadastro_GrupoFocal").css("display", "block");
                $("#pnlGrupoFocal").css("display", "none");
                $("#btnSalvarGrupoFocal").val("Salvar Alterações");
            }
        },
        error: function (data) {
        }
    });
}

//function AdcIluminacao() {
//    $("#tblAdcIlu").css("display", "none");
//    $("#divAdd_SistemaIluminacao").css("display", "block");
//    $("#divTbl_SelSistemaIluminacao").css("display", "none");
//    $("#divCadastro_SistemaIluminacao").css("display", "none");
//    $("#pnlIluminacao").css("display", "none");
//}

function CancelSistemaIlu() {

    FindDNA();
}

function implantacaoSistemaIluminacao() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoIlu',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#tblSelSistemaIluminacaoParaUtilizar").css("display", "block");
                $("#tbSelSistemaIluminacaoParaUtilizar").empty();

                $("#tblAdcIlu").css("display", "none");
                $("#divAdd_SistemaIluminacao").css("display", "none");
                $("#divTbl_SelSistemaIluminacao").css("display", "block");
                $("#divCadastro_SistemaIluminacao").css("display", "none");
                $("#pnlIluminacao").css("display", "none");

                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[1] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[2] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;'>" + lst[3] + "</td>";
                    cols += '<td style="border: 1px solid black; border-collapse: collapse; padding: 5px; color: #4CA2BF; width:20%;"> <a style="cursor:pointer;color:#0174DF;" onclick="selNovoSistemaIluminacao(this)" data-id="' + lst[0] + '">Selecionar</a></td>';

                    i++;
                    newRow.append(cols);
                    $("#tblSelSistemaIluminacaoParaUtilizar").append(newRow);
                }

            }
        },
        error: function (data) {
        }
    });
}

function selNovoSistemaIluminacao(valor) {

    $("#pnlQtdIlu").css("display", "block");
    $("#btnExcluirSistemaIluminacao").css("display", "none");
    idProduto = $(valor).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectNewIlu',
        dataType: 'json',
        data: "{'idProduto':'" + idProduto + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lst = data.d[0].split('@');

                $("#txtNumSerie_S_Iluminacao").val(lst[0]);
                $("#txtFabricante_S_Iluminacao").val(lst[1]);
                $("#txtModelo_S_Iluminacao").val(lst[2]);

                $("#tblAdcIlu").css("display", "none");
                $("#divAdd_SistemaIluminacao").css("display", "none");
                $("#divTbl_SelSistemaIluminacao").css("display", "none");
                $("#divCadastro_SistemaIluminacao").css("display", "block");
                $("#pnlIluminacao").css("display", "none");
                $("#btnSalvarSistemaIluminacao").val("Salvar");
            }
        },
        error: function (data) {
        }
    });
}

function salvarSistemaIluminacao(value) {

    var nmrPat = $("#txtNumPatrimonio_S_Iluminacao").val();

    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            document.getElementById("lblProdNpatrimonio").innerHTML = "Sistema de Iluminação";
            document.getElementById("lblProdNpatrimonio").title = "Sistema de Iluminação";
            $("#mpMensagem").modal("show");
            return;
        }
    }
    else {
        document.getElementById("txtNumPatrimonio_S_Iluminacao").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatrimonio_S_Iluminacao").style.placeholder = "";
    }

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','nmrPatrimonio':'" + nmrPat + "','idPatrimonio':'" + idPatrimonio + "','value':'" + value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                alert("Esse número de patrimonio já está vinculado a um produto!");
                return;
            }
            else {
                $.ajax({
                    type: 'POST',
                    url: '../../WebServices/Materiais.asmx/SalvarIlu',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','NumeroPatrimonio':'" + nmrPat +
                        "','idPatrimonio':'" + idPatrimonio + "','idProduto':'" + idProduto + "','quantidade':'" + $("#txtQuantidade_S_Iluminacao").val() +
                        "','DataGarantia':'" + $("#txtDataGarantia_S_Iluminacao").val() + "','Fabricante':'" + $("#txtFabricante_S_Iluminacao").val() +
                        "','idDepartamento':'" + idDepartamento + "','idSubDivisao':'" + $("#hfIdSub").val() +
                        "','modelo':'" + $("#txtModelo_S_Iluminacao").val() +
                        "','DataInstalacao':'" + $("#txtDataInstalacao_S_Iluminacao").val() +
                        "','EstadoOperacional':'" + $("#ddlIluAtivo").val() + "','TensaoInstalada':'" + $("#sleTensaoInstalada_S_Iluminacao").val() + "','value':'" + value +
                        "','idOcorrencia':'" + $("#hfIdOcorrencia").val() + "','idDnaGSS':'" + $("#hfIdDnaGSS").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {
                            var lst = data.d[0].split('@');
                            alert(lst[0]);
                            return;
                        }
                        else {
                            FindDNA();
                        }

                    },
                    error: function (data) {
                    }
                });
            }
        },
        error: function (data) {
        }
    });

}

function excluirSistemaIluminacao() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ApagarSistemaIlu',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
            " 'quantidade':'" + $("#txtQuantidade_S_Iluminacao").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value +
            "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
        },
        error: function (data) {
        }
    });
}

function selSistemaIluminacao(valor) {

    $("#pnlQtdIlu").css("display", "none");
    $("#btnExcluirSistemaIluminacao").css("display", "block");
    idPatrimonio = $(valor).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectIlum',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#btnSalvarSistemaIluminacao").val("Salvar Alterações");
            if (data.d != "") {
                var lst = data.d[0].split('@');
                idPatrimonio = lst[0];
                $("#txtNumSerie_S_Iluminacao").val(lst[1]);
                $("#txtFabricante_S_Iluminacao").val(lst[2]);
                $("#txtModelo_S_Iluminacao").val(lst[3]);
                $("#txtDataInstalacao_S_Iluminacao").val(lst[4]);
                $("#txtDataGarantia_S_Iluminacao").val(lst[5]);
                $("#txtNumPatrimonio_S_Iluminacao").val(lst[6]);
                $("#ddlIluAtivo").val(lst[7]);
                $("#sleTensaoInstalada_S_Iluminacao").val(lst[8]);

                $("#tblAdcIlu").css("display", "none");
                $("#divAdd_SistemaIluminacao").css("display", "none");
                $("#divTbl_SelSistemaIluminacao").css("display", "none");
                $("#divCadastro_SistemaIluminacao").css("display", "block");
                $("#pnlIluminacao").css("display", "none");
            }
        },
        error: function (data) {
        }
    });
}

//function AdcAcess() {
//    $("#tblNewAcess").css("display", "none");
//    $("#divBtn_AddAcessorios").css("display", "block");
//    $("#divTbl_AcessorioDesejado").css("display", "none");
//    $("#divCadastro_Acessorio").css("display", "none");
//    $("#pnlAcessorios").css("display", "none");
//}

function cancelarAcessorio() {

    FindDNA();
}

function implantacaoAcessorios() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoAcess',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#tblSelAcessorioParaUtilizar").css("display", "block");
                $("#tbSelAcessorioParaUtilizar").empty();

                $("#tblNewAcess").css("display", "none");
                $("#divBtn_AddAcessorios").css("display", "none");
                $("#divTbl_AcessorioDesejado").css("display", "block");
                $("#divCadastro_Acessorio").css("display", "none");
                $("#pnlAcessorios").css("display", "none");

                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                        " color: #4CA2BF; width:20%;'>" + lst[1] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                        " color: #4CA2BF; width:20%;'>" + lst[2] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                        " color: #4CA2BF; width:20%;'>" + lst[3] + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                        " color: #4CA2BF; width:20%;'> <a style='cursor:pointer;color:#0174DF;' " +
                        " onclick='selNovoAcessorio(this)' data-id='" + lst[0] + "'>Selecionar</a></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblSelAcessorioParaUtilizar").append(newRow);
                }
            }
        },
        error: function (data) {
        }
    });
}

function selNovoAcessorio(valor) {

    $("#pnlQtdAcess").css("display", "block");
    $("#btnExcluirAcessorio").css("display", "none");
    idProduto = $(valor).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectNewAcess',
        dataType: 'json',
        data: "{'idProduto':'" + idProduto + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lst = data.d[0].split('@');

                $("#txtNumSerieAcessorio").val(lst[0]);
                $("#txtFabricanteAcessorio").val(lst[1]);
                $("#txtNomeAcessorio").val(lst[2]);

                $("#tblNewAcess").css("display", "none");
                $("#divBtn_AddAcessorios").css("display", "none");
                $("#divTbl_AcessorioDesejado").css("display", "none");
                $("#divCadastro_Acessorio").css("display", "block");
                $("#pnlAcessorios").css("display", "none");
                $("#btnSalvarAcessorio").val("Salvar");
            }
        },
        error: function (data) {
        }
    });
}

function salvarAcessorio(value) {

    var nmrPat = $("#txtNumPatrimonioAcessorio").val();
    if (nmrPat == "") {

        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            $("#mpMensagem").modal("show");
            document.getElementById("lblProdNpatrimonio").innerHTML = "Acessórios";
            document.getElementById("lblProdNpatrimonio").title = "Acessórios";
            return;
        }

    }
    else {
        document.getElementById("txtNumPatrimonioAcessorio").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatrimonioAcessorio").style.placeholder = "";
    }

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','nmrPatrimonio':'" + nmrPat + "','idPatrimonio':'" + idPatrimonio + "','value':'" + value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                alert("Esse número de patrimonio já está vinculado a um produto!");
                return;
            }
            else {
                $.ajax({
                    type: 'POST',
                    url: '../../WebServices/Materiais.asmx/AdicionarAcessorio',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','NumeroPatrimonio':'" + nmrPat +
                        "','idPatrimonio':'" + idPatrimonio + "','idProduto':'" + idProduto + "','quantidade':'" + $("#txtQtdAcess").val() +
                        "','Fabricante':'" + $("#txtFabricanteAcessorio").val() +
                        "','idDepartamento':'" + idDepartamento + "','idSubDivisao':'" + $("#hfIdSub").val() +
                        "','DataInstalacao':'" + $("#txtDataInstalacaoAcessorio").val() +
                        "','Fixacao':'" + $("#sleFixacaoAcessorio").val() +
                        "','value':'" + value + "','idLocal':'" + document.getElementById("hfIdDna").value +
                        "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value +
                        "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "") {
                            var lst = data.d[0].split('@');
                            alert(lst[0]);
                            return;
                        }
                        else {
                            FindDNA();
                        }
                    },
                    error: function (data) {
                    }
                });
            }
        },
        error: function (data) {
        }
    });
}

function excluirAcessorio() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/DeleteAcessorios',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
            " 'quantidade':'" + $("#txtQtdAcess").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value +
            "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
        },
        error: function (data) {
        }
    });
}

function selAcessorio(valor) {

    $("#pnlQtdAcess").css("display", "none");
    $("#btnExcluirAcessorio").css("display", "block");
    idPatrimonio = $(valor).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectAcessorio',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#btnSalvarAcessorio").val("Salvar Alterações");
            if (data.d != "") {
                var lst = data.d[0].split('@');
                idPatrimonio = lst[0];
                $("#txtNumSerieAcessorio").val(lst[1]);
                $("#txtFabricanteAcessorio").val(lst[2]);
                $("#txtDataInstalacaoAcessorio").val(lst[3]);
                $("#txtNomeAcessorio").val(lst[4]);
                $("#txtNumPatrimonioAcessorio").val(lst[5]);
                $("#sleFixacaoAcessorio").val(lst[6]);


                $("#tblNewAcess").css("display", "none");
                $("#divBtn_AddAcessorios").css("display", "none");
                $("#divTbl_AcessorioDesejado").css("display", "none");
                $("#divCadastro_Acessorio").css("display", "block");
                $("#pnlAcessorios").css("display", "none");
            }
        },
        error: function (data) {
        }
    });
}

function findTag() {

    var idPrefeitura = document.getElementById("hfIdPrefeitura").value;
    var idsubdivisao = document.getElementById("hfIdSub").value;
    $("#btnAddNovaEtiqueta").css("display", "block");
    $("#imgPesquisar").css("display", "block");
    //document.getElementById("btnSaveTag").value = "Confirmar";
    //document.getElementById("btnSaveTag").style.visibility = "hidden";
    //document.getElementById("btnVoltar").style.visibility = "hidden";
    var EPC = document.getElementById("txtEpc").value;
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/findTag',
        dataType: 'json',
        data: "{'EPC':'" + EPC + "','idPrefeitura':'" + idPrefeitura + "','idsubdivisao':'" + idsubdivisao + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d.toString() != "") {
                var i = 0;
                $("#tblEtiquetasCadastradas").css("display", "block");
                $("#tbEtiquetasCadastradas").css("display", "block");
                //$("#tfTag").css("display", "none");
                $("#tbEtiquetasCadastradas").empty();
                while (data.d[i]) {

                    var lst = data.d[i].split('@');
                    var Id = lst[0];
                    var EPC = lst[1];

                    var newRow = $("<tr>");
                    var cols = "";

                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                        " color: #4CA2BF; width:150px;'>" + EPC + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                        " color: #4CA2BF; width:150px;'> <a style='cursor:pointer;color:#0174DF;' " +
                        " onclick='modalAddEpc()' data-id='" + Id + "' data-epc='" + EPC + "'>Editar</a></td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                        " color: #4CA2BF; width:150px;'> <a style='cursor:pointer;color:#0174DF;' " +
                        " onclick='excluirEPC(this)' data-id='" + Id + "'>Excluir</a></td>";

                    newRow.append(cols);
                    $("#tblEtiquetasCadastradas").append(newRow);
                    i++
                }
            }
            else {

                $("#tblEtiquetasCadastradas").css("display", "block");
                $("#thEtiquetasCadastradas").css("display", "block");
                //$("#tfTag").css("display", "block");
                $("#tbEtiquetasCadastradas").css("display", "none");
                $("#tbEtiquetasCadastradas").empty();
            }

            document.getElementById("txtEpc").value = "";
            //document.getElementById("btnSaveTag").value = "Confirmar";
        },
        error: function (data) {
        }
    });
}

function salvarNovaTag() {

    var idPrefeitura = document.getElementById("hfIdPrefeitura").value;
    var idsubdivisao = document.getElementById("hfIdSub").value;
    var EPC = document.getElementById("txtEpc").value;
    if (EPC == "") {
        document.getElementById("txtEpc").style.borderColor = 'red';
        document.getElementById("txtEpc").placeholder = 'Campo obrigatorio!';
        return;
    }
    else {
        document.getElementById("txtEpc").style.borderColor = 'rgb(169, 169, 169)';
    }
    if (document.getElementById("btnSalvarEpc").value == "Salvar") {
        $.ajax({
            type: 'POST',
            url: '../../WebServices/Materiais.asmx/InsertTag',
            dataType: 'json',
            data: "{'EPC':'" + EPC + "','idPrefeitura':'" + idPrefeitura + "','idsubdivisao':'" + idsubdivisao + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d == "REPETIDO") {
                    alert("Esta Etiqueta já está cadastrada para esse cruzamento!");
                    return;
                }
                document.getElementById("txtEpc").value = "";
                findTag();
            },
            error: function (data) {
            }
        });
    }
    else {
        var Id = document.getElementById("hdfIdTag").value;
        $.ajax({
            type: 'POST',
            url: '../../WebServices/Materiais.asmx/EditTag',
            dataType: 'json',
            data: "{'EPC':'" + EPC + "','Id':'" + Id + "','idsubdivisao':'" + idsubdivisao + "', " +
                " 'idPrefeitura':'" + idPrefeitura + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d == "REPETIDO") {
                    alert("Esta Etiqueta já está cadastrada para esse cruzamento!");
                    return;
                }
                document.getElementById("txtEpc").value = "";
                findTag();
            },
            error: function (data) {
            }
        });
    }
}

//function EditEPC(value) {

//    document.getElementById("btnSalvarEpc").value = "Salvar alteraçōes";
//    $("#btnAddNovaEtiqueta").css("display", "none");
//    $("#imgPesquisar").css("display", "none");
//    //document.getElementById("btnSaveTag").style.visibility = "visible";
//    document.getElementById("btnVoltar").style.visibility = "visible";
//    document.getElementById("hdfIdTag").value = $(value).data("id");
//    document.getElementById("txtEpc").value = $(value).data("epc");

//}

function excluirEPC(value) {

    var IdTag = $(value).data("id");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/DeleteTag',
        dataType: 'json',
        data: "{'Id':'" + IdTag + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            document.getElementById("txtEpc").value = "";
            findTag();
        },
        error: function (data) {
        }
    });
}

function voltar() {

    document.getElementById("txtEpcEtiquetas").value = "";
    findTag();
}

//function cadastrarNovaTag() {

//    document.getElementById("btnSaveTag").style.visibility = "visible";
//    document.getElementById("btnVoltar").style.visibility = "visible";
//    $("#btnAddNovaEtiqueta").css("display", "none");
//    $("#imgPesquisar").css("display", "none");
//    document.getElementById("btnSaveTag").value = "Confirmar";
//    document.getElementById("txtEpc").value = "";
//}

function FindNmrPatMov() {

    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;
    document.getElementById("divAlmoxarifado").style.display = "none";
    $("#tblSelAlmoxarifado1").css("display", "none");

    var idSubMov = $("#hfIdSubMov").val();
    var text = $("#txtNumPatrimonio1").val();
    var Prod = document.getElementById("lblProduto1").innerHTML;
    $("#tblDadosProd").css("display", "none");
    var dataSub = [];
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/FindNmrPatMov',
        dataType: 'json',
        data: "{'idPrefeitura':'" + IdPrefeitura + "','text':'" + text + "','idSub':'" + idSubMov + "', " +
            " 'Prod':'" + Prod + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var dados = data.d;


            var qtd = 1;
            if (dados.length == 0) {
                alert("Produto não encontrado!");
                $("#divSubdivisaoManutencao").css("display", "none");

            }
            else {
                $("#tbSelControladorDesejado1").empty();
                $("#tblSelSubdivisaoManutencao1").css("display", "block");
                //$("#divScroll").css("display", "block");
                $("#divSubdivisaoManutencao").css("display", "block");
            }

            $.each(dados, function (index, dados) {
                var newRow = $("<tr>");
                var cols = "";
                $("#btnSalvarMovimentacao1").css("display", "block");
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                    " display:none'>" + dados.idPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.Produto + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.NmrPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.Subdivisao + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.Endereco + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " ><input type='checkbox' id='chk' \></td>";

                dataSub.push({
                    id: dados.idPatrimonio,
                    nome: dados.Produto,
                    nmrPat: dados.NmrPatrimonio
                });

                newRow.append(cols);
                $("#tblSelSubdivisaoManutencao1").append(newRow);
                qtd++;
            });

        },
        error: function (response) {
        }
    });
}

function FindSubdivisaoMov() {
    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;
    document.getElementById("divAlmoxarifado").style.display = "none";
    $("#tblSelAlmoxarifado1").css("display", "none");

    var idSubMov = $("#hfIdSubMov").val();
    var text = $("#txtIdLocal1").val();
    var Prod = document.getElementById("lblProduto1").innerHTML;
    $("#tblDadosProd").css("display", "none");
    var dataSub = [];
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/FindSubdivisaoMov',
        dataType: 'json',
        data: "{'idPrefeitura':'" + IdPrefeitura + "','text':'" + text + "','idSub':'" + idSubMov + "', " +
            " 'Prod':'" + Prod + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var dados = data.d;


            var qtd = 1;
            if (dados.length == 0) {
                alert("Produto não encontrado!");
                $("#divSubdivisaoManutencao").css("display", "none");

            }
            else {
                $("#tbSelControladorDesejado1").empty();
                $("#tblSelSubdivisaoManutencao1").css("display", "block");
                //$("#divScroll").css("display", "block");
                $("#divSubdivisaoManutencao").css("display", "block");
            }

            $.each(dados, function (index, dados) {
                var newRow = $("<tr>");
                var cols = "";
                $("#btnSalvarMovimentacao1").css("display", "block");
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                    " display:none'>" + dados.idPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.Produto + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.NmrPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.Subdivisao + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.Endereco + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " ><input type='checkbox' id='chk' \></td>";

                dataSub.push({
                    id: dados.idPatrimonio,
                    nome: dados.Produto,
                    nmrPat: dados.NmrPatrimonio
                });

                newRow.append(cols);
                $("#tblSelSubdivisaoManutencao1").append(newRow);
                qtd++;
            });
        },
        error: function (response) {
        }
    });
}

function ocultarTabelas() {

    document.getElementById("divAlmoxarifado").style.display = "none";
    $("#tblSelSubdivisaoManutencao1").css("display", "none");
    $("#tblSelAlmoxarifado1").css("display", "none");
    $("#tblSelSubdivisaoManutencao1").css("display", "none");
    $("#hfIdSubMov").val("");
    $("#hfIdPatMov").val("");
    $("#txtNumPatrimonio1").append();
    $("#btnSalvarMovimentacao1").css("display", "none");
    //$("#divScroll").css("display", "none");
    $("#tblDadosProd").css("display", "none");
    $("#hfIdPatMov").val("");
    $("#hfIdSubMov").val("");
}

function SalvarProd() {
    if ($("#lblProduto1").text() == "Controlador") {
        if ($("#sleFormaOperacional1").val() == "0") {
            alert("Selecione uma Forma Operacional!");
            $("#sleFormaOperacional1").css("border-color", "red");
            return false;
        }
        else {
            $("#sleFormaOperacional1").css("border-color", "");
        }
    }
    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;
    var table = $("#tblSelSubdivisaoManutencao1 tbody");
    var idSub = $("#hfIdSub").val();
    table.find('tr').each(function (i, el) {
        var $tds = $(this).find('td'),
            idPat = $tds.eq(0).text(),
            Subd = $tds.eq(3).text(),
            End = $tds.eq(4).text(),
            chk = $tds[5].childNodes[0].checked;
        var produto = document.getElementById("lblProduto1").innerHTML;
        if (chk == true) {
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/SalvarProd',
                dataType: "json",
                data: "{'idPrefeitura':'" + IdPrefeitura + "','idPat':'" + idPat + "', " +
                    " 'SubdivisaoMov':'" + Subd + "','EnderecoMov':'" + End + "', " +
                    " 'idSub':'" + idSub + "','produto':'" + produto + "', " +
                    " 'formaOperacional':'" + $("#sleFormaOperacional1").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#divSubdivisaoManutencao").css("display", "none");
                    $("#modalMov").modal("hide");
                    $("#txtNumPatrimonio1").val("");
                    FindDNA();
                },
                error: function (data) {
                    FindDNA();
                }
            });
        }
    });

    FindDNA();
}

function verificaQtd(valor) {

    var qtd = valor.value;
    var title = valor.title.toString();
    if (qtd > 1) {
        switch (title) {
            case "placa":
                $("#divBotoesImplantacao_Movimentacao").css("display", "block");
                break;
            case "coluna":
                $("#btnPorParamColuna").css("display", "block");
                break;
            case "cabo":
                $("#btnPorParamCabo").css("display", "block");
                break;
            case "gf":
                $("#btnPorParamGF").css("display", "block");
                break;
            case "iluminacao":
                $("#btnPorParamSI").css("display", "block");
                break;
            default: $("#btnPorParamAcess").css("display", "block");
        }
    }
    else {
        $("#divBotoesImplantacao_Movimentacao").css("display", "none");
        $("#btnPorParamColuna").css("display", "none");
        $("#btnPorParamCabo").css("display", "none");
        $("#btnPorParamGF").css("display", "none");
        $("#btnPorParamSI").css("display", "none");
        $("#btnPorParamAcess").css("display", "none");
    }
}

function porParametro(valor) {
    var title = valor.title.toString();
    document.getElementById("lblProdParam").innerHTML = title;
}

function SalvarPatParametro() {
    var produto = document.getElementById("lblProdParam").innerHTML;
    var quantidade = 0;
    switch (produto) {
        case "placa":
            quantidade = $("#txtQuantidadePlcControladorCad").val();
            break;
        case "coluna":
            quantidade = $("#txtQuantidadeColuna").val();
            break;
        case "cabo":
            quantidade = $("#txtQtdCabo").val();
            break;
        case "Grupo Focal":
            quantidade = $("#txtQuantidadeGrupoFocal").val();
            break;
        case "sistema de iluminação":
            quantidade = $("#txtQuantidade_S_Iluminacao").val();
            break;
        default: quantidade = $("#txtQtdAcess").val();
    }
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ValidNmrPatParametro',
        dataType: "json",
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
            " 'NumeroPatrimonio':'" + $("#txtNumPatInicial").val() + "', " +
            " 'quantidade':'" + quantidade + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lst = data.d[0].split('@');
                alert(lst[0]);
                return;
            }
            else {
                switch (produto) {
                    case "placa":
                        $("#txtNumPatrimonioPlcControladorCad").val($("#txtNumPatInicial").val());
                        break;
                    case "coluna":
                        $("#txtNumPatrimonioColuna").val($("#txtNumPatInicial").val());
                        break;
                    case "cabo":
                        $("#txtNumPatrimonioCabos").val($("#txtNumPatInicial").val());
                        break;
                    case "Grupo Focal":
                        $("#txtNumPatrimonioGrupoFocal").val($("#txtNumPatInicial").val());
                        break;
                    case "sistema de iluminação":
                        $("#txtNumPatrimonio_S_Iluminacao").val($("#txtNumPatInicial").val());
                        break;
                    default: $("#txtNumPatrimonioAcessorio").val($("#txtNumPatInicial").val());
                }
                $("#mpParametro").modal("hide");
            }
        },
        error: function (data) {
        }
    });
}

function Clear() {

    //document.getElementById("lblProdNpatrimonio").title = "";
    $("#txtNumSerieAcessorio").val("");
    $("#txtFabricanteAcessorio").val("");
    $("#txtDataInstalacaoAcessorio").val("");
    $("#txtNomeAcessorio").val("");
    $("#txtNumPatrimonioAcessorio").val("");
    $("#sleFixacaoAcessorio").val("");

    $("#txtNumSerie_S_Iluminacao").val("");
    $("#txtFabricante_S_Iluminacao").val("");
    $("#txtModelo_S_Iluminacao").val("");
    $("#txtDataInstalacao_S_Iluminacao").val("");
    $("#txtDataGarantia_S_Iluminacao").val("");
    $("#txtNumPatrimonio_S_Iluminacao").val("");
    $("#ddlIluAtivo").val("");
    $("#sleTensaoInstalada_S_Iluminacao").val("");

    $("#txtModeloGrupoFocal").val("");
    $("#txtFabricanteGrupoFocal").val("");
    $("#sleEstadoOperacionalGrupoFocal").val("");
    $("#txtNumPatrimonioGrupoFocal").val("");
    $("#txtDataGarantiaGrupoFocal").val("");
    $("#txtDataInstalacaoGrupoFocal").val("");

    $("#txtNumSerieCabos").val("");
    $("#txtFabricanteCabos").val("");
    $("#txtModeloCabos").val("");
    $("#txtDataInstalacaoCabos").val("");
    $("#txtDataGarantiaCabos").val("");
    $("#txtNumPatrimonioCabos").val("");
    $("#sleTipoInstalacaoCabos").val("");
    $("#sleMeioInstalacaoCabos").val("");
    $("#txtMetrosCabos").val("");
    $("#sleEstadoOperacionalCabos").val("");
    $("#txtDescricaoCabos").val("");

    $("#txtNumPatrimonioColuna").val("");
    $("#txtFabricanteColuna").val("");
    $("#txtNumSerieColuna").val("");
    $("#txtDataGarantiaColuna").val("");
    $("#txtDataInstalacaoColuna").val("");
    $("#txtModeloColuna").val("");
    $("#sleEstadoOperacionalColuna").val("");
    $("#sleFixacaoColuna").val("");

    $("#txtFabricanteGprsNbk").val("");
    $("#lblFabricanteGprsNobreak").val("");
    $("#txtNumPatrimonioGprsNobreak").val("");
    $("#lblNumPatrimonioGprsNobreak").val("");
    $("#txtNumLinhaGprsNobreak").val("");
    $("#txtDtGarantiaGprsNbk").val("");
    $("#txtDataInstalacaoGprsNobreak").val("");
    $("#txtModeloGprsNbk").val("");
    $("#lblModeloGprsNobreak").val("");
    $("#sleOperadoraGprsNobreak").val("");
    $("#sleEstadoOperacionalGprsNobreak").val("");

    $("#txtAutonomiaDadosNobreak").val("");
    $("#txtDataGarantiaDadosNobreak").val("");
    $("#txtFabricanteDadosNobreak").val("");
    $("#txtPotenciaDadosNobreak").val("");
    $("#txtModeloDadosNobreak").val("");
    $("#txtNumPatrimonioDadosNobreak").val("");
    $("#txtPotenciaDadosNobreak").val("");
    $("#sleEstadoOperacionalDadosNobreak").val("");
    $("#sleFixacaoDadosNobreak").val("");
    $("#sleMonitoracaoDadosNobreak").val("");

    $("#txtCapacidadeFaseSuportada").val("");
    $("#txtNomeProduto").val("");
    $("#sleFormaOperacionalCadastro").val("");
    $("#sleFixacao").val("");
    $("#txtNumSerie").val("");
    $("#txtNumPatrimonio").val("");
    $("#txtDataGarantia").val("");
    $("#txtDataInstalacao").val("");
    $("#txtFabricante").val("");
    $("#txtModelo").val("");
    $("#txtTipo").val("");
    $("#sleTensaoEntrada").val("");
    $("#sleTensaoSaida").val("");
    $("#txtCapacidadeFaseSuportada").val("");
    $("#txtCapacidadeFasesInstaladas").val("");
    $("#sleEstadoOperacional").val("");

    $("#txtFabricantePlcControladorCad").val("");
    $("#txtModeloPlcControladorCad").val("");
    $("#txtDataInstalacaoPlcControladorCad").val("");
    $("#txtDataGarantiaPlcControladorCad").val("");
    $("#txtNumPatrimonioPlcControladorCad").val("");
    $("#sleEstadoOperacionalPlcControladorCad").val("");

    $("#txtQuantidadePlcControladorCad").val("1");
    $("#txtQuantidadeColuna").val("1");
    $("#txtQtdCabo").val("1");
    $("#txtQuantidadeGrupoFocal").val("1");
    $("#txtQuantidade_S_Iluminacao").val("1");
    $("#txtQtdAcess").val("1");
}

function SalvarProdutoNPat() {

    var Produto = document.getElementById("lblProdNpatrimonio").innerHTML;
    $("#modalConfirmacaoNmrPatrimonio").modal("hide");
    switch (Produto) {
        case "Controlador":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            salvarDadosControlador($("#btnSalvar").val());
            break;

        case "Gprs Controlador":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            salvarGprsControlador($("#btnSalvarGPRS_Controlador").val());
            break;

        case "Placa Controlador":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            salvarPlacaControlador($("#btnSalvarPlcControladorCad").val());
            break;

        case "Nobreak":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            salvarDadosNobreak($("#btnSalvarDadosNobreak").val());
            break;

        case "Gprs Nobreak":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            salvarGprsNobreak($("#btnSalvarGprsNobreak").val());
            break;

        case "Coluna":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            salvarColuna($("#btnSalvarColuna").val());
            break;

        case "Cabos":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            salvarCabo($("#btnSalvarCabo").val());
            break;

        case "Grupo Focal":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            salvarGrupoFocal($("#btnSalvarGrupoFocal").val());
            break;

        case "Sistema de Iluminação":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            salvarSistemaIluminacao($("#btnSalvarSistemaIluminacao").val());
            break;

        default:
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            AdicionarAcessorio($("#btnSalvarAcessorio").val());
            break;
    }
}

function tblAlmoxarifado() {

    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;
    var Prod = document.getElementById("lblProduto1").innerHTML;
    var dataSub = [];
    $("#tblDadosProd").css("display", "none");
    $("#tblSelSubdivisaoManutencao1").css("display", "none");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/Almoxarifado',
        dataType: 'json',
        data: "{'idPrefeitura':'" + IdPrefeitura + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d.length == 0) {
                alert("Nenhum Almoxarifado encontrado!");
                document.getElementById("divAlmoxarifado").style.display = "none";
                $("#tblSelAlmoxarifado1").css("display", "none");
                $("#divSubdivisaoManutencao").css("display", "none");
                return false;

            }
            /*if (data.d.length == 1) {
                var dados = data.d[0];
 
                $("#tblDadosSub").css("display", "block");
                $("spnIdLocal").append();
                $("spnEndereco").append();
                document.getElementById("spnIdLocal").innerHTML = dados.Subdivisao;
                document.getElementById("spnEndereco").innerHTML = dados.Endereco;
                $("#hfIdSubMov").val(dados.idSub);
                document.getElementById("divSelAlmoxarifado").style.display = "none";
 
                $.ajax({
                    type: 'POST',
                    url: '../../WebServices/Materiais.asmx/ProcurarProdutoSub',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + IdPrefeitura + "','idSub':'" + dados.idSub + "','Prod':'" + Prod + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var dados = data.d;
 
 
                        var qtd = 1;
                        if (dados.length == 0) {
                            alert("Nenhum Produto encontrado nesse Almoxarifado!");
                            $("#divtblMov").css("display", "none");
                        }
                        else {
                            $("#tbGrdProdutos").empty();
                            $("#tblGrdProdutos").css("display", "block");
                            $("#divScroll").css("display", "block");
                            $("#divtblMov").css("display", "block");
                        }
 
                        $.each(dados, function (index, dados) {
                            var newRow = $("<tr>");
                            var cols = "";
                            if (Prod == "Placa" || Prod == "Coluna" || Prod == "Cabo" || Prod == "Grupo Focal" || Prod == "Sistema de Iluminação" || Prod == "Acessorio") {
                                $("#btnSalvarProd").css("display", "block");
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;display:none'>" + dados.idPatrimonio + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Produto + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.NmrPatrimonio + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Subdivisao + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Endereco + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'><input type='checkbox' id='chk' \"></td>";
                            }
                            else {
                                $("#btnSalvarProd").css("display", "none");
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;display:none'>" + dados.idPatrimonio + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Produto + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.NmrPatrimonio + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Subdivisao + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Endereco + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'><label onClick=\"SelecionarProdMov('" + dados.idPatrimonio + "','" + dados.idSub + "','" + dados.Produto + "','" + dados.NmrPatrimonio + "','" + dados.Subdivisao + "','" + dados.Endereco + "');\" style='cursor:pointer;font-size:15px;margin-bottom:0px;font-weight:100;color:#23527c;'>Selecionar</label></td>";
 
                            }
 
 
                            dataSub.push({
                                id: dados.idPatrimonio,
                                nome: dados.Produto,
                                nmrPat: dados.NmrPatrimonio
                            });
 
                            newRow.append(cols);
                            $("#tblGrdProdutos").append(newRow);
                            qtd++;
                        });
                    },
                    error: function (response) {
                    }
                });
            }*/

            else {
                document.getElementById("divAlmoxarifado").style.display = "block";
                document.getElementById("aSelAlmoxarifado").innerHTML = "Selecione o Almoxarifado:";

                $("#tblSelSubdivisaoManutencao1").css("display", "none");
                var dados = data.d;
                $("#tbSelAlmoxarifado1").empty();
                var qtd = 1;
                $("#tblSelAlmoxarifado1").css("display", "block");
                $("#divSubdivisaoManutencao").css("display", "block");

                $.each(dados, function (index, dados) {
                    var newRow = $("<tr>");
                    var cols = "";

                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                        " display:none'>" + dados.idSub + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                        " >" + dados.Subdivisao + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                        " >" + dados.Endereco + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                        " ><label onClick=\"SelecionaSubMov('" + dados.Subdivisao + "','" + dados.Endereco + "', " +
                        " '" + dados.idSub + "');\" style='cursor:pointer;font-size:15px;margin-bottom:0px; " +
                        " font-weight:100;color:#23527c;'>Selecionar</label></td>";

                    dataSub.push({
                        id: dados.idSub,
                        nome: dados.Subdivisao,
                        end: dados.Endereco
                    });

                    newRow.append(cols);
                    $("#tblSelAlmoxarifado1").append(newRow);
                    qtd++;
                });
            }
        },
        error: function (response) {
        }
    });
}

function tblManutencao() {

    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;

    var Prod = document.getElementById("lblProduto1").innerHTML;
    var dataSub = [];
    $("#tblDadosProd").css("display", "none");
    $("#tblSelSubdivisaoManutencao1").css("display", "none");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/Manutencao',
        dataType: 'json',
        data: "{'idPrefeitura':'" + IdPrefeitura + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d.length == 0) {
                alert("Nenhuma Subdivisão de Manutenção encontrada!");
                document.getElementById("divAlmoxarifado").style.display = "none";
                $("#tblSelAlmoxarifado1").css("display", "none");
                $("#divSubdivisaoManutencao").css("display", "none");
                return false;

            }
            if (data.d.length == 1) {
                document.getElementById("divAlmoxarifado").style.display = "none";
                var dados = data.d[0];
                $("#tblSelAlmoxarifado1").css("display", "none");
                $("#tblSelSubdivisaoManutencao1").css("display", "block");

                $("lblIdentificacaoSelecionada").append();
                //$("spnEndereco").append();
                document.getElementById("lblIdentificacaoSelecionada").innerHTML = dados.Subdivisao;
                //document.getElementById("spnEndereco").innerHTML = dados.Endereco;
                $("#hfIdSubMov").val(dados.idSub);
                $.ajax({
                    type: 'POST',
                    url: '../../WebServices/Materiais.asmx/ProcurarProdutoSub',
                    dataType: 'json',
                    data: "{'idPrefeitura':'" + IdPrefeitura + "','idSub':'" + dados.idSub + "','Prod':'" + Prod + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var dados = data.d;


                        var qtd = 1;
                        if (dados.length == 0) {
                            alert("Nenhum Produto encontrado nessa Subdivisão!");

                        }
                        else {
                            $("#tbSelControladorDesejado1").empty();
                            $("#tblSelSubdivisaoManutencao1").css("display", "block");
                            //$("#divScroll").css("display", "block");
                            $("#divSubdivisaoManutencao").css("display", "block");
                        }

                        $.each(dados, function (index, dados) {
                            var newRow = $("<tr>");
                            var cols = "";
                            if (Prod == "Placa" || Prod == "Coluna" || Prod == "Cabo" || Prod == "Grupo Focal"
                                || Prod == "Sistema de Iluminação" || Prod == "Acessorio") {
                                $("#btnSalvarMovimentacao1").css("display", "block");
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                    " display:none'>" + dados.idPatrimonio + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                                    " >" + dados.Produto + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                                    " >" + dados.NmrPatrimonio + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                                    " >" + dados.Subdivisao + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                                    " >" + dados.Endereco + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                                    " ><input type='checkbox' id='chk' \></td>";
                            }
                            else {
                                $("#btnSalvarMovimentacao1").css("display", "none");
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                                    " display:none'>" + dados.idPatrimonio + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                                    " >" + dados.Produto + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                                    " >" + dados.NmrPatrimonio + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                                    " >" + dados.Subdivisao + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                                    " >" + dados.Endereco + "</td>";
                                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                                    " ><label onClick=\"SelecionarProdMov('" + dados.idPatrimonio + "', " +
                                    " '" + dados.idSub + "','" + dados.Produto + "','" + dados.NmrPatrimonio + "', " +
                                    " '" + dados.Subdivisao + "','" + dados.Endereco + "');\" " +
                                    " style='cursor:pointer;font-size:15px;margin-bottom:0px;font-weight:100; " +
                                    " color:#23527c;'>Selecionar</label></td>";
                            }


                            dataSub.push({
                                id: dados.idPatrimonio,
                                nome: dados.Produto,
                                nmrPat: dados.NmrPatrimonio
                            });

                            newRow.append(cols);
                            $("#tblSelSubdivisaoManutencao1").append(newRow);
                            qtd++;
                        });
                    },
                    error: function (response) {
                    }
                });
            }

            else {
                document.getElementById("divAlmoxarifado").style.display = "block";
                document.getElementById("aSelAlmoxarifado").innerHTML = "Selecione a Subdivisão de Manutenção:";

                $("#tblSelSubdivisaoManutencao1").css("display", "none");
                var dados = data.d;
                $("#tbSelAlmoxarifado1").empty();
                var qtd = 1;
                $("#tblSelAlmoxarifado1").css("display", "block");
                $("#divSubdivisaoManutencao").css("display", "block");
                $.each(dados, function (index, dados) {
                    var newRow = $("<tr>");
                    var cols = "";

                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                        " display:none'>" + dados.idSub + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                        " >" + dados.Subdivisao + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                        " >" + dados.Endereco + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                        " ><label onClick=\"SelecionaSubMov('" + dados.Subdivisao + "','" + dados.Endereco + "', " +
                        " '" + dados.idSub + "');\" style='cursor:pointer;font-size:15px;margin-bottom:0px; " +
                        " font-weight:100;color:#23527c;'>Selecionar</label></td>";


                    dataSub.push({
                        id: dados.idSub,
                        nome: dados.Subdivisao,
                        end: dados.Endereco
                    });

                    newRow.append(cols);
                    $("#tblSelAlmoxarifado1").append(newRow);
                    qtd++;
                });
            }
        },
        error: function (response) {
        }
    });
}

function SelecionaSubMov(Sub, End, idSub) {

    var dataSub = [];
    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;

    var Prod = document.getElementById("lblProduto1").innerHTML;
    document.getElementById("divAlmoxarifado").style.display = "none";
    $("#tblSelAlmoxarifado1").css("display", "none");
    $("#tblSelSubdivisaoManutencao1").css("display", "block");
    $("#tblDadosProd").css("display", "none");
    $("lblIdentificacaoSelecionada").append();
    //$("spnEndereco").append();
    document.getElementById("lblIdentificacaoSelecionada").innerHTML = Sub;
    //document.getElementById("spnEndereco").innerHTML = End;
    $("#hfIdSubMov").val(idSub);
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ProcurarProdutoSub',
        dataType: 'json',
        data: "{'idPrefeitura':'" + IdPrefeitura + "','idSub':'" + idSub + "','Prod':'" + Prod + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var dados = data.d;


            var qtd = 1;
            if (dados.length == 0) {
                alert("Nenhum Produto encontrado nesse cruzamento!");
                $("#divSubdivisaoManutencao").css("display", "none");

            }
            else {
                $("#tbSelControladorDesejado1").empty();
                $("#tblSelSubdivisaoManutencao1").css("display", "block");
                //$("#divScroll").css("display", "block");
                $("#divSubdivisaoManutencao").css("display", "block");
            }

            $.each(dados, function (index, dados) {
                var newRow = $("<tr>");
                var cols = "";

                $("#btnSalvarMovimentacao1").css("display", "block");
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px; " +
                    " display:none'>" + dados.idPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.Produto + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.NmrPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.Subdivisao + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " >" + dados.Endereco + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;' " +
                    " ><input type='checkbox' id='chk' \></td>";

                dataSub.push({
                    id: dados.idPatrimonio,
                    nome: dados.Produto,
                    nmrPat: dados.NmrPatrimonio
                });

                newRow.append(cols);
                $("#tblSelSubdivisaoManutencao1").append(newRow);
                qtd++;
            });
        },
        error: function (response) {
        }
    });
}

function SubdivisaoClick(valor) {

    idSubdivisaoMov = $(valor).data("id");
    SubdivisaoMov = $(valor).text();
    $("#lblSubDivisaoSelecionada").text(SubdivisaoMov);
    $("#" + idSubdivisaoMov).toggle();
}

function salvarManutencao() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/salvarManutencao',
        dataType: "json",
        data: "{'idPatrimonio':'" + idPatrimonio + "','idSubdivisaoMov':'" + idSubdivisaoMov +
            "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
            " 'motivo':'" + $("#sleMotivoManutencao1").val() + "', " +
            " 'ocorrencia':'" + $("#txtOcorrenciaManutencao1").val() + "', " +
            " 'produto':'" + document.getElementById("lblProdManutencao").innerHTML + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
            $("#sleMotivoManutencao1").val("");
            $("#txtOcorrenciaManutencao1").val("");
        },
        error: function (data) {
            FindDNA();
        }
    });
}
