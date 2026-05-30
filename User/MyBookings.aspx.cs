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

        string role = Session["Role"] as string;
        if (role == "Admin")
        {
            phAdminMenu.Visible = true;
        }

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
            string query = @"SELECT b.BookingID, b.EventID, b.BookingDate, e.EventName, e.Location, e.EventDate
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

    protected void gvBookings_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "CancelBooking")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int bookingId = Convert.ToInt32(gvBookings.DataKeys[index].Values["BookingID"]);
            int eventId = Convert.ToInt32(gvBookings.DataKeys[index].Values["EventID"]);

            if (CancelBooking(bookingId, eventId))
            {
                string script = "alert('Booking cancelled successfully!');";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                LoadBookings();
            }
        }
    }

    private bool CancelBooking(int bookingId, int eventId)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            using (SqlTransaction trans = conn.BeginTransaction())
            {
                try
                {
                    // Delete Booking
                    string deleteQuery = "DELETE FROM Bookings WHERE BookingID = @BookingID";
                    using (SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn, trans))
                    {
                        deleteCmd.Parameters.AddWithValue("@BookingID", bookingId);
                        deleteCmd.ExecuteNonQuery();
                    }

                    // Increment AvailableSeats
                    string updateQuery = "UPDATE Events SET AvailableSeats = AvailableSeats + 1 WHERE EventID = @EventID";
                    using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn, trans))
                    {
                        updateCmd.Parameters.AddWithValue("@EventID", eventId);
                        updateCmd.ExecuteNonQuery();
                    }

                    trans.Commit();
                    return true;
                }
                catch
                {
                    trans.Rollback();
                    return false;
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
