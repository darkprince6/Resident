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
    public partial class Vendor : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        SqlConnection con = new SqlConnection();

        string _ip = string.Empty;
        string _user = string.Empty;
        int _eventId = 1;
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

        protected void custValVendor_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkVendor.Checked;
        }

        protected void btnSubmitVendor_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "EventVendor_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@EventId", SqlDbType.Int).Value = _eventId;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameVendor.Text;
                    if (!string.IsNullOrWhiteSpace(txtPhoneVendor.Text))
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 20).Value = txtPhoneVendor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 20).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtEmailVendor.Text))
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 20).Value = txtEmailVendor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 20).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtDescrVendor.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrVendor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    }
                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgVendor.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForVendorIns();", true);
                        RepVendor.DataBind();
                        resetVendorData();
                    }
                    catch (Exception ex)
                    {
                        resetVendorData();
                        lblErroMsgVendor.Text = ex.ToString();
                        lblErroMsgVendor.Visible = true;
                    }


                }
            }
        }

        private void resetVendorData()
        {
            txtNameVendor.Text = string.Empty;
            txtEmailVendor.Text = string.Empty;
            txtPhoneVendor.Text = string.Empty;
            txtDescrVendor.Text = string.Empty;
            chkVendor.Checked = false;
            txtNameVendor.Focus();
            btnSubmitVendor.Visible = true;
            btnUpdateVendor.Visible = false;

        }

        protected void lbtnEditVendor_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnVendorId = (HiddenField)item.FindControl("hdnVendorId");
            Label _lblName = (Label)item.FindControl("lblName");
            Label _lblPhone = (Label)item.FindControl("lblPhone");
            Label _lblEmail = (Label)item.FindControl("lblEmail");
            Label _lblDescr = (Label)item.FindControl("lblDescr");

            hdnPixelVendor.Value = _hdnVendorId.Value;
            txtNameVendor.Text = _lblName.Text;
            txtPhoneVendor.Text = _lblPhone.Text;
            txtEmailVendor.Text = _lblEmail.Text;
            txtDescrVendor.Text = _lblDescr.Text;

            txtNameVendor.Focus();

            chkVendor.Checked = false;
            btnSubmitVendor.Visible = false;
            btnUpdateVendor.Visible = true;
        }

        protected void btnUpdateVendor_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "EventVendor_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelVendor.Value;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameVendor.Text;
                    if (!string.IsNullOrWhiteSpace(txtPhoneVendor.Text))
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 20).Value = txtPhoneVendor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 20).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtEmailVendor.Text))
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 20).Value = txtEmailVendor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 20).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtDescrVendor.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrVendor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    }
                    cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgVendor.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForVendorUpd();", true);
                        RepVendor.DataBind();
                        resetVendorData();
                    }
                    catch (Exception ex)
                    {
                        resetVendorData();
                        lblErroMsgVendor.Text = ex.ToString();
                        lblErroMsgVendor.Visible = true;
                    }


                }
            }
        }

        protected void btnCancelVendor_Click(object sender, EventArgs e)
        {
            resetVendorData();
        }

        protected void lbtnRemoveVendor_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openRemoveModalForVendor();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnVendorId = (HiddenField)item.FindControl("hdnVendorId");
            hdnPixelVendor.Value = _hdnVendorId.Value;
        }

        protected void lbtnSubmitVendorForRemove_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "EventVendor_Remove";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelVendor.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                //try
                //{
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeRemoveModalForVendor();", true);
                RepVendor.DataBind();
                //}
                //catch (Exception ex)
                //{
                //    lblErroMsg.Visible = true;
                //    lblErroMsg.Text = ex.ToString();
                //}
            }
        }

        protected void lbtnReincludeVendor_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openReincludeModalForVendor();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnVendorId = (HiddenField)item.FindControl("hdnVendorId");
            hdnPixelVendor.Value = _hdnVendorId.Value;
        }

        protected void lbtnSubmitVendorForReinclude_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "EventVendor_Reinclude";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelVendor.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                //try
                //{
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeReincludeModalForVendor();", true);
                RepVendor.DataBind();
                //}
                //catch (Exception ex)
                //{
                //    lblErroMsg.Visible = true;
                //    lblErroMsg.Text = ex.ToString();
                //}
            }
        }
    }
}