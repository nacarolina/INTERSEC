<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Register.ConfigModuloComunicacao.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
	<style>
		.loading {
			position: absolute;
			background: #fff;
			width: 150px;
			height: 150px;
			border-radius: 100%;
			border: 10px solid #5cb85c;
			z-index: 10;
			padding-top: 52px;
			font-size: large;
			color: #5cb85c;
		}

			.loading:after {
				content: '';
				background: trasparent;
				width: 140%;
				height: 140%;
				position: absolute;
				border-radius: 100%;
				top: -20%;
				left: -20%;
				opacity: 1.7;
				box-shadow: #5cb85c -4px -5px 3px -3px;
				animation: rotate 2s infinite linear;
			}

		@keyframes rotate {
			0% {
				transform: rotateZ(0deg);
			}

			100% {
				transform: rotateZ(360deg);
			}
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
	<asp:HiddenField ID="hfId" ClientIDMode="Static" runat="server" />

	<asp:HiddenField ID="hfUser" ClientIDMode="Static" runat="server" />
	<h3>Módulo de Comunicação
	</h3>
	<hr />
	<button id="btnExcluir" type="button" class="btn btn-danger" style="margin-left: 10px; width: 180px; display: none;" onclick="ExcluirConfiguracao();" disabled="disabled">Excluir</button>

	<br />
	<div id="dvPesquisa">
		<div class="form-inline" style="margin-bottom: 20px;">
			<div class="form-group">
				Serial:
				<input type="text" class="form-control" id="txtPesqNSerie" style="width: 400px;" />
				<button type="button" class="btn btn-default" onclick="BuscarConfiguracao()" style="width: 180px"><%= Resources.Resource.buscar %></button>
				<button id="btnNovo" type="button" class="btn btn-primary" style="width: 180px;" onclick="Novo();"><%= Resources.Resource.novo %></button>
			</div>
		</div>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th style="font-size:smaller">Nº de Serie</th>
					<th style="font-size:smaller">Serial</th>
					<th style="font-size:smaller">Endereço Servidor 1</th>
					<th style="font-size:smaller">Porta TRAP</th>
					<th style="font-size:smaller">Endereço Servidor 2</th>
					<th style="font-size:smaller">PORTA TRAP</th>
					<%--<th style="font-size:smaller">1ª Operadora</th>
					<th style="font-size:smaller">2ª Operadora</th>--%>
					<th style="font-size:smaller">IP Reset</th>
					<th style="font-size:smaller">Porta Reset</th>
					<th style="font-size:smaller">Porta IIS</th>
					<th style="font-size:smaller">Permissões</th>
					<th style="font-size:smaller">Data Atualização</th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody id="tbModulos">
                <tr>
                    <td colspan="13" style="color:red;">
                        Preencha a Serial para pesquisar!
                    </td>
                </tr>
			</tbody>
		</table>
	</div>
	<div class="modal fade" id="mpCadastro" role="dialog">
		<div class="modal-dialog" style="width: 60%">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><%= Resources.Resource.cadastrar %> <%= Resources.Resource.moduloDeComunicacao %></h4>
				</div>

				<div class="panel-body" id="divRegister">
					<table class="table table-bordered">
						<tr>
							<td>
								<label for="txtNSerie">N° Série:</label>
								<input type="text" class="form-control" id="txtNSerie" style="width: 400px;" /><span id="spnValidaNSerie" style="color: red; font-style: italic; display: none;">*</span>
							</td>
							<td>
								<label for="txtSerial">Serial:</label>
								<input type="text" class="form-control" id="txtSerial" style="width: 400px;" />

							</td>
						</tr>
						<tr>
							<td>
								<label for="txtIP">Endereço Servidor 1:</label><br />
								<input type="text" class="form-control" id="txtIP" style="width: 250px;" />
							</td>
							<td>
								<label for="txtportTrap">Porta TRAP:</label><br />
								<input type="text" class="form-control" id="txtportTrap" style="width: 130px;" />
							</td>
						</tr>
						<tr>
							<td>
								<label for="txtIPExt">Endereço Servidor 2:</label><br />
								<input type="text" class="form-control" id="txtIPExt" style="width: 250px;" />
							</td>
							<td>
								<label for="txtportTrapExt">Porta TRAP:</label><br />
								<input type="text" class="form-control" id="txtportTrapExt" style="width: 130px;" />
							</td>
						</tr>
						<tr>
							<td>
								<label for="cboSimm1">1° Operadora:</label><br />
								<select class="form-control" id="cboSimm1" style="width: 190px;">
									<option value="0">- Selecione - </option>
									<option value="Vivo">Vivo</option>
									<option value="Claro">Claro</option>
									<option value="Oi">Oi</option>
									<option value="Tim">Tim</option>
								</select>
							</td>
							<td>
								<label for="cboSimm2">2° Operadora:</label><br />
								<select class="form-control" id="cboSimm2" style="width: 190px;">
									<option value="0">- Selecione - </option>
									<option value="Vivo">Vivo</option>
									<option value="Claro">Claro</option>
									<option value="Oi">Oi</option>
									<option value="Tim">Tim</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								<label for="txtIP_Reset">IP Reset:</label><br />
								<input type="text" class="form-control" id="txtIP_Reset" style="width: 250px;" />
							</td>
							<td>
								<label for="txtPortaReset">Porta Reset:</label><br />
								<input type="text" class="form-control" id="txtPortaReset" style="width: 130px;" />
							</td>
						</tr>
						<tr>
							<td>
								<label for="txtPortaIIS">Porta IIS:</label>
								<input type="text" class="form-control" id="txtPortaIIS" style="width: 400px;" />
							</td>
							<td>
								<label>
									<input id="chkPermiteReqImg" type="checkbox" />
									Ativar Câmera</label>
								<%--<br />--%>
								<label style="display:none">
									<input id="chkPermiteReset" type="checkbox" />
									Permissão de Reset</label>
							</td>
						</tr>
					</table>

				</div>
				<div class="modal-footer">
					<button id="btnSalvar" type="button" class="btn btn-success" style="display: none; width: 180px" onclick="SalvarConfiguracao();"><%= Resources.Resource.salvar %></button>
					<button id="btnCancelar" type="button" class="btn btn-warning" style="display: none; width: 180px" onclick="Cancelar();"><%= Resources.Resource.cancelar %></button>
				</div>
			</div>
		</div>
	</div>
	<div id="divLoading" style="display: none;">
		<div style="z-index: 9999; background-color: rgba(0,0,0,.4); position: fixed; width: 100%; height: 100%; transition: background-color .1s; top: 0;">
			<div style="background-color: #fff; width: 300px; height: 220px; text-align: center; z-index: 10; padding-left: 75px; padding-top: 30px; border-radius: 10px; position: absolute; margin: auto; top: 0; right: 0; bottom: 0; left: 0;">
				<div class="loading"><%= Resources.Resource.aguarde %> ...</div>
			</div>
		</div>
	</div>
	<script>
		$(function () {
			//BuscarConfiguracao();
		});
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

        function BuscarConfiguracao() {
            if ($("#txtPesqNSerie").val() == "") {
                alert("Preencha a serial para pesquisar!");
                $("#txtPesqNSerie").focus();
                return;
            }
			$("#divLoading").css("display", "block");
			$.ajax({
				type: 'POST',
				url: 'Default.aspx/BuscarConfiguracao',
				dataType: 'json',
				data: "{'nSerie':'" + $("#txtPesqNSerie").val() + "','serial':''}",
				contentType: "application/json; charset=utf-8",
				success: function (data) {
					$("#divLoading").css("display", "none");
					$("#tbModulos").empty();

					if (data.d.length > 0) {
						for (var i = 0; i < data.d.length; i++) {
							var lst = data.d[i];
							var newRow = $("<tr>");
							var cols = "";
							cols += "<td>" + lst.numeroSerie + "</td>";
							cols += "<td>" + lst.serial + "</td>";
							cols += "<td>" + lst.ipAddressServer1 + "</td>";
							cols += "<td>" + lst.portServer1 + "</td>";
							cols += "<td>" + lst.ipAddressServer2 + "</td>";
							cols += "<td>" + lst.portServer2 + "</td>";
							//cols += "<td>" + lst.operadoraSimm1 + "</td>";
							//cols += "<td>" + lst.operadoraSimm2 + "</td>";
							cols += "<td>" + lst.ipReset + "</td>";
							cols += "<td>" + lst.portaReset + "</td>";
							cols += "<td>" + lst.portaIIS + "</td>";
							cols += "<td>";

							if (lst.permiteReqImagens == 'True') {
								cols += "Ativar Câmera; ";
							}
							if (lst.permiteReset == 'True') {
								cols += "Reset; ";
							}
							cols += "</td>";
							
							cols += "<td>" + lst.DtHrAtualizacao + "</td>";
							cols += "<td style='border-collapse: collapse; padding: 5px; width:80px'><input type=\"button\" style=\"width:80px;\" class=\"btn btn-warning\" value=\"<%= Resources.Resource.editar %>\" onclick=\"Selecionar(this)\" data-id='" + lst.id + "' data-numeroserie='" + lst.numeroSerie + "' data-permiteeeqimagens='" + lst.permiteReqImagens + "' data-permitereset='" + lst.permiteReset + "' data-serial='" + lst.serial + "' data-ipAddressServer1='" + lst.ipAddressServer1 + "' data-portServer1='" + lst.portServer1 + "' data-ipAddressServer2='" + lst.ipAddressServer2 + "' data-portServer2='" + lst.portServer2 + "' data-operadoraSimm1='" + lst.operadoraSimm1 + "' data-operadoraSimm2='" + lst.operadoraSimm2 + "' data-portaiis='" + lst.portaIIS + "' data-ipreset='" + lst.ipReset + "' data-portareset='" + lst.portaReset + "' /></td>";
							cols += "<td style='border-collapse: collapse; padding: 5px; width:80px'> <div class=\"btn-group\"><button type=\"button\" style=\"width:80px;\"  class=\"btn btn-danger dropdown-toggle\" data-toggle=\"dropdown\">" +
                                "<%= Resources.Resource.excluir %> <span class=\"caret\"></span></button>" +
								"<ul class=\"dropdown-menu\" role=\"menu\">" +
								"<li><a href=\"#\"onclick='ExcluirConfiguracao(this)' data-id='" + lst.id + "'data-numeroserie='" + lst.numeroSerie + "' data-permiteeeqimagens='" + lst.permiteReqImagens + "' data-permitereset='" + lst.permiteReset + "' data-serial='" + lst.serial + "' data-ipAddressServer1='" + lst.ipAddressServer1 + "' data-portServer1='" + lst.portServer1 + "' data-ipAddressServer2='" + lst.ipAddressServer2 + "' data-portServer2='" + lst.portServer2 + "' data-operadoraSimm1='" + lst.operadoraSimm1 + "' data-operadoraSimm2='" + lst.operadoraSimm2 + "' data-portaiis='" + lst.portaIIS + "' data-ipreset='" + lst.ipReset + "' data-portareset='" + lst.portaReset +"'><%= Resources.Resource.sim %></a></li>" +
								"</ul>" +
								"</div></td>";
							newRow.append(cols);
							$("#tbModulos").append(newRow);
						}
					}
					else {
						var newRow = $("<tr>");
						var cols = "<td colspan='14' style='border-collapse: collapse; padding: 5px;'><%= Resources.Resource.naoHaRegistros %></td>";
						newRow.append(cols);
						$("#tbModulos").append(newRow);
					}
				},
				error: function (data) {
					$("#divLoading").css("display", "none");
				}
			});

		}

		function Selecionar(btn) {
			$("#mpCadastro").modal("show");
			$("#txtNSerie").val(btn.dataset.numeroserie);
			$("#txtNSerie").prop("disabled", true);
			$("#hfId").val(btn.dataset.id);
			$("#txtSerial").val(btn.dataset.serial);
			$("#txtIP").val(btn.dataset.ipaddressserver1);
			$("#txtportTrap").val(btn.dataset.portserver1);
			$("#txtIPExt").val(btn.dataset.ipaddressserver2);
			$("#txtportTrapExt").val(btn.dataset.portserver2);
			$("#cboSimm1").val(btn.dataset.operadorasimm1);
			$("#cboSimm2").val(btn.dataset.operadorasimm2);
			$("#txtPortaIIS").val(btn.dataset.portaiis);
			$("#txtIP_Reset").val(btn.dataset.ipreset);
			$("#txtPortaReset").val(btn.dataset.portareset);
			$("#btnCancelar").css("display", "");
			$("#btnSalvar").css("display", "");

			if (btn.dataset.permiteeeqimagens == "True") $("#chkPermiteReqImg").prop("checked", true);
			else $("#chkPermiteReqImg").prop("checked", false);

			if (btn.dataset.permitereset == "True") $("#chkPermiteReset").prop("checked", true);
			else $("#chkPermiteReset").prop("checked", false);
			$("#btnExcluir").prop("disabled", false);

		}

		function SalvarConfiguracao() {
			if ($("#txtSerial").val() == "") {
				alert("A Serial é obrigatório para a configuração do Módulo de comunicação!");
				$("#txtSerial").focus();
				return false;
			}
			if ($("#txtNSerie").val() == "") {
				alert("O Número de Série é obrigatório para a configuração do Módulo de comunicação!");
				$("#spnValidaNSerie").css("display", "");
				return false;
			}
			else
				$("#spnValidaNSerie").css("display", "none");

			callServer('Default.aspx/SalvarConfiguracao', "{'numeroSerie':'" + $("#txtNSerie").val() + "','serial':'" + $("#txtSerial").val() +
				"','ipAddressServer1':'" + $("#txtIP").val() + "','portServer1':'" + $("#txtportTrap").val() + "','ipAddressServer2':'" + $("#txtIPExt").val() +
				"','portServer2':'" + $("#txtportTrapExt").val() + "','operadoraSimm1':'" + $("#cboSimm1").val() + "','operadoraSimm2':'" + $("#cboSimm2").val() +
				"','portaIIS':'" + $("#txtPortaIIS").val() + "','ipReset':'" + $("#txtIP_Reset").val() + "','portaReset':'" + $("#txtPortaReset").val() +
				"','permiteReqImagens':'" + $("#chkPermiteReqImg").prop("checked") + "','permiteReset':'" + $("#chkPermiteReset").prop("checked") + "','id':'" + $("#hfId").val() + "'}",

				function (data) {
					if (data != "SUCESSO") {
						if (data == "serial") {
							alert("Já tem um módulo com essa Serial!");

						} else {
							alert("Já tem um módulo com esse Nº de Serie!");
						}
						return;
					} else {
						BuscarConfiguracao();
						alert("Salvo com sucesso!");
					}
					$("#mpCadastro").modal("hide");

				});
		}

		function ExcluirConfiguracao(btn) {
			callServer('Default.aspx/ExcluirConfiguracao', "{'id':'" + btn.dataset.id + "'}",
				function (data) {
					alert("Excluído com sucesso!");
					BuscarConfiguracao();
				});
		}

		function Cancelar() {
			$("#txtNSerie").val("");
			$("#txtNSerie").prop("disabled", false);
			$("#txtSerial").val("");
			$("#hfId").val("");
			$("#txtIP").val("");
			$("#txtportTrap").val("");
			$("#txtIPExt").val("");
			$("#txtportTrapExt").val("");
			$("#cboSimm1").val("");
			$("#cboSimm2").val("");
			$("#txtPortaIIS").val("");
			$("#txtIP_Reset").val("");
			$("#txtPortaReset").val("");
			$("#chkPermiteReqImg").prop("checked", false);
			$("#chkPermiteReset").prop("checked", false);
			$("#mpCadastro").modal("hide");
			$("#btnExcluir").prop("disabled", true);
			$("#btnCancelar").css("display", "none");
			$("#btnExcluir").css("display", "none");
			$("#btnSalvar").css("display", "none");
			$("#btnNovo").css("display", "");
		}

		function Novo() {
			Cancelar();
			$("#btnCancelar").css("display", "");
			$("#btnSalvar").css("display", "");
			$("#mpCadastro").modal("show");
		}
	</script>
</asp:Content>

