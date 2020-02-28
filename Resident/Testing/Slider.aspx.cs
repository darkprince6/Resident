using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.Testing
{
    public partial class Slider : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            {
                DataTable dummy = new DataTable();
                dummy.Columns.Add();
                dummy.Rows.Add();
                rptMain.DataSource = dummy;
                rptMain.DataBind();
            }
        }

        private DataTable GetData()
        {
            DataTable dt = new DataTable();
            //dt.Columns.AddRange(new DataColumn[2] { new DataColumn("Banner_Name"), new DataColumn("Banner_Image") });
            //dt.Rows.Add("1", "http://static.flickr.com/66/199481236_dc98b5abb3_s.jpg");
            //dt.Rows.Add("2", "http://static.flickr.com/75/199481072_b4a0d09597_s.jpg");
            //dt.Rows.Add("3", "http://static.flickr.com/57/199481087_33ae73a8de_s.jpg");
            //dt.Rows.Add("4", "http://static.flickr.com/77/199481108_4359e6b971_s.jpg");
            //dt.Rows.Add("5", "http://static.flickr.com/58/199481143_3c148d9dd3_s.jpg");
            //dt.Rows.Add("6", "http://static.flickr.com/72/199481203_ad4cdcf109_s.jpg");
            //dt.Rows.Add("7", "http://static.flickr.com/58/199481218_264ce20da0_s.jpg");
            //dt.Rows.Add("8", "http://static.flickr.com/69/199481255_fdfe885f87_s.jpg");
            //dt.Rows.Add("9", "http://static.flickr.com/60/199480111_87d4cb3e38_s.jpg");
            //dt.Rows.Add("10", "http://static.flickr.com/70/229228324_08223b70fa_s.jpg");


            using (SqlConnection con = new SqlConnection(constr))
            {
                string _query = "SELECT Id, CoverImg FROM ResidentialComplex";
                SqlCommand cmd = new SqlCommand(_query, con);
                SqlDataAdapter sqlDa = new SqlDataAdapter(cmd);
                sqlDa.Fill(dt);
            }
            return dt;
        }

        protected void rptMain_ItemDataBound1(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rptIndicators = e.Item.FindControl("rptIndicators") as Repeater;
                Repeater rptSlides = e.Item.FindControl("rptSlides") as Repeater;
                rptIndicators.DataSource = GetData();
                rptIndicators.DataBind();
                rptSlides.DataSource = GetData();
                rptSlides.DataBind();
            }
        }
    }
}