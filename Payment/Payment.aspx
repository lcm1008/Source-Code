<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEnd.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="ConcertTicketingSystem.Payment.Payment" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/css/payment.css">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" rel="stylesheet" />
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>



    <script type="text/javascript">
        function updateDateTime() {
            var now = new Date();
            var date = now.toLocaleDateString();
            var time = now.toLocaleTimeString();
            var dateTimeString = date + ' ' + time;
            document.getElementById('<%= dateTime.ClientID %>').textContent = dateTimeString;
        }

        // Update date and time every second
        setInterval(updateDateTime, 1000);

        // Initial update
        window.onload = function () {
            updateDateTime();
        };

        // Function to add leading zero to single digits
        function padZero(num) {
            return (num < 10 ? '0' : '') + num;
        }

        // Dynamically populate the month options
        var monthSelect = document.getElementById('month');
        for (var i = 1; i <= 12; i++) {
            var option = document.createElement('option');
            option.value = i;
            option.text = padZero(i);
            monthSelect.appendChild(option);
        }

        // Dynamically populate the year options
        var yearSelect = document.getElementById('year');
        var currentYear = new Date().getFullYear();
        for (var i = currentYear; i <= currentYear + 10; i++) { // You can adjust the range of years here
            var option = document.createElement('option');
            option.value = i;
            option.text = i;
            yearSelect.appendChild(option);
        }


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container py-5">

        <!-- End -->

        <div class="row mb-4">
            <div class="col-lg-8 mx-auto text-center">
                <h1 class="display-6"><b>Payment</b></h1>
            </div>
        </div>


        <div class="col-lg-6 mx-auto">
            <div class="card ">
                <div class="card-header">

                    <!-- Credit card form content -->
                    <div class="tab-content">
                        <div id="datetime" style="margin-left: 400px">
                            <b>
                                <asp:Label ID="dateTime" runat="server" Text=""></asp:Label></b>
                        </div>
                        <!-- credit card info-->
                        <div id="credit-card" class="tab-pane fade show active pt-3">
<%--                            <form role="form" onsubmit="" runat="server">--%>
                                <div class="form-group">
                                    <label for="username">
                                        <h6>Card Owner</h6>
                                    </label>
                                    <input type="text" name="username" placeholder="Card Owner Name" required class="form-control " pattern="^((?:[A-Za-z]+ ?){1,3})$" title="Enter your full name as stated on your card.">
                                </div>
                                <div class="form-group">
                                    <label for="cardNumber">
                                        <h6>Card number</h6>
                                    </label>
                                    <div class="input-group">
                                        <input type="text" name="cardNumber" placeholder="Valid card number" class="form-control " required pattern="^(4[0-9]{15}|5[1-5][0-9]{14})$" title="Please check card number entered. We only accept Visa and Master Card">
                            <%-- Sample Visa = value="4111111111111111"--%>
                                        <div class="input-group-append"><span class="input-group-text text-muted"><i class="fab fa-cc-visa mx-1" title="Visa"></i><i class="fab fa-cc-mastercard mx-1" title="Master Card"></i></span></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-8">
                                        <div class="form-group">
                                            <label>
                                                <span class="hidden-xs">
                                                    <h6>Expiration Date</h6>
                                                </span>
                                            </label>
                                            <div class="input-group">
                                                
                                                <asp:DropDownList ID="monthDropdown" runat="server" CssClass="form-control" required>
                                                    <asp:ListItem Text="MM" Value="" />
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="yearDropdown" runat="server" CssClass="form-control" required>
                                                    <asp:ListItem Text="YY" Value="" />
                                                </asp:DropDownList>


                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group mb-4">
                                            <label data-toggle="tooltip" title="Three digit CV code on the back of your card">
                                                <h6>CVV <i class="fa fa-question-circle d-inline"></i></h6>
                                            </label>
                                            <input type="text" required class="form-control" pattern="^\d{3}$" title="Please check back of your card for 3 CVV digit number.">
                                        </div>
                                    </div>
                                </div>

                                <%-- Google Recaptcha --%>
                                <div class="g-recaptcha" data-sitekey="6LfUC6UpAAAAAHSkQByUjXtyQlBDjh5PdygxfBgx" style="margin-left: 110px;" ></div>
                                <br />


                                <div class="card-footer">

                                    <asp:Button ID="conPay" runat="server" Text="Confirm Payment" CssClass="subscribe btn btn-primary btn-block shadow-sm" OnClientClick="showNotification()" OnClick="conPay_Click" />

                                </div>
                            <%--</form>--%>



                        </div>
                    </div>

 
                    <!-- End -->

                    <!-- End -->
                </div>


            </div>
        </div>
       
    </div>


</asp:Content>
