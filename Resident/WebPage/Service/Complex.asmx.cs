using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;

namespace Resident.WebPage.Service
{
    /// <summary>
    /// Summary description for Complex
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class Complex : System.Web.Services.WebService
    {

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string[] GetComplex(string prefix, int countryid)
        {
            List<string> _col = new List<string>();
            using (SqlConnection con = new SqlConnection())
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT Id, Name FROM ResidentialComplex WHERE CountryId=@CountryId AND IsDel=0 AND " +
                    "Name like @SearchText + '%'";
                    cmd.Parameters.AddWithValue("@SearchText", prefix);
                    cmd.Parameters.AddWithValue("@CountryId", countryid);

                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            _col.Add(string.Format("{0}-{1}", dr["Name"], dr["Id"]));
                        }
                    }
                    con.Close();
                }
                return _col.ToArray();
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string[] GetOB(string prefix, int complexid)
        {
            List<string> _col = new List<string>();
            using (SqlConnection con = new SqlConnection())
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "PropertOwner_Sel_ForAC";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@SearchText", SqlDbType.NVarChar, 150).Value = prefix;
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = complexid;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            _col.Add(string.Format("{0}-{1}", dr["Name"], dr["Id"]));
                        }
                    }
                    con.Close();
                }
                return _col.ToArray();
            }
        }
    }
}
