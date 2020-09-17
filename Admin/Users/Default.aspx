<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Admin.Users.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

	<link href="../../Styles/forms-styles.css" rel="stylesheet" />
	<link href="../../Styles/popup-styles.css" rel="stylesheet" />
	<script src="../../assets/sweetalert-dev.js"></script>
	<link href="../../assets/sweetalert.css" rel="stylesheet" />

	<style type="text/css">
		.MarginGrid {
			margin-left: 32px;
		}
	</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
	<h4>
		<i class="fas fa-users"></i>
		<%= Resources.Resource.usuario %></h4>
	<hr />
	<div>
		<%= Resources.Resource.usuario %>:<br />
		<div class="input-group">
			<asp:TextBox ID="txtFind" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
			<span class="input-group-btn">
				<asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" OnClick="btnFind_Click"><i class="fas fa-search"></i></asp:LinkButton>
				<button type="button" class="btn btn-success" data-toggle="modal" onclick="addUser();" data-target="#modalUser"><i class="fas fa-user-plus"></i></button>
			</span>
		</div>
	</div>

	<br />
	<asp:Panel ID="Panel4" runat="server" Height="450px" ScrollBars="Horizontal">
		<small class="text-muted">* <%= Resources.Resource.lista %> - <%= Resources.Resource.usuario %></small>
		<hr />
		<asp:GridView ID="grdUsers" ClientIDMode="Static" Font-Size="Smaller" CssClass="table table-bordered table-hover" runat="server" AutoGenerateColumns="False" CellPadding="4"
			DataSourceID="dsMembersFilter" ForeColor="Black" GridLines="Horizontal" DataKeyNames="Usuario" OnRowDeleting="grdUsers_RowDeleting"
			OnSelectedIndexChanged="grdUsers_SelectedIndexChanged" BorderStyle="None" BorderWidth="1px" Width="100%">
			<Columns>
				<asp:BoundField DataField="Usuario" HeaderText="<%$ Resources:Resource, usuario %>" />
				<asp:BoundField DataField="Email" HeaderText="Email" />
				<asp:TemplateField ShowHeader="False">
					<ItemTemplate>
						<asp:LinkButton ID="LinkEdit" runat="server" CssClass="btn btn-primary" CausesValidation="False" CommandName="Select" Text="Select"><i class="fas fa-user-edit"></i></asp:LinkButton>
					</ItemTemplate>
				</asp:TemplateField>
				<asp:TemplateField ShowHeader="False">
					<ItemTemplate>
						<asp:LinkButton ID="LinkExcluir" runat="server" CssClass="btn btn-danger" CausesValidation="False" CommandName="Delete" Text="Excluir"><i class="fas fa-user-times"></i></asp:LinkButton>
					</ItemTemplate>
				</asp:TemplateField>

				<asp:TemplateField ShowHeader="False"></asp:TemplateField>
			</Columns>
			<FooterStyle BackColor="White" ForeColor="Black" />
			<HeaderStyle BackColor="White" ForeColor="Black" />
			<PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
			<SelectedRowStyle BackColor="White" ForeColor="black" />
			<SortedAscendingCellStyle BackColor="#F7F7F7" />
			<SortedAscendingHeaderStyle BackColor="#4B4B4B" />
			<SortedDescendingCellStyle BackColor="#E5E5E5" />
			<SortedDescendingHeaderStyle BackColor="#242121" />
			<EmptyDataTemplate><%= Resources.Resource.naoHaRegistros %></EmptyDataTemplate>
		</asp:GridView>
	</asp:Panel>
	<asp:ObjectDataSource ID="dsMembers" runat="server" OldValuesParameterFormatString="original_{0}"
		SelectMethod="GetAllUsers" TypeName="infortronics.User"></asp:ObjectDataSource>
	<asp:ObjectDataSource ID="dsMembersFilter" runat="server" OldValuesParameterFormatString="original_{0}"
		SelectMethod="GetUser2" TypeName="infortronics.User">
		<SelectParameters>
			<asp:ControlParameter ControlID="txtFind" Name="Usuario" PropertyName="Text"
				Type="String" />
		</SelectParameters>
	</asp:ObjectDataSource>

	<asp:Button runat="server" ID="cmdPopup" Style="display: none;" />
	<ajaxToolkit:ModalPopupExtender ID="mpAlert" runat="server" BackgroundCssClass="modalBackground"
		CancelControlID="cmdFechar" DropShadow="true" PopupControlID="pnlCad" PopupDragHandleControlID="programmaticPopupDragHandle"
		TargetControlID="cmdPopup">
	</ajaxToolkit:ModalPopupExtender>


	<asp:Panel ID="pnlCad" runat="server" BackColor="White" Width="600px" CssClass="modal-content modal-position">
		<asp:Panel runat="Server" ID="programmaticPopupDragHandle" CssClass="modal-header" Style="cursor: move; text-align: left;">
			<table style="height: 21px; width: 100%">
				<tr>
					<td style="margin-left: 10px; padding-left: 10px; font-size: medium;">
						<h4 class="modal-title"><i class="fas fa-users-cog"></i><%= Resources.Resource.usuario %> - <%= Resources.Resource.configuracoes %></h4>
					</td>
					<td style="text-align: right; margin-right: 0px; padding-right: 0px; color: white; font-size: medium;">
						<asp:ImageButton ID="cmdFechar" runat="server" ImageUrl="~/Images/close24.png"
							ImageAlign="Right" BackColor="#4CA2BF" BorderColor="#4CA2BF" Width="16px" Height="16px" />
					</td>
				</tr>
			</table>
		</asp:Panel>
		<br />

		<asp:Panel ID="pnlBody" runat="server" CssClass="modal-body">
			<asp:FormView ID="FormView1" runat="server" CellPadding="4" DataSourceID="dsMember"
				ForeColor="#333333" OnModeChanging="FormView1_ModeChanging" OnItemUpdated="FormView1_ItemUpdated" CssClass="MarginGrid" Width="500px">
				<EditRowStyle BackColor="#FFFFFF" />
				<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
				<%-- <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"/>--%>
				<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
				<RowStyle BackColor="#FFFFFF" ForeColor="#333333" />
				<HeaderTemplate>
				</HeaderTemplate>
				<ItemTemplate>
					<table class="table table-striped">
						<tr>
							<td colspan="2"><i class="fas fa-user-check"></i><%= Resources.Resource.detalhes %></td>
						</tr>
						<tr>
							<td><%= Resources.Resource.usuario %>:
                                <asp:Label ID="lblUser" runat="server" Text='<%# Bind("Usuario") %>' /></td>
						</tr>
						<tr>
							<td><%= Resources.Resource.empresa %>:
                                <asp:Label ID="lblEmpresa" runat="server" Text='<%# Bind("EmpresaUsuario") %>' /></td>
						</tr>
						<tr>
							<td>Email:
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
							</td>
						</tr>
						<tr>
							<td><%= Resources.Resource.data %>:
                                <asp:Label ID="lblDtCad" runat="server" Text='<%# Eval("DataCadastro") %>' />
							</td>
						</tr>
						<tr>
							<td><%= Resources.Resource.ultimoAcesso %>:
                                <asp:Label ID="lblLastAcesso" runat="server" Text='<%# Eval("UltimoAcesso") %>' />
							</td>
						</tr>
						<caption style="float: right;">
							<asp:Button ID="btnEdit" CssClass="btn btn-primary" CommandName="Edit" runat="server" Text="<%$ Resources:Resource, editar %>"></asp:Button></caption>
					</table>


				</ItemTemplate>
				<EditItemTemplate>
					<table class="table table-striped" style="width: 100%">
						<tr>
							<td colspan="2"><i class="fas fa-user-edit"></i>- <%= Resources.Resource.editar %></td>
						</tr>
						<tr>
							<td>Email:
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' Width="100%" />
								<asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="txtEmail"
									CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>"
									ValidationGroup="edit">*</asp:RequiredFieldValidator>
								<asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationGroup="edit"
									ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail"
									ErrorMessage="<%$ Resources:Resource, emailInvalido %>"
									SetFocusOnError="True"></asp:RegularExpressionValidator>
								<ajaxToolkit:ValidatorCalloutExtender ID="vceEmail" runat="Server" TargetControlID="EmailRequired" />
								<ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="Server" TargetControlID="regexEmailValid" />
							</td>
						</tr>
						<tr>
							<td><%= Resources.Resource.empresa %>:
                            <asp:TextBox ID="txtEmpresa" CssClass="form-control" runat="server" Text='<%# Bind("EmpresaUsuario") %>' Width="100%" />
							</td>
						</tr>
						<tr>
							<td><%= Resources.Resource.comentario %>:
                            <asp:TextBox ID="txtComentario" CssClass="form-control" runat="server" Text='<%# Bind("Comentario") %>' Height="80px"
								Rows="3" TextMode="MultiLine" />
							</td>
						</tr>
						<caption style="float: right;">
							<asp:Button ID="btnSave" CssClass="btn btn-success" CommandName="Update" ValidationGroup="edit" runat="server" Text="<%$ Resources:Resource, salvar %>" />
							<asp:Button ID="btnCancel" CssClass="btn btn-danger" CommandName="Cancel" runat="server" Text="<%$ Resources:Resource, cancelar %>" />
						</caption>
					</table>

				</EditItemTemplate>
			</asp:FormView>
			<br />
			<%--        <div style="width:580px; border: 1px solid darkgray; background-color: black; color: #FFFFFF; height: 32px;">

                        <b style="color: #FFFFFF; margin-left: 32px;"> Permissões do Usuário</b>
        </div>--%>
			<%--<small class="text-muted">* Lista de Permissões do Usuários</small>
            <hr />
            <asp:Panel ID="Panel3" runat="server" Height="300px" ScrollBars="Horizontal">

                <asp:GridView ID="grdRoles" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" DataSourceID="dsRoles" GridLines="Horizontal" OnPageIndexChanging="grdRoles_PageIndexChanging" OnRowDataBound="grdRoles_RowDataBound" PageSize="5">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkOn" runat="server" AutoPostBack="True" Checked='<%# Bind("on") %>' Enabled="true" OnCheckedChanged="chkOn_CheckedChanged1" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkOn" runat="server" AutoPostBack="True" Checked='<%# Bind("on") %>' Enabled="true" OnCheckedChanged="chkOn_CheckedChanged" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Permissao" HeaderText="Permissões" />
                    </Columns>
                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                    <HeaderStyle BackColor="White" ForeColor="Black" />
                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="White" ForeColor="Black" />
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#242121" />
                </asp:GridView>
            </asp:Panel>--%>

			<asp:ObjectDataSource ID="dsMember" runat="server" OldValuesParameterFormatString="original_{0}"
				SelectMethod="GetUser" TypeName="infortronics.User" UpdateMethod="UpdateUser">
				<SelectParameters>
					<asp:ControlParameter ControlID="grdUsers" Name="Usuario" PropertyName="SelectedValue"
						Type="String" />
				</SelectParameters>
				<UpdateParameters>
					<asp:ControlParameter ControlID="grdUsers" Name="Usuario" PropertyName="SelectedValue"
						Type="String" />
					<asp:Parameter Name="Email" Type="String" />
					<asp:Parameter Name="Comentario" Type="String" />
				</UpdateParameters>
			</asp:ObjectDataSource>
			<asp:ObjectDataSource ID="dsRoles" runat="server" OldValuesParameterFormatString="original_{0}"
				SelectMethod="GetRoles" TypeName="infortronics.User">
				<SelectParameters>
					<asp:ControlParameter ControlID="grdUsers" Name="Usuario" PropertyName="SelectedValue"
						Type="String" />
				</SelectParameters>
			</asp:ObjectDataSource>
		</asp:Panel>
	</asp:Panel>

	<div class="modal fade" id="modalUser" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/Images/close24.png"
						ImageAlign="Right" BackColor="#4CA2BF" BorderColor="#4CA2BF" Width="16px" Height="16px" />
					<h4 class="modal-title"><i class="fas fa-user-plus"></i><%= Resources.Resource.cadastroUsuario %></h4>
				</div>
				<div class="modal-body">
					<table class="table table-striped">
						<tr>
							<td colspan="2"><%= Resources.Resource.usuario %>:
                        <asp:TextBox ID="txtUserName" ClientIDMode="Static" runat="server" CssClass="form-control"></asp:TextBox>
								<asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="txtUserName" CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" ValidationGroup="RegisterUserValidationGroup" Style="color: #000000">*</asp:RequiredFieldValidator>
								<ajaxToolkit:ValidatorCalloutExtender ID="vceName" runat="Server" TargetControlID="UserNameRequired" />
							</td>
						</tr>
						<tr>
							<td colspan="2"><%= Resources.Resource.empresa %>:
                        <asp:TextBox ID="txtEmpresa" ClientIDMode="Static" runat="server" CssClass="form-control"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td colspan="2">Email:
                        <asp:TextBox ID="txtEmail" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
								<span style="color: #000000;">
									<asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="txtEmail" CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
									<ajaxToolkit:ValidatorCalloutExtender ID="vceEmail" runat="Server" TargetControlID="EmailRequired" />
									<asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ControlToValidate="txtEmail" ErrorMessage="<%$ Resources:Resource, emailInvalido %>" SetFocusOnError="True" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="RegisterUserValidationGroup"></asp:RegularExpressionValidator>
								</span></td>
						</tr>
						<tr>
							<td><%= Resources.Resource.senha %>:
                        <asp:TextBox ID="txtPassword" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Password" Width="250px"></asp:TextBox>
								<asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="txtPassword" CssClass="failureNotification" ErrorMessage=" <%$ Resources:Resource, campoObrigatorio %>" ValidationGroup="RegisterUserValidationGroup" Style="color: #000000">*</asp:RequiredFieldValidator>
								<ajaxToolkit:ValidatorCalloutExtender ID="vceSenha" runat="Server" TargetControlID="PasswordRequired" />
							</td>
							<td><%= Resources.Resource.digiteSenhaNovamente %>:
                        <asp:TextBox ID="txtConfirmPassword" runat="server" ClientIDMode="Static" CssClass="form-control" TextMode="Password" Width="250px"></asp:TextBox>
								<span style="color: #000000;">
									<asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="txtConfirmPassword" CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
									<asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, senhasNaoCorrenspondem %>" ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>
								</span></td>
						</tr>
						<tr>
							<td colspan="3">
								<small class="text-danger">Min. <%= Resources.Resource.caracteres %>: 
            <%= Membership.MinRequiredPasswordLength %>
									<br />
									Min. <%= Resources.Resource.caracteres %> <%= Resources.Resource.alfanumericos %>: 
                                    <%= Membership.MinRequiredNonAlphanumericCharacters %> (Ex.: @ ! # $ % &amp; * )
								</small>
							</td>
						</tr>
						<tr>
							<td><%= Resources.Resource.perguntaSecreta %>:
                        <asp:TextBox ID="txtPasswordQuestion" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPasswordQuestion" CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" ValidationGroup="RegisterUserValidationGroup" Style="color: #000000">*</asp:RequiredFieldValidator>
								<ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="Server" TargetControlID="RequiredFieldValidator1" />
							</td>
							<td><%= Resources.Resource.resposta %> <%= Resources.Resource.perguntaSecreta %>:
                        <asp:TextBox ID="txtPasswordAnswer" runat="server" ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPasswordAnswer" CssClass="failureNotification" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" ValidationGroup="RegisterUserValidationGroup" Style="color: #000000">*</asp:RequiredFieldValidator>
								<ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="Server" TargetControlID="RequiredFieldValidator2" />
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<asp:Button ID="CreateUserButton" runat="server" OnClick="CreateUserButton_Click" Text="<%$ Resources:Resource, salvar %>" ValidationGroup="RegisterUserValidationGroup" CssClass="btn btn-success" Height="32px" Width="180px" />
					<button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
				</div>
			</div>

		</div>
	</div>

	<script>
		function AvisoPopupUser(aviso, tipo) {
			if (tipo == 'invalido') {
				$("#modalUser").modal("show");
				swal("<%= Resources.Resource.atencao %>", aviso, "warning");
			}
			else {
				$("#modalUser").modal("hide");
				swal("<%= Resources.Resource.informacao %>", aviso, "success");
			}
		}

		function addUser() {
			$("#txtUserName").text("");
			$("#txtEmail").text("");
			$("#txtPassword").text("");
			$("#txtConfirmPassword").text("");
			$("#txtPasswordQuestion").text("");
			$("#txtPasswordAnswer").text("");
		}
	</script>

</asp:Content>
