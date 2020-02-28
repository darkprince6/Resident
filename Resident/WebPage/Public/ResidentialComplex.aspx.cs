using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class ResidentialComplex : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.GetRouteUrl("Complex");
            // Response.Write(x);
            // Response.RedirectToRoute(x);
            GetLocalIPAddress();
            
        }

        public void GetLocalIPAddress()
        {
            var host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (var ip in host.AddressList)
            {
                if (ip.AddressFamily == AddressFamily.InterNetwork)
                {
                    Response.Write( ip.ToString());
                    
                }
            }
            //throw new Exception("No network adapters with an IPv4 address in the system!");
        }
    }
}