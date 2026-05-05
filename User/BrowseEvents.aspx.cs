using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;

public partial class User_BrowseEvents : System.Web.UI.Page
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
            LoadEvents();
        }
    }

    private void LoadEvents(string search = "")
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT * FROM Events";
            if (!string.IsNullOrEmpty(search))
            {
                query += " WHERE EventName LIKE @search OR Location LIKE @search";
            }
            query += " ORDER BY EventDate ASC";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (!string.IsNullOrEmpty(search))
                {
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");
                }

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptEvents.DataSource = dt;
                    rptEvents.DataBind();
                }
            }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadEvents(txtSearch.Text.Trim());
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        LoadEvents();
    }

    protected void rptEvents_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Book")
        {
            int eventId = Convert.ToInt32(e.CommandArgument);
            int userId = Convert.ToInt32(Session["UserID"]);

            try
            {
                if (BookEvent(userId, eventId))
                {
                    string script = "alert('Ticket Booked Successfully!');";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                    LoadEvents(txtSearch.Text.Trim());
                }
            }
            catch (Exception ex)
            {
                string script = "alert('" + ex.Message.Replace("'", "\\'") + "');";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            }
        }
    }

    private bool BookEvent(int userId, int eventId)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            using (SqlTransaction trans = conn.BeginTransaction())
            {
                try
                {
                    // Check availability first
                    string checkQuery = "SELECT AvailableSeats FROM Events WHERE EventID = @EventID";
                    int availableSeats = 0;
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn, trans))
                    {
                        checkCmd.Parameters.AddWithValue("@EventID", eventId);
                        object result = checkCmd.ExecuteScalar();
                        if (result != null)
                        {
                            availableSeats = Convert.ToInt32(result);
                        }
                    }

                    if (availableSeats <= 0)
                    {
                        throw new Exception("Sorry, this event is already sold out!");
                    }

                    // Insert Booking
                    string insertQuery = "INSERT INTO Bookings (UserID, EventID, BookingDate) VALUES (@UserID, @EventID, @BookingDate)";
                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn, trans))
                    {
                        insertCmd.Parameters.AddWithValue("@UserID", userId);
                        insertCmd.Parameters.AddWithValue("@EventID", eventId);
                        insertCmd.Parameters.AddWithValue("@BookingDate", DateTime.Now);
                        insertCmd.ExecuteNonQuery();
                    }

                    // Decrement AvailableSeats
                    string updateQuery = "UPDATE Events SET AvailableSeats = AvailableSeats - 1 WHERE EventID = @EventID";
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
                    throw;
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
