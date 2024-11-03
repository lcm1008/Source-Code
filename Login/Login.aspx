<%@ Page Title="" Language="C#" MasterPageFile="~/Public.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ConcertTicketingSystem.Login.Login" Async="true" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/css/login.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" rel="stylesheet" />
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
                <div class="card card-signin my-5">
                    <div class="card-body">
                        <h4 class="card-title text-center"><b>Login</b></h4>
                        <%--<form class="form-signin" runat="server">--%>

                        <%--Email Field--%>
                        <div class="form-label-group mt-3">
                            <asp:TextBox ID="inputEmail" runat="server" placeholder="Email address" class="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ControlToValidate="inputEmail"
                                ErrorMessage="Please enter your Email."
                                ForeColor="Red"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="EmailFormatValidator" runat="server"
                                ControlToValidate="inputEmail"
                                ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b"
                                ErrorMessage="Enter a valid email address."
                                Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                            <br />
                        </div>

                        <%--Password field--%>
                        <div class="form-label-group">
                            <asp:TextBox ID="inputPassword" runat="server" placeholder="Password" class="form-control" TextMode="Password"></asp:TextBox>

                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    ControlToValidate="inputPassword"
                                    ErrorMessage="Please enter your Password."
                                    ForeColor="Red"
                                    Display="Dynamic"></asp:RequiredFieldValidator>--%>
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                    ControlToValidate="inputPassword"
                                    ErrorMessage="Password must be at least 8 characters long and include at least 1 uppercase letter, 1 lowercase letter, 1 digit, and 1 symbol."
                                    ValidationExpression="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^\w\d\s]).{8,}$"
                                    ForeColor="Red"
                                    Display="Dynamic">
                                </asp:RegularExpressionValidator>--%>

                            <br />

                        </div>

                        <div>
                            <p>
                                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                            </p>
                            <p>Forget Password ? <a href="ForgetPassEmail.aspx">Click Here</a></p>

                        </div>

                        <%-- Google Recaptcha --%>
                        <div class="g-recaptcha" data-sitekey="6LfUC6UpAAAAAHSkQByUjXtyQlBDjh5PdygxfBgx" style="margin-left: 60px;"></div>
                        <br />



                        <%--<button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit" cssclass="btn btn-lg btn-primary btn-block text-uppercase">Sign in</button>--%>

                        <asp:Button ID="submit" runat="server" Text="Log In" CssClass="btn btn-lg btn-dark btn-block text-uppercase" OnClick="submit_Click" />

                        <hr class="my-4">
                        <!--
                            <button class="btn btn-lg btn-google btn-block text-uppercase" type="submit"><i class="fab fa-google mr-2"></i>Sign in with Google</button>
                            <button class="btn btn-lg btn-facebook btn-block text-uppercase" type="submit"><i class="fab fa-facebook-f mr-2"></i>Sign in with Facebook</button>-->
                        <div class="login_message">
                            <p>Don&rsquo;t have an account ? <a href="../Register/Register.aspx">Register </a></p>
                        </div>
                        <div class="login_message">
                            <p><a href="#">Click Here </a> if you are an admin </p>
                        </div>
                        <%--</form>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</asp:Content>
