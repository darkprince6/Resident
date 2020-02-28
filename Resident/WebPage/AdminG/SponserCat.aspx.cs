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
    public partial class SponserCat : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["EveCon"].ConnectionString;
        SqlConnection con = new SqlConnection();

        string _ip = string.Empty;
        string _user = string.Empty;
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
                if (!IsPostBack)
                {
                }
            }

        }

        protected void CustvalSponserCat_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkSponserCat.Checked;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "SponserCat_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@EId", SqlDbType.Int).Value = "1";
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtName.Text;
                    cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriority.Text;
                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsg.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForSponserCat();", true);
                        RepSponserCat.DataBind();
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
            chkSponserCat.Checked = false;

            txtName.Text = string.Empty;
            txtPriority.Text = "0";
            txtName.Focus();
            lblErroMsg.Visible = false;
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
        }

        protected void lbtnEdit_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnSponserCatId = (HiddenField)item.FindControl("hdnSponserCatId");
            Label _lblName = (Label)item.FindControl("lblName");
            Label _lblPriority = (Label)item.FindControl("lblPriority");
            hdnPixel.Value = _hdnSponserCatId.Value;
            txtName.Text = _lblName.Text;
            txtPriority.Text = _lblPriority.Text;
            txtName.Focus();
            chkSponserCat.Checked = false;
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "SponserCat_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtName.Text;
                    cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriority.Text;
                    cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsg.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForSponserCat();", true);
                        RepSponserCat.DataBind();
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
            HiddenField _hdnSponserCatId = (HiddenField)item.FindControl("hdnSponserCatId");
            hdnPixel.Value = _hdnSponserCatId.Value;
        }

        protected void lbtnReinclude_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            using (con)
            {
                string query = "SponserCat_Reinclude_Modal";
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForRemove();", true);
                    RepSponserCat.DataBind();

                }
                catch (Exception ex)
                {

                }

            }

            // }
        }

        protected void lbtnSubmitForRemove_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            using (con)
            {
                string query = "SponserCat_Remove_Modal";
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForRemove();", true);
                    RepSponserCat.DataBind();

                }
                catch (Exception ex)
                {

                }

            }

            // }
        }
    }
}