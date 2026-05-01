using System;
using System.Data;
using System.Data.SQLite;
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
            query += " ORDER BY EventDate ASC";

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

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("../Login.aspx");
    }
}
