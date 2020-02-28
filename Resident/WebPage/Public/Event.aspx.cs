using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class Event : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RepEvents_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string _hdnComplexEventId = (e.Item.FindControl("hdnComplexEventId") as HiddenField).Value;
                HyperLink _lnkAddVanue = e.Item.FindControl("lnkAddVanue") as HyperLink;
                _lnkAddVanue.NavigateUrl = "~/WebPage/Public/EventVenues.aspx?ComplexEventId=" + _hdnComplexEventId.ToString();
            }
        }
    }
}