using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Admin_ViewBookings : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["EventDb"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.Identity.IsAuthenticated || Session["Role"] as string != "Admin")
        {
            Response.Redirect("../Login.aspx");
            return;
        }

        litUsernameNav.Text = Session["FullName"] != null ? Session["FullName"].ToString() : User.Identity.Name;

        if (!IsPostBack)
        {
            LoadEvents();
            LoadBookings();
            UpdateTotalCount();
        }
    }

    private void LoadEvents()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT EventID, EventName FROM Events ORDER BY EventName ASC";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                conn.Open();
                ddlEvents.DataSource = cmd.ExecuteReader();
                ddlEvents.DataTextField = "EventName";
                ddlEvents.DataValueField = "EventID";
                ddlEvents.DataBind();
            }
        }
        ddlEvents.Items.Insert(0, new ListItem("All Events", "0"));
    }

    private void LoadBookings()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = @"SELECT B.BookingID, E.EventName, U.FullName, B.BookingDate
                            FROM Bookings B
                            JOIN Events E ON B.EventID = E.EventID
                            JOIN Users U ON B.UserID = U.UserID
                            WHERE 1=1";

            if (ddlEvents.SelectedValue != "0")
            {
                query += " AND E.EventID = @EventID";
            }

            if (!string.IsNullOrEmpty(txtUserSearch.Text.Trim()))
            {
                query += " AND U.FullName LIKE @FullName";
            }

            query += " ORDER BY B.BookingDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (ddlEvents.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue("@EventID", ddlEvents.SelectedValue);
                }

                if (!string.IsNullOrEmpty(txtUserSearch.Text.Trim()))
                {
                    cmd.Parameters.AddWithValue("@FullName", "%" + txtUserSearch.Text.Trim() + "%");
                }

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

    private void UpdateTotalCount()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT COUNT(*) FROM Bookings";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                conn.Open();
                lblTotalBookings.Text = cmd.ExecuteScalar().ToString();
            }
        }
    }

    protected void FilterChanged(object sender, EventArgs e)
    {
        LoadBookings();
    }

    protected void btnClearFilters_Click(object sender, EventArgs e)
    {
        ddlEvents.SelectedIndex = 0;
        txtUserSearch.Text = "";
        LoadBookings();
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Session.Abandon();
        Response.Redirect("../Login.aspx");
    }
}
