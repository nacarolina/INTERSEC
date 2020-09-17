
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

$(function () {
    loadResourcesLocales();
    loadAgenda('');
    GetAgendaHorarios();
});

$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})

function loadAgenda(idAgenda) {
    $.ajax({
        url: 'Default.aspx/loadAgenda',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        dataType: "json",
        async: false,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#sleAgendaCad").empty();
            $("#sleAgendaPesq").empty();
            $("#sleAgendaCad").append($("<option></option>").val("0").html("─ SELECIONE ─"));
            $("#sleAgendaPesq").append($("<option></option>").val("0").html("─ SELECIONE ─"));
            $.each(data.d, function () {
                $("#sleAgendaCad").append($("<option></option>").val(this['Value']).html(this['Text']));
                $("#sleAgendaPesq").append($("<option></option>").val(this['Value']).html(this['Text']));
            });

            if (idAgenda != '') $("#sleAgendaCad").val(idAgenda);
        }
    });
}

function NovaAgenda() {

    $("#mpCadAgenda").modal("show");
    $("#txtAgenda").val("");
    $("#lnkCancelarAlteracao").css("display", "none");
    $("#btnSalvarAgenda").val(getResourceItem("salvar"));
    GetAgenda();
}

function GetAgenda() {
    $.ajax({
        type: 'POST',
        url: 'Default.aspx/loadAgenda',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d.length > 0) {
                $("#tbCadAgenda").empty();

                $.each(data.d, function () {
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border-collapse: collapse; padding: 5px;'>" + this['Text'] + "</td>";

                    cols += "<td style='border-collapse: collapse; padding: 5px; width:1px'><input type=\"button\" \" class=\"btn btn-secondary\" value=\"" + getResourceItem("editar") + "\" onclick=\"EditarAgenda(this)\"  data-id='" + this['Value'] + "'  data-agenda='" + this['Text'] + "'/></td>";

                    cols += "<td style='border-collapse: collapse; padding: 5px; width:1px'> " +
                        " <div class=\"btn-group mr-1 mb-1\">" +
                        " <button type=\"button\" class=\"btn btn-danger btn-min-width dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\"> " + getResourceItem("excluir") + " </button> " +
                        " <div class=\"dropdown-menu\"> " +
                        " <a class=\"dropdown-item\" href=\"#\"onclick='ExcluirAgenda(this)' data-idagenda='" + this['Value'] + "'  data-agenda='" + this['Text'] + "'> " + getResourceItem("excluir") + " " + getResourceItem("agenda") + " </a>" +
                        " <a </div>" +
                        " </div> " +
                        " </td>";

                    newRow.append(cols);
                    $("#tbCadAgenda").append(newRow);
                });
            }
        }
    });
}

function FecharCadAgenda() {
    $("#mpCadAgenda").modal("hide");
}

function SalvarAgenda() {

    if ($("#txtAgenda").val() == "") {
        $("#txtAgenda").css("border-color", "#ff0000");
        $("#txtAgenda").css("outline", "0");
        $("#txtAgenda").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
        $("#txtAgenda").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
        $("#txtAgenda").focus();
        return false;
    }

    $("#txtAgenda").css("border-color", "");
    $("#txtAgenda").css("box-shadow", "");

    if ($("#btnSalvarAgenda").val() == getResourceItem("salvar")) {

        $.ajax({
            type: 'POST',
            url: 'Default.aspx/SalvarAgenda',
            dataType: 'json',
            data: "{'nomeAgenda':'" + $("#txtAgenda").val() + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','user':'" + $("#hfUser").val() + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d.includes("ATENÇÃO:")) {

                    Swal.fire({
                        type: 'error',
                        title: 'ERRO!',
                        text: (data.d.replace("ATENÇÃO:", "")),
                    })
                    return;
                }
                else {

                    $("#mpCadAgenda").modal("hide");
                    loadAgenda(data.d);
                }

                Swal.fire({
                    type: 'success',
                    title: 'Salvo!',
                    text: 'Salvo com sucesso.',
                })
            }
        });
    }
    else {

        $.ajax({
            type: 'POST',
            url: 'Default.aspx/AlterarAgenda',
            dataType: 'json',
            data: "{'nomeAgenda':'" + $("#txtAgenda").val() + "','idAgenda':'" + $("#btnSalvarAgenda")[0].dataset.idagenda + "','user':'" + $("#hfUser").val() + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {

                if (data.d != "SUCESSO") {

                    Swal.fire({
                        type: 'error',
                        title: 'ERRO!',
                        text: data.d,
                    })
                    return;
                }
                else {

                    $("#txtAgenda").val("");
                    GetAgenda();
                    loadAgenda('');
                    $("#btnSalvarAgenda").val(getResourceItem("salvar"));
                }

                Swal.fire({
                    type: 'success',
                    title: 'Salvo!',
                    text: 'Salvo com sucesso.',
                })
            }
        });
    }
}

