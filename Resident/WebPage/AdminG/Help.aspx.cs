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
    public partial class Help : System.Web.UI.Page
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

            //if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            //{
            _user = User.Identity.Name;
            if (!IsPostBack)
            {

            }
            //  }
           // btnSubmitHelpReply.OnClientClick = ClientScript.GetPostBackEventReference(btnSubmitHelpReply, "") + ";this.value='Submitting...';this.disabled=true;";

            System.Threading.Thread.Sleep(1000);
        }

        #region Help Insert
        protected void btnSubmitHelpIns_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "Help_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = _complexId;
                    cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = txtTitleForHelpIns.Text;
                    cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrForHelpIns.Text;
                    cmd.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgHelpIns.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForHelpIns();", true);
                        RepHelp.DataBind();
                        resetHelpInsData();
                    }
                    catch (Exception ex)
                    {
                        resetHelpInsData();
                        lblErroMsgHelpIns.Text = ex.ToString();
                        lblErroMsgHelpIns.Visible = true;
                    }


                }
            }
        }

        private void resetHelpInsData()
        {
            txtTitleForHelpIns.Text = string.Empty;
            txtDescrForHelpIns.Text = string.Empty;
            chkHelpIns.Checked = false;
            txtTitleForHelpIns.Focus();
        }

        protected void btnCancelHelpIns_Click(object sender, EventArgs e)
        {
            resetHelpInsData();
        }

        protected void custValHelpIns_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkHelpIns.Checked;
        }

        #endregion

        #region Help Reply
        protected void lbtnReplyHelp_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openReplyHelpModal();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnHelpId = (HiddenField)item.FindControl("hdnHelpId");
            hdnHelpPixel.Value = _hdnHelpId.Value;
            txtDescrForHelpReply.Text = string.Empty;
            txtDescrForHelpReply.Focus();
            chkHelpReply.Checked = false;
        }

        protected void custValHelpReply_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkHelpReply.Checked;
        }

        protected void btnSubmitHelpReply_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "HelpReply_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@HelpId", SqlDbType.Int).Value = hdnHelpPixel.Value;
                    cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrForHelpReply.Text;
                    cmd.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgHelpReply.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForHelpReply();", true);
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeReplyHelpModal();", true);
                        RepHelp.DataBind();
                    }
                    catch (Exception ex)
                    {

                        lblErroMsgHelpReply.Text = ex.ToString();
                        lblErroMsgHelpReply.Visible = true;
                    }


                }
            }
        }

        #endregion


        #region Help Edit
        protected void lbtnEditHelp_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openEditHelpModal();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnHelpId = (HiddenField)item.FindControl("hdnHelpId");
            Label _lblTitle = (Label)item.FindControl("lblTitle");
            Label _lblDescr = (Label)item.FindControl("lblDescr");
            hdnHelpPixel.Value = _hdnHelpId.Value;
            txtTitleForHelpUpd.Text = _lblTitle.Text;
            txtDescrForHelpUpd.Text = _lblDescr.Text;
            chkHelpUpd.Checked = false;
        }

        protected void custValHelpUpd_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkHelpUpd.Checked;

        }

        protected void btnSubmitHelpUpd_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "Help_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnHelpPixel.Value;
                    cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = txtTitleForHelpUpd.Text;
                    cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrForHelpUpd.Text;
                    cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgHelpUpd.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForHelpUpd();", true);
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeEditHelpModal();", true);

                        RepHelp.DataBind();
                    }
                    catch (Exception ex)
                    {
                      
                        lblErroMsgHelpUpd.Text = ex.ToString();
                        lblErroMsgHelpUpd.Visible = true;
                    }


                }
            }
        }
        #endregion

        #region Help Resolve
        protected void lbtnResolveHelp_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openResolveHelpModal();", true);

            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnHelpId = (HiddenField)item.FindControl("hdnHelpId");
            hdnHelpPixel.Value = _hdnHelpId.Value;
        }

        protected void lbtnSubmitHelpForResolve_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "Help_Remove";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnHelpPixel.Value;
                cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                //try
                //{
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeResolveHelpModal();", true);
                RepHelp.DataBind();
            }
            #endregion
        }

        protected void RepHelp_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string _hdnHelpId = (e.Item.FindControl("hdnHelpId") as HiddenField).Value;
                Repeater RepReply = e.Item.FindControl("RepReply") as Repeater;
                RepReply.DataSource = GetData(string.Format("SELECT " +
                    "                                                   Id, HelpId, Descr, CrDt " +
                    "                                             FROM " +
                    "                                                   HelpReply " +
                    "                                             WHERE " +
                    "                                                   IsDel=0 AND HelpId='{0}' ", _hdnHelpId));
                RepReply.DataBind();
            }
        }

        

        private static DataTable GetData(string query)
        {
            string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = query;
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataSet ds = new DataSet())
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }

        protected void lbtnX_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "HelpReply_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@HelpId", SqlDbType.Int).Value = hdnHelpPixel.Value;
                    cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrForHelpReply.Text;
                    cmd.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgHelpReply.Visible = false;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForHelpReply();", true);
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeReplyHelpModal();", true);
                        RepHelp.DataBind();
                    }
                    catch (Exception ex)
                    {

                        lblErroMsgHelpReply.Text = ex.ToString();
                        lblErroMsgHelpReply.Visible = true;
                    }


                }
            }
        }
    }
}