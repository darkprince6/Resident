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
    public partial class Perormer : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        SqlConnection con = new SqlConnection();

        string _ip = string.Empty;
        string _user = string.Empty;
        int _eventId = 1;
        int _ESId = 1;
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
        protected void lbtnAddPerf_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForPerformer();", true);
           // resetPerformerData();
          //  divPerf.Visible = true;
        }

        protected void custValPerf_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkPerf.Checked;
        }

        protected void btnSubmitPerf_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "EPerformer_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@EId", SqlDbType.Int).Value = _eventId;
                    cmd.Parameters.Add("@ESId", SqlDbType.Int).Value = _ESId;
                    cmd.Parameters.Add("@ESubSId", SqlDbType.Int).Value = _ESId;
                    if (!string.IsNullOrWhiteSpace(txtCapecityPerf.Text))
                    {
                        cmd.Parameters.Add("@Capacity", SqlDbType.NVarChar, 500).Value = txtCapecityPerf.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    }
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 100).Value = txtNamePerf.Text;
                    cmd.Parameters.Add("@Image", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    if (!string.IsNullOrWhiteSpace(txtDescrPerf.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrPerf.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    }
                    cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityPerf.Text;

                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgPerf.Visible = false;
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForPerformer();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForPerformer();", true);
                        resetPerformerData();
                    }
                    catch (Exception ex)
                    {
                        resetPerformerData();
                        lblErroMsgPerf.Text = ex.ToString();
                        lblErroMsgPerf.Visible = true;
                    }


                }
            }
        }

        private void resetPerformerData()
        {
            txtCapecityPerf.Text = string.Empty;
            txtNamePerf.Text = string.Empty;
            txtDescrPerf.Text = string.Empty;
            txtPriorityPerf.Text = "0";
            txtNamePerf.Focus();
            chkPerf.Checked = false;
        }

        protected void btnCancelPerf_Click(object sender, EventArgs e)
        {
            resetPerformerData();
           // divPerf.Visible = true;
        }

        protected void lbtnAddSubPerf_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForPerformer();", true);
           // resetPerformerData();
           // divSubPerf.Visible = true; ;
        }

        //protected void btnSubmitSubPerf_Click(object sender, EventArgs e)
        //{
        //    if (IsValid)
        //    {
        //        using (con)
        //        {
        //            string query = "ESubPerformer_Ins";
        //            SqlCommand cmd = new SqlCommand(query, con);
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.Add("@ESId", SqlDbType.Int).Value = _ESId;
        //            cmd.Parameters.Add("@CelibrityId", SqlDbType.Int).Value = _eventId;
        //            cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 100).Value = txtNamePerf.Text;
        //            cmd.Parameters.Add("@Image", SqlDbType.NVarChar, 500).Value = DBNull.Value;
        //            if (!string.IsNullOrWhiteSpace(txtDescrPerf.Text))
        //            {
        //                cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrPerf.Text;
        //            }
        //            else
        //            {
        //                cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = DBNull.Value;
        //            }
        //            cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityPerf.Text;

        //            cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
        //            cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
        //            cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
        //            try
        //            {
        //                con.Open();
        //                cmd.ExecuteNonQuery();
        //                con.Close();
        //                lblErroMsgPerf.Visible = false;
        //                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForPerformer();", true);
        //                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForPerformer();", true);
        //                resetPerformerData();
        //            }
        //            catch (Exception ex)
        //            {
        //                resetPerformerData();
        //                lblErroMsgPerf.Text = ex.ToString();
        //                lblErroMsgPerf.Visible = true;
        //            }


        //        }
        //    }
        //}

        //protected void btnCancelSubPerf_Click(object sender, EventArgs e)
        //{
        //    resetPerformerData();
        //    divSubPerf.Visible = true; ;
        //}
    }
}