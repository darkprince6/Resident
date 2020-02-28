using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.AdminG
{
    public partial class Ruler : System.Web.UI.Page
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

            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                _user = User.Identity.Name;
                _complexId = int.Parse(Request.QueryString["ComplexId"]);
                if (!IsPostBack)
                {
                }
            }

        }

        protected void CustValRules_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkRules.Checked;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            //  {
            if (IsValid)
            {
                using (con)
                {
                    string query = "Rules_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = _complexId;
                    cmd.Parameters.Add("@AssoId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@RulerCatId", SqlDbType.Int).Value = ddlRulesCat.SelectedValue; 
                    cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = txtTitle.Text;

                    if (!string.IsNullOrWhiteSpace(txtDescr.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 150).Value = txtDescr.Text;
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
                        lblErroMsg.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForRules();", true);
                        RepRules.DataBind();
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

            //}
            //else
            //{
            //    lblNoLog.Visible = true;
            //}
        }

        private void resetData()
        {
            txtTitle.Text = string.Empty;
            txtDescr.Text = string.Empty;
            txtTitle.Focus();
            btnSubmit.Visible = true;
            btnUpdate.Visible = false;
            chkRules.Checked = false;
            ddlRulesCat.Enabled = true;

        }

        protected void lbtnEdit_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnRulesId = (HiddenField)item.FindControl("hdnRulesId");
            Label _lblTitle = (Label)item.FindControl("lblTitle");
            Label _lblDescr = (Label)item.FindControl("lblDescr");
            HiddenField _hdnRulerCatId = (HiddenField)item.FindControl("hdnRulerCatId");
            hdnPixel.Value = _hdnRulesId.Value;
            txtTitle.Text = _lblTitle.Text;
            txtDescr.Text = _lblDescr.Text;
            ddlRulesCat.SelectedValue = _hdnRulerCatId.Value;
            txtTitle.Focus();
            ddlRulesCat.Enabled = false;
            chkRules.Checked = false;
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;

        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            //  {
            if (IsValid)
            {
                using (con)
                {
                    string query = "Rules_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;

                    cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = txtTitle.Text;
                    if (!string.IsNullOrWhiteSpace(txtDescr.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 150).Value = txtDescr.Text;
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
                        lblErroMsg.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForRulesUpd();", true);
                        RepRules.DataBind();
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

            //}
            //else
            //{
            //    lblNoLog.Visible = true;
            //}
        }

        protected void lbtnSubmitForRemove_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            using (con)
            {
                string query = "Rules_Remove";
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
                    RepRules.DataBind();

                }
                catch (Exception ex)
                {

                }

            }

            // }
        }

        protected void lbtnRemove_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForRemove();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnRulesId = (HiddenField)item.FindControl("hdnRulesId");
            hdnPixel.Value = _hdnRulesId.Value;
        }

        protected void lbtnReinclude_Click(object sender, EventArgs e)
        {
            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            // {
            using (con)
            {
                string query = "Rules_Reinclude";
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
                    RepRules.DataBind();

                }
                catch (Exception ex)
                {

                }

            }

            // }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            resetData();
        }
    }
}