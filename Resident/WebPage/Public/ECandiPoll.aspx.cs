using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class ECandiPoll : System.Web.UI.Page
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
                if (MyCheckBoxList.Items.Count == 0)
                {
                    MyCheckBoxList.Items.Add("one");
                    MyCheckBoxList.Items.Add("two");
                    MyCheckBoxList.Items.Add("three");
                    MyCheckBoxList.Items.Add("four");
                    MyCheckBoxList.Items.Add("five");
                }
            }
        }

        protected void RepPost_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                string _postId = (e.Item.FindControl("hdnPostId") as HiddenField).Value;
                Repeater RepECandi = e.Item.FindControl("RepECandi") as Repeater;
                RepECandi.DataSource = GetData(string.Format("SELECT " +
                    "                                                   Id, Name, Age " +
                    "                                             FROM " +
                    "                                                   ECandi " +
                    "                                             WHERE " +
                    "                                                   IsDel=0 AND ElecId='{0}' AND PostId='{1}' ", ddlElec.SelectedValue, _postId));
                RepECandi.DataBind();

               


            }
        }

        protected void RepECandi_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {


                LinkButton lbtnSubmitPoll = e.Item.FindControl("lbtnSubmitPoll") as LinkButton;

                con.Open();
                string query = "SELECT COUNT(*) FROM ECandiPoll WHERE ElecId=2 AND PostId=4 AND PFCId=1 AND NameOfUser='Dk_Singh'";

                SqlCommand cmdcheck = new SqlCommand(query, con);
                int _uservoteExist = (int)cmdcheck.ExecuteScalar();
                if (_uservoteExist != 0)
                {
                    lbtnSubmitPoll.Text = "Inactive";
                }
                else
                {
                    lbtnSubmitPoll.Text = "Active";

                }
                con.Close();

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


        protected void ddlElec_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlElec.SelectedIndex > 0)
            {
                RepPost.Visible = true;
            }
            else
            {
                RepPost.Visible = false;

            }
        }

        protected void lbtnSubmitPoll_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openConfirmPollModal();", true);
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem itemChield = (RepeaterItem)lbtn.Parent;
            RepeaterItem itemParent = (RepeaterItem)lbtn.Parent.Parent.Parent;

            HiddenField hdnCandiId = (HiddenField)itemChield.FindControl("hdnCandiId");
            HiddenField hdnPostId = (HiddenField)itemParent.FindControl("hdnPostId");

            hdnPixelPoll.Value = hdnCandiId.Value;
            hdnPixelPost.Value = hdnPostId.Value;

            lblX.Text = "hdnPixelPoll=" + hdnPixelPoll.Value + ", hdnPixelPost=" + hdnPixelPost.Value;

        }
        protected void btnSubmitPollConfirm_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (con)
                {
                    string query = "ECandiPoll_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = _complexId;
                    cmd.Parameters.Add("@ElecId", SqlDbType.Int).Value = ddlElec.SelectedValue;
                    cmd.Parameters.Add("@PostId", SqlDbType.Int).Value = hdnPixelPost.Value;
                    cmd.Parameters.Add("@ECandiId", SqlDbType.Int).Value = hdnPixelPoll.Value;
                    cmd.Parameters.Add("@PFCId", SqlDbType.Int).Value = 1;

                    cmd.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 250).Value = "Dk_Singh";
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        // ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertMsgForVote();", true);
                        ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeConfirmPollModal();", true);
                        // RepHelp.DataBind();
                    }
                    catch (Exception ex)
                    {

                        //lblErroMsgHelpReply.Text = ex.ToString();
                        //lblErroMsgHelpReply.Visible = true;
                    }


                }
            }
        }

        protected void MyCheckBoxList_SelectedIndexChanged(object sender, EventArgs e)
        {
            int a = MyCheckBoxList.Items.Count;
            int count = 0;
            for (int i = 0; i < a; i++)
            {
                if (MyCheckBoxList.Items[i].Selected == true)
                    count++;
            }
            if (count > 2)
            {
                for (int i = 0; i < a; i++)
                {
                    if (MyCheckBoxList.Items[i].Selected == true)
                    {
                        MyCheckBoxList.Items[i].Selected = false;
                       // break;
                    }
                    else
                    {
                        MyCheckBoxList.Items[i].Selected = true;

                    }
                }
            }
        }
    }
}