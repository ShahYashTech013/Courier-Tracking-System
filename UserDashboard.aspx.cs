using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using WebGrease.Activities;

namespace CourierTrackingSystem034
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "⚠️ Please enter username and password.";
                return;
            }

            try
            {
                string conn = ConfigurationManager
                    .ConnectionStrings["CourierDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(conn))
                {
                    con.Open();
                    // ✅ Users table — Username + Password + Role
                    string sql = @"SELECT Username, Role 
                                   FROM Users 
                                   WHERE Username = @uname 
                                   AND Password = @pass";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@uname", username);
                        cmd.Parameters.AddWithValue("@pass", password);

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                string role = dr["Role"].ToString();
                                Session["Username"] = dr["Username"].ToString();
                                Session["Role"] = role;

                                // ✅ Role नुसार redirect
                                if (role == "admin")
                                    Response.Redirect("AdminDashboard.aspx");
                                else
                                    Response.Redirect("UserDashboard.aspx");
                            }
                            elseusing System;
                            using System.Web.UI;

namespace CourierTrackingSystem034
    {
        public partial class UserDashboard : Page
        {
            protected void Page_Load(object sender, EventArgs e)
            {
                if (Session["Username"] == null)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                if (!IsPostBack)
                {
                    hfUsername.Value = Session["Username"].ToString();
                }
            }
        }
    }
                            {
                                lblError.Text = "❌ Invalid username or password.";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "❌ Error: " + ex.Message;
            }
        }
    }
}