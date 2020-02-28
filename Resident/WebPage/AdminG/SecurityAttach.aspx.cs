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
    public partial class SecurityAttach : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        SqlConnection con = new SqlConnection();

        string _ip = string.Empty;
        string _user = string.Empty;
        int _complexId = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = conStr;
            Session["NameOfUser"] = "Dk_Singh";
            _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (_ip == "" || _ip == null)
                _ip = Request.ServerVariables["REMOTE_ADDR"];
            if (!IsPostBack)
            {
                RepPost.DataSourceID = "SqlRepPost";
                RepPost.DataBind();

                RepApproveStaff.DataSourceID = "SqlRepApproveStaff";
                RepApproveStaff.DataBind();
            }
        }

        #region Check Staff
        protected void RepPost_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string _postId = (e.Item.FindControl("hdnPostId") as HiddenField).Value;
                Repeater RepStaff = e.Item.FindControl("RepStaff") as Repeater;

                RepStaff.DataSource = GetData(string.Format("SELECT " +
                   "                                                   Id, PostId, Name, Image1, CrDt, IsAppr, IsSend" +
                   "                                             FROM " +
                   "                                                   MaintStaff " +
                   "                                             WHERE " +
                   "                                                   PostId='{0}'AND IsDel=0 ORDER BY Priority", _postId));

                RepStaff.DataBind();

                if (RepStaff.Items.Count == 0)
                {
                    RepStaff.Visible = false;
                    Panel pnlStaffNotFound = e.Item.FindControl("pnlStaffNotFound") as Panel;
                    pnlStaffNotFound.Visible = true;
                }
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


        protected void lbtnStaffCheck_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnStaffId = (HiddenField)item.FindControl("hdnStaffId");
            HiddenField _hdnPostId = (HiddenField)item.FindControl("hdnPostId");

            hdnPixel.Value = _hdnStaffId.Value;
            hdnPixelPost.Value = _hdnPostId.Value;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openStaffCheckModal();", true);

        }

        protected void btnCheckSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "MaintStaffAttach_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = _complexId;
                    cmd.Parameters.Add("@StaffId", SqlDbType.Int).Value = hdnPixel.Value;
                    cmd.Parameters.Add("@PostId", SqlDbType.Int).Value = hdnPixelPost.Value;
                    cmd.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        RepPost.DataBind();
                        RepApproveStaff.DataBind();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForStaffCheck();", true);
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal", "closeStaffCheckModal();", true);

                    }
                    catch (Exception ex)
                    {

                    }

                }
            }
        }
        #endregion

        #region Approve Staff

        protected void lbtnApprove_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnStaffId = (HiddenField)item.FindControl("hdnStaffId");
            hdnPixelApprove.Value = _hdnStaffId.Value;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openStaffApproveModal();", true);
        }

        protected void lbtnDecline_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnStaffId = (HiddenField)item.FindControl("hdnStaffId");
            hdnPixelApprove.Value = _hdnStaffId.Value;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openStaffDeclineModal();", true);
        }

        protected void btnApproveSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "MaintStaff_Approve_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelApprove.Value;
                    cmd.Parameters.Add("@IsAppr", SqlDbType.Bit).Value = 1;
                    cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@ModByUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        RepApproveStaff.DataBind();
                        RepPost.DataBind();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForStaffApprove();", true);
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal", "closeStaffApproveModal();", true);

                    }
                    catch (Exception ex)
                    {

                    }

                }
            }
        }

        protected void btnDeclineSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "MaintStaff_Approve_Upd";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = hdnPixelApprove.Value;
                    cmd.Parameters.Add("@IsAppr", SqlDbType.Bit).Value = 0;
                    cmd.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@ModByUser", SqlDbType.NVarChar, 150).Value = Session["NameOfUser"];
                    cmd.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@ModByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    //try
                    //{
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    RepApproveStaff.DataBind();
                    RepPost.DataBind();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForStaffDecline();", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal", "closeStaffDeclineModal();", true);

                    //}
                    //catch (Exception ex)
                    //{

                    //}

                }
            }
        }

        #endregion
    }
}