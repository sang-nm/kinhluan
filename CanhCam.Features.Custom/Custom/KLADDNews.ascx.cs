using CanhCam.Business;
using CanhCam.Web;
using CanhCam.Web.Editor;
using CanhCam.Web.Framework;
using CanhCam.Web.CustomUI;
using Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using CanhCam.FileSystem;
using log4net;

namespace CanhCam.Web.CustomUI
{
    public partial class KLADDNews : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLADDNews));
        private News news = null;
        private KLNews KLnews = null;
        protected int newsId = -1;
        private IFileSystem fileSystem = null;
        private int newsType = 0; protected string imageFolderPath;
        private SiteUser currentUser = null;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            grid.NeedDataSource += new GridNeedDataSourceEventHandler(grid_NeedDataSource);
            //SiteUtils.SetupEditor(fullcontent);
            //SiteUtils.SetupEditor(shortcontent);
            this.btncreate.Click += new EventHandler(Btncreate_Click);
            this.btndraft.Click += new EventHandler(Btndraft_Click);
            this.btnpost.Click += new EventHandler(Btnpost_Click);
            this.btnreview.Click += new EventHandler(Btnreview_Click);
            ddlnewtype.SelectedIndexChanged += new EventHandler(Ddlnewtype_SelectedIndexChanged);
        }

        private void Ddlnewtype_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlnewtypechild.DataSource = KLNewsType.GetAll().Where(nt => nt.ParentID.ToString() == ddlnewtype.SelectedValue);
            ddlnewtypechild.DataBind();
        }

        private void Btnreview_Click(object sender, EventArgs e)
        {
            int nId = Save("draft");
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/news-detail?newsID=" + nId.ToString());//Link Detail News
            }
        }

        private void Btnpost_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/create-news?NewsID=" + nId.ToString());
            }
        }

        private void Btndraft_Click(object sender, EventArgs e)
        {
            int nId = Save("draft");
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/create-news?NewsID=" + nId.ToString());
            }
        }

        private void Btncreate_Click(object sender, EventArgs e)
        {
            int nId = Save("draft");
            if (nId > 0)
            {
                    WebUtils.SetupRedirect(this, SiteRoot + "/create-news?NewsID=" + nId.ToString());
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
           
            PopulateLabels();
            LoadParams();
            LoadSettings();
            HiddenButton();
            if (!IsPostBack)
            {
                PopulateControls();
            }
        }
        private void PopulateControls()
        {
            SiteUser current = SiteUtils.GetCurrentSiteUser();
            if (current != null)
            {
                KLAuthor author = KLAuthor.GetKLAuthorByUserID(current.UserId);
                GeneralVariables.NameAuthor = current.Name;
                GeneralVariables.Level = author.LevelAuthor;
                if (news != null)
                {
                    shortcontent.Content = news.BriefContent;
                    fullcontent.Content = news.FullContent;
                    newstitle.Text = news.Title;
                    KLNewsType temp = new KLNewsType(KLnews.NewType);
                    ddlnewtype.SelectedValue = temp.ParentID.ToString();
                    ddlnewtypechild.SelectedValue = temp.NewsTypeID.ToString();
                }
                else
                {
                    litabimages.Visible = false;
                }
            }
            else
            {
                WebUtils.SetupRedirect(this, SiteRoot);
            }
        }
        protected virtual void PopulateLabels()
        {

            //fullcontent.WebEditor.ToolBar = ToolBar.FullWithTemplates;
            //fullcontent.WebEditor.Height = Unit.Pixel(500);
            //shortcontent.WebEditor.ToolBar = ToolBar.FullWithTemplates;
            //shortcontent.WebEditor.Height = Unit.Pixel(500);
            ddlnewtype.DataSource = KLNewsType.GetAll().Where(kt=>kt.ParentID==-1);
            ddlnewtype.DataBind();
            ddlnewtypechild.DataSource = KLNewsType.GetAll().Where(nt => nt.ParentID.ToString() == ddlnewtype.SelectedValue);
            ddlnewtypechild.DataBind();
        }
        private void LoadParams()
        {

            newsId = WebUtils.ParseInt32FromQueryString("NewsID", newsId);
            newsType = WebUtils.ParseInt32FromQueryString("type", newsType);
        }
        protected virtual void LoadSettings()
        {
            currentUser = SiteUtils.GetCurrentSiteUser();
            if (currentUser == null)
                WebUtils.SetupRedirect(this, SiteRoot );
            if (newsId > -1)
            {
                news = new News(siteSettings.SiteId, newsId);
                if (news != null && news.NewsID > 0)
                {
                    KLnews = new KLNews(news.NewsID, 0);
                    if (news.IsDeleted)
                    {
                        SiteUtils.RedirectToEditAccessDeniedPage();
                        return;
                    }
                    newsType = news.NewsType;
                    imageFolderPath = NewsHelper.MediaFolderPath(siteSettings.SiteId, news.NewsID);
                }
            }
            
            shortcontent.ImageManager.ViewPaths= new string[] { AuthorHepper.PublicFolderPath(siteSettings.SiteId, currentUser.UserId) };
            shortcontent.ImageManager.UploadPaths = new string[] { AuthorHepper.PublicFolderPath(siteSettings.SiteId, currentUser.UserId) };
            shortcontent.ImageManager.DeletePaths = new string[] { AuthorHepper.PublicFolderPath(siteSettings.SiteId, currentUser.UserId) };


            fullcontent.ImageManager.ViewPaths = new string[] { AuthorHepper.PublicFolderPath(siteSettings.SiteId, currentUser.UserId) };
            fullcontent.ImageManager.UploadPaths = new string[] { AuthorHepper.PublicFolderPath(siteSettings.SiteId, currentUser.UserId) };
            fullcontent.ImageManager.DeletePaths = new string[] { AuthorHepper.PublicFolderPath(siteSettings.SiteId, currentUser.UserId) };

            FileSystemProvider p = FileSystemManager.Providers[WebConfigSettings.FileSystemProvider];
            if (p != null) { fileSystem = p.GetFileSystem(); }
        }
        void HiddenButton()
        {
            if (newsId > -1)
            {
                btncreate.Visible = false;
                if(KLnews.Isapproved)
                {
                    btnpost.Visible = false;
                    btndraft.Visible = false;
                }
                if(KLnews.Isdraft)
                {
                    btncreate.Visible = false;
                }
                if(KLnews.Isapproved==false && KLnews.Isdraft==false)
                {
                    btndraft.Visible = true;
                    btndraft.Text = "Stop Pendding (Save to Draft)";
                    btnpost.Text = "Update";
                    btnpost.Visible = true;
                    
                }
            }
            else
            {
                btndraft.Visible = false;
                btnpost.Visible = false;
                btnreview.Visible = false;
                
            }
        }
        protected void btnUpdateImage_Click(object sender, EventArgs e)
        {
            if (news == null) return;

            //txtImageTitle.Text = txtImageTitle.Text.Trim();
            NewsHelper.VerifyNewsFolders(fileSystem, imageFolderPath);

            foreach (UploadedFile file in uplImageFile.UploadedFiles)
            {
                string ext = file.GetExtension();
                if (SiteUtils.IsAllowedUploadBrowseFile(ext, WebConfigSettings.ImageFileExtensions))
                {
                    ContentMedia image = new ContentMedia();
                    image.SiteGuid = siteSettings.SiteGuid;
                    image.ContentGuid = news.NewsGuid;
                    //image.Title = txtImageTitle.Text;
                    image.DisplayOrder = 0;

                    string newFileName = file.FileName.ToCleanFileName(WebConfigSettings.ForceLowerCaseForUploadedFiles);
                    string newImagePath = VirtualPathUtility.Combine(imageFolderPath, newFileName);

                    if (image.MediaFile == newFileName)
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

                    image.MediaFile = newFileName;
                    image.ThumbnailFile = newFileName;
                    image.ThumbNailWidth = displaySettings.ThumbnailWidth;
                    image.ThumbNailHeight = displaySettings.ThumbnailHeight;
                    image.Save();
                    NewsHelper.ProcessImage(image, fileSystem, imageFolderPath, file.FileName, NewsHelper.GetColor(displaySettings.ResizeBackgroundColor));
                }
            }
            grid.Rebind();
            updImages.Update();

        }

        protected void btnDeleteImage_Click(object sender, EventArgs e)
        {
            try
            {
                bool isDeleted = false;
                foreach (GridDataItem data in grid.SelectedItems)
                {
                    Guid guid = new Guid(data.GetDataKeyValue("Guid").ToString());

                    ContentMedia media = new ContentMedia(guid);
                    if (media != null && media.Guid != Guid.Empty)
                    {
                        NewsHelper.DeleteImages(media, fileSystem, imageFolderPath);
                        ContentMedia.Delete(guid);

                        isDeleted = true;
                    }
                }

                if (isDeleted)
                {
                    grid.Rebind();
                    updImages.Update();
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
        }

        protected void grid_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            List<ContentMedia> listMedia = null;
            if (news != null)
            {
                listMedia = ContentMedia.GetByContentDesc(news.NewsGuid);
                grid.DataSource = listMedia;

                if (listMedia.Count > 0)
                    btnDeleteImage.Visible = true;
            }
        }

        protected void grid_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {

        }

        private int Save(string op="")
        {
            Page.Validate("news");

            if (!Page.IsValid)
                return -1;

            if (ddlnewtype.SelectedValue.Length == 0)
            {
                message.ErrorMessage = CustomResources.SelectTypeMessage;
                return -1;
            }

            if (news == null)
            {
                news = new News(siteSettings.SiteId, newsId);
                news.ZoneID = -1;
            }
            if (currentUser == null) { return -1; }

            news.LastModUserGuid = currentUser.UserGuid;
           
            news.SiteId = siteSettings.SiteId;
            news.FullContent = fullcontent.Content;
            news.BriefContent = shortcontent.Content;
            news.Title = newstitle.Text;
            news.UserGuid = currentUser.UserGuid;
            
            if (news.Save())
            {
               
                if (newsId > 0)
                {
                    KLnews.NewType = Convert.ToInt32(ddlnewtypechild.SelectedValue);
                    LogActivity.Write("Update news", news.Title);
                    message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "UpdateSuccessMessage");
                }
                else
                {
                    KLAuthor author = KLAuthor.GetKLAuthorByUserID(currentUser.UserId);

                    KLnews = new KLNews()
                    {
                        CommentCount = 0,
                        AuthorID = author.AuthorID,
                        LikeCount = 0,
                        Newlsevel = 1,
                        Newstotalpoint = 0,
                        NewsID = news.NewsID,
                        ShareCount = 0,
                        NewType = Convert.ToInt32(ddlnewtypechild.SelectedValue),
                        ViewCount = 0,
                    };
                   
                  
                }
                if (op == "draft")
                {
                    KLnews.Isdraft = true;
                    KLnews.Isapproved = false;
                }
                else
                {
                    KLnews.Isdraft = false;
                    KLnews.Isapproved = false;
                }
                if (KLnews.Save())
                {
                    LogActivity.Write("Create new news", news.Title);
                    message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "InsertSuccessMessage");
                }
            }

            SiteUtils.QueueIndexing();

            return news.NewsID;
        }
    }
}