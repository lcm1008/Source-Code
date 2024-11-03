<%@ Page Title="" Language="C#" MasterPageFile="~/Public.Master" AutoEventWireup="true" CodeBehind="ForgetPass.aspx.cs" Inherits="ConcertTicketingSystem.Login.WebForm1" %>


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
                        <%--<form class="form-signin" runat="server">--%>

                            <%--Email Field--%>
                            <div class="form-label-group">
                                <asp:TextBox ID="inputEmail" runat="server" placeholder="Email address**" class="form-control" ReadOnly="True"></asp:TextBox>
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
                                <asp:TextBox ID="inputPassword" runat="server" placeholder="New Password**" class="form-control" TextMode="Password"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    ControlToValidate="inputPassword"
                                    ErrorMessage="Please enter your New Password."
                                    ForeColor="Red"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                    ControlToValidate="inputPassword"
                                    ErrorMessage="Password must be at least 8 characters long and include at least 1 uppercase letter, 1 lowercase letter, 1 digit, and 1 symbol."
                                    ValidationExpression="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^\w\d\s]).{8,}$"
                                    ForeColor="Red"
                                    Display="Dynamic">
                                </asp:RegularExpressionValidator>
                                <br />
                            </div>


                            <%--Confirm Password field--%>
                            <div class="form-label-group">
                                <asp:TextBox ID="confirmPass" runat="server" placeholder="Confirm Password**" class="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                    ControlToValidate="confirmPass" ErrorMessage="Please re-enter your New Password"
                                    Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="ConfirmPasswordValidator" runat="server"
                                    ControlToValidate="confirmPass"
                                    ControlToCompare="inputPassword"
                                    ErrorMessage="Passwords do not match."
                                    ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                                <br />
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                <br />
                            </div>


                            
                            <asp:Button ID="updatePass" runat="server" Text="Update Password" CssClass="btn btn-lg btn-primary btn-block text-uppercase" OnClick="updatePass_Click" />

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
