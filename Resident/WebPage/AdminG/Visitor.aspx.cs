using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.AdminG
{
    public partial class Visitor : System.Web.UI.Page
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
                RepVisitor.DataSource = GetVisitorData(1);
                RepVisitor.DataBind();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "removeButton()", true);
            }
            //  }
        }

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
                    cmd.Parameters.Add("@CatId", SqlDbType.Int).Value = hdnVisitorCatId.Value;
                    cmd.Parameters.Add("@FrequencyId", SqlDbType.Int).Value = hdnVisitorFId.Value;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtNameVisitor.Text;
                    cmd.Parameters.Add("@TotalNumber", SqlDbType.Int).Value = txtTotalVisitor.Text;

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
                    cmd.Parameters.Add("@Image1", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    cmd.Parameters.Add("@Image2", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    cmd.Parameters.Add("@Image3", SqlDbType.NVarChar, 500).Value = DBNull.Value;

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
                        divFrequency.Visible = false;
                        divEntry.Visible = false;
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
            //hdnVisitorFId.Value = string.Empty;
            //hdnVisitorFId.Value = string.Empty;
            txtNameVisitor.Text = string.Empty;
            txtFromDateVisitor.Text = string.Empty;
            txtToDateVisitor.Text = string.Empty;
            txtDescrVisitor.Text = string.Empty;
            txtTotalVisitor.Text = "1";
            chkVisitor.Checked = false;
            pnlVisitorDate.Visible = false;
        }

        protected void btnCancelVisitor_Click(object sender, EventArgs e)
        {
            resetVisitorData();
            txtNameVisitor.Focus();
        }

        protected void lbtnCatSelect_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnCatId = (HiddenField)item.FindControl("hdnCatId");
            HiddenField _hdnCatName = (HiddenField)item.FindControl("hdnCatName");
            LinkButton _lbtnCatSelect = (LinkButton)item.FindControl("lbtnCatSelect");

            //foreach (RepeaterItem item1 in RepCat.Items)
            //{
            //    LinkButton _lbtnCatSelect1 = (LinkButton)item.FindControl("lbtnCatSelect");
            //    if (_lbtnCatSelect1.CssClass== "btn btn-outline-dark btn-sm mb-1")
            //    {
            //        _lbtnCatSelect1.ForeColor = Color.Red;
            //       // _lbtnCatSelect1.BackColor = Color.Black;

            //    }

            //}

            hdnVisitorCatId.Value = _hdnCatId.Value;
            RepVisitor.DataBind();
            _lbtnCatSelect.ForeColor = Color.DarkOrange;
            _lbtnCatSelect.BackColor = Color.FromName("#343a40");
            divFrequency.Visible = true;
            divEntry.Visible = false;



        }

        protected void lbtnFrecSelect_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = (LinkButton)sender;
            RepeaterItem item = (RepeaterItem)lbtn.Parent;
            HiddenField _hdnFrequencyId = (HiddenField)item.FindControl("hdnFrequencyId");
            HiddenField _hdnFrequencyName = (HiddenField)item.FindControl("hdnFrequencyName");
            hdnVisitorFId.Value = _hdnFrequencyId.Value;


            LinkButton _lbtnFrecSelect = (LinkButton)item.FindControl("lbtnFrecSelect");
            _lbtnFrecSelect.ForeColor = Color.DarkOrange;
            _lbtnFrecSelect.BackColor = Color.FromName("#343a40");
            divEntry.Visible = true;

            if (!string.IsNullOrEmpty(_hdnFrequencyName.Value))
            {
                if (_hdnFrequencyName.Value == "One time")
                {
                    pnlVisitorDate.Visible = false;
                }
                else
                {
                    pnlVisitorDate.Visible = true;
                }
            }
        }


        public static DataSet GetVisitorData(int pageIndex)
        {
            string query = "[GetVisitorPageWise]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
            cmd.Parameters.AddWithValue("@PageSize", 10);
            cmd.Parameters.Add("@PageCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
            return GetData(cmd);
        }

        private static DataSet GetData(SqlCommand cmd)
        {
            string strConnString = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        sda.Fill(ds, "Visitor");
                        DataTable dt = new DataTable("PageCount");
                        dt.Columns.Add("PageCount");
                        dt.Rows.Add();
                        dt.Rows[0][0] = cmd.Parameters["@PageCount"].Value;
                        ds.Tables.Add(dt);
                        return ds;
                    }
                }
            }
        }

        [WebMethod]
        public static string GetVisitor(int pageIndex)
        {
            return GetVisitorData(pageIndex).GetXml();
        }


        [WebMethod]
        public static bool UpdateVisitor(int visitorId, string toDate)
        {
            string conString = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE Visitor SET ToDate=@ToDate WHERE Id = @Id"))
                {
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@Id", visitorId);
                    cmd.Parameters.AddWithValue("@ToDate", toDate);

                    //cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 150).Value = descr;
                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    con.Close();
                    return rowsAffected > 0;
                }
            }
        }

        [WebMethod]
        public static bool RemoveVisitor(int visitorId)
        {
            string conString = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE Visitor SET IsDel=1 WHERE Id = @Id"))
                {
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@Id", visitorId);
                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    con.Close();
                    return rowsAffected > 0;
                }
            }
        }

        #endregion


    }
}