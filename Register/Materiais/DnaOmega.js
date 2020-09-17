
var idDepartamento = "";
var idPatrimonio = "";
var idProduto = "";
var idSubdivisaoMov = "";
var SubdivisaoMov = "";
var idPatrimonioCtrl = "";

function FindDNA() {
    $("#btnAdcParamPlacaCtrl").css("display", "none");
    $("#btnPorParamColuna").css("display", "none");
    $("#btnPorParamCabo").css("display", "none");
    $("#btnPorParamGF").css("display", "none");
    $("#btnPorParamSI").css("display", "none");
    $("#btnPorParamAcess").css("display", "none");
    document.getElementById("ddlFormaOperacional").disabled = false;
    $("#ddlFormaOperacional").val("─ SELECIONE ─");
    $("#pnlAdcCtrl").css("display", "none");
    $("#pnlCtrlEditarDetalhes").css("display", "none");
    $("#tblformaoperacional").css("display", "none");
    $("#txtIdLocal").val(document.getElementById("hfIdDna").value);
    $("#lnkNovaPlaca").css("display", "block");
    $("#lnkNovoGprs").css("display", "block");
    //document.getElementById("hfIdDna").value;
    //document.getElementById("hfIdDnaGSS").value;

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getSubdivisao',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'idLocal':'" + document.getElementById("hfIdDna").value + "', " +
            " 'Endereco':'" + document.getElementById("hfEndereco").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                var getSub = data.d;
                document.getElementById("hfIdSub").value = getSub[0].idSub;

                $("#txtDtDeflagracao").val(getSub[0].DtDeflagracao);
                $("#txtRespVistoria").val(getSub[0].ResponsavelVistoria);
                $("#txtRegistroCET").val(getSub[0].RegistroCET);
                $("#txtRegistroCREA").val(getSub[0].RegistroCREA);
                $("#txtEngResponsavel").val(getSub[0].EngResponsavel);

                if (getSub[0].Endereco != null || getSub[0].Endereco != undefined) {
                    document.getElementById("hfEndereco").value = getSub[0].Endereco;
                    $("#txtEndereco").val(getSub[0].Endereco);
                }

                idDepartamento = getSub[0].idDepartamento;
                $("#hfIdDepartamento").val(idDepartamento);
                if (getSub[0].Subdivisao != null || getSub[0].Subdivisao != undefined) {
                    document.getElementById("hfIdDna").value = getSub[0].Subdivisao;
                    $("#txtIdLocal").val(getSub[0].Subdivisao);
                }
                $("#divMateriais").css("display", "block");
            }
            else {
                alert("Esse cruzamento não foi encontrado!");
                $("#divMateriais").css("display", "none");
            }

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
                        document.getElementById("lnkDetalhesCtrl").innerHTML = "Detalhes do controlador";
                        $("#pnlAdcCtrl").css("display", "none");
                        $("#divAdcCtrl").css("display", "none");
                        $("#pnlAdcCtrlImplantacao").css("display", "none");
                        var lst = data.d[0].split('@');
                        $("#lnkDetalhesCtrl").data("IdPatrimonio", lst[1]);
                        $("#lnkCtrlManutencao").data("id", lst[1]);
                        idPatrimonioCtrl = lst[1];
                        idPatrimonio = lst[1];
                        idDepartamento = lst[2];
                        var nmrSerie = lst[3];
                        $("#txtNmrSerie").val(nmrSerie);
                        document.getElementById("lblNmrPatCtrl").innerHTML = lst[4];
                        document.getElementById("lblModeloCtrl").innerHTML = lst[5];
                        if (lst[0] == "Conjugado") {
                            $("#pnlCtrlEditarDetalhes").css("display", "none");
                            $("#tblMestreIsol").css("display", "none");
                            $("#pnlCtrlDados").css("display", "block");
                            $("#tblSelSubMestre").css("display", "none");
                            $("#tblConjugado").css("display", "block");
                            document.getElementById("lblMestre").innerHTML = lst[1];
                            var subdivisao = lst[1];
                            var n = subdivisao.indexOf("-");
                            if (n > 0) {
                                document.getElementById("txtIdLocalMestre").value = subdivisao.substring(0, n).trim();
                            }
                            else {
                                document.getElementById("txtIdLocalMestre").value = subdivisao;
                            }
                            document.getElementById("lblFormaOperacionalCtrl").innerHTML = "CONJUGADO";
                            document.getElementById("lnkDetalhesCtrl").innerHTML = "Editar";
                            $("#divCtrlConj").css("display", "none");
                            $("#divPlacaCtrl").css("display", "none");
                            $("#divGprsCtrl").css("display", "none");
                        }
                        else if (lst[0] == "Mestre") {

                            $("#divCtrlConj").css("display", "block");
                            $("#divPlacaCtrl").css("display", "block");
                            $("#divGprsCtrl").css("display", "block");
                            $("#tblConjugado").css("display", "none");
                            $("#tblSelSubMestre").css("display", "none");
                            $("#pnlCtrlDados").css("display", "block");
                            $("#tblMestreIsol").css("display", "block");
                            $("#pnlConjugados").css("display", "block");
                            $("#pnlCtrlEditarDetalhes").css("display", "none");
                            document.getElementById("lblFormaOperacionalCtrl").innerHTML = "MESTRE";

                            var i = 0;
                            $("#tblConjugados").css("display", "table");
                            $("#TfConjugados").css("display", "none");
                            $("#tbConjugados").empty();
                            while (data.d[i]) {

                                var lst = data.d[i].split('@');

                                var newRow = $("<tr>");
                                var cols = "";
                                if (lst[6] != undefined && lst[7] != undefined) {
                                    cols += "<td style='padding-top: 14px;'>" + lst[8] + "</td>";
                                    cols += "<td style='padding-top: 14px;'>" + lst[7] + "</td>";

                                    newRow.append(cols);
                                    $("#tblConjugados").append(newRow);

                                }
                                else {
                                    $("#TfConjugados").css("display", "table-footer-group");
                                    $("#tbConjugados").empty();
                                }
                                i++
                            }
                        }
                        else {
                            $("#divCtrlConj").css("display", "none");
                            $("#divPlacaCtrl").css("display", "block");
                            $("#divGprsCtrl").css("display", "block");

                            $("#tblConjugado").css("display", "none");
                            $("#tblSelSubMestre").css("display", "none");
                            $("#pnlCtrlDados").css("display", "block");
                            $("#tblMestreIsol").css("display", "block");
                            $("#pnlConjugados").css("display", "block");
                            $("#pnlCtrlEditarDetalhes").css("display", "none");
                            document.getElementById("lblFormaOperacionalCtrl").innerHTML = "ISOLADO";
                        }
                    }
                    else {
                        $("#tblSelSubMestre").css("display", "none");
                        $("#divAdcCtrl").css("display", "block");
                        $("#pnlCtrlDados").css("display", "none");
                        $("#divCtrlConj").css("display", "none");
                        $("#divPlacaCtrl").css("display", "none");
                        $("#divGprsCtrl").css("display", "none");
                        $("#pnlAdcCtrlImplantacao").css("display", "none");
                    }

                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/findPlacaCtrl',
                        dataType: 'json',
                        data: "{'idDepartamento':'" + idDepartamento + "','idSub':'" + document.getElementById("hfIdSub").value + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d != "") {
                                var i = 0;
                                $("#tblPlaca").css("display", "table");
                                $("#tbPlaca").empty();
                                while (data.d[i]) {

                                    var lst = data.d[i].split('@');

                                    var newRow = $("<tr>");
                                    var cols = "";

                                    cols += "<td style='padding-top: 14px;'>" + lst[0] + "</td>";
                                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";

                                    cols += "<td style='padding: 5px;'> " +
                                        " <button type='button' class='btn btn-icon btn-info' " +
                                        " onclick='SelectPlacaCtrl(this)' data-idpatrimonioplaca='" + lst[4] + "'> " +
                                        " <i class='ft-edit-3'></i></button></td>";
                                    cols += "<td style='padding: 5px;'> " +
                                        " <button type='button' class='btn btn-outline-secondary' title='Placa' " +
                                        " onclick='MovimentarManutencao(this)' data-id='" + lst[5] + "'>Manutenção</a></td>";

                                    newRow.append(cols);
                                    $("#tblPlaca").append(newRow);
                                    i++
                                }
                            }
                            else {
                                $("#tblPlaca").css("display", "none");
                                $("#tbPlaca").empty();
                            }

                            $("#pnlPlaca").css("display", "block");
                            $("#pnlAdcPlaca").css("display", "none");
                            $("#pnlGrdPlacaCtrl").css("display", "none");
                            $("#dvGrdPlacas").css("display", "block");
                            $("#pnlPlacaDetalhe").css("display", "none");
                        },
                        error: function (data) {
                        }
                    });

                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/findGprsCtrl',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','idSub':'" + document.getElementById("hfIdSub").value + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d != "") {
                                var lstGprs = data.d[0].split('@');
                                $("#lnkDetalhesGprsCtrl").data("id", lstGprs[0]);
                                $("#linkGprsCtrlManutencao").data("id", lstGprs[0]);

                                var dtInstalacao = lstGprs[2];
                                var dtGarantia = lstGprs[1];

                                document.getElementById("txtGprsDtGarantia").value = dtGarantia.replace(" ", "T").replace("/", "-").replace("/", "-");
                                document.getElementById("txtGprsDtInstalacao").value = dtInstalacao.replace(" ", "T").replace("/", "-").replace("/", "-");

                                document.getElementById("txtGprsFab").value = lstGprs[3];
                                document.getElementById("lblModeloGprsCtrl").innerHTML = document.getElementById("txtGprsModelo").value = lstGprs[4];
                                document.getElementById("lblNmrLinhaGprsCtrl").innerHTML = document.getElementById("txtGprsNrLinha").value = lstGprs[5];
                                document.getElementById("lblNmrPatGprsCtrl").innerHTML = document.getElementById("txtGprsNumPat").value = lstGprs[6];
                                document.getElementById("txtGprsNumSerie").value = lstGprs[7];
                                $("#ddlGprsEstadoOperacional").val(lstGprs[8]);
                                $("#ddlGprsOperadora").val(lstGprs[9]);
                                $("#tblNewGprs").css("display", "none");
                                $("#pnlAdcGprsCtrl").css("display", "none");
                                $("#pnlSelGprs").css("display", "none");
                                $("#pnlDadosGprsCtrl").css("display", "block");
                                $("#pnlEditarGprsCtrl").css("display", "none");
                                $("#btnSalvarGpsC").val("Salvar");
                            }
                            else {
                                $("#tblNewGprs").css("display", "block");
                                $("#pnlAdcGprsCtrl").css("display", "none");
                                $("#pnlSelGprs").css("display", "none");
                                $("#pnlDadosGprsCtrl").css("display", "none");
                                $("#pnlEditarGprsCtrl").css("display", "none");
                                $("#btnSalvarGpsC").val("Salvar");
                            }
                        },
                        error: function (data) {
                        }
                    });
                },
                error: function (data) {
                }
            });

            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findNobreak',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {
                        var lst = data.d[0].split('@');
                        idPatrimonio = lst[0];
                        $("#lnkManutencaoNbr").data("id", lst[0]);
                        $("#txtNbkAutonomia").val(lst[1]);
                        document.getElementById("lblFabNbr").innerHTML = lst[3];
                        $("#txtNbkFabricante").val(lst[3]);

                        var dtInstalacao = lst[4].replace(" ", "T").replace("/", "-").replace("/", "-");
                        var dtGarantia = lst[2].replace(" ", "T").replace("/", "-").replace("/", "-");

                        document.getElementById("txtNbkDataGarantia").value = dtGarantia;
                        document.getElementById("txtNbkDataInstal").value = dtInstalacao;
                        

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
                        $("#lnkAdcNobreak").css("display", "block");
                        $("#pnlDetailsNbr").css("display", "none");
                        $("#pnlGrdAddNobreak").css("display", "none");
                        $("#pnlCadastroNobreak").css("display", "none");
                        $("#pnlAddNbk").css("display", "none");
                    }

                    $("#btnEditNobreak").html("Salvar");

                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/findGprsNbrk',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                            " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
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

                                var dtInstalacao = lst[5].replace(" ", "T").replace("/", "-").replace("/", "-");
                                var dtGarantia = lst[4].replace(" ", "T").replace("/", "-").replace("/", "-");

                                document.getElementById("txtDtGarantiaGprsNbk").value = dtGarantia;
                                document.getElementById("txtDtInstalGprsNbk").value = dtInstalacao;

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

            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findColuna',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {
                        $("#tbladcNewcols").css("display", "block");
                        $("#pnlAdcColuna").css("display", "none");
                        $("#pnlGrdAdcColuna").css("display", "none");
                        $("#pnlDadosColuna").css("display", "none");
                        $("#pnlColunas").css("display", "block");
                        $("#btnAddColuna").val("Salvar");
                        var i = 0;
                        $("#tblColunas").css("display", "table");
                        $("#tbColunas").empty();
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');

                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[4] + "</td>";

                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-icon btn-info' " +
                                " onclick='SelectColuna(this)' data-id='" + lst[0] + "'> " +
                                " <i class='ft-edit-3'></i></button></td>";
                            cols += "<td style='padding: 5px;'> "+
                                " <button type='button' class='btn btn-outline-secondary' " +
                                " title='Coluna' onclick='MovimentarManutencao(this)' " +
                                " data-id='" + lst[0] + "'>Manutenção</button></td>";

                            newRow.append(cols);
                            $("#tblColunas").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblColunas").css("display", "none");
                        $("#tbladcNewcols").css("display", "block");
                        $("#pnlAdcColuna").css("display", "none");
                        $("#pnlGrdAdcColuna").css("display", "none");
                        $("#pnlDadosColuna").css("display", "none");
                        $("#pnlColunas").css("display", "none");
                        $("#btnAddColuna").val("Salvar");
                    }
                },
                error: function (data) {
                }
            });

            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findCabo',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#tblAdcCabo").css("display", "block");
                        $("#pnlAdcCabo").css("display", "none");
                        $("#pnlGrdAdcCabo").css("display", "none");
                        $("#pnlDadosCabo").css("display", "none");
                        $("#pnlCabos").css("display", "block");
                        $("#btnSalvarCabos").val("Salvar");
                        var i = 0;
                        $("#tblCabos").css("display", "table");
                        $("#tbCabos").empty();
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');
                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[4] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[5] + "</td>";

                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-icon btn-info' " +
                                " onclick='SelectCabo(this)' data-id='" + lst[0] + "'> " +
                                " <i class='ft-edit-3'></i></button></td>";
                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-outline-secondary' " +
                                " title='Cabo' onclick='MovimentarManutencao(this)' " +
                                " data-id='" + lst[0] + "'>Manutenção</button></td>";

                            newRow.append(cols);
                            $("#tblCabos").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblCabos").css("display", "none");
                        $("#tblAdcCabo").css("display", "block");
                        $("#pnlAdcCabo").css("display", "none");
                        $("#pnlGrdAdcCabo").css("display", "none");
                        $("#pnlDadosCabo").css("display", "none");
                        $("#pnlCabos").css("display", "none");
                        $("#btnSalvarCabos").val("Salvar");
                    }
                },
                error: function (data) {
                }
            });

            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findGrupoFocal',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {
                        $("#tblAdcGf").css("display", "block");
                        $("#pnlAdcGrupoFocal").css("display", "none");
                        $("#pnlGrdAdcGrupoFocal").css("display", "none");
                        $("#pnlDadosGrupoFocal").css("display", "none");
                        $("#pnlGrupoFocal").css("display", "block");
                        $("#btnEditGrupoFocal").val("Salvar");
                        $("#tblGrupoFocal").css("display", "table");
                        $("#tbGrupoFocal").empty();

                        var i = 0;
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');

                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[4] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[5] + "</td>";

                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-icon btn-info' " +
                                " onclick='SelectGrupoFocal(this)' data-id='" + lst[0] + "'> " +
                                " <i class='ft-edit-3'></i></button></td>";
                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-outline-secondary' " +
                                " title='Grupo Focal' onclick='MovimentarManutencao(this)' " +
                                " data-id='" + lst[0] + "'>Manutenção</button></td>";

                            newRow.append(cols);
                            $("#tblGrupoFocal").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblGrupoFocal").css("display", "none");
                        $("#tblAdcGf").css("display", "block");
                        $("#pnlAdcGrupoFocal").css("display", "none");
                        $("#pnlGrdAdcGrupoFocal").css("display", "none");
                        $("#pnlDadosGrupoFocal").css("display", "none");
                        $("#pnlGrupoFocal").css("display", "none");
                        $("#btnEditGrupoFocal").val("Salvar");
                    }
                },
                error: function (data) {
                }
            });

            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findSistemaIlu',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $("#tblAdcIlu").css("display", "block");
                        $("#pnlAdcIluminacao").css("display", "none");
                        $("#pnlGrdAdcIluminacao").css("display", "none");
                        $("#pnlDadosIlu").css("display", "none");
                        $("#pnlIluminacao").css("display", "block");
                        $("#btnSalvarIlu").val("Salvar");
                        var i = 0;
                        $("#tblIluminacao").css("display", "table");
                        $("#tbIluminacao").empty();
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');

                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[4] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[5] + "</td>";

                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-icon btn-info' " +
                                " onclick='SelectIlum(this)' data-id='" + lst[0] + "'> " +
                                " <i class='ft-edit-3'></i></button></td>";
                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-outline-secondary' " +
                                " title='Sistema de Iluminação' onclick='MovimentarManutencao(this)' " +
                                " data-id='" + lst[0] + "'>Manutenção</button></td>";

                            newRow.append(cols);
                            $("#tblIluminacao").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblIluminacao").css("display", "none");
                        $("#tblAdcIlu").css("display", "block");
                        $("#pnlAdcIluminacao").css("display", "none");
                        $("#pnlGrdAdcIluminacao").css("display", "none");
                        $("#pnlDadosIlu").css("display", "none");
                        $("#pnlIluminacao").css("display", "none");
                        $("#btnSalvarIlu").val("Salvar");
                    }
                },
                error: function (data) {
                }
            });

            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findAcessorio',
                dataType: 'json',
                data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idSub':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "") {
                        $("#tblNewAcess").css("display", "block");
                        $("#pnlAdcAcess").css("display", "none");
                        $("#pnlGrdAdcAcess").css("display", "none");
                        $("#pnlDadosAcessorio").css("display", "none");
                        $("#pnlAcessorios").css("display", "block");
                        $("#btnSalvarAcessorio").val("Salvar");
                        var i = 0;
                        $("#tblAcessorios").css("display", "table");
                        $("#tbAcessorios").empty();

                        while (data.d[i]) {

                            var lst = data.d[i].split('@');
                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                            cols += "<td style='padding-top: 14px;'>" + lst[4] + "</td>";

                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-icon btn-info' " +
                                " onclick='SelectAcessorio(this)' data-id='" + lst[0] + "'> " +
                                " <i class='ft-edit-3'></i></button></td>";
                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-outline-secondary' " +
                                " title='Acessório' onclick='MovimentarManutencao(this)' " +
                                " data-id='" + lst[0] + "'>Manutenção</button></td>";

                            newRow.append(cols);
                            $("#tblAcessorios").append(newRow);
                            i++
                        }
                    }
                    else {
                        $("#tblAcessorios").css("display", "none");
                        $("#tblNewAcess").css("display", "block");
                        $("#pnlAdcAcess").css("display", "none");
                        $("#pnlGrdAdcAcess").css("display", "none");
                        $("#pnlDadosAcessorio").css("display", "none");
                        $("#pnlAcessorios").css("display", "none");
                        $("#btnSalvarAcessorio").val("Salvar");
                    }
                },
                error: function (data) {
                }
            });

            $("#newCad").css("display", "block");
            $("#imgPesquisar").css("display", "block");
            document.getElementById("btnSaveTag").value = "Confirmar";
            document.getElementById("btnSaveTag").style.visibility = "hidden";
            document.getElementById("btnVoltar").style.visibility = "hidden";
            var EPC = document.getElementById("txtEpc").value;
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/findTag',
                dataType: 'json',
                data: "{'EPC':'" + EPC + "', " +
                    " 'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                    " 'idsubdivisao':'" + document.getElementById("hfIdSub").value + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        var i = 0;
                        $("#tblTag").css("display", "table");
                        $("#tbTag").css("display", "contents");
                        $("#tfTag").css("display", "none");
                        $("#tbTag").empty();
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');
                            var Id = lst[0];
                            var EPC = lst[1];

                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td style='padding-top: 14px;'>" + EPC + "</td>";

                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-icon btn-info' " +
                                " onclick='EditEPC(this)' data-id='" + Id + "' " +
                                " data-epc='" + EPC + "'> " +
                                " <i class='ft-edit-3'></i></button></td>";
                            cols += "<td style='padding: 5px;'> " +
                                " <button type='button' class='btn btn-icon btn-danger' " +
                                " onclick='DeleteEPC(this)' data-id='" + Id + "'> " +
                                " <i class='ft-trash-2'></i></button></td>";

                            newRow.append(cols);
                            $("#tbTag").append(newRow);
                            i++
                        }

                    }
                    else {
                        $("#tblTag").css("display", "table");
                        //$("#thTag").css("display", "block");
                        $("#tfTag").css("display", "contents");
                        $("#tbTag").css("display", "none");
                        $("#tbTag").empty();
                    }
                    document.getElementById("txtEpc").value = "";
                    document.getElementById("btnSaveTag").value = "Confirmar";
                },
                error: function (data) {
                }
            });

            CarregarListaDatasImagem();
            CarregarListaProjeto();
            CarregarListaArquivo();

            /*$.ajax({
                type: 'POST',
                url: 'WebService/Materiais.asmx/GetUploadImages_Patrimonio',
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
                        $("#txtMotivo").empty();
                        $("#txtMotivo").append($("<option></option>").val(0).html("Selecione"));
                        while (data.d[i]) {
                            var lst = data.d[i].split('@');
                            var Motivo = lst[0];
                            var id = lst[1];
                            $("#txtMotivo").append($("<option></option>").val(id).html(Motivo));
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
    $("#btnIniciarUpload").css("display", "none");

}

function CarregarListaDatasImagem() {
    $("#divLoading").css("display", "block");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/CarregarListaDatasImagem',
        dataType: 'json',
        data: "{'idLocal':'" + document.getElementById("hfIdSub").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var i = 0;
            $("#ulDataImagem").empty();
            $("#divLoading").css("display", "none");

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
                cols += "<img class=\"img-responsive\" src=\"../../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" alt=\"\">";
                cols += "<div style=\"width: 292px;background-color: #e4e4e4;height: 24px;bottom: 0px;z-index: 99999;position: absolute;padding-top: 3px;/* border: 1px solid darkgrey; */\"><span>" + data.d[i].Hora + "</span></div>";
                cols += "<div class=\"image-gallery-v2-overlay\">";
                cols += "<div class=\"image-gallery-v2-overlay-content\">";
                cols += "    <div class=\"theme-icons-wrap\">";

                cols += "<div class=\"btn-group\">";
                cols += "<a class=\"btn btn-success\"  data-tooltip=\"tooltip\" title=\"Baixar\" target=\"_blank\"  href=\"../../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" download id=\"download\"><span class=\"la la-download\"></span></a>";
                //cols += " <a class=\"btn btn-primary\" data-tooltip=\"tooltip\" title=\"Expandir\" class=\"example-image-link\" href=\"../../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" data-toggle='modal' data-target='#modalGallery' data-lightbox=\"example-set\" data-title=\"" + data.d[i].NomeArquivo + "\"><img  style=\"display:none;\" class=\"img-responsive\" src=\"../../ImagemDepartamento/images/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" alt=\"\"><span class=\"icon-size-fullscreen\"></span></a>";
                cols += '<div class="btn-group dropup"><button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">';
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
    $("#divLoading").css("display", "block");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ExcluirImagem',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: "{'IdArquivo':'" + Id + "','NomeArquivo':'" + NomeArquivo + "','IdDepartamento':'" + idDepartamento + "'}",
        success: function (data) {
            CarregarListaDatasImagem();
            $("#divLoading").css("display", "none");
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
    $("#divLoading").css("display", "block");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/GetUploadProjetos',
        dataType: 'json',
        data: "{'idLocal':'" + document.getElementById("hfIdSub").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#divLoading").css("display", "none");
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
                cols += "<td style=\"width: 1px;\"><a class=\"btn btn-success\" target=\"_blank\" href=\"../../ProjetoDepartamento/arqs/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" download=\"\" id=\"download\"><span class=\"glyphicon glyphicon-download-alt\" style=\"padding-right: 4px;\"></span>Baixar</a></td>";
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
    window.open('../../ProjetoDepartamento/arqs/' + IdDepartamento + "/" + NomeArquivo);
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
    $("#divLoading").css("display", "block");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/GetUploadArquivos',
        dataType: 'json',
        data: "{'idLocal':'" + document.getElementById("hfIdSub").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var i = 0;
            $("#divLoading").css("display", "none");
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
                cols += "<td style=\"width: 1px;\"><a class=\"btn btn-success\" target=\"_blank\" href=\"../../ArquivosDoc/arqs/" + data.d[i].IdDepartamento + "/" + data.d[i].NomeArquivo + "\" download=\"\" id=\"download\"><span class=\"glyphicon glyphicon-download-alt\" style=\"padding-right: 4px;\"></span>Baixar</a></td>";
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
    $("#tblGrdProdutos tbody").find('tr').each(function (i, el) {
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
    $("#divAdcCtrl").css("display", "none");
    $("#pnlAdcCtrl").css("display", "block");
}

function NovoGprs() {

    $("#pnlAdcGprsCtrl").css("display", "block");
    $("#pnlSelGprs").css("display", "none");
    $("#pnlDadosGprsCtrl").css("display", "none");
    $("#pnlEditarGprsCtrl").css("display", "none");
    $("#lnkNovoGprs").css("display", "none");
}

function CancelGprs() {

    FindDNA();
}

function ApagarGprsControl() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ApagarGprsControl',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() +
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

function PorImplantacaoGPRSctrl() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getGprsCtrl',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#pnlSelGprs").css("display", "block");
                $("#tblAdcGprs").css("display", "table");
                $("#bdAdcGprs").empty();
                $("#pnlAdcGprsCtrl").css("display", "none");
                $("#pnlDadosGprsCtrl").css("display", "none");
                $("#pnlEditarGprsCtrl").css("display", "none");
                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectGprsCtrlCad(this)' " +
                        " data-idpatrimonio='" + lst[0] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblAdcGprs").append(newRow);
                }
            }
        },
        error: function (data) {
        }
    })
}

