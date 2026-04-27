using System;
using System.Collections.Generic;

namespace CourierTrackingSystem034
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            var users = new Dictionary<string, Tuple<string, string>>();

            // Dummy users
            users.Add("admin", Tuple.Create("admin123", "admin"));
            users.Add("user", Tuple.Create("user123", "user"));

            Application["users"] = users;
        }
    }
}