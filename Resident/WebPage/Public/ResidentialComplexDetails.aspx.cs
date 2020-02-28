using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class ResidentialComplexDetails : System.Web.UI.Page
    {
        int _resComId = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            _resComId = Convert.ToInt32(Page.RouteData.Values["Id"]);
             catchLabel.Text = "Server Time:-" + DateTime.Now.ToString();
            //catchMain();

            catchMain();
        }

        protected void catchMain()
        {
            // Check if the DataSet is present in cache
            if (Cache["ResAssoData"] != null)
            {

                repResAsso.DataSource = Cache["ResAssoData"];
                repResAsso.DataBind();
                catchLabel.Text = "Data Retrieve From Catch:-" + DateTime.Now.ToString();

            }
            else
            {

                string CS = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;


                SqlConnection con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand("spTestResAsso", con);
                cmd.Parameters.Add("@ResComId", SqlDbType.Int).Value = 1;

                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);


                CacheItemRemovedCallback onCacheItemRemoved = new CacheItemRemovedCallback(CacheItemRemovedCallbackMethod);
                SqlCacheDependency sqlDependency = new SqlCacheDependency("Residence4UmDB", "ResidentsAssociations");

                Cache.Insert("ResAssoData", ds, sqlDependency, DateTime.Now.AddHours(24), Cache.NoSlidingExpiration,
                    CacheItemPriority.Default, onCacheItemRemoved);
                //Cache.Insert("ResComCatData", ds, sqlDependency);

                repResAsso.DataSource = ds;
                repResAsso.DataBind();
                catchLabel.Text = "Data Retrieve From DataBase:-" + DateTime.Now.ToString();


            }
        }

        public void CacheItemRemovedCallbackMethod(string key, object value, CacheItemRemovedReason reason)
        {
            string CS = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;

            SqlConnection con = new SqlConnection(CS);

            SqlCommand cmd = new SqlCommand("spTestResAsso", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@ResComId", SqlDbType.Int).Value = 1;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);


            CacheItemRemovedCallback onCacheItemRemoved = new CacheItemRemovedCallback(CacheItemRemovedCallbackMethod);
            SqlCacheDependency sqlDependency = new SqlCacheDependency("Residence4UmDB", "ResidentsAssociations");

            Cache.Insert("ResAssoData", ds, sqlDependency, DateTime.Now.AddHours(24), Cache.NoSlidingExpiration,
                CacheItemPriority.Default, onCacheItemRemoved);
        }



        protected void repResidentialComplex_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item)
            {
                HiddenField hdnId = (HiddenField)e.Item.FindControl("hdnId");
                hdnResComId.Value = hdnId.Value;
            }

        }

        protected void btnPosts_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.Parent;
            HiddenField hdnId2 = (HiddenField)item.FindControl("hdnId2");
            hdnAssoId.Value = hdnId2.Value;

            //Resident Association
            repResAsso.DataBind();

            //Associate Office Bearers
            divAssoOB.Visible = true;
            RepAssoOB.DataBind();

            //Asoociate Session
            divAssoSession.Visible = true;
            RepAssoSessions.DataBind();

            //Associate Election
            //divAssoElec.Visible = true;



        }

        protected void RepAssoSessions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item)
            {
                HiddenField hdnId3 = (HiddenField)e.Item.FindControl("hdnId3");
                hdnAssoSId.Value = hdnId3.Value;
            }


        }

        protected void btnAssoSession_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.Parent;
            HiddenField hdnId3 = (HiddenField)item.FindControl("hdnId3");
            hdnAssoSId.Value = hdnId3.Value;

            //Associate Election
            divAssoElec.Visible = true;
            RepAssoElec.DataBind();

        }

        protected void RepAssoSessions_PreRender(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in RepAssoSessions.Items)
            {
                if (item.ItemType == ListItemType.AlternatingItem || item.ItemType == ListItemType.Item)
                {
                    Button btnAssoSession = (Button)item.FindControl("btnAssoSession");
                    if (RepAssoSessions.Items.Count > 1)
                    {
                        btnAssoSession.Visible = true;
                        //divAssoElec.Visible = false;

                    }
                    else
                    {
                        btnAssoSession.Visible = false;
                        divAssoElec.Visible = true;

                    }
                }
            }
        }

        protected void btnAssoElec_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.Parent;
            HiddenField hdnId4 = (HiddenField)item.FindControl("hdnId4");
            hdnAssoElecId.Value = hdnId4.Value;

            //Associate Election Phases
            divAssoElecPheses.Visible = true;
            RepAssoElecPheses.DataBind();

            //Associate Election Candidate
            divAssoECandi.Visible = true;
            RepAssoECandiPost.DataBind();

        }
        protected void RepAssoElec_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item)
            {
                HiddenField hdnId4 = (HiddenField)e.Item.FindControl("hdnId4");
                hdnAssoElecId.Value = hdnId4.Value;
            }
        }

        protected void RepAssoECandiPost_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                string _postId = (e.Item.FindControl("hdnId5") as HiddenField).Value;
                hdnAssoECandiPost.Value = _postId;
                Repeater RepAssoECandi = e.Item.FindControl("RepAssoECandi") as Repeater;
                RepAssoECandi.DataSource = GetData(string.Format("SELECT " +
                    "                                                   Id, Img, NameFirst, NameMiddle, NameLast, DoB, Age, SupportVotes, " +
                    "                                                   SupportVotesInactive, Affidavit, Votes, Winner, Withdrawn, Disqualified " +
                    "                                             FROM " +
                    "                                                   AssoECandi " +
                    "                                             WHERE " +
                    "                                                   IsDel=0 AND AssoPostId='{0}' AND ResComId='{1}' " +
                    "                                                   AND AssoId='{2}' AND AssoEId='{3}'", _postId, _resComId, hdnAssoId.Value, hdnAssoElecId.Value));
                RepAssoECandi.DataBind();
            }
        }

        private static DataTable GetData(string query)
        {
            string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = query;
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataSet ds = new DataSet())
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }

        protected void repResAsso_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                divAssoElec.Visible = false;
                divAssoElecPheses.Visible = false;
                divAssoECandi.Visible = false;
            }
        }
        protected void RepAssoElec_PreRender(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in RepAssoElec.Items)
            {
                if (item.ItemType == ListItemType.AlternatingItem || item.ItemType == ListItemType.Item)
                {
                    Button btnAssoElec = (Button)item.FindControl("btnAssoElec");
                    if (RepAssoElec.Items.Count > 1)
                    {
                        btnAssoElec.Visible = true;
                        //divAssoElecPheses.Visible = false;
                        //divAssoECandi.Visible = false;
                    }
                    else
                    {
                        btnAssoElec.Visible = false;
                        divAssoElecPheses.Visible = true;
                        divAssoECandi.Visible = true;
                    }
                }
            }
        }

        protected void RepAssoOB_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HyperLink _hlOBProfile = (HyperLink)e.Item.FindControl("hlOBProfile");
                _hlOBProfile.NavigateUrl = GetRouteUrl("AssoOBFeedRoute",
                                new System.Web.Routing.RouteValueDictionary
                                 {
                                     {"ComplexName", "Gopal-Das"},
                                     {"Name", "Ram-Kumar-Mishra" },
                                     {"Id", 1 }

                                 });
            }
        }

        protected void repResAsso_PreRender(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in repResAsso.Items)
            {
                if (item.ItemType == ListItemType.AlternatingItem || item.ItemType == ListItemType.Item)
                {
                    Button btnPosts = (Button)item.FindControl("btnPosts");
                    if (repResAsso.Items.Count > 1)
                    {
                        btnPosts.Visible = true;
                    }
                    else
                    {
                        btnPosts.Visible = false;

                    }
                }
            }
        }
    }
}