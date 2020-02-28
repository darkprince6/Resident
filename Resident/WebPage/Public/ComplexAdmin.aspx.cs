using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.Public
{
    public partial class ComplexAdmin : System.Web.UI.Page
    {
        string _ip = string.Empty;
        string _user = string.Empty;
        string logo = "";
        string image1 = "";
        string coverimg = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                divAsso.Visible = false;
                _user = User.Identity.Name;
                _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (_ip == "" || _ip == null)
                    _ip = Request.ServerVariables["REMOTE_ADDR"];
                divButton.Visible = true;
                divNoLog.Visible = false;
            }
            else
            {
                NoLog();
            }
        }

        private void NoLog()
        {
            //lblNoLog.Text = "You are not logged in. Please log in.";
            divNoLog.Visible = true;
            divButton.Visible = false;
            divAsso.Visible = false;
            //divAsso.Visible = false;
        }

        #region ComAsso

        protected void btnAsso_Click(object sender, EventArgs e)
        {
            divAsso.Visible = true;
            dvwComAsso.ChangeMode(DetailsViewMode.Insert);
            divPost.Visible = false;
            divAssoOB.Visible = false;

        }

        protected void dvwComAsso_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            if (HttpContext.Current != null &&
                               HttpContext.Current.User.Identity.IsAuthenticated)
            {
                #region Logo
                FileUpload _fuLogo = dvwComAsso.FindControl("fuLogo") as FileUpload;

                if (_fuLogo.PostedFile != null && _fuLogo.PostedFile.ContentLength > 0)
                {

                    if (_fuLogo.FileName.Length > 10)
                    {
                        string _subFN = _fuLogo.FileName.Substring(_fuLogo.FileName.Length - 10);
                        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                        logo = _subDtTime + " " + _user + " " + _subFN;
                    }
                    else
                    {
                        string _subFN = _fuLogo.FileName;
                        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                        logo = _subDtTime + " " + _user + " " + _subFN;
                    }
                    //string fileName = fu.FileName;

                    string dirUrl = "~/Image/PublicG/Acc/";
                    string dirPath = Server.MapPath(dirUrl);

                    string directory = Server.MapPath(@dirUrl);

                    //Create a bitmap in memory of the content of the fileUpload control
                    Bitmap originalBMP = new Bitmap(_fuLogo.FileContent);

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
                    newBMP.Save(directory + logo);

                    //Once finished with the bitmap objects, we deallocate them.
                    // We can also use originalBMP.Dispose and similar.
                    originalBMP = null;
                    newBMP = null;
                    oGraphics = null;

                    string fileUrlDisplay = @"~/Image/PublicG/Acc/" + logo;
                    e.Values["Logo"] = fileUrlDisplay;
                }
                #endregion

                #region Image1
                FileUpload _fuImage1 = dvwComAsso.FindControl("fuImage1") as FileUpload;
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

                    string dirUrl = "~/Image/PublicG/Acc/";
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

                    string fileUrlDisplay1 = @"~/Image/PublicG/Acc/" + image1;
                    e.Values["Image1"] = fileUrlDisplay1;
                }
                #endregion

                e.Values["CrDt"] = DateTime.Now;
                e.Values["CrBy"] = _user;
                e.Values["CrByIp"] = _ip;

            }
            else
            {
                NoLog();
            }
        }

        protected void dvwComAsso_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (HttpContext.Current != null &&
                    HttpContext.Current.User.Identity.IsAuthenticated)
            {
                divAsso.Visible = true;
                dvwComAsso.ChangeMode(DetailsViewMode.Insert);
                gvwComAsso.DataBind();
            }
            else
            {
                NoLog();
            }
        }

        protected void dvwComAsso_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            if (HttpContext.Current != null &&
                               HttpContext.Current.User.Identity.IsAuthenticated)
            {
                #region Logo
                FileUpload _fuLogo = dvwComAsso.FindControl("fuLogo") as FileUpload;

                if (_fuLogo.PostedFile != null && _fuLogo.PostedFile.ContentLength > 0)
                {

                    if (_fuLogo.FileName.Length > 10)
                    {
                        string _subFN = _fuLogo.FileName.Substring(_fuLogo.FileName.Length - 10);
                        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                        logo = _subDtTime + " " + _user + " " + _subFN;
                    }
                    else
                    {
                        string _subFN = _fuLogo.FileName;
                        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                        logo = _subDtTime + " " + _user + " " + _subFN;
                    }
                    //string fileName = fu.FileName;

                    string dirUrl = "~/Image/PublicG/Acc/";
                    string dirPath = Server.MapPath(dirUrl);

                    string directory = Server.MapPath(@dirUrl);

                    //Create a bitmap in memory of the content of the fileUpload control
                    Bitmap originalBMP = new Bitmap(_fuLogo.FileContent);

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
                    newBMP.Save(directory + logo);

                    //Once finished with the bitmap objects, we deallocate them.
                    // We can also use originalBMP.Dispose and similar.
                    originalBMP = null;
                    newBMP = null;
                    oGraphics = null;

                    string fileUrlDisplay = @"~/Image/PublicG/Acc/" + logo;
                    e.NewValues["Logo"] = fileUrlDisplay;
                }
                #endregion

                #region Image1
                FileUpload _fuImage1 = dvwComAsso.FindControl("fuImage1") as FileUpload;
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

                    string dirUrl = "~/Image/PublicG/Acc/";
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

                    string fileUrlDisplay1 = @"~/Image/PublicG/Acc/" + image1;
                    e.NewValues["Image1"] = fileUrlDisplay1;
                }
                #endregion

                e.NewValues["ModDt"] = DateTime.Now;
                e.NewValues["ModBy"] = _user;
                e.NewValues["ModByIp"] = _ip;

            }
            else
            {
                NoLog();
            }
        }

        protected void dvwComAsso_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (HttpContext.Current != null &&
                    HttpContext.Current.User.Identity.IsAuthenticated)
            {
                divAsso.Visible = true;
                dvwComAsso.ChangeMode(DetailsViewMode.Insert);
                gvwComAsso.DataBind();
            }
            else
            {
                NoLog();
            }
        }

        protected void dvwComAsso_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("cancel", StringComparison.CurrentCultureIgnoreCase))
            {
                divAsso.Visible = true;
                dvwComAsso.Visible = true;
                dvwComAsso.ChangeMode(DetailsViewMode.Insert);
                gvwComAsso.Visible = true;
            }
        }

        protected void gvwComAsso_SelectedIndexChanged(object sender, EventArgs e)
        {
            divAsso.Visible = true;
            dvwComAsso.Visible = true;
            dvwComAsso.ChangeMode(DetailsViewMode.Edit);
        }

        #endregion

        #region Posts

        protected void btnPosts_Click(object sender, EventArgs e)
        {
            divPost.Visible = true;
            ddlAsso.Visible = true;
            dvwAssoPosts.Visible = false;
            gvwAssoPosts.Visible = false;
            ddlAsso.SelectedIndex = -1;
            divAssoOB.Visible = false;
            divAsso.Visible = false;

        }

        protected void ddlAsso_DataBound(object sender, EventArgs e)
        {
            ddlAsso.Items.Insert(0, new ListItem("--Choose Association--", "0"));
        }

        protected void ddlAsso_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (ddlAsso.SelectedIndex > 0)
                {
                    dvwAssoPosts.Visible = true;
                    dvwAssoPosts.ChangeMode(DetailsViewMode.Insert);
                    gvwAssoPosts.Visible = true;

                }
                else
                {
                    dvwAssoPosts.Visible = false;
                    gvwAssoPosts.Visible = false;
                }
            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoPosts_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            if (HttpContext.Current != null &&
                               HttpContext.Current.User.Identity.IsAuthenticated)
            {
                e.Values["CrDt"] = DateTime.Now;
                e.Values["CrBy"] = _user;
                e.Values["CrByIp"] = _ip;

            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoPosts_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (HttpContext.Current != null &&
                    HttpContext.Current.User.Identity.IsAuthenticated)
            {
                divAsso.Visible = false;

                divPost.Visible = true;
                dvwAssoPosts.ChangeMode(DetailsViewMode.Insert);
                gvwAssoPosts.DataBind();
            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoPosts_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            if (HttpContext.Current != null &&
                               HttpContext.Current.User.Identity.IsAuthenticated)
            {
                e.NewValues["ModDt"] = DateTime.Now;
                e.NewValues["ModBy"] = _user;
                e.NewValues["ModByIp"] = _ip;
            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoPosts_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (HttpContext.Current != null &&
                    HttpContext.Current.User.Identity.IsAuthenticated)
            {
                divAsso.Visible = false;

                divPost.Visible = true;
                dvwAssoPosts.ChangeMode(DetailsViewMode.Insert);
                gvwAssoPosts.DataBind();
            }
            else
            {
                NoLog();
            }
        }

        protected void gvwAssoPosts_SelectedIndexChanged(object sender, EventArgs e)
        {
            dvwAssoPosts.Visible = true;
            dvwAssoPosts.ChangeMode(DetailsViewMode.Edit);
        }

        #endregion

        #region OfficeBerer


        protected void btnOB_Click(object sender, EventArgs e)
        {
            divAsso.Visible = false;
            divPost.Visible = false;
            gvwAssoOB.Visible = false;
            dvwAssoOB.Visible = false;
            ddlPost.Visible = false;

            divAssoOB.Visible = true;
            ddlAsso2.Visible = true;
            ddlAsso2.SelectedIndex = -1;
        }

        protected void ddlAsso2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAsso2.SelectedIndex > 0)
            {
                ddlPost.Visible = true;
                ddlPost.SelectedIndex = -1;
                dvwAssoOB.Visible = false;
                gvwAssoOB.Visible = false;
            }
            else
            {
                ddlPost.Visible = false;
                dvwAssoOB.Visible = false;
                gvwAssoOB.Visible = false;
            }


        }

        protected void ddlAsso2_DataBound(object sender, EventArgs e)
        {
            ddlAsso2.Items.Insert(0, new ListItem("--Choose Association--", "0"));
        }

        protected void ddlPost_DataBound(object sender, EventArgs e)
        {
            ddlPost.Items.Insert(0, new ListItem("--Choose Post--", "0"));

        }

        protected void ddlPost_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlPost.SelectedIndex > 0)
            {
                dvwAssoOB.Visible = true;
                dvwAssoOB.ChangeMode(DetailsViewMode.Insert);
                gvwAssoOB.Visible = true;
                gvwAssoOB.DataBind();
            }
            else
            {
                dvwAssoOB.Visible = false;
                gvwAssoOB.Visible = false;
            }
        }

        protected void dvwAssoOB_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            if (HttpContext.Current != null &&
                               HttpContext.Current.User.Identity.IsAuthenticated)
            {
                #region Image1
                FileUpload _fuImage1 = dvwAssoOB.FindControl("fuImage1") as FileUpload;
                if (_fuImage1.PostedFile != null && _fuImage1.PostedFile.ContentLength > 0)
                {

                    if (_fuImage1.FileName.Length > 10)
                    {
                        string _subFN = _fuImage1.FileName.Substring(_fuImage1.FileName.Length - 10);
                        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                        coverimg = _subDtTime + " " + _user + " " + _subFN;
                    }
                    else
                    {
                        string _subFN = _fuImage1.FileName;
                        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                        coverimg = _subDtTime + " " + _user + " " + _subFN;
                    }
                    //string fileName = fu.FileName;

                    string dirUrl = "~/Image/PublicG/Acc/";
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
                    newBMP.Save(directory + coverimg);

                    //Once finished with the bitmap objects, we deallocate them.
                    // We can also use originalBMP.Dispose and similar.
                    originalBMP = null;
                    newBMP = null;
                    oGraphics = null;

                    string fileUrlDisplay1 = @"~/Image/PublicG/Acc/" + coverimg;
                    e.Values["Image1"] = fileUrlDisplay1;
                }
                #endregion

                e.Values["CrDt"] = DateTime.Now;
                e.Values["CrBy"] = _user;
                e.Values["CrByIp"] = _ip;

            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoOB_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (HttpContext.Current != null &&
                   HttpContext.Current.User.Identity.IsAuthenticated)
            {
                divAssoOB.Visible = true;
                dvwAssoOB.ChangeMode(DetailsViewMode.Insert);
                gvwAssoOB.DataBind();
            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoOB_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            if (HttpContext.Current != null &&
                               HttpContext.Current.User.Identity.IsAuthenticated)
            {
                #region Image1
                FileUpload _fuImage1 = dvwAssoOB.FindControl("fuImage1") as FileUpload;
                if (_fuImage1.PostedFile != null && _fuImage1.PostedFile.ContentLength > 0)
                {

                    if (_fuImage1.FileName.Length > 10)
                    {
                        string _subFN = _fuImage1.FileName.Substring(_fuImage1.FileName.Length - 10);
                        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                        coverimg = _subDtTime + " " + _user + " " + _subFN;
                    }
                    else
                    {
                        string _subFN = _fuImage1.FileName;
                        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
                        coverimg = _subDtTime + " " + _user + " " + _subFN;
                    }
                    //string fileName = fu.FileName;

                    string dirUrl = "~/Image/PublicG/Acc/";
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
                    newBMP.Save(directory + coverimg);

                    //Once finished with the bitmap objects, we deallocate them.
                    // We can also use originalBMP.Dispose and similar.
                    originalBMP = null;
                    newBMP = null;
                    oGraphics = null;

                    string fileUrlDisplay1 = @"~/Image/PublicG/Acc/" + coverimg;
                    e.NewValues["Image1"] = fileUrlDisplay1;
                }
                #endregion

                e.NewValues["ModDt"] = DateTime.Now;
                e.NewValues["ModBy"] = _user;
                e.NewValues["ModByIp"] = _ip;

            }
            else
            {
                NoLog();
            }
        }

        protected void dvwAssoOB_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (HttpContext.Current != null &&
                    HttpContext.Current.User.Identity.IsAuthenticated)
            {
                divAssoOB.Visible = true;
                dvwAssoOB.ChangeMode(DetailsViewMode.Insert);
                gvwAssoOB.DataBind();
            }
            else
            {
                NoLog();
            }
        }

        protected void gvwAssoOB_SelectedIndexChanged(object sender, EventArgs e)
        {
            dvwAssoOB.Visible = true;
            dvwAssoOB.ChangeMode(DetailsViewMode.Edit);
        }

        #endregion

    }
}