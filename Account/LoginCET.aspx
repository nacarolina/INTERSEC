<%@ Page Title="Login - Central Semafórica" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CentralSemaforica.Account.Login" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Central Semafórica</title>
    <style type="text/css">
        .border {
            -moz-border-radius: 30px; /* Para Firefox */
            -webkit-border-radius: 30px; /*Para Safari e Chrome */
            border-radius: 30px; /* Para Opera 10.5+*/
            border-color: transparent;
        }

        html {
            background: url(../Images/FundoTeste.jpg) no-repeat center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }

        .validation-summary-errors {
            font-weight: 700;
            margin-bottom: 0px;
        }

        input[type="text"] {
        border: 1px solid #c4c4c4;
    /*width: 180px;*/
    font-size: 13px;
    padding: 4px 4px 4px 4px;
    border-radius: 6px;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;
    box-shadow: 0px 0px 4px #d9d9d9;
    -moz-box-shadow: 0px 0px 4px #d9d9d9;
    -webkit-box-shadow: 0px 0px 4px #d9d9d9;
    transition: border 0.3s linear 0s, color 0.5s linear 0s;
    transition: box-shadow 0.3s linear 0s, color 0.5s linear 0s;
}
input[type="text"]:focus {
        border: 1px solid #c4c4c4;
    /*width: 180px;*/
       outline: none;
    border: 1px solid #5fbbd9;
    box-shadow: 0px 0px 6px #4CA2BF;
    -moz-box-shadow: 0px 0px 4px #4CA2BF;
    -webkit-box-shadow: 0px 0px 4px #4CA2BF;
}
input[type="password"] {
        border: 1px solid #c4c4c4;
    /*width: 180px;*/
    font-size: 13px;
    padding: 4px 4px 4px 4px;
    border-radius: 6px;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;
    box-shadow: 0px 0px 4px #d9d9d9;
    -moz-box-shadow: 0px 0px 4px #d9d9d9;
    -webkit-box-shadow: 0px 0px 4px #d9d9d9;
    transition: border 0.3s linear 0s, color 0.5s linear 0s;
    transition: box-shadow 0.3s linear 0s, color 0.5s linear 0s;
}
input[type="password"]:focus {
        border: 1px solid #c4c4c4;
    /*width: 180px;*/
       outline: none;
    border: 1px solid #5fbbd9;
    box-shadow: 0px 0px 6px #4CA2BF;
    -moz-box-shadow: 0px 0px 4px #4CA2BF;
    -webkit-box-shadow: 0px 0px 4px #4CA2BF;
}
        .field-validation-error {
            font-weight: 700;
        }
        .auto-style2 {
            height: 27px;
        }
        .auto-style3 {
            height: 24px;
        }
        .auto-style4 {
            height: 28px;
        }

        .myButton {
	-moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
	box-shadow:inset 0px 1px 0px 0px #ffffff;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #f6f6f6));
	background:-moz-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
	background:-webkit-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
	background:-o-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
	background:-ms-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
	background:linear-gradient(to bottom, #ffffff 5%, #f6f6f6 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#f6f6f6',GradientType=0);
	background-color:#ffffff;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #dcdcdc;
	display:inline-block;
	cursor:pointer;
	color:#666666;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ffffff;
}
.myButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #f6f6f6), color-stop(1, #ffffff));
	background:-moz-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
	background:-webkit-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
	background:-o-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
	background:-ms-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
	background:linear-gradient(to bottom, #f6f6f6 5%, #ffffff 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f6f6f6', endColorstr='#ffffff',GradientType=0);
	background-color:#f6f6f6;
}
.myButton:active {
	position:relative;
	top:1px;
}

    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div style="text-align: center; margin-top: 4%">

            <img id="imgLogo" style="width: 500px;" src="../Images/LogoCentraL_cet.png">
        </div>
        <table align="center" style="margin-top: 34px; font-family: Century Gothic; border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-top: 8px;
padding-left: 8px; padding-right: 8px; box-shadow: 0px 0px 8px #ffffff; -moz-box-shadow: 0px 0px 8px #ffffff; -webkit-box-shadow: 0px 0px 8px #ffffff;">
            <tr align="center">
                <td style="letter-spacing: 1px;
border-bottom: 1px solid darkgray;height: 24px;" colspan="2">Dados do Login</td>
            </tr>
            <tr  align="center">
                <td class="auto-style2" colspan="2">
                    <asp:Login ID="Login1" runat="server" ViewStateMode="Disabled" OnLoggedIn="Login1_LoggedIn">
                        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                        <LayoutTemplate>
                    
                                <asp:Literal runat="server" ID="FailureText" />
                       

                            <table>
                                <tr>
                                    <td class="auto-style3">
                                        <asp:Label ID="Label1" runat="server" AssociatedControlID="UserName">Usuário</asp:Label>:</td>
                                </tr>

                                <tr>
                                    <td>
                                        <asp:TextBox runat="server" ID="UserName" placeholder="Digite o Usuário" Width="250px" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" CssClass="field-validation-error" ErrorMessage="*" ForeColor="Red" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">
                                        <asp:Label ID="Label2" runat="server" AssociatedControlID="Password">Senha:</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="Password" runat="server" placeholder="Digite a Senha" TextMode="Password" Width="250px" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Password" CssClass="field-validation-error" ErrorMessage="*" ForeColor="Red" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style4">
                                        <asp:CheckBox ID="RememberMe" runat="server" />
                                        <asp:Label ID="Label3" runat="server" AssociatedControlID="RememberMe" CssClass="checkbox">Lembrar</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="Button1" runat="server" class="myButton" CommandName="Login" Text="Login" Width="268px" />
                                    </td>
                                </tr>
                            </table>


                        </LayoutTemplate>

                        <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
                        <TextBoxStyle Font-Size="0.8em" />
                        <TitleTextStyle BackColor="#507CD1" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />

                    </asp:Login>
                </td>
            </tr>
            <tr>
                <td align="center" style="height:60px">
                     <asp:Image ID="imgLogoCET" runat="server" ImageUrl="~/Images/LogoCET.jpg" Width="200px" />
                                    
                </td>
                <td align="center" style="height:60px">
                     <asp:Image ID="imgLogoCobrasin" runat="server" ImageUrl="~/Images/LogoCobrasin.png" Width="200px" />
                                    
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