function EditarAgenda(btn) {
    $("#txtAgenda").val(btn.dataset.agenda);
    $("#btnSalvarAgenda").val(getResourceItem("editar"));
    $("#lnkCancelarAlteracao").css("display", "block");
    $("#btnSalvarAgenda")[0].dataset.idagenda = btn.dataset.id;
}

function ExcluirAgenda(btn) {

    Swal.fire({
        title: 'Realmente deseja excluir?',
        text: "Esta agenda será excluída permanentemente!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        cancelButtonText: 'Cancelar',
        confirmButtonText: 'Sim, excluir!'
    }).then((result) => {
        if (result.value) {

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/ExcluirAgenda',
                dataType: 'json',
                data: "{'idAgenda':'" + btn.dataset.idagenda + "','user':'" + $("#hfUser").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    Swal.fire(

                        'Excluído!',
                        'Agenda excluída com sucesso.',
                        'success'
                    )
                    loadAgenda('');
                    GetAgenda();
                }
            });
        }
    });
}

function CancelarAlteracaoAgenda() {
    $("#txtAgenda").val("");
    $("#btnSalvarAgenda").val(getResourceItem("salvar"));
    $("#lnkCancelarAlteracao").css("display", "none");
    $("#btnSalvarAgenda")[0].dataset.idagenda = "";
}

function GetDiasSemana(chk) {

    if (chk.value == "TodoDia") {
        $("#chkSegSab")[0].checked = false;
        $("#chkSegSex")[0].checked = false;
        $("#chkSabDom")[0].checked = false;

        $("#chkSegunda")[0].checked = true;
        $("#chkTerca")[0].checked = true;
        $("#chkQuarta")[0].checked = true;
        $("#chkQuinta")[0].checked = true;
        $("#chkSexta")[0].checked = true;
        $("#chkSabado")[0].checked = true;
        $("#chkDomingo")[0].checked = true;
    } else if (chk.value == "SegSab") {
        $("#chkTodoDia")[0].checked = false;
        $("#chkSegSex")[0].checked = false;
        $("#chkSabDom")[0].checked = false;

        $("#chkSegunda")[0].checked = true;
        $("#chkTerca")[0].checked = true;
        $("#chkQuarta")[0].checked = true;
        $("#chkQuinta")[0].checked = true;
        $("#chkSexta")[0].checked = true;
        $("#chkSabado")[0].checked = true;
        $("#chkDomingo")[0].checked = false;
    } else if (chk.value == "SegSex") {
        $("#chkSegSab")[0].checked = false;
        $("#chkTodoDia")[0].checked = false;
        $("#chkSabDom")[0].checked = false;

        $("#chkSegunda")[0].checked = true;
        $("#chkTerca")[0].checked = true;
        $("#chkQuarta")[0].checked = true;
        $("#chkQuinta")[0].checked = true;
        $("#chkSexta")[0].checked = true;
        $("#chkSabado")[0].checked = false;
        $("#chkDomingo")[0].checked = false;
    } else if (chk.value == "SabDom") {
        $("#chkSegSab")[0].checked = false;
        $("#chkSegSex")[0].checked = false;
        $("#chkTodoDia")[0].checked = false;

        $("#chkSegunda")[0].checked = false;
        $("#chkTerca")[0].checked = false;
        $("#chkQuarta")[0].checked = false;
        $("#chkQuinta")[0].checked = false;
        $("#chkSexta")[0].checked = false;
        $("#chkSabado")[0].checked = true;
        $("#chkDomingo")[0].checked = true;
    }
    if (chk.checked == false) {
        $("#chkSegunda")[0].checked = false;
        $("#chkTerca")[0].checked = false;
        $("#chkQuarta")[0].checked = false;
        $("#chkQuinta")[0].checked = false;
        $("#chkSexta")[0].checked = false;
        $("#chkSabado")[0].checked = false;
        $("#chkDomingo")[0].checked = false;
    }
}

