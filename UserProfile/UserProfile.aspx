<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEnd.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="ConcertTicketingSystem.Project.UserProfile.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css' rel='stylesheet' />
    <script type='text/javascript' src='https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js'></script>
    <link href="/assets/css/UserProfile/UserProfile.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%--<body classname='snippet-body'>--%>

        <div class="wrapper bg-white mt-sm-5">
            <h4 class="pb-4 border-bottom">Account settings</h4>
            <div><asp:Image ID="ImageControl" runat="server" CssClass="rounded img-fluid img-thumbnail" /></div><br />
            <div class="d-flex align-items-start py-3 border-bottom">
                <asp:Image ID="ProfileImage" runat="server" CssClass="img" ImageUrl="https://images.pexels.com/photos/1037995/pexels-photo-1037995.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500" AlternateText="" />
                <div class="pl-sm-4 pl-2" id="img-section">
                    <b>Profile Photo</b>
                    <p>Accepted file type .png. Less than 1MB</p>
                    <!-- File input for image selection -->
                    <asp:FileUpload ID="FileUploadControl" runat="server" CssClass="form-control form-control-sm" accept=".png" onchange="previewImage()" />
                    
                    <asp:Label ID="lblMessage" runat="server" Text="" CssClass="error-message"></asp:Label>
                </div>
            </div>


            <div class="py-2">
                <div class="row py-2">
                    <div class="col-md-6">
                        <label for="name">Name</label>
                        <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="bg-light form-control" placeholder="Steve"></asp:TextBox>

                        <!-- RequiredFieldValidator for Name -->
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="FirstNameTextBox"
                            ErrorMessage="Name Field is Required!" ForeColor="Red" CssClass="error-message" ValidationGroup="myInput"
                            SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                        <!-- RegularExpressionValidator for Name -->
                        <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="FirstNameTextBox"
                            ErrorMessage="Please enter the Name in all letters!" ForeColor="Red" ValidationGroup="myInput"
                            ValidationExpression="^[a-zA-Z][a-zA-Z ]*$" SetFocusOnError="True" CssClass="error-message" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <div class="col-md-6 pt-md-0 pt-3">
                        <label for="phone">Phone Number</label>
                        <asp:TextBox ID="PhoneTextBox" runat="server" CssClass="bg-light form-control" placeholder="+6012 345 6789"></asp:TextBox>
                        <!-- RequiredFieldValidator for Phone Number -->
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="PhoneTextBox"
                            ErrorMessage="Phone Number is Required!" ForeColor="Red" ValidationGroup="myInput"
                            SetFocusOnError="True" Display="Dynamic" CssClass="error-message"></asp:RequiredFieldValidator>
                        <!-- RegularExpressionValidator for Phone Number (Malaysia) -->
                        <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="PhoneTextBox"
                            ErrorMessage="Invalid Phone Number Format!" ForeColor="Red" ValidationGroup="myInput"
                            ValidationExpression="(\+?6?01)[02-46-9]-*[0-9]{7}$|^(\+?6?01)[1]-*[0-9]{8}$" SetFocusOnError="True" Display="Dynamic" CssClass="error-message"></asp:RegularExpressionValidator>
                    </div>
                </div>

                <div class="row py-2">
                    <div class="col-md-6">
                        <label for="email">Email Address</label>
                        <asp:TextBox ID="EmailTextBox" runat="server" CssClass="bg-light form-control" placeholder="steve_@email.com"></asp:TextBox>
                        <!-- RequiredFieldValidator for Email -->
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="EmailTextBox"
                            ErrorMessage="Email Address is Required!" ForeColor="Red" ValidationGroup="myInput"
                            SetFocusOnError="True" Display="Dynamic" CssClass="error-message"></asp:RequiredFieldValidator>
                        <!-- RegularExpressionValidator for Email -->
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="EmailTextBox"
                            ErrorMessage="Invalid Email Address!" ForeColor="Red" ValidationGroup="myInput"
                            ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" SetFocusOnError="True"
                            Display="Dynamic" CssClass="error-message"></asp:RegularExpressionValidator>
                    </div>
                    <div class="col-md-6 pt-md-0 pt-3">
                        <label for="password">Password</label> <asp:Button ID="Button1" runat="server" Text="[Change]" BorderStyle="None" BackColor="White" Font-Size="Small" Font-Bold="true" OnClick="Button1_Click"  />
                        <asp:TextBox ID="password" runat="server" CssClass="bg-light form-control" Value="Abc12345" TextMode="Password" ReadOnly="true"></asp:TextBox>
                        <!-- RequiredFieldValidator for Address -->
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="password"
                            ErrorMessage="Password Field is Required!" ForeColor="Red" ValidationGroup="Input"
                            SetFocusOnError="True" Display="Dynamic" CssClass="error-message"></asp:RequiredFieldValidator>

                        <!-- RegularExpressionValidator for Address -->
                        <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="password"
                            ErrorMessage="Please enter a valid password!" ForeColor="Red" ValidationGroup="myInput"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$" SetFocusOnError="True" Display="Dynamic" CssClass="error-message"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="row py-2">
                    <div class="col-md-6">
                        <label for="country">Date Of Birth</label>

                        <asp:TextBox ID="birthday" runat="server" type="date" CssClass="bg-light form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="birthday" ErrorMessage="Date of birth is required." CssClass="error-message" ForeColor="Red" ValidationGroup="myInput" Display="Dynamic"></asp:RequiredFieldValidator>

                    </div>
                    <div class="col-md-6 pt-md-0 pt-3">
                        <label for="gender">Gender</label>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="bg-light">
                            <asp:ListItem Value=""></asp:ListItem>
                            <asp:ListItem Value="Male">Male</asp:ListItem>
                            <asp:ListItem Value="Female">Female</asp:ListItem>

                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlGender" ErrorMessage="Gender is required." ForeColor="Red" ValidationGroup="myInput" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div>
                    <asp:Label ID="lblSuccess" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>
                    <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false"></asp:Label>
                </div>
                <div class="py-3 pb-4 ">
                    <asp:Button ID="SaveChangesButton" runat="server" Text="Save Changes" CssClass="btn btn-primary mr-3" ValidationGroup="myInput" OnClick="SaveChangesButton_Click1" />
                    <asp:Button ID="CancelButton" runat="server" Text="Cancel" CssClass="btn border button" OnClick="CancelButton_Click" />
                </div>

            </div>
        </div>

    <%--</body>--%>

    <script>

        function previewImage() {
            var fileUploadControl = document.getElementById('<%= FileUploadControl.ClientID %>');
            var profileImage = document.getElementById('<%= ProfileImage.ClientID %>');

            if (fileUploadControl.files && fileUploadControl.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    profileImage.src = e.target.result;
                }
                reader.readAsDataURL(fileUploadControl.files[0]);
            }
        }
    </script>




</asp:Content>
