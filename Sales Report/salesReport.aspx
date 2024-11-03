<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="salesReport.aspx.cs" Inherits="ConcertTicketingSystem.Project.Admin.salesReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <style type="text/css">
        .auto-style2 {
            width: 351px;
        }

        .auto-style5 {
            width: 351px;
            height: 20px;
        }

        .auto-style8 {
            height: 20px;
            width: 300px;
        }

        .auto-style9 {
            width: 300px;
        }

        .auto-style10 {
            width: 349px;
            height: 20px;
        }

        .auto-style11 {
            width: 349px;
        }

        <style >
        /* CSS code for table */
/*        table {
            border-collapse: collapse;
            border: 10px solid black;
        }

        th, td {
            border: 5px solid black;
            padding: 8px;
            text-align: center;
        }*/

            .sales-grid {
                width: 70%;
                margin: auto;
                border-collapse: collapse;
                border: 1px solid #000;
            }

            .sales-grid th, .sales-grid td {
                border: 1px solid #000;
                padding: 8px;
                text-align: center;
            }

            .auto-style8 {
                /* Style for Year and Month headers */
            }

            .auto-style5 {
                /* Style for Total Sales column */
            }

            .auto-style10 {
                /* Style for Average Sales Per Month column */
            }


    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div style="width: 1050px; margin-left: 50px;">
        <h1>Sales report</h1>
        <%--<p>Please choose the start date and end date that you wish to generate report: </p>

        <asp:DropDownList ID="yearDropdown" runat="server">
            <asp:ListItem>2024</asp:ListItem>
            <asp:ListItem>2023</asp:ListItem>
            <asp:ListItem>2022</asp:ListItem>
            <asp:ListItem>2021</asp:ListItem>
            <asp:ListItem>2020</asp:ListItem>
            <asp:ListItem>2019</asp:ListItem>
            <asp:ListItem>2018</asp:ListItem>
            <asp:ListItem>2017</asp:ListItem>
            <asp:ListItem>2016</asp:ListItem>
        </asp:DropDownList>




        <asp:TextBox ID="startDatePicker" runat="server" CssClass="datepicker" placeholder="Start Date" TextMode="Month"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ControlToValidate="startDatePicker" ErrorMessage="Start Date is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>


        &nbsp;<asp:TextBox ID="endDatePicker" runat="server" CssClass="datepicker" placeholder="End Date" TextMode="Month"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ControlToValidate="endDatePicker" ErrorMessage="End Date is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <asp:CompareValidator ID="cvEndDate" runat="server" ControlToValidate="endDatePicker" ControlToCompare="startDatePicker" Operator="GreaterThanEqual" ErrorMessage="End Date must be later than or equal to Start Date" Display="Dynamic" ForeColor="Red"></asp:CompareValidator>



        &nbsp;<asp:Button ID="btnGenerate" runat="server" Text="Generate Chart" OnClick="btnGenerate_Click" />
        <br />--%>
    </div>

    <br />

    <!-- ASP.NET page (SalesReport.aspx) -->
    <div style="text-align: center;">
        <canvas id="salesChart" width="300" height="300" style="display: block; margin-left: auto; margin-right: auto;"></canvas>
<%--        <canvas id="pieChart" width="500" height="500" style="display: block; margin-left: auto; margin-right: auto;"></canvas>--%>
        <div>
            <br />

            <p>
                <b><u>Yearly Total Sales (RM)</u></b>
            </p>
            
            <%--            <p>
                Total sales gain: <b>RM
                <asp:Label ID="totalSalesLabel" runat="server" Text=""></asp:Label></b>
            </p>--%>