function SelectGprsCtrlCad(value) {
    $("#btnApagarGprsControl").css("display", "none");
    $("#btnSalvarGpsC").val("Salvar");
    $("#pnlSelGprs").css("display", "none");
    $("#pnlAdcGprsCtrl").css("display", "none");
    $("#pnlDadosGprsCtrl").css("display", "none");
    $("#pnlEditarGprsCtrl").css("display", "block");

    $("#txtGprsNumPat").val("");
    $("#txtGprsNrLinha").val("");
    $("#ddlGprsOperadora").val("");

    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();
    var hh = today.getHours();
    var MM = today.getMinutes();
    var ss = today.getSeconds();
    var T = "T";

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
    var hoje = yyyy + '-' + mm + '-' + dd + T + hh + ':' + MM;
    var garantia = (parseInt(yyyy) + 1).toString() + '-' + mm + '-' + dd + T + hh + ':' + MM;

    $("#txtGprsDtInstalacao").val(hoje);
    $("#txtGprsDtGarantia").val(garantia);

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
                $("#txtGprsModelo").val(lst[0]);
                $("#txtGprsFab").val(lst[1]);
                $("#txtGprsNumSerie").val(lst[2]);
            }
        },
        error: function (data) {
        }
    })
}

function SalvarGprsC(value) {

    var nmrPat = $("#txtGprsNumPat").val();
    if (nmrPat == "") {

        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            $("#mpMensagem").modal("show");
            document.getElementById("lblProdNpatrimonio").title = "Gprs Controlador"
            document.getElementById("lblProdNpatrimonio").innerHTML = "Gprs Controlador";
            return;
        }
    }
    else {
        document.getElementById("txtGprsNumPat").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtGprsNumPat").style.placeholder = "";
    }

    var dtInstalacao_formatada = $("#txtGprsDtInstalacao").val().replace("T", " ").replace("-", "/").replace("-", "/");
    var dtGarantia_formatada = $("#txtGprsDtGarantia").val().replace("T", " ").replace("-", "/").replace("-", "/");

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'nmrPatrimonio':'" + nmrPat + "', " +
            " 'idPatrimonio':'" + idPatrimonio + "', " +
            " 'value':'" + value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                alert("Esse número de patrimonio já está vinculado a um produto!");
                return;
            }
            else {
                if (value == "Salvar Alterações") {
                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/EditGprsCtrl',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                            " 'NumeroPatrimonio':'" + nmrPat + "', " +
                            " 'idPatrimonio':'" + idPatrimonio + "', " +
                            " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                            " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                            " 'NmrDaLinha':'" + $("#txtGprsNrLinha").val() + "', " +
                            " 'Operadora':'" + $("#ddlGprsOperadora").val() + "', " +
                            " 'EstadoOperacional':'" + $("#ddlGprsEstadoOperacional").val() + "'}",
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
                        url: '../../WebServices/Materiais.asmx/InsertGprsCtrl',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                            " 'NumeroPatrimonio':'" + nmrPat + "', " +
                            " 'idPatrimonio':'" + idPatrimonio + "', " +
                            " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                            " 'Fabricante':'" + $("#txtGprsFab").val() +
                            "','IdDepartamento':'" + idDepartamento + "', " +
                            " 'idProduto':'" + idProduto + "', " +
                            " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                            " 'modelo':'" + $("#txtGprsModelo").val() + "', " +
                            " 'NumeroSerie':'" + $("#txtGprsNumSerie").val() + "', " +
                            " 'NmrDaLinha':'" + $("#txtGprsNrLinha").val() + "', " +
                            " 'Operadora':'" + $("#ddlGprsOperadora").val() + "', " +
                            " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                            " 'EstadoOperacional':'" + $("#ddlGprsEstadoOperacional").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

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

function DetalhesGprsCtrl(valor) {

    idPatrimonio = $(valor).data("id");
    $("#tblNewGprs").css("display", "none");
    $("#pnlAdcGprsCtrl").css("display", "none");
    $("#pnlSelGprs").css("display", "none");
    $("#pnlDadosGprsCtrl").css("display", "none");
    $("#pnlEditarGprsCtrl").css("display", "block");
    $("#btnSalvarGpsC").val("Salvar Alterações");
    $("#btnApagarGprsControl").css("display", "block");
}

function AdcControladorImplantacao(valor) {

    $("#tblformaoperacional").css("display", "block");
    $("#pnlAdcCtrl").css("display", "none");
    //$("#ddlFormaOperacional").val("─ SELECIONE ─");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getControllers',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#tblProdCtr").css("display", "table");
                $("#tbProdCtr").empty();
                if (valor == "valorDrop") {
                    $("#pnlAdcCtrlImplantacao").css("display", "block");
                }
                else {
                    $("#pnlAdcCtrlImplantacao").css("display", "none");
                }
                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectCtrlCad(this)' " +
                        " data-idpatrimonio='" + lst[0] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblProdCtr").append(newRow);
                }

            }
        },
        error: function (data) {
        }
    });

}

