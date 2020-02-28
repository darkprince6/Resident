using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Resident.Services
{
    /// <summary>
    /// Summary description for UserExist
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class UserExist : System.Web.Services.WebService
    {

        [WebMethod]
        public void UserNameExists(string userName, int complexId)
        {
            string userNameInUse;
            // bool userNameOut = false;

            string cs = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("AspNetUsers_Sel_Exists", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@UserName",
                    Value = userName
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@ComplexId",
                    Value = complexId
                });

                con.Open();

                userNameInUse = cmd.ExecuteScalar().ToString();

            }

            Registration regsitration = new Registration();
            regsitration.ComplexId = complexId;
            regsitration.UserName = userName;
            regsitration.UserNameInUse = userNameInUse;

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(regsitration));
        }
    }
}
