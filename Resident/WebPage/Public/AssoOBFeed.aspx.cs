using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class AssoOBFeed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hplDemo.NavigateUrl =
                GetRouteUrl("ResidentialComplexRoute");
                               //new System.Web.Routing.RouteValueDictionary
                               // {
                               //      //{"Name", "Ram-Kumar-Mishra" },
                               //      //{"Id", 1 }

                               // });
        }
    }
}