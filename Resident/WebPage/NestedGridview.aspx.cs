using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage
{
    public partial class NestedGridview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // if (!IsPostBack)
           // {
                GvwUtility.DataSource = GetUtilityData(1);
                GvwUtility.DataBind();
           // }
        }

       
        public static DataSet GetUtilityData(int pageIndex)
        {
            string query = "[GetUtilityPageWise]";
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
                        sda.Fill(ds, "Utility");
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
        public static string GetUtility(int pageIndex)
        {
            return GetUtilityData(pageIndex).GetXml();
        }

        public static DataSet GetNestedData(string utilityId)
        {
            string strConnString = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                SqlCommand cmd = new SqlCommand("SELECT Id, UtilityId, Email FROM UtilityEmail WHERE UtilityId=@UtilityId");
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Parameters.AddWithValue("@UtilityId", utilityId);
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        DataTable dt = new DataTable("UtilityEmail");
                        sda.Fill(dt);
                        ds.Tables.Add(dt);
                        return ds;
                    }
                }
            }
        }

        [WebMethod]
        public static string GetUtilityEmail(string utilityId)
        {
            return GetNestedData(utilityId).GetXml();
        }

        protected void GvwUtility_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string utilityId = (e.Row.FindControl("hdnUtilityId") as HiddenField).Value;
                GridView GvwUtilityEmail = e.Row.FindControl("GvwUtilityEmail") as GridView;
                GvwUtilityEmail.DataSource = GetNestedData(utilityId);
                GvwUtilityEmail.DataBind();
            }
        }
    }
}