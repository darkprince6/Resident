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
    public partial class SocialMedia : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        SqlConnection con = new SqlConnection();

        string _ip = string.Empty;
        string _user = string.Empty;
        int _eventId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = conStr;

            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (_ip == "" || _ip == null)
                _ip = Request.ServerVariables["REMOTE_ADDR"];

            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            //{
            _user = User.Identity.Name;
            if (!IsPostBack)
            {
            }
            //  }
        }

        protected void lbtnIcon_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openSocialModal();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnSocialId = (HiddenField)item.FindControl("hdnSocialId");
            HiddenField _hdnName = (HiddenField)item.FindControl("hdnName");
            HiddenField _hdnIcon = (HiddenField)item.FindControl("hdnIcon");
            hdnSocialPixel.Value = _hdnSocialId.Value;
            hdnSocialName.Value = _hdnName.Value;
            hdnSocialIcon.Value = _hdnIcon.Value;

        }

        protected void lbtnSocialSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "SocialMediaComplexLink_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@SMId", SqlDbType.Int).Value = hdnSocialPixel.Value;
                    cmd.Parameters.Add("@SMName", SqlDbType.NVarChar, 50).Value = hdnSocialName.Value;
                    cmd.Parameters.Add("@Icon", SqlDbType.NVarChar, 50).Value = hdnSocialIcon.Value;
                    cmd.Parameters.Add("@Link", SqlDbType.NVarChar, 250).Value = txtLink.Text;

                    if (!string.IsNullOrWhiteSpace(txtDescr.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 50).Value = txtDescr.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }
                    
                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsg.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForSocial();", true);
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeSocialModal();", true);

                        // RepSponser.DataBind();
                        resetData();
                    }
                    catch (Exception ex)
                    {
                        resetData();
                        lblErroMsg.Text = ex.ToString();
                        lblErroMsg.Visible = true;
                    }


                }
            }
        }

        private void resetData()
        {
            txtLink.Text = string.Empty;
            txtDescr.Text = string.Empty;
            chkSocial.Checked = false;
        }

        protected void CustvalSocial_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkSocial.Checked;
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem ri = e.Item;


            if ((ri.ItemType == ListItemType.Item) || (ri.ItemType == ListItemType.AlternatingItem))
            {
                HyperLink chb = ri.FindControl("lnkColor") as HyperLink;


                if ((chb != null) && chb.Text.Contains(","))
                {
                    chb.Text = chb.Text.Replace(",", ">");
                    chb.NavigateUrl = chb.NavigateUrl.Replace(",", "mailto");
                    HyperLink hyp = new HyperLink();
                    hyp.ID = "hypABD";
                    hyp.NavigateUrl = "";
                    hyp.Text = "Hello";
                    Page.Controls.Add(hyp);
                }
            }
        }
    }
}