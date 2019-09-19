using CanhCam.Business;
using CanhCam.FileSystem;
using CanhCam.Web;
using CanhCam.Web.Editor;
using CanhCam.Web.Framework;
using log4net;
using Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CanhCam.Web.CustomUI
{
    public partial class KLADDBook : SiteModuleControl
    {
        KLAuthor author = null;
        KLBook book = null;
        int bookid = -1;
        SiteUser currentuser = null;

        private IFileSystem fileSystem = null;
        private static readonly ILog log = LogManager.GetLogger(typeof(KLRegisterAuthor));
        protected string imageFolderPath;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            SiteUtils.SetupEditor(fullcontent);
            this.Load += new EventHandler(Page_Load);
            btncreate.Click += new EventHandler(Btncreate_Click);
        }

        private void Btncreate_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/create-book?BookID=" + nId.ToString());
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            PopulateLabels();
            LoadSettings();
            if (!IsPostBack)
            {
                PopulateControls();
            }
        }
        private void PopulateControls()
        {
            if (book != null)
            {
                txttitle.Text = book.Title;
                txtURl.Text = book.Url;
                fullcontent.Text = book.Description;
            }
        }

        protected virtual void PopulateLabels()
        {
            fullcontent.WebEditor.ToolBar = ToolBar.FullWithTemplates;
            fullcontent.WebEditor.Height = Unit.Pixel(500);
           
        }

        protected virtual void LoadSettings()
        {
            currentuser = SiteUtils.GetCurrentSiteUser();
            if(currentuser==null)
            {
                WebUtils.SetupRedirect(this, SiteRoot);
            }
            else
            {
                author = KLAuthor.GetKLAuthorByUserID(currentuser.UserId);
            }
            bookid = WebUtils.ParseInt32FromQueryString("BookID", bookid);
            if(bookid!=-1)
            {
                book = new KLBook(bookid);
            }


            FileSystemProvider p = FileSystemManager.Providers[WebConfigSettings.FileSystemProvider];
            if (p != null) { fileSystem = p.GetFileSystem(); }
        }

        private int Save()
        {

            Page.Validate("Books");

            if (!Page.IsValid)
                return -1;

            if (currentuser == null) { return -1; }
            if (book == null)
            {
                book = new KLBook();
                book.AuthorID = author.AuthorID;
                book.IsPublish = true;
                book.IsDelected = false;
            }
            book.Title = txttitle.Text;
            book.Url = txtURl.Text;
            book.Description = fullcontent.Text;
            if (book.Save())
            {
                imageFolderPath = BookHelper.MediaFolderPath(siteSettings.SiteId, book.BookID);

                if (fileImages.UploadedFiles.Count > 0)
                {


                    BookHelper.VerifyBookFolders(fileSystem, imageFolderPath);

                    foreach (UploadedFile file in fileImages.UploadedFiles)
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

                            book.Image = newFileName;
                            media.Save();
                            BookHelper.ProcessImage(media, fileSystem, imageFolderPath, file.FileName);
                        }
                    }
                }
            }
            if(book.Save())
            {
                LogActivity.Write("Create new news", book.Title);
                message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "InsertSuccessMessage");
            }
            return book.BookID;
        }
    }
}