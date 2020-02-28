using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.AdminG
{
    public partial class ResiApprove : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        string _ip = string.Empty;
        string _user = string.Empty;
        string s = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                s = Request.QueryString["Id"];
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                _user = User.Identity.Name;
                _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (_ip == "" || _ip == null)
                    _ip = Request.ServerVariables["REMOTE_ADDR"];
            }
        }

        protected void lbtnApprove_Click(object sender, EventArgs e)
        {
            LinkButton _lbtn = (LinkButton)sender;
            RepeaterItem _item = (RepeaterItem)_lbtn.Parent;
            HiddenField _hdnId = (HiddenField)_item.FindControl("hdnId");

            // if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            using (SqlConnection con = new SqlConnection(constr))
            {
                SqlCommand cmdAprove = new SqlCommand("PropertyResiApply_Approved", con);
                cmdAprove.CommandType = CommandType.StoredProcedure;
                cmdAprove.Parameters.Add("@IsAppr", SqlDbType.Bit).Value = true;
                cmdAprove.Parameters.Add("@ComplexId", SqlDbType.Int).Value = 1;
                cmdAprove.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                cmdAprove.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmdAprove.Parameters.Add("@CrByIp", SqlDbType.NVarChar, 150).Value = _ip;
                cmdAprove.Parameters.Add("@Id", SqlDbType.Int).Value = _hdnId.Value;
                con.Open();
                cmdAprove.ExecuteNonQuery();
                con.Close();
                repApprove.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertmsgforapprove();", true);

            }
            //  }
        }

        protected void lbtnReject_Click(object sender, EventArgs e)
        {
            LinkButton _lbtn = (LinkButton)sender;
            RepeaterItem _item = (RepeaterItem)_lbtn.Parent;
            HiddenField _hdnId = (HiddenField)_item.FindControl("hdnId");

            // if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            using (SqlConnection con = new SqlConnection(constr))
            {
                SqlCommand cmdReject = new SqlCommand("PropertyResiApply_Approved", con);
                cmdReject.CommandType = CommandType.StoredProcedure;
                cmdReject.Parameters.Add("@IsAppr", SqlDbType.Bit).Value = false;
                cmdReject.Parameters.Add("@ComplexId", SqlDbType.Int).Value = 1;
                cmdReject.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                cmdReject.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmdReject.Parameters.Add("@CrByIp", SqlDbType.NVarChar, 150).Value = _ip;
                cmdReject.Parameters.Add("@Id", SqlDbType.Int).Value = _hdnId.Value;
                con.Open();
                cmdReject.ExecuteNonQuery();
                con.Close();
                repApprove.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertmsgforreject();", true);


            }
            //  }
        }

        protected void lbtnSendMessage_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
            LinkButton _lbtn = (LinkButton)sender;
            RepeaterItem _item = (RepeaterItem)_lbtn.Parent;
            HiddenField _hdnId = (HiddenField)_item.FindControl("hdnId");
            hdnApplyId.Value = _hdnId.Value;
        }

        protected void repApprove_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HiddenField _hdnIsAppr = e.Item.FindControl("hdnIsAppr") as HiddenField;
                LinkButton _lbtnApprove = e.Item.FindControl("lbtnApprove") as LinkButton;
                LinkButton _lbtnReject = e.Item.FindControl("lbtnReject") as LinkButton;
                if (_hdnIsAppr.Value == "True")
                {
                    _lbtnApprove.Visible = false;
                }
                else if (_hdnIsAppr.Value == "False")
                {
                    _lbtnReject.Visible = false;
                }
            }

        }

        protected void btnReplySubmit_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                SqlCommand cmdAprove = new SqlCommand("PropertyResiApplyReply_Ins", con);
                cmdAprove.CommandType = CommandType.StoredProcedure;
                cmdAprove.Parameters.Add("@ComplexId", SqlDbType.Int).Value = 1;
                cmdAprove.Parameters.Add("@PropertyResiApplyId", SqlDbType.Int).Value = hdnApplyId.Value;
                cmdAprove.Parameters.Add("@Descr", SqlDbType.NVarChar, 250).Value = txtDescr.Text;
                cmdAprove.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                cmdAprove.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmdAprove.Parameters.Add("@CrByIp", SqlDbType.NVarChar, 150).Value = _ip;
                con.Open();
                cmdAprove.ExecuteNonQuery();
                con.Close();
                repApprove.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertmsg();", true);

                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModal();", true);

            }
        }
    }
}