function AddPlano() {
    //subtrai 2 por causa dos plano amarelo interm. e apagado
    var totalPlanos = $("#slePlanos")[0].length - 2;
    totalPlanos++;
    $('#slePlanos').append($('<option>', {
        value: 'PLANO ' + totalPlanos,
        text: getResourceItem("plano") + totalPlanos
    }));
    $('#slePlanos')[0].value = "PLANO " + totalPlanos;
}

function GetAgendaHorarios() {

    $("#divLoading").css("display", "block");
    $.ajax({
        type: 'POST',
        url: 'Default.aspx/GetAgendaHorarios',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','agruparDias':'" + $("#chkAgruparDias")[0].checked + "','idAgenda':'" + $("#sleAgendaPesq").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#tbAgendaHorarios").empty();

            if (data.d.length > 0) {
                for (var i = 0; i < data.d.length; i++) {
                    var lst = data.d[i];
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td>" + lst.Plano + "</td>";
                    cols += "<td>" + lst.HrIni + "</td>";
                    cols += "<td>" + lst.HrFim + "</td>";
                    cols += "<td>" + getDayCultureLanguage(lst.Dia) + "</td>";

                    // cols += "<td style='border-collapse: collapse; padding: 5px; width:150px'><input type=\"button\" style=\"width:150px;\" class=\"btn btn-default\" value=\" Resources.Resource.editar %>\" onclick=\"EditarAgendaHorarios(this)\" data-TabelaEspecial='" + lst.TabelaEspecial + "' data-hrini='" + lst.HrIni + "' data-hrFim='" + lst.HrFim + "' data-id='" + lst.Id + "' data-dia='" + lst.Dia + "' data-plano='" + lst.Plano + "'/></td>";
                    cols += "<td style='width:120px'><div class=\"btn-group mr-1 mb-1\"><button type=\"button\" style=\"width:125px;\"  class=\"btn btn-danger btn-min-width dropdown-toggle\" data-toggle=\"dropdown\">" +
                        " " + getResourceItem("excluir") + " </button> <div class='dropdown-menu' x-placement='bottom-start' style='position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 40px, 0px); '>" +
                        "<a href=\"#\" class='dropdown-item' onclick='ExcluirAgendaHorarios(this)' data-hrini='" + lst.HrIni + "', data-hrFim='" + lst.HrFim + "', data-dia='" + lst.Dia + "', data-id='" + lst.Id + "', data-plano='" + lst.Plano + "')'  data-subareas='" + lst.SubAreas + "'> " + getResourceItem("sim") + " </a></div></div></td>";

                    newRow.append(cols);
                    $("#tbAgendaHorarios").append(newRow);
                }
            }
            else {

                var newRow = $("<tr>");
                var cols = "<td colspan='6' style='border-collapse: collapse; padding: 5px;'> " + getResourceItem("naoHaRegistros") + " </td>";
                newRow.append(cols);
                $("#tbAgendaHorarios").append(newRow);
            }

            $("#divLoading").css("display", "none");
        }
    });
}

