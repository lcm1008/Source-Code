<%@ Page Title="" Language="C#" MasterPageFile="~/Public.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ConcertTicketingSystem.Register.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        * {
            margin: 0;
            font-family: 'Arial', sans-serif;
        }
    </style>
    <br />
    <div class="container-fluid min-vh-75">
        <div class="row">
            <div class="col-lg-6 mx-auto">

                <div class="card" id="cardd" runat="server">
                    <%--<form runat="server">--%>
                        <div class="card-body">

                            <%--<div class="row">
                                <div class="col">
                                    <center>
                                        <img width="100px" src="../assets/img/user.png" />
                                    </center>
                                </div>
                            </div>--%>

                            <div class="row">
                                <div class="col">
                                    <center>
                                        <h3>Member Registration</h3>
                                    </center>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col">
                                    <center>
                                        <hr />
                                    </center>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Label ID="Label1" runat="server" Text="Full Name"></asp:Label>
                                    <div class="input-group mb-1">
                                        <asp:TextBox CssClass="form-control" placeholder="Full Name" ID="name" runat="server"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="name"
                                        ErrorMessage="Please enter your name."
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                        ControlToValidate="name"
                                        ErrorMessage="Please enter your name in letter format"
                                        ValidationExpression="^[a-zA-Z][a-zA-Z ]*$"
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:RegularExpressionValidator>
                                </div>

                                <div class="col-md-6">
                                    <asp:Label ID="Label2" runat="server" Text="Date of Birth"></asp:Label>
                                    <div class="input-group mb-1">
                                        <asp:TextBox CssClass="form-control" placeholder="Date of Birth" ID="dob" runat="server" TextMode="Date"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ControlToValidate="dob"
                                        ErrorMessage="Please select your date of birth."
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="CustomValidator1" runat="server"
                                        ControlToValidate="dob"
                                        ClientValidationFunction="validateDate"
                                        ErrorMessage="You must be at least 18 years old to register."
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:CustomValidator>

                                    <script type="text/javascript">
                                        function validateDate(sender, args) {
                                            var selectedDate = new Date(args.Value);
                                            var today = new Date();
                                            var minAgeDate = new Date();
                                            minAgeDate.setFullYear(minAgeDate.getFullYear() - 18); // Calculate date 18 years ago

                                            if (selectedDate > today || selectedDate > minAgeDate) {
                                                args.IsValid = false;
                                            } else {
                                                args.IsValid = true;
                                            }
                                        }
                                    </script>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Label ID="Label3" runat="server" Text="Contact No"></asp:Label>
                                    <div class="input-group mb-1">
                                        <asp:TextBox CssClass="form-control" placeholder="Contact No" ID="contact" runat="server"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                        ControlToValidate="contact"
                                        ErrorMessage="Please enter your contact number."
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                                        ControlToValidate="contact"
                                        ErrorMessage="Please enter a valid contact number (10 to 11 digits)"
                                        ValidationExpression="^\d{10,11}$"
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:RegularExpressionValidator>
                                </div>
                                <div class="col-md-6">
                                    <asp:Label ID="Label4" runat="server" Text="Email"></asp:Label>
                                    <div class="input-group mb-1">
                                        <asp:TextBox CssClass="form-control" placeholder="Email" ID="email" runat="server" TextMode="Email"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                        ControlToValidate="email"
                                        ErrorMessage="Please enter your email."
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Label ID="Label7" runat="server" Text="Gender"></asp:Label>
                                    <div class="input-group mb-1">
                                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" >
                                            <asp:ListItem Selected="True" Value="">Please Select One</asp:ListItem>
                                            <asp:ListItem Value="Male">Male</asp:ListItem>
                                            <asp:ListItem Value="Female">Female</asp:ListItem>
                                        </asp:DropDownList>

                                    </div>
                                    <div class="col-md-6">
                                        <asp:RequiredFieldValidator ID="DropDownListValidator" runat="server"
                                            ControlToValidate="DropDownList1"
                                            InitialValue=""
                                            ErrorMessage="Please select one option."
                                            Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    </div>
                                    <%--<div class="input-group mb-1">
                                 <asp:TextBox CssClass="form-control" placeholder="Full Address" ID="address" runat="server" Rows="4" TextMode="MultiLine" Columns="50"></asp:TextBox>
                             </div>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                 ControlToValidate="address"
                                 ErrorMessage="Please enter your address."
                                 ForeColor="Red"
                                 Display="Dynamic">
                             </asp:RequiredFieldValidator>--%>
                                </div>
                                <%--                                <div class="col-md-6">
                                    <asp:Label ID="Label8" runat="server" Text="Contact Number: "></asp:Label>
                                    <div class="input-group mb-1">
                                        <asp:TextBox CssClass="form-control" placeholder="012-345678" ID="telField" runat="server" TextMode="Phone"></asp:TextBox>

                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                        ControlToValidate="telField"
                                        ErrorMessage="Please enter your Phone."
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="PhoneNumberValidator" runat="server"
                                        ControlToValidate="telField"
                                        ValidationExpression="^\+60\d{1,2}-\d{7,8}$"
                                        ErrorMessage="Enter a valid Malaysian phone number."
                                        Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>--%>
                            </div>

                            <div class="row">
                                <div class="col-md-6">

                                    <asp:Label ID="Label6" runat="server" Text="Password"></asp:Label>
                                    <div class="input-group mb-1">
                                        <asp:TextBox CssClass="form-control" ID="pass" runat="server" TextMode="Password" placeholder="Password">Password</asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                        ControlToValidate="pass"
                                        ErrorMessage="Please enter a password."
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                        ControlToValidate="pass"
                                        ErrorMessage="Password must be at least 8 characters long and include at least 1 uppercase letter, 1 lowercase letter, 1 digit, and 1 symbol."
                                        ValidationExpression="^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^\w\d\s]).{8,}$"
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:RegularExpressionValidator>
                                </div>
                                <div class="col-md-6">
                                    <asp:Label ID="Label5" runat="server" Text="Confirm Password"></asp:Label>
                                    <div class="input-group mb-1">
                                        <asp:TextBox CssClass="form-control" ID="cpass" runat="server" TextMode="Password" placeholder="Confirm Password">Confirm Password</asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                        ControlToValidate="cpass"
                                        ErrorMessage="Please enter again the password."
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>

                                <center>
                                    <br />
                                    <asp:CompareValidator ID="PasswordCompareValidator" runat="server"
                                        ControlToValidate="cpass"
                                        ControlToCompare="pass"
                                        Operator="Equal"
                                        Type="String"
                                        ErrorMessage="Passwords are not match."
                                        ForeColor="Red"
                                        Display="Dynamic">
                                    </asp:CompareValidator>

                                </center>

                            </div>

                            <div class="row">
                                <div class="col">
                                    <div class="input-group mb-3 mt-1 d-grid gap-2">
                                        <asp:Button ID="register" CssClass="btn btn-success" runat="server" Text="Register" OnClick="register_Click" />
                                        
                                    </div>
                                </div>
                            </div>
                        </div>

                    <%--</form>--%>
                </div>
            </div>



        </div>
    </div>
    <div class="row">
        <div class="col d-flex justify-content-center">
            <asp:Label ID="lblMessage" runat="server" ClientIDMode="Static"></asp:Label>
        </div>
    </div>
    <br />
</asp:Content>
