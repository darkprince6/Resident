using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class Meeting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RepMeeting_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string _hdnMeetingId = (e.Item.FindControl("hdnMeetingId") as HiddenField).Value;
                HyperLink _lnkShowMeetdetails = e.Item.FindControl("lnkShowMeetdetails") as HyperLink;
                _lnkShowMeetdetails.NavigateUrl = "~/WebPage/Public/MeetingDetails.aspx?MeetingId=" + _hdnMeetingId.ToString();
            }
        }
    }
}