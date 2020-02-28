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

namespace Resident.WebPage.Public
{
    public partial class NestedRepeter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RepUtility.DataSource = GetUtilityData(1);
                RepUtility.DataBind();
            }
        }

        protected void RepUtility_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string utilityId = (e.Item.FindControl("hdnUtilityId") as HiddenField).Value;
                Repeater RepUtilityEmail = e.Item.FindControl("RepUtilityEmail") as Repeater;
                RepUtilityEmail.DataSource = GetNestedData(utilityId);
                RepUtilityEmail.DataBind();
            }
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
                SqlCommand cmd = new SqlCommand("SELECT UtilityId, Email FROM UtilityEmail WHERE UtilityId=@UtilityId");
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
    }
}