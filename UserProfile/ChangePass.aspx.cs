using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ConcertTicketingSystem.ChangePass
{
    public partial class ChangePass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["cusid"] = "C002";
        }

        protected void updatePass_Click(object sender, EventArgs e)
        {
           

            string cusId = (string)Session["cusid"];


            if (Page.IsValid)
            {
                // Update the database with the new password

                // Retrieve the salt from the Customer table
                string salt = GetSaltFromDatabase(cusId);

                if (cusId != null)
                {
                    if (!string.IsNullOrEmpty(salt))
                    {
                        if (IsPasswordMatch(currentPass.Text,getPassword(cusId), salt))
                        {
                            // Validate the password and perform other checks
                            if (!IsPasswordMatch(inputNewPassword.Text, getPassword(cusId), salt))
                            {

                                // Hash the new password
                                string hashedPassword = HashPassword(inputNewPassword.Text, salt);

                                // Update the password in the database
                                if (UpdatePassword(cusId, hashedPassword))
                                {
                                    /// Code to update the database goes here

                                    lblMessage.CssClass = "";
                                    lblMessage.Text = "Your password has been <b>successfully changed</b>. Please use your new password for next login session.<br/><a href='../HomePage/Homepage.aspx'>Click Here</a> back to hompage";
                                    currentPass.Visible = false;
                                    inputNewPassword.Enabled = false;
                                    inputNewPassword.Style["display"] = "none";


                                    inputNewPassword.Visible = false;
                                    inputNewPassword.Enabled = false;
                                    inputNewPassword.Style["display"] = "none";

                                    confirmPass.Visible = false;
                                    confirmPass.Enabled = false;
                                    confirmPass.Style["display"] = "none";

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
                            lblMessage.Text = "Invalid current password.";
                        }
                    }
                    else
                    {
                        lblMessage.CssClass = "alert alert-danger";
                        lblMessage.Text = "Invalid password. Please enter a valid password.";
                    }
                }
                else
                {
                    Response.Redirect("../HomePage/HomePage.aspx");
                }


                //// Notify the user that the password has been changed
                //ScriptManager.RegisterStartupScript(this, GetType(), "changePasswordAlert", "alert('Your password has been successfully changed. Please use your new password for next login session');", true);

                //// Redirect the user to the homepage or another page after a short delay
                //ScriptManager.RegisterStartupScript(this, GetType(), "redirectScript", "setTimeout(function() { window.location.href = '../HomePage/HomePage.aspx'; }, 5);", true);
            }
        }

        private string getPassword(string id)
        {
            string password = null;
            string query = "SELECT cus_password FROM Customer WHERE cus_id = @Id";

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.Parameters.AddWithValue("@Id", id);
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

        private string HashPassword(string inputPassword, string storedSalt)
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

        private string GetSaltFromDatabase(string id)
        {
            string salt = null;
            string query = "SELECT salt FROM Customer WHERE cus_id = @Id";

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    cmd.Parameters.AddWithValue("@Id", id);
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

        private bool UpdatePassword(string id, string hashedPassword)
        {
            try
            {
                string query = "UPDATE Customer SET cus_password = @Password WHERE cus_id = @Id";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);
                    cmd.Parameters.AddWithValue("@Id", id);
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


    }
}