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
    public partial class Professional : System.Web.UI.Page
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

        protected void custValProf_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkProf.Checked;
        }

        protected void btnSubmitProf_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "EventProfessional_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@EventId", SqlDbType.Int).Value = _eventId;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameProf.Text;
                    if (!string.IsNullOrWhiteSpace(txtPhoneProf.Text))
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 20).Value = txtPhoneProf.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 20).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtEmailProf.Text))
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 20).Value = txtEmailProf.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 20).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtDescrProf.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrProf.Text;
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
                        lblErroMsgProf.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForProfessionalIns();", true);
                        RepProfessional.DataBind();
                        resetProfData();
                    }
                    catch (Exception ex)
                    {
                        resetProfData();
                        lblErroMsgProf.Text = ex.ToString();
                        lblErroMsgProf.Visible = true;
                    }


                }
            }
        }

        private void resetProfData()
        {
            txtNameProf.Text = string.Empty;
            txtEmailProf.Text = string.Empty;
            txtPhoneProf.Text = string.Empty;
            txtDescrProf.Text = string.Empty;
            chkProf.Checked = false;
            txtNameProf.Focus();
            btnSubmitProf.Visible = true;
            btnUpdateProf.Visible = false;

        }

        protected void lbtnEditProf_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnProfessionalId = (HiddenField)item.FindControl("hdnProfessionalId");
            Label _lblName = (Label)item.FindControl("lblName");
            Label _lblPhone = (Label)item.FindControl("lblPhone");
            Label _lblEmail = (Label)item.FindControl("lblEmail");
            Label _lblDescr = (Label)item.FindControl("lblDescr");

            hdnPixelProf.Value = _hdnProfessionalId.Value;
            txtNameProf.Text = _lblName.Text;
            txtPhoneProf.Text = _lblPhone.Text;
            txtEmailProf.Text = _lblEmail.Text;
            txtDescrProf.Text = _lblDescr.Text;

            txtNameProf.Focus();

            chkProf.Checked = false;
            btnSubmitProf.Visible = false;
            btnUpdateProf.Visible = true;
        }

        protected void btnUpdateProf_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "EventProfessional_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelProf.Value;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameProf.Text;
                    if (!string.IsNullOrWhiteSpace(txtPhoneProf.Text))
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 20).Value = txtPhoneProf.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 20).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtEmailProf.Text))
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 20).Value = txtEmailProf.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 20).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtDescrProf.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrProf.Text;
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
                        lblErroMsgProf.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForProfessionalUpd();", true);
                        RepProfessional.DataBind();
                        resetProfData();
                    }
                    catch (Exception ex)
                    {
                        resetProfData();
                        lblErroMsgProf.Text = ex.ToString();
                        lblErroMsgProf.Visible = true;
                    }


                }
            }
        }

        protected void btnCancelProf_Click(object sender, EventArgs e)
        {
            resetProfData();
        }
       
        protected void lbtnRemoveProf_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openRemoveModalForProfessional();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnProfessionalId = (HiddenField)item.FindControl("hdnProfessionalId");
            hdnPixelProf.Value = _hdnProfessionalId.Value;
        }

        protected void lbtnSubmitProfForRemove_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "EventProfessional_Remove";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelProf.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                //try
                //{
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeRemoveModalForProfessional();", true);
                RepProfessional.DataBind();
                //}
                //catch (Exception ex)
                //{
                //    lblErroMsg.Visible = true;
                //    lblErroMsg.Text = ex.ToString();
                //}
            }
        }

        protected void lbtnReincludeProf_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openReincludeModalForProfessional();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnProfessionalId = (HiddenField)item.FindControl("hdnProfessionalId");
            hdnPixelProf.Value = _hdnProfessionalId.Value;
        }
      
        protected void lbtnSubmitProfForReinclude_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "EventProfessional_Reinclude";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelProf.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                //try
                //{
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeReincludeModalForProfessional();", true);
                RepProfessional.DataBind();
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