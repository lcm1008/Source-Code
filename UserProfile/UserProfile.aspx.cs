using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ConcertTicketingSystem.Project.UserProfile
{
    public partial class UserProfile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);


        protected void Page_Load(object sender, EventArgs e)
        {

            //Session["cusid"] = "C002";

            string cusId = (string)Session["cusid"];

            if (!IsPostBack)
            {


                

                // Check if the session contains the user ID
                if (cusId != null)
                {


                    // Retrieve user information from the database based on the user ID
                    string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                    string query = "SELECT * FROM Customer WHERE cus_id = @UserId";

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@UserId", cusId);

                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();

                            if (reader.Read())
                            {
                                // Assuming you have controls like labels to display the user information
                                FirstNameTextBox.Text = reader["cus_name"].ToString();
                                PhoneTextBox.Text = reader["cus_tel"].ToString();
                                EmailTextBox.Text = reader["cus_email"].ToString();

                                password.Text = reader["cus_password"].ToString();

                                object dobObject = reader["cus_dob"];
                                if (dobObject != DBNull.Value)
                                {
                                    DateTime dob = (DateTime)dobObject;
                                    birthday.Text = dob.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    birthday.Text = string.Empty; // Or set it to some default value
                                }


                                // Set the gender DropDownList
                                string gender = reader["cus_gender"].ToString();
                                if (gender == "Male")
                                {
                                    ddlGender.SelectedValue = "Male"; // Assuming "Male" is one of the values in your DropDownList
                                }
                                else if (gender == "Female")
                                {
                                    ddlGender.SelectedValue = "Female"; // Assuming "Female" is one of the values in your DropDownList
                                }
                                else
                                {
                                    // If the gender value is neither "Male" nor "Female", handle it accordingly
                                    // For example, you can set it to a default value or display an error message
                                }

                                // Check if there is an image path stored in the database
                                string imagePath = GetImagePathFromDatabase(cusId);

                                if (!string.IsNullOrEmpty(imagePath))
                                {
                                    // If there is an image path, display the image
                                    ImageControl.ImageUrl = imagePath;
                                    ImageControl.Visible = true;
                                }
                                else
                                {
                                    // If there is no image path, hide the image control
                                    ImageControl.Visible = false;
                                }


                            }
                            else
                            {
                                // Handle case where user ID is not found in the database
                                // For example, display an error message or redirect to another page
                                Response.Redirect("../Login/Login.aspx");
                            }

                            reader.Close();
                        }
                        catch (Exception ex)
                        {
                            // Handle the exception (log, display error message, etc.)
                            Console.WriteLine("Error: " + ex.Message);
                        }
                    }
                }
                else
                {
                    // Handle the case where the user ID is not found in the session
                    //FirstNameTextBox.Text = cusId + "Hi";

                    Response.Redirect("../Login/Login.aspx");
                }
            }
            else
            {
                // Check if there is an image path stored in the database
                                string imagePath = GetImagePathFromDatabase(cusId);

                                if (!string.IsNullOrEmpty(imagePath))
                                {
                                    // If there is an image path, display the image
                                    ImageControl.ImageUrl = imagePath;
                                    ImageControl.Visible = true;
                                }
                                else
                                {
                                    // If there is no image path, hide the image control
                                    ImageControl.Visible = false;
                                }

            }
        }

        private string GetImagePathFromDatabase(string customerId)
        {
            string imagePath = ""; // Initialize imagePath variable

            try
            {
                // Assuming you have a connection named "con" to your database

                // Open the database connection
                con.Open();

                // Query to retrieve the image path from the database
                string query = "SELECT cus_image FROM Customer WHERE cus_id = @CustomerId"; // Adjust this query as per your database schema

                // Create a SqlCommand object
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Set the parameter value
                    cmd.Parameters.AddWithValue("@CustomerId", customerId); // Assuming you have the customerId variable defined elsewhere

                    // Execute the query and retrieve the image path
                    imagePath = cmd.ExecuteScalar()?.ToString(); // ExecuteScalar returns the first column of the first row in the result set, or a null reference if the result set is empty
                }

                // Check if imagePath is not null or empty
                if (!string.IsNullOrEmpty(imagePath))
                {
                    // Remove the directory part of the path and keep only the relative part
                    imagePath = imagePath.Substring(imagePath.IndexOf("assets"));

                    // Replace any occurrences of "\\" with "/"
                    imagePath = imagePath.Replace("\\", "/");

                    // Prepend "~/assets/" to the relative path
                    imagePath = $"~/{imagePath}";
                }
            }
            catch (SqlException ex)
            {
                // Handle SQL exceptions
                Console.WriteLine("SQL Error: " + ex.Message);
                // You may want to log the error or handle it appropriately
            }
            catch (Exception ex)
            {
                // Handle other exceptions
                Console.WriteLine("Error: " + ex.Message);
                // You may want to log the error or handle it appropriately
            }
            finally
            {
                // Close the database connection
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }

            // Return the retrieved image path
            return imagePath;
        }





        protected void SaveChangesButton_Click(object sender, EventArgs e)
        {

        }

        protected void CountryDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("../HomePage/HomePage.aspx");
        }

        protected void DeactivateButton_Click(object sender, EventArgs e)
        {

        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {

        }

        protected void SaveChangesButton_Click1(object sender, EventArgs e)
        {

            string cusId = (string)Session["cusid"];

            // Get the updated values from the text boxes and drop-down list
            string name = FirstNameTextBox.Text;
            string phone = PhoneTextBox.Text;
            string email = EmailTextBox.Text;
            DateTime dob = DateTime.ParseExact(birthday.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture);
            string gender = ddlGender.SelectedValue;

            // Update the database with the new values
            UpdateCustomerDetails(cusId, name, phone, email, dob, gender);



            if (FileUploadControl.HasFile)
            {
                try
                {
                    string filename = Path.GetFileName(FileUploadControl.FileName);
                    string folderPath = Server.MapPath("~/assets/img/profile_pic/"); // Set the folder path where you want to save the images
                    string filePath = folderPath + filename;
                    FileUploadControl.SaveAs(filePath);

                    // Now you can store the file path in a database or use it as needed
                    string imagePath = "~/assets/img/profile_pic/" + filename;


                    // Insert the image path into the database
                    InsertImagePathIntoDatabase(cusId, filePath);

                    // Display a success message
                    lblMessage.Text = "Image uploaded successfully.";

                    // Redirect to the same page to display the updated image
                    Response.Redirect(Request.Url.AbsoluteUri); // Reload the current page


                }
                catch (Exception ex)
                {
                    // Handle the exception (e.g., display an error message)
                    lblMessage.Text = "Upload failed: " + ex.Message;
                }
            }
            //else
            //{

            //    // Display a message indicating that no file was selected
            //    lblMessage.Text = "Please select a file to upload.";
            //}

            // Display a success message as an alert box using JavaScript
            string script = "alert('Changes saved successfully!');";
            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);


  

        }

        private void UpdateCustomerDetails(string customerId, string name, string phone, string email, DateTime dob, string gender)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "UPDATE Customer SET cus_name = @Name, cus_tel = @Phone, cus_email = @Email, cus_dob = @DOB, cus_gender = @Gender WHERE cus_id = @CustomerId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@Name", name);
                command.Parameters.AddWithValue("@Phone", phone);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@DOB", dob);
                command.Parameters.AddWithValue("@Gender", gender);
                command.Parameters.AddWithValue("@CustomerId", customerId);

                try
                {
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    // Check if the update was successful
                    if (rowsAffected > 0)
                    {
                        // Update successful
                        lblSuccess.Text = "Update Successful";

                    }
                    else
                    {
                        // Update failed
                        lblError.Text = "Update Failed";

                    }
                }
                catch (Exception ex)
                {
                    // Handle the exception
                    lblMessage.Text = "Error updating customer details: " + ex.Message;
                }
            }
        }


        // Method to insert the image path into the database
        private void InsertImagePathIntoDatabase(string customerId, string imagePath)
        {
            try
            {
                // Use your SQL connection and query to insert the image path into the database
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    con.Open();
                    string query = "UPDATE Customer SET cus_image = @ImagePath WHERE cus_id = @CustomerId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@CustomerId", customerId);
                        cmd.Parameters.AddWithValue("@ImagePath", imagePath);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine("Error inserting image path into database: " + ex.Message);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Project/UserProfile/ChangePass.aspx");
        }
    }
}