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
    public partial class AssociateCat : System.Web.UI.Page
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
            _user = User.Identity.Name;
            if (!IsPostBack)
            {
            }

        }

        #region Add Category

        protected void lbtnAddCat_Click(object sender, EventArgs e)
        {
            txtCatIns.Text = "";
            chkCatIns.Checked = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForCatIns();", true);
            
        }
        protected void lbtnCatInsSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "AssociateCat_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtCatIns.Text;
                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblMsgCatIns.Visible = false;
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForCatIns();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForCatIns();", true);

                        RepCat.DataBind();
                    }
                    catch (Exception ex)
                    {
                        lblMsgCatIns.Text = ex.ToString();
                        lblMsgCatIns.Visible = true;
                    }

                }
            }
        }
        protected void CustvalCatIns_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkCatIns.Checked;
        }

        #endregion

        #region Update Category

        protected void lbtnEditCat_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForCatEdit();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnCatId = (HiddenField)item.FindControl("hdnCatId");
            Label _lblName = (Label)item.FindControl("lblName");

            hdnPixel.Value = _hdnCatId.Value;
            txtCatEdit.Text = _lblName.Text;
            chkCatEdit.Checked = false;
        }
        protected void CustvalCatEdit_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkCatEdit.Checked;
        }
        protected void lbtnCatEditSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "AssociateCat_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixel.Value;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtCatEdit.Text;
                    cmd.Parameters.Add("@ModBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblMsgCatEdit.Visible = false;
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForCatEdit();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForCatUpd();", true);
                        RepCat.DataBind();
                    }
                    catch (Exception ex)
                    {
                        lblMsgCatEdit.Text = ex.ToString();
                        lblMsgCatEdit.Visible = true;
                    }

                }
            }
        }

        #endregion


        #region Remove/Reinclude

        protected void lbtnRemoveCat_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForCatRemove();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnCatId = (HiddenField)item.FindControl("hdnCatId");
            hdnPixel.Value = _hdnCatId.Value;
        }
        protected void lbtnCatRemoveSubmit_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "AssociateCat_Remove";
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModalForCatRemove();", true);
                    RepCat.DataBind();

                }
                catch (Exception ex)
                {

                }
            }
        }
        protected void lbtnReincludeCat_Click(object sender, EventArgs e)
        {
            using (con)
            {
                string query = "AssociateCat_Reinclude";
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
                    RepCat.DataBind();
                }
                catch (Exception ex)
                {

                }
            }
        }

        #endregion

    }
}