<%--            <p>
                Month with the highest sales:  <b>
                    <asp:Label ID="highestSalesLabel" runat="server" Text=""></asp:Label>
                </b>
            </p>--%>

            <div>
                <br />
                <br />
                <%--<table border="1" style="width: 70%; margin-left: auto; margin-right: auto;" title="Total Sales Table">
                    <caption style="text-align: center">Total Sales Table</caption>
                    <tr>
                        <th class="auto-style8">Year</th>
                        <th class="auto-style8">Month</th>
                        <th class="auto-style5">Total Sales (RM)</th>
                        <th class="auto-style10" rowspan="1">Average Sales Per Month (RM)</th>
                    </tr>
                    <tr>
                        <td class="auto-style9">2024</td>
                        <td class="auto-style9">January</td>
                        <td class="auto-style2">500,000</td>
                        <td class="auto-style11" rowspan="5">1,000,000</td>
                    </tr>
                    <tr>
                        <td class="auto-style9">&nbsp;</td>
                        <td class="auto-style9">February</td>
                        <td class="auto-style2">650,000</td>
                    </tr>
                    <tr>
                        <td class="auto-style9">&nbsp;</td>
                        <td class="auto-style9">March</td>
                        <td class="auto-style2">850,000</td>
                    </tr>
                    <tr>
                        <td class="auto-style9">&nbsp;</td>
                        <td class="auto-style9">April</td>
                        <td class="auto-style2">750,000</td>
                    </tr>
                    <tr>
                        <td class="auto-style9">&nbsp;</td>
                        <td class="auto-style9">May</td>
                        <td class="auto-style2">980,000</td>
                    </tr>
                </table>--%>
                
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="sales-grid" AllowPaging="True" style="width: 70%; margin-left: auto; margin-right: auto;">
    <Columns>
        <asp:BoundField DataField="Year" HeaderText="Year" ReadOnly="True" SortExpression="Year" ItemStyle-CssClass="auto-style8" />
        <asp:BoundField DataField="Month" HeaderText="Month" ReadOnly="True" SortExpression="Month" ItemStyle-CssClass="auto-style8" />
        <asp:BoundField DataField="Total Sales" HeaderText="Total Sales (RM)" ReadOnly="True" SortExpression="Total Sales" ItemStyle-CssClass="auto-style5" />
        <asp:BoundField DataField="Average Sales Per Month" HeaderText="Average Sales Per Month (RM)" ReadOnly="True" SortExpression="Average Sales Per Month" ItemStyle-CssClass="auto-style10" />
    </Columns>
</asp:GridView>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT 
    YEAR(p.payment_date) AS Year,
    CASE 
        WHEN MONTH(p.payment_date) = 1 THEN 'January'
        WHEN MONTH(p.payment_date) = 2 THEN 'February'
        WHEN MONTH(p.payment_date) = 3 THEN 'March'
        WHEN MONTH(p.payment_date) = 4 THEN 'April'
        WHEN MONTH(p.payment_date) = 5 THEN 'May'
        WHEN MONTH(p.payment_date) = 6 THEN 'June'
        WHEN MONTH(p.payment_date) = 7 THEN 'July'
        WHEN MONTH(p.payment_date) = 8 THEN 'August'
        WHEN MONTH(p.payment_date) = 9 THEN 'September'
        WHEN MONTH(p.payment_date) = 10 THEN 'October'
        WHEN MONTH(p.payment_date) = 11 THEN 'November'
        ELSE 'December'
    END AS Month,
    SUM(c.total_price) AS [Total Sales],
    ROUND(SUM(c.total_price) / CAST(COUNT(DISTINCT MONTH(p.payment_date)) AS DECIMAL(10, 2)), 2) AS [Average Sales Per Month]
FROM 
    Payment p
JOIN 
    Cart c ON p.payment_id = c.payment_id
WHERE
    c.status = 'paid'
GROUP BY 
    YEAR(p.payment_date),
    MONTH(p.payment_date)
