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
    public partial class MeetingDetails : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        SqlConnection con = new SqlConnection();

        string _ip = string.Empty;
        string _user = string.Empty;
        int _assoId = 0;
        int _meetingId = 0;
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
                _meetingId = int.Parse(Request.QueryString["MeetingId"]);
                if (!IsPostBack)
                {
                }
            }

        }
        #region Agenda
        protected void lbtnAddAgenda_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openAgendaModal();", true);

            divEntryForAgenda.Visible = true;
            lblErroMsgForAgenda.Visible = false;
            txtTitleForAgenda.Text = string.Empty;
            txtDescr1Agenda.Text = string.Empty;
            txtDescr2Agenda.Text = string.Empty;
            txtPriorityAgenda.Text = "0";
            chkAgenda.Checked = false;
            txtTitleForAgenda.Focus();

            lblNoLogForAgenda.Visible = false;
            lblNoAdminForAgenda.Visible = false;
            lblNoAdminComForAgenda.Visible = false;
            lblNoAdminActGForAgenda.Visible = false;
        }

        protected void CustValAgenda_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkAgenda.Checked;

        }

        protected void btnSubmitForAgenda_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (IsValid)
                {
                    using (con)
                    {
                        string query = "MeetingAgenda_Ins_Modal";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@AssoId", SqlDbType.Int).Value = _assoId;
                        cmd.Parameters.Add("@MeetingId", SqlDbType.Int).Value = _meetingId;
                        cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 50).Value = txtTitleForAgenda.Text;
                        cmd.Parameters.Add("@Descr1", SqlDbType.NVarChar, 500).Value = txtDescr1Agenda.Text;
                        cmd.Parameters.Add("@Descr2", SqlDbType.NVarChar, 500).Value = txtDescr2Agenda.Text;
                        cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityAgenda.Text;
                        cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblErroMsgForAgenda.Visible = false;

                            ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeAgendaModal();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForAgenda();", true);
                            RepAgenda.DataBind();

                        }
                        catch (Exception ex)
                        {
                            // lblErroMsgForAgenda.Text = ex.ToString();

                            lblErroMsgForAgenda.Visible = true;
                        }


                    }
                }

            }
            else
            {
                lblNoLogForAgenda.Visible = true;
            }
        }

        protected void lbtnEditAgenda_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openAgendaModalForEdit();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnAgendaId = (HiddenField)item.FindControl("hdnAgendaId");
            HiddenField _hdnPriority = (HiddenField)item.FindControl("hdnPriority");
            Label _lblTitle = (Label)item.FindControl("lblTitle");
            Label _lblDescr1 = (Label)item.FindControl("lblDescr1");
            Label _lblDescr2 = (Label)item.FindControl("lblDescr2");

            hdnPixel.Value = _hdnAgendaId.Value;
            txtTitleForAgendaForEdit.Text = _lblTitle.Text;
            txtDescr1AgendaForEdit.Text = _lblDescr1.Text;
            txtDescr2AgendaForEdit.Text = _lblDescr2.Text;
            txtPriorityAgendaForEdit.Text = _hdnPriority.Value;
            chkAgendaForEdit.Checked = false;
        }

        protected void lbtnRemoveAgenda_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openAgendaModalForRemove();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnAgendaId = (HiddenField)item.FindControl("hdnAgendaId");
            hdnPixel.Value = _hdnAgendaId.Value;

        }

        protected void CustValAgendaForEdit_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkAgendaForEdit.Checked;
        }

        protected void btnSubmitForAgendaForEdit_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (IsValid)
                {
                    using (con)
                    {
                        string query = "MeetingAgenda_Upd_Modal";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                        cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 50).Value = txtTitleForAgendaForEdit.Text;
                        cmd.Parameters.Add("@Descr1", SqlDbType.NVarChar, 500).Value = txtDescr1AgendaForEdit.Text;
                        cmd.Parameters.Add("@Descr2", SqlDbType.NVarChar, 500).Value = txtDescr2AgendaForEdit.Text;
                        cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityAgendaForEdit.Text;
                        cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblErroMsgForAgendaForEdit.Visible = false;

                            ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeAgendaModalForEdit();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForAgendaForEdit();", true);
                            RepAgenda.DataBind();

                        }
                        catch (Exception ex)
                        {
                            // lblErroMsgForAgenda.Text = ex.ToString();

                            lblErroMsgForAgendaForEdit.Visible = true;
                        }


                    }
                }

            }
            else
            {
                lblNoLogForAgendaForEdit.Visible = true;
            }
        }

        protected void lbtnSubmitForAgendaForRemove_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (con)
                {
                    string query = "MeetingAgenda_Remove_Modal";
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
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeAgendaModalForRemove();", true);
                        RepAgenda.DataBind();

                    }
                    catch (Exception ex)
                    {
                        
                    }

                }

            }
        }

        protected void lbtnReincludeAgenda_Click(object sender, EventArgs e)
        {

            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (con)
                {
                    string query = "MeetingAgenda_Reinclude_Modal";
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
                        RepAgenda.DataBind();

                    }
                    catch (Exception ex)
                    {

                    }

                }

            }
        }


        #endregion

        #region Attendance
        protected void lbtnAddAttendance_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openAttendanceModal();", true);

            divEntryForAttendance.Visible = true;
            lblErroMsgForAttendance.Visible = false;
            txtNameForAttendance.Text = "";
            txtDescr1Attendance.Text = "";
            txtDescr2Attendance.Text = "";
            txtPriorityAttendance.Text = "0";

            chkAttendance.Checked = false;
            txtNameForAttendance.Focus();

            lblNoLogForAttendance.Visible = false;
            lblNoAdminForAttendance.Visible = false;
            lblNoAdminComForAttendance.Visible = false;
            lblNoAdminActGForAttendance.Visible = false;
        }

        protected void CustValAttendance_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkAttendance.Checked;

        }

        protected void btnSubmitForAttendance_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (IsValid)
                {
                    using (con)
                    {
                        string query = "MeetingAttendance_Ins_Modal";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@AssoId", SqlDbType.Int).Value = _assoId;
                        cmd.Parameters.Add("@MeetingId", SqlDbType.Int).Value = _meetingId;
                        cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 50).Value = txtNameForAttendance.Text;
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescr1Attendance.Text;
                        cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityAttendance.Text;
                        cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblErroMsgForAttendance.Visible = false;

                            ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeAttendanceModal();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForAttendance();", true);
                            RepAttendance.DataBind();

                        }
                        catch (Exception ex)
                        {
                            //lblErroMsgForAttendance.Text = ex.ToString();

                            lblErroMsgForAttendance.Visible = true;
                        }


                    }
                }

            }
            else
            {
                lblNoLogForAttendance.Visible = true;
            }
        }

        protected void lbtnEditAttendance_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openAttendanceModalForEdit();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnAttendanceId = (HiddenField)item.FindControl("hdnAttendanceId");
            HiddenField _hdnPriority = (HiddenField)item.FindControl("hdnPriority");
            Label _lblName = (Label)item.FindControl("lblName");
            Label _lblDescr = (Label)item.FindControl("lblDescr");

            hdnPixel.Value = _hdnAttendanceId.Value;
            txtNameForAttendanceForEdit.Text = _lblName.Text;
            txtDescrAttendanceForEdit.Text = _lblDescr.Text;
            txtPriorityAttendanceForEdit.Text = _hdnPriority.Value;
            chkAttendanceForEdit.Checked = false;
        }

        protected void lbtnRemoveAttendance_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openAttendanceModalForRemove();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnAttendanceId = (HiddenField)item.FindControl("hdnAttendanceId");
            hdnPixel.Value = _hdnAttendanceId.Value;
        }

        protected void CustValAttendanceForEdit_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkAttendanceForEdit.Checked;

        }

        protected void btnSubmitForAttendanceForEdit_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (IsValid)
                {
                    using (con)
                    {
                        string query = "MeetingAttendance_Upd_Modal";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                        cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 50).Value = txtNameForAttendanceForEdit.Text;
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrAttendanceForEdit.Text;
                        cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityAttendanceForEdit.Text;
                        cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblErroMsgForAttendanceForEdit.Visible = false;

                            ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeAttendanceModalForEdit();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForAttendanceForEdit();", true);
                            RepAttendance.DataBind();

                        }
                        catch (Exception ex)
                        {
                            // lblErroMsgForAttendance.Text = ex.ToString();

                            lblErroMsgForAttendanceForEdit.Visible = true;
                        }


                    }
                }

            }
            else
            {
                lblNoLogForAttendanceForEdit.Visible = true;
            }
        }

        protected void lbtnSubmitForAttendanceForRemove_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (con)
                {
                    string query = "MeetingAttendance_Remove_Modal";
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
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeAttendanceModalForRemove();", true);
                        RepAttendance.DataBind();

                    }
                    catch (Exception ex)
                    {

                    }

                }

            }
        }

        protected void lbtnReincludeAttendance_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (con)
                {
                    string query = "MeetingAttendance_Reinclude_Modal";
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
                        RepAttendance.DataBind();

                    }
                    catch (Exception ex)
                    {

                    }

                }

            }
        }

        #endregion

        #region Minutes

        protected void lbtnAddMinutes_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openMinutesModal();", true);
            lblErroMsgForMinutes.Visible = false;
            divEntryForMinutes.Visible = true;
            txtTimeForMinutes.Text = "";
            txtDescr1Minutes.Text = "";
            txtDescr2Minutes.Text = "";
            txtDescr3Minutes.Text = "";
            txtPriorityMinutes.Text = "0";
            chkMinutes.Checked = false;
            txtTimeForMinutes.Focus();

            lblNoLogForMinutes.Visible = false;
            lblNoAdminForMinutes.Visible = false;
            lblNoAdminComForMinutes.Visible = false;
            lblNoAdminActGForMinutes.Visible = false;
        }

        protected void CustValMinutes_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkMinutes.Checked;

        }

        protected void btnSubmitForMinutes_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (IsValid)
                {
                    using (con)
                    {
                        string query = "MeetingMinutes_Ins_Modal";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@AssoId", SqlDbType.Int).Value = _assoId;
                        cmd.Parameters.Add("@MeetingId", SqlDbType.Int).Value = _meetingId;
                        cmd.Parameters.Add("@Time", SqlDbType.NVarChar, 20).Value = txtTimeForMinutes.Text;
                        cmd.Parameters.Add("@Descr1", SqlDbType.NVarChar, 500).Value = txtDescr1Minutes.Text;
                        cmd.Parameters.Add("@Descr2", SqlDbType.NVarChar, 500).Value = txtDescr2Minutes.Text;
                        cmd.Parameters.Add("@Descr2", SqlDbType.NVarChar, 500).Value = txtDescr3Minutes.Text;

                        cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityMinutes.Text;
                        cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblErroMsgForMinutes.Visible = false;

                            ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeMinutesModal();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForMinutes();", true);
                            RepMinutes.DataBind();

                        }
                        catch (Exception ex)
                        {
                            lblErroMsgForMinutes.Text = ex.ToString();

                            lblErroMsgForMinutes.Visible = true;
                        }


                    }
                }

            }
            else
            {
                lblNoLogForMinutes.Visible = true;
            }
        }

        protected void lbtnEditMinutes_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openMinutesModalForEdit();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnMinutesId = (HiddenField)item.FindControl("hdnMinutesId");
            HiddenField _hdnPriority = (HiddenField)item.FindControl("hdnPriority");
            Label _lblTime = (Label)item.FindControl("lblTime");
            Label _lblDescr1 = (Label)item.FindControl("lblDescr1");
            Label _lblDescr2 = (Label)item.FindControl("lblDescr2");
            Label _lblDescr3 = (Label)item.FindControl("lblDescr3");

            hdnPixel.Value = _hdnMinutesId.Value;
            txtTimeForMinutesForEdit.Text = _lblTime.Text;
            txtDescr1MinutesForEdit.Text = _lblDescr1.Text;
            txtDescr2MinutesForEdit.Text = _lblDescr2.Text;
            txtDescr3MinutesForEdit.Text = _lblDescr3.Text;

            txtPriorityMinutesForEdit.Text = _hdnPriority.Value;
            chkMinutesForEdit.Checked = false;
        }

        protected void lbtnRemoveMinutes_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openMinutesModalForRemove();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnMinutesId = (HiddenField)item.FindControl("hdnMinutesId");
            hdnPixel.Value = _hdnMinutesId.Value;
        }
       
        protected void CustValMinutesForEdit_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkMinutesForEdit.Checked;

        }

        protected void btnSubmitForMinutesForEdit_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (IsValid)
                {
                    using (con)
                    {
                        string query = "MeetingMinutes_Upd_Modal";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                        cmd.Parameters.Add("@Time", SqlDbType.NVarChar, 50).Value = txtTimeForMinutesForEdit.Text;
                        cmd.Parameters.Add("@Descr1", SqlDbType.NVarChar, 500).Value = txtDescr1MinutesForEdit.Text;
                        cmd.Parameters.Add("@Descr2", SqlDbType.NVarChar, 500).Value = txtDescr2MinutesForEdit.Text;
                        cmd.Parameters.Add("@Descr3", SqlDbType.NVarChar, 500).Value = txtDescr3MinutesForEdit.Text;

                        cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityMinutesForEdit.Text;
                        cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblErroMsgForMinutesForEdit.Visible = false;

                            ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeMinutesModalForEdit();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForMinutesForEdit();", true);
                            RepMinutes.DataBind();

                        }
                        catch (Exception ex)
                        {
                            // lblErroMsgForMinutes.Text = ex.ToString();

                            lblErroMsgForMinutesForEdit.Visible = true;
                        }


                    }
                }

            }
            else
            {
                lblNoLogForMinutesForEdit.Visible = true;
            }
        }

        protected void lbtnSubmitForMinutesForRemove_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (con)
                {
                    string query = "MeetingMinutes_Remove_Modal";
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
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeMinutesModalForRemove();", true);
                        RepMinutes.DataBind();

                    }
                    catch (Exception ex)
                    {

                    }

                }

            }
        }

        protected void lbtnReincludeMinutes_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (con)
                {
                    string query = "MeetingMinutes_Reinclude_Modal";
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
                        RepMinutes.DataBind();

                    }
                    catch (Exception ex)
                    {

                    }

                }

            }
        }

        #endregion

        #region Decisions
        protected void lbtnAddDecisions_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openDecisionsModal();", true);

            divEntryForDecisions.Visible = true;
            lblErroMsgForDecisions.Visible = false;
            txtTitleForDecisions.Text = "";
            txtDescr1Decisions.Text = "";
            txtDescr2Decisions.Text = "";
            txtPriorityAgenda.Text = "0";
            chkDecisions.Checked = false;
            txtTitleForDecisions.Focus();

            lblNoLogForDecisions.Visible = false;
            lblNoAdminForDecisions.Visible = false;
            lblNoAdminComForDecisions.Visible = false;
            lblNoAdminActGForDecisions.Visible = false;
        }

        protected void CustValDecisions_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkDecisions.Checked;

        }

        protected void btnSubmitForDecisions_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (IsValid)
                {
                    using (con)
                    {
                        string query = "MeetingDecisions_Ins_Modal";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@AssoId", SqlDbType.Int).Value = _assoId;
                        cmd.Parameters.Add("@MeetingId", SqlDbType.Int).Value = _meetingId;
                        cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 50).Value = txtTitleForDecisions.Text;
                        cmd.Parameters.Add("@Descr1", SqlDbType.NVarChar, 500).Value = txtDescr1Decisions.Text;
                        cmd.Parameters.Add("@Descr2", SqlDbType.NVarChar, 500).Value = txtDescr2Decisions.Text;
                        cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityDecisions.Text;
                        cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblErroMsgForDecisions.Visible = false;

                            ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeDecisionsModal();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForDecisions();", true);
                            RepDecisions.DataBind();

                        }
                        catch (Exception ex)
                        {
                            //lblErroMsgForDecisions.Text = ex.ToString();

                            lblErroMsgForDecisions.Visible = true;
                        }


                    }
                }

            }
            else
            {
                lblNoLogForDecisions.Visible = true;
            }
        }

        protected void lbtnEditDecisions_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openDecisionsModalForEdit();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnDecisionsId = (HiddenField)item.FindControl("hdnDecisionsId");
            HiddenField _hdnPriority = (HiddenField)item.FindControl("hdnPriority");
            Label _lblTitle = (Label)item.FindControl("lblTitle");
            Label _lblDescr1 = (Label)item.FindControl("lblDescr1");
            Label _lblDescr2 = (Label)item.FindControl("lblDescr2");

            hdnPixel.Value = _hdnDecisionsId.Value;
            txtTitleForDecisionsForEdit.Text = _lblTitle.Text;
            txtDescr1DecisionsForEdit.Text = _lblDescr1.Text;
            txtDescr2DecisionsForEdit.Text = _lblDescr2.Text;
            txtPriorityDecisionsForEdit.Text = _hdnPriority.Value;
            chkDecisionsForEdit.Checked = false;
        }

        protected void lbtnRemoveDecisions_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openDecisionsModalForRemove();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnDecisionsId = (HiddenField)item.FindControl("hdnDecisionsId");
            hdnPixel.Value = _hdnDecisionsId.Value;
        }

        protected void CustValDecisionsForEdit_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkDecisionsForEdit.Checked;

        }

        protected void btnSubmitForDecisionsForEdit_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (IsValid)
                {
                    using (con)
                    {
                        string query = "MeetingDecisions_Upd_Modal";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                        cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 50).Value = txtTitleForDecisionsForEdit.Text;
                        cmd.Parameters.Add("@Descr1", SqlDbType.NVarChar, 500).Value = txtDescr1DecisionsForEdit.Text;
                        cmd.Parameters.Add("@Descr2", SqlDbType.NVarChar, 500).Value = txtDescr2DecisionsForEdit.Text;
                        cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityDecisionsForEdit.Text;
                        cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblErroMsgForDecisionsForEdit.Visible = false;

                            ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeDecisionsModalForEdit();", true);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForDecisionsForEdit();", true);
                            RepDecisions.DataBind();

                        }
                        catch (Exception ex)
                        {
                            // lblErroMsgForDecisions.Text = ex.ToString();

                            lblErroMsgForDecisionsForEdit.Visible = true;
                        }


                    }
                }

            }
            else
            {
                lblNoLogForDecisionsForEdit.Visible = true;
            }
        }

        protected void lbtnSubmitForDecisionsForRemove_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (con)
                {
                    string query = "MeetingDecisions_Remove_Modal";
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
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeDecisionsModalForRemove();", true);
                        RepDecisions.DataBind();

                    }
                    catch (Exception ex)
                    {

                    }

                }

            }
        }

        protected void lbtnReincludeDecisions_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (con)
                {
                    string query = "MeetingDecisions_Reinclude_Modal";
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
                        RepDecisions.DataBind();

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