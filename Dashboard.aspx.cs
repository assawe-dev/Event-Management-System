using System;
using System.Web;
using System.Web.Security;

public partial class Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.Identity.IsAuthenticated)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        litUsername.Text = User.Identity.Name;

        FormsIdentity id = (FormsIdentity)User.Identity;
        FormsAuthenticationTicket ticket = id.Ticket;
        string role = ticket.UserData;

        if (role == "Admin")
        {
            phAdminMenu.Visible = true;
            phAdminCard.Visible = true;
        }
        else if (role == "User")
        {
            phUserMenu.Visible = true;
            phUserCard.Visible = true;
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("Login.aspx");
    }
}