function SelectCtrlCad(value) {
    $("#pnlAdcCtrlImplantacao").css("display", "none");
    $("#pnlCtrlEditarDetalhes").css("display", "block");
    $("#tblformaoperacional").css("display", "block");
    $("#tblEditarDadosCtrl").css("display", "block");
    $("#dvBtnCtrl").css("display", "block");
    $("#btnApagarControlador").css("display", "none");
    document.getElementById("btnCtrlSave").value = "Salvar";
    idProduto = $(value).data("idpatrimonio");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectCadControllers',
        dataType: 'json',
        data: "{'idProduto':'" + idProduto + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var lst = data.d[0].split('@');
                $("#txtProduto").val(lst[0]);
                $("#txtCtrlModelo").val(lst[1]);
                $("#txtCtrlFabricante").val(lst[2]);
                $("#txtNmrSerie").val(lst[3]);
                $("#txtCtrlTipo").val(lst[4]);
            }
        },
        error: function (data) {
        }
    });
}

function SelectPlacaCtrl(value) {
    $("#pnlQtdPlacaCtrl").css("display", "none");
    idPatrimonio = $(value).data("idpatrimonioplaca");
    $("#pnlPlacaDetalhe").css("display", "block");
    $("#pnlPlaca").css("display", "none");
    $("#btnApagarPlaca").css("display", "block");
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
                $("#txtFabricantePlaca").val(lst[1]);
                $("#txtPlacaModelo").val(lst[2]);
                $("#txtPlacaDtInstal").val(lst[3]);
                $("#txtPlacaDtGarantia").val(lst[4]);
                $("#txtNmrPatlaca").val(lst[5]);
                $("#ddlPlacaAtivo").val(lst[6]);
                $("#btnPlacaSave").val("Salvar Alterações");
                $("#txtQtdPlacaCtrl").val("");
                $("#pnlQtdPlacaCtrl").css("display", "none");
            }
        },
        error: function (data) {
        }
    });
}

function NovaPlaca() {

    $("#pnlAdcPlaca").css("display", "block");
    $("#pnlGrdPlacaCtrl").css("display", "none");
    $("#dvGrdPlacas").css("display", "none");
    $("#pnlPlaca").css("display", "block");
    $("#pnlPlacaDetalhe").css("display", "none");
    $("#pnlQtdPlacaCtrl").css("display", "block");
    $("#lnkNovaPlaca").css("display", "none");
}

function CancelPlaca() {
    FindDNA();
}

function PlacaSave(value) {
    var nmrPat = $("#txtNmrPatlaca").val();

    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            $("#mpMensagem").modal("show");
            document.getElementById("lblProdNpatrimonio").innerHTML = "Placa Controlador";
            document.getElementById("lblProdNpatrimonio").title = "Placa Controlador"
            return;
        }
    }
    else {
        document.getElementById("txtNmrPatlaca").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNmrPatlaca").style.placeholder = "";
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
                if (value == "Salvar Alterações") {
                    $.ajax({
                        type: 'POST',
                        url: '../../WebServices/Materiais.asmx/EditPlacaCtrl',
                        dataType: 'json',
                        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','NumeroPatrimonio':'" + nmrPat +
                            "','DataGarantia':'" + $("#txtPlacaDtGarantia").val() + "','idPatrimonio':'" + idPatrimonio +
                            "','DataInstalacao':'" + $("#txtPlacaDtInstal").val() + "','EstadoOperacional':'" + $("#ddlPlacaAtivo").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            FindDNA();
                        },
                        error: function (data) {
                        }
                    });
                }
                else {
                    var quantidade = $("#txtQtdPlacaCtrl").val();
                    var i = 0;
                    if (nmrPat != "") {

                        $.ajax({
                            type: 'POST',
                            url: '../../WebServices/Materiais.asmx/verificaNrPat',
                            dataType: 'json',
                            data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','nmrPatrimonio':'" + $("#txtNmrPatlaca").val() + "','NmrPat':'" + nmrPat + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.d != "") {
                                    alert("Existem Nºs de Patrimonios sendo usado no intervalo de " + $("#txtNmrPatlaca").val() + " a " + (nmrPat - 1) + "!");
                                    return;
                                }
                                else {
                                    nmrPat = $("#txtNmrPatlaca").val();
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
                        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idProduto':'" + idProduto + "','NmrPat':'" + nmrPat +
                            "','quantidade':'" + quantidade + "','DataGarantia':'" + $("#txtPlacaDtGarantia").val() + "','Fabricante':'" + $("#txtFabricantePlaca").val() +
                            "','IdDepartamento':'" + idDepartamento + "','idSubDivisao':'" + $("#hfIdSub").val() + "','modelo':'" + $("#txtPlacaModelo").val() +
                            "','NumeroSerie':'" + $("#txtNmrSerie").val() + "','idPatrimonio':'" + idPatrimonio + "','DataInstalacao':'" + $("#txtPlacaDtInstal").val() +
                            "','EstadoOperacional':'" + $("#ddlPlacaAtivo").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
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

function ApagarPlaca() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/DeletePlacaControllers',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','quantidade':'" + $("#txtQtdGrupoFocal").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
        },
        error: function (data) {
        }
    });
}

function ImplantacaoPlacaCtrl() {

    $("#pnlGrdPlacaCtrl").css("display", "block");
    $("#pnlPlaca").css("display", "block");
    $("#pnlAdcPlaca").css("display", "none");
    $("#dvGrdPlacas").css("display", "none");
    $("#pnlPlacaDetalhe").css("display", "none");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/getPlacaControllers',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','IdPatrimonio':'" + idPatrimonioCtrl + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {

                var i = 0;
                $("#tblAdcPlaca").css("display", "table");
                $("#tbAdcPlaca").empty();
                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectPlacaCtrlCad(this)' data-id='" + lst[0] + "' " +
                        " data-modelo='" + lst[2] + "' data-fabricante='" + lst[3] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblAdcPlaca").append(newRow);
                }


            }
        },
        error: function (data) {
        }
    });
}

function SelectPlacaCtrlCad(value) {
    idProduto = $(value).data("id");
    $("#txtPlacaModelo").val($(value).data("modelo"));
    $("#txtFabricantePlaca").val($(value).data("fabricante"));
    $("#btnPlacaSave").val("Salvar");
    $("#pnlPlacaDetalhe").css("display", "block");
    $("#pnlPlaca").css("display", "none");
    $("#pnlQtdPlacaCtrl").css("display", "block");
    $("#btnApagarPlaca").css("display", "none");
}

function CancelarCtrl() {
    FindDNA();
}

