using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Admin_ManageUsers : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["EventDb"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.Identity.IsAuthenticated || Session["Role"] as string != "Admin")
        {
            Response.Redirect("../Login.aspx");
            return;
        }

        litUsernameNav.Text = User.Identity.Name;

        if (!IsPostBack)
        {
            LoadUsers();
        }
    }

    private void LoadUsers(string search = "")
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT UserID, Username, FullName, Role FROM Users";
            if (!string.IsNullOrEmpty(search))
            {
                query += " WHERE Username LIKE @search";
            }
            query += " ORDER BY Username ASC";

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
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadUsers(txtSearch.Text.Trim());
    }

    protected void btnClearSearch_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        LoadUsers();
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
        hfUserId.Value = "";
        txtUsername.Text = "";
        txtPassword.Text = "";
        txtFullName.Text = "";
        ddlRole.SelectedIndex = 0;
        litFormTitle.Text = "Add New User";
        btnSave.Text = "Save";
    }

    private void ShowMessage(string message)
    {
        string script = "alert('" + message.Replace("'", "\\'") + "');";
        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();
        string fullName = txtFullName.Text.Trim();
        string role = ddlRole.SelectedValue;
        string id = hfUserId.Value;

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query;
                if (string.IsNullOrEmpty(id))
                {
                    query = "INSERT INTO Users (Username, Password, FullName, Role) VALUES (@username, @password, @fullname, @role)";
                }
                else
                {
                    query = "UPDATE Users SET Username=@username, Password=@password, FullName=@fullname, Role=@role WHERE UserID=@id";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@password", password);
                    cmd.Parameters.AddWithValue("@fullname", fullName);
                    cmd.Parameters.AddWithValue("@role", role);
                    if (!string.IsNullOrEmpty(id))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                    }
                    cmd.ExecuteNonQuery();
                }
            }

            string msg = string.IsNullOrEmpty(id) ? "User added successfully!" : "User updated!";
            ResetForm();
            LoadUsers();
            ShowMessage(msg);
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message);
        }
    }

    protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditUser")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM Users WHERE UserID = @id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            hfUserId.Value = dr["UserID"].ToString();
                            txtUsername.Text = dr["Username"].ToString();
                            txtPassword.Text = dr["Password"].ToString();
                            txtFullName.Text = dr["FullName"].ToString();
                            ddlRole.SelectedValue = dr["Role"].ToString();
                            litFormTitle.Text = "Edit User";
                            btnSave.Text = "Update";
                        }
                    }
                }
            }
        }
        else if (e.CommandName == "DeleteUser")
        {
            try
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "DELETE FROM Users WHERE UserID = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadUsers();
                ShowMessage("User deleted!");
            }
            catch (Exception ex)
            {
                ShowMessage("Error deleting user: " + ex.Message);
            }
        }
    }
}
