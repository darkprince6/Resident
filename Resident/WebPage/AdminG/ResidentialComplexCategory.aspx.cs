using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.AdminG
{
    public partial class ResidentialComplexCategory : System.Web.UI.Page
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
                divResComCat.Visible = true;
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
            divResComCat.Visible = false;
        }

        protected void dvwResComCat_ItemInserting(object sender, DetailsViewInsertEventArgs e)
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

        protected void dvwResComCat_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (HttpContext.Current != null &&
                    HttpContext.Current.User.Identity.IsAuthenticated)
            {
                dvwResComCat.Visible = true;
                dvwResComCat.ChangeMode(DetailsViewMode.Insert);
                gvwResComCat.DataBind();
            }
            else
            {
                NoLog();
            }
        }

        protected void dvwResComCat_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
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

        protected void dvwResComCat_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (HttpContext.Current != null &&
                    HttpContext.Current.User.Identity.IsAuthenticated)
            {
                dvwResComCat.Visible = true;
                dvwResComCat.ChangeMode(DetailsViewMode.Insert);
                gvwResComCat.DataBind();

            }
            else
            {
                NoLog();
            }
        }

        protected void gvwResComCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            dvwResComCat.Visible = true;
            dvwResComCat.ChangeMode(DetailsViewMode.Edit);
        }
    }
}