function CtrlSave(value) {

    if ($("#ddlFormaOperacional").val() == "CONJUGADO") {
        var idLocalMestre = $("#txtIdLocalMestre").val();

        if (idLocalMestre == "") {
            document.getElementById("txtIdLocalMestre").style.placeholder = "Obrigatório!";
            document.getElementById("txtIdLocalMestre").style.borderColor = "red";
            return;
        }
        else {
            document.getElementById("txtIdLocalMestre").style.borderColor = 'rgb(169, 169, 169)';
            document.getElementById("txtIdLocalMestre").style.placeholder = "";

            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/EditMestreCtrl',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                    " 'idLocalMestre':'" + $("#txtIdLocalMestre").val() + "', " +
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
        var dtInstalacao_formatada = $("#txtCtrlDtInstalacao").val().replace("T", " ").replace("-", "/").replace("-", "/");
        var dtGarantia_formatada = $("#txtCtrlDtGarantia").val().replace("T", " ").replace("-", "/").replace("-", "/");

        //Valida nmrPatrimonio
        $.ajax({
            type: 'POST',
            url: '../../WebServices/Materiais.asmx/validaNrPat',
            dataType: 'json',
            data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                " 'nmrPatrimonio':'" + document.getElementById("txtNumPat").value + "', " +
                " 'idPatrimonio':'" + idPatrimonio + "','value':'" + value + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {

                if (data.d != "") {
                    alert("Esse número de patrimonio já está vinculado a um produto!");
                    return;
                }
                else {

                    if ($("#ddlFormaOperacional").val() == "MESTRE" || $("#ddlFormaOperacional").val() == "ISOLADO") {

                        var nmrPat = $("#txtNumPat").val();

                        if (nmrPat == "") {
                            if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
                                $("#mpMensagem").modal("show");
                                document.getElementById("lblProdNpatrimonio").innerHTML = "Controlador";
                                document.getElementById("lblProdNpatrimonio").title = "Controlador"
                                return;
                            }

                        }
                        else {
                            document.getElementById("txtNumPat").style.borderColor = 'rgb(169, 169, 169)';
                            document.getElementById("txtNumPat").style.placeholder = "";
                        }

                        if (value == "Salvar Alterações") {

                            $.ajax({
                                type: 'POST',
                                url: '../../WebServices/Materiais.asmx/EditCtrl',
                                dataType: 'json',
                                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                                    " 'nmrPatrimonio':'" + $("#txtNumPat").val() + "', " +
                                    " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                                    " 'idPatriomonio':'" + idPatrimonio + "', " +
                                    " 'Fixacao':'" + $("#ddlCtrlFixacao").val() + "', " +
                                    " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                                    " 'TensaoEntrada':'" + $("#ddlCtrlTensaoIn").val() + "', " +
                                    " 'TensaoSaida':'" + $("#ddlCtrlTensaoOut").val() + "', " +
                                    " 'CapacidadeFasesSuportadas':'" + $("#txtCapSuportada").val() + "', " +
                                    " 'CapacidadeFasesInstaladas':'" + $("#txtCtrlCapacidadeFaseInst").val() + "', " +
                                    " 'EstadoOperacional':'" + $("#ddlEstadoOperacional").val() + "', " +
                                    " 'FormaOperacional':'" + $("#ddlFormaOperacional").val() + "', " +
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
                            data: "{'DataGarantia':'" + dtGarantia_formatada + "', " +
                                " 'Fabricante':'" + $("#txtCtrlFabricante").val() + "', " +
                                " 'IdDepartamento':'" + idDepartamento + "', " +
                                " 'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                                " 'IdProduto':'" + idProduto + "', " +
                                " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                                " 'modelo':'" + $("#txtCtrlModelo").val() + "', " +
                                " 'NumeroSerie':'" + $("#txtNmrSerie").val() + "', " +
                                " 'NumeroPatrimonio':'" + $("#txtNumPat").val() + "'}",
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
                                        " 'nmrPatrimonio':'" + $("#txtNumPat").val() + "', " +
                                        " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                                        " 'idPatriomonio':'" + idPatrimonio + "', " +
                                        " 'Fixacao':'" + $("#ddlCtrlFixacao").val() + "', " +
                                        " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                                        " 'TensaoEntrada':'" + $("#ddlCtrlTensaoIn").val() + "', " +
                                        " 'TensaoSaida':'" + $("#ddlCtrlTensaoOut").val() + "', " +
                                        " 'CapacidadeFasesSuportadas':'" + $("#txtCapSuportada").val() + "', " +
                                        " 'CapacidadeFasesInstaladas':'" + $("#txtCtrlCapacidadeFaseInst").val() + "', " +
                                        " 'EstadoOperacional':'" + $("#ddlEstadoOperacional").val() + "', " +
                                        " 'FormaOperacional':'" + $("#ddlFormaOperacional").val() + "', " +
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

function DetalhesCtrl() {

    var detalhes = "";
    document.getElementById("ddlFormaOperacional").disabled = true;
    $("#pnlCtrlDados").css("display", "none");
    $("#lnkVoltarCadCtrl").css("display", "none");
    $("#pnlDadoSubMestre").css("display", "none");
    $("#tblDadoSubMestre").css("display", "none");
    $("#btnApagarControlador").css("display", "block");
    if (document.getElementById("lnkDetalhesCtrl").innerHTML == "Detalhes do controlador") {
        detalhes = "Controlador";
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
                    $("#pnlCtrlEditarDetalhes").css("display", "block");
                    var lst = data.d[0].split('@');

                    idPatrimonio = lst[0];
                    idDepartamento = lst[1]
                    $("#txtCapSuportada").val(lst[2]);
                    $("#txtProduto").val(lst[3]);
                    $("#ddlFormaOperacional").val(lst[4]);
                    var FormaOperacional = lst[4];
                    $("#ddlCtrlFixacao").val(lst[5]);
                    $("#txtNmrSerie").val(lst[6]);
                    $("#txtNumPat").val(lst[7]);
                    $("#txtCtrlDtGarantia").val(lst[8].replace(" ", "T").replace("/", "-").replace("/", "-"));
                    $("#txtCtrlDtInstalacao").val(lst[9].replace(" ", "T").replace("/", "-").replace("/", "-"));
                    $("#txtCtrlFabricante").val(lst[10]);
                    $("#txtCtrlModelo").val(lst[11]);
                    $("#txtCtrlTipo").val(lst[12]);
                    $("#ddlCtrlTensaoIn").val(lst[13]);
                    $("#ddlCtrlTensaoOut").val(lst[14]);
                    $("#txtCapSuportada").val(lst[15]);
                    $("#txtCtrlCapacidadeFaseInst").val(lst[16]);
                    $("#ddlEstadoOperacional").val(lst[17]);

                    if (FormaOperacional == "CONJUGADO") {

                        $("#tblConjugado").css("display", "block");
                        document.getElementById("lblMestre").innerHTML = lst[18];
                        document.getElementById("lblModeloMestre").innerHTML = lst[19];
                    }
                    else if (lst[0] == "Mestre") {

                        $("#pnlConjugados").css("display", "block");
                        document.getElementById("lblFormaOperacionalCtrl").innerHTML = "MESTRE";

                        var i = 0;
                        $("#tblConjugados").css("display", "table");
                        $("#TfConjugados").css("display", "none");
                        $("#tbConjugados").empty();
                        while (data.d[i]) {

                            var lst = data.d[i].split('@');

                            var newRow = $("<tr>");
                            var cols = "";
                            if (lst[18] != undefined && lst[19] != undefined) {
                                cols += "<td style='padding-top: 14px;'>" + lst[19] + "</td>";
                                cols += "<td style='padding-top: 14px;'>" + lst[20] + "</td>";
                            }
                            else {
                                $("#TfConjugados").css("display", "flex");
                                $("#tbConjugados").empty();
                            }


                            newRow.append(cols);
                            $("#tblConjugados").append(newRow);
                            i++
                        }
                    }
                    else {
                        document.getElementById("lblFormaOperacionalCtrl").innerHTML = "ISOLADO";
                    }

                }
            },
            error: function (data) {
            }
        });
    }

    else {
        detalhes = "Conjugado";
        $.ajax({
            type: 'POST',
            url: '../../WebServices/Materiais.asmx/DetalhesCtrl',
            dataType: 'json',
            data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "','idsubdivisao':'" + document.getElementById("hfIdSub").value + "','Endereco':'" + document.getElementById("hfEndereco").value + "','IdLocal':'" + document.getElementById("hfIdDna").value + "','Detalhes':'" + detalhes + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d != "") {
                    var lst = data.d[0].split('@');
                    document.getElementById("lblMestre").innerHTML = lst[0];
                    $("#ddlFormaOperacional").val("CONJUGADO");
                    $("#tblConjugado").css("display", "block");
                    $("#tblSelSubMestre").css("display", "block");
                    $("#tblDadoSubMestre").css("display", "none");
                    $("#tblEditarDadosCtrl").css("display", "none");
                    $("#pnlAdcCtrlImplantacao").css("display", "none");
                    $("#pnlCtrlEditarDetalhes").css("display", "block");
                    $("#tblformaoperacional").css("display", "block");
                    $("#dvBtnCtrl").css("display", "block");
                }
            },
            error: function (data) {
            }
        });
    }
    document.getElementById("btnCtrlSave").value = "Salvar Alterações";
    document.getElementById("btnApagarControlador").style.visibility = "visible";
    document.getElementById("btnCancelarCtrl").style.visibility = "visible";
    $("#pnlAdcCtrlImplantacao").css("display", "none");
    $("#pnlAdcCtrl").css("display", "none");
    $("#divAdcCtrl").css("display", "none");
}

function ApagarControlador() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/DeleteControllers',
        dataType: 'json',
        data: "{'idSubdivisao':'" + $("#hfIdSub").val() + "','idPatrimonio':'" + idPatrimonio + "','formaOperacional':'" + $("#ddlFormaOperacional").val() +
            "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value +
            "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
        },
        error: function (data) {
        }
    });

}

function ValorDrop(valor) {
    var formaOperacional = valor.value;

    switch (formaOperacional) {
        case "MESTRE":
            $("#pnlAdcCtrlImplantacao").css("display", "block");
            $("#tblSelSubMestre").css("display", "none");
            $("#pnlCtrlEditarDetalhes").css("display", "none");
            AdcControladorImplantacao("valorDrop");
            break;
        case "CONJUGADO":
            $("#tblSelSubMestre").css("display", "block");
            $("#tblDadoSubMestre").css("display", "none");
            $("#tblEditarDadosCtrl").css("display", "none");
            $("#pnlAdcCtrlImplantacao").css("display", "none");
            $("#pnlCtrlEditarDetalhes").css("display", "block");
            $("#tblformaoperacional").css("display", "block");
            $("#dvBtnCtrl").css("display", "block");
            break;
        default:
            $("#pnlAdcCtrlImplantacao").css("display", "block");
            $("#tblSelSubMestre").css("display", "none");
            $("#pnlCtrlEditarDetalhes").css("display", "none");
            AdcControladorImplantacao("valorDrop");
    }

}

function AdcNobreak() {

    $("#pnlDetailsNbr").css("display", "none");
    $("#lnkAdcNobreak").css("display", "none");
    $("#pnlAddNbk").css("display", "block");
    $("#pnlCadastroNobreak").css("display", "none");
    $("#pnlGrdAddNobreak").css("display", "none");
    $("#adcNbrk").css("display", "block");

}

function EditNobreak(value) {

    var nmrPat = $("#txtNbkNumPat").val();
    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            $("#mpMensagem").modal("show");
            document.getElementById("lblProdNpatrimonio").innerHTML = "Nobreak";
            document.getElementById("lblProdNpatrimonio").title = "Nobreak";
            return;
        }
    }
    else {
        document.getElementById("txtNbkNumPat").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNbkNumPat").style.placeholder = "";
    }

    var dtInstalacao_formatada = $("#txtNbkDataInstal").val().replace("T", " ").replace("-", "/").replace("-", "/");
    var dtGarantia_formatada = $("#txtNbkDataGarantia").val().replace("T", " ").replace("-", "/").replace("-", "/");

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'nmrPatrimonio':'" + nmrPat + "', " +
            " 'idPatrimonio':'" + idPatrimonio + "', " +
            " 'value':'" + value + "'}",
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
                    data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                        " 'NumeroPatrimonio':'" + nmrPat + "', " +
                        " 'idPatrimonio':'" + idPatrimonio + "', " +
                        " 'idProduto':'" + idProduto + "', " +
                        " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                        " 'Fabricante':'" + $("#txtNbkFabricante").val() + "', " +
                        " 'IdDepartamento':'" + idDepartamento + "', " +
                        " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                        " 'modelo':'" + $("#txtNbkModelo").val() + "', " +
                        " 'Fixacao':'" + $("#ddlNbkFixacao").val() + "', " +
                        " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                        " 'EstadoOperacional':'" + $("#ddlNbkAtivo").val() + "', " +
                        " 'Autonomia':'" + $("#txtNbkAutonomia").val() + "', " +
                        " 'Potencia':'" + $("#txtNbkPotencia").val() + "', " +
                        " 'Monitoracao':'" + $("#ddlNbkMonitoracao").val() + "', " +
                        " 'value':'" + value + "', " +
                        " 'idLocal':'" + document.getElementById("hfIdDna").value + "', " +
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
        },
        error: function (data) {
        }
    });
}

function ApagarNobreak() {

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

function CancelNbrk() {

    FindDNA();
}

function ImplantacaoNbk() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoNbrk',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#tblAdcNobreak").css("display", "table");
                $("#tbAdcNobreak").empty();
                $("#pnlGrdAddNobreak").css("display", "block");
                $("#pnlDetailsNbr").css("display", "none");
                $("#pnlAddNbk").css("display", "none");
                $("#pnlCadastroNobreak").css("display", "none");
                $("#adcNbrk").css("display", "none");
                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectNbrkCad(this)' data-id='" + lst[0] + "' " +
                        " data-model='" + lst[2] + "'  data-fab='" + lst[3] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblAdcNobreak").append(newRow);
                }

            }
        },
        error: function (data) {
        }
    });
}

function SelectNbrkCad(valor) {

    idProduto = $(valor).data("id");
    $("#txtNbkModelo").val($(valor).data("model"));
    $("#txtNbkFabricante").val($(valor).data("fab"));

    $("#btnApagarNobreak").css("display", "none");
    $("#pnlDetailsNbr").css("display", "none");
    $("#pnlAddNbk").css("display", "none");
    $("#pnlCadastroNobreak").css("display", "block");
    $("#pnlGrdAddNobreak").css("display", "none");
    $("#adcNbrk").css("display", "none");
    $("#btnEditNobreak").val("Salvar");
}

