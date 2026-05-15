using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

public partial class Register : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["EventDb"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (User.Identity.IsAuthenticated)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;

        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();
        string fullName = txtFullName.Text.Trim();

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check if username already exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Username", username);
                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                    {
                        string script = "alert('Username already exists. Please choose another one.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                        return;
                    }
                }

                // Insert new user with default role 'User'
                string query = "INSERT INTO Users (Username, Password, FullName, Role) VALUES (@Username, @Password, @FullName, 'User')";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@FullName", fullName);

                    cmd.ExecuteNonQuery();
                }
            }

            string successScript = "alert('Registration successful! You can now login.'); window.location='Login.aspx';";
            ClientScript.RegisterStartupScript(this.GetType(), "success", successScript, true);
        }
        catch (Exception ex)
        {
            string errorScript = "alert('An error occurred during registration: " + ex.Message.Replace("'", "\\'") + "');";
            ClientScript.RegisterStartupScript(this.GetType(), "error", errorScript, true);
        }
    }
}
