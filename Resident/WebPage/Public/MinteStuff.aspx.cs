using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class MinteStuff : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString);
        string _ip = string.Empty;
        string _user = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Page.Form.Attributes.Add("enctype", "multipart/form-data");

                _user = User.Identity.Name;
                _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (_ip == "" || _ip == null)
                    _ip = Request.ServerVariables["REMOTE_ADDR"];


                
            }
            if (!IsPostBack)
            {
                BindTreeViewControl();
            }
        }


        public void BindTreeViewControl()
        {
            // DataSet ds = GetDataSet("SELECT Id, Name, ParentId FROM PropertyFlowChart");
            DataTable dt = new DataTable();
            string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            SqlConnection con = new SqlConnection(conStr);
            using (con)
            {
                string sql = "SELECT Id, PName, ParentPostId FROM MaintPosts";
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        dt = ds.Tables[0];
                        DataRow[] Rows = ds.Tables[0].Select("ParentPostId = '0'"); // Get all parents nodes
                        for (int i = 0; i < Rows.Length; i++)
                        {
                            TreeNode root = new TreeNode(Rows[i]["PName"].ToString(), Rows[i]["Id"].ToString());
                            root.SelectAction = TreeNodeSelectAction.Select;
                            //root.NavigateUrl = "~/Admin/PPUnits_Public.aspx?PPUId=" + Rows[i]["Id"];
                            CreateNode(root, ds.Tables[0]);
                            tvMaintStuff.Nodes.Add(root);
                        }
                    }
                }
            }

        }

        public void CreateNode(TreeNode node, DataTable Dt)
        {
            DataRow[] Rows = Dt.Select("ParentPostId  =" + node.Value);
            if (Rows.Length == 0) { return; }
            for (int i = 0; i < Rows.Length; i++)
            {
                TreeNode Childnode = new TreeNode(Rows[i]["PName"].ToString(), Rows[i]["Id"].ToString());
                Childnode.SelectAction = TreeNodeSelectAction.Select;

                //Childnode.NavigateUrl = "~/Admin/PPUnits_Public.aspx?PPUId=" + Rows[i]["Id"];

                node.ChildNodes.Add(Childnode);
                CreateNode(Childnode, Dt);
            }
        }

        protected void tvMaintStuff_SelectedNodeChanged(object sender, EventArgs e)
        {
            dvwMaintStuff.ChangeMode(DetailsViewMode.Insert);
            dvwMaintStuff.Enabled = true;
            dvwMaintStuff.DataBind();

            hdnPostId.Value = tvMaintStuff.SelectedNode.Value;

            lblmsg.Text = tvMaintStuff.SelectedNode.Text;

            TreeNode node = tvMaintStuff.SelectedNode;
            while (node.Parent != null)
            {
                node = node.Parent;
            }
            hdnRoot.Value = node.Value;
            BindGvw();
        }

        private void BindGvw()
        {
            DataTable table = new DataTable();
            using (con)
            {
                string sql = "SELECT [Id], [Name] FROM [MaintStaff] WHERE MaintPostId=@MaintPostId";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.Add("@MaintPostId", SqlDbType.Int).Value = hdnPostId.Value;
                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {
                        ad.Fill(table);
                    }
                }
            }
            gvwMaintStuff.DataSource = table;
            gvwMaintStuff.DataBind();
        }

        protected void dvwMaintStuff_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            dvwMaintStuff.ChangeMode(DetailsViewMode.Insert);
            BindGvw();
        }
        protected void dvwMaintStuff_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {         
            e.Values["ResComId"] = hdnRoot.Value;
            e.Values["MaintPostId"] = hdnPostId.Value;

            e.Values["CrDt"] = DateTime.Now;
            e.Values["CrBy"] = _user;
            e.Values["CrByIp"] = _ip;
        }

        protected void dvwMaintStuff_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            e.NewValues["ModDt"] = DateTime.Now;
            e.NewValues["ModBy"] = _user;
            e.NewValues["ModByIp"] = _ip;
        }

        protected void dvwMaintStuff_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            dvwMaintStuff.ChangeMode(DetailsViewMode.Insert);
            BindGvw();
        }

        protected void gvwMaintStuff_SelectedIndexChanged(object sender, EventArgs e)
        {
            dvwMaintStuff.Visible = true;
            dvwMaintStuff.ChangeMode(DetailsViewMode.Edit);
        }
    }
}