<%@ Page Title="" Language="C#" MasterPageFile="~/Public.Master" AutoEventWireup="true" CodeBehind="ForgetPassEmail.aspx.cs" Inherits="ConcertTicketingSystem.Login.ForgetPassEmail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/css/login.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" rel="stylesheet" />
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
                <div class="card card-signin my-5">
                    <div class="card-body">
                        <h5 class="card-title text-center"><b><u>Forget Password</u></b></h5>
                        <%--<form class="form-signin" runat="server" onsubmit="">--%>

                            <p style="text-align: center;">Enter email to reset your password</p>

                            <%--Email Field--%>
                            <div class="form-label-group">
                                <asp:TextBox ID="inputEmail" runat="server" placeholder="Email address**" class="form-control" TextMode="Email"></asp:TextBox>
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
                                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                <br />
                                <asp:Label ID="lblMessageSuccess" runat="server"></asp:Label>
                                <br />
                            </div>

                            <div id="messagePlaceholder" style="display: none;">
                                Please check your email for password reset instructions.
                            </div>



                            <asp:Button ID="resetBtn" CssClass="btn btn-lg btn-primary btn-block text-uppercase" runat="server" Text="Forget Password" OnClick="Button1_Click"/>

<%--                            <button id="resetButton" class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">Reset my Password</button>--%>
                            <hr class="my-4">
                        <%--</form>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</asp:Content>
