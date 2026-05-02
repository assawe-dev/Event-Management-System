using System;
using System.Web;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;

public partial class Dashboard : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["EventDb"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.Identity.IsAuthenticated)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        string username = User.Identity.Name;
        litUsername.Text = username;
        litUsernameWelcome.Text = username;

        string role = Session["Role"] as string;

        // If session is lost but user is authenticated via FormsAuth
        if (string.IsNullOrEmpty(role))
        {
            role = GetUserRole(username);
            Session["Role"] = role;
        }

        if (role == "Admin")
        {
            phAdminMenu.Visible = true;
            phAdminCard.Visible = true;
        }
        else if (role == "User" || role == "Employee")
        {
            phUserMenu.Visible = true;
            phUserCard.Visible = true;
        }

        if (!IsPostBack)
        {
            LoadStatistics();
        }
    }

    private string GetUserRole(string username)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT Role FROM Users WHERE Username = @Username";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                conn.Open();
                object result = cmd.ExecuteScalar();
                return result != null ? result.ToString() : "";
            }
        }
    }

    private void LoadStatistics()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();

            // Total Events
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Events", conn))
            {
                litTotalEvents.Text = cmd.ExecuteScalar().ToString();
            }

            // Total Users
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users", conn))
            {
                litTotalUsers.Text = cmd.ExecuteScalar().ToString();
            }

            // Total Capacity
            using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(Capacity), 0) FROM Events", conn))
            {
                litTotalCapacity.Text = cmd.ExecuteScalar().ToString();
            }
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Session.Abandon();
        Response.Redirect("Login.aspx");
    }
}
