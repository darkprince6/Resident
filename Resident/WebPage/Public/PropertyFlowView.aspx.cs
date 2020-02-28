using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class PropertyFlowView : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString);
        string _ip = string.Empty;
        string _user = string.Empty;
        string image1 = "";
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

            //var node2 = tvPropertyFlow.Nodes[1]; // second node
            ////TreeNode node2 = new TreeNode("2");

            //node2.SelectAction = TreeNodeSelectAction.None;
            //foreach (TreeNode node in node2.ChildNodes)
            //{
            //    node.SelectAction = TreeNodeSelectAction.None;
            //    foreach (TreeNode subnode in node.ChildNodes)
            //    {
            //        subnode.SelectAction = TreeNodeSelectAction.None;

            //    }
            //}


            //tvPropertyFlow.FindNode("2").SelectAction = TreeNodeSelectAction.None;

            
           


            //this.tvPropertyFlow.Nodes[0].SelectAction = TreeNodeSelectAction.None;

        }

        public void BindTreeViewControl()
        {
            DataTable dt = new DataTable();
            string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            SqlConnection con = new SqlConnection(conStr);
            using (con)
            {
                string sql = "SELECT Id, Name, ParentId, ComplexId FROM PropertyFlowChart";
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        dt = ds.Tables[0];
                        DataRow[] Rows = ds.Tables[0].Select("ParentId = '0'"); // Get all parents nodes
                        for (int i = 0; i < Rows.Length; i++)
                        {
                            TreeNode root = new TreeNode(Rows[i]["Name"].ToString(), Rows[i]["Id"].ToString());
                            root.SelectAction = TreeNodeSelectAction.Select;

                            CreateNode(root, ds.Tables[0]);
                            //CreateNode2(root, ds.Tables[0]);

                            tvPropertyFlow.Nodes.Add(root);
                        }
                    }
                }
            }

        }

        public void CreateNode(TreeNode node, DataTable Dt)
        {
            DataRow[] Rows = Dt.Select("ParentId  =" + node.Value);
            if (Rows.Length == 0) { return; }
            for (int i = 0; i < Rows.Length; i++)
            {
                TreeNode Childnode = new TreeNode(Rows[i]["Name"].ToString(), Rows[i]["Id"].ToString());
                string s = Rows[i]["ComplexId"].ToString();
                if (s == 3.ToString())
                {
                    Childnode.SelectAction = TreeNodeSelectAction.None;
                    Childnode.Text = String.Format("<span style='color: #a8a8a8; cursor: not-allowed'>{0}</span>", Childnode.Text);
                }
                else
                {
                    Childnode.SelectAction = TreeNodeSelectAction.Select;
                }
                node.ChildNodes.Add(Childnode);
                CreateNode(Childnode, Dt);
            }
        }

        public void CreateNode2(TreeNode node, DataTable Dt)
        {
            DataRow[] Rows = Dt.Select("ComplexId =" + 3);
            if (Rows.Length == 0) { return; }
            for (int i = 0; i < Rows.Length; i++)
            {
                TreeNode Childnode = new TreeNode(Rows[i]["Name"].ToString(), Rows[i]["Id"].ToString());
                TreeNode Childnode2 = new TreeNode(Rows[i]["ComplexId"].ToString());


                Childnode.SelectAction = TreeNodeSelectAction.None;
                if (Childnode2.Value == 3.ToString())
                {

                }
                node.ChildNodes.Add(Childnode);
                CreateNode2(Childnode, Dt);
            }
        }

        protected void tvPropertyFlow_TreeNodeExpanded(object sender, TreeNodeEventArgs e)
        {
            //if (e.Node.Value == "0")
            //    e.Node.SelectAction
        }
    }
}