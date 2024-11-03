using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ConcertTicketingSystem.Login
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if token is present in the URL
                if (!string.IsNullOrEmpty(Request.QueryString["token"]))
                {
                    string resetToken = Request.QueryString["token"];

                    // Query the database to find the email address associated with the token
                    string email = GetEmailFromToken(resetToken);

                    if (!string.IsNullOrEmpty(email))
                    {
                        // Display the email address and allow password reset
                        inputEmail.Text = email;
                        // Show password reset controls (e.g., textboxes for new password)
                    }
                    else
                    {
                        lblMessage.CssClass = "alert alert-danger";

                        // Token not found or expired, display appropriate message
                        lblMessage.Text = "Invalid or expired token.";
                    }
                }
                else
                {
                    lblMessage.CssClass = "alert alert-danger";

                    // Token not provided in the URL, display error message
                    lblMessage.Text = "Token not provided.";

                    inputEmail.Visible = false;
                    RequiredFieldValidator1.Visible = false;
                    EmailFormatValidator.Visible = false;
                    inputPassword.Visible = false;
                    RequiredFieldValidator3.Visible = false;
                    RegularExpressionValidator1.Visible = false;
                    confirmPass.Visible = false;
                    RequiredFieldValidator4.Visible = false;
                    ConfirmPasswordValidator.Visible = false;
                    updatePass.Visible = false;
                }
            }
        }

        protected void ShowPasswordCheckbox_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void updatePass_Click(object sender, EventArgs e)
        {
            string resetToken = Request.QueryString["token"];
            string email = GetEmailFromToken(resetToken);

            // Retrieve the salt from the Customer table
            string salt = GetSaltFromDatabase(email);

            if (!string.IsNullOrEmpty(salt))
            {
                // Validate the password and perform other checks
                if (!IsPasswordMatch(inputPassword.Text, getPassword(email), salt))
                {

                    // Hash the new password
                    string hashedPassword = HashPassword(inputPassword.Text, salt);

                    // Update the password in the database
                    if (UpdatePassword(email, hashedPassword))
                    {
                        // Password updated successfully
                        lblMessage.Text = "Password has been updated. Please proceed to <a href='login.aspx'>Login Page</a>";
                        inputEmail.ReadOnly = true;
                        inputPassword.Visible = false;
                        confirmPass.Visible = false;
                        updatePass.Visible = false;
                    }
                    else
                    {
                        lblMessage.CssClass = "alert alert-danger";
                        lblMessage.Text = "Failed to update password. Please try again later.";
                    }
                }
                else
                {
                    lblMessage.CssClass = "alert alert-danger";
                    lblMessage.Text = "Please use a new Password.";
                }
            }
            else
            {
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Text = "Invalid password. Please enter a valid password.";
            }
        }

        private string getPassword(string email)
        {
            string password = null;
            string query = "SELECT cus_password FROM Customer WHERE cus_email = @Email";

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.Parameters.AddWithValue("@Email", email);
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        password = result.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error retrieving salt from database: " + ex.Message);
                // Log the error or handle it appropriately
            }

            return password;
        }

        private bool IsPasswordMatch(string inputPassword, string storedHashedPassword, string storedSalt)
        {
            // Convert stored hashed password and salt from Base64 strings to byte arrays
            byte[] storedHashedPasswordBytes = Convert.FromBase64String(storedHashedPassword);
            byte[] storedSaltBytes = Convert.FromBase64String(storedSalt);

            // Combine user-entered password with stored salt
            byte[] combinedPasswordWithSalt = CombinePasswordAndSalt(inputPassword, storedSaltBytes);

            // Hash the combined password and salt
            byte[] hashedPassword = HashPassword(combinedPasswordWithSalt);

            // Convert hashed password to Base64 string for comparison
            string hashedPasswordString = Convert.ToBase64String(hashedPassword);

            // Compare the hashed password with the stored hashed password
            return hashedPasswordString.Equals(storedHashedPassword);
        }

        private byte[] HashPassword(byte[] combinedPasswordWithSalt)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                return sha256Hash.ComputeHash(combinedPasswordWithSalt);
            }
        }

        private string HashPassword(string inputPassword,  string storedSalt)
        {

            byte[] storedSaltBytes = Convert.FromBase64String(storedSalt);

            // Combine user-entered password with stored salt
            byte[] combinedPasswordWithSalt = CombinePasswordAndSalt(inputPassword, storedSaltBytes);

            // Hash the combined password and salt
            byte[] hashedPassword = HashPassword(combinedPasswordWithSalt);

            // Convert hashed password to Base64 string for comparison
            string hashedPasswordString = Convert.ToBase64String(hashedPassword);

            // Compare the hashed password with the stored hashed password
            return hashedPasswordString;
        }


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

        private string GetSaltFromDatabase(string email)
        {
            string salt = null;
            string query = "SELECT salt FROM Customer WHERE cus_email = @Email";

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.Parameters.AddWithValue("@Email", email);
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        salt = result.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error retrieving salt from database: " + ex.Message);
                // Log the error or handle it appropriately
            }

            return salt;
        }

        private bool UpdatePassword(string email, string hashedPassword)
        {
            try
            {
                string query = "UPDATE Customer SET cus_password = @Password WHERE cus_email = @Email";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);
                    cmd.Parameters.AddWithValue("@Email", email);
                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error updating password: " + ex.Message);
                return false;
            }
        }


        private string GetEmailFromToken(string resetToken)
        {
            try
            {
                string email = null;
                // Query the database to retrieve the email address associated with the token
                string query = "SELECT c.cus_email FROM Customer c INNER JOIN ForgetPassword fp ON c.cus_id = fp.cus_id WHERE fp.token = @Token";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Token", resetToken);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        email = result.ToString();
                    }
                }
                return email;
            }catch(Exception ex) {
                Console.WriteLine("Error : " + ex.Message);
                // Log the error or handle it appropriately
                return null;
            }
        }
    }
}