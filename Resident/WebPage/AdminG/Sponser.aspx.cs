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
    public partial class Sponser : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["EveCon"].ConnectionString;
        SqlConnection con = new SqlConnection();

        string _ip=string.Empty;
        string _user=string.Empty;
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
                _eventId = int.Parse(Request.QueryString["EventId"]);

                if (!IsPostBack)
                {
                }
          //  }

        }

        protected void CustvalSponser_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkSponser.Checked;
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "Sponsers_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@EId", SqlDbType.Int).Value = _eventId;
                    cmd.Parameters.Add("@ESId", SqlDbType.Int).Value = "1";
                    cmd.Parameters.Add("@ESCatId", SqlDbType.Int).Value =ddlSponserCat.SelectedValue;

                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtName.Text;
                    cmd.Parameters.Add("@BrandName", SqlDbType.NVarChar, 150).Value = txtBrandName.Text;
                    cmd.Parameters.Add("@Address1", SqlDbType.NVarChar, 250).Value = txtAddress1.Text;
                    if (!string.IsNullOrWhiteSpace(txtPhone1.Text))
                    {
                        cmd.Parameters.Add("@Phone1", SqlDbType.NVarChar, 50).Value = txtPhone1.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone1", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtMobile1.Text))
                    {
                        cmd.Parameters.Add("@Mobile1", SqlDbType.NVarChar, 50).Value = txtMobile1.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Mobile1", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtWebLink1.Text))
                    {
                        cmd.Parameters.Add("@WebLink1", SqlDbType.NVarChar, 150).Value = txtWebLink1.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@WebLink1", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                    }

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
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForSponser();", true);
                        RepSponser.DataBind();
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
            txtName.Text = string.Empty;
            txtBrandName.Text = string.Empty;
            txtAddress1.Text = string.Empty;
            txtPhone1.Text = string.Empty;
            txtMobile1.Text = string.Empty;
            txtWebLink1.Text = string.Empty;
            txtPriority.Text = "0";
            txtName.Focus();
            chkSponser.Checked = false;
            btnUpdate.Visible = false;
            btnSubmit.Visible = true;
            ddlSponserCat.SelectedIndex = -1;

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            resetData();
        }

        protected void lbtnEdit_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnSponserId = (HiddenField)item.FindControl("hdnSponserId");
            HiddenField _hdnSponserCatId = (HiddenField)item.FindControl("hdnSponserCatId");

            Label _lblName = (Label)item.FindControl("lblName");
            Label _lblBrandeName = (Label)item.FindControl("lblBrandeName");
            Label _lblAddress1 = (Label)item.FindControl("lblAddress1");
            Label _lblPhone1 = (Label)item.FindControl("lblPhone1");
            Label _lblMobile1 = (Label)item.FindControl("lblMobile1");
            Label _lblWeblink1 = (Label)item.FindControl("lblWeblink1");
            Label _lblPriority = (Label)item.FindControl("lblPriority");

            hdnPixel.Value = _hdnSponserId.Value;
            ddlSponserCat.SelectedValue = _hdnSponserCatId.Value;
            txtName.Text = _lblName.Text;
            txtBrandName.Text = _lblBrandeName.Text;
            txtAddress1.Text = _lblAddress1.Text;
            txtPhone1.Text = _lblPhone1.Text;
            txtMobile1.Text = _lblMobile1.Text;
            txtWebLink1.Text = _lblWeblink1.Text;
            txtPriority.Text = _lblPriority.Text;
            txtName.Focus();

            chkSponser.Checked = false;
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "Sponsers_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                    cmd.Parameters.Add("@ESCatId", SqlDbType.Int).Value = ddlSponserCat.SelectedValue;

                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtName.Text;
                    cmd.Parameters.Add("@BrandName", SqlDbType.NVarChar, 150).Value = txtBrandName.Text;
                    cmd.Parameters.Add("@Address1", SqlDbType.NVarChar, 250).Value = txtAddress1.Text;
                    if (!string.IsNullOrWhiteSpace(txtPhone1.Text))
                    {
                        cmd.Parameters.Add("@Phone1", SqlDbType.NVarChar, 50).Value = txtPhone1.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone1", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtMobile1.Text))
                    {
                        cmd.Parameters.Add("@Mobile1", SqlDbType.NVarChar, 50).Value = txtMobile1.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Mobile1", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtWebLink1.Text))
                    {
                        cmd.Parameters.Add("@WebLink1", SqlDbType.NVarChar, 150).Value = txtWebLink1.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@WebLink1", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                    }

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
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForSponser();", true);
                        RepSponser.DataBind();
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

        protected void lbtnRemove_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForRemove();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnSponserId = (HiddenField)item.FindControl("hdnSponserId");
            hdnPixel.Value = _hdnSponserId.Value;
        }

        protected void lbtnSubmitForRemove_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            using (con)
            {
                string query = "Sponsers_Remove_Modal";
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
                    RepSponser.DataBind();

                }
                catch (Exception ex)
                {

                }

            }

            // }
        }

        protected void lbtnReinclude_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            using (con)
            {
                string query = "Sponsers_Reinclude_Modal";
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
                    RepSponser.DataBind();

                }
                catch (Exception ex)
                {

                }

            }

            // }
        }

        
    }
}