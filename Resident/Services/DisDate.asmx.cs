using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Resident.Services
{
    /// <summary>
    /// Summary description for DisDate
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class DisDate : System.Web.Services.WebService
    {

        public class AminityRecord
        {
            public string from { get; set; }
            public string to { get; set; }
        }

        [WebMethod]
        public void GetAllDates(string complexId)
        {
            List<AminityRecord> dateList = new List<AminityRecord>();

            string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("AminityBookings_Sel_DateRange", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ComplexId", complexId);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    AminityRecord date = new AminityRecord();

                    date.from = string.Format("{0:yyyy/MM/dd}", rdr.GetDateTime(0));
                    date.to = string.Format("{0:yyyy/MM/dd}", rdr.GetDateTime(1));
                    dateList.Add(date);
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            string json = new JavaScriptSerializer().Serialize(dateList);
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.AddHeader("content-length", json.Length.ToString());
            Context.Response.Flush();
            Context.Response.Write(json);
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
    }
}
