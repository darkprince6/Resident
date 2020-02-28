using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class SpaceBooking : System.Web.UI.Page
    {

        string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
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

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            if (IsValid)
            {
                using (con)
                {
                    string query = "AminityBookings_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ResiId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@AminityPFCId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@DateFrom", SqlDbType.DateTime).Value = txtFromDate.Text;
                    if (!string.IsNullOrEmpty(txtToDate.Text))
                    {
                        cmd.Parameters.Add("@DateTo", SqlDbType.DateTime).Value = txtToDate.Text;
                    }
                    else
                    {
                        cmd.Parameters.Add("@DateTo", SqlDbType.DateTime).Value = txtFromDate.Text;
                    }
                    cmd.Parameters.Add("@CrBy", SqlDbType.NVarChar, 50).Value = _user;
                    cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 250).Value = "Dk_Singh";
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 50).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblMsg.Text = "From: " + txtFromDate.Text + " To: " + txtToDate.Text;
                        txtFromDate.Text = string.Empty;
                        txtToDate.Text = string.Empty;

                    }
                    catch (Exception ex)
                    {
                        lblMsg.Text = ex.ToString();
                    }

                }
            }
        }

        protected void btnRange_Click(object sender, EventArgs e)
        {
            string dates = txtRangeDateFrom.Text.Trim();
            // string from=dates.Remove()
            lblMsgRange.Text = dates;

        }

        protected void btnRange2_Click(object sender, EventArgs e)
        {


            if (IsValid)
            {
                string dateRange = txtRange2.Text;
                string[] dateParts = dateRange.Split('-');
                string from = string.Join("", dateParts.Take(dateParts.Length / 2));
                string to = string.Join("", dateParts.Skip(dateParts.Length / 2));
                lblMsgRange2.Text = "From:" + from + "To:" + to;
                using (con)
                {
                    string query = "AminityBookings_Ins";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = hdnComplexId.Value;
                    cmd.Parameters.Add("@ResiId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@AminityPFCId", SqlDbType.Int).Value = 1;
                    if (!string.IsNullOrEmpty(from))
                    {
                        cmd.Parameters.Add("@DateFrom", SqlDbType.DateTime).Value = from;
                        cmd.Parameters.Add("@DateTo", SqlDbType.DateTime).Value = to;
                    }
                    else
                    {
                        cmd.Parameters.Add("@DateFrom", SqlDbType.DateTime).Value = to;
                        cmd.Parameters.Add("@DateTo", SqlDbType.DateTime).Value = to;
                    }
                    cmd.Parameters.Add("@CrBy", SqlDbType.NVarChar, 50).Value = _user;
                    cmd.Parameters.Add("@NameOfUser", SqlDbType.NVarChar, 250).Value = "Dk_Singh";
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 50).Value = _ip;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        lblMsg.Text = "From: " + txtFromDate.Text + " To: " + txtToDate.Text;
                        txtFromDate.Text = string.Empty;
                        txtToDate.Text = string.Empty;
                        txtRange2.Text = string.Empty;

                    }
                    catch (Exception ex)
                    {
                        lblMsg.Text = ex.ToString();
                    }

                }
            }

        }
    }
}