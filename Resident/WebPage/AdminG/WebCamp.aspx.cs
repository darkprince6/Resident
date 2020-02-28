using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Resident.WebPage.AdminG
{
    public partial class WebCamp : System.Web.UI.Page
    {
        string fileName;
        int _complexId = 0;
        string _user = "avik";
        private string hexString;
        private string imageName;
        private string imagePath;

        //string imageName, imagePath, hexString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (Request.InputStream.Length > 0)
                {
                    using (StreamReader reader = new StreamReader(Request.InputStream))
                    {
                        hexString = Server.UrlEncode(reader.ReadToEnd());
                        imageName = Guid.NewGuid().ToString();
                        imagePath = string.Format("~/Image/{0}.png", imageName);
                        byte[] bytes = ConvertHexToBytes(hexString);
                        string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                        Session["RawImage"] = "data:image/png;base64," + base64String;
                        imgCapture.ImageUrl = Session["RawImage"].ToString();
                        Session["CapturedImage"] = hexString;
                        Session["CapturedImageName"] = imagePath;


                    }
                }
            }
        }


        private static byte[] ConvertHexToBytes(string hex)
        {
            byte[] bytes = new byte[hex.Length / 2];
            for (int i = 0; i < hex.Length; i += 2)
            {
                bytes[i / 2] = Convert.ToByte(hex.Substring(i, 2), 16);
            }
            return bytes;
        }

        [WebMethod(EnableSession = true)]
        public static string GetCapturedImage()
        {

            string url = HttpContext.Current.Session["RawImage"].ToString();
            HttpContext.Current.Session["RawImage"] = null;
            return url;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

           
            //if (Session["CapturedImage1"] != null)
            //{
            //    //postedFile.SaveAs(Server.MapPath("~/Img/") + Session["Image1Name"]);
            //    HttpPostedFile postedFile = (HttpPostedFile)Session["CapturedImage1"];

            //    string _imageName = Session["CapturedImageName"].ToString();

            //    if (_imageName.Length > 50)
            //    {
            //        string _subFN = _imageName.Substring(_imageName.Length - 50);
            //        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
            //        fileName = _subDtTime + " " + _subFN;
            //    }
            //    else
            //    {
            //        string _subFN = _imageName;
            //        string _subDtTime = DateTime.Now.ToString("dd-MM-yyyy hh-mm-ss ");
            //        fileName = _subDtTime + " " + _subFN;
            //    }

            //    string dirUrl = "~/Image/" + _complexId + "/camera/" + _user + "/";

            //    string dirPath = Server.MapPath(dirUrl);
            //    if (!Directory.Exists(dirPath))
            //        Directory.CreateDirectory(dirPath);
            //    string directory = Server.MapPath(@dirUrl);

            //   // Create a bitmap in memory of the content of the fileUpload control
            //    Bitmap originalBMP = new Bitmap(postedFile.InputStream);

            //   // Calculate the new image dimensions
            //    int MaxFullImageSize = 450;
            //    int origWidth = originalBMP.Width;
            //    int origHeight = originalBMP.Height;
            //    int sngRatio = origWidth / origHeight;
            //    int newWidth = Math.Min(origWidth, MaxFullImageSize);
            //    int newHeight = (int)(origHeight * ((float)newWidth / (float)origWidth));

            //   // Create a new bitmap which will hold the previous resized bitmap
            //    Bitmap newBMP = new Bitmap(originalBMP, newWidth, newHeight);

            //   // Create a graphic based on the new bitmap
            //    Graphics oGraphics = Graphics.FromImage(newBMP);

            //   // Set the properties for the new graphic file
            //    oGraphics.SmoothingMode = SmoothingMode.AntiAlias;
            //    oGraphics.InterpolationMode = InterpolationMode.HighQualityBicubic;

            //   // Draw the new graphic based on the resized bitmap
            //    oGraphics.DrawImage(originalBMP, 0, 0, newWidth, newHeight);

            //   // Save the new graphic file to the server
            //    newBMP.Save(directory + fileName);

            //  //  Once finished with the bitmap objects, we deallocate them.
            //  //   We can also use originalBMP.Dispose and similar.
            //    originalBMP = null;
            //    newBMP = null;
            //    oGraphics = null;
            //    string fileUrlDisplay1 = @"~/Image/" + _complexId + "/camera/" + _user + "/" + fileName;
            //   // cmd.Parameters.Add("@Image", SqlDbType.NVarChar, 500).Value = fileUrlDisplay1;
            //    Session["CapturedImageName"] = null;
            //    Session["CapturedImage"] = null;
            //}
            //else
            //{
            //  //  cmd.Parameters.Add("@Image", SqlDbType.NVarChar, 500).Value = DBNull.Value;
            //}
        }

        protected void lbtnSave_Click(object sender, EventArgs e)
        {
            if (Session["CapturedImage"] != null)
            {
                string hexString = Session["CapturedImage"].ToString();
                imageName = Guid.NewGuid().ToString();
                imagePath = string.Format("~/Image/{0}.png", imageName);
                File.WriteAllBytes(Server.MapPath(imagePath), ConvertHexToBytes(hexString));
                ScriptManager.RegisterStartupScript(this, GetType(), "Close Modal Popup", "closeModal();", true);
            }

        }

        protected void btnOpenModal_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }
    }
}