using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.AdminG
{
	public partial class AssoOfficeBearers : System.Web.UI.Page
	{

        string _ip = string.Empty;
        string _user = string.Empty;
        string coverimg = "";
        protected void Page_Load(object sender, EventArgs e)
		{
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                divNoLog.Visible = false;
                _user = User.Identity.Name;
                _ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (_ip == "" || _ip == null)
                    _ip = Request.ServerVariables["REMOTE_ADDR"];
                divddlAssoPosts.Visible = true;
            }
            else
            {
                NoLog();
            }
        }
        private void NoLog()
        {
            lblNoLog.Text = "You are not logged in. Please log in.";
            divNoLog.Visible = true;
            divddlAssoPosts.Visible = false;
            divAssoOB.Visible = false;
        }
        protected void ddlAssoPosts_DataBound(object sender, EventArgs e)
        {
            ddlAssoPosts.Items.Insert(0, new ListItem("--Select--", "0"));
        }

        protected void ddlAssoPosts_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (HttpContext.Current != null && HttpContext.Current.User.Identity.IsAuthenticated)
            {
                if (ddlAssoPosts.SelectedIndex > 0)
                {
                    divAssoOB.Visible = true;
                    dvwAssoOB.ChangeMode(DetailsViewMode.Insert);
                }
                else
                {
                    divAssoOB.Visible = false;
                }
            }
            else
            {
                NoLog();
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
                    newBMP.Save(directory + coverimg);

                    //Once finished with the bitmap objects, we deallocate them.
                    // We can also use originalBMP.Dispose and similar.
                    originalBMP = null;
                    newBMP = null;
                    oGraphics = null;

                    string fileUrlDisplay1 = @"~/Image/AdminG/Acc/" + coverimg;
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
                    newBMP.Save(directory + coverimg);

                    //Once finished with the bitmap objects, we deallocate them.
                    // We can also use originalBMP.Dispose and similar.
                    originalBMP = null;
                    newBMP = null;
                    oGraphics = null;

                    string fileUrlDisplay1 = @"~/Image/AdminG/Acc/" + coverimg;
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
            dvwAssoOB .ChangeMode(DetailsViewMode.Edit);
        }

    }
}