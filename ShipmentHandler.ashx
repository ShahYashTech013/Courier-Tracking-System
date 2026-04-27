<%@ WebHandler Language="C#" Class="ShipmentHandler" %>

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;

public class ShipmentHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        string action = context.Request["action"];
        var js = new JavaScriptSerializer();

        try
        {
            if (action == "track")
            {
                string trackId = (context.Request["trackId"] ?? "").Trim().ToUpper();

                if (string.IsNullOrEmpty(trackId))
                {
                    context.Response.Write(js.Serialize(
                        new { success = false, message = "No Tracking ID" }));
                    return;
                }

                string conn = ConfigurationManager
                    .ConnectionStrings["CourierDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(conn))
                {
                    con.Open();
                    string sql = @"SELECT TrackingNumber, SenderName, ReceiverName,
                                          Origin, Destination, Weight, Status, Stage
                                   FROM   Couriers
                                   WHERE  UPPER(TrackingNumber) = @tid";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@tid", trackId);

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (!dr.Read())
                            {
                                context.Response.Write(js.Serialize(
                                    new { success = false, message = "Not found" }));
                                return;
                            }

                            var result = new
                            {
                                success      = true,
                                trackingId   = dr["TrackingNumber"].ToString(),
                                status       = dr["Status"].ToString(),
                                stage        = Convert.ToInt32(dr["Stage"]),
                                origin       = dr["Origin"].ToString(),
                                destination  = dr["Destination"].ToString(),
                                senderName   = dr["SenderName"].ToString(),
                                receiverName = dr["ReceiverName"].ToString(),
                                weight       = dr["Weight"].ToString()
                            };

                            context.Response.Write(js.Serialize(result));
                        }
                    }
                }
            }
            else if (action == "myshipments")
            {
                // Username — session किंवा querystring मधून
                string username = "";

                if (context.Session != null && context.Session["Username"] != null)
                    username = context.Session["Username"].ToString();

                if (string.IsNullOrEmpty(username))
                    username = context.Request["uname"] ?? "";

                string conn = ConfigurationManager
                    .ConnectionStrings["CourierDB"].ConnectionString;

                var list = new List<object>();

                using (SqlConnection con = new SqlConnection(conn))
                {
                    con.Open();
                    // Couriers table मध्ये Username नाही
                    // म्हणून सगळे recent couriers दाखवतो
                    string sql = @"SELECT TOP 20 
                                          TrackingNumber, Status, Stage,
                                          Origin, Destination,
                                          ReceiverName, CreatedAt
                                   FROM   Couriers
                                   ORDER  BY CreatedAt DESC";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                list.Add(new
                                {
                                    trackingId   = dr["TrackingNumber"].ToString(),
                                    status       = dr["Status"].ToString(),
                                    origin       = dr["Origin"].ToString(),
                                    destination  = dr["Destination"].ToString(),
                                    receiverName = dr["ReceiverName"].ToString(),
                                    bookingDate  = Convert.ToDateTime(dr["CreatedAt"])
                                                          .ToString("dd MMM yyyy")
                                });
                            }
                        }
                    }
                }

                context.Response.Write(js.Serialize(list));
            }
            else
            {
                context.Response.Write(js.Serialize(
                    new { success = false, message = "Unknown action" }));
            }
        }
        catch (Exception ex)
        {
            context.Response.Write(js.Serialize(
                new { success = false, message = ex.Message }));
        }
    }

    public bool IsReusable { get { return false; } }
}