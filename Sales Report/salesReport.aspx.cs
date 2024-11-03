using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace ConcertTicketingSystem.Project.Admin
{
    public partial class salesReport : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Call a method to retrieve data from the database and bind it to the chart
                BindChart();
                //UpdateSalesInfo();
                
                
            }
        }

        private void BindChart()
        {
            // Get total sales for each year from the database
            Dictionary<int, decimal> salesData = GetTotalSalesByYear();

            // Convert dictionary to JSON format
            string salesJson = Newtonsoft.Json.JsonConvert.SerializeObject(salesData);

            // Register a script to initialize the chart with the sales data
            string script = $"initializePieChart({salesJson});";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "InitChart", script, true);
        }

        public Dictionary<int, decimal> GetTotalSalesByYear()
        {
            Dictionary<int, decimal> salesData = new Dictionary<int, decimal>();

            using (con)
            {
                string query = @"
            SELECT YEAR(p.payment_date) AS Year, SUM(c.total_price) AS TotalSales
            FROM Payment p
            JOIN Cart c ON p.payment_id = c.payment_id AND c.status = 'paid'
            GROUP BY YEAR(p.payment_date)";

                using (SqlCommand command = new SqlCommand(query, con))
                {
                    try
                    {
                        con.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                int year = Convert.ToInt32(reader["Year"]);
                                decimal totalSales = Convert.ToDecimal(reader["TotalSales"]);
                                salesData.Add(year, totalSales);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions
                        Console.WriteLine("Error retrieving total sales data: " + ex.Message);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                        {
                            con.Close();
                        }
                    }

                }
            }

            return salesData;
        }


        private void UpdateSalesInfo()
        {
            // Get total sales for each year and month with the highest sales
            Dictionary<int, decimal> salesData = GetTotalSalesByYear();

            //string highestMonth = GetMonthWithHighestSales(salesData);

            // Calculate total sales
            decimal totalSales = salesData.Sum(x => x.Value);

            // Update labels
            //totalSalesLabel.Text = totalSales.ToString(); // Display total sales in currency format
            //highestSalesLabel.Text = highestMonth;
        }

        private string GetMonthWithHighestSales(Dictionary<int, decimal> salesData)
        {
            string highestMonth = string.Empty;
            decimal highestSales = decimal.MinValue;

            foreach (var entry in salesData)
            {
                // Check if the current sales are higher than the previous highest sales
                if (entry.Value > highestSales)
                {
                    highestSales = entry.Value;
                    highestMonth = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(entry.Key);
                }
            }

            return highestMonth;
        }

    }
}