function DetailsNbr() {

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
                $("#txtNbkAutonomia").val(lst[1]);
                $("#txtNbkDataGarantia").val(lst[2].replace(" ", "T").replace("/", "-").replace("/", "-"));
                $("#txtNbkFabricante").val(lst[3]);
                $("#txtNbkDataInstal").val(lst[4].replace(" ", "T").replace("/", "-").replace("/", "-"));
                $("#txtNbkModelo").val(lst[5]);
                $("#txtNbkNumPat").val(lst[6]);
                $("#txtNbkPotencia").val(lst[7]);
                $("#ddlNbkAtivo").val(lst[8]);
                $("#ddlNbkFixacao").val(lst[9]);
                $("#ddlNbkMonitoracao").val(lst[10]);
                $("#pnlDetailsNbr").css("display", "none");
                $("#pnlAddNbk").css("display", "none");
                $("#pnlCadastroNobreak").css("display", "block");
                $("#pnlGrdAddNobreak").css("display", "none");
                $("#adcNbrk").css("display", "none");
                $("#btnEditNobreak").val("Salvar Alterações");
                $("#btnApagarNobreak").css("display", "block");
            }
        },
        error: function (data) {
        }
    });
}

function AdcGPRSnbk() {
    $("#adcGprs").css("display", "none");
    $("#pnlAddGprsNbk").css("display", "block");
    $("#pnlDetailsGprs").css("display", "none");
    $("#pnlGrdAdcGprsNbk").css("display", "none");
    $("#pnlDadosGPRSnbk").css("display", "none");
}

function ImplantacaoGprsNbk() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoGprsNbk',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d != "") {
                var i = 0;
                $("#tblAdcGPRSNbk").css("display", "block");
                $("#tbAdcGPRSNbk").empty();
                $("#adcGprs").css("display", "none");
                $("#pnlAddGprsNbk").css("display", "none");
                $("#pnlDetailsGprs").css("display", "none");
                $("#pnlGrdAdcGprsNbk").css("display", "block");
                $("#pnlDadosGPRSnbk").css("display", "none");
                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectGprsNbrkCad(this)' data-id='" + lst[0] + "' " +
                        " data-model='" + lst[2] + "'  data-fab='" + lst[3] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblAdcGPRSNbk").append(newRow);
                }

            }
        },
        error: function (data) {
        }
    });
}

function SelectGprsNbrkCad(valor) {
    $("#btnExcluirGprsNbk").css("display", "none");
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
                $("#txtNmrSerieGprsNbk").val(lst[0]);
            }
        },
        error: function (data) {
        }
    });
    $("#adcGprs").css("display", "none");
    $("#pnlAddGprsNbk").css("display", "none");
    $("#pnlDetailsGprs").css("display", "none");
    $("#pnlGrdAdcGprsNbk").css("display", "none");
    $("#pnlDadosGPRSnbk").css("display", "block");
    $("#btnSalvarGprsNbk").val("Salvar");

}

function CancelGprsNbk() {
    FindDNA();
}

function Gprs() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/DetailsNbrGprs',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
            " 'idSubdivisao':'" + $("#hfIdSub").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                var lst = data.d[0].split('@');
                idPatrimonio = lst[0];
                $("#txtFabricanteGprsNbk").val(lst[1]);
                $("#lblFabricanteGprs").val(lst[1]);
                $("#txtNmrPatGprsNbk").val(lst[2]);
                $("#lblnrpatGprs").val(lst[2]);
                $("#txtNmrLinhaGprsNbk").val(lst[3]);

                $("#txtDtGarantiaGprsNbk").val(lst[4]);
                $("#txtDtInstalGprsNbk").val(lst[5]);

                var dtInstalacao = lst[5].replace(" ", "T").replace("/", "-").replace("/", "-");
                var dtGarantia = lst[4].replace(" ", "T").replace("/", "-").replace("/", "-");

                document.getElementById("txtDtGarantiaGprsNbk").value = dtGarantia;
                document.getElementById("txtDtInstalGprsNbk").value = dtInstalacao;

                $("#txtModeloGprsNbk").val(lst[6]);
                $("#lblModelGprs").val(lst[6]);
                $("#ddlOperadoraGprsNbk").val(lst[7]);
                $("#ddlEstadoOperacionalGprsNbk").val(lst[8]);
                $("#adcGprs").css("display", "none");
                $("#pnlAddGprsNbk").css("display", "none");
                $("#pnlDetailsGprs").css("display", "none");
                $("#pnlGrdAdcGprsNbk").css("display", "none");
                $("#pnlDadosGPRSnbk").css("display", "block");
                $("#btnSalvarGprsNbk").val("Salvar Alterações");
                $("#btnExcluirGprsNbk").css("display", "block");
            }
        },
        error: function (data) {
        }
    });
}

function SalvarGprsNbk(value) {

    var nmrPat = $("#txtNmrPatGprsNbk").val();
    if (nmrPat == "") {

        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            $("#mpMensagem").modal("show");
            document.getElementById("lblProdNpatrimonio").innerHTML = "Gprs Nobreak";
            document.getElementById("lblProdNpatrimonio").title = "Gprs Nobreak";
            return;
        }
    }
    else {
        document.getElementById("txtNmrPatGprsNbk").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNmrPatGprsNbk").style.placeholder = "";
    }

    var dtInstalacao_formatada = $("#txtDtInstalGprsNbk").val().replace("T", " ").replace("-", "/").replace("-", "/");
    var dtGarantia_formatada = $("#txtDtGarantiaGprsNbk").val().replace("T", " ").replace("-", "/").replace("-", "/");

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'nmrPatrimonio':'" + nmrPat + "', " +
            " 'idPatrimonio':'" + idPatrimonio + "', " +
            " 'value':'" + value + "'}",
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
                    data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                        " 'NumeroPatrimonio':'" + nmrPat + "', " +
                        " 'idPatrimonio':'" + idPatrimonio + "', " +
                        " 'idProduto':'" + idProduto + "', " +
                        " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                        " 'Fabricante':'" + $("#txtFabricanteGprsNbk").val() + "', " +
                        " 'IdDepartamento':'" + idDepartamento + "', " +
                        " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                        " 'modelo':'" + $("#txtModeloGprsNbk").val() + "', " +
                        " 'NumeroSerie':'" + $("#txtNmrSerieGprsNbk").val() + "', " +
                        " 'NmrDaLinha':'" + $("#txtNmrLinhaGprsNbk").val() + "', " +
                        " 'Operadora':'" + $("#ddlOperadoraGprsNbk").val() + "', " +
                        " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                        " 'EstadoOperacional':'" + $("#ddlEstadoOperacionalGprsNbk").val() + "', " +
                        " 'value':'" + value + "', " +
                        " 'idLocal':'" + document.getElementById("hfIdDna").value + "', " +
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
        },
        error: function (data) {
        }
    });
}

function ExcluirGprsNbk() {

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

function AdcColuna() {
    $("#tbladcNewcols").css("display", "none");
    $("#pnlAdcColuna").css("display", "block");
    $("#pnlGrdAdcColuna").css("display", "none");
    $("#pnlDadosColuna").css("display", "none");
    $("#pnlColunas").css("display", "none");
}

function CancelarColuna() {
    FindDNA();
}

function ImplantacaoColuna() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoColuna',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                var i = 0;
                $("#tblAdcColuna").css("display", "table");
                $("#tbAdcColuna").empty();
                $("#tbladcNewcols").css("display", "none");
                $("#pnlAdcColuna").css("display", "none");
                $("#pnlGrdAdcColuna").css("display", "block");
                $("#pnlDadosColuna").css("display", "none");
                $("#pnlColunas").css("display", "none");

                while (data.d[i]) {

                    var lst = data.d[i].split('@');
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectNewCols(this)' data-id='" + lst[0] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblAdcColuna").append(newRow);
                }
            }
        },
        error: function (data) {
        }
    });
}

function SelectNewCols(valor) {
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
                $("#txtNrSerieColuna").val(lst[0]);
                $("#txtFabricanteColuna").val(lst[1]);
                $("#txtModeloColuna").val(lst[2]);
                $("#tbladcNewcols").css("display", "none");
                $("#pnlAdcColuna").css("display", "none");
                $("#pnlGrdAdcColuna").css("display", "none");
                $("#pnlDadosColuna").css("display", "block");
                $("#pnlColunas").css("display", "none");
                $("#btnAddColuna").val("Salvar");
                $("#btnApagarColuna").css("display", "none");
            }
        },
        error: function (data) {
        }
    });
}

function AddColuna(value) {

    var nmrPat = $("#txtNumPatColuna").val();
    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            document.getElementById("lblProdNpatrimonio").innerHTML = "Coluna";
            document.getElementById("lblProdNpatrimonio").title = "Coluna";
            $("#mpMensagem").modal("show");
            return;
        }
    }
    else {
        document.getElementById("txtNumPatColuna").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatColuna").style.placeholder = "";
    }

    var dtInstalacao_formatada = $("#txtDtInstalacaoColuna").val().replace("T", " ").replace("-", "/").replace("-", "/");
    var dtGarantia_formatada = $("#txtDtGarantiaColuna").val().replace("T", " ").replace("-", "/").replace("-", "/");

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'nmrPatrimonio':'" + nmrPat + "', " +
            " 'idPatrimonio':'" + idPatrimonio + "', " +
            " 'value':'" + value + "'}",
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
                        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
                            " 'NumeroPatrimonio':'" + nmrPat + "', " +
                            " 'idPatrimonio':'" + idPatrimonio + "', " +
                            " 'idProduto':'" + idProduto + "', " +
                            " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                            " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                            " 'Fixacao':'" + $("#ddlFixacaoColuna").val() + "', " +
                            " 'EstadoOperacional':'" + $("#ddlEstadoOperacionalColuna").val() + "'}",
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
                        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                            " 'NumeroPatrimonio':'" + nmrPat + "', " +
                            " 'idPatrimonio':'" + idPatrimonio + "', " +
                            " 'idProduto':'" + idProduto + "', " +
                            " 'quantidade':'" + $("#txtQtdColuna").val() + "', " +
                            " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                            " 'Fabricante':'" + $("#txtFabricanteColuna").val() +
                            "','IdDepartamento':'" + idDepartamento + "', " +
                            " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                            " 'modelo':'" + $("#txtModeloColuna").val() + "', " +
                            " 'Fixacao':'" + $("#ddlFixacaoColuna").val() + "', " +
                            " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                            " 'EstadoOperacional':'" + $("#ddlEstadoOperacionalColuna").val() + "', " +
                            " 'idLocal':'" + document.getElementById("hfIdDna").value + "', " +
                            " 'idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "', " +
                            " 'idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
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

function ApagarColuna() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ApagarColuna',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','quantidade':'" + $("#txtQtdColuna").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
        },
        error: function (data) {
        }
    });
}

function SelectColuna(valor) {

    $("#pnlQtdColuna").css("display", "none");
    idPatrimonio = $(valor).data("id");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectColuna',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $("#btnAddColuna").val("Salvar Alterações");
            if (data.d != "") {
                var lst = data.d[0].split('@');
                $("#txtNumPatColuna").val(lst[0]);
                $("#txtFabricanteColuna").val(lst[1]);
                $("#txtNrSerieColuna").val(lst[2]);

                $("#txtDtGarantiaColuna").val(lst[3].replace(" ", "T").replace("/", "-").replace("/", "-"));
                $("#txtDtInstalacaoColuna").val(lst[4].replace(" ", "T").replace("/", "-").replace("/", "-"));

                idProduto = lst[5];
                $("#txtModeloColuna").val(lst[6]);
                $("#ddlEstadoOperacionalColuna").val(lst[7]);
                $("#ddlFixacaoColuna").val(lst[8]);
                idPatrimonio = lst[9];
                $("#tbladcNewcols").css("display", "none");
                $("#pnlAdcColuna").css("display", "none");
                $("#pnlGrdAdcColuna").css("display", "none");
                $("#pnlDadosColuna").css("display", "block");
                $("#pnlColunas").css("display", "none");
                $("#btnApagarColuna").css("display", "block");
            }
        },
        error: function (data) {
        }
    });
}

function AdcCabo() {
    $("#tblAdcCabo").css("display", "none");
    $("#pnlAdcCabo").css("display", "block");
    $("#pnlGrdAdcCabo").css("display", "none");
    $("#pnlDadosCabo").css("display", "none");
    $("#pnlCabos").css("display", "none");
}

function CancelarCabo() {
    FindDNA();
}

function ImplantacaoCabo() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoCabo',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                var i = 0;
                $("#tblAdcCabos").css("display", "table");
                $("#tbAdcCabos").empty();

                $("#tblAdcCabo").css("display", "none");
                $("#pnlAdcCabo").css("display", "none");
                $("#pnlGrdAdcCabo").css("display", "block");
                $("#pnlDadosCabo").css("display", "none");
                $("#pnlCabos").css("display", "none");

                while (data.d[i]) {

                    var lst = data.d[i].split('@');
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";

                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectNewCabo(this)' data-id='" + lst[0] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblAdcCabos").append(newRow);
                }
            }
        },
        error: function (data) {
        }
    });
}

function SelectNewCabo(valor) {
    $("#pnlQtdCabo").css("display", "block");
    $("#btnApagarCabos").css("display", "none");
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

                $("#txtNmrSerieCabo").val(lst[0]);
                $("#txtFabricanteCabos").val(lst[1]);
                $("#txtModeloCabos").val(lst[2]);

                $("#tblAdcCabo").css("display", "none");
                $("#pnlAdcCabo").css("display", "none");
                $("#pnlGrdAdcCabo").css("display", "none");
                $("#pnlDadosCabo").css("display", "block");
                $("#pnlCabos").css("display", "none");
                $("#btnSalvarCabos").val("Salvar");
            }
        },
        error: function (data) {
        }
    });
}

