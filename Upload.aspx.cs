using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SuPlan
{
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fuUpload.HasFile)
            {
                string user = Context.User.Identity.Name;
                UploadDAO ul = new UploadDAO();
                string result;

                string fileName = Path.GetFileName(fuUpload.PostedFile.FileName);
                string extension = Path.GetExtension(fuUpload.PostedFile.FileName);
                string folderPath = ConfigurationManager.AppSettings["FolderPath"];
                string filePath = Server.MapPath(folderPath + fileName);
                fuUpload.SaveAs(filePath);

                result = ul.ImportFile(filePath, extension, user);
                lblImportResult.Text = result;
            }
        }
    }
}