function getDayCultureLanguage(dia) {
    var diaSemana = "";

    switch (dia) {
        case "Segunda":
            diaSemana = getResourceItem("segunda")
            break;
        case "Terca":
            diaSemana = getResourceItem("terca")
            break;
        case "Quarta":
            diaSemana = getResourceItem("quarta")
            break;
        case "Quinta":
            diaSemana = getResourceItem("quinta")
            break;
        case "Sexta":
            diaSemana = getResourceItem("sexta")
            break;
        case "Sabado":
            diaSemana = getResourceItem("sabado")
            break;
        case "Domingo":
            diaSemana = getResourceItem("domingo")
            break;
        default:
            diaSemana = getResourceItem("todosOsDias")
            break;
    }
    return diaSemana;
}

function NovaAgendaHorarios() {

    $("#btnSalvar")[0].disabled = false;
    $("#dvPesquisa").css("display", "none");
    $("#dvCad").css("display", "block");
    $("#tblPlanos").css("display", "none");

    $("#txtHrIni").css("border-color", "");
    $("#txtHrIni").css("outline", "");
    $("#txtHrIni").css("-webkit-box-shadow", "");
    $("#txtHrIni").css("box-shadow", "");

    $("#mpCadAgendaHorarios").modal("show");
    $("#btnSalvar")[0].dataset.origem = "Salvar";
    $("#btnSalvar")[0].dataset.idagendasel = "";
    $("#btnSalvar")[0].dataset.idagendahorarios = "";
    $("#btnSalvar")[0].dataset.hrinisel = "";
    $("#btnSalvar")[0].dataset.planosel = "";
    $("#btnSalvar")[0].dataset.diasel = "";
    $("#txtHrIni").val("");
    $("#txtTblEspecialHrIni").val("");
    $("#txtTblEspecialHrFim").val("");
    $("#sleAgendaCad").val($("#sleAgendaPesq").val());

    $("#chkTodoDia")[0].checked = false;
    $("#chkSegSab")[0].checked = false;
    $("#chkSegSex")[0].checked = false;
    $("#chkSabDom")[0].checked = false;

    $("#chkSegunda")[0].checked = false;
    $("#chkTerca")[0].checked = false;
    $("#chkQuarta")[0].checked = false;
    $("#chkQuinta")[0].checked = false;
    $("#chkSexta")[0].checked = false;
    $("#chkSabado")[0].checked = false;
    $("#chkDomingo")[0].checked = false;
}

function FecharCadAgendaHorarios() {

    $("#mpCadAgendaHorarios").modal("hide");
    $("#dvCad").css("display", "none");
    $("#dvPesquisa").css("display", "block");
    $("#tblPlanos").css("display", "block");
}

function ViewTabelaEspecial() {

    if ($("#chkTblEspecial")[0].checked) {

        $("#tblTabelaEspecial").css('display', '');
        $("#tblDiasSemana").css('display', 'none');
        $("#tituloDiasSemana").css('display', 'none');
        $("#tituloTabelaEspecial").css('display', 'block');

        $("#lblTimeInicial").css('display', 'none');
        $("#icoRelogio").css('display', 'none');
        $("#txtHrIni").css('display', 'none');
    }
    else {

        $("#lblTimeInicial").css('display', 'block');
        $("#icoRelogio").css('display', 'block');
        $("#txtHrIni").css('display', 'block');

        $("#tituloDiasSemana").css('display', 'block');
        $("#tblTabelaEspecial").css('display', 'none');
        $("#tblDiasSemana").css('display', '');
        $("#tituloTabelaEspecial").css('display', 'none');

        $("#txtHrIni").css("border-color", "");
        $("#txtHrIni").css("outline", "");
        $("#txtHrIni").css("-webkit-box-shadow", "");
        $("#txtHrIni").css("box-shadow", "");
    }

    document.getElementById("btnSalvar").disabled = false;
    //LIMPA INPUTS TABELA ESPECIAL
    $("#txtTblEspecialHrIni").css("border-color", "");
    $("#txtTblEspecialHrIni").css("outline", "");
    $("#txtTblEspecialHrIni").css("-webkit-box-shadow", "");
    $("#txtTblEspecialHrIni").css("box-shadow", "");

    $("#txtTblEspecialHrFim").css("border-color", "");
    $("#txtTblEspecialHrFim").css("outline", "");
    $("#txtTblEspecialHrFim").css("-webkit-box-shadow", "");
    $("#txtTblEspecialHrFim").css("box-shadow", "");
}

function SalvarAgendaHorarios(btn) {

    var diasSemana = [];
    if ($("#chkTblEspecial")[0].checked == false) {
        if ($("#txtHrIni").val() == "") {
            $("#txtHrIni").css("border-color", "#ff0000");
            $("#txtHrIni").css("outline", "0");
            $("#txtHrIni").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
            $("#txtHrIni").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
            return;
        }
        $("#txtHrIni").css("border-color", "");
        $("#txtHrIni").css("box-shadow", "");

        if ($("#chkSegunda")[0].checked) {
            diasSemana.push("Segunda");
        }
        if ($("#chkTerca")[0].checked) {
            diasSemana.push("Terca");
        }
        if ($("#chkQuarta")[0].checked) {
            diasSemana.push("Quarta");
        }
        if ($("#chkQuinta")[0].checked) {
            diasSemana.push("Quinta");
        }
        if ($("#chkSexta")[0].checked) {
            diasSemana.push("Sexta");
        }
        if ($("#chkSabado")[0].checked) {
            diasSemana.push("Sabado");
        }
        if ($("#chkDomingo")[0].checked) {
            diasSemana.push("Domingo");
        }
        if (diasSemana.length == 0) {

            Swal.fire({
                type: 'info',
                title: 'ATENÇÃO!',
                text: getResourceItem("selecioneDiaSemana"),
            })
            return;

        }
    } else {
        if ($("#txtTblEspecialHrIni").val() == "") {
            $("#txtTblEspecialHrFim").css("border-color", "");
            $("#txtTblEspecialHrFim").css("box-shadow", "");

            $("#txtTblEspecialHrIni").css("border-color", "#ff0000");
            $("#txtTblEspecialHrIni").css("outline", "0");
            $("#txtTblEspecialHrIni").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
            $("#txtTblEspecialHrIni").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
            return;
        }
        if ($("#txtTblEspecialHrFim").val() == "") {
            $("#txtTblEspecialHrIni").css("border-color", "");
            $("#txtTblEspecialHrIni").css("box-shadow", "");

            $("#txtTblEspecialHrFim").css("border-color", "#ff0000");
            $("#txtTblEspecialHrFim").css("outline", "0");
            $("#txtTblEspecialHrFim").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
            $("#txtTblEspecialHrFim").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
            return;
        }
        if ($("#txtTblEspecialHrIni").val() == $("#txtTblEspecialHrFim").val()) {

            Swal.fire({
                type: 'info',
                title: 'ATENÇÃO!',
                text: 'A Data Hora Inicial está igual a Data Hora Final!',
            })

            $("#txtTblEspecialHrIni").focus();
            return;
        }
        $("#txtTblEspecialHrIni").css("border-color", "");
        $("#txtTblEspecialHrIni").css("box-shadow", "");
        $("#txtTblEspecialHrFim").css("border-color", "");
        $("#txtTblEspecialHrFim").css("box-shadow", "");
    }

    $("#divLoading").css("display", "block");

    $.ajax({
        type: 'POST',
        url: 'Default.aspx/SalvarAgendaHorarios',
        dataType: 'json',
        data: "{'plano': '" + $("#slePlanos").val() + "','tblEspecial':'" + $("#chkTblEspecial")[0].checked + "','HrIni':'" + $("#txtHrIni").val() + "'," +
            "'TblEspecialHrIni':'" + $("#txtTblEspecialHrIni").val() + "','TblEspecialHrFim':'"
            + $("#txtTblEspecialHrFim").val() + "','diasSemana':'" + diasSemana + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() +
            "','idAgenda':'" + $("#sleAgendaCad").val() + "','origem':'" + btn.dataset.origem + "','idAgendaAnterior':'" + btn.dataset.idagendasel + "','planoAnterior':'" + btn.dataset.planosel + "','hrIniAnterior':'" + btn.dataset.hrinisel + "','diasSemanaAnterior':'" + btn.dataset.diasel + "','user':'" + $("#hfUser").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "SUCESSO") {

                Swal.fire({
                    type: 'error',
                    title: 'ERRO!',
                    text: data.d,
                })
            }
            else {

                $("#sleAgendaPesq").val($("#sleAgendaCad").val());
                $("#mpCadAgendaHorarios").modal("hide");
                GetAgendaHorarios();

                Swal.fire({
                    type: 'success',
                    title: 'Salvo!',
                    text: 'Salvo com sucesso.',
                })

                $("#dvPesquisa").css("display", "block");
                $("#dvCad").css("display", "none");
                $("#tblPlanos").css("display", "block");
            }

            $("#divLoading").css("display", "none");
        }
    });

}

function ExcluirAgendaHorarios(btn) {

    Swal.fire({
        title: 'Realmente deseja excluir?',
        text: "Este plano será excluído permanentemente!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        cancelButtonText: 'Cancelar',
        confirmButtonText: 'Sim, excluir!'
    }).then((result) => {

        if (result.value) {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/ExcluirAgendaHorarios',
                dataType: 'json',
                data: "{'plano':'" + btn.dataset.plano + "','idAgendaHorarios':'" + btn.dataset.id + "','HrIni':'" + btn.dataset.hrini + "'," +
                    "'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idAgendaCentral':'" + $("#sleAgendaPesq").val() + "','user':'" + $("#hfUser").val() + "','HrFim':'" + btn.dataset.hrfim + "','dia':'" + btn.dataset.dia + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "SUCESSO") {

                        Swal.fire({
                            type: 'error',
                            title: 'ERRO!',
                            text: data.d,
                        })
                        return;

                        //alert(data.d);
                    }
                    else {

                        $("#divLoading").css("display", "none");

                        Swal.fire(

                            'Excluído!',
                            'Plano excluído com sucesso.',
                            'success'
                        )

                        GetAgendaHorarios();
                        //alert("Resources.Resource.agendamento %>  Resources.Resource.excluido %>!");
                    }

                }
            });
        }
    });
}

function EditarAgendaHorarios(btn) {
    $("#mpCadAgendaHorarios").modal("show");

    var diasSemana = [];
    $("#sleAgendaCad").val($("#sleAgendaPesq").val());
    $("#btnSalvar")[0].dataset.origem = "Alterar";
    $("#btnSalvar")[0].dataset.idagendasel = $("#sleAgendaPesq").val();
    $("#btnSalvar")[0].dataset.idagendahorarios = btn.dataset.id;
    $("#btnSalvar")[0].dataset.hrinisel = btn.dataset.hrini;
    $("#btnSalvar")[0].dataset.planosel = btn.dataset.plano;

    if (btn.dataset.tabelaespecial == "Sim") {
        $("#chkTblEspecial")[0].checked = true;
        ViewTabelaEspecial($("#chkTblEspecial")[0]);
        $("#txtTblEspecialHrIni").val(btn.dataset.hrini);
        $("#txtTblEspecialHrFim").val(btn.dataset.hrfim);
        $("#slePlanos").val(btn.dataset.plano);
    }
    else {
        $("#chkTblEspecial")[0].checked = false;
        ViewTabelaEspecial($("#chkTblEspecial")[0]);
        $("#txtHrIni").val(btn.dataset.hrini);
        $("#slePlanos").val(btn.dataset.plano);
        var dia = btn.dataset.dia;
        if (dia == "Todos os dias") {
            $("#chkTodoDia")[0].checked = true;
            GetDiasSemana($("#chkTodoDia")[0]);
        } else if (dia == "Segunda - Sexta") {
            $("#chkSegSex")[0].checked = true;
            GetDiasSemana($("#chkSegSex")[0]);
        } else if (dia == "Segunda - Sábado") {
            $("#chkSegSab")[0].checked = true;
            GetDiasSemana($("#chkSegSab")[0]);
        } else if (dia == "Sábado - Domingo") {
            $("#chkSabDom")[0].checked = true;
            GetDiasSemana($("#chkSabDom")[0]);
        } else {
            $("#chkSabDom")[0].checked = false;
            GetDiasSemana($("#chkSabDom")[0]);
            if (dia.includes("Segunda")) {
                $("#chkSegunda")[0].checked = true;
            }
            if (dia.includes("Terca")) {
                $("#chkTerca")[0].checked = true;
            }
            if (dia.includes("Quarta")) {
                $("#chkQuarta")[0].checked = true;
            }
            if (dia.includes("Quinta")) {
                $("#chkQuinta")[0].checked = true;
            }
            if (dia.includes("Sexta")) {
                $("#chkSexta")[0].checked = true;
            }
            if (dia.includes("Sabado")) {
                $("#chkSabado")[0].checked = true;
            }
            if (dia.includes("Domingo")) {
                $("#chkDomingo")[0].checked = true;
            }
        }

        if ($("#chkSegunda")[0].checked) {
            diasSemana.push("Segunda");
        }
        if ($("#chkTerca")[0].checked) {
            diasSemana.push("Terca");
        }
        if ($("#chkQuarta")[0].checked) {
            diasSemana.push("Quarta");
        }
        if ($("#chkQuinta")[0].checked) {
            diasSemana.push("Quinta");
        }
        if ($("#chkSexta")[0].checked) {
            diasSemana.push("Sexta");
        }
        if ($("#chkSabado")[0].checked) {
            diasSemana.push("Sabado");
        }
        if ($("#chkDomingo")[0].checked) {
            diasSemana.push("Domingo");
        }

        $("#btnSalvar")[0].dataset.diasel = diasSemana;
    }
}

function ValidarAgendaHorarios() {

    $.ajax({
        type: 'POST',
        url: 'Default.aspx/ValidarAgendaHorarios',
        dataType: 'json',
        data: "{'idAgendaCentral':'" + $("#sleAgendaPesq").val() + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','user':'" + $("#hfUser").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "SUCESSO") {

                Swal.fire({
                    type: 'error',
                    title: 'ERRO!',
                    text: data.d,
                })
                return;

                //alert(data.d);
            }
            else {

                Swal.fire({
                    type: 'success',
                    title: 'Salvo!',
                    text: getResourceItem("agenda") + getResourceItem("validada"),
                })

                //alert(getResourceItem("agenda") + getResourceItem("validada"));
            }
        }
    });
}

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

        Swal.fire({
            type: 'warning',
            title: 'ATENÇÃO!',
            text: getResourceItem("data") + getResourceItem("invalida") + " DD/MM/AAAA ",
        })

        //alert(getResourceItem("data") + getResourceItem("invalida") + " DD/MM/AAAA ");
        return false;
    }

    splitData = stringData.split('/');

    if (splitData.length != 3) {

        Swal.fire({
            type: 'warning',
            title: 'ATENÇÃO!',
            text: getResourceItem("data") + getResourceItem("invalida") + " DD/MM/AAAA ",
        })
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

    if ($("#chkTblEspecial")[0].checked == false) {
        $(obj).css("border-color", "");
        $(obj).css("outline", "");
        $(obj).css("-webkit-box-shadow", "");
        $(obj).css("box-shadow", "");
        $("#btnSalvar")[0].disabled = false;
        return true;
    }
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
