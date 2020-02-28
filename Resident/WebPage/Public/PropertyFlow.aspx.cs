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
    public partial class PropertyFlow : System.Web.UI.Page
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
        }

        public void BindTreeViewControl()
        {


            // DataSet ds = GetDataSet("SELECT Id, Name, ParentId FROM PropertyFlowChart");
            DataTable dt = new DataTable();
            string conStr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            SqlConnection con = new SqlConnection(conStr);
            using (con)
            {
                string sql = "SELECT Id, Name, ParentId FROM PropertyFlowChart";
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
                            //root.NavigateUrl = "~/Admin/PPUnits_Public.aspx?PPUId=" + Rows[i]["Id"];
                            CreateNode(root, ds.Tables[0]);
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
                Childnode.SelectAction = TreeNodeSelectAction.Select;

                //Childnode.NavigateUrl = "~/Admin/PPUnits_Public.aspx?PPUId=" + Rows[i]["Id"];

                node.ChildNodes.Add(Childnode);
                CreateNode(Childnode, Dt);
            }
        }

        protected void tvPropertyFlow_SelectedNodeChanged(object sender, EventArgs e)
        {
            dvwPropertyFlow.ChangeMode(DetailsViewMode.Insert);
            dvwPropertyFlow.Enabled = true;
            dvwPropertyFlow.DataBind();

            hdnPFCId.Value = tvPropertyFlow.SelectedNode.Value;

            lblPFCName.Text = tvPropertyFlow.SelectedNode.Text;

            TreeNode node = tvPropertyFlow.SelectedNode;
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
                string sql = "SELECT [Id], [Name], [NameAlt], [Image1], [Descr] FROM [PropertyFlowChart] WHERE ParentId=@ParentId";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.Add("@ParentId", SqlDbType.Int).Value = hdnPFCId.Value;
                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {
                        ad.Fill(table);
                    }
                }
            }
            gvwPropertyFlow.DataSource = table;
            gvwPropertyFlow.DataBind();
        }

        protected void dvwPropertyFlow_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {

            dvwPropertyFlow.ChangeMode(DetailsViewMode.Insert);
            BindGvw();
            tvPropertyFlow.Nodes.Clear();
            BindTreeViewControl();
            tvPropertyFlow.DataBind();

        }

        protected void dvwPropertyFlow_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            #region Image1
            FileUpload _fuImage1 = dvwPropertyFlow.FindControl("fuImage1") as FileUpload;
            if (_fuImage1.PostedFile != null && _fuImage1.PostedFile.ContentLength > 0)
            {

                if (_fuImage1.FileName.Length > 10)
                {
                    string _subFN = _fuImage1.FileName.Substring(_fuImage1.FileName.Length - 10);
                    string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                    image1 = _subDtTime + " " + _user + " " + _subFN;
                }
                else
                {
                    string _subFN = _fuImage1.FileName;
                    string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                    image1 = _subDtTime + " " + _user + " " + _subFN;
                }
                //string fileName = fu.FileName;

                string dirUrl = "~/Image/AdminG/Acc/";
                string dirPath = Server.MapPath(dirUrl);

                string directory = Server.MapPath(@dirUrl);

                //Create a bitmap in memory of the content of the fileUpload control
                Bitmap originalBMP = new Bitmap(_fuImage1.FileContent);

                //Calculate the new image dimensions
                int MaxFullImageSize = 450;
                int origWidth = originalBMP.Width;
                int origHeight = originalBMP.Height;
                int sngRatio = origWidth / origHeight;
                int newWidth = Math.Min(origWidth, MaxFullImageSize);
                int newHeight = (int)(origHeight * ((float)newWidth / (float)origWidth));

                //Create a new bitmap which will hold the previous resized bitmap
                Bitmap newBMP = new Bitmap(originalBMP, newWidth, newHeight);

                //Create a graphic based on the new bitmap
                Graphics oGraphics = Graphics.FromImage(newBMP);

                //Set the properties for the new graphic file

                oGraphics.SmoothingMode = SmoothingMode.AntiAlias;
                oGraphics.InterpolationMode = InterpolationMode.HighQualityBicubic;

                //Draw the new graphic based on the resized bitmap

                oGraphics.DrawImage(originalBMP, 0, 0, newWidth, newHeight);


                //Save the new graphic file to the server
                newBMP.Save(directory + image1);

                //Once finished with the bitmap objects, we deallocate them.
                // We can also use originalBMP.Dispose and similar.
                originalBMP = null;
                newBMP = null;
                oGraphics = null;

                string fileUrlDisplay1 = @"~/Image/AdminG/Acc/" + image1;
                e.Values["Image1"] = fileUrlDisplay1;
            }
            #endregion

            e.Values["ComplexId"] = hdnRoot.Value;
            e.Values["ParentId"] = hdnPFCId.Value;

            e.Values["CrDt"] = DateTime.Now;
            e.Values["CrBy"] = _user;
            e.Values["CrByIp"] = _ip;
        }

        protected void dvwPropertyFlow_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            #region Image1
            FileUpload _fuImage1 = dvwPropertyFlow.FindControl("fuImage1") as FileUpload;
            if (_fuImage1.PostedFile != null && _fuImage1.PostedFile.ContentLength > 0)
            {

                if (_fuImage1.FileName.Length > 10)
                {
                    string _subFN = _fuImage1.FileName.Substring(_fuImage1.FileName.Length - 10);
                    string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                    image1 = _subDtTime + " " + _user + " " + _subFN;
                }
                else
                {
                    string _subFN = _fuImage1.FileName;
                    string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                    image1 = _subDtTime + " " + _user + " " + _subFN;
                }
                //string fileName = fu.FileName;

                string dirUrl = "~/Image/AdminG/Acc/";
                string dirPath = Server.MapPath(dirUrl);

                string directory = Server.MapPath(@dirUrl);

                //Create a bitmap in memory of the content of the fileUpload control
                Bitmap originalBMP = new Bitmap(_fuImage1.FileContent);

                //Calculate the new image dimensions
                int MaxFullImageSize = 450;
                int origWidth = originalBMP.Width;
                int origHeight = originalBMP.Height;
                int sngRatio = origWidth / origHeight;
                int newWidth = Math.Min(origWidth, MaxFullImageSize);
                int newHeight = (int)(origHeight * ((float)newWidth / (float)origWidth));

                //Create a new bitmap which will hold the previous resized bitmap
                Bitmap newBMP = new Bitmap(originalBMP, newWidth, newHeight);

                //Create a graphic based on the new bitmap
                Graphics oGraphics = Graphics.FromImage(newBMP);

                //Set the properties for the new graphic file

                oGraphics.SmoothingMode = SmoothingMode.AntiAlias;
                oGraphics.InterpolationMode = InterpolationMode.HighQualityBicubic;

                //Draw the new graphic based on the resized bitmap

                oGraphics.DrawImage(originalBMP, 0, 0, newWidth, newHeight);


                //Save the new graphic file to the server
                newBMP.Save(directory + image1);

                //Once finished with the bitmap objects, we deallocate them.
                // We can also use originalBMP.Dispose and similar.
                originalBMP = null;
                newBMP = null;
                oGraphics = null;

                string fileUrlDisplay1 = @"~/Image/AdminG/Acc/" + image1;
                e.NewValues["Image1"] = fileUrlDisplay1;
            }
            #endregion
            e.NewValues["ModDt"] = DateTime.Now;
            e.NewValues["ModBy"] = _user;
            e.NewValues["ModByIp"] = _ip;
        }

        protected void dvwPropertyFlow_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            dvwPropertyFlow.ChangeMode(DetailsViewMode.Insert);
            BindGvw();

            tvPropertyFlow.Nodes.Clear();
            BindTreeViewControl();
            tvPropertyFlow.DataBind();
        }

        protected void gvwPropertyFlow_SelectedIndexChanged(object sender, EventArgs e)
        {
            dvwPropertyFlow.Visible = true;
            dvwPropertyFlow.ChangeMode(DetailsViewMode.Edit);
        }

    }
}