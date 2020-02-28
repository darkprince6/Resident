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
    public partial class Booking : System.Web.UI.Page
    {
        string _ip = string.Empty;
        string _user = string.Empty;
        string s = string.Empty;
        string _todate = string.Empty;
        string _fromdate = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                _user = User.Identity.Name;

                string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;

               // string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
                //using (SqlConnection con = new SqlConnection(constr))
                //{
                //    SqlCommand cmd1 = new SqlCommand("SELECT FromDate, ToDate FROM PropertyFlowBookings WHERE Id=1", con);

                //    SqlDataReader dr = null;

                //    con.Open();
                //    dr = cmd1.ExecuteReader();

                //    while (dr.Read())
                //    {
                //        _fromdate = dr["FromDate"].ToString();
                //        _todate = dr["ToDate"].ToString();

                //    }
                //    dr.Close();
                //    if (Convert.ToDateTime(_fromdate) > Convert.ToDateTime(_todate))
                //    {
                //        lbl.Text = "gretter time";
                //    }
                //    else
                //    {
                //        lbl.Text = "leasser time";

                //    }
                //}
            }

            _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (_ip == "" || _ip == null)
                _ip = Request.ServerVariables["REMOTE_ADDR"];

            txtStartDate.Attributes.Add("readonly", "readonly");
            txtEndDate.Attributes.Add("readonly", "readonly");

        }

        protected void btnAddButton_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);

        }

        protected void ddlPurposeCat_DataBound(object sender, EventArgs e)
        {
            ddlPurposeCat.Items.Insert(0, new ListItem("--Select--", "0"));

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            //using (SqlConnection con = new SqlConnection(constr))
            //{
            //    SqlCommand cmd1 = new SqlCommand("SELECT FromDate, ToDate FROM PropertyFlowBookings WHERE Id=1", con);

            //    SqlDataReader dr = null;

            //    con.Open();
            //    dr = cmd1.ExecuteReader();

            //    while (dr.Read())
            //    {
            //         _fromdate = dr["FromDate"].ToString();
            //        _todate = dr["ToDate"].ToString();

            //    }
            //    dr.Close();
            //    if (Convert.ToDateTime(_fromdate) > Convert.ToDateTime(_todate))
            //    {
            //        lbl.Text = "gretter time";
            //    }
            //    else
            //    {
            //        lbl.Text = "leasser time";

            //    }
            //}




            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                // if (IsValid)
                // {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    string query = "	INSERT INTO PropertyFlowBookings " +
                        "                       (PropertyFlowId, PurposeCatId, Descr, FromDate, ToDate, WhoseEvent, CrBY, CrDt, CrByIP) " +
                        "                 VALUES" +
                        "                       (@PropertyFlowId, @PurposeCatId, @Descr, @FromDate, @ToDate, @WhoseEvent, @CrBY, @CrDt, @CrByIP)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.Add("@PropertyFlowId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@PurposeCatId", SqlDbType.Int).Value = ddlPurposeCat.SelectedValue;
                    cmd.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescr.Text;
                    cmd.Parameters.Add("@FromDate", SqlDbType.DateTime).Value = txtStartDate.Text;
                    cmd.Parameters.Add("@ToDate", SqlDbType.DateTime).Value = txtEndDate.Text;
                    cmd.Parameters.Add("@WhoseEvent", SqlDbType.NVarChar, 150).Value = txtWhoseEvent.Text;
                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertmsg();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "closeModal();", true);

                    repBooking.DataBind();
                }
            }
            //}
        }
    }
}
