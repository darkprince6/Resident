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
    public partial class UtilityView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static string GetImages(int pageIndex)
        {
            return GetImagesData(pageIndex, 10).GetXml();
        }

        public static DataSet GetImagesData(int pageIndex, int pageSize)
        {
            string query = "[sp_demo_utility]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
            cmd.Parameters.AddWithValue("@PageSize", pageSize);
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
                        sda.Fill(ds, "Images");
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

        protected void btnUtilityCat_Click(object sender, EventArgs e)
        {
            Button _btn = (Button)sender;
            RepeaterItem _item = (RepeaterItem)_btn.Parent;
            HiddenField _hdnId = (HiddenField)_item.FindControl("hdnId");
            SqlUtilityView.SelectParameters["CatId"].DefaultValue = _hdnId.Value;
            // SqlUtilityView.Select();
            RepUtilityView.DataBind();
        }

       
    }
}