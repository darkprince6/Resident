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
    public partial class Visitor2 : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        SqlConnection con = new SqlConnection();

        string _ip = string.Empty;
        string _user = string.Empty;
        int _complexId = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = conStr;
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (_ip == "" || _ip == null)
                _ip = Request.ServerVariables["REMOTE_ADDR"];
            Session["NameOfUser"] = "avikmondal";
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            //{
            _user = User.Identity.Name;
            if (!IsPostBack)
            {
            }
            //  }
        }

        #region VisitorCat
        protected void custValCat_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkCat.Checked;
        }

        protected void btnSubmitCat_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "VisitorCat_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameCat.Text;
                    cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityCat.Text;
                    cmd.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgCat.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForCatIns();", true);
                        RepCat.DataBind();
                        resetCatData();
                    }
                    catch (Exception ex)
                    {
                        resetCatData();
                        lblErroMsgCat.Text = ex.ToString();
                        lblErroMsgCat.Visible = true;
                    }
                    
                }
            }
        }

        private void resetCatData()
        {
            txtNameCat.Text = string.Empty;
            txtPriorityCat.Text = string.Empty;
            chkCat.Checked = false;
            btnUpdateCat.Visible = false;
            btnSubmitCat.Visible = true;
        }

        protected void lbtnEditCat_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnCatId = (HiddenField)item.FindControl("hdnCatId");
            Label _lblName = (Label)item.FindControl("lblName");
            Label _lblPriority = (Label)item.FindControl("lblPriority");

            hdnPixelCat.Value = _hdnCatId.Value;
            txtNameCat.Text = _lblName.Text;
            txtPriorityCat.Text = _lblPriority.Text;
            txtNameCat.Focus();

            chkCat.Checked = false;
            btnSubmitCat.Visible = false;
            btnUpdateCat.Visible = true;
        }

        protected void btnUpdateCat_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "VisitorCat_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelCat.Value;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameCat.Text;
                    cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityCat.Text;
                    cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgCat.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForCatUpd();", true);
                        RepCat.DataBind();
                        resetCatData();
                    }
                    catch (Exception ex)
                    {
                        resetCatData();
                        lblErroMsgCat.Text = ex.ToString();
                        lblErroMsgCat.Visible = true;
                    }

                }
            }
        }

        protected void btnCancelCat_Click(object sender, EventArgs e)
        {
            resetCatData();
            txtNameCat.Focus();
        }

        protected void lbtnRemoveCat_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openReincludeModalForCat();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnCatId = (HiddenField)item.FindControl("hdnCatId");
            hdnPixelCat.Value = _hdnCatId.Value;
        }

        protected void lbtnSubmitCatForRemove_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "VisitorCat_Reinclude";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelCat.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                RepCat.DataBind();
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeRemoveModalForCat();", true);

            }
        }

        protected void lbtnReincludeCat_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openRemoveModalForCat();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnCatId = (HiddenField)item.FindControl("hdnCatId");
            hdnPixelCat.Value = _hdnCatId.Value;
        }

        protected void lbtnSubmitCatForReinclude_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "VisitorCat_Remove";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelCat.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeReincludeModalForCat();", true);
                RepCat.DataBind();
            }
        }
      
        #endregion

        #region Visitor

        protected void custValVisitor_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkVisitor.Checked;
        }

        protected void btnSubmitVisitor_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "Visitor_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = _complexId;
                    cmd.Parameters.Add("@CatId", SqlDbType.Int).Value = ddlVisitorCat.SelectedValue;
                    cmd.Parameters.Add("@FrequencyId", SqlDbType.Int).Value = ddlVisitorFrec.SelectedValue;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameVisitor.Text;
                    if (!string.IsNullOrWhiteSpace(txtFromDateVisitor.Text))
                    {
                        cmd.Parameters.Add("@FromDate", SqlDbType.DateTime).Value = txtFromDateVisitor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@FromDate", SqlDbType.DateTime).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtToDateVisitor.Text))
                    {
                        cmd.Parameters.Add("@ToDate", SqlDbType.DateTime).Value = txtToDateVisitor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@ToDate", SqlDbType.DateTime).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtDescrVisitor.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrVisitor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    }

                    cmd.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgVisitor.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForVisitorIns();", true);
                        RepVisitor.DataBind();
                        resetVisitorData();
                    }
                    catch (Exception ex)
                    {
                        resetVisitorData();
                        lblErroMsgVisitor.Text = ex.ToString();
                        lblErroMsgVisitor.Visible = true;
                    }

                }
            }
        }

        private void resetVisitorData()
        {
            ddlVisitorCat.SelectedIndex = -1;
            ddlVisitorFrec.SelectedIndex = -1;
            txtNameVisitor.Text = string.Empty;
            txtFromDateVisitor.Text = string.Empty;
            txtToDateVisitor.Text = string.Empty;
            txtDescrVisitor.Text = string.Empty;
            chkVisitor.Checked = false;
            btnUpdateVisitor.Visible = false;
            btnSubmitVisitor.Visible = true;
            pnlVisitorDate.Visible = false;
        }

        protected void lbtnEditVisitor_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnVisitorId = (HiddenField)item.FindControl("hdnVisitorId");
            HiddenField _hdnCatId = (HiddenField)item.FindControl("hdnCatId");
            HiddenField _hdnFrequencyId = (HiddenField)item.FindControl("hdnFrequencyId");

            Label _lblName = (Label)item.FindControl("lblName");
            HiddenField _hdnFromDate = (HiddenField)item.FindControl("hdnFromDate");
            HiddenField _hdnToDate = (HiddenField)item.FindControl("hdnToDate");
            Label _lblDescr = (Label)item.FindControl("lblDescr");

            hdnPixelVisitor.Value = _hdnVisitorId.Value;
            ddlVisitorCat.SelectedValue = _hdnCatId.Value;

            SqlVisitorFrequency.SelectParameters["CatId"].DefaultValue = _hdnCatId.Value;
            ddlVisitorFrec.DataBind();
            ddlVisitorFrec.SelectedValue = _hdnFrequencyId.Value;

            txtNameVisitor.Text = _lblName.Text;
            txtFromDateVisitor.Text = _hdnFromDate.Value;
            txtToDateVisitor.Text = _hdnToDate.Value;
            txtDescrVisitor.Text = _lblDescr.Text;

            txtNameVisitor.Focus();

            chkVisitor.Checked = false;
            btnSubmitVisitor.Visible = false;
            btnUpdateVisitor.Visible = true;

            
            if (ddlVisitorFrec.SelectedItem.Text != "One time")
            {
                pnlVisitorDate.Visible = true;
            }
            else
            {
                pnlVisitorDate.Visible = false;
                txtFromDateVisitor.Text = string.Empty;
                txtToDateVisitor.Text = string.Empty;
            }
        }

        protected void btnUpdateVisitor_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "Visitor_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelVisitor.Value;
                    cmd.Parameters.Add("@CatId", SqlDbType.Int).Value = ddlVisitorCat.SelectedValue;
                    cmd.Parameters.Add("@FrequencyId", SqlDbType.Int).Value = ddlVisitorFrec.SelectedValue;

                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameVisitor.Text;
                    
                    if (!string.IsNullOrWhiteSpace(txtFromDateVisitor.Text))
                    {
                        cmd.Parameters.Add("@FromDate", SqlDbType.DateTime).Value = txtFromDateVisitor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@FromDate", SqlDbType.DateTime).Value = DBNull.Value;
                    }
                    if (!string.IsNullOrWhiteSpace(txtToDateVisitor.Text))
                    {
                        cmd.Parameters.Add("@ToDate", SqlDbType.DateTime).Value = txtToDateVisitor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@ToDate", SqlDbType.DateTime).Value = DBNull.Value;
                    }

                    if (!string.IsNullOrWhiteSpace(txtDescrVisitor.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrVisitor.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    }

                    cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgVisitor.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForVisitorUpd();", true);
                        RepVisitor.DataBind();
                        resetVisitorData();
                    }
                    catch (Exception ex)
                    {
                        resetVisitorData();
                        lblErroMsgVisitor.Text = ex.ToString();
                        lblErroMsgVisitor.Visible = true;
                    }

                }
            }
        }

        protected void btnCancelVisitor_Click(object sender, EventArgs e)
        {
            resetVisitorData();
            txtNameVisitor.Focus();
        }

        protected void lbtnRemoveVisitor_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openRemoveModalForVisitor();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnVisitorId = (HiddenField)item.FindControl("hdnVisitorId");
            hdnPixelVisitor.Value = _hdnVisitorId.Value;
        }

        protected void lbtnSubmitVisitorForRemove_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "Visitor_Remove";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelVisitor.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                RepVisitor.DataBind();
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeRemoveModalForVisitor();", true);

            }
        }

        protected void lbtnReincludeVisitor_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openReincludeModalForVisitor();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnVisitorId = (HiddenField)item.FindControl("hdnVisitorId");
            hdnPixelVisitor.Value = _hdnVisitorId.Value;
        }

        protected void lbtnSubmitVisitorForReinclude_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "Visitor_Reinclude";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelVisitor.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeReincludeModalForVisitor();", true);
                RepVisitor.DataBind();
            }
        }

        #endregion

        protected void ddlVisitorFrec_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlVisitorFrec.SelectedIndex > 0)
            {
                if(ddlVisitorFrec.SelectedItem.Text!="One time")
                {
                    pnlVisitorDate.Visible = true;
                    txtFromDateVisitor.Text = string.Empty;
                    txtToDateVisitor.Text = string.Empty;
                }
                else
                {
                    pnlVisitorDate.Visible = false;
                    txtFromDateVisitor.Text = string.Empty;
                    txtToDateVisitor.Text = string.Empty;
                }
            }
            else
            {
                pnlVisitorDate.Visible = false;
                txtFromDateVisitor.Text = string.Empty;
                txtToDateVisitor.Text = string.Empty;
            }
        }

        protected void ddlVisitorCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlVisitorDate.Visible = false;
        }

        protected void ddlVisitorFrec_DataBound(object sender, EventArgs e)
        {
            ddlVisitorFrec.Items.Insert(0, new ListItem("--Select--", "0"));
        }

        protected void lbtnCatSelect_Click(object sender, EventArgs e)
        {

        }

        protected void lbtnFrecSelect_Click(object sender, EventArgs e)
        {

        }
    }
}