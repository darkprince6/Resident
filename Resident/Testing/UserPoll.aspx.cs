using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.Testing
{
    public partial class UserPoll : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["DemoCon"].ConnectionString;
        string _ip = string.Empty;
        string _user = string.Empty;
        string s = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            s = Request.QueryString["Id"];

            Bind_RbtnAnswer();
            _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (_ip == "" || _ip == null)
                _ip = Request.ServerVariables["REMOTE_ADDR"];

            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                _user = User.Identity.Name;

                using (SqlConnection con = new SqlConnection(constr))
                {
                    string _checkquery = "SELECT COUNT(*) FROM UserAnswer WHERE CrBy=@CrBy AND QuestionId=@QuestionId";
                    SqlCommand cmdcheck = new SqlCommand(_checkquery, con);
                    cmdcheck.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmdcheck.Parameters.Add("@QuestionId", SqlDbType.Int).Value = s;
                    con.Open();
                    int _uservoteExist = (int)cmdcheck.ExecuteScalar();
                    con.Close();
                    if (_uservoteExist == 0)
                    {
                        divOnlinePoll.Visible = true;
                        divSuccessMsg.Visible = false;
                        divNolog.Visible = false;
                        lbtnAnswer.Enabled = true;
                    }
                    else
                    {
                        divOnlinePoll.Visible = false;
                        divSuccessMsg.Visible = true;
                    }
                }

            }
            else
            {
                divNolog.Visible = true;
                lbtnAnswer.Enabled = false;
                divSuccessMsg.Visible = false;
            }
        }

        protected void lbtnAnswer_Click(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    string _checkquery = "SELECT COUNT(*) FROM UserAnswer WHERE CrBy=@CrBy AND QuestionId=@QuestionId";
                    SqlCommand cmdcheck = new SqlCommand(_checkquery, con);
                    cmdcheck.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmdcheck.Parameters.Add("@QuestionId", SqlDbType.Int).Value = s;

                    con.Open();
                    int _uservoteExist = (int)cmdcheck.ExecuteScalar();
                    con.Close();
                    if (_uservoteExist == 0)
                    {
                        string query = "INSERT INTO UserAnswer (QuestionId, AnswerId, CrBY, CrDt, CrByIP) VALUES(@QuestionId, @AnswerId, @CrBY, @CrDt, @CrByIP)";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.Add("@QuestionId", SqlDbType.Int).Value = s;
                        cmd.Parameters.Add("@AnswerId", SqlDbType.Int).Value = RbtnAnswer.SelectedValue;
                        cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        divOnlinePoll.Visible = false;
                        divSuccessMsg.Visible = true;
                    }
                }
            }

        }

        private void Bind_RbtnAnswer()
        {
            DataTable dt = new DataTable();
            string _id = string.Empty;
            string _answer = string.Empty;
            string _newName = string.Empty;
            string _imgPath = string.Empty;
            string _img = string.Empty;
            using (SqlConnection con = new SqlConnection(constr))
            {
                string _query = "SELECT Id, Answer, Image1  FROM Answer WHERE (QuestionId = @QuestionId AND IsDel=0)";
                SqlCommand cmd = new SqlCommand(_query, con);
                cmd.Parameters.Add("@QuestionId", SqlDbType.Int).Value = s;
                SqlDataAdapter sqlDa = new SqlDataAdapter(cmd);
                sqlDa.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        JavaScriptSerializer ser = new JavaScriptSerializer();
                        _id = dt.Rows[i]["Id"].ToString();
                        _answer = dt.Rows[i]["Answer"].ToString();
                        _imgPath = dt.Rows[i]["Image1"].ToString();

                        if (_imgPath != string.Empty)
                        {
                            _img = ("<img src='" + _imgPath + "' runat='server' style='border: 1px solid #ddd; border-radius: 50%; padding: 1.5px; width: 30px; height: 30px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.10);'/>");
                        }
                        else
                        {
                            _img = null;
                        }
                        _newName = (_answer + " " + _img);
                        RbtnAnswer.Items.Add(new ListItem(_newName, _id));
                    }
                }
            }
        }
    }
}