ORDER BY 
    Year DESC, 
    Month DESC;"></asp:SqlDataSource>
            </div>
        </div>
    </div>

   <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<script type="text/javascript">
    function initializePieChart(salesData) {
        var ctx = document.getElementById('salesChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: Object.keys(salesData), // Years
                datasets: [{
                    label: 'Total Sales',
                    data: Object.values(salesData), // Total sales for each year
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.7)',
                        'rgba(54, 162, 235, 0.7)',
                        'rgba(255, 206, 86, 0.7)',
                        'rgba(75, 192, 192, 0.7)',
                        'rgba(153, 102, 255, 0.7)',
                        'rgba(255, 159, 64, 0.7)',
                        'rgba(255, 99, 132, 0.7)',
                        'rgba(54, 162, 235, 0.7)',
                        'rgba(255, 206, 86, 0.7)',
                        'rgba(75, 192, 192, 0.7)',
                        'rgba(153, 102, 255, 0.7)',
                        'rgba(255, 159, 64, 0.7)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: false
            }
        });
    }

</script>




<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
    <script type="text/javascript">
        // Function to update sales data
        function updateSalesData() {
            // Replace these sample values with actual data retrieved from the server
            var totalSales = 5000;
            var highestSalesMonth = 'March';

            // Update the text elements with the calculated data
            document.getElementById('totalSales').textContent = totalSales;
            document.getElementById('highestSalesMonth').textContent = highestSalesMonth;
        }

        // Call the function to update sales data initially
        updateSalesData();

        // Function to limit date range based on selected year
        function limitDateRange() {
            var selectedYear = document.getElementById('<%= yearDropdown.ClientID %>').value;
            var startDatePicker = document.getElementById('<%= startDatePicker.ClientID %>');
            var endDatePicker = document.getElementById('<%= endDatePicker.ClientID %>');

            // Set the min and max attributes for the date pickers
            startDatePicker.min = selectedYear + '-01';
            startDatePicker.max = selectedYear + '-12';
            endDatePicker.min = selectedYear + '-01';
            endDatePicker.max = selectedYear + '-12';
        }

        // Call the function to limit date range initially
        limitDateRange();

        // Add event listener to the year dropdown to update date range
        document.getElementById('<%= yearDropdown.ClientID %>').addEventListener('change', limitDateRange);

        // Chart initialization
        var ctx = document.getElementById('pieChart').getContext('2d');
        var myPieChart;

        function initializePieChart(data) {
            if (myPieChart) {
                myPieChart.destroy(); // Destroy existing chart if it exists
            }

            myPieChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: data.labels, // Use labels from the data object
                    datasets: [{
                        data: data.values, // Use values from the data object
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(255, 206, 86, 0.7)',
                            'rgba(75, 192, 192, 0.7)',
                            'rgba(153, 102, 255, 0.7)',
                            'rgba(255, 159, 64, 0.7)',
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(255, 206, 86, 0.7)',
                            'rgba(75, 192, 192, 0.7)',
                            'rgba(153, 102, 255, 0.7)',
                            'rgba(255, 159, 64, 0.7)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: false
                }
            });
        }

        function getSalesData(selectedYear, startDate, endDate) {
            $.ajax({
                type: "POST",
                url: "salesReport.aspx/GetSalesData",
                data: JSON.stringify({ selectedYear: selectedYear, startDate: startDate, endDate: endDate }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var salesData = response.d;

                    // Update the pie chart with the new data
                    updatePieChart(salesData);
                },
                error: function (response) {
                    console.log("Error retrieving sales data: " + response.responseText);
                }
            });
        }

        function updatePieChart(salesData) {
            // Update the pie chart with the new sales data
            var ctx = document.getElementById('pieChart').getContext('2d');
            var myPieChart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
                    datasets: [{
                        data: salesData, // Use the sales data retrieved from the server
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(255, 206, 86, 0.7)',
                            'rgba(75, 192, 192, 0.7)',
                            'rgba(153, 102, 255, 0.7)',
                            'rgba(255, 159, 64, 0.7)',
                            'rgba(255, 99, 132, 0.7)',
                            'rgba(54, 162, 235, 0.7)',
                            'rgba(255, 206, 86, 0.7)',
                            'rgba(75, 192, 192, 0.7)',
                            'rgba(153, 102, 255, 0.7)',
                            'rgba(255, 159, 64, 0.7)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: false
                }
            });
        }

    </script>--%>

</asp:Content>
