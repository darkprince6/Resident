using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class EventVenues : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        SqlConnection con = new SqlConnection();

        string _ip = string.Empty;
        string _user = string.Empty;
        int _complexEventId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = conStr;

            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (_ip == "" || _ip == null)
                _ip = Request.ServerVariables["REMOTE_ADDR"];

            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                _user = User.Identity.Name;
                _complexEventId = int.Parse(Request.QueryString["ComplexEventId"]);
                if (!IsPostBack)
                {
                }
            }

        }
        #region Venue
        protected void lbtnAddVenue_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openVenueModal();", true);

            divEntryForVenue.Visible = true;
            lblErroMsgForVenue.Visible = false;
            txtTitleForVenueForIns.Text = string.Empty;
            txtAdd1ForVenueForIns.Text = string.Empty;
            txtAdd2ForVenueForIns.Text = string.Empty;
            txtPostalCodeForVenueForIns.Text = string.Empty;
            txtFromDateForVenueForIns.Text = string.Empty;
            txtToDateForVenueForIns.Text = string.Empty;
            txtDescrForVenueForIns.Text = string.Empty;
            chkVenue.Checked = false;
            txtTitleForVenueForIns.Focus();

            lblNoLogForVenue.Visible = false;
            lblNoAdminForVenue.Visible = false;
            lblNoAdminComForVenue.Visible = false;
            lblNoAdminActGForVenue.Visible = false;
        }

        protected void CustValVenue_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkVenue.Checked;

        }

        protected void btnSubmitForVenue_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (IsValid)
                {
                    using (con)
                    {
                        string query = "EventVenues_Ins_Modal";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@ComplexEventId", SqlDbType.Int).Value = _complexEventId;
                        if (!string.IsNullOrWhiteSpace(txtTitleForVenueForIns.Text))
                        {
                            cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = txtTitleForVenueForIns.Text;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                        }
                        cmd.Parameters.Add("@Address1", SqlDbType.NVarChar, 250).Value = txtAdd1ForVenueForIns.Text;

                        if (!string.IsNullOrWhiteSpace(txtAdd2ForVenueForIns.Text))
                        {
                            cmd.Parameters.Add("@Address2", SqlDbType.NVarChar, 250).Value = txtAdd2ForVenueForIns.Text;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Address2", SqlDbType.NVarChar, 250).Value = DBNull.Value;
                        }
                        cmd.Parameters.Add("@PostalCode", SqlDbType.Int).Value = txtPostalCodeForVenueForIns.Text;
                        cmd.Parameters.Add("@FromDate", SqlDbType.DateTime).Value = txtFromDateForVenueForIns.Text;
                        if (!string.IsNullOrWhiteSpace(txtToDateForVenueForIns.Text))
                        {
                            cmd.Parameters.Add("@ToDate", SqlDbType.DateTime).Value = txtToDateForVenueForIns.Text;
                        }
                        else
                        {
                            cmd.Parameters.Add("@ToDate", SqlDbType.DateTime).Value = DBNull.Value;
                        }
                        if (!string.IsNullOrWhiteSpace(txtDescrForVenueForIns.Text))
                        {
                            cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 150).Value = txtDescrForVenueForIns.Text;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                        }
                        
                        cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblErroMsgForVenue.Visible = false;

                            ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeVenueModal();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForVenue();", true);
                            RepVenue.DataBind();

                        }
                        catch (Exception ex)
                        {
                            lblErroMsgForVenue.Text = ex.ToString();

                            lblErroMsgForVenue.Visible = true;
                        }


                    }
                }

            }
            else
            {
                lblNoLogForVenue.Visible = true;
            }
        }

        protected void lbtnEditVenue_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openVenueModalForEdit();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnVenueId = (HiddenField)item.FindControl("hdnVenueId");
            Label _lblTitleForVenue = (Label)item.FindControl("lblTitleForVenue");

            Label _lblAdd1ForVenue = (Label)item.FindControl("lblAdd1ForVenue");
            Label _lblAdd2ForVenue = (Label)item.FindControl("lblAdd2ForVenue");
            Label _lblPostalCodeForVenue = (Label)item.FindControl("lblPostalCodeForVenue");
            HiddenField _hdnFromDateForVenue = (HiddenField)item.FindControl("hdnFromDateForVenue");
            HiddenField _hdnToDateForVenue = (HiddenField)item.FindControl("hdnToDateForVenue");
            Label _lblDescrForVenue = (Label)item.FindControl("lblDescrForVenue");

            hdnPixel.Value = _hdnVenueId.Value;
            txtTitleForVenueForEdit.Text = _lblTitleForVenue.Text;
            txtAdd1ForVenueForEdit.Text = _lblAdd1ForVenue.Text;
            txtAdd2ForVenueForEdit.Text = _lblAdd2ForVenue.Text;
            txtPostalCodeForVenueForEdit.Text = _lblPostalCodeForVenue.Text;
            txtFromDateForVenueForEdit.Text = _hdnFromDateForVenue.Value;
            txtToDateForVenueForEdit.Text = _hdnToDateForVenue.Value;
            txtDescrForVenueForEdit.Text = _lblDescrForVenue.Text;
            txtTitleForVenueForEdit.Focus();
            chkVenueForEdit.Checked = false;
        }

        protected void lbtnRemoveVenue_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openVenueModalForRemove();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnVenueId = (HiddenField)item.FindControl("hdnVenueId");
            hdnPixel.Value = _hdnVenueId.Value;

        }

        protected void CustValVenueForEdit_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkVenueForEdit.Checked;
        }

        protected void btnSubmitForVenueForEdit_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (IsValid)
                {
                    using (con)
                    {
                        string query = "EventVenues_Upd_Modal";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                        if (!string.IsNullOrWhiteSpace(txtTitleForVenueForEdit.Text))
                        {
                            cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = txtTitleForVenueForEdit.Text;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                        }
                        cmd.Parameters.Add("@Address1", SqlDbType.NVarChar, 250).Value = txtAdd1ForVenueForEdit.Text;

                        if (!string.IsNullOrWhiteSpace(txtAdd2ForVenueForEdit.Text))
                        {
                            cmd.Parameters.Add("@Address2", SqlDbType.NVarChar, 250).Value = txtAdd2ForVenueForEdit.Text;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Address2", SqlDbType.NVarChar, 250).Value = DBNull.Value;
                        }
                        cmd.Parameters.Add("@PostalCode", SqlDbType.Int).Value = txtPostalCodeForVenueForEdit.Text;
                        cmd.Parameters.Add("@FromDate", SqlDbType.DateTime).Value = txtFromDateForVenueForEdit.Text;
                        if (!string.IsNullOrWhiteSpace(txtToDateForVenueForEdit.Text))
                        {
                            cmd.Parameters.Add("@ToDate", SqlDbType.DateTime).Value = txtToDateForVenueForEdit.Text;
                        }
                        else
                        {
                            cmd.Parameters.Add("@ToDate", SqlDbType.DateTime).Value = DBNull.Value;
                        }
                        if (!string.IsNullOrWhiteSpace(txtDescrForVenueForEdit.Text))
                        {
                            cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 150).Value = txtDescrForVenueForEdit.Text;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                        }
                        cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblErroMsgForVenueForEdit.Visible = false;

                            ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeVenueModalForEdit();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForVenueForEdit();", true);
                            RepVenue.DataBind();

                        }
                        catch (Exception ex)
                        {
                            // lblErroMsgForVenue.Text = ex.ToString();

                            lblErroMsgForVenueForEdit.Visible = true;
                        }


                    }
                }

            }
            else
            {
                lblNoLogForVenueForEdit.Visible = true;
            }
        }

        protected void lbtnSubmitForVenueForRemove_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (con)
                {
                    string query = "EventVenues_Remove_Modal";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                    cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    //try
                    //{
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeVenueModalForRemove();", true);
                        RepVenue.DataBind();

                    //}
                    //catch (Exception ex)
                    //{

                    //}

                }

            }
        }

        protected void lbtnReincludeVenue_Click(object sender, EventArgs e)
        {

            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (con)
                {
                    string query = "EventVenues_Reinclude_Modal";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                    cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        RepVenue.DataBind();

                    }
                    catch (Exception ex)
                    {

                    }

                }

            }
        }


        #endregion
    }
}