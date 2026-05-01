using System;
using System.Data;
using System.Data.SQLite;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Admin_ManageEvents : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["EventDb"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.Identity.IsAuthenticated)
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
        using (SQLiteConnection conn = new SQLiteConnection(connectionString))
        {
            string query = "SELECT * FROM Events";
            if (!string.IsNullOrEmpty(search))
            {
                query += " WHERE Name LIKE @search OR Location LIKE @search";
            }
            query += " ORDER BY EventDate DESC";

            using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
            {
                if (!string.IsNullOrEmpty(search))
                {
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");
                }

                using (SQLiteDataAdapter da = new SQLiteDataAdapter(cmd))
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
        litFormTitle.Text = "Add New Event";
        btnSave.Text = "Save";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string name = txtEventName.Text.Trim();
        string date = txtEventDate.Text.Trim();
        string location = txtLocation.Text.Trim();
        string id = hfEventId.Value;

        using (SQLiteConnection conn = new SQLiteConnection(connectionString))
        {
            conn.Open();
            string query;
            if (string.IsNullOrEmpty(id))
            {
                query = "INSERT INTO Events (Name, EventDate, Location) VALUES (@name, @date, @location)";
            }
            else
            {
                query = "UPDATE Events SET Name=@name, EventDate=@date, Location=@location WHERE Id=@id";
            }

            using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@date", date);
                cmd.Parameters.AddWithValue("@location", location);
                if (!string.IsNullOrEmpty(id))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                }
                cmd.ExecuteNonQuery();
            }
        }

        ResetForm();
        LoadEvents();
    }

    protected void gvEvents_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "EditEvent")
        {
            using (SQLiteConnection conn = new SQLiteConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM Events WHERE Id = @id";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    using (SQLiteDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            hfEventId.Value = dr["Id"].ToString();
                            txtEventName.Text = dr["Name"].ToString();
                            txtEventDate.Text = dr["EventDate"].ToString();
                            txtLocation.Text = dr["Location"].ToString();
                            litFormTitle.Text = "Edit Event";
                            btnSave.Text = "Update";
                        }
                    }
                }
            }
        }
        else if (e.CommandName == "DeleteEvent")
        {
            using (SQLiteConnection conn = new SQLiteConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM Events WHERE Id = @id";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }
            LoadEvents();
        }
    }
}
