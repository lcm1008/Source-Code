using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Text;

namespace ConcertTicketingSystem.Register
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void register_Click(object sender, EventArgs e)
        {

            try
            {

                string user_name = name.Text;
                string user_dob = dob.Text;
                string user_no = contact.Text;
                string user_email = email.Text;
                string gender = DropDownList1.SelectedItem.ToString();
                string user_pass = pass.Text;
                string id = GenerateUniqueCustomerID(GetAllCustomerIDs());

                var hashedPasswordAndSalt = HashPassword(user_pass);
                string hashedPassword = hashedPasswordAndSalt.Item1;
                string salt = hashedPasswordAndSalt.Item2;

                conn.Open();
                string insert = "INSERT INTO Customer (cus_id, cus_name, cus_gender, cus_tel, cus_dob, cus_email, cus_password, cus_image, salt) VALUES (@Cid, @Cname, @Cgen, @Ctel, @Cdob, @Cemail, @Cpass, @Cimg, @salt)";

                SqlCommand cmd = new SqlCommand(insert, conn);


                cmd.Parameters.AddWithValue("@Cid", id);
                cmd.Parameters.AddWithValue("@Cname", user_name);
                cmd.Parameters.AddWithValue("@Cgen", gender);
                cmd.Parameters.AddWithValue("@Cdob", user_dob);
                cmd.Parameters.AddWithValue("@Ctel", user_no);
                cmd.Parameters.AddWithValue("@Cemail", user_email);
                cmd.Parameters.AddWithValue("@Cpass", hashedPassword);
                cmd.Parameters.AddWithValue("@Cimg", DBNull.Value);
                cmd.Parameters.AddWithValue("@salt", salt);

                cmd.ExecuteNonQuery();
                conn.Close();




                if (pass.Text == cpass.Text)
                {
                    lblMessage.CssClass = "alert alert-success";
                    cardd.Style["display"] = "none";
                    lblMessage.Text = "Account has been registered successful. Click here move to <a href=\"../Login/Login.aspx\" class=\"alert-link\">Login</a>.";
                }
                else
                {
                    lblMessage.CssClass = "alert alert-danger";
                    lblMessage.Text = "Please fill in all the info in the correct format.";
                    ScriptManager.RegisterStartupScript(this, GetType(), "HideLabel", "setTimeout(function() { document.getElementById('lblMessage').style.display = 'none'; }, 2500);", true);
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                //Response.Redirect("/Project/Admin/addUser.aspx?id=" + id);

            }
        }

        // Method to retrieve all customer IDs from the database
        public List<string> GetAllCustomerIDs()
        {
            List<string> customerIDs = new List<string>();

                try
                {
                conn.Open();
                // SQL query to select all customer IDs
                string query = "SELECT cus_id FROM Customer";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        


                        SqlDataReader reader = cmd.ExecuteReader();

                        // Loop through the result set and add each customer ID to the list
                        while (reader.Read())
                        {
                            string customerID = reader["cus_id"].ToString();
                            customerIDs.Add(customerID);
                        }

                        reader.Close();
                        
                    }
                }catch(Exception ex)
                {
                    Console.WriteLine("Exception occurred during id generate: " + ex.Message);

                }

            finally
            {
                conn.Close();
            }
            

            return customerIDs;
        }

        protected string GenerateUniqueCustomerID(List<string> existingCustomerIDs)
        {
            string newCustomerID = "";
            int counter = 1;

            // Generate a new ID until it's unique
            do
            {
                newCustomerID = "C" + counter.ToString("000");
                counter++;
            }
            while (existingCustomerIDs.Contains(newCustomerID));

            return newCustomerID;
        }


        public static Tuple<string, string> HashPassword(string password)
        {
            
            byte[] salt = GenerateSalt();

            // Combine password and salt
            byte[] combinedPassword = Encoding.UTF8.GetBytes(password);
            byte[] combinedPasswordWithSalt = new byte[combinedPassword.Length + salt.Length];
            combinedPassword.CopyTo(combinedPasswordWithSalt, 0);
            salt.CopyTo(combinedPasswordWithSalt, combinedPassword.Length);

            // Hash the password
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] hashedPassword = sha256Hash.ComputeHash(combinedPasswordWithSalt);
                string hashedPasswordString = Convert.ToBase64String(hashedPassword);
                string saltString = Convert.ToBase64String(salt);
                return Tuple.Create(hashedPasswordString, saltString);
            }
        }

        private static byte[] GenerateSalt()
        {
            // Generate a random salt
            byte[] salt = new byte[16];
            using (var rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(salt);
            }
            return salt;
        }


    }
}