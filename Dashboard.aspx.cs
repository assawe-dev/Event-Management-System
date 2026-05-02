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
        string fullName = Session["FullName"] as string;

        // If session is lost but user is authenticated via FormsAuth
        if (string.IsNullOrEmpty(fullName))
        {
            SetUserSession(username);
            fullName = Session["FullName"] as string;
        }

        litUsername.Text = fullName;
        litUsernameWelcome.Text = fullName;

        string role = Session["Role"] as string;

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

    private void SetUserSession(string username)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT UserID, FullName, Role FROM Users WHERE Username = @Username";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        Session["UserID"] = Convert.ToInt32(reader["UserID"]);
                        Session["FullName"] = reader["FullName"].ToString();
                        Session["Role"] = reader["Role"].ToString();
                    }
                }
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

            // Role-based Bookings Statistics
            string role = Session["Role"] as string;
            if (role == "Admin")
            {
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Bookings", conn))
                {
                    litTotalUsers.Text = cmd.ExecuteScalar().ToString();
                }
                litBookingsLabel.Text = "Total Bookings";
                litBookingScope.Text = "System-wide";
            }
            else
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Bookings WHERE UserID = @UserID", conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    litTotalUsers.Text = cmd.ExecuteScalar().ToString();
                }
                litBookingsLabel.Text = "My Bookings";
                litBookingScope.Text = "Personal";
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
