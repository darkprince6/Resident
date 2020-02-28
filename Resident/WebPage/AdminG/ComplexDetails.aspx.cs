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
    public partial class ComplexDetails : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        SqlConnection con = new SqlConnection();

        string _ip = string.Empty;
        string _user = string.Empty;
        int _complexId = 0;

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
            _complexId = int.Parse(Request.QueryString["ComplexId"]);

            if (!IsPostBack)
            {
            }
            //  }

        }
        #region Image
        protected void CustValImg_ServerValidate(object source, ServerValidateEventArgs args)
        {

        }

        protected void btnImageByFileSubmit_Click(object sender, EventArgs e)
        {

        }

        protected void lbtnImageComplexRemove_Click(object sender, EventArgs e)
        {

        }

        protected void lbtnAddImage_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openImageModal();", true);
        }
        #endregion

        #region Post
        protected void lbtnAddPost_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openPOInsModal();", true);

        }

        protected void CustValPO_I_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkPO_I.Checked;
        }

        protected void CustValPO_U_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkPO_U.Checked;
        }

        protected void btnSubmitPO_I_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "ComplexPO_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = _complexId;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNamePO_I.Text;

                    cmd.Parameters.Add("@Address", SqlDbType.NVarChar, 250).Value = txtAddressPO_I.Text;
                    cmd.Parameters.Add("@PostalCode", SqlDbType.NVarChar, 10).Value = txtPostalPO_I.Text;
                    if (!string.IsNullOrWhiteSpace(txtEmailPO_I.Text))
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 50).Value = txtEmailPO_I.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtWebsitePO_I.Text))
                    {
                        cmd.Parameters.Add("@Website", SqlDbType.NVarChar, 50).Value = txtWebsitePO_I.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Website", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtPhone1PO_I.Text))
                    {
                        cmd.Parameters.Add("@Phone1", SqlDbType.NVarChar, 150).Value = txtPhone1PO_I.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone1", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtPhone2PO_I.Text))
                    {
                        cmd.Parameters.Add("@Phone2", SqlDbType.NVarChar, 150).Value = txtPhone2PO_I.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone2", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                    }
                    cmd.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErrorMsgPO_I.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForPOIns();", true);
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closePOInsModal();", true);
                        RepPostOffice.DataBind();
                        resetPO_IData();
                    }
                    catch (Exception ex)
                    {
                       // resetPO_IData();
                        lblErrorMsgPO_I.Text = ex.ToString();
                        lblErrorMsgPO_I.Visible = true;
                    }


                }
            }
        }

        private void resetPO_IData()
        {
            txtNamePO_I.Text = string.Empty;
            txtAddressPO_I.Text = string.Empty;
            txtPostalPO_I.Text = string.Empty;
            txtEmailPO_I.Text = string.Empty;
            txtWebsitePO_I.Text = string.Empty;
            txtPhone1PO_I.Text = string.Empty;
            txtPhone2PO_I.Text = string.Empty;
            txtNamePO_I.Focus();
            chkPO_I.Checked = false;


        }

        private void resetPO_UData()
        {
            hdnPixelPost.Value = string.Empty;
            txtNamePO_U.Text = string.Empty;
            txtAddressPO_U.Text = string.Empty;
            txtPostalPO_U.Text = string.Empty;
            txtEmailPO_U.Text = string.Empty;
            txtWebsitePO_U.Text = string.Empty;
            txtPhone1PO_U.Text = string.Empty;
            txtPhone2PO_U.Text = string.Empty;
            chkPO_U.Checked = false;
        }

        protected void btnCancelPO_I_Click(object sender, EventArgs e)
        {
            resetPO_IData();
        }

        protected void lbtnEditPO_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openPOUpdModal();", true);
            LinkButton _lbtn = (LinkButton)sender;
            RepeaterItem _item = (RepeaterItem)_lbtn.Parent;

            Label _lblName = (Label)_item.FindControl("lblName");
            HiddenField _hdnPostId = (HiddenField)_item.FindControl("hdnPostId");
            Label _lblAddress = (Label)_item.FindControl("lblAddress");
            Label _lblPostalCode = (Label)_item.FindControl("lblPostalCode");
            Label _lblEmail = (Label)_item.FindControl("lblEmail");
            Label _lblWebsite = (Label)_item.FindControl("lblWebsite");
            Label _lblPhone1 = (Label)_item.FindControl("lblPhone1");
            Label _lblPhone2 = (Label)_item.FindControl("lblPhone2");

            hdnPixelPost.Value = _hdnPostId.Value;
            txtNamePO_U.Text = _lblName.Text;

            txtAddressPO_U.Text = _lblAddress.Text;
            txtPostalPO_U.Text = _lblPostalCode.Text;
            txtEmailPO_U.Text = _lblEmail.Text;
            txtWebsitePO_U.Text = _lblWebsite.Text;
            txtPhone1PO_U.Text = _lblPhone1.Text;
            txtPhone2PO_U.Text = _lblPhone2.Text;

            chkPO_U.Checked = false;

        }

        protected void btnSubmitPO_U_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "ComplexPO_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelPost.Value;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNamePO_U.Text;

                    cmd.Parameters.Add("@Address", SqlDbType.NVarChar, 250).Value = txtAddressPO_U.Text;
                    cmd.Parameters.Add("@PostalCode", SqlDbType.NVarChar, 10).Value = txtPostalPO_U.Text;
                    if (!string.IsNullOrWhiteSpace(txtEmailPO_U.Text))
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 50).Value = txtEmailPO_U.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtWebsitePO_U.Text))
                    {
                        cmd.Parameters.Add("@Website", SqlDbType.NVarChar, 50).Value = txtWebsitePO_U.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Website", SqlDbType.NVarChar, 50).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtPhone1PO_U.Text))
                    {
                        cmd.Parameters.Add("@Phone1", SqlDbType.NVarChar, 150).Value = txtPhone1PO_U.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone1", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtPhone2PO_U.Text))
                    {
                        cmd.Parameters.Add("@Phone2", SqlDbType.NVarChar, 150).Value = txtPhone2PO_U.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Phone2", SqlDbType.NVarChar, 150).Value = DBNull.Value;
                    }
                    cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErrorMsgPO_U.Visible = false;
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closePOUpdModal();", true);

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForPOUpd();", true);
                        RepPostOffice.DataBind();
                        resetPO_UData();
                    }
                    catch (Exception ex)
                    {
                       // resetPO_UData();
                        lblErrorMsgPO_U.Text = ex.ToString();
                        lblErrorMsgPO_U.Visible = true;
                    }


                }
            }
        }



        #endregion

        #region PoilceStation

        #endregion

       
    }
}