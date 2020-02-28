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
    public partial class Amenities : System.Web.UI.Page
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

        protected void CustvalAmenities_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkAmenities.Checked;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "Amenities_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = txtTitle.Text;
                    if (!string.IsNullOrWhiteSpace(txtDescr.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescr.Text;
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
                        lblErroMsg.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForAmenities();", true);
                        RepAmenities.DataBind();
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
            txtTitle.Text = string.Empty;
            txtDescr.Text = string.Empty;
            chkAmenities.Checked = false;
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
            txtTitle.Focus();
        }
        protected void lbtnEdit_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnAmenitiesId = (HiddenField)item.FindControl("hdnAmenitiesId");
            Label _lblTitle = (Label)item.FindControl("lblTitle");
            Label _lblDescr = (Label)item.FindControl("lblDescr");

            hdnPixel.Value = _hdnAmenitiesId.Value;
            txtTitle.Text = _lblTitle.Text;
            txtDescr.Text = _lblDescr.Text;
            txtTitle.Focus();

            chkAmenities.Checked = false;
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "Amenities_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                    cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = txtTitle.Text;
                    if (!string.IsNullOrWhiteSpace(txtDescr.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescr.Text;
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
                        lblErroMsg.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForAmenitiesUpd();", true);
                        RepAmenities.DataBind();
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

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            resetData();
        }


        protected void lbtnRemove_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForRemove();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnAmenitiesId = (HiddenField)item.FindControl("hdnAmenitiesId");
            hdnPixel.Value = _hdnAmenitiesId.Value;
        }

        protected void lbtnSubmitForRemove_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "Amenities_Remove";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                //try
                //{
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForRemove();", true);
                    RepAmenities.DataBind();
                //}
                //catch (Exception ex)
                //{
                //    lblErroMsg.Visible = true;
                //    lblErroMsg.Text = ex.ToString();
                //}
            }
        }

        protected void lbtnReinclude_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnAmenitiesId = (HiddenField)item.FindControl("hdnAmenitiesId");
            hdnPixel.Value = _hdnAmenitiesId.Value;
            using (con)
            {
                string query = "Amenities_Reinclude";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                //try
                //{
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    RepAmenities.DataBind();
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