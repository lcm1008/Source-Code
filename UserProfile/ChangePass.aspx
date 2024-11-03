<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEnd.Master" AutoEventWireup="true" CodeBehind="ChangePass.aspx.cs" Inherits="ConcertTicketingSystem.ChangePass.ChangePass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/css/login.css">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" rel="stylesheet" />
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <script type="text/javascript">
        function validateNewPassword(sender, args) {
            var currentPassword = document.getElementById('<%= currentPass.ClientID %>').value;
            var newPassword = args.Value;

            if (currentPassword === newPassword) {
                args.IsValid = false;
            } else {
                args.IsValid = true;
            }
        }

        function confirmChangePassword() {
            var confirmed = confirm("Are you sure you want to change your password?");
            if (!confirmed) {
                return false; // Prevent the server-side click event if user cancels
            }

            return Page_ClientValidate();
        }

    </script>

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
                                <asp:TextBox ID="currentPass" runat="server" placeholder="Current Password**" class="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ControlToValidate="currentPass"
                                    ErrorMessage="Please enter your current Password."
                                    ForeColor="Red"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="PassFormatValidator" runat="server"
                                    ControlToValidate="currentPass"
                                    ValidationExpression="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^\w\d\s]).{8,}$"
                                    ErrorMessage="Invalid Password"
                                    Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                                <br />
                            </div>

                            <%--Password field--%>
                            <div class="form-label-group">
                                <asp:TextBox ID="inputNewPassword" runat="server" placeholder="New Password**" class="form-control" TextMode="Password"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    ControlToValidate="inputNewPassword"
                                    ErrorMessage="Please enter your New Password."
                                    ForeColor="Red"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="passwordValidator" runat="server"
                                    ControlToValidate="inputNewPassword"
                                    ClientValidationFunction="validateNewPassword"
                                    ErrorMessage="New password cannot be the same as the current password."
                                    Display="Dynamic"
                                    ForeColor="Red">
                                </asp:CustomValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                    ControlToValidate="inputNewPassword"
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
                                    ControlToCompare="inputNewPassword"
                                    ErrorMessage="Passwords do not match."
                                    ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                                <br />
                                <div style="margin-left: auto; margin-right: auto; text-align: center;">
                                <asp:Label ID="lblMessage" runat="server">
                                </asp:Label></div>
                                <br />
                            </div>



                            <asp:Button ID="updatePass" runat="server" Text="Update Password" CssClass="btn btn-lg btn-primary btn-block text-uppercase" OnClick="updatePass_Click" OnClientClick="return confirmChangePassword();"/>


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

