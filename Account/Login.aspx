<%@ Page Title="Login" Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="GwCentral.Account.Login" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" class="loading" lang="pt-BR" data-textdirection="ltr">

<!-- BEGIN: Head-->

<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui" />
    <meta name="description" content="Chameleon Admin is a modern Bootstrap 4 webapp &amp; admin dashboard html template with a large number of components, elegant design, clean and organized code." />
    <meta name="keywords" content="admin template, Chameleon admin template, dashboard template, gradient admin template, responsive admin template, webapp, eCommerce dashboard, analytic dashboard" />
    <meta name="author" content="INFORTRONICS" />
    <title>Login - <%= Resources.Resource.site_name %></title>
    <link rel="apple-touch-icon" href="../app-assets/images/ico/apple-icon-120.png" />
    <link rel="shortcut icon" type="image/x-icon" href="../app-assets/images/ico/favicon.ico" />
    <link href="https://fonts.googleapis.com/css?family=Muli:300,300i,400,400i,600,600i,700,700i%7CComfortaa:300,400,700" rel="stylesheet" />

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="../app-assets/vendors/css/vendors.min.css" />
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="../app-assets/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../app-assets/css/bootstrap-extended.css" />
    <link rel="stylesheet" type="text/css" href="../app-assets/css/colors.css" />
    <link rel="stylesheet" type="text/css" href="../app-assets/css/components.css" />
    <!-- END: Theme CSS-->

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="../app-assets/css/core/menu/menu-types/vertical-menu-modern.css" />
    <link rel="stylesheet" type="text/css" href="../app-assets/css/core/colors/palette-gradient.css" />
    <link rel="stylesheet" type="text/css" href="../app-assets/css/pages/login-register.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css" />
    <!-- END: Custom CSS-->

    <style>
        .Titulo_Logo {
            color: white;
            font-size: 45px;
        }

        .Caixa {
            width: 50%;
        }

        @media (max-width: 372px) {
            .Titulo_Logo {
                font-size: 36px;
            }
        }

        @media (max-width: 322px) {
            .Titulo_Logo {
                font-size: 26px;
            }
        }
    </style>
</head>

<!-- END: Head-->

<!-- BEGIN: Body-->

<body runat="server" class="vertical-layout vertical-menu-modern 1-column  bg-full-screen-image blank-page blank-page" data-open="click" data-menu="vertical-menu-modern" data-color="bg-gradient-x-purple-red" data-col="1-column">
    <!-- BEGIN: Content-->
    <form runat="server">

        <div class="app-content content">
            <div class="content-wrapper">
                <div class="content-wrapper-before"></div>
                <div class="content-header row">
                </div>
                <div class="content-body">
                    <section class="flexbox-container">
                        <div class="col-12 d-flex align-items-center justify-content-center">
                            <div class="col-lg-4 col-md-6 col-10 p-0 Caixa">
                                <div class="card border-grey border-lighten-3 px-1 py-1 m-0" style="background-color: transparent; max-width: 450px;">
                                    <div class="card-header border-0" style="background-color: transparent;">
                                        <div class="text-center mb-1">
                                            <img src="../app-assets/images/logo/logo.png" alt="branding logo">
                                        </div>
                                        <div class="text-center Titulo_Logo">
                                            INTERSEC
                                   
                                        </div>
                                    </div>
                                    <div class="card-content">

                                        <div class="card-body">

                                            <asp:Login ID="Login1" runat="server" ViewStateMode="Disabled" OnLoggedIn="Login1_LoggedIn" FailureText="<%$ Resources:Resource, erroLogin %>" Style="width: 100%;" OnLoginError="Login1_LoginError1">
                                                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                                                <LayoutTemplate>

                                                    <form class="form-horizontal" action="index.html" novalidate>
                                                        <fieldset class="form-group position-relative has-icon-left">
                                                            <asp:TextBox runat="server" ID="UserName" type="text" class="form-control round" placeholder="Digite o usuário" required />
                                                            <div class="form-control-position">
                                                                <i class="ft-user"></i>
                                                            </div>
                                                        </fieldset>
                                                        <fieldset class="form-group position-relative has-icon-left">
                                                            <asp:TextBox ID="Password" runat="server" TextMode="Password" type="password" class="form-control round" placeholder="Digite a senha" required />
                                                            <div class="form-control-position">
                                                                <i class="ft-lock"></i>
                                                            </div>
                                                        </fieldset>
                                                        <asp:Panel ID="pnlErro"  Visible="false" class="alert alert-danger mb-2" role="alert" runat="server">
                                                            <asp:Literal runat="server" ID="FailureText" />
                                                        </asp:Panel>


                                                        <div class="form-group row">

                                                            <div class="col-md-6 col-12 text-center text-sm-left">
                                                            </div>
                                                            <div class="col-md-6 col-12 float-sm-left text-center text-sm-right"><a href="#" class="card-link" style="color:#5ed84f;">Esqueceu a senha?</a></div>
                                                        </div>
                                                        <div class="form-group text-center">
                                                            <span style="color: red;">

                                                                <asp:Button ID="Button1" runat="server" CommandName="Login" Text="<%$ Resources:Resource, entrar %>" type="submit" class="btn btn-block btn-outline-success btn-min-width box-shadow-2 mr-1 mb-1 btn-lg" />
                                                        </div>

                                                    </form>

                                                </LayoutTemplate>
                                                <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
                                                <TextBoxStyle Font-Size="0.8em" />
                                                <TitleTextStyle BackColor="#507CD1" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />

                                            </asp:Login>


                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                </div>
            </div>
        </div>
    </form>
    <!-- END: Content-->


    <!-- BEGIN: Vendor JS-->
    <script src="../app-assets/vendors/js/vendors.min.js" type="text/javascript"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../app-assets/js/core/app-menu.js" type="text/javascript"></script>
    <script src="../app-assets/js/core/app.js" type="text/javascript"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="../app-assets/js/scripts/forms/form-login-register.js" type="text/javascript"></script>
    <!-- END: Page JS-->

</body>

<!-- END: Body-->

</html>
