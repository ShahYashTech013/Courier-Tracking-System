using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Linq;

namespace CourierTrackingSystem034
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in and is admin
            if (Session["UserName"] == null || Session["Role"] != "admin")
            {
                Response.Redirect("Auth.aspx");
            }
        }

        [WebMethod]
        public static string AddCourier(string senderName, string senderPhone, string receiverName, string receiverPhone, string origin, string destination, string weight, string status)
        {
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            try
            {
                // Generate unique tracking ID (CT + 6 random digits)
                string trackingId = "CT" + DateTime.Now.Ticks.ToString().Substring(DateTime.Now.Ticks.ToString().Length - 6);

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = @"INSERT INTO Couriers (TrackingNumber, SenderName, SenderPhone, ReceiverName, ReceiverPhone, Origin, Destination, Weight, Status, Stage) 
                                    VALUES (@TrackingNumber, @SenderName, @SenderPhone, @ReceiverName, @ReceiverPhone, @Origin, @Destination, @Weight, @Status, @Stage)";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@TrackingNumber", trackingId);
                    cmd.Parameters.AddWithValue("@SenderName", senderName);
                    cmd.Parameters.AddWithValue("@SenderPhone", senderPhone);
                    cmd.Parameters.AddWithValue("@ReceiverName", receiverName);
                    cmd.Parameters.AddWithValue("@ReceiverPhone", receiverPhone);
                    cmd.Parameters.AddWithValue("@Origin", origin);
                    cmd.Parameters.AddWithValue("@Destination", destination);
                    cmd.Parameters.AddWithValue("@Weight", decimal.Parse(weight));
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@Stage", GetStage(status));

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    return "✅ Courier added successfully! Tracking ID: " + trackingId;
                }
            }
            catch (Exception ex)
            {
                return "❌ Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string GetAllCouriers()
        {
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT TrackingNumber, SenderName, ReceiverName, Origin, Destination, Weight, Status, Stage FROM Couriers ORDER BY CreatedAt DESC";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    var couriers = new System.Collections.Generic.List<object>();
                    while (reader.Read())
                    {
                        couriers.Add(new
                        {
                            trackingNumber = reader["TrackingNumber"].ToString(),
                            senderName = reader["SenderName"].ToString(),
                            receiverName = reader["ReceiverName"].ToString(),
                            origin = reader["Origin"].ToString(),
                            destination = reader["Destination"].ToString(),
                            weight = reader["Weight"].ToString(),
                            status = reader["Status"].ToString(),
                            stage = int.Parse(reader["Stage"].ToString())
                        });
                    }

                    return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(couriers);
                }
            }
            catch (Exception ex)
            {
                return "[]";
            }
        }

        [WebMethod]
        public static string UpdateStatus(string trackingId, string newStatus)
        {
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "UPDATE Couriers SET Status = @Status, Stage = @Stage, UpdatedAt = GETDATE() WHERE TrackingNumber = @TrackingNumber";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@TrackingNumber", trackingId);
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@Stage", GetStage(newStatus));

                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                        return "✅ Status updated successfully!";
                    else
                        return "❌ Tracking ID not found";
                }
            }
            catch (Exception ex)
            {
                return "❌ Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string GetCourierDetails(string trackingId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT * FROM Couriers WHERE TrackingNumber = @TrackingNumber";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@TrackingNumber", trackingId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        int stage = (int)reader["Stage"];
                        return System.Web.Script.Serialization.JavaScriptConvert.SerializeObject(new
                        {
                            trackingId = reader["TrackingNumber"].ToString(),
                            senderName = reader["SenderName"].ToString(),
                            receiverName = reader["ReceiverName"].ToString(),
                            origin = reader["Origin"].ToString(),
                            destination = reader["Destination"].ToString(),
                            status = reader["Status"].ToString(),
                            stage = stage
                        });
                    }
                    else
                    {
                        return null;
                    }
                }
            }
            catch
            {
                return null;
            }
        }

        private static int GetStage(string status)
        {
            return status switch
            {
                "Pickup" => 0,
                "Parcel Hub" => 1,
                "In Transit" => 2,
                "Destination Hub" => 3,
                "Out for Delivery" => 4,
                "Delivered" => 5,
                _ => 0
            };
        }
    }
}