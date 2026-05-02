using System;
using System.Web;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;

public partial class Login : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["EventDb"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();

        string role = "";
        bool isValid = false;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT Role FROM Users WHERE Username = @Username AND Password = @Password";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);
                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    isValid = true;
                    role = result.ToString();
                }
            }
        }

        if (isValid)
        {
            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                1,
                username,
                DateTime.Now,
                DateTime.Now.AddMinutes(30),
                false,
                role,
                FormsAuthentication.FormsCookiePath);

            string hash = FormsAuthentication.Encrypt(ticket);
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, hash);

            if (ticket.IsPersistent)
            {
                cookie.Expires = ticket.Expiration;
            }

            Response.Cookies.Add(cookie);
            Session["Role"] = role;
            Session["Username"] = username;
            Response.Redirect("Dashboard.aspx");
        }
        else
        {
            lblMessage.Text = "Invalid username or password.";
        }
    }
}