function AddCabos(value) {

    var nmrPat = $("#txtNumPatCabo").val();
    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            document.getElementById("lblProdNpatrimonio").innerHTML = "Cabos";
            document.getElementById("lblProdNpatrimonio").title = "Cabos";
            $("#mpMensagem").modal("show");
            return;
        }
    }
    else {
        document.getElementById("txtNumPatCabo").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatCabo").style.placeholder = "";
    }

    var dtInstalacao_formatada = $("#txtDataInstalacaoCabos").val().replace("T", " ").replace("-", "/").replace("-", "/");
    var dtGarantia_formatada = $("#txtDataGarantiaCabos").val().replace("T", " ").replace("-", "/").replace("-", "/");

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'nmrPatrimonio':'" + nmrPat + "', " +
            " 'idPatrimonio':'" + idPatrimonio + "', " +
            " 'value':'" + value + "'}",
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
                    data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                        " 'NumeroPatrimonio':'" + nmrPat + "', " +
                        " 'idPatrimonio':'" + idPatrimonio + "', " +
                        " 'idProduto':'" + idProduto + "', " +
                        " 'quantidade':'" + $("#txtQtdCabo").val() + "', " +
                        " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                        " 'Fabricante':'" + $("#txtFabricanteCabos").val() + "', " +
                        " 'idDepartamento':'" + idDepartamento + "', " +
                        " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                        " 'modelo':'" + $("#txtModeloCabos").val() + "', " +
                        " 'QtdUni':'" + $("#txtMetrosCabos").val() + "', " +
                        " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                        " 'EstadoOperacional':'" + $("#ddlEstadoOperacionalCabos").val() + "', " +
                        " 'TipoInstalacao':'" + $("#ddlInstalacaoCabos").val() + "', " +
                        " 'MeioInstalacao':'" + $("#ddlMeioInstalacaoCabos").val() + "', " +
                        " 'value':'" + value + "', " +
                        " 'idLocal':'" + document.getElementById("hfIdDna").value + "', " +
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
        },
        error: function (data) {
        }
    });
}

function ApagarCabos() {
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

function SelectCabo(valor) {

    $("#pnlQtdCabo").css("display", "none");
    $("#btnApagarCabos").css("display", "block");
    idPatrimonio = $(valor).data("id");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectCabo',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            $("#btnSalvarCabos").val("Salvar Alterações");

            if (data.d != "") {
                var lst = data.d[0].split('@');
                $("#txtNmrSerieCabo").val(lst[0]);
                $("#txtFabricanteCabos").val(lst[1]);
                $("#txtModeloCabos").val(lst[2]);
                idProduto = lst[3];

                $("#txtDataInstalacaoCabos").val(lst[4].replace(" ", "T").replace("/", "-").replace("/", "-"));
                $("#txtDataGarantiaCabos").val(lst[5].replace(" ", "T").replace("/", "-").replace("/", "-"));
 
                $("#txtNumPatCabo").val(lst[6]);
                idPatrimonio = lst[7];
                $("#ddlInstalacaoCabos").val(lst[8]);
                $("#ddlMeioInstalacaoCabos").val(lst[9]);
                $("#txtMetrosCabos").val(lst[10]);
                $("#ddlEstadoOperacionalCabos").val(lst[11]);

                $("#tblAdcCabo").css("display", "none");
                $("#pnlAdcCabo").css("display", "none");
                $("#pnlGrdAdcCabo").css("display", "none");
                $("#pnlDadosCabo").css("display", "block");
                $("#pnlCabos").css("display", "none");
            }
        },
        error: function (data) {
        }
    });
}

function AdcGrupoFocal() {
    $("#tblAdcGf").css("display", "none");
    $("#pnlAdcGrupoFocal").css("display", "block");
    $("#pnlGrdAdcGrupoFocal").css("display", "none");
    $("#pnlDadosGrupoFocal").css("display", "none");
    $("#pnlGrupoFocal").css("display", "none");
}

function CancelarGF() {
    FindDNA();
}

function ImplantacaoGF() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoGF',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                var i = 0;
                $("#tblAdcGrupoFocal").css("display", "table");
                $("#tbAdcGrupoFocal").empty();

                $("#tblAdcGf").css("display", "none");
                $("#pnlAdcGrupoFocal").css("display", "none");
                $("#pnlGrdAdcGrupoFocal").css("display", "block");
                $("#pnlDadosGrupoFocal").css("display", "none");
                $("#pnlGrupoFocal").css("display", "none");

                while (data.d[i]) {
                    var lst = data.d[i].split('@');
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectNewGf(this)' data-id='" + lst[0] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblAdcGrupoFocal").append(newRow);
                }
            }
        },
        error: function (data) {
        }
    });
}

function SelectNewGf(valor) {
    $("#pnlQtdGF").css("display", "block");
    $("#btnApagarGrupoFocal").css("display", "none");
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

                $("#txtNrSerieGrupoFocal").val(lst[0]);
                $("#txtFabricanteGrupoFocal").val(lst[1]);
                $("#txtModeloGrupoFocal").val(lst[2]);

                $("#tblAdcGf").css("display", "none");
                $("#pnlAdcGrupoFocal").css("display", "none");
                $("#pnlGrdAdcGrupoFocal").css("display", "none");
                $("#pnlDadosGrupoFocal").css("display", "block");
                $("#pnlGrupoFocal").css("display", "none");
                $("#btnEditGrupoFocal").val("Salvar");
            }
        },
        error: function (data) {
        }
    });
}

function EditGrupoFocal(value) {

    var nmrPat = $("#txtNumPatGF").val();
    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            document.getElementById("lblProdNpatrimonio").innerHTML = "Grupo Focal";
            document.getElementById("lblProdNpatrimonio").title = "Grupo Focal";
            $("#mpMensagem").modal("show");
            return;
        }
    }
    else {
        document.getElementById("txtNumPatGF").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatGF").style.placeholder = "";
    }

    var dtInstalacao_formatada = $("#txtDtInstalacaoGrupoFocal").val().replace("T", " ").replace("-", "/").replace("-", "/");
    var dtGarantia_formatada = $("#txtDtGarantiaGrupoFocal").val().replace("T", " ").replace("-", "/").replace("-", "/");

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'nmrPatrimonio':'" + nmrPat + "', " +
            " 'idPatrimonio':'" + idPatrimonio + "', " +
            " 'value':'" + value + "'}",
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
                    data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                        " 'NumeroPatrimonio':'" + nmrPat + "', " +
                        " 'idPatrimonio':'" + idPatrimonio + "', " +
                        " 'idProduto':'" + idProduto + "', " +
                        " 'quantidade':'" + $("#txtQtdGrupoFocal").val() + "', " +
                        " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                        " 'Fabricante':'" + $("#txtFabricanteGrupoFocal").val() + "', " +
                        " 'idDepartamento':'" + idDepartamento + "', " +
                        " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                        " 'modelo':'" + $("#txtModeloGrupoFocal").val() + "', " +
                        " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                        " 'EstadoOperacional':'" + $("#ddlEstadoOperacionalGrupoFocal").val() + "', " +
                        " 'value':'" + value + "', " +
                        " 'idLocal':'" + document.getElementById("hfIdDna").value + "', " +
                        " 'idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "', " +
                        " 'idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
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

function ApagarGrupoFocal() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ApagarGrupoFocal',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','quantidade':'" + $("#txtQtdGrupoFocal").val() +
            "','idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "','idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
        },
        error: function (data) {
        }
    });
}

function SelectGrupoFocal(valor) {

    $("#pnlQtdGF").css("display", "none");
    $("#btnApagarGrupoFocal").css("display", "block");
    idPatrimonio = $(valor).data("id");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectGrupoFocal',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            $("#btnEditGrupoFocal").val("Salvar Alterações");
            if (data.d != "") {
                var lst = data.d[0].split('@');
                $("#txtModeloGrupoFocal").val(lst[0]);
                $("#txtFabricanteGrupoFocal").val(lst[1]);
                $("#ddlEstadoOperacionalGrupoFocal").val(lst[2]);
                $("#txtNumPatGF").val(lst[3]);
                idProduto = lst[4];
                $("#txtDtGarantiaGrupoFocal").val(lst[5].replace(" ", "T").replace("/", "-").replace("/", "-"));
                $("#txtDtInstalacaoGrupoFocal").val(lst[6].replace(" ", "T").replace("/", "-").replace("/", "-"));
                idPatrimonio = lst[7];

                $("#tblAdcGf").css("display", "none");
                $("#pnlAdcGrupoFocal").css("display", "none");
                $("#pnlGrdAdcGrupoFocal").css("display", "none");
                $("#pnlDadosGrupoFocal").css("display", "block");
                $("#pnlGrupoFocal").css("display", "none");
                $("#btnEditGrupoFocal").val("Salvar Alterações");
            }
        },
        error: function (data) {
        }
    });
}

function AdcIluminacao() {
    $("#tblAdcIlu").css("display", "none");
    $("#pnlAdcIluminacao").css("display", "block");
    $("#pnlGrdAdcIluminacao").css("display", "none");
    $("#pnlDadosIlu").css("display", "none");
    $("#pnlIluminacao").css("display", "none");
}

function CancelSistemaIlu() {
    FindDNA();
}

function ImplantacaoIlu() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoIlu',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                var i = 0;
                $("#tblAdcIluminacao").css("display", "table");
                $("#tbAdcIluminacao").empty();

                $("#tblAdcIlu").css("display", "none");
                $("#pnlAdcIluminacao").css("display", "none");
                $("#pnlGrdAdcIluminacao").css("display", "block");
                $("#pnlDadosIlu").css("display", "none");
                $("#pnlIluminacao").css("display", "none");

                while (data.d[i]) {
                    var lst = data.d[i].split('@');

                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";
                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectNewIlu(this)' data-id='" + lst[0] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblAdcIluminacao").append(newRow);
                }

            }
        },
        error: function (data) {
        }
    });
}

function SelectNewIlu(valor) {
    $("#pnlQtdIlu").css("display", "block");
    $("#btnApagarSistemaIlu").css("display", "none");
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

                $("#txtIluNumeroSerie").val(lst[0]);
                $("#txtIluFabricante").val(lst[1]);
                $("#txtIluModelo").val(lst[2]);

                $("#tblAdcIlu").css("display", "none");
                $("#pnlAdcIluminacao").css("display", "none");
                $("#pnlGrdAdcIluminacao").css("display", "none");
                $("#pnlDadosIlu").css("display", "block");
                $("#pnlIluminacao").css("display", "none");
                $("#btnSalvarIlu").val("Salvar");
            }
        },
        error: function (data) {
        }
    });
}

function SalvarIlu(value) {

    var nmrPat = $("#txtNumPatSI").val();
    if (nmrPat == "") {
        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            document.getElementById("lblProdNpatrimonio").innerHTML = "Sistema de Iluminação";
            document.getElementById("lblProdNpatrimonio").title = "Sistema de Iluminação";
            $("#mpMensagem").modal("show");
            return;
        }
    }
    else {
        document.getElementById("txtNumPatSI").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatSI").style.placeholder = "";
    }

    var dtInstalacao_formatada = $("#txtIluDtInstalacao").val().replace("T", " ").replace("-", "/").replace("-", "/");
    var dtGarantia_formatada = $("#txtIluDtGarantia").val().replace("T", " ").replace("-", "/").replace("-", "/");

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'nmrPatrimonio':'" + nmrPat + "', " +
            " 'idPatrimonio':'" + idPatrimonio + "', " +
            " 'value':'" + value + "'}",
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
                    data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                        " 'NumeroPatrimonio':'" + nmrPat + "', " +
                        " 'idPatrimonio':'" + idPatrimonio + "', " +
                        " 'idProduto':'" + idProduto + "', " +
                        " 'quantidade':'" + $("#txtQtdIlum").val() + "', " +
                        " 'DataGarantia':'" + dtGarantia_formatada + "', " +
                        " 'Fabricante':'" + $("#txtIluFabricante").val() + "', " +
                        " 'idDepartamento':'" + idDepartamento + "', " +
                        " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                        " 'modelo':'" + $("#txtIluModelo").val() + "', " +
                        " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                        " 'EstadoOperacional':'" + $("#ddlIluAtivo").val() + "', " +
                        " 'TensaoInstalada':'" + $("#ddlIluTensao").val() + "', " +
                        " 'value':'" + value + "', " +
                        " 'idOcorrencia':'" + $("#hfIdOcorrencia").val() + "', " +
                        " 'idDnaGSS':'" + $("#hfIdDnaGSS").val() + "'}",
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

function ApagarSistemaIlu() {
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ApagarSistemaIlu',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','quantidade':'" + $("#txtQtdIlum").val() +
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

function SelectIlum(valor) {

    $("#pnlQtdIlu").css("display", "none");
    $("#btnApagarSistemaIlu").css("display", "block");
    idPatrimonio = $(valor).data("id");

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/SelectIlum',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            $("#btnSalvarIlu").val("Salvar Alterações");
            if (data.d != "") {
                var lst = data.d[0].split('@');
                idPatrimonio = lst[0];
                $("#txtIluNumeroSerie").val(lst[1]);
                $("#txtIluFabricante").val(lst[2]);
                $("#txtIluModelo").val(lst[3]);
                $("#txtIluDtInstalacao").val(lst[4].replace(" ", "T").replace("/", "-").replace("/", "-"));
                $("#txtIluDtGarantia").val(lst[5].replace(" ", "T").replace("/", "-").replace("/", "-"));
                $("#txtNumPatSI").val(lst[6]);
                $("#ddlIluAtivo").val(lst[7]);
                $("#ddlIluTensao").val(lst[8]);

                $("#tblAdcIlu").css("display", "none");
                $("#pnlAdcIluminacao").css("display", "none");
                $("#pnlGrdAdcIluminacao").css("display", "none");
                $("#pnlDadosIlu").css("display", "block");
                $("#pnlIluminacao").css("display", "none");
            }
        },
        error: function (data) {
        }
    });
}

function AdcAcess() {
    $("#tblNewAcess").css("display", "none");
    $("#pnlAdcAcess").css("display", "block");
    $("#pnlGrdAdcAcess").css("display", "none");
    $("#pnlDadosAcessorio").css("display", "none");
    $("#pnlAcessorios").css("display", "none");
}

function CancelAcess() {
    FindDNA();
}

function ImplantacaoAcess() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ImplantacaoAcess',
        dataType: 'json',
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d != "") {
                var i = 0;
                $("#tblAdcAcessorios").css("display", "table");
                $("#tbAdcAcessorios").empty();

                $("#tblNewAcess").css("display", "none");
                $("#pnlAdcAcess").css("display", "none");
                $("#pnlGrdAdcAcess").css("display", "block");
                $("#pnlDadosAcessorio").css("display", "none");
                $("#pnlAcessorios").css("display", "none");

                while (data.d[i]) {
                    var lst = data.d[i].split('@');
                    var newRow = $("<tr>");
                    var cols = "";
                    cols += "<td style='padding-top: 14px;'>" + lst[1] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[2] + "</td>";
                    cols += "<td style='padding-top: 14px;'>" + lst[3] + "</td>";

                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='SelectNewAcess(this)' data-id='" + lst[0] + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";

                    i++;
                    newRow.append(cols);
                    $("#tblAdcAcessorios").append(newRow);
                }
            }
        },
        error: function (data) {
        }
    });
}

function SelectNewAcess(valor) {
    $("#pnlQtdAcess").css("display", "block");
    $("#btnExcluirAcessorios").css("display", "none");
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

                $("#txtAcessNumSerie").val(lst[0]);
                $("#txtFabricanteAcess").val(lst[1]);
                $("#txtNomeAcessorio").val(lst[2]);

                $("#tblNewAcess").css("display", "none");
                $("#pnlAdcAcess").css("display", "none");
                $("#pnlGrdAdcAcess").css("display", "none");
                $("#pnlDadosAcessorio").css("display", "block");
                $("#pnlAcessorios").css("display", "none");
                $("#btnSalvarAcessorio").val("Salvar");
            }
        },
        error: function (data) {
        }
    });
}

function AdicionarAcessorio(value) {

    var nmrPat = $("#txtNumPatAcess").val();
    if (nmrPat == "") {

        if (document.getElementById("lblProdNpatrimonio").title != "Salvar") {
            $("#mpMensagem").modal("show");
            document.getElementById("lblProdNpatrimonio").innerHTML = "Acessórios";
            document.getElementById("lblProdNpatrimonio").title = "Acessórios";
            return;
        }
    }
    else {
        document.getElementById("txtNumPatAcess").style.borderColor = 'rgb(169, 169, 169)';
        document.getElementById("txtNumPatAcess").style.placeholder = "";
    }

    var dtInstalacao_formatada = $("#txtDataInstalAcess").val().replace("T", " ").replace("-", "/").replace("-", "/");

    //Valida nmrPatrimonio
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/validaNrPat',
        dataType: 'json',
        data: "{'idPrefeitura':'" + document.getElementById("hfIdPrefeitura").value + "', " +
            " 'nmrPatrimonio':'" + nmrPat + "', " +
            " 'idPatrimonio':'" + idPatrimonio + "', " +
            " 'value':'" + value + "'}",
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
                    data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
                        " 'NumeroPatrimonio':'" + nmrPat + "', " +
                        " 'idPatrimonio':'" + idPatrimonio + "', " +
                        " 'idProduto':'" + idProduto + "', " +
                        " 'quantidade':'" + $("#txtQtdAcess").val() + "', " +
                        " 'Fabricante':'" + $("#txtFabricanteAcess").val() + "', " +
                        " 'idDepartamento':'" + idDepartamento + "', " +
                        " 'idSubDivisao':'" + $("#hfIdSub").val() + "', " +
                        " 'DataInstalacao':'" + dtInstalacao_formatada + "', " +
                        " 'Fixacao':'" + $("#cboLuminariaFixacao").val() + "', " +
                        " 'value':'" + value + "', " +
                        " 'idLocal':'" + document.getElementById("hfIdDna").value + "', " +
                        " 'idOcorrencia':'" + document.getElementById("hfIdOcorrencia").value + "', " +
                        " 'idDnaGSS':'" + document.getElementById("hfIdDnaGSS").value + "'}",
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

function DeleteAcessorios() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/DeleteAcessorios',
        dataType: 'json',
        data: "{'idPatrimonio':'" + idPatrimonio + "', " +
            " 'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', " +
            " 'quantidade':'" + $("#txtQtdAcess").val() + "', " +
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

function SelectAcessorio(valor) {
    $("#pnlQtdAcess").css("display", "none");
    $("#btnExcluirAcessorios").css("display", "block");
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
                $("#txtAcessNumSerie").val(lst[1]);
                $("#txtFabricanteAcess").val(lst[2]);
                $("#txtDataInstalAcess").val(lst[3]);
                $("#txtNomeAcessorio").val(lst[4]);
                $("#txtNumPatAcess").val(lst[5]);
                $("#cboLuminariaFixacao").val(lst[6]);


                $("#tblNewAcess").css("display", "none");
                $("#pnlAdcAcess").css("display", "none");
                $("#pnlGrdAdcAcess").css("display", "none");
                $("#pnlDadosAcessorio").css("display", "block");
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
    $("#newCad").css("display", "block");
    $("#imgPesquisar").css("display", "block");
    document.getElementById("btnSaveTag").value = "Confirmar";
    document.getElementById("btnSaveTag").style.visibility = "hidden";
    document.getElementById("btnVoltar").style.visibility = "hidden";
    var EPC = document.getElementById("txtEpc").value;

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/findTag',
        dataType: 'json',
        data: "{'EPC':'" + EPC + "', " +
            " 'idPrefeitura':'" + idPrefeitura + "', " +
            " 'idsubdivisao':'" + idsubdivisao + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {

            if (data.d.toString() != "") {
                var i = 0;
                $("#tblTag").css("display", "table");
                $("#tbTag").css("display", "contents");
                $("#tfTag").css("display", "none");
                $("#tbTag").empty();
                while (data.d[i]) {

                    var lst = data.d[i].split('@');
                    var Id = lst[0];
                    var EPC = lst[1];
                    var newRow = $("<tr>");
                    var cols = "";

                    cols += "<td style='padding-top: 14px;'>" + EPC + "</td>";

                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-info' " +
                        " onclick='EditEPC(this)' data-id='" + Id + "' " +
                        " data-epc='" + EPC + "'> " +
                        " <i class='ft-edit-3'></i></button></td>";
                    cols += "<td style='padding: 5px;'> " +
                        " <button type='button' class='btn btn-icon btn-danger' " +
                        " onclick='DeleteEPC(this)' data-id='" + Id + "'> " +
                        " <i class='ft-trash-2'></i></button></td>";

                    newRow.append(cols);
                    $("#tbTag").append(newRow);
                    i++
                }
            }
            else {
                $("#tblTag").css("display", "table");
                //$("#thTag").css("display", "block");
                $("#tfTag").css("display", "contents");
                $("#tbTag").css("display", "none");
                $("#tbTag").empty();
            }
            document.getElementById("txtEpc").value = "";
            document.getElementById("btnSaveTag").value = "Confirmar";
        },
        error: function (data) {
        }
    });
}

function InsertTag() {

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

    if (document.getElementById("btnSaveTag").value == "Confirmar") {
        $.ajax({
            type: 'POST',
            url: '../../WebServices/Materiais.asmx/InsertTag',
            dataType: 'json',
            data: "{'EPC':'" + EPC + "','idPrefeitura':'" + idPrefeitura + "', " +
                " 'idsubdivisao':'" + idsubdivisao + "'}",
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
            data: "{'EPC':'" + EPC + "','Id':'" + Id + "', " +
                " 'idsubdivisao':'" + idsubdivisao + "', " +
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

function EditEPC(value) {
    document.getElementById("btnSaveTag").value = "Salvar alteraçōes";
    $("#newCad").css("display", "none");
    $("#imgPesquisar").css("display", "none");
    document.getElementById("btnSaveTag").style.visibility = "visible";
    document.getElementById("btnVoltar").style.visibility = "visible";
    document.getElementById("hdfIdTag").value = $(value).data("id");
    document.getElementById("txtEpc").value = $(value).data("epc");

}

function DeleteEPC(value) {
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

function Voltar() {
    document.getElementById("txtEpc").value = "";
    findTag();
}

function NewTag() {
    document.getElementById("btnSaveTag").style.visibility = "visible";
    document.getElementById("btnVoltar").style.visibility = "visible";
    $("#newCad").css("display", "none");
    $("#imgPesquisar").css("display", "none");
    document.getElementById("btnSaveTag").value = "Confirmar";
    document.getElementById("txtEpc").value = "";
}

function modalMovimentacao(valor) {
    var Produto = valor.title.toString();
    document.getElementById("lblProd").innerHTML = Produto;
    if (Produto == "Controlador")
        $("#pController").css("display", "");
    else
        $("#pController").css("display", "none");
}

function FindNmrPatMov() {
    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;
    document.getElementById("divSelAlmoxarifado").style.display = "none";
    $("#tblGrdSubdivisao").css("display", "none");

    var idSubMov = $("#hfIdSubMov").val();
    var text = $("#txtNmrPatMov").val();
    var Prod = document.getElementById("lblProd").innerHTML;
    $("#tblDadosProd").css("display", "none");
    var dataSub = [];
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/FindNmrPatMov',
        dataType: 'json',
        data: "{'idPrefeitura':'" + IdPrefeitura + "','text':'" + text + "','idSub':'" + idSubMov + "','Prod':'" + Prod + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var dados = data.d;


            var qtd = 1;
            if (dados.length == 0) {
                alert("Produto não encontrado!");
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
                $("#btnSalvarProd").css("display", "block");
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;display:none'>" + dados.idPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Produto + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.NmrPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Subdivisao + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Endereco + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'><input type='checkbox' id='chk' \"></td>";

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
}

function FindSubdivisaoMov() {
    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;
    document.getElementById("divSelAlmoxarifado").style.display = "none";
    $("#tblGrdSubdivisao").css("display", "none");

    var idSubMov = $("#hfIdSubMov").val();
    var text = $("#txtSubdivisaoMov").val();
    var Prod = document.getElementById("lblProd").innerHTML;
    $("#tblDadosProd").css("display", "none");
    var dataSub = [];
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/FindSubdivisaoMov',
        dataType: 'json',
        data: "{'idPrefeitura':'" + IdPrefeitura + "','text':'" + text + "','idSub':'" + idSubMov + "','Prod':'" + Prod + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var dados = data.d;


            var qtd = 1;
            if (dados.length == 0) {
                alert("Produto não encontrado!");
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
                $("#btnSalvarProd").css("display", "block");
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;display:none'>" + dados.idPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Produto + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.NmrPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Subdivisao + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Endereco + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'><input type='checkbox' id='chk' \"></td>";

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
}

function Cancelar() {
    document.getElementById("divSelAlmoxarifado").style.display = "none";
    $("#tblGrdProdutos").css("display", "none");
    $("#tblGrdSubdivisao").css("display", "none");
    $("#tblDadosSub").css("display", "none");
    $("#hfIdSubMov").val("");
    $("#hfIdPatMov").val("");
    $("#txtNmrPatMov").append();
    $("#btnSalvarProd").css("display", "none");
    $("#divScroll").css("display", "none");
    $("#tblDadosProd").css("display", "none");
    $("#hfIdPatMov").val("");
    $("#hfIdSubMov").val("");
}

function SalvarProd() {
    if ($("#lblProd").text() == "Controlador") {
        if ($("#slFormaOperacionalControllerMovimentacao").val() == "0") {
            alert("Selecione uma Forma Operacional!");
            $("#slFormaOperacionalControllerMovimentacao").css("border-color", "red");
            return false;
        }
        else {
            $("#slFormaOperacionalControllerMovimentacao").css("border-color", "");
        }
    }
    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;
    var table = $("#tblGrdProdutos tbody");
    var idSub = $("#hfIdSub").val();
    table.find('tr').each(function (i, el) {
        var $tds = $(this).find('td'),
            idPat = $tds.eq(0).text(),
            Subd = $tds.eq(3).text(),
            End = $tds.eq(4).text(),
            chk = $tds[5].childNodes[0].checked;
        var produto = document.getElementById("lblProd").innerHTML;
        if (chk == true) {
            $.ajax({
                type: 'POST',
                url: '../../WebServices/Materiais.asmx/SalvarProd',
                dataType: "json",
                data: "{'idPrefeitura':'" + IdPrefeitura + "','idPat':'" + idPat + "','SubdivisaoMov':'" + Subd + "','EnderecoMov':'" + End + "','idSub':'" + idSub + "','produto':'" + produto + "','formaOperacional':'" + $("#slFormaOperacionalControllerMovimentacao").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#divtblMov").css("display", "none");
                    $("#modalMov").modal("hide");
                    $("#txtNmrPatMov").val("");
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
                $("#btnAdcParamPlacaCtrl").css("display", "block");
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
        $("#btnAdcParamPlacaCtrl").css("display", "none");
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
            quantidade = $("#txtQtdPlacaCtrl").val();
            break;
        case "coluna":
            quantidade = $("#txtQtdColuna").val();
            break;
        case "cabo":
            quantidade = $("#txtQtdCabo").val();
            break;
        case "Grupo Focal":
            quantidade = $("#txtQtdGrupoFocal").val();
            break;
        case "sistema de iluminação":
            quantidade = $("#txtQtdIlum").val();
            break;
        default: quantidade = $("#txtQtdAcess").val();
    }
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/ValidNmrPatParametro',
        dataType: "json",
        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','NumeroPatrimonio':'" + $("#txtNumPatInicial").val() +
            "','quantidade':'" + quantidade + "'}",
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
                        $("#txtNmrPatlaca").val($("#txtNumPatInicial").val());
                        break;
                    case "coluna":
                        $("#txtNumPatColuna").val($("#txtNumPatInicial").val());
                        break;
                    case "cabo":
                        $("#txtNumPatCabo").val($("#txtNumPatInicial").val());
                        break;
                    case "Grupo Focal":
                        $("#txtNumPatGF").val($("#txtNumPatInicial").val());
                        break;
                    case "sistema de iluminação":
                        $("#txtNumPatSI").val($("#txtNumPatInicial").val());
                        break;
                    default: $("#txtNumPatAcess").val($("#txtNumPatInicial").val());
                }
                $("#mpParametro").modal("hide");
            }
        },
        error: function (data) {
        }
    });
}

function Clear() {
    document.getElementById("lblProdNpatrimonio").title = "";
    $("#txtAcessNumSerie").val("");
    $("#txtFabricanteAcess").val("");
    $("#txtDataInstalAcess").val("");
    $("#txtNomeAcessorio").val("");
    $("#txtNumPatAcess").val("");
    $("#cboLuminariaFixacao").val("");

    $("#txtIluNumeroSerie").val("");
    $("#txtIluFabricante").val("");
    $("#txtIluModelo").val("");
    $("#txtIluDtInstalacao").val("");
    $("#txtIluDtGarantia").val("");
    $("#txtNumPatSI").val("");
    $("#ddlIluAtivo").val("");
    $("#ddlIluTensao").val("");

    $("#txtModeloGrupoFocal").val("");
    $("#txtFabricanteGrupoFocal").val("");
    $("#ddlEstadoOperacionalGrupoFocal").val("");
    $("#txtNumPatGF").val("");
    $("#txtDtGarantiaGrupoFocal").val("");
    $("#txtDtInstalacaoGrupoFocal").val("");

    $("#txtNmrSerieCabo").val("");
    $("#txtFabricanteCabos").val("");
    $("#txtModeloCabos").val("");
    $("#txtDataInstalacaoCabos").val("");
    $("#txtDataGarantiaCabos").val("");
    $("#txtNumPatCabo").val("");
    $("#ddlInstalacaoCabos").val("");
    $("#ddlMeioInstalacaoCabos").val("");
    $("#txtMetrosCabos").val("");
    $("#ddlEstadoOperacionalCabos").val("");

    $("#txtNumPatColuna").val("");
    $("#txtFabricanteColuna").val("");
    $("#txtNrSerieColuna").val("");
    $("#txtDtGarantiaColuna").val("");
    $("#txtDtInstalacaoColuna").val("");
    $("#txtModeloColuna").val("");
    $("#ddlEstadoOperacionalColuna").val("");
    $("#ddlFixacaoColuna").val("");

    $("#txtFabricanteGprsNbk").val("");
    $("#lblFabricanteGprs").val("");
    $("#txtNmrPatGprsNbk").val("");
    $("#lblnrpatGprs").val("");
    $("#txtNmrLinhaGprsNbk").val("");
    $("#txtDtGarantiaGprsNbk").val("");
    $("#txtDtInstalGprsNbk").val("");
    $("#txtModeloGprsNbk").val("");
    $("#lblModelGprs").val("");
    $("#ddlOperadoraGprsNbk").val("");
    $("#ddlEstadoOperacionalGprsNbk").val("");

    $("#txtNbkAutonomia").val("");
    $("#txtNbkDataGarantia").val("");
    $("#txtNbkFabricante").val("");
    $("#txtNbkDataInstal").val("");
    $("#txtNbkModelo").val("");
    $("#txtNbkNumPat").val("");
    $("#txtNbkPotencia").val("");
    $("#ddlNbkAtivo").val("");
    $("#ddlNbkFixacao").val("");
    $("#ddlNbkMonitoracao").val("");

    $("#txtCapSuportada").val("");
    $("#txtProduto").val("");
    $("#ddlFormaOperacional").val("");
    $("#ddlCtrlFixacao").val("");
    $("#txtNmrSerie").val("");
    $("#txtNumPat").val("");
    $("#txtCtrlDtGarantia").val("");
    $("#txtCtrlDtInstalacao").val("");
    $("#txtCtrlFabricante").val("");
    $("#txtCtrlModelo").val("");
    $("#txtCtrlTipo").val("");
    $("#ddlCtrlTensaoIn").val("");
    $("#ddlCtrlTensaoOut").val("");
    $("#txtCapSuportada").val("");
    $("#txtCtrlCapacidadeFaseInst").val("");
    $("#ddlEstadoOperacional").val("");

    $("#txtFabricantePlaca").val("");
    $("#txtPlacaModelo").val("");
    $("#txtPlacaDtInstal").val("");
    $("#txtPlacaDtGarantia").val("");
    $("#txtNmrPatlaca").val("");
    $("#ddlPlacaAtivo").val("");

    $("#txtQtdPlacaCtrl").val("1");
    $("#txtQtdColuna").val("1");
    $("#txtQtdCabo").val("1");
    $("#txtQtdGrupoFocal").val("1");
    $("#txtQtdIlum").val("1");
    $("#txtQtdAcess").val("1");

}

function SalvarProdutoNPat() {
    var Produto = document.getElementById("lblProdNpatrimonio").innerHTML;
    $("#mpMensagem").modal("hide");
    switch (Produto) {
        case "Controlador":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            CtrlSave($("#btnCtrlSave").val());
            break;
        case "Gprs Controlador":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            SalvarGprsC($("#btnSalvarGpsC").val());
            break;
        case "Placa Controlador":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            PlacaSave($("#btnPlacaSave").val());
            break;
        case "Nobreak":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            EditNobreak($("#btnEditNobreak").val());
            break;
        case "Gprs Nobreak":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            SalvarGprsNbk($("#btnSalvarGprsNbk").val());
            break;
        case "Coluna":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            AddColuna($("#btnAddColuna").val());
            break;
        case "Cabos":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            AddCabos($("#btnSalvarCabos").val());
            break;
        case "Grupo Focal":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            EditGrupoFocal($("#btnEditGrupoFocal").val());
            break;
        case "Sistema de Iluminação":
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            SalvarIlu($("#btnSalvarIlu").val());
            break;
        default:
            document.getElementById("lblProdNpatrimonio").title = "Salvar";
            AdicionarAcessorio($("#btnSalvarAcessorio").val());
            break;
    }
}

function Almoxarifado() {
    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;

    var Prod = document.getElementById("lblProd").innerHTML;
    var dataSub = [];
    $("#tblDadosProd").css("display", "none");
    $("#tblDadosSub").css("display", "none");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/Almoxarifado',
        dataType: 'json',
        data: "{'idPrefeitura':'" + IdPrefeitura + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d.length == 0) {
                alert("Nenhum Almoxarifado encontrado!");
                document.getElementById("divSelAlmoxarifado").style.display = "none";
                $("#tblGrdSubdivisao").css("display", "none");
                $("#divtblMov").css("display", "none");
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
                document.getElementById("divSelAlmoxarifado").style.display = "block";
                document.getElementById("aSelAlmoxarifado").innerHTML = "Selecione o Almoxarifado:";

                $("#tblGrdProdutos").css("display", "none");
                var dados = data.d;
                $("#tbGrdSubdivisao").empty();
                var qtd = 1;
                $("#tblGrdSubdivisao").css("display", "block");
                $("#divtblMov").css("display", "block");

                $.each(dados, function (index, dados) {
                    var newRow = $("<tr>");
                    var cols = "";

                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;display:none'>" + dados.idSub + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Subdivisao + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Endereco + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'><label onClick=\"SelecionaSubMov('" + dados.Subdivisao + "','" + dados.Endereco + "','" + dados.idSub + "');\" style='cursor:pointer;font-size:15px;margin-bottom:0px;font-weight:100;color:#23527c;'>Selecionar</label></td>";


                    dataSub.push({
                        id: dados.idSub,
                        nome: dados.Subdivisao,
                        end: dados.Endereco
                    });

                    newRow.append(cols);
                    $("#tblGrdSubdivisao").append(newRow);
                    qtd++;
                });
            }

        },
        error: function (response) {
        }
    });
}

function Manutencao() {
    var IdPrefeitura = document.getElementById("hfIdPrefeitura").value;

    var Prod = document.getElementById("lblProd").innerHTML;
    var dataSub = [];
    $("#tblDadosProd").css("display", "none");
    $("#tblDadosSub").css("display", "none");
    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/Manutencao',
        dataType: 'json',
        data: "{'idPrefeitura':'" + IdPrefeitura + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.d.length == 0) {
                alert("Nenhuma Subdivisão de Manutenção encontrada!");
                document.getElementById("divSelAlmoxarifado").style.display = "none";
                $("#tblGrdSubdivisao").css("display", "none");
                $("#divtblMov").css("display", "none");
                return false;

            }
            if (data.d.length == 1) {
                document.getElementById("divSelAlmoxarifado").style.display = "none";
                var dados = data.d[0];
                $("#tblGrdSubdivisao").css("display", "none");
                $("#tblDadosSub").css("display", "block");

                $("spnIdLocal").append();
                $("spnEndereco").append();
                document.getElementById("spnIdLocal").innerHTML = dados.Subdivisao;
                document.getElementById("spnEndereco").innerHTML = dados.Endereco;
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
            }

            else {
                document.getElementById("divSelAlmoxarifado").style.display = "block";
                document.getElementById("aSelAlmoxarifado").innerHTML = "Selecione a Subdivisão de Manutenção:";

                $("#tblGrdProdutos").css("display", "none");
                var dados = data.d;
                $("#tbGrdSubdivisao").empty();
                var qtd = 1;
                $("#tblGrdSubdivisao").css("display", "block");
                $("#divtblMov").css("display", "block");
                $.each(dados, function (index, dados) {
                    var newRow = $("<tr>");
                    var cols = "";

                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;display:none'>" + dados.idSub + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Subdivisao + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Endereco + "</td>";
                    cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'><label onClick=\"SelecionaSubMov('" + dados.Subdivisao + "','" + dados.Endereco + "','" + dados.idSub + "');\" style='cursor:pointer;font-size:15px;margin-bottom:0px;font-weight:100;color:#23527c;'>Selecionar</label></td>";


                    dataSub.push({
                        id: dados.idSub,
                        nome: dados.Subdivisao,
                        end: dados.Endereco
                    });

                    newRow.append(cols);
                    $("#tblGrdSubdivisao").append(newRow);
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

    var Prod = document.getElementById("lblProd").innerHTML;
    document.getElementById("divSelAlmoxarifado").style.display = "none";
    $("#tblGrdSubdivisao").css("display", "none");
    $("#tblDadosSub").css("display", "block");
    $("#tblDadosProd").css("display", "none");
    $("spnIdLocal").append();
    $("spnEndereco").append();
    document.getElementById("spnIdLocal").innerHTML = Sub;
    document.getElementById("spnEndereco").innerHTML = End;
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

                $("#btnSalvarProd").css("display", "block");
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;display:none'>" + dados.idPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Produto + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.NmrPatrimonio + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Subdivisao + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'>" + dados.Endereco + "</td>";
                cols += "<td style='border: 1px solid black; border-collapse: collapse; padding: 5px;'><input type='checkbox' id='chk' \"></td>";

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
}

function MovimentarManutencao(valor) {
    document.getElementById("lblprodManutencao").innerHTML = valor.title;
    idPatrimonio = $(valor).data("id");
    $("#modalManutencao").modal("show");
}

function SubdivisaoClick(valor) {
    idSubdivisaoMov = $(valor).data("id");
    SubdivisaoMov = $(valor).text();
    $("#lblSubSelecionada").text(SubdivisaoMov);
    $("#" + idSubdivisaoMov).toggle();
}

function salvarManutencao() {

    $.ajax({
        type: 'POST',
        url: '../../WebServices/Materiais.asmx/salvarManutencao',
        dataType: "json",
        data: "{'idPatrimonio':'" + idPatrimonio + "','idSubdivisaoMov':'" + idSubdivisaoMov +
            "','idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','motivo':'" + $("#txtMotivo").val() +
            "','ocorrencia':'" + $("#txtOcorrencia").val() + "','produto':'" + document.getElementById("lblprodManutencao").innerHTML + "'}",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            FindDNA();
            $("#txtMotivo").val("");
            $("#txtOcorrencia").val("");
        },
        error: function (data) {
            FindDNA();
        }
    });

}
