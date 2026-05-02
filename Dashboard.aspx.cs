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
        litUsernameWelcome.Text = User.Identity.Name;

        string role = Session["Role"] as string;

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
        Session.Abandon();
        Response.Redirect("Login.aspx");
    }
}
