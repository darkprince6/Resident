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
    public partial class ComplexIssue : System.Web.UI.Page
    {
        string _ip = string.Empty;
        string _user = string.Empty;
        string s = string.Empty;
        string image1 = string.Empty;
        string image2 = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                s = Request.QueryString["Id"];
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                _user = User.Identity.Name;
                _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (_ip == "" || _ip == null)
                    _ip = Request.ServerVariables["REMOTE_ADDR"];
            }
        }

        protected void ddlIssueCat_DataBound(object sender, EventArgs e)
        {
            ddlIssueCat.Items.Insert(0, new ListItem("--Select--", "0"));

        }

        protected void RepIssue_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            //{
            //    string hdnIssueId = (e.Item.FindControl("hdnIssueId") as HiddenField).Value;
            //    Repeater RepIssueReply = e.Item.FindControl("RepIssueReply") as Repeater;
            //    RepIssueReply.DataSource = GetData(string.Format("SELECT Descr1, Descr2 FROM ComplexIssueReply WHERE IssueId='{0}'", hdnIssueId));
            //    RepIssueReply.DataBind();
            //    //BindRepIssueReply();
            //}
        }
        public void BindRepIssueReply()
        {
            foreach (RepeaterItem item in RepIssue.Items)
            {
                HiddenField hdnIssueId = (HiddenField)item.FindControl("hdnIssueId");

                // HiddenField hdnIssueId = RepIssue.FindControl("hdnIssueId") as HiddenField;
                Repeater RepIssueReply = (Repeater)item.FindControl("RepIssueReply");

                // Repeater RepIssueReply = e.Item.FindControl("RepIssueReply") as Repeater;
                RepIssueReply.DataSource = GetData(string.Format("SELECT Descr1, Descr2 FROM ComplexIssueReply WHERE IssueId='{0}'", hdnIssueId.Value));
                RepIssueReply.DataBind();
            }
            //    // string hdnIssueId = (e.Item.FindControl("hdnIssueId") as HiddenField).Value;

            //    HiddenField hdnIssueId = RepIssue.FindControl("hdnIssueId") as HiddenField;
            //    Repeater RepIssueReply = RepIssue.FindControl("RepIssueReply") as Repeater;

            //    // Repeater RepIssueReply = e.Item.FindControl("RepIssueReply") as Repeater;
            //    RepIssueReply.DataSource = GetData(string.Format("SELECT Descr1, Descr2 FROM ComplexIssueReply WHERE IssueId='{0}'", hdnIssueId.Value));
            //    RepIssueReply.DataBind();
            //}
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            if (IsValid)
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    string query = "	INSERT INTO ComplexIssues " +
                        "                       (ComplexId, AssoId, IssueCatId, Title, Descr1, Descr2, Image1, CrBY, CrDt, CrByIP) " +
                        "                 VALUES" +
                        "                       (@ComplexId, @AssoId, @IssueCatId, @Title, @Descr1, @Descr2, @Image1, @CrBY, @CrDt, @CrByIP)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@AssoId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@IssueCatId", SqlDbType.Int).Value = ddlIssueCat.SelectedValue;
                    cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 150).Value = txtTitle.Text;
                    cmd.Parameters.Add("@Descr1", SqlDbType.NVarChar, 500).Value = txtDescr1.Text;
                    cmd.Parameters.Add("@Descr2", SqlDbType.NVarChar, 500).Value = txtDescr2.Text;

                    #region Image1
                    if (fuImage1.PostedFile != null && fuImage1.PostedFile.ContentLength > 0)
                    {

                        if (fuImage1.FileName.Length > 10)
                        {
                            string _subFN = fuImage1.FileName.Substring(fuImage1.FileName.Length - 10);
                            string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                            image1 = _subDtTime + " " + _user + " " + _subFN;
                        }
                        else
                        {
                            string _subFN = fuImage1.FileName;
                            string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                            image1 = _subDtTime + " " + _user + " " + _subFN;
                        }
                        //string fileName = fu.FileName;

                        string dirUrl = "~/Image/AdminG/Acc/";
                        string dirPath = Server.MapPath(dirUrl);

                        string directory = Server.MapPath(@dirUrl);

                        //Create a bitmap in memory of the content of the fileUpload control
                        Bitmap originalBMP = new Bitmap(fuImage1.FileContent);

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
                        cmd.Parameters.Add("@Image1", SqlDbType.NVarChar, 500).Value = fileUrlDisplay1;

                    }
                    else
                    {
                        cmd.Parameters.Add("@Image1", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    }
                    #endregion

                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertmsg();", true);

                }
            }
        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.Parent;
            HiddenField hdnIssueId = (HiddenField)item.FindControl("hdnIssueId");
            hdnIssueId2.Value = hdnIssueId.Value;
        }

        protected void btnReplySubmit_Click(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            if (IsValid)
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    string query = "	INSERT INTO ComplexIssueReply " +
                        "                       (ComplexId, AssoId, IssueId, Descr1, Descr2, Image1, CrBY, CrDt, CrByIP) " +
                        "                 VALUES" +
                        "                       (@ComplexId, @AssoId, @IssueId, @Descr1, @Descr2, @Image1, @CrBY, @CrDt, @CrByIP)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.Add("@ComplexId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@AssoId", SqlDbType.Int).Value = 1;
                    cmd.Parameters.Add("@IssueId", SqlDbType.Int).Value = hdnIssueId2.Value;
                    cmd.Parameters.Add("@Descr1", SqlDbType.NVarChar, 500).Value = txtDescr1Reply.Text;
                    cmd.Parameters.Add("@Descr2", SqlDbType.NVarChar, 500).Value = txtDescr2Reply.Text;

                    #region Image1Reply
                    if (fuImage1Reply.PostedFile != null && fuImage1.PostedFile.ContentLength > 0)
                    {

                        if (fuImage1Reply.FileName.Length > 10)
                        {
                            string _subFN = fuImage1Reply.FileName.Substring(fuImage1Reply.FileName.Length - 10);
                            string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                            image2 = _subDtTime + " " + _user + " " + _subFN;
                        }
                        else
                        {
                            string _subFN = fuImage1Reply.FileName;
                            string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                            image2 = _subDtTime + " " + _user + " " + _subFN;
                        }
                        //string fileName = fu.FileName;

                        string dirUrl = "~/Image/AdminG/Acc/";
                        string dirPath = Server.MapPath(dirUrl);

                        string directory = Server.MapPath(@dirUrl);

                        //Create a bitmap in memory of the content of the fileUpload control
                        Bitmap originalBMP = new Bitmap(fuImage1Reply.FileContent);

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
                        newBMP.Save(directory + image2);

                        //Once finished with the bitmap objects, we deallocate them.
                        // We can also use originalBMP.Dispose and similar.
                        originalBMP = null;
                        newBMP = null;
                        oGraphics = null;

                        string fileUrlDisplay1 = @"~/Image/AdminG/Acc/" + image2;
                        cmd.Parameters.Add("@Image1", SqlDbType.NVarChar, 500).Value = fileUrlDisplay1;

                    }
                    else
                    {
                        cmd.Parameters.Add("@Image1", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    }
                    #endregion

                    cmd.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                    cmd.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                    cmd.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertmsg();", true);
                }
            }
        }

        protected void btnLike_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal2();", true);
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.Parent;
            HiddenField hdnIssueId = (HiddenField)item.FindControl("hdnIssueId");
            hdnIssueId3.Value = hdnIssueId.Value;

        }

        protected void btnLikeSubmit_Click(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    SqlCommand cmd1 = new SqlCommand("ComplexIssueLikes_Sel", con);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.Add("@IssueId", SqlDbType.Int).Value = hdnIssueId3.Value;
                    cmd1.Parameters.Add("@CrBy", SqlDbType.NVarChar, 200).Value = _user;
                    int _userLikeExist = (int)cmd1.ExecuteScalar();
                    if (_userLikeExist > 0)
                    {
                        DataSet ds = new DataSet();
                        string query = "SELECT Likes FROM ComplexIssueLikes WHERE IssueId=@IssueId AND CrBY=@CrBy AND ISDEL=0";
                        SqlCommand cmdLikeCheck = new SqlCommand(query, con);
                        cmdLikeCheck.Parameters.Add("@IssueId", SqlDbType.Int).Value = hdnIssueId3.Value;
                        cmdLikeCheck.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                        SqlDataAdapter da = new SqlDataAdapter(cmdLikeCheck);
                        da.Fill(ds);
                        if (ds.Tables.Count > 0)
                        {
                            if (ds.Tables[0].Rows.Count != 0)
                            {
                                var likes = ds.Tables[0].Rows[0]["Likes"].ToString();

                                if (Convert.ToBoolean(likes) == true)
                                {
                                    SqlCommand cmdLike = new SqlCommand("ComplexIssueLikes_Upd", con);
                                    cmdLike.CommandType = CommandType.StoredProcedure;
                                    cmdLike.Parameters.Add("@Likes", SqlDbType.Bit).Value = false;
                                    cmdLike.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrLike.Text;
                                    cmdLike.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                                    cmdLike.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                                    cmdLike.Parameters.Add("@ModByIp", SqlDbType.NVarChar, 150).Value = _ip;
                                    cmdLike.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                                    cmdLike.Parameters.Add("@IssueId", SqlDbType.Int).Value = hdnIssueId3.Value;
                                    cmdLike.ExecuteNonQuery();

                                    //foreach (RepeaterItem item in RepIssue.Items)
                                    //{
                                    //    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                                    //    {
                                    //        var btnLike = (Button)item.FindControl("btnLike");
                                    //        btnLike.Text = "Like";

                                    //    }
                                    //}
                                }
                                else
                                {
                                    SqlCommand cmdUnLike = new SqlCommand("ComplexIssueLikes_Upd", con);
                                    cmdUnLike.CommandType = CommandType.StoredProcedure;
                                    cmdUnLike.Parameters.Add("@Likes", SqlDbType.Bit).Value = true;
                                    cmdUnLike.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrLike.Text;
                                    cmdUnLike.Parameters.Add("@ModBy", SqlDbType.NVarChar, 150).Value = _user;
                                    cmdUnLike.Parameters.Add("@ModDt", SqlDbType.DateTime).Value = DateTime.Now;
                                    cmdUnLike.Parameters.Add("@ModByIp", SqlDbType.NVarChar, 150).Value = _ip;
                                    cmdUnLike.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                                    cmdUnLike.Parameters.Add("@IssueId", SqlDbType.Int).Value = hdnIssueId3.Value;
                                    cmdUnLike.ExecuteNonQuery();

                                    //foreach (RepeaterItem item in RepIssue.Items)
                                    //{
                                    //    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                                    //    {
                                    //        var btnLike = (Button)item.FindControl("btnLike");
                                    //        btnLike.Text = "Unlike";

                                    //    }
                                    //}
                                }
                            }
                        }
                    }
                    else
                    {
                        SqlCommand cmd2 = new SqlCommand("ComplexIssueLikes_Ins", con);
                        cmd2.CommandType = CommandType.StoredProcedure;
                        cmd2.Parameters.Add("@IssueId", SqlDbType.Int).Value = hdnIssueId3.Value;
                        cmd2.Parameters.Add("@Likes", SqlDbType.Bit).Value = true;
                        cmd2.Parameters.Add("@Descr", SqlDbType.NVarChar, 500).Value = txtDescrLike.Text;
                        cmd2.Parameters.Add("@CrBY", SqlDbType.NVarChar, 150).Value = _user;
                        cmd2.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd2.Parameters.Add("@CrByIP", SqlDbType.NVarChar, 150).Value = _ip;
                        cmd2.ExecuteNonQuery();
                    }
                    con.Close();
                }
            }
        }

        public void TotalVote()
        {
            foreach (RepeaterItem item in RepIssue.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    var checkBox = (CheckBox)item.FindControl("ckbActive");
                }
            }


            //        foreach (Repeater gvRow in Repeater.Rows)
            //{

            //    Label lblFBId = (Label)gvRow.FindControl("lblFBId");
            //    Label lblCountLikes = (Label)gvRow.FindControl("lblCountLikes");
            //    LinkButton lbtnFBLikes = (LinkButton)gvRow.FindControl("lbtnFBLikes");
            //    int _insSUMFeedId = Convert.ToInt32(lblFBId.Text);
            //    SqlCommand cmd = new SqlCommand("sp_InsSUMFeed_Total_Like", con);
            //    cmd.CommandType = CommandType.StoredProcedure;
            //    cmd.Parameters.Add("@InsSUMFeedId", SqlDbType.Int).Value = _insSUMFeedId;
            //    int _countlike = (int)cmd.ExecuteScalar();
            //    if (_countlike == 1)
            //    {
            //        lbtnFBLikes.Enabled = true;
            //        lbtnFBLikes.BackColor = ColorTranslator.FromHtml("#007E33");
            //    }
            //}
        }

        protected void RepIssue_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Button btnLike = e.Item.FindControl("btnLIke") as Button;
            btnLike.Text = "Like";
        }

        protected void lbtnAddIssue_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal3();", true);
            ddlIssueCat.SelectedIndex = -1;
            txtDescr1.Text = "";
            txtDescr2.Text = "";
            txtTitle.Text = "";
            customCheck.Checked = false;
        }

        protected void btnShowReply_Click(object sender, EventArgs e)
        {
            // foreach (RepeaterItem item in RepIssue.Items)

            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.Parent;
            //  {
            HiddenField hdnIssueId = (HiddenField)item.FindControl("hdnIssueId");

            // HiddenField hdnIssueId = RepIssue.FindControl("hdnIssueId") as HiddenField;
            Repeater RepIssueReply = (Repeater)item.FindControl("RepIssueReply");

            // Repeater RepIssueReply = e.Item.FindControl("RepIssueReply") as Repeater;
            RepIssueReply.DataSource = GetData(string.Format("SELECT Descr1, Descr2 FROM ComplexIssueReply WHERE IssueId='{0}'", hdnIssueId.Value));
            RepIssueReply.DataBind();

            if (RepIssueReply.Items.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "funPopOver();", true);

            }
            //  }
        }
    }
}