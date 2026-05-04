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

            if (BookEvent(userId, eventId))
            {
                string script = "alert('Ticket Booked Successfully!');";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                LoadEvents(txtSearch.Text.Trim());
            }
        }
    }

    private bool BookEvent(int userId, int eventId)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "INSERT INTO Bookings (UserID, EventID, BookingDate) VALUES (@UserID, @EventID, @BookingDate)";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@EventID", eventId);
                cmd.Parameters.AddWithValue("@BookingDate", DateTime.Now);

                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
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
