using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.UI;

namespace CourierTrackingSystem034
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetShipment(string trackId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["CourierDB"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT TrackingNumber, SenderName, ReceiverName, Origin, Destination, Status, Stage FROM Couriers WHERE TrackingNumber = @TrackingID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@TrackingID", trackId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        var result = new
                        {
                            trackingId = reader["TrackingNumber"].ToString(),
                            senderName = reader["SenderName"].ToString(),
                            receiverName = reader["ReceiverName"].ToString(),
                            origin = reader["Origin"].ToString(),
                            destination = reader["Destination"].ToString(),
                            status = reader["Status"].ToString(),
                            stage = int.Parse(reader["Stage"].ToString())
                        };
                        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(result);
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
    }
}