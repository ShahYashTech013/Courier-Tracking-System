using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

namespace CourierTrackingSystem034
{
    public partial class Auth : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: clear old error
            lblError.Text = "";
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "❌ Enter username & password";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT Password, Role FROM Users WHERE Username = @Username";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Username", username);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string storedPassword = reader["Password"].ToString();
                        string role = reader["Role"].ToString();

                        if (storedPassword == password)
                        {
                            Session["UserName"] = username;
                            Session["Role"] = role;

                            // Redirect based on role
                            if (role == "admin")
                                Response.Redirect("AdminDashboard.aspx");
                            else
                                Response.Redirect("UserDashboard.aspx");
                        }
                        else
                        {
                            lblError.Text = "❌ Wrong password";
                        }
                    }
                    else
                    {
                        lblError.Text = "❌ User not found";
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "❌ Database error: " + ex.Message;
            }
        }

        // ✅ REGISTER METHOD
        [WebMethod]
        public static string RegisterUser(string username, string password)
        {
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                return "❌ Enter username & password";
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    // Check if user already exists
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                    checkCmd.Parameters.AddWithValue("@Username", username);

                    conn.Open();
                    int count = (int)checkCmd.ExecuteScalar();

                    if (count > 0)
                    {
                        return "❌ User already exists";
                    }

                    // Insert new user
                    string insertQuery = "INSERT INTO Users (Username, Password, Role) VALUES (@Username, @Password, @Role)";
                    SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                    insertCmd.Parameters.AddWithValue("@Username", username);
                    insertCmd.Parameters.AddWithValue("@Password", password);
                    insertCmd.Parameters.AddWithValue("@Role", "user");

                    insertCmd.ExecuteNonQuery();

                    return "✅ Registered successfully! You can now log in.";
                }
            }
            catch (Exception ex)
            {
                return "❌ Error: " + ex.Message;
            }
        }
    }
}