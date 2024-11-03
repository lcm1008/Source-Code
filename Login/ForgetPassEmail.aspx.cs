using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Data;


namespace ConcertTicketingSystem.Login
{
    public partial class ForgetPassEmail : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string email = inputEmail.Text;

            if (validateEmail(email))
            {
                // Retrieve the user ID from the database based on the email address
                string id = GetUserIdByEmail(email);

                if (!string.IsNullOrEmpty(id))
                {
                    // Generate a password reset token
                    string resetToken = Guid.NewGuid().ToString();

                    // Store the reset token and email address in the database
                    StoreResetTokenInDatabase(id, resetToken);

                    // Compose the email message with only the token in the link
                    string resetLink = "http://localhost:55894/Project/Login/ForgetPass?token=" + resetToken;
                    string emailBody = $"Dear user,\n\nYou have requested to reset your password. Please click on the following link to reset your password:\n\n{resetLink}\n\nIf you did not request this, please ignore this email.\n\nRegards,\nYour Website Team";

                    // Send the email
                    SendResetPasswordEmail(email, emailBody);

                    // Inform the user to check their email for instructions
                    lblMessageSuccess.Text = "Please check your email for password reset instructions.";
                    inputEmail.ReadOnly = true;
                    resetBtn.Visible = false;
                }
                else
                {
                    lblMessage.ForeColor = Color.Red;
                    lblMessage.Text = "There is problem retreiving the id";
                }

            }
            else
            {
                lblMessage.ForeColor = Color.Red;
                lblMessage.Text = "Invalid email address. Please try again";
            }
        }

        private string GetUserIdByEmail(string email)
        {
            string userId = null;
            string query = "SELECT cus_id FROM Customer WHERE cus_email = @Email";

            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        userId = reader["cus_id"].ToString();
                    }
                    reader.Close();
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error: " + ex.Message);
                // Log the error or handle it appropriately
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                // Log the error or handle it appropriately
            }

            return userId;
        }

        private void StoreResetTokenInDatabase(string id, string resetToken)
        {
            try
            {
                Guid uuid = Guid.NewGuid();

                // Store the reset token and email address in the database
                string query = "INSERT INTO ForgetPassword (id, cus_id, token, createdDate, expiredDate) VALUES (@id, @cusId, @ResetToken, GETDATE(), DATEADD(day, 1, GETDATE()))";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", uuid);
                    cmd.Parameters.AddWithValue("@cusId", id);
                    cmd.Parameters.AddWithValue("@ResetToken", resetToken); // Corrected parameter name
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error: " + ex.Message);
                // Log the error or handle it appropriately
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                // Log the error or handle it appropriately
            }
        }



        private void SendResetPasswordEmail(string email, string body)
        {
            // Compose and send the email
            MailMessage mailMessage = new MailMessage();
            mailMessage.From = new MailAddress("hello@example.com");
            mailMessage.To.Add(email);
            mailMessage.Subject = "Password Reset Instructions";
            mailMessage.Body = body;
            mailMessage.IsBodyHtml = false;

            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com");
            smtpClient.Port = 587;
            smtpClient.Credentials = new NetworkCredential("chatbuddyenterprise@gmail.com", "irgatzjovndbcvru");
            smtpClient.EnableSsl = true;

            smtpClient.Send(mailMessage);
        }


        private bool validateEmail(string email)
        {


            string query = "SELECT COUNT(*) FROM Customer WHERE cus_email = @EnteredEmail";
            int count = 0;

            using (con)
            {
                using (SqlCommand command = new SqlCommand(query, con))
                {
                    command.Parameters.AddWithValue("@EnteredEmail", email);

                    try
                    {
                        con.Open();
                        count = (int)command.ExecuteScalar();
                    }
                    catch (Exception ex)
                    {
                        // Handle the exception (log, display error message, etc.)
                        Console.WriteLine("Error: " + ex.Message);
                    }
                }
            }

            // If count is greater than 0, the email exists in the database
            return count > 0;
        }


    }
}