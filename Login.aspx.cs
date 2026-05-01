using System;
using System.Web;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
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

        // Hardcoded users for demonstration as requested/implied by university project setup
        // In a real app, these would be in the database
        string role = "";
        bool isValid = false;

        if (username == "admin" && password == "admin123")
        {
            isValid = true;
            role = "Admin";
        }
        else if (username == "user" && password == "user123")
        {
            isValid = true;
            role = "User";
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
            Response.Redirect("Dashboard.aspx");
        }
        else
        {
            lblMessage.Text = "Invalid username or password.";
        }
    }
}
