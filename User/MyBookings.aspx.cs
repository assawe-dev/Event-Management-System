using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;

public partial class User_MyBookings : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["EventDb"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.Identity.IsAuthenticated)
        {
            Response.Redirect("../Login.aspx");
            return;
        }

        string fullName = Session["FullName"] as string;
        if (string.IsNullOrEmpty(fullName))
        {
            Response.Redirect("../Login.aspx");
            return;
        }

        litUsernameNav.Text = fullName;

        if (!IsPostBack)
        {
            LoadBookings();
        }
    }

    private void LoadBookings()
    {
        int userId = Convert.ToInt32(Session["UserID"]);

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = @"SELECT b.BookingID, b.BookingDate, e.EventName, e.Location, e.EventDate
                            FROM Bookings b
                            JOIN Events e ON b.EventID = e.EventID
                            WHERE b.UserID = @UserID
                            ORDER BY b.BookingDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvBookings.DataSource = dt;
                    gvBookings.DataBind();
                }
            }
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Session.Abandon();
        Response.Redirect("../Login.aspx");
    }
}
