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
    public partial class Celebrity : System.Web.UI.Page
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
        protected void lbtnAddCeleb_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForCelebrity();", true);
           // resetCelebrityData();
          //  divCeleb.Visible = true;
        }

        protected void custValCeleb_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkCeleb.Checked;
        }

        protected void btnSubmitCeleb_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "ECelebrity_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@EId", SqlDbType.Int).Value = _eventId;
                    cmd.Parameters.Add("@ESId", SqlDbType.Int).Value = _ESId;
                    cmd.Parameters.Add("@ESubSId", SqlDbType.Int).Value = _ESId;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 100).Value = txtNameCeleb.Text;
                    cmd.Parameters.Add("@Image", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    if (!string.IsNullOrWhiteSpace(txtDescrCeleb.Text))
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrCeleb.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    }
                    cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityCeleb.Text;

                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblErroMsgCeleb.Visible = false;
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForCelebrity();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForCelebrity();", true);
                        resetCelebrityData();
                    }
                    catch (Exception ex)
                    {
                        resetCelebrityData();
                        lblErroMsgCeleb.Text = ex.ToString();
                        lblErroMsgCeleb.Visible = true;
                    }


                }
            }
        }

        private void resetCelebrityData()
        {
            txtNameCeleb.Text = string.Empty;
            txtDescrCeleb.Text = string.Empty;
            txtPriorityCeleb.Text = "0";
            txtNameCeleb.Focus();
            chkCeleb.Checked = false;
        }

        protected void btnCancelCeleb_Click(object sender, EventArgs e)
        {
            resetCelebrityData();
           // divCeleb.Visible = true;
        }

        protected void lbtnAddSubCeleb_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForCelebrity();", true);
           // resetCelebrityData();
           // divSubCeleb.Visible = true; ;
        }

        //protected void btnSubmitSubCeleb_Click(object sender, EventArgs e)
        //{
        //    if (IsValid)
        //    {
        //        using (con)
        //        {
        //            string query = "ESubCelebrity_Ins";
        //            SqlCommand cmd = new SqlCommand(query, con);
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.Add("@ESId", SqlDbType.Int).Value = _ESId;
        //            cmd.Parameters.Add("@CelibrityId", SqlDbType.Int).Value = _eventId;
        //            cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 100).Value = txtNameCeleb.Text;
        //            cmd.Parameters.Add("@Image", SqlDbType.NVarChar, 500).Value = DBNull.Value;
        //            if (!string.IsNullOrWhiteSpace(txtDescrCeleb.Text))
        //            {
        //                cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrCeleb.Text;
        //            }
        //            else
        //            {
        //                cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = DBNull.Value;
        //            }
        //            cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = txtPriorityCeleb.Text;

        //            cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
        //            cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
        //            cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
        //            try
        //            {
        //                con.Open();
        //                cmd.ExecuteNonQuery();
        //                con.Close();
        //                lblErroMsgCeleb.Visible = false;
        //                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForCelebrity();", true);
        //                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForCelebrity();", true);
        //                resetCelebrityData();
        //            }
        //            catch (Exception ex)
        //            {
        //                resetCelebrityData();
        //                lblErroMsgCeleb.Text = ex.ToString();
        //                lblErroMsgCeleb.Visible = true;
        //            }


        //        }
        //    }
        //}

        //protected void btnCancelSubCeleb_Click(object sender, EventArgs e)
        //{
        //    resetCelebrityData();
        //    divSubCeleb.Visible = true; ;
        //}
    }
}