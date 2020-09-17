<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="GwCentral.Register.CityHall.register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
	<h4><i class="fas fa-list-alt" style="margin-right: 10px;"></i><%= Resources.Resource.cliente %></h4>
	<hr />
	<asp:HiddenField runat="server" ClientIDMode="Static" ID="hfIdCliente"></asp:HiddenField>

	<table class="table table-bordered">
		<tr>
			<td><%= Resources.Resource.nome %>:
                <asp:TextBox ID="txtPrefeitura" CssClass="form-control" runat="server" Width="400px"></asp:TextBox></td>
			<td style="width: 400px">Site:
                <asp:TextBox ID="txtSite" CssClass="form-control" runat="server" Width="400px"></asp:TextBox></td>
			<td><%= Resources.Resource.telefone %>:
                <asp:TextBox ID="txtTelefone" CssClass="form-control" runat="server" Width="150px"></asp:TextBox></td>
		</tr>
		<tr>
			<td>Email:
                <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server"></asp:TextBox></td>
			<td colspan="2"><%= Resources.Resource.endereco %>:
                <asp:TextBox ID="txtEndereco" CssClass="form-control" runat="server"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="width: 135px; color: #000000;">Logo <%= Resources.Resource.empresa %>:
                <asp:FileUpload ID="FileUpload1" runat="server" /></td>
			<td colspan="2"><%= Resources.Resource.porta %> Reset:
                <asp:TextBox ID="txtPortaReset" CssClass="form-control" runat="server"></asp:TextBox>
			</td>
		</tr>
	</table>
	<table style="width: 700px; margin-left: 32px; display: none;">
		<tr>
			<td>
				<div style="display: inline">
					<p><span><%= Resources.Resource.usaSemaforoSicapp %></span><input type="checkbox" id="chkSemaforoSicapp" style="margin-left: 10px; margin-right: 10px;" /><input type="text" id="txtClientes" disabled="disabled" /></p>
				</div>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td style="margin-right: 10px;">
				<asp:Button ID="btnSalvarAlteracao" runat="server" Text="<%$ Resources:Resource, salvar %>" OnClick="btnSalvarAlteracao_Click" CssClass="btn btn-success" />
			</td>
			<td>
				<asp:Button ID="btnBack" runat="server" OnClick="btnVoltar_Click" Text="<%$ Resources:Resource, voltar %>" CssClass="btn btn-primary" /></td>
		</tr>
	</table>

	<asp:Panel ID="pnlLoginResponsavel" runat="server" Visible="true">
		<span style="font-size: medium;">Login - <%= Resources.Resource.responsavel %></span>
		<hr />
		<table class="table table-bordered">
			<tr>
				<td><%= Resources.Resource.usuario %>:<br />
					<asp:TextBox ID="txtUserName" runat="server" CssClass="textEntry form-control"></asp:TextBox>
					<asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="txtUserName" CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="vceName" runat="Server" TargetControlID="UserNameRequired" />
				</td>
				<td style="color: #000000;"><strong>Min. <%= Resources.Resource.caracteres %>: <%= Membership.MinRequiredPasswordLength %><br />
					Min. <%= Resources.Resource.caracteres %> <%= Resources.Resource.alfanumericos %>: <%= Membership.MinRequiredNonAlphanumericCharacters %> (Ex.: @ ! # $ % &amp; * )</strong></td>
			</tr>
			<tr>
				<td><%= Resources.Resource.senha %>:<br />
					<asp:TextBox ID="txtPassword" runat="server" CssClass="passwordEntry form-control" TextMode="Password"></asp:TextBox>
					<asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="txtPassword" CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="vceSenha" runat="Server" TargetControlID="PasswordRequired" />
					<ajaxToolkit:ValidatorCalloutExtender ID="vceCSenha" runat="Server" TargetControlID="PasswordRequired" />
				</td>
				<td><%= Resources.Resource.digiteSenhaNovamente %>:<br />
					<asp:TextBox ID="txtConfirmPassword" runat="server" Width="50%" CssClass="passwordEntry form-control" TextMode="Password"></asp:TextBox>
					<asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="txtConfirmPassword"
						CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>"
						ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
					<asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="txtPassword"
						ControlToValidate="txtConfirmPassword" CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, senhasNaoCorrenspondem %>"
						ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="vceCCSenha" runat="Server" TargetControlID="PasswordCompare" />
				</td>
			</tr>
			<tr>
				<td><%= Resources.Resource.perguntaSecreta %>:<br />
					<asp:TextBox ID="txtPasswordQuestion" runat="server" CssClass="textEntry form-control"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPasswordQuestion"
						CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>"
						ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="Server" TargetControlID="RequiredFieldValidator1" />
				</td>
				<td><%= Resources.Resource.resposta %> - <%= Resources.Resource.perguntaSecreta %>:<br />
					<asp:TextBox ID="txtPasswordAnswer" runat="server" Width="50%" CssClass="textEntry form-control"></asp:TextBox>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPasswordAnswer"
						CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>"
						ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
					<ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="Server" TargetControlID="RequiredFieldValidator2" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<asp:Button ID="CreateUserButton" runat="server" class="btn btn-success" OnClick="CreateUserButton_Click" Text="<%$ Resources:Resource, salvar %>" ValidationGroup="RegisterUserValidationGroup" />
					<asp:Button ID="btnVoltar" runat="server" class="btn btn-primary" OnClick="btnVoltar_Click" Text="<%$ Resources:Resource, voltar %>" />
				</td>
			</tr>
		</table>
	</asp:Panel>
	<script>
		$(function () {

			if ($("#hfIdCliente").val() != "") {
				$("#chkSemaforoSicapp").prop("checked", true);
				$("#txtClientes").prop("disabled", false);
			}
			else {
				$("#chkSemaforoSicapp").prop("checked", false);
				$("#txtClientes").prop("disabled", true);
			}

			$("#chkSemaforoSicapp").change(function () {
				if ($("#txtClientes").prop("disabled") == true) {
					$("#txtClientes").prop("disabled", false);
				}
				else {
					$("#txtClientes").prop("disabled", true);
					$("#txtClientes").val("");
					$("#hfIdCliente").val("");
				}
			});

			$.ajax({
				url: 'register.aspx/GetClientsSemaforoSicapp',
				data: "{'idCliente': '" + $("#hfIdCliente").val() + "'}",
				dataType: "json",
				type: "POST",
				contentType: "application/json; charset=utf-8",
				success: function (data) {
					$("#txtClientes").val(data.d);
				},
				error: function (data) { }
			});

			$("#txtClientes").autocomplete({
				source: function (request, response) {
					$.ajax({
						url: 'register.aspx/GetClients',
						data: "{ 'prefixText': '" + request.term + "'}",
						dataType: "json",
						type: "POST",
						contentType: "application/json; charset=utf-8",
						success: function (data) {
							response($.map(data.d, function (item) {
								var lst = item;
								return {
									label: lst.Nome,
									val: lst.Id
								}
							}))
						},
						error: function (response) {
						}
					});
				},
				select: function (e, i) {
					$("#txtClientes").val(i.item.label);
					$("#hfIdCliente").val(i.item.val);
				},
				minLength: 1

			});
		})
	</script>
</asp:Content>
