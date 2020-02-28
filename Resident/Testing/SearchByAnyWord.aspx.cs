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
    public partial class SearchByAnyWord : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                RepTesting.DataSourceID = null;
                RepTesting.DataBind();
                string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;

                SqlConnection connection = new SqlConnection(constr);
                connection.Open();
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM UtilityEmail WHERE Email LIKE '%" + txtSearch.Text + "%'", connection);
                DataSet ds = new DataSet();
                da.Fill(ds);
                RepTesting.DataSource = ds;
                RepTesting.DataBind();
            }
            else
            {
                RepTesting.DataSourceID = "SqlRepTesting";
                RepTesting.DataBind();
            }
        }
    }
}