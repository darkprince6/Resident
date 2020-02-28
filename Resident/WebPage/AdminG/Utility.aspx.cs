using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.AdminG
{
    public partial class Utility : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["ResiCon"].ConnectionString;
        string _ip = string.Empty;
        string _user = string.Empty;
        string s = string.Empty;
        string _logo = "";
        string _image = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Form.Attributes.Add("enctype", "multipart/form-data");

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



        protected void ddlUtilityCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlUtilityCat.SelectedIndex > 0)
            {
                divUtilityView.Visible = true;
            }
            else
            {
                divUtilityView.Visible = false;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                SqlCommand cmdAprove = new SqlCommand("Utlity_Ins", con);
                cmdAprove.CommandType = CommandType.StoredProcedure;

                cmdAprove.Parameters.Add("@ComplexId", SqlDbType.Int).Value = 1;
                cmdAprove.Parameters.Add("@CatId", SqlDbType.Int).Value = ddlUtilityCat.SelectedValue;
                cmdAprove.Parameters.Add("@Name", SqlDbType.NVarChar, 150).Value = txtName.Text;
                cmdAprove.Parameters.Add("@PostalCode", SqlDbType.NVarChar, 50).Value = txtPostalCode.Text.Trim();

                cmdAprove.Parameters.Add("@Addr1", SqlDbType.NVarChar, 250).Value = txtAddress1.Text;
                cmdAprove.Parameters.Add("@Addr2", SqlDbType.NVarChar, 250).Value = txtAddress2.Text;
                cmdAprove.Parameters.Add("@Image1", SqlDbType.NVarChar, 250).Value = _image;
                cmdAprove.Parameters.Add("@Logo1", SqlDbType.NVarChar, 250).Value = _logo;

                cmdAprove.Parameters.Add("@CrBy", SqlDbType.NVarChar, 150).Value = _user;
                cmdAprove.Parameters.Add("@CrDt", SqlDbType.DateTime).Value = DateTime.Now;
                cmdAprove.Parameters.Add("@CrByIp", SqlDbType.NVarChar, 150).Value = _ip;

                cmdAprove.Parameters.Add("@Mobile", SqlDbType.NVarChar, 150).Value = txtMobile1.Text;
                cmdAprove.Parameters.Add("@Phone", SqlDbType.NVarChar, 150).Value = txtPhone1.Text.Trim();
                cmdAprove.Parameters.Add("@Email", SqlDbType.NVarChar, 150).Value = txtEmail1.Text;
                cmdAprove.Parameters.Add("@Website", SqlDbType.NVarChar, 150).Value = txtWebsite.Text;

                con.Open();
                cmdAprove.ExecuteNonQuery();
                con.Close();
                RepUtility.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "alertmsg();", true);
                txtName.Text = string.Empty;
                txtName.Focus();
                txtAddress1.Text = string.Empty;
                txtAddress2.Text = string.Empty;
                txtPostalCode.Text = string.Empty;
                txtPhone1.Text = string.Empty;
                txtMobile1.Text = string.Empty;
                txtEmail1.Text = string.Empty;
                txtWebsite.Text = string.Empty;

            }
        }

        //protected void FileUploadComplete(object sender, EventArgs e)
        //{
        //    string filename = Path.GetFileName(ajaxfuImage1.FileName);
        //    ajaxfuImage1.SaveAs(Server.MapPath("~/Image/") + filename);
        //}

        protected void ajaxfuImage1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
        {
            // string filename = Path.GetFileName(ajaxfuImage1.FileName);
            // ajaxfuImage1.SaveAs(Server.MapPath("~/Image/") + filename);


        }

        protected void ajaxUpload_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            #region
            string fileName = Path.GetFileName(e.FileName);
            //if (fileName.Length > 10)
            //    {
            //        string _subFN = e.FileName.Substring(e.FileName.Length - 10);
            //        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
            //        _image = _subDtTime + " " + _user + " " + _subFN;
            //    }
            //    else
            //    {
            //        string _subFN = e.FileName;
            //        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
            //        _image = _subDtTime + " " + _user + " " + _subFN;
            //    }
            //string fileName = fu.FileName;

            string dirUrl = "~/Image/";
            string dirPath = Server.MapPath(dirUrl);

            string directory = Server.MapPath(@dirUrl);

            //Create a bitmap in memory of the content of the fileUpload control
            Bitmap originalBMP = new Bitmap(e.GetStreamContents());

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
            newBMP.Save(directory + fileName);

            //Once finished with the bitmap objects, we deallocate them.
            // We can also use originalBMP.Dispose and similar.
            originalBMP = null;
            newBMP = null;
            oGraphics = null;


            #endregion



            string fileUrlDisplay1 = @"~/Image/" + fileName;
            ajaxUpload.SaveAs(Server.MapPath(fileUrlDisplay1));

            //objImage.Save(shopLogoName, ImageFormat.Jpeg);

            //string fileName = Path.GetFileName(e.FileName);
            // ajaxUpload.SaveAs(Server.MapPath("~/Image/" + fileName));

           
        }

       

        protected Bitmap GetScaledPicture(Bitmap source, int maxWidth, int maxHeight)
        {
            int width, height;
            float aspectRatio = (float)source.Width / (float)source.Height;

            if ((maxHeight > 0) && (maxWidth > 0))
            {
                if ((source.Width < maxWidth) && (source.Height < maxHeight))
                {
                    //Return unchanged image
                    return source;
                }
                else if (aspectRatio > 1)
                {
                    // Calculated width and height,
                    // and recalcuate if the height exceeds maxHeight
                    width = maxWidth;
                    height = (int)(width / aspectRatio);
                    if (height > maxHeight)
                    {
                        height = maxHeight;
                        width = (int)(height * aspectRatio);
                    }
                }
                else
                {
                    // Calculated width and height,
                    // and recalcuate if the width exceeds maxWidth
                    height = maxHeight;
                    width = (int)(height * aspectRatio);
                    if (width > maxWidth)
                    {
                        width = maxWidth;
                        height = (int)(width / aspectRatio);
                    }
                }
            }
            else if ((maxHeight == 0) && (source.Width > maxWidth))
            {
                // If MaxHeight is not provided (unlimited), and
                // the source width exceeds maxWidth,
                // then recalculate height
                width = maxWidth;
                height = (int)(width / aspectRatio);
            }
            else if ((maxWidth == 0) && (source.Height > maxHeight))
            {
                // If MaxWidth is not provided (unlimited), and the
                // source height exceeds maxHeight, then
                // recalculate width
                height = maxHeight;
                width = (int)(height * aspectRatio);
            }
            else
            {
                //Return unchanged image
                return source;
            }

            Bitmap newImage = GetResizedImage(source, width, height);
            return newImage;
        }

        protected Bitmap GetResizedImage(Bitmap source, int width, int height)
        {
            //This function creates the thumbnail image.
            //The logic is to create a blank image and to
            // draw the source image onto it

            Bitmap thumb = new Bitmap(width, height);


            //string outputFileName = "...";
            //using (MemoryStream memory = new MemoryStream())
            //{
            //    using (FileStream fs = new FileStream(outputFileName, FileMode.Create, FileAccess.ReadWrite))
            //    {
            //        thumbBMP.Save(memory, ImageFormat.Jpeg);
            //        byte[] bytes = memory.ToArray();
            //        fs.Write(bytes, 0, bytes.Length);
            //    }
            //}
            Graphics gr = Graphics.FromImage(thumb);

            gr.InterpolationMode = InterpolationMode.HighQualityBicubic;
            gr.SmoothingMode = SmoothingMode.HighQuality;
            gr.PixelOffsetMode = PixelOffsetMode.HighQuality;
            gr.CompositingQuality = CompositingQuality.HighQuality;

            gr.DrawImage(source, 0, 0, width, height);
            return thumb;

        }
    }
}