using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.AdminG
{
	public partial class AssoPosts : System.Web.UI.Page
	{
        string _ip = string.Empty;
        string _user = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                divNoLog.Visible = false;
                _user = User.Identity.Name;
                _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (_ip == "" || _ip == null)
                    _ip = Request.ServerVariables["REMOTE_ADDR"];
                divddlAssoReg.Visible = true;
            }
            else
            {
                NoLog();
            }
        }

        private void NoLog()
        {
            lblNoLog.Text = "You are not logged in. Please log in.";
            divNoLog.Visible = true;
            divddlAssoReg.Visible = false;
            divAssoPosts.Visible = false;
        }

        protected void ddlAssoReg_DataBound(object sender, EventArgs e)
        {
            ddlAssoReg.Items.Insert(0, new ListItem("--Select--", "0"));
        }

        protected void ddlAssoReg_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (ddlAssoReg.SelectedIndex > 0)
                {
                    divAssoPosts.Visible = true;
                    dvwAssoPosts.ChangeMode(DetailsViewMode.Insert);

                }
                else
                {
                    divAssoPosts.Visible = false;
                }
            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoPosts_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            if (HttpContext.Current != null &&
                               HttpContext.Current.User.Identity.IsAuthenticated)
            {
                e.Values["CrDt"] = DateTime.Now;
                e.Values["CrBy"] = _user;
                e.Values["CrByIp"] = _ip;

            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoPosts_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (HttpContext.Current != null &&
                    HttpContext.Current.User.Identity.IsAuthenticated)
            {
                divAssoPosts.Visible = true;
                dvwAssoPosts.ChangeMode(DetailsViewMode.Insert);
                gvwAssoPosts.DataBind();
            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoPosts_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            if (HttpContext.Current != null &&
                               HttpContext.Current.User.Identity.IsAuthenticated)
            {
                e.NewValues["ModDt"] = DateTime.Now;
                e.NewValues["ModBy"] = _user;
                e.NewValues["ModByIp"] = _ip;
            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoPosts_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (HttpContext.Current != null &&
                    HttpContext.Current.User.Identity.IsAuthenticated)
            {
                divAssoPosts.Visible = true;
                dvwAssoPosts.ChangeMode(DetailsViewMode.Insert);
                gvwAssoPosts.DataBind();
            }
            else
            {
                NoLog();
            }
        }

        protected void gvwAssoPosts_SelectedIndexChanged(object sender, EventArgs e)
        {
            dvwAssoPosts.Visible = true;
            dvwAssoPosts.ChangeMode(DetailsViewMode.Edit);
        }
    }
}