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
    public partial class Associate : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["EveCon"].ConnectionString;
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
            _eventId = int.Parse(Request.QueryString["EventId"]);

            if (!IsPostBack)
            {
            }
            //  }

        }

        #region Associate
        protected void CustvalAssoIns_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkAssociate.Checked;
        }

        protected void lbtnAssoInsSubmit_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            //{
            if (IsValid)
            {
                using (con)
                {
                    string query = "Associate_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@EId", SqlDbType.Int).Value = _eventId;
                    cmd.Parameters.Add("@EACatId", SqlDbType.Int).Value = ddlAssociateCat.SelectedValue;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameAsso.Text;
                    cmd.Parameters.Add("@BrandName", SqlDbType.NVarChar, 150).Value = txtBNameAsso.Text;
                    cmd.Parameters.Add("@Logo", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                    cmd.Parameters.Add("@Image", SqlDbType.NVarChar, 150).Value = DBNull.Value;

                    if (!string.IsNullOrWhiteSpace(txtAddressAsso.Text))
                    {
                        cmd.Parameters.Add("@Address", SqlDbType.NVarChar, 50).Value = txtAddressAsso.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Address", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtPhoneAsso.Text))
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 50).Value = txtPhoneAsso.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtMobileAsso.Text))
                    {
                        cmd.Parameters.Add("@Mobile", SqlDbType.NVarChar, 50).Value = txtMobileAsso.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Mobile", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtEmailAsso.Text))
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 50).Value = txtEmailAsso.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtWebLinkAsso.Text))
                    {
                        cmd.Parameters.Add("@WebLink", SqlDbType.NVarChar, 150).Value = txtWebLinkAsso.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@WebLink", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                    }
                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblMsgAssoIns.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForAssociateIns();", true);
                        RepAssociate.DataBind();
                        resetAssoData();
                    }
                    catch (Exception ex)
                    {
                        //resetAssoData();
                        lblMsgAssoIns.Text = ex.ToString();
                        lblMsgAssoIns.Visible = true;
                    }


                }
            }
            //  }
        }

        private void resetAssoData()
        {
            ddlAssociateCat.Enabled = true;
            ddlAssociateCat.SelectedIndex = -1;
            txtNameAsso.Text = string.Empty;
            txtBNameAsso.Text = string.Empty;
            txtAddressAsso.Text = string.Empty;
            txtPhoneAsso.Text = string.Empty;
            txtMobileAsso.Text = string.Empty;
            txtEmailAsso.Text = string.Empty;
            txtWebLinkAsso.Text = string.Empty;
            txtNameAsso.Focus();
            chkAssociate.Checked = false;
            lbtnAssoUpdSubmit.Visible = false;
            lbtnAssoInsSubmit.Visible = true;
        }

        private void bindDllAssoCat()
        {
            ddlAssociateCat.Items.Clear();
            ddlAssociateCat.DataSourceID = "SqlddlAssoCat";
            ddlAssociateCat.DataBind();
        }

        protected void lbtnEditAssociate_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnAssoId = (HiddenField)item.FindControl("hdnAssoId");
            HiddenField _hdnAssoCatId = (HiddenField)item.FindControl("hdnAssoCatId");

            Label _lblName = (Label)item.FindControl("lblName");
            Label _lblBrandName = (Label)item.FindControl("lblBrandName");
            Label _lblAddress = (Label)item.FindControl("lblAddress");
            Label _lblPhone = (Label)item.FindControl("lblPhone");
            Label _lblMobile = (Label)item.FindControl("lblMobile");
            Label _lblWeblink = (Label)item.FindControl("lblWeblink");
            Label _lblEmail = (Label)item.FindControl("lblEmail");

            hdnPixelAssociate.Value = _hdnAssoId.Value;
            ddlAssociateCat.Enabled = false;
            ddlAssociateCat.SelectedValue = _hdnAssoCatId.Value;

            txtNameAsso.Text = _lblName.Text;
            txtBNameAsso.Text = _lblBrandName.Text;
            txtAddressAsso.Text = _lblAddress.Text;
            txtPhoneAsso.Text = _lblPhone.Text;
            txtMobileAsso.Text = _lblMobile.Text;
            txtWebLinkAsso.Text = _lblWeblink.Text;
            txtEmailAsso.Text = _lblEmail.Text;
            txtNameAsso.Focus();

            chkAssociate.Checked = false;
            lbtnAssoInsSubmit.Visible = false;
            lbtnAssoUpdSubmit.Visible = true;
        }

        protected void lbtnAssoUpdSubmit_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            //{
            if (IsValid)
            {
                using (con)
                {
                    string query = "Associate_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelAssociate.Value;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameAsso.Text;
                    cmd.Parameters.Add("@BrandName", SqlDbType.NVarChar, 150).Value = txtBNameAsso.Text;
                    cmd.Parameters.Add("@Logo", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                    cmd.Parameters.Add("@Image", SqlDbType.NVarChar, 150).Value = DBNull.Value;

                    if (!string.IsNullOrWhiteSpace(txtAddressAsso.Text))
                    {
                        cmd.Parameters.Add("@Address", SqlDbType.NVarChar, 50).Value = txtAddressAsso.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Address", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtPhoneAsso.Text))
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 50).Value = txtPhoneAsso.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtMobileAsso.Text))
                    {
                        cmd.Parameters.Add("@Mobile", SqlDbType.NVarChar, 50).Value = txtMobileAsso.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Mobile", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtEmailAsso.Text))
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 50).Value = txtEmailAsso.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtWebLinkAsso.Text))
                    {
                        cmd.Parameters.Add("@WebLink", SqlDbType.NVarChar, 150).Value = txtWebLinkAsso.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@WebLink", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                    }
                    cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblMsgAssoIns.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForAssociateUpd();", true);
                        RepAssociate.DataBind();
                        resetAssoData();
                    }
                    catch (Exception ex)
                    {
                        //resetAssoData();
                        lblMsgAssoIns.Text = ex.ToString();
                        lblMsgAssoIns.Visible = true;
                    }


                }
            }
            //  }
        }

        protected void lbtnAssoCancel_Click(object sender, EventArgs e)
        {
            resetAssoData();
        }

        protected void lbtnRemoveAssociate_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForAssociateRemove();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnAssoId = (HiddenField)item.FindControl("hdnAssoId");
            hdnPixelAssociate.Value = _hdnAssoId.Value;
        }

        protected void lbtnAssoRemoveSubmit_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            using (con)
            {
                string query = "Associate_Remove";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelAssociate.Value;
                cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForAssociateRemove();", true);
                    RepAssociate.DataBind();

                }
                catch (Exception ex)
                {

                }

            }

            // }
        }

        protected void lbtnReincludeAssociate_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            using (con)
            {
                string query = "Associate_Reinclude";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelAssociate.Value;
                cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    RepAssociate.DataBind();

                }
                catch (Exception ex)
                {

                }

            }

            // }
        }
        #endregion

        #region Associate Category

        protected void lbtnAddAssoCat_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForAssoCat();", true);
            resetAssoCatData();

        }

        private void resetAssoCatData()
        {
            txtAssoCat.Text = string.Empty;
            txtCatPriority.Text = "0";
            txtAssoCat.Focus();
            chkAssoCat.Checked = false;
        }

        protected void lbtnAssoCatSubmit_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            //{
          
            if (IsValid)
            {
                using (con)
                {
                    string query = "AssociateCat_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@EId", SqlDbType.Int).Value = _eventId;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtAssoCat.Text;
                    cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtCatPriority.Text;
                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblMsgAssoCat.Visible = false;
                        RepAssoCat.DataBind();
                        resetAssoCatData();
                    }
                    catch (Exception ex)
                    {
                        //resetAssoCatData();
                        lblMsgAssoCat.Text = ex.ToString();
                        lblMsgAssoCat.Visible = true;
                    }


                }
            }
            //  }
        }

        protected void lbtnAssoCatCancel_Click(object sender, EventArgs e)
        {
            resetAssoCatData();
        }

        protected void lbtnRemoveAssoCat_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnAssoCatId = (HiddenField)item.FindControl("hdnAssoCatId");
            hdnPixelAssoCat.Value = _hdnAssoCatId.Value;
            using (con)
            {
                string query = "AssociateCat_Remove";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelAssoCat.Value;
                cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    RepAssoCat.DataBind();

                }
                catch (Exception ex) 
                {

                }

            }

            // }
        }

        protected void CustvalAssoCat_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkAssoCat.Checked;
        }

        #endregion
    }
}