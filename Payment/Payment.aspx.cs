using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;

namespace ConcertTicketingSystem.Payment
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get current month and year
                int currentMonth = DateTime.Now.Month;
                int currentYear = DateTime.Now.Year;

                // Populate month dropdown
                for (int i = currentMonth; i <= 12; i++)
                {
                    string month = i.ToString().PadLeft(2, '0'); // Add leading zero for single-digit months
                    monthDropdown.Items.Add(new ListItem(month, month));
                }

                // Populate year dropdown
                for (int i = currentYear; i <= currentYear + 10; i++) // You can adjust the range of years here
                {
                    yearDropdown.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
            }
        }

        // reCAPTCHA secret key
        private const string RecaptchaSecretKey = "6LfUC6UpAAAAACfv5wtiDNtSb3oEiRpuEgt5h9Lj";

        protected async void conPay_Click(object sender, EventArgs e)
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
            bool isVerified = await VerifyRecaptcha(userResponse);

            // Set the session variable to indicate that reCAPTCHA verification has been attempted
            Session["RecaptchaAttempted"] = true;

            if (isVerified)
            {
                // Reset the session variable as the verification is successful
                Session["RecaptchaAttempted"] = false;

                // Display a custom notification alert to indicate that the website is connecting to the merchant
                Response.Write("<script>alert('Verifying your payment with merchant, check your inbox for transaction details.');</script>");

                // Redirect to the payment success page after a delay (e.g., 3 seconds)
                Response.Write("<script>setTimeout(function() { window.location.href = '../Payment/PaySuccess.aspx'; }, 5);</script>");
            }
            else
            {
                // Reset the session variable as the verification failed
                Session["RecaptchaAttempted"] = false;

                // Display an error message to the user
                // indicating that they need to complete the reCAPTCHA challenge.
                // For example, display an error message on the page.
                // Or redirect the user to a different page indicating the failure.

                Response.Write("<script>alert('reCAPTCHA verification failed. Please try again.');</script>");
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

    }
}