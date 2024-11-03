using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Xml.Linq;
using System.Drawing;
using WebGrease.Activities;
using System.Data;
using Microsoft.SqlServer.Server;



namespace ConcertTicketingSystem.Login
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        string id = "";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // reCAPTCHA secret key
        private const string RecaptchaSecretKey = "6LfUC6UpAAAAACfv5wtiDNtSb3oEiRpuEgt5h9Lj";

        protected void submit_Click(object sender, EventArgs e)
        {

            

            // Check if reCAPTCHA verification has already been attempted
            if (Session["RecaptchaAttempted"] != null && (bool)Session["RecaptchaAttempted"])
            {
                // reCAPTCHA verification has already been attempted, do not show error message again
                return;
            }

            // Get the reCAPTCHA response from the client-side
            string userResponse = Request.Form["g-recaptcha-response"];

            // Verify the reCAPTCHA response
            //bool isVerified = await VerifyRecaptcha(userResponse);

            // Set the session variable to indicate that reCAPTCHA verification has been attempted
            Session["RecaptchaAttempted"] = true;

            if (true)
            {
                // Do validation on the server
                if (checkAcc())
                {
                    // Set a session variable
                    Session["cusid"] = id;

                    //string userId = (string)Session["cusid"];
                    //bool recapha = (bool)Session["RecaptchaAttempted"];
                    //string recaphaString = recapha.ToString(); // Using ToString() method

                    //lblMessage.Text = userId;

                    
                    Response.Redirect("../HomePage/HomePage.aspx");
                    //Response.Redirect("../UserProfile/UserProfile.aspx");


                }
                else
                {
                    //Session["RecaptchaAttempted"] = false;
                    lblMessage.CssClass = "alert alert-danger";
                    lblMessage.Text = "Invalid Email OR Password.";
                    ScriptManager.RegisterStartupScript(this, GetType(), "HideLabel", "setTimeout(function() { document.getElementById('lblMessage').style.display = 'none'; }, 2500);", true);
                }
            }

            //else
            //{
            //    // Reset the session variable as the verification failed
            //    Session["RecaptchaAttempted"] = false;

            //    // Display an error message to the user
            //    // indicating that they need to complete the reCAPTCHA challenge.
            //    // For example, display an error message on the page.
            //    // Or redirect the user to a different page indicating the failure.

            //    Response.Write("<script>alert('reCAPTCHA verification failed. Please try again.');</script>");
            //}

           

        }

        private bool checkAcc()
        {
            try
            {
                con.Open();
                string query = "SELECT * FROM Customer WHERE cus_email = @Email";

                string email = inputEmail.Text;
                string password = inputPassword.Text;

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Add parameters to the command
                    cmd.Parameters.AddWithValue("@Email", email);

                    // Execute the query and retrieve the matched email address
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Email and password match found
                            string matchedEmail = reader["cus_email"].ToString();
                            id = reader["cus_id"].ToString();
                            string salt = reader["salt"].ToString(); // Read salt as string
                            string hashedPassword = reader["cus_password"].ToString(); // Read hashed password as string

                            if (AuthenticateUser(password, hashedPassword, salt))
                            {



                                return true;
                            }
                        }
                    }
                }

                // No matching email or password found
                return false;
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error: " + ex.Message);
                // Log the error or display it to the user
                return false;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                // Log the error or display it to the user
                return false;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }


        // Verify reCAPTCHA response
        private async Task<bool> VerifyRecaptcha(string response)
        {
            using (var httpClient = new HttpClient())
            {
                var parameters = new FormUrlEncodedContent(new[]
                {
                new KeyValuePair<string, string>("secret", RecaptchaSecretKey),
                new KeyValuePair<string, string>("response", response)
            });

                var responseMessage = await httpClient.PostAsync("https://www.google.com/recaptcha/api/siteverify", parameters);
                var responseContent = await responseMessage.Content.ReadAsStringAsync();

                // Parse the JSON response
                dynamic jsonResponse = Newtonsoft.Json.JsonConvert.DeserializeObject(responseContent);

                // Check if the verification was successful
                return jsonResponse.success == "true";
            }
        }

        public bool AuthenticateUser(string userEnteredPassword, string storedHashedPassword, string storedSalt)
        {
            // Convert stored hashed password and salt from Base64 strings to byte arrays
            byte[] storedHashedPasswordBytes = Convert.FromBase64String(storedHashedPassword);
            byte[] storedSaltBytes = Convert.FromBase64String(storedSalt);

            // Combine user-entered password with stored salt
            byte[] combinedPasswordWithSalt = CombinePasswordAndSalt(userEnteredPassword, storedSaltBytes);

            // Hash the combined password and salt
            byte[] hashedPassword = HashPassword(combinedPasswordWithSalt);

            // Convert hashed password to Base64 string for comparison
            string hashedPasswordString = Convert.ToBase64String(hashedPassword);

            // Compare the hashed password with the stored hashed password
            return hashedPasswordString.Equals(storedHashedPassword);
        }

        // Method to combine password and salt
        private byte[] CombinePasswordAndSalt(string password, byte[] salt)
        {
            byte[] combinedPassword = Encoding.UTF8.GetBytes(password);
            byte[] combinedPasswordWithSalt = new byte[combinedPassword.Length + salt.Length];

            // Copy password bytes
            Array.Copy(combinedPassword, combinedPasswordWithSalt, combinedPassword.Length);

            // Copy salt bytes
            Array.Copy(salt, 0, combinedPasswordWithSalt, combinedPassword.Length, salt.Length);

            return combinedPasswordWithSalt;
        }

        // Method to hash password
        private byte[] HashPassword(byte[] combinedPasswordWithSalt)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                return sha256Hash.ComputeHash(combinedPasswordWithSalt);
            }
        }

    }
}