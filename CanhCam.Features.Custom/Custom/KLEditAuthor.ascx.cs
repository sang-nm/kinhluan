using CanhCam.Business;
using CanhCam.FileSystem;
using CanhCam.Web;
using CanhCam.Web.Framework;
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CanhCam.Web.CustomUI
{
    public partial class KLEditAuthor : SiteModuleControl
    {
        private IFileSystem fileSystem = null;
        private static readonly ILog log = LogManager.GetLogger(typeof(KLEditAuthor));
        protected string imageFolderPath;
        private SiteUser current = null;
        private KLAuthor author = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            PopulateLabels();
            LoadSettings();
            if (!IsPostBack)
            {
                PopulateControls();
            }
        }
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            btncreate.Click +=new EventHandler(Btncreate_Click);
        }

        private void Btncreate_Click(object sender, EventArgs e)
        {
            var num = Save();
        }
        private void PopulateControls()
        {

        }

        protected virtual void PopulateLabels()
        {
        }

        protected virtual void LoadSettings()
        {


            FileSystemProvider p = FileSystemManager.Providers[WebConfigSettings.FileSystemProvider];
            if (p != null) { fileSystem = p.GetFileSystem(); }
            current = SiteUtils.GetCurrentSiteUser();
            if (current != null)
            {
                author = KLAuthor.GetKLAuthorByUserID(current.UserId);
                GeneralVariables.NameAuthor = current.Name;
                GeneralVariables.Level = author.LevelAuthor;
                if (author != null)
                {
                    txtfb.Text= author.LinkFacebook;
                    txtinstagram.Text = author.LinkInstagram;
                    txtpinterest.Text = author.LinkPinterest;
                    txttwinter.Text = author.LinkTwitter;
                    txtFullName.Text = author.Name;
                    txtEmail.Text = current.Email;
                    editDescription.Content = current.Signature;
                    ImageAvatar.ImageUrl = AuthorHepper.GetAvatarAuthor(siteSettings.SiteId, author.UserID);
                }
            }
            else
            {
                WebUtils.SetupRedirect(this, SiteRoot);
            }
        }
        private int Save()
        {

            Page.Validate("Author");

            if (!Page.IsValid)
                return -1;
            try
            {
                author.LinkFacebook = txtfb.Text;
                author.LinkInstagram = txtinstagram.Text;
                author.LinkPinterest = txtpinterest.Text;
                author.LinkTwitter = txttwinter.Text;
                author.Name = txtFullName.Text;
                SiteUser temp = new SiteUser(siteSettings, author.UserID);
                temp.Signature = editDescription.Text;
                if (fileImage.UploadedFiles.Count > 0)
                {
                    imageFolderPath = AuthorHepper.MediaFolderPath(siteSettings.SiteId, author.UserID);


                    AuthorHepper.VerifyAuthorFolders(fileSystem, imageFolderPath);

                    foreach (UploadedFile file in fileImage.UploadedFiles)
                    {
                        string ext = file.GetExtension();
                        if (SiteUtils.IsAllowedUploadBrowseFile(ext, WebConfigSettings.ImageFileExtensions))
                        {
                            ContentMedia media = new ContentMedia();
                            media.SiteGuid = siteSettings.SiteGuid;
                            //image.Title = txtImageTitle.Text;
                            media.DisplayOrder = 0;

                            string newFileName = file.FileName.ToCleanFileName(WebConfigSettings.ForceLowerCaseForUploadedFiles);
                            string newImagePath = VirtualPathUtility.Combine(imageFolderPath, newFileName);

                            if (media.MediaFile == newFileName)
                            {
                                // an existing image delete the old one
                                fileSystem.DeleteFile(newImagePath);
                            }
                            else
                            {
                                // this is a new newsImage instance, make sure we don't use the same file name as any other instance
                                int i = 1;
                                while (fileSystem.FileExists(VirtualPathUtility.Combine(imageFolderPath, newFileName)))
                                {
                                    newFileName = i.ToInvariantString() + newFileName;
                                    i += 1;
                                }

                            }

                            newImagePath = VirtualPathUtility.Combine(imageFolderPath, newFileName);

                            file.SaveAs(Server.MapPath(newImagePath));

                            media.MediaFile = newFileName;
                            media.ThumbnailFile = newFileName;

                            author.Avatar = newFileName;
                            media.Save();
                            AuthorHepper.ProcessImage(media, fileSystem, imageFolderPath, file.FileName);
                        }
                    }
                }

                
                if(temp.Save()&& author.Save())
                {
                    ImageAvatar.ImageUrl = AuthorHepper.GetAvatarAuthor(siteSettings.SiteId, author.UserID);
                    LogActivity.Write("Update Author", author.Name);
                    message.SuccessMessage = ResourceHelper.GetResourceString("CustomResources", "UpdateAuthorSuccess");
                }
            }
            catch (Exception ex)
            {
                log.Error(ex.Message);
            }
            return author.AuthorID;

        }

    }
}