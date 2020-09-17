
$(function () {
    loadResourcesLocales();
    Geocodificacao('São Paulo,SP');
    var addresspicker = $("#txtCruzamento").addresspicker({
        componentsFilter: 'country:BR'
    });

    $("#input-pt-br").fileinput({
        language: "pt-BR",
        uploadUrl: "ArquivoCroqui",
        maxFilePreviewSize: 10240,
        allowedFileExtensions: ["jpg", "png", "gif", "zip", "rar", "gz", "tgz", "jpeg", "pdf", "doc", "docx", "xlsx", "xls"],
        uploadAsync: true,
        elErrorContainer: '#kv-error-1'
    }).on('filebatchpreupload', function (event, data, id, index) {
        $('#kv-success-1').html('<h4>Upload Status</h4><ul></ul>').hide();
    }).on('fileuploaded', function (event, data, id, index) {
        var fname = data.files[index].name,
            out = '<li>' + 'Uploaded file # ' + (index + 1) + ' - ' +
                fname + ' successfully.' + '</li>';
        $('#kv-success-1 ul').append(out);
        $('#kv-success-1').fadeIn('slow');
    });
});

Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequest);
function BeginRequest(sender, e) {
    e.get_postBackElement().disabled = true;

}
function passIdPonto(idPonto) {
    document.getElementById("spaIdPontoCam").innerHTML = idPonto;
}
function searchCamera() {
    var input, filter, table, tr, td, i;
    input = document.getElementById("txtsearchCamera");
    filter = input.value.toUpperCase();
    table = document.getElementById("tblCamera");
    tr = table.getElementsByTagName("tr");
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0];
        if (td) {
            if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

function setIpPorTrap() {
    if (document.getElementById("chkIpTrap").checked && document.getElementById("hInfoCad").innerText.indexOf("Nobreak") != -1 && document.getElementById("hfSerialController").value) {
        document.getElementById("txtSerialCad").value = document.getElementById("hfSerialController").value;
        document.getElementById("txtSerialCad").disabled = true;
    }
    else if (document.getElementById("chkIpTrap").checked == false && document.getElementById("hInfoCad").innerText == "Cadastrar Nobreak") {
        document.getElementById("txtSerialCad").disabled = false;
    }
}

var clearAll = function () {
    document.getElementById("tdSerial").style.display = "none";
    document.getElementById("tfControlador").style.display = "";
    document.getElementById("txtEndereco").value = "";
    document.getElementById("spaCruzamento").innerHTML = "";
    //document.getElementById("txtIdLocal").value = "";
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

function btnAdicionarArquivo_Click() {
    $("#divArquivos").slideToggle();
    $("#tblArquivos").slideToggle();
    $("#tbArquivos").empty();
    $("#myfile").val("");
}

function ExcluirControladores() {
    callServer("../../WebServices/CadEqp.asmx/ExcluirControladores", "{}", function (eqp) {
    });
    GetControls();
}

function VisualCamera() {
    $.ajax({
        url: '../../WebServices/CadEqp.asmx/VisualCamera',
        data: "{'idDna':'" + $("#txtIdLocal").val() + "'}",
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#tbCamera").empty();
            if (data.d != "") {
                var i = 0;
                while (data.d[i]) {
                    var lst = data.d[i];

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lst.hostName + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lst.idPonto + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + lst.user + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'><a style='cursor:pointer;' data-id=" + lst.idCamera + " onclick='selectCamera(this)'>" + getResourceItem("selecionar") + "</a></td>";

                    newRow.append(cols);
                    $("#tblCamera").append(newRow);

                    i++;
                }
            }
            else {
                $("#tbCamera").empty();
                var newRow = $("<tr>");
                var cols = "";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + getResourceItem("naoHaRegistros") + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'></td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'></td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'></td>";

                newRow.append(cols);
                $("#tblCamera").append(newRow);
            }
        },
        error: function (response) {
        }
    });
}

function selectCamera(handler) {
    $("#paragraphCadPonto").css("visibility", "hidden");
    var idCamera = $(handler).data("id");
    $("#popupVisualCamera").modal("hide");
    $("#popupCamera").modal("show");
    $.ajax({
        url: '../../WebServices/CadEqp.asmx/SelectCamera',
        data: "{'idCamera':'" + idCamera + "'}",
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var lst = data.d[0];
            document.getElementById("spaIdPontoCam").innerHTML = lst.idPonto;
            document.getElementById("spaIdPontoCam").title = lst.idCamera;
            $("#txtHostName").val(lst.hostName);
            $("#txtUsuarioCamera").val(lst.user);
            $("#txtSenhaCamera").val(lst.senha);
            $("#txtSerialModuloComunicacao").val(lst.serial);
            var servico = lst.servico == "True" ? true : false;
            $("#chkServicoCamera").prop("checked", servico);
        },
        error: function (response) {
        }
    });
}

function NovaCamera() {
    $("#paragraphCadPonto").css('visibility', 'visible');
    document.getElementById("spaIdPontoCam").innerHTML = "";
    $("#txtIdPonto").val("");
    $("#txtHostName").val("");
    $("#txtUsuarioCamera").val("");
    $("#txtSenhaCamera").val("");
    $("#txtSerialModuloComunicacao").val("");
    $("#chkServicoCamera").prop("checked", false);
}

function PesquisarDNA() {
    var IdDNA = document.getElementById("txtDNAMestre").value;
    if (IdDNA == "") {
        $("#spnValidaDNAMestre").css("display", "block");
        return false;
    }
    else {
        $("#spnValidaDNAMestre").css("display", "none");
    }
    callServer("../../WebServices/CadEqp.asmx/PesquisarDNAMestre", "{'IdDNA':'" + IdDNA + "','ConjMestre':'false'}", function (resul) {
        if (resul.toString() == "" || resul == null) {
            document.getElementById("#spnValidaDNAMestre").innerHTML = "DNA " + getResourceItem("naoEncontrado");
            $("#spnValidaDNAMestre").css("display", "block");
            return false;
        }
        else {
            ////Cruzamento,SerialMestre,IP,PortSnmpReset,PortSnmpTraps,PortSnmp,Ddns
            if (resul[1] == "CONJUGADO") {
                document.getElementById("#spnValidaDNAMestre").innerHTML = "DNA " + getResourceItem("naoEncontrado");
                $("#spnValidaDNAMestre").css("display", "block");
                return false;
            }
            else {
                var i = 0;
                var lst = resul[i].split('@');
                $("#trEnderecoDNA").css("display", "");
                document.getElementById("spnEndereco").innerHTML = lst[0];
                document.getElementById("spnSerialMestre").innerHTML = lst[1];
                document.getElementById("txtIP").value = lst[2];
                document.getElementById("txtPortaReset").value = lst[3];
                document.getElementById("txtPortaSnmpTrap").value = lst[4];
                document.getElementById("txtPortaSnmpMib").value = lst[5];
                document.getElementById("txtDDNS").value = lst[6];
            }

        }
    });
}

function Novo() {
    CarregaListaCroqui();
    $("#txtSerialCad").val("");
    $("#dvGrdPesquisa").css("display", "none");
    $("#btnPesqSerial").css("display", "table-column");
    $("#dvModelo").css("display", "");
    $("#tdPesqEnd").css("display", "");
    //$("#tdSerial").css("display", "");
    $("#dvControladorMestre").css("display", "");
    $("#divEquipamento").css("display", "");
    $("#btnExcluirCruz").css("display", "none");
    $("#btnNovo").css("display", "none");
    $("#btnGrupo").css("display", "none");
    $("#txtIdLocal")[0].disabled = false;
    $("#txtSerialCad")[0].disabled = false;
    $("#btnSalvarCruz").val('Salvar');
    $("#txtModelo").val("");
    $("#txtMestre").val("");
}

function CancelarCad() {
    CarregaListaCroqui();

    $("#dvControladorMestre").css("display", "none");
    $("#dvModelo").css("display", "none");
    $("#tdPesqEnd").css("display", "none");
    $("#btnPesqSerial").css("display", "");
    $("#dvGrdPesquisa").css("display", "");
    $("#txtSerialCad").val("");
    //$("#tdSerial").css("display", "none");
    $("#divEquipamento").css("display", "none");
    $("#txtIdLocal")[0].disabled = false;
    $("#txtSerialCad")[0].disabled = false;

    $("#txtPesqEndereco").val("");
    $("#btnExcluirCruz").css("display", "none");
    $("#btnNovo").css("display", "");
    $("#txtCruzamento").val("");
    $("#txtIdLocal").val("");
}

function pesqEqp() {
    //$("#paragraphCadPonto").css("visibility", "hidden");
    if ($("#txtSerialCad").val() == "") {
        $("#dvGrdPesquisa").css("display", "block");
        $.ajax({
            type: 'POST',
            url: 'Default.aspx/GetAllEqp',
            dataType: 'json',
            data: "{}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d.length > 0) {
                    $("#tbControlador").empty();

                    for (var i = 0; i < data.d.length; i++) {
                        var lst = data.d[i];

                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.serial + "</td>";

                        cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.cruzamento + "</td>";
                        cols += "<td style='border-collapse: collapse; padding: 5px; width:1px'><input type=\"button\" \" class=\"btn btn-warning\" value=\"" + getResourceItem("editar") + "\" onclick=\"EditarControlador(this)\"  data-serial='" + lst.serial + "' /></td>";

                        newRow.append(cols);
                        $("#tbControlador").append(newRow);
                    }
                }
                else {
                    newRow = $("<tr>");
                    cols = "";
                    cols += "<td colspan='3'>" + getResourceItem("naoHaRegistros") + "</td>";

                    newRow.append(cols);
                    $("#tbControlador").append(newRow);
                }
            }
        });
    }
    else {
        $("#dvGrdPesquisa").css("display", "none");
        callServer("../../WebServices/CadEqp.asmx/GetEqp", "{'idDna':'" + $("#txtSerialCad").val() + "'}", function (eqp) {
            $("#tbControlador").empty();
            $("#hdfId").val($("#txtIdLocal").val());
            $("#divMapa").css("display", "block");
            if (eqp.length == 0) {
                swal(getResourceItem("atencao"), getResourceItem("controlador") + " " + getResourceItem("naoEncontrado") + "!", "warning");

                $("#txtPesqEndereco").val("");
                $("#txtCruzamento").val("");
                //$("#tdSerial").css("display", "none");
                $("#txtIdLocal")[0].disabled = false;
                $("#divEquipamento").css("display", "none");
                $("#btnNovo").css("display", "");
            }
            else {
                CarregaListaCroqui();
                $("#btnNovo").css("display", "");
                $("#tdPesqEnd").css("display", "");
                $("#dvModelo").css("display", "");
                $("#dvControladorMestre").css("display", "");
                $("#btnNovo").css("display", "none");
                $("#btnPesqSerial").css("display", "table-column");
                $("#txtSerialCad").val(eqp[0].serial);
                $("#txtIdLocal")[0].disabled = true;
                $("#btnGrupo").css("display", "");
                $("#txtSerialCad")[0].disabled = true;
                document.getElementById("spaCruzamento").innerHTML = eqp[0].cruzamento;
                //$("#tdSerial").css("display", "");
                document.getElementById("hfSerialController").value = "";
                $("#btnCadChip").attr("data-id", eqp[0].idDna);
                document.getElementById("txtCruzamento").value = eqp[0].cruzamento;
                document.getElementById("txtEndereco").value = eqp[0].cruzamento;
                $("#txtModelo").val(eqp[0].modelo);
                $("#txtMestre").val(eqp[0].mestre);
                if ($("#txtMestre").val() == "") {
                    $("#chkConjugado")[0].checked = false;
                    document.getElementById("txtMestre").disabled = true;
                }
                else {
                    $("#chkConjugado")[0].checked = true;
                        document.getElementById("txtMestre").disabled = false;
                    
                }
                $("#divEquipamento").css("display", "");
                $("#btnExcluirCruz").css("display", "");
                $("#btnSalvarCruz").val("Salvar Alterações");

                //#region LoadControllers
                Geocodificacao();

                document.getElementById("spaIdPontoCam").innerHTML = eqp[0].idDna;
                document.getElementById("txtHostName").value = eqp[0].hostNameCam;
                document.getElementById("txtUsuarioCamera").value = eqp[0].userCamera;
                document.getElementById("txtSenhaCamera").value = eqp[0].passwordCam;
                $("#txtSerialModuloComunicacao").val(eqp[0].serialComunicacao);
                var servico = eqp[0].servico == "True" ? true : false;
                $("#chkServicoCamera").prop("checked", servico);

                //#endregion   
            }
        });
    }
}

function EditarControlador(btn) {
    $("#txtSerialCad").val(btn.dataset.serial);
    pesqEqp();
}

function VerGrupo(btn) {
    window.open("../Dna/LocaisGruposSemaforicos.aspx?IdEqp=" + $("#txtSerialCad").val() + "&local=" + $("#txtCruzamento").val());
}

function infoConsorcio(status) {
    switch (status) {
        case "Sim":
            document.getElementById("divInfoConsorcioChip").style.display = "";
            document.getElementById("divEmpChip").style.display = "none";
            break;
        case "Nao":
            document.getElementById("divInfoConsorcioChip").style.display = "none";
            document.getElementById("divEmpChip").style.display = "";
            break;
    }
}

var cadCamera = function (status) {

    var hostName = document.getElementById("txtHostName").value;
    var userCamera = document.getElementById("txtUsuarioCamera").value;
    var senhaCamera = document.getElementById("txtSenhaCamera").value;

    if (status == "Habilitado") {
        //#region valida camera

        if (hostName == "") {
            $("#txtHostName").addClass("validaCampo");
            return;
        }
        else $("#txtHostName").removeClass("validaCampo");

        if (userCamera == "") {
            $("#txtUsuarioCamera").addClass("validaCampo");
            return;
        }
        else $("#txtUsuarioCamera").removeClass("validaCampo");

        if (senhaCamera == "") {
            $("#txtSenhaCamera").addClass("validaCampo");
            return;
        }
        else $("#txtSenhaCamera").removeClass("validaCampo");

        // #endregion
    }

    callServer("../../WebServices/CadEqp.asmx/SaveConfigCamera",
        "{'idDna':'" + document.getElementById("spaIdPontoCam").innerHTML + "','hostName':'" + hostName + "','userName':'"
        + userCamera + "','password':'" + senhaCamera + "','statusCamera':'" + status + "','idCamera':'"
        + document.getElementById("spaIdPontoCam").title + "','servico':'" + $("#chkServicoCamera")[0].checked
        + "','serialComunicacao':'" + $("#txtSerialModuloComunicacao").val() + "'}",

        function (resul) {
            if (resul != "") {
                resul = resul.indexOf("A serial configurada já está vinculada ao mesmo IP") != -1 ? getResourceItem("serialConfigNoMesmoIP") : resul;
                alert(resul);
            }

            $("#popupCamera").modal("hide");
            // pesqEqp();
        });
}

function DesabilitaControlador(chk, serial) {
    if (chk.checked == true) {
        var params = "{'serial':'" + serial + "','chk':'true','idDna':'" + chk.value + "'}";
        callServer("../../WebServices/CadEqp.asmx/DesabilitarEquipamento", params, function (resposta) {
            if (resposta == "H") {
                alert(getResourceItem("alert_desabitarEqpCruzamento"));
                chk.checked = false;
                return;
            }
            if (resposta == "OK")
                alert(getResourceItem("controlador") + " " + getResourceItem("desabilitado") + "!");
            else {
                alert(getResourceItem("falhaDesabilitar") + "!");
                chk.checked = false;
            }
        });
    }
    else {
        var params = "{'serial':'" + serial + "','chk':'false','idDna':'" + chk.value + "'}";
        callServer("../../WebServices/CadEqp.asmx/DesabilitarEquipamento", params, function (resposta) {
            if (resposta == "OK") {
                alert(getResourceItem("controlador") + " " + getResourceItem("habilitado") + "!");
            }
            else {
                alert(getResourceItem("falhaHabilitar") + "!");
                chk.checked = true;
            }
        });
    }
}

function DesabilitaNobreak(chk, serial) {
    if (chk.checked == true) {
        var params = "{'serial':'" + serial + "','chk':'true'}";
        callServer("../../WebServices/CadEqp.asmx/DesabilitarNobreak", params, function (resposta) {
            if (resposta == "OK")
                alert("Nobreak " + getResourceItem("desabilitado") + "!");
            else {
                alert(getResourceItem("falhaDesabilitar") + "!");
                chk.checked = false;
            }
        });
    }
    else {
        var params = "{'serial':'" + serial + "','chk':'false'}";
        callServer("../../WebServices/CadEqp.asmx/DesabilitarNobreak", params, function (resposta) {
            if (resposta == "OK") {
                alert("Nobreak " + getResourceItem("habilitado") + "!");
            }
            else {
                alert(getResourceItem("falhaHabilitar") + "!");
                chk.checked = true;
            }
        });
    }
}

function deleteEqp(handler, tipo) {
    var serial = $(handler).data("id");
    var tr = $(handler).closest('tr');
    var idDna = tr.find('td').eq(0).text();
    var params;
    switch (tipo) {
        case "nobreak":
            params = "{'tipo':'nobreak','serial':'" + serial + "','idDna':'" + idDna + "'}";
            break;
        case "controller":
            params = "{'tipo':'controller','serial':'" + serial + "','idDna':'" + idDna + "'}";
            break;
    }
    callServer("../../WebServices/CadEqp.asmx/DeleteEqp", params, function (resposta) {
        if (resposta == "H") {
            swal(getResourceItem("atencao"), getResourceItem("alert_ExcluirEqpCruzamento"), "warning");
        }
        else {
            pesqEqp();
        }
    });
}

function saveEqp() {
    if (document.getElementById("txtSerialCad").value == "") {
        $("#txtSerialCad").addClass('valida-input');
        $("#txtSerialCad").focus();
        return;
    }
    else {
        $("#txtSerialCad").removeClass('valida-input');
    }

    if (document.getElementById("txtCruzamento").value == "") {
        $("#txtCruzamento").addClass('valida-input');
        $("#txtCruzamento").focus();
        return;
    }
    else {
        $("#txtCruzamento").removeClass('valida-input');
    }
    if (document.getElementById("txtCruzamento").value == "") {
        $("#txtCruzamento").addClass('valida-input');
        $("#txtCruzamento").focus();
        return;
    }
    else {
        Geocodificacao();
        $("#txtCruzamento").removeClass('valida-input');
    }
    if (document.getElementById("txtLat").value == "" || document.getElementById("txtLong").value == "") {
        $("#txtCruzamento").focus();
        return;
    }

    var SerialMestre = $("#txtMestre").val();
    /* if (document.getElementById("chkConjugado").checked == true) {
         if (document.getElementById("spnSerialMestre").innerHTML == "") {
             document.getElementById("spnValidaDNAMestre").innerHTML = getResourceItem("informeDnaMestre");
             $("#spnValidaDNAMestre").css("display", "block");
             return false;
         }
         else {
             $("#spnValidaDNAMestre").css("display", "none");
             SerialMestre = document.getElementById("spnSerialMestre").innerHTML;
         }
     }*/

    var semComunicacao
    var params;
    switch ($("#btnSalvarCruz").val()) {
        case getResourceItem("salvar"):
            params = "{'SerialMestre':'" + SerialMestre + "','tipoEqp':'controller','tipoCad':'insert','idDna':'" + $("#txtIdLocal").val() + "','serial':'" + document.getElementById("txtSerialCad").value + "','ddns':'" + document.getElementById("txtDDNS").value + "','ip':'" + document.getElementById("txtIP").value + "','portaSnmpMib':'" + document.getElementById("txtPortaSnmpMib").value + "','portaSnmpTrap':'" + document.getElementById("txtPortaSnmpTrap").value + "','portaSnmpReset':'" + document.getElementById("txtPortaReset").value + "','ipPorTrap':'" + document.getElementById("chkIpTrap").checked + "','habilitaCentral':'" + document.getElementById("chkHabilitaCentral").checked + "','semServico':'" + document.getElementById("chkSemComunicacao").checked + "','empresa':'','resetPorRequisicao':'','cruzamento':'" + $("#txtCruzamento").val() + "','lat':'" + $("#txtLat").val() + "','lon':'" + $("#txtLong").val() + "','modelo':'" + $("#txtModelo").val() + "'}";
            break;
        case getResourceItem("salvarAlteracoes"):
            params = "{'SerialMestre':'" + SerialMestre + "','tipoEqp':'controller','tipoCad':'update','idDna':'" + $("#txtIdLocal").val() + "','serial':'" + document.getElementById("txtSerialCad").value + "','ddns':'" + document.getElementById("txtDDNS").value + "','ip':'" + document.getElementById("txtIP").value + "','portaSnmpMib':'" + document.getElementById("txtPortaSnmpMib").value + "','portaSnmpTrap':'" + document.getElementById("txtPortaSnmpTrap").value + "','portaSnmpReset':'" + document.getElementById("txtPortaReset").value + "','ipPorTrap':'" + document.getElementById("chkIpTrap").checked + "','habilitaCentral':'" + document.getElementById("chkHabilitaCentral").checked + "','empresa':'" + document.getElementById('sleEmpresa').options[document.getElementById('sleEmpresa').selectedIndex].innerText + "','semServico':'" + document.getElementById("chkSemComunicacao").checked + "','resetPorRequisicao':'" + $("#chkResetPorRequisicao")[0].checked + "','cruzamento':'" + $("#txtCruzamento").val() + "','lat':'" + $("#txtLat").val() + "','lon':'" + $("#txtLong").val() + "','modelo':'" + $("#txtModelo").val() + "'}";
            break;
        case getResourceItem("cadastrar") + " Nobreak":
            params = "{'SerialMestre':'" + SerialMestre + "','tipoEqp':'nobreak','tipoCad':'insert','idDna':'" + $("#txtIdLocal").val() + "','serial':'" + document.getElementById("txtSerialCad").value + "','ddns':'" + document.getElementById("txtDDNS").value + "','ip':'" + document.getElementById("txtIP").value + "','portaSnmpMib':'" + document.getElementById("txtPortaSnmpMib").value + "','portaSnmpTrap':'" + document.getElementById("txtPortaSnmpTrap").value + "','portaSnmpReset':'','ipPorTrap':'" + document.getElementById("chkIpTrap").checked + "','habilitaCentral':'" + false + "','semServico':'" + document.getElementById("chkSemComunicacao").checked + "','empresa':'','resetPorRequisicao':''}";
            break;
        case getResourceItem("salvarAlteracoes") + " Nobreak":
            params = "{'SerialMestre':'" + SerialMestre + "','tipoEqp':'nobreak','tipoCad':'update','idDna':'" + $("#txtIdLocal").val() + "','serial':'" + document.getElementById("txtSerialCad").value + "','ddns':'" + document.getElementById("txtDDNS").value + "','ip':'" + document.getElementById("txtIP").value + "','portaSnmpMib':'" + document.getElementById("txtPortaSnmpMib").value + "','portaSnmpTrap':'" + document.getElementById("txtPortaSnmpTrap").value + "','portaSnmpReset':'','ipPorTrap':'" + document.getElementById("chkIpTrap").checked + "','habilitaCentral':'" + false + "','semServico':'" + document.getElementById("chkSemComunicacao").checked + "','empresa':'','resetPorRequisicao':''}";
            break;
    }

    callServer("../../WebServices/CadEqp.asmx/SaveEqp", params, function (resposta) {
        $("#spaInfoCad").empty();

        resposta = resposta.indexOf("Este Id do Dna ja foi vinculado") != -1 ? getResourceItem("idDnaJaFoiVinculado") : resposta;
        resposta = resposta.indexOf("Este Serial ja existe") != -1 ? getResourceItem("serialExistente") : resposta;
        resposta = resposta.indexOf("Este Dna não existe") != -1 ? getResourceItem("DnaNaoExiste") : resposta;

        switch (resposta) {
            case getResourceItem("idDnaJaFoiVinculado"):
            case getResourceItem("serialExistente"):
            case getResourceItem("DnaNaoExiste"):
                document.getElementById("pInfoCad").style.display = "";
                document.getElementById("spaInfoCad").innerHTML = resposta;
                swal(getResourceItem("atencao"), resposta, "warning");
                break;
            case "ok":
                document.getElementById("pInfoCad").style.display = "none";
                CancelarCad();
                break;
        }
    });


    //CancelarCad();
}

function confirmCadConj() {
    $.ajax({
        url: '../../WebServices/CadEqp.asmx/SaveConjMestre',
        data: "{'Mestre':'" + $("#ctrlMestre").val() + "','idDna':'" + $("#txtIdPontoConj").val() + "'}",
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $.ajax({
                url: '../../WebServices/CadEqp.asmx/GetConjugadosMestre',
                data: "{'idDNA':'" + $("#ctrlMestre").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbConj").empty();
                    if (data.d != "") {

                        var i = 0;
                        while (data.d[i]) {
                            var lst = data.d[i].split('@');

                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst[1] + "</td>";
                            cols += "<td>" + lst[0] + "</td>";

                            newRow.append(cols);
                            $("#tblConj").append(newRow);

                            i++;
                        }
                    }
                    CancelarConj();
                }
            });
        }
    });

}

function CadCruzamento() {
    $("#mpCadCruzamento").modal("show");
    $("#hdfId").val($("#txtIdLocal").val());
    document.getElementById("btnSalvarCruz").value = getResourceItem("salvar");
    document.getElementById("txtLat").value = "";
    document.getElementById("txtLong").value = "";

    Geocodificacao();

    if (document.getElementById("tdSerial").style.display == "" && document.getElementById("tfControlador").style.display == "") {
        document.getElementById("btnSalvarCruz").value = getResourceItem("salvarAlteracoes");
        document.getElementById("btnExcluirCruz").style.visibility = "visible";
        return;
    }
    else if (document.getElementById("tdSerial").style.display == "") {
        document.getElementById("btnSalvarCruz").value = getResourceItem("salvarAlteracoes");
    }
    document.getElementById("btnExcluirCruz").style.visibility = "hidden";

    //document.getElementById("txtEmpresa").value = "";
}

function SalvarCruzamento() {
    var idDna = document.getElementById("txtIdLocal").value;
    //if (idDna == "") {
    //	document.getElementById("txtIdLocal").style.borderColor = 'red';
    //	return;
    //}
    //else {
    //	document.getElementById("txtIdLocal").style.borderColor = 'rgb(169, 169, 169)';
    //}

    var Dna = document.getElementById("txtCruzamento").value.replace("'", "");
    if (Dna == "") {
        document.getElementById("txtCruzamento").style.borderColor = 'red';
        return;
    }
    else {
        document.getElementById("txtCruzamento").style.borderColor = 'rgb(169, 169, 169)';
    }
    if (document.getElementById("txtSerialCad").value == "") {
        document.getElementById("txtSerialCad").style.borderColor = 'red';
        $("#txtSerialCad").focus();
        return;
    }
    else {
        document.getElementById("txtSerialCad").style.borderColor = 'rgb(169, 169, 169)';
    }

    var Latitude = document.getElementById("txtLat").value;
    if (Latitude == "") {
        document.getElementById("txtLat").style.borderColor = 'red';
        return;
    }
    else {
        document.getElementById("txtLat").style.borderColor = 'rgb(169, 169, 169)';
    }

    var Longitude = document.getElementById("txtLong").value;
    if (Longitude == "") {
        document.getElementById("txtLong").style.borderColor = 'red';
        return;
    }
    else {
        document.getElementById("txtLong").style.borderColor = 'rgb(169, 169, 169)';
    }


    if (document.getElementById("btnSalvarCruz").value == getResourceItem("salvar")) {
        $.ajax({
            type: 'POST',
            url: '../../WebServices/cadDna.asmx/Salvar',
            dataType: 'json',
            data: "{'idDna':'" + $("#txtSerialCad").val() + "','Dna':'" + Dna + "','Latitude':'" + Latitude + "','Longitude':'" + Longitude + "','User':'" + document.getElementById("hfUser").value + "','modelo':'" + $("#txtModelo").val() + "','serialMestre':'" + $("#txtMestre").val() + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d != "SUCESSO") {
                    switch (data.d) {
                        case getResourceItem("idDnaJaFoiVinculado"):
                        case getResourceItem("serialExistente"):
                        case getResourceItem("DnaNaoExiste"):
                            document.getElementById("pInfoCad").style.display = "";
                            document.getElementById("spaInfoCad").innerHTML = data.d;
                            swal(getResourceItem("atencao"), data.d, "warning");
                            break;
                    }
                    return;
                }
                $("#hdfId").val($("#txtIdLocal").val());
                UploadFile($("#myfile")[0]);
                saveEqp();
                $("#divArquivos").slideToggle();
                $("#tblArquivos").slideToggle();
                CarregaListaCroqui();
                //swal(getResourceItem("informacao"), getResourceItem("salvoComSucesso"), "success");
            }
        });
    }
    else {
        var idDna = document.getElementById("hdfId").value;
        $.ajax({
            type: 'POST',
            url: '../../WebServices/cadDna.asmx/Editar',
            dataType: 'json',
            data: "{'idDna':'" + $("#txtSerialCad").val() + "','Dna':'" + Dna + "','Latitude':'" + Latitude + "','Longitude':'" + Longitude + "','User':'" + document.getElementById("hfUser").value + "','modelo':'" + $("#txtModelo").val() + "','serialMestre':'" + $("#txtMestre").val() + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                CancelarCad();
                swal(getResourceItem("informacao"), getResourceItem("salvoComSucesso"), "success");
            }
        });
    }

    $("#txtEndereco").val($("#txtCruzamento").val());

    $("#mpCadCruzamento").modal("hide");
}

function UploadFile(fileUpload) {
    if (fileUpload.value != '' && $("#btnSalvarCruz").val() != getResourceItem("salvar")) {
        $("#hdfId").val($("#txtIdLocal").val());
        var fi = document.getElementById("myfile");

        if (fi.files.length > 0) {

            for (var i = 0; i <= fi.files.length - 1; i++) {
                var name = fi.files.item(i).name;
                var fsize = fi.files.item(i).size;
                var reader = new FileReader();
                reader.onload = function (e) {
                    var base64 = e.target.result;
                    base64 = base64.replace(/^[^,]*,/, '');
                    $.ajax({
                        type: 'POST',
                        url: 'Default.aspx/SalvarArquivo',
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        data: "{'base64':'" + JSON.stringify(base64) + "','NomeArquivo':'" + name + "','idEqp':'" + $("#hdfId").val() + "'}",
                        success: function (data) {
                            CarregaListaCroqui();
                            $("#divArquivos").slideToggle();
                            $("#tblArquivos").slideToggle();
                        }
                    });
                }
                reader.readAsDataURL(fi.files.item(i));

            }
        }
    }
}

function CarregaListaCroqui() {
    //"jpg", "png", "gif", "zip", "rar", "gz", "tgz", "jpeg", "pdf", "doc", "docx", "xlsx", "xls"
    $.ajax({
        type: 'POST',
        url: '../../WebServices/cadDna.asmx/CarregaArquivosCroqui',
        dataType: 'json',
        data: "{'idEqp':'" + $("#hdfId").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var i = 0;
            $("#tbArquivos").empty();
            if (data.d.length == 0) {
                var newRow = $("<tr>");
                var cols = "<td colspan='5'>" + getResourceItem("naoHaRegistros") + "</td>";
                newRow.append(cols);
                $("#tbArquivos").append(newRow);
            }
            while (data.d[i]) {
                var newRow = $("<tr>");
                var cols = "";

                if (data.d[i].NomeArquivo.toLowerCase().indexOf(".jpg") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".png") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".gif") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".jpeg") > -1) {
                    cols += "<td style=\"line-height: 34px;width: 1px;\"> <a class=\"example-image-link\" href=\"ArquivoCroqui/" + data.d[i].NomeArquivo + "\" data-lightbox=\"example-set\" data-title=\"" + data.d[i].NomeArquivo + "\"> <img style=\"width:32px;height:32px;\" src=\"ArquivoCroqui/" + data.d[i].NomeArquivo + "\"></a> </td>";
                }
                else {
                    cols += "<td style=\"line-height: 34px;font-size: 24px;width: 1px;\"> <i class=\"glyphicon glyphicon-file\"></i></td>";
                }
                cols += "<td style=\"line-height: 34px;white-space: -moz-pre-wrap !important;white-space: -webkit-pre-wrap;white-space: -pre-wrap; white-space: -o-pre-wrap;  white-space: pre-wrap;word-wrap: break-word;word-break: break-all;white-space: normal;\">" + data.d[i].NomeArquivo + "</td>";
                if (data.d[i].NomeArquivo.toLowerCase().indexOf(".jpg") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".png") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".gif") > -1 || data.d[i].NomeArquivo.toLowerCase().indexOf(".jpeg") > -1) {
                    cols += "<td style=\"line-height: 34px;width: 1px;\"><input type=\"button\" value=\"" + getResourceItem("visualizar") + "\" class=\"btn btn-info\" onclick=\"ViewFile('" + data.d[i].NomeArquivo + "')\"  href=\"ArquivoCroqui/" + data.d[i].NomeArquivo + "\" /> </td>";
                }
                else {
                    cols += "<td></td>";
                }
                cols += "<td style=\"width: 1px;\"><a class=\"btn btn-success\" target=\"_blank\"  href=\"ArquivoCroqui/" + data.d[i].NomeArquivo + "\" download id=\"download\"><span class=\"glyphicon glyphicon-download-alt\" style=\"padding-right: 4px;\"></span>Download</a></td>";

                cols += "<td style=\"width: 1px;\"><button type=\"button\" class=\"btn btn-danger\" onclick=\"ExcluirArquivo('" + data.d[i].Id + "','" + data.d[i].NomeArquivo + "');\"><span class=\"glyphicon glyphicon-remove-circle\" style=\"padding-right: 4px;\"></span>" + getResourceItem("excluir") + "</button></td>";
                newRow.append(cols);
                $("#tbArquivos").append(newRow);
                i++;
            }
        }

    });
}

var modal = document.getElementById('myModal');
function ViewFile(nomeArq) {
    modal.style.display = "block";
    $("#img01")[0].src = "ArquivoCroqui/" + nomeArq;
}

function closeModal() {
    modal.style.display = "none";
}

function ExcluirArquivo(id, nomeArquivo) {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/cadDna.asmx/ExcluirArquivo',
        dataType: 'json',
        data: "{'Id':'" + id + "','NomeArquivo':'" + nomeArquivo + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            CarregaListaCroqui();
        }
    });
}

function Mestre() {
    $("#txtMestre").val("");
    if ($("#chkConjugado")[0].checked) {
        document.getElementById("txtMestre").disabled = false;
    }
    else {
        document.getElementById("txtMestre").disabled = true;
    }
}

function Geocodificacao(endereco) {

    if (endereco == undefined || endereco == '') {
        endereco = document.getElementById("txtPesqEndereco").value;
    }
    if (endereco == '') {
        endereco = document.getElementById("txtCruzamento").value;
    }
    if (endereco != "") {
        geocoder = new google.maps.Geocoder();
        geocoder.geocode({ 'address': endereco + ' Foz do Iguaçu, Brasil', 'region': 'BR' }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[0]) {
                    var latitude = results[0].geometry.location.lat();
                    var longitude = results[0].geometry.location.lng();

                    document.getElementById("txtLat").value = latitude;
                    document.getElementById("txtLong").value = longitude;

                    var latlng = new google.maps.LatLng(latitude, longitude);

                    var options = {
                        zoom: 5,
                        center: latlng,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    };

                    map = new google.maps.Map(document.getElementById("map"), options);

                    marker = new google.maps.Marker({
                        map: map,
                        draggable: true,
                        position: latlng
                    });
                    map.setZoom(15);
                    document.getElementById("map").style.visibility = "visible";

                    geocoder = new google.maps.Geocoder();
                    google.maps.event.addListener(marker, 'drag', function () {
                        geocoder.geocode({ 'latLng': marker.getPosition() }, function (results, status) {
                            if (status == google.maps.GeocoderStatus.OK) {
                                if (results[0]) {
                                    //$("#txtCruzamento").val(results[0].formatted_address);
                                    $("#txtPesqEndereco").val(results[0].formatted_address);
                                    $("#txtLat").val(marker.getPosition().lat());
                                    $("#txtLong").val(marker.getPosition().lng());
                                }
                            }
                        });
                    });

                }
                else {
                    document.getElementById("map").style.visibility = "hidden";
                }
            }
        });
    }
}

function ExcluirCruzamento() {
    var idDna = document.getElementById("txtSerialCad").value;
    $.ajax({
        type: 'POST',
        url: '../../WebServices/cadDna.asmx/Excluir',
        dataType: 'json',
        data: "{'idDna':'" + idDna + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var lst = data.d[0].split('@');
            var controlador = lst[0];

            if (controlador == "true") {
                alert(getResourceItem("jaExisteControladorVinculadoPonto") + "!");
            }

            swal(getResourceItem("excluido"), getResourceItem("excluidoSucesso"), "success");
            CancelarCad();
            //pesqEqp();
        }
    });
}

function editEqp(handler, tipo) {
    var serial = $(handler).data("id");
    var idConsorcio = $(handler).data("idconsorcio");

    $("#trConjugado").css("display", "block");
    $("#trEnderecoDNA").css("display", "none");
    document.getElementById("divInfoEmpCet").style.display = "none";
    var tr = $(handler).closest('tr');
    $("#ctrlMestre").val(tr.find('td').eq(0).text());
    clearFieldsCad();
    callServer("../../WebServices/CadEqp.asmx/GetDadosConjugado", "{'idDNA':'" + tr.find('td').eq(0).text() + "'}", function (resul) {
        var i = 0;
        if (resul[0] == "NULL") {
            document.getElementById("chkConjugado").checked = false;
            $("#tdDNAMestre").css("display", "none");
            $("#trEnderecoDNA").css("display", "none");
            document.getElementById("liConj").style.visibility = "visible";
            document.getElementById("Conjugados").style.visibility = "visible";

            $.ajax({
                url: '../../WebServices/CadEqp.asmx/GetConjugadosMestre',
                data: "{'idDNA':'" + tr.find('td').eq(0).text() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbConj").empty();
                    if (data.d != "") {

                        var i = 0;
                        while (data.d[i]) {
                            var lst = data.d[i].split('@');

                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst[1] + "</td>";
                            cols += "<td>" + lst[0] + "</td>";

                            newRow.append(cols);
                            $("#tblConj").append(newRow);

                            i++;
                        }
                    }
                    CancelarConj();
                }
            });
        }
        else {
            document.getElementById("liConj").style.visibility = "hidden";
            document.getElementById("Conjugados").style.visibility = "hidden";
            document.getElementById("spnEndereco").innerHTML = resul[1];
            document.getElementById("txtDNAMestre").value = resul[0];
            document.getElementById("spnSerialMestre").innerHTML = resul[0];

            document.getElementById("chkConjugado").checked = true;
            $("#tdDNAMestre").css("display", "block");
            $("#trEnderecoDNA").css("display", "");

        }
    });

    document.getElementById("chkConjugado").checked = false;
    $("#trEnderecoDNA").css("display", "none");
    $("#spnValidaDNAMestre").css("display", "none");
    document.getElementById("txtDNAMestre").value = "";
    document.getElementById("spnSerialMestre").value = "";
    $("#tdDNAMestre").css("display", "none");

    document.getElementById("txtSerialCad").value = tr.find('td').eq(1).text();
    document.getElementById("txtSerialCad").disabled = true;
    document.getElementById("txtDDNS").value = tr.find('td').eq(2).text();
    document.getElementById("txtIP").value = tr.find('td').eq(3).text();
    document.getElementById("txtPortaSnmpMib").value = tr.find('td').eq(4).text();
    document.getElementById("txtPortaSnmpTrap").value = tr.find('td').eq(5).text();

    if (tr.find('td').eq(11).text() == "Desativado") {
        $("#chkResetPorRequisicao")[0].checked = false;
    }
    else {
        $("#chkResetPorRequisicao")[0].checked = true;
    }
    document.getElementById("imgPesqSerialControl").style.display = "none";
    if (tr.find('td').eq(6).text() == "True") {
        $("#chkIpTrap").prop("checked", true);
    }
    else {
        $("#chkIpTrap").prop("checked", false);
    }
    switch (tipo) {
        case "controller":
            $("#hInfoCad").append("Editar Controlador");
            document.getElementById("divCadController").style.display = "";
            document.getElementById("txtPortaReset").value = tr.find('td').eq(7).text();
            if (tr.find('td').eq(3).text() == "Habilitado") {
                $("#chkHabilitaCentral").prop("checked", true);
            }
            else {
                $("#chkHabilitaCentral").prop("checked", false);
            }
            if (tr.find('td').eq(4).text() == "Sem comunicação") {
                $("#chkSemComunicacao").prop("checked", true);
            }
            else {
                $("#chkSemComunicacao").prop("checked", false);
            }
            if (idConsorcio != 0) {
                switch (idConsorcio) {
                    case 1:
                        document.getElementById("spaConsorcio").innerHTML = "CONSORCIO SINAL PAULISTANO";
                        break;
                    case 2:
                        document.getElementById("spaConsorcio").innerHTML = "CONSORCIO ONDAVERDE";
                        break;
                    case 3:
                        document.getElementById("spaConsorcio").innerHTML = "CONSORCIO MCS";
                        break;
                    case 4:
                        document.getElementById("spaConsorcio").innerHTML = "CONSORCIO SEMAFORICO PAULISTANO";
                        break;
                }
                document.getElementById("divInfoEmpCet").style.display = "";
                loadEmpresaCet(idConsorcio);
            }
            break;
        case "nobreak":
            $("#hInfoCad").append(getResourceItem("salvarAlteracoes") + " Nobreak");
            document.getElementById("divCadController").style.display = "none";
            break;
    }

    $("#popupEqp").modal("show");
}


function pesqSerialControl() {
    if (document.getElementById("txtSerialCad").value == "") {
        return;
    }
    callServer("../../WebServices/CadEqp.asmx/GetEqpOff", "{ 'serial': '" + document.getElementById("txtSerialCad").value + "'}", function (item) {
        if (item.length > 0) {
            document.getElementById("hInfoCad").innerHTML = getResourceItem("salvarAlteracoes") + " " + getResourceItem("controlador");
            document.getElementById("txtDDNS").value = item[0].ddns;
            document.getElementById("txtIP").value = item[0].ip;
            document.getElementById("txtPortaSnmpMib").value = item[0].portaSnmpMib;
            document.getElementById("txtPortaSnmpTrap").value = item[0].portaSnmpTrap;
            document.getElementById("txtPortaReset").value = item[0].portaReset;
            if (item[0].bRecebeIpTrap == "True") {
                document.getElementById("chkIpTrap").checked = true;
            }
            else {
                document.getElementById("chkIpTrap").checked = false;
            }
        }
    });
}

function openCad(tipo) {
    clearFieldsCad();
    document.getElementById("txtSerialCad").disabled = false;
    document.getElementById("chkIpTrap").checked = true;
    document.getElementById("chkHabilitaCentral").checked = false;
    if (document.getElementById("txtIdLocal").value == "") {
        document.getElementById("txtIdDnaCad").disabled = false;
    }
    else {
        document.getElementById("txtIdDnaCad").value = document.getElementById("txtIdLocal").value;
        document.getElementById("txtIdDnaCad").disabled = true;
    }

    switch (tipo) {
        case "controller":
            $("#hInfoCad").append(getResourceItem("cadastrar") + " " + getResourceItem("controlador"));
            $("#trConjugado").css("display", "block");
            $("#trEnderecoDNA").css("display", "none");
            document.getElementById("divInfoEmpCet").style.display = "none";
            document.getElementById("divCadController").style.display = "";
            document.getElementById("imgPesqSerialControl").style.display = "";
            break;
        case "nobreak":
            $("#hInfoCad").append(getResourceItem("cadastrar") + " Nobreak");
            $("#trConjugado").css("display", "none");
            $("#trEnderecoDNA").css("display", "none");
            document.getElementById("divCadController").style.display = "none";
            document.getElementById("imgPesqSerialControl").style.display = "none";
            break;
    }

    $("#popupEqp").modal("show");
}

function clearFieldsCad() {
    $("#sleEmpresa").empty().append($("<option></option>").val("").html(""));
    document.getElementById("divInfoEmpCet").style.display = "none";
    document.getElementById("txtIdDnaCad").value = "";
    document.getElementById("txtDDNS").value = "";
    document.getElementById("txtIP").value = "";
    document.getElementById("txtPortaSnmpMib").value = "";
    document.getElementById("txtPortaSnmpTrap").value = "";
    document.getElementById("txtPortaReset").value = "";
    $("#hInfoCad").empty();
}

var callServer = function (urlName, params, callback) {
    document.getElementById("divLoading").style.display = "block";
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
            document.getElementById("divLoading").style.display = "none";
        },
        error: function (data) {
            window.location.reload(true);
        }
    });
};

$("#txtPesqEndereco").autocomplete({
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
            }
        });
    },
    select: function (e, i) {
        $("#txtPesqEndereco").val(i.item.label);
        document.getElementById("txtIdLocal").value = i.item.val;
        Geocodificacao();
    },
    minLength: 1

});

function GetControls(sleDisponibilidade) {
    callServer("../../WebServices/CadEqp.asmx/GetControls", "{'disponivel': '" + sleDisponibilidade + "'}", function (eqp) {
        $("#tbControladores").empty();
        if (eqp.length == 0) {
            $("#spaInfoControl").css("display", "block");
            $("#tblControladores").css("display", "none");
            $("#divRelatorio").css("display", "none");
        }
        else {
            $("#spaInfoControl").css("display", "none");
            $("#tblControladores").css("display", "block");
            $("#divRelatorio").css("display", "block");
            $.each(eqp, function (index, item) {
                var newRow = $("<tr>");
                var cols = "";
                cols += "<td>" + item.serial + "</td>";
                cols += "<td>" + item.idDna + "</td>";
                cols += "<td>" + item.disponivel + "</td>";
                cols += "<td>" + item.ip + "</td>";
                cols += "<td>" + item.dtAtualizacao + "</td>";

                newRow.append(cols);
                $("#tblControladores").append(newRow);
            });
            $("#popupControladores").modal("show");
        }
    });
}

function PesquisaControl() {
    var sleDisponibilidade = document.getElementById('sleDisponibilidade').value;

    if (sleDisponibilidade != 0) {
        GetControls(sleDisponibilidade);
        $("#btnExcluirControladores").css("display", "block");

    }
}

document.getElementById('btnImprimirHistoControl').onclick = function () {
    $("#scrollControls").css("overflow-y", "hidden");
    $("#scrollControls").css("height", "auto");
    $("#divTitle").css("display", "block");
    document.body.innerHTML =
        "<html><head><title></title></head><body>" +
        document.getElementById("scrollControls").innerHTML + "</body>";
    window.print();
    window.location.reload(true);
}