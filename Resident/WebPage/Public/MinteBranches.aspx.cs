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
    public partial class MinteBranches : System.Web.UI.Page
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
                string sql = "SELECT Id, Branch, ParentBranchId FROM MaintBranches";
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        dt = ds.Tables[0];
                        DataRow[] Rows = ds.Tables[0].Select("ParentBranchId = '0'"); // Get all parents nodes
                        for (int i = 0; i < Rows.Length; i++)
                        {
                            TreeNode root = new TreeNode(Rows[i]["Branch"].ToString(), Rows[i]["Id"].ToString());
                            root.SelectAction = TreeNodeSelectAction.Select;
                            //root.NavigateUrl = "~/Admin/PPUnits_Public.aspx?PPUId=" + Rows[i]["Id"];
                            CreateNode(root, ds.Tables[0]);
                            tvMaintBranches.Nodes.Add(root);
                        }
                    }
                }
            }

        }

        public void CreateNode(TreeNode node, DataTable Dt)
        {
            DataRow[] Rows = Dt.Select("ParentBranchId  =" + node.Value);
            if (Rows.Length == 0) { return; }
            for (int i = 0; i < Rows.Length; i++)
            {
                TreeNode Childnode = new TreeNode(Rows[i]["Branch"].ToString(), Rows[i]["Id"].ToString());
                Childnode.SelectAction = TreeNodeSelectAction.Select;

                //Childnode.NavigateUrl = "~/Admin/PPUnits_Public.aspx?PPUId=" + Rows[i]["Id"];

                node.ChildNodes.Add(Childnode);
                CreateNode(Childnode, Dt);
            }
        }

        protected void tvMaintBranches_SelectedNodeChanged(object sender, EventArgs e)
        {
            dvwMaintBranch.ChangeMode(DetailsViewMode.Insert);
            dvwMaintBranch.Enabled = true;
            dvwMaintBranch.DataBind();

            hdnBranchId.Value = tvMaintBranches.SelectedNode.Value;

            lblMaintBranch.Text = tvMaintBranches.SelectedNode.Text;

            TreeNode node = tvMaintBranches.SelectedNode;
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
                string sql = "SELECT [Id], [Branch], [Descr] FROM [MaintBranches] WHERE ParentBranchId=@ParentBranchId";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.Add("@ParentBranchId", SqlDbType.Int).Value = hdnBranchId.Value;
                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {
                        ad.Fill(table);
                    }
                }
            }
            gvwMaintBranch.DataSource = table;
            gvwMaintBranch.DataBind();
        }

        protected void dvwMaintBranch_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            dvwMaintBranch.ChangeMode(DetailsViewMode.Insert);
            BindGvw();
            tvMaintBranches.Nodes.Clear();
            BindTreeViewControl();
            tvMaintBranches.DataBind();
        }

        protected void dvwMaintBranch_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["ResComId"] = hdnRoot.Value;
            e.Values["ParentBranchId"] = hdnBranchId.Value;

            e.Values["CrDt"] = DateTime.Now;
            e.Values["CrBy"] = _user;
            e.Values["CrByIp"] = _ip;
        }

        protected void dvwMaintBranch_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            e.NewValues["ModDt"] = DateTime.Now;
            e.NewValues["ModBy"] = _user;
            e.NewValues["ModByIp"] = _ip;
        }

        protected void dvwMaintBranch_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            dvwMaintBranch.ChangeMode(DetailsViewMode.Insert);
            BindGvw();
            tvMaintBranches.Nodes.Clear();
            BindTreeViewControl();
            tvMaintBranches.DataBind();
        }

        protected void gvwMaintBranch_SelectedIndexChanged(object sender, EventArgs e)
        {
            dvwMaintBranch.Visible = true;
            dvwMaintBranch.ChangeMode(DetailsViewMode.Edit);
        }
    }
}