using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Admin_ManageEvents : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["EventDb"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.Identity.IsAuthenticated || Session["Role"] as string != "Admin")
        {
            Response.Redirect("../Login.aspx");
            return;
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
            query += " ORDER BY EventDate DESC";

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
                    gvEvents.DataSource = dt;
                    gvEvents.DataBind();
                }
            }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadEvents(txtSearch.Text.Trim());
    }

    protected void btnClearSearch_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        LoadEvents();
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Session.Abandon();
        Response.Redirect("../Login.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ResetForm();
    }

    private void ResetForm()
    {
        hfEventId.Value = "";
        txtEventName.Text = "";
        txtEventDate.Text = "";
        txtLocation.Text = "";
        txtCapacity.Text = "";
        txtAvailableSeats.Text = "";
        litFormTitle.Text = "Add New Event";
        btnSave.Text = "Save";
        pnlMessage.Visible = false;
    }

    private void ShowMessage(string message, string cssClass)
    {
        lblMessage.Text = message;
        pnlMessage.CssClass = "alert alert-dismissible fade show " + cssClass;
        pnlMessage.Visible = true;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string name = txtEventName.Text.Trim();
        string date = txtEventDate.Text.Trim();
        string location = txtLocation.Text.Trim();
        int capacity = int.Parse(txtCapacity.Text.Trim());
        int available = int.Parse(txtAvailableSeats.Text.Trim());
        string id = hfEventId.Value;

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query;
                if (string.IsNullOrEmpty(id))
                {
                    query = "INSERT INTO Events (EventName, EventDate, Location, Capacity, AvailableSeats) VALUES (@name, @date, @location, @capacity, @available)";
                }
                else
                {
                    query = "UPDATE Events SET EventName=@name, EventDate=@date, Location=@location, Capacity=@capacity, AvailableSeats=@available WHERE EventID=@id";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@date", date);
                    cmd.Parameters.AddWithValue("@location", location);
                    cmd.Parameters.AddWithValue("@capacity", capacity);
                    cmd.Parameters.AddWithValue("@available", available);
                    if (!string.IsNullOrEmpty(id))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                    }
                    cmd.ExecuteNonQuery();
                }
            }

            string msg = string.IsNullOrEmpty(id) ? "Event added successfully!" : "Event updated!";
            ResetForm();
            LoadEvents();
            ShowMessage(msg, "alert-success");
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message, "alert-danger");
        }
    }

    protected void gvEvents_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditEvent")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM Events WHERE EventID = @id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            hfEventId.Value = dr["EventID"].ToString();
                            txtEventName.Text = dr["EventName"].ToString();
                            txtEventDate.Text = Convert.ToDateTime(dr["EventDate"]).ToString("yyyy-MM-dd");
                            txtLocation.Text = dr["Location"].ToString();
                            txtCapacity.Text = dr["Capacity"].ToString();
                            txtAvailableSeats.Text = dr["AvailableSeats"].ToString();
                            litFormTitle.Text = "Edit Event";
                            btnSave.Text = "Update";
                            pnlMessage.Visible = false;
                        }
                    }
                }
            }
        }
        else if (e.CommandName == "DeleteEvent")
        {
            try
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "DELETE FROM Events WHERE EventID = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadEvents();
                ShowMessage("Event deleted!", "alert-success");
            }
            catch (Exception ex)
            {
                ShowMessage("Error deleting event: " + ex.Message, "alert-danger");
            }
        }
    }
}
