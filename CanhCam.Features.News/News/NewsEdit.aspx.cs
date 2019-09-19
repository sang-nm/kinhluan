/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2014-06-22
/// 2015-11-25: Copy news

using log4net;
using CanhCam.Business;
using CanhCam.Business.WebHelpers;
using CanhCam.FileSystem;
using CanhCam.SearchIndex;
using CanhCam.Web.Editor;
using CanhCam.Web.Framework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Web;
using Resources;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsEditPage : CmsNonBasePage
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(NewsEditPage));

        protected int newsId = -1;
        protected string virtualRoot;
        protected Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;
        private int pageNumber = 1;
        private int pageSize = 10;
        private int totalPages = 1;
        private News news = null;
        private bool isAdmin = false;
        ContentMetaRespository metaRepository = new ContentMetaRespository();

        protected string imageFolderPath;
        protected string thumbnailImageFolderPath;
        private IFileSystem fileSystem = null;
        private SiteUser currentUser = null;
        private bool cancelRedirect = false;

        private bool canViewList = false;
        private bool canCreate = false;
        private bool canUpdate = false;
        private bool canDelete = false;
        private string startZone = string.Empty;

        private int newsType = 0;

        private void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                SiteUtils.RedirectToLoginPage(this);
                return;
            }

            SecurityHelper.DisableBrowserCache();

            LoadParams();
            LoadSettings();

            if (!canCreate && !canUpdate && !canDelete && !isReviewRole)
            {
                SiteUtils.RedirectToEditAccessDeniedPage();
                return;
            }

            PopulateLabels();
            SetupScripts();

            if ((!Page.IsPostBack) && (!Page.IsCallback))
            {
                BindEnum();
                PopulateZoneList();
                PopulateControls();

                BindAttribute();
                PopulateAttributeControls();
            }
        }

        protected virtual void PopulateControls()
        {
            if (news != null)
            {
                ListItem li = ddZones.Items.FindByValue(news.ZoneID.ToString());
                if (li != null)
                {
                    ddZones.ClearSelection();
                    li.Selected = true;
                }

                dpBeginDate.ShowTime = true;
                if (timeZone != null)
                {
                    dpBeginDate.Text = news.StartDate.ToLocalTime(timeZone).ToString("g");
                    if (news.EndDate < DateTime.MaxValue)
                    {
                        dpEndDate.Text = news.EndDate.ToLocalTime(timeZone).ToString("g");
                    }
                }
                else
                {
                    dpBeginDate.Text = DateTimeHelper.LocalizeToCalendar(news.StartDate.AddHours(timeOffset).ToString("g"));
                    if (news.EndDate < DateTime.MaxValue)
                    {
                        dpEndDate.Text = DateTimeHelper.LocalizeToCalendar(news.EndDate.AddHours(timeOffset).ToString("g"));
                    }
                }
                txtTitle.Text = news.Title;
                txtSubTitle.Text = news.SubTitle;
                txtUrl.Text = news.Url;
                edFullContent.Text = news.FullContent;
                edBriefContent.Text = news.BriefContent;
                txtMetaDescription.Text = news.MetaDescription;
                txtMetaKeywords.Text = news.MetaKeywords;
                txtMetaTitle.Text = news.MetaTitle;
                txtAdditionalMetaTags.Text = news.AdditionalMetaTags;
                txtFileAttachment.Text = news.FileAttachment;

                chkIsPublished.Checked = news.IsPublished;
                chkOpenInNewWindow.Checked = news.OpenInNewWindow;
                chkIncludeInSearch.Checked = news.IncludeInSearch;
                chkIncludeInSiteMap.Checked = news.IncludeInSiteMap;
                chkIncludeInFeed.Checked = news.IncludeInFeed;

                if (divShowOption.Visible)
                {
                    foreach (ListItem option in chlShowOption.Items)
                    {
                        option.Selected = ((news.ShowOption & Convert.ToInt16(option.Value)) > 0);
                    }
                }

                foreach (ListItem option in chlPosition.Items)
                {
                    option.Selected = ((news.Position & Convert.ToInt16(option.Value)) > 0);
                }

                ListItem item = ddCommentAllowedForDays.Items.FindByValue(news.AllowCommentsForDays.ToInvariantString());
                if (item != null)
                {
                    ddCommentAllowedForDays.ClearSelection();
                    item.Selected = true;
                }

                lnkPreview.NavigateUrl = NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID);
                //if ((!news.IsPublished) || (news.StartDate > DateTime.UtcNow))
                //    lnkPreview.Visible = true;

                hdnTitle.Value = txtTitle.Text;
            }
            else
            {
                dpBeginDate.Text = DateTimeHelper.LocalizeToCalendar(DateTime.UtcNow.AddHours(timeOffset).ToString("g"));
                this.btnDelete.Visible = false;
            }

            if ((txtUrl.Text.Length == 0) && (txtTitle.Text.Length > 0))
            {
                String friendlyUrl = SiteUtils.SuggestFriendlyUrl(txtTitle.Text, siteSettings);

                txtUrl.Text = "~/" + friendlyUrl;
            }

            bool isLoadAll = (news != null && news.NewsID > 0);
            LanguageHelper.PopulateTab(tabLanguage, isLoadAll);
            LanguageHelper.PopulateTab(tabLanguageSEO, isLoadAll);
        }

        #region Populate Zone List

        private void PopulateZoneList()
        {
            gbSiteMapProvider.PopulateListControl(ddZones, false, News.FeatureGuid);

            if (startZone.Length > 0 && newsId == -1)
            {
                ListItem li = ddZones.Items.FindByValue(startZone);
                if (li != null)
                {
                    ddZones.ClearSelection();
                    li.Selected = true;
                }
            }
        }

        #endregion

        private void BindEnum()
        {
            try
            {
                chlPosition.DataSource = EnumDefined.LoadFromConfigurationXml("news");
                chlPosition.DataBind();
                //if (chlPosition.Items.Count > 0)
                //    divPosition.Visible = true;

                chlShowOption.DataValueField = "Value";
                chlShowOption.DataTextField = "Name";
                chlShowOption.DataSource = EnumDefined.LoadFromConfigurationXml("news", "showoption", "value");
                chlShowOption.DataBind();

                if (chlShowOption.Items.Count > 0)
                    divShowOption.Visible = true;
            }
            catch (Exception ex)
            {
                log.Error(ex.Message);
            }
        }

        void btnInsert_Click(object sender, EventArgs e)
        {
            if (!canCreate)
            {
                SiteUtils.RedirectToEditAccessDeniedPage();
                return;
            }

            int nId = Save();
            if (nId > 0)
            {
                if (canUpdate || workflowIsAvailable)
                    WebUtils.SetupRedirect(this, SiteRoot + "/News/NewsEdit.aspx?NewsID=" + nId.ToString());
                else
                    SiteUtils.RedirectToHomepage();
            }
        }

        void btnInsertAndClose_Click(object sender, EventArgs e)
        {
            if (!canCreate)
            {
                SiteUtils.RedirectToEditAccessDeniedPage();
                return;
            }

            int nId = Save();
            if (nId > 0)
            {
                if (canViewList)
                    WebUtils.SetupRedirect(this, GetNewsListPage(ddZones.SelectedValue));
                else
                    SiteUtils.RedirectToHomepage();
            }
        }

        void btnInsertAndNew_Click(object sender, EventArgs e)
        {
            if (!canCreate)
            {
                SiteUtils.RedirectToEditAccessDeniedPage();
                return;
            }

            int nId = Save();
            if (nId > 0)
            {
                if (canCreate)
                    WebUtils.SetupRedirect(this, GetNewsEditPage(ddZones.SelectedValue));
                else
                    SiteUtils.RedirectToHomepage();
            }
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!canUpdate)
            {
                SiteUtils.RedirectToEditAccessDeniedPage();
                return;
            }

            int nId = Save();
            if (nId > 0)
            {
                if (canUpdate)
                    WebUtils.SetupRedirect(this, SiteRoot + "/News/NewsEdit.aspx?NewsID=" + nId.ToString());
                else
                    SiteUtils.RedirectToHomepage();
            }
        }

        void btnUpdateAndClose_Click(object sender, EventArgs e)
        {
            if (!canUpdate)
            {
                SiteUtils.RedirectToEditAccessDeniedPage();
                return;
            }

            int nId = Save();
            if (nId > 0)
            {
                if (canViewList)
                    WebUtils.SetupRedirect(this, GetNewsListPage(ddZones.SelectedValue));
                else
                    SiteUtils.RedirectToHomepage();
            }
        }

        void btnUpdateAndNew_Click(object sender, EventArgs e)
        {
            if (!canUpdate)
            {
                SiteUtils.RedirectToEditAccessDeniedPage();
                return;
            }

            int nId = Save();
            if (nId > 0)
            {
                if (canCreate)
                    WebUtils.SetupRedirect(this, GetNewsEditPage(ddZones.SelectedValue));
                else
                    SiteUtils.RedirectToHomepage();
            }
        }

        //2015-11-25: copy news
        void btnCopyNews_Click(object sender, EventArgs e)
        {
            if (!canCreate)
            {
                SiteUtils.RedirectToEditAccessDeniedPage();
                return;
            }

            Page.Validate("newsCopy");

            if (!Page.IsValid)
                return;

            if (news == null || news.NewsID <= 0) return;

            TextBox txtCopyNewsTitle = (TextBox)MPContent.FindControl("txtCopyNewsTitle");
            CheckBox chkCopyNewsPublished = (CheckBox)MPContent.FindControl("chkCopyNewsPublished");
            CheckBox chkCopyNewsCopyImages = (CheckBox)MPContent.FindControl("chkCopyNewsCopyImages");
            if (
                txtCopyNewsTitle == null
                || txtCopyNewsTitle.Text.Trim().Length == 0
                )
                return;

            int iNewsId = news.NewsID;
            Guid newsGuid = news.NewsGuid;

            News copyNews = news;
            copyNews.NewsID = -1;
            copyNews.NewsGuid = Guid.Empty;

            copyNews.StartDate = DateTime.UtcNow;
            copyNews.EndDate = DateTime.MaxValue;
            copyNews.CreatedUtc = DateTime.UtcNow;
            copyNews.LastModUtc = DateTime.UtcNow;
            copyNews.UserGuid = currentUser.UserGuid;
            copyNews.LastModUserGuid = currentUser.UserGuid;
            copyNews.Viewed = 0;
            copyNews.CommentCount = 0;
            copyNews.Title = txtCopyNewsTitle.Text.Trim();
            copyNews.IsPublished = chkCopyNewsPublished.Checked;

            string copyUrl = SiteUtils.SuggestFriendlyUrl(copyNews.Title, siteSettings);
            var friendlyUrlString = SiteUtils.RemoveInvalidUrlChars(copyUrl);
            if ((friendlyUrlString.EndsWith("/")) && (!friendlyUrlString.StartsWith("http")))
                friendlyUrlString = friendlyUrlString.Substring(0, friendlyUrlString.Length - 1);

            copyNews.Url = "~/" + friendlyUrlString;

            copyNews.ContentChanged += new ContentChangedEventHandler(news_ContentChanged);

            if (copyNews.Save())
            {
                var friendlyUrl = new FriendlyUrl(siteSettings.SiteId, friendlyUrlString);
                if (!friendlyUrl.FoundFriendlyUrl)
                {
                    if ((friendlyUrlString.Length > 0) && (!WebPageInfo.IsPhysicalWebPage("~/" + friendlyUrlString)))
                    {
                        FriendlyUrl newFriendlyUrl = new FriendlyUrl();
                        newFriendlyUrl.SiteId = siteSettings.SiteId;
                        newFriendlyUrl.SiteGuid = siteSettings.SiteGuid;
                        newFriendlyUrl.PageGuid = copyNews.NewsGuid;
                        newFriendlyUrl.Url = friendlyUrlString;
                        newFriendlyUrl.RealUrl = "~/News/NewsDetail.aspx?zoneid="
                                    + copyNews.ZoneID.ToInvariantString()
                                    + "&NewsID=" + copyNews.NewsID.ToInvariantString();
                        newFriendlyUrl.Save();
                    }
                }

                ////Copy languages
                var lstProductLanguages = ContentLanguage.GetByContent(newsGuid);
                //foreach (ContentLanguage content in lstProductLanguages)
                //{
                //    ContentLanguage copyContent = content;
                //    copyContent.Guid = Guid.Empty;
                //    copyContent.ContentGuid = copyNews.NewsGuid;
                //    copyContent.Save();
                //}

                //Copy attributes
                var lstProductAttributes = ContentAttribute.GetByContentAsc(newsGuid);
                foreach (ContentAttribute attribute in lstProductAttributes)
                {
                    ContentAttribute copyAttribute = attribute;
                    copyAttribute.Guid = Guid.Empty;
                    copyAttribute.ContentGuid = copyNews.NewsGuid;
                    if (copyAttribute.Save())
                    {
                        lstProductLanguages = ContentLanguage.GetByContent(copyAttribute.Guid);
                        foreach (ContentLanguage content in lstProductLanguages)
                        {
                            ContentLanguage copyContent = content;
                            copyContent.Guid = Guid.Empty;
                            copyContent.ContentGuid = copyAttribute.Guid;
                            copyContent.Save();
                        }
                    }
                }

                //Copy images
                if (chkCopyNewsCopyImages.Checked)
                {
                    var lstProductMedia = ContentMedia.GetByContentAsc(newsGuid);
                    if (lstProductMedia.Count > 0)
                    {
                        imageFolderPath = NewsHelper.MediaFolderPath(siteSettings.SiteId, iNewsId);
                        var copyImageFolderPath = NewsHelper.MediaFolderPath(siteSettings.SiteId, copyNews.NewsID);

                        NewsHelper.VerifyNewsFolders(fileSystem, copyImageFolderPath);

                        foreach (ContentMedia medium in lstProductMedia)
                        {
                            ContentMedia copyContent = medium;
                            copyContent.Guid = Guid.Empty;
                            copyContent.ContentGuid = copyNews.NewsGuid;
                            if (copyContent.Save())
                            {
                                if (fileSystem.FileExists(imageFolderPath + medium.MediaFile))
                                    fileSystem.CopyFile(imageFolderPath + medium.MediaFile, copyImageFolderPath + medium.MediaFile, false);
                                if (fileSystem.FileExists(imageFolderPath + "thumbs/" + medium.ThumbnailFile))
                                    fileSystem.CopyFile(imageFolderPath + "thumbs/" + medium.ThumbnailFile, copyImageFolderPath + "thumbs/" + medium.ThumbnailFile, false);
                            }
                        }
                    }
                }

                LogActivity.Write("Copy news", copyNews.Title);
                message.SuccessMessage = ResourceHelper.GetResourceString("NewsResources", "CopyNewsSuccessMessage");

                WebUtils.SetupRedirect(this, SiteRoot + "/News/NewsEdit.aspx" + (canUpdate ? "?NewsID=" + copyNews.NewsID.ToString() : ""));
            }
        }

        private bool ParamsAreValid()
        {
            try
            {
                DateTime localTime = DateTime.Parse(dpBeginDate.Text);
            }
            catch (FormatException)
            {
                message.ErrorMessage = NewsResources.ParseDateFailureMessage;
                return false;
            }
            catch (ArgumentNullException)
            {
                message.ErrorMessage = NewsResources.ParseDateFailureMessage;
                return false;
            }
            return true;
        }

        private int Save()
        {
            Page.Validate("news");

            if (!Page.IsValid)
                return -1;

            if (ddZones.SelectedValue.Length == 0)
            {
                message.ErrorMessage = NewsResources.SelectZoneMessage;
                return -1;
            }

            if (news == null)
            {
                news = new News(siteSettings.SiteId, newsId);
            }

            if (currentUser == null) { return -1; }
            news.LastModUserGuid = currentUser.UserGuid;

            bool changedZone = false;
            if (news.ZoneID.ToString() != ddZones.SelectedValue && news.NewsID > 0)
                changedZone = true;

            news.ZoneID = Convert.ToInt32(ddZones.SelectedValue);
            news.SiteId = siteSettings.SiteId;

            news.ContentChanged += new ContentChangedEventHandler(news_ContentChanged);

            DateTime localTime = DateTime.Parse(dpBeginDate.Text);
            if (timeZone != null)
            {
                news.StartDate = localTime.ToUtc(timeZone);
            }
            else
            {
                news.StartDate = localTime.AddHours(-timeOffset);
            }

            if (dpEndDate.Text.Length == 0)
            {
                news.EndDate = DateTime.MaxValue;
            }
            else
            {
                DateTime localEndTime = DateTime.Parse(dpEndDate.Text);
                if (timeZone != null)
                {
                    news.EndDate = localEndTime.ToUtc(timeZone);
                }
                else
                {
                    news.EndDate = localEndTime.AddHours(-timeOffset);
                }
            }

            news.IsPublished = chkIsPublished.Checked;

            bool saveState = false;
            if (workflowIsAvailable && firstWorkflowStateId > 0)
            {
                if (!isAdmin && news.NewsID == -1)
                {
                    news.StateId = firstWorkflowStateId;
                    saveState = true;
                }
            }

            news.NewsType = newsType;
            news.UserGuid = currentUser.UserGuid;
            news.OpenInNewWindow = chkOpenInNewWindow.Checked;
            news.IncludeInSearch = chkIncludeInSearch.Checked;
            news.IncludeInSiteMap = chkIncludeInSiteMap.Checked;
            news.IncludeInFeed = chkIncludeInFeed.Checked;

            news.ShowOption = chlShowOption.Items.SelectedItemsToBinaryOrOperator();
            news.Position = chlPosition.Items.SelectedItemsToBinaryOrOperator();

            int allowComentsForDays = -1;
            int.TryParse(ddCommentAllowedForDays.SelectedValue, out allowComentsForDays);
            news.AllowCommentsForDays = allowComentsForDays;

            string oldUrl = string.Empty;
            string newUrl = string.Empty;
            String friendlyUrlString = string.Empty;
            FriendlyUrl friendlyUrl = null;
            if (!IsLanguageTab())
            {
                news.Title = txtTitle.Text.Trim();
                news.SubTitle = txtSubTitle.Text.Trim();
                news.BriefContent = edBriefContent.Text;
                news.FullContent = edFullContent.Text;
                news.FileAttachment = txtFileAttachment.Text.Trim();

                if (txtUrl.Text.Length == 0)
                {
                    txtUrl.Text = "~/" + SiteUtils.SuggestFriendlyUrl(txtTitle.Text, siteSettings);
                }

                friendlyUrlString = SiteUtils.RemoveInvalidUrlChars(txtUrl.Text.Replace("~/", String.Empty));

                if ((friendlyUrlString.EndsWith("/")) && (!friendlyUrlString.StartsWith("http")))
                {
                    friendlyUrlString = friendlyUrlString.Substring(0, friendlyUrlString.Length - 1);
                }

                friendlyUrl = new FriendlyUrl(siteSettings.SiteId, friendlyUrlString);

                if (
                    ((friendlyUrl.FoundFriendlyUrl) && (friendlyUrl.PageGuid != news.NewsGuid))
                    && (news.Url != txtUrl.Text.Trim())
                    && (!txtUrl.Text.StartsWith("http"))
                    )
                {
                    message.ErrorMessage = NewsResources.PageUrlInUseNewsErrorMessage;
                    cancelRedirect = true;
                    return -1;
                }

                oldUrl = news.Url.Replace("~/", string.Empty);
                newUrl = friendlyUrlString;

                if (txtUrl.Text.Trim().StartsWith("http"))
                {
                    news.Url = txtUrl.Text.Trim();
                }
                else if (friendlyUrlString.Length > 0)
                {
                    news.Url = "~/" + friendlyUrlString;
                }
                else if (friendlyUrlString.Length == 0)
                {
                    news.Url = string.Empty;
                }
            }
            if (!IsLanguageSeoTab())
            {
                news.MetaDescription = txtMetaDescription.Text;
                news.MetaKeywords = txtMetaKeywords.Text;
                news.MetaTitle = txtMetaTitle.Text;
                news.AdditionalMetaTags = txtAdditionalMetaTags.Text;
            }

            if (news.Save())
            {
                SaveContentLanguage(news.NewsGuid);
                SaveContentLanguageSEO(news.NewsGuid);

                if (saveState)
                    news.SaveState();

                //Save Image
                if (fileImage.UploadedFiles.Count > 0)
                {
                    imageFolderPath = NewsHelper.MediaFolderPath(siteSettings.SiteId, news.NewsID);
                    thumbnailImageFolderPath = imageFolderPath + "thumbs/";

                    NewsHelper.VerifyNewsFolders(fileSystem, imageFolderPath);

                    foreach (UploadedFile file in fileImage.UploadedFiles)
                    {
                        string ext = file.GetExtension();
                        if (SiteUtils.IsAllowedUploadBrowseFile(ext, WebConfigSettings.ImageFileExtensions))
                        {
                            ContentMedia media = new ContentMedia();
                            media.SiteGuid = siteSettings.SiteGuid;
                            media.ContentGuid = news.NewsGuid;
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
                            media.ThumbNailWidth = displaySettings.ThumbnailWidth;
                            media.ThumbNailHeight = displaySettings.ThumbnailHeight;
                            media.Save();

                            NewsHelper.ProcessImage(media, fileSystem, imageFolderPath, file.FileName, NewsHelper.GetColor(displaySettings.ResizeBackgroundColor));
                        }
                    }
                }

                if (newsId > 0)
                {
                    LogActivity.Write("Update news", news.Title);
                    message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "UpdateSuccessMessage");
                }
                else
                {
                    LogActivity.Write("Create new news", news.Title);
                    message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "InsertSuccessMessage");
                }
            }

            if (!IsLanguageTab())
            {
                if (
                    (oldUrl.Length > 0)
                    && (newUrl.Length > 0)
                    && (!SiteUtils.UrlsMatch(oldUrl, newUrl))
                    )
                {
                    FriendlyUrl oldFriendlyUrl = new FriendlyUrl(siteSettings.SiteId, oldUrl);
                    if ((oldFriendlyUrl.FoundFriendlyUrl) && (oldFriendlyUrl.PageGuid == news.NewsGuid))
                    {
                        FriendlyUrl.DeleteUrl(oldFriendlyUrl.UrlId);
                    }
                }

                if (
                    ((txtUrl.Text.EndsWith(".aspx")) || siteSettings.DefaultFriendlyUrlPattern == SiteSettings.FriendlyUrlPattern.PageName)
                    && (txtUrl.Text.StartsWith("~/"))
                    )
                {
                    if (!friendlyUrl.FoundFriendlyUrl)
                    {
                        if ((friendlyUrlString.Length > 0) && (!WebPageInfo.IsPhysicalWebPage("~/" + friendlyUrlString)))
                        {
                            FriendlyUrl newFriendlyUrl = new FriendlyUrl();
                            newFriendlyUrl.SiteId = siteSettings.SiteId;
                            newFriendlyUrl.SiteGuid = siteSettings.SiteGuid;
                            newFriendlyUrl.PageGuid = news.NewsGuid;
                            newFriendlyUrl.Url = friendlyUrlString;
                            newFriendlyUrl.RealUrl = "~/News/NewsDetail.aspx?zoneid="
                                + news.ZoneID.ToInvariantString()
                                + "&NewsID=" + news.NewsID.ToInvariantString();

                            newFriendlyUrl.Save();
                        }
                    }
                }
            }

            if (changedZone)
            {
                List<FriendlyUrl> friendlyUrls = FriendlyUrl.GetByPageGuid(news.NewsGuid);
                foreach (FriendlyUrl item in friendlyUrls)
                {
                    item.RealUrl = "~/News/NewsDetail.aspx?zoneid="
                        + news.ZoneID.ToInvariantString()
                        + "&NewsID=" + news.NewsID.ToInvariantString();

                    item.Save();
                }
            }

            SiteUtils.QueueIndexing();

            return news.NewsID;
        }

        #region Language

        protected void tabLanguage_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
        {
            btnDeleteLanguage.Visible = false;

            if (e.Tab.Index == 0)
            {
                txtSubTitle.Text = news.SubTitle;
                txtTitle.Text = news.Title;
                txtUrl.Text = news.Url;
                edBriefContent.Text = news.BriefContent;
                edFullContent.Text = news.FullContent;
                txtFileAttachment.Text = news.FileAttachment;
            }
            else
            {
                txtSubTitle.Text = string.Empty;
                txtTitle.Text = string.Empty;
                txtUrl.Text = string.Empty;
                edBriefContent.Text = string.Empty;
                edFullContent.Text = string.Empty;
                txtFileAttachment.Text = string.Empty;

                ContentLanguage content = new ContentLanguage(news.NewsGuid, Convert.ToInt32(e.Tab.Value));
                if (content != null && content.Guid != Guid.Empty)
                {
                    btnDeleteLanguage.Visible = canDelete;

                    txtSubTitle.Text = content.ExtraText1;
                    txtTitle.Text = content.Title;
                    txtUrl.Text = content.Url;
                    edBriefContent.Text = content.BriefContent;
                    edFullContent.Text = content.FullContent;
                    txtFileAttachment.Text = content.ExtraText2;
                }
            }

            upButton.Update();
            hdnTitle.Value = txtTitle.Text;
        }

        protected void tabLanguageSEO_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
        {
            if (e.Tab.Index == 0)
            {
                txtMetaKeywords.Text = news.MetaKeywords;
                txtMetaDescription.Text = news.MetaDescription;
                txtMetaTitle.Text = news.MetaTitle;
                txtAdditionalMetaTags.Text = news.AdditionalMetaTags;
            }
            else
            {
                txtMetaKeywords.Text = "";
                txtMetaDescription.Text = "";
                txtMetaTitle.Text = "";
                txtAdditionalMetaTags.Text = "";

                ContentLanguage content = new ContentLanguage(news.NewsGuid, Convert.ToInt32(e.Tab.Value));
                if (content != null && content.Guid != Guid.Empty)
                {
                    txtMetaKeywords.Text = content.MetaKeywords;
                    txtMetaDescription.Text = content.MetaDescription;
                    txtMetaTitle.Text = content.MetaTitle;
                    txtAdditionalMetaTags.Text = content.ExtraContent1;
                }
            }

            upButton.Update();
        }

        private bool IsLanguageTab()
        {
            if (tabLanguage.Visible && tabLanguage.SelectedIndex > 0)
                return true;

            return false;
        }

        private bool IsLanguageSeoTab()
        {
            if (tabLanguageSEO.Visible && tabLanguageSEO.SelectedIndex > 0)
                return true;

            return false;
        }

        private void SaveContentLanguage(Guid contentGuid)
        {
            if (contentGuid == Guid.Empty || !IsLanguageTab())
                return;

            int languageID = -1;
            if (tabLanguage.SelectedIndex > 0)
                languageID = Convert.ToInt32(tabLanguage.SelectedTab.Value);

            if (languageID == -1)
                return;

            var content = new ContentLanguage(contentGuid, languageID);
            var newsName = txtTitle.Text.Trim();

            if (newsName.Length == 0)
            {
                return;
            }

            if (txtUrl.Text.Length == 0)
            {
                txtUrl.Text = "~/" + SiteUtils.SuggestFriendlyUrl(newsName, siteSettings);
            }

            if (txtUrl.Text.Length == 0 || (txtUrl.Text == "~/" && news.Url != "~/"))
            {
                txtUrl.Text = "~/" + SiteUtils.SuggestFriendlyUrl(news.Title + " " + tabLanguage.SelectedTab.Text, siteSettings);
            }

            String friendlyUrlString = SiteUtils.RemoveInvalidUrlChars(txtUrl.Text.Replace("~/", String.Empty));

            if ((friendlyUrlString.EndsWith("/")) && (!friendlyUrlString.StartsWith("http")))
            {
                friendlyUrlString = friendlyUrlString.Substring(0, friendlyUrlString.Length - 1);
            }

            FriendlyUrl friendlyUrl = new FriendlyUrl(siteSettings.SiteId, friendlyUrlString);

            if (
                ((friendlyUrl.FoundFriendlyUrl) && (friendlyUrl.ItemGuid != content.Guid))
                && (content.Url != txtUrl.Text.Trim())
                && (!txtUrl.Text.StartsWith("http"))
                )
            {
                message.ErrorMessage = NewsResources.PageUrlInUseNewsErrorMessage;
                //message.InfoMessage = NewsResources.NewsUrlInUseErrorMessage;
                return;
            }

            string oldUrl = content.Url.Replace("~/", string.Empty);
            string newUrl = friendlyUrlString;
            if ((txtUrl.Text.StartsWith("http")) || (txtUrl.Text.Trim() == "~/"))
            {
                content.Url = txtUrl.Text.Trim();
            }
            else if (friendlyUrlString.Length > 0)
            {
                content.Url = "~/" + friendlyUrlString;
            }
            else if (friendlyUrlString.Length == 0)
            {
                content.Url = string.Empty;
            }

            content.BriefContent = edBriefContent.Text.Trim();
            content.FullContent = edFullContent.Text.Trim();
            content.LanguageId = languageID;
            content.ContentGuid = contentGuid;
            content.SiteGuid = siteSettings.SiteGuid;
            content.Title = newsName;
            content.ExtraText1 = txtSubTitle.Text.Trim();
            content.ExtraText2 = txtFileAttachment.Text.Trim();
            content.Save();

            if (
                (oldUrl.Length > 0)
                && (newUrl.Length > 0)
                && (!SiteUtils.UrlsMatch(oldUrl, newUrl))
                )
            {
                FriendlyUrl oldFriendlyUrl = new FriendlyUrl(siteSettings.SiteId, oldUrl);
                if ((oldFriendlyUrl.FoundFriendlyUrl) && (oldFriendlyUrl.ItemGuid == content.Guid))
                {
                    FriendlyUrl.DeleteUrl(oldFriendlyUrl.UrlId);
                }
            }

            if (
                ((txtUrl.Text.EndsWith(".aspx")) || siteSettings.DefaultFriendlyUrlPattern == SiteSettings.FriendlyUrlPattern.PageName)
                && (txtUrl.Text.StartsWith("~/"))
                )
            {
                if (!friendlyUrl.FoundFriendlyUrl)
                {
                    if ((friendlyUrlString.Length > 0) && (!WebPageInfo.IsPhysicalWebPage("~/" + friendlyUrlString)))
                    {
                        FriendlyUrl newFriendlyUrl = new FriendlyUrl();
                        newFriendlyUrl.SiteId = siteSettings.SiteId;
                        newFriendlyUrl.SiteGuid = siteSettings.SiteGuid;
                        newFriendlyUrl.PageGuid = news.NewsGuid;
                        newFriendlyUrl.ItemGuid = content.Guid;
                        newFriendlyUrl.LanguageId = content.LanguageId;
                        newFriendlyUrl.Url = friendlyUrlString;
                        newFriendlyUrl.RealUrl = "~/News/NewsDetail.aspx?zoneid="
                            + news.ZoneID.ToInvariantString()
                            + "&NewsID=" + news.NewsID.ToInvariantString();
                        newFriendlyUrl.Save();
                    }
                }
            }
        }

        protected void btnDeleteLanguage_Click(object sender, EventArgs e)
        {
            if (!IsLanguageTab())
                return;

            int languageId = -1;
            if (tabLanguage.SelectedIndex > 0)
            {
                languageId = Convert.ToInt32(tabLanguage.SelectedTab.Value);

                if (languageId > 0)
                {
                    FriendlyUrl.DeleteByLanguage(news.NewsGuid, languageId);
                    ContentLanguage.Delete(news.NewsGuid, languageId);
                    message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "DeleteSuccessMessage");

                    news.ContentChanged += new ContentChangedEventHandler(news_ContentChanged);
                    SiteUtils.QueueIndexing();

                    WebUtils.SetupRedirect(this, Request.RawUrl);
                }
            }
        }

        private void SaveContentLanguageSEO(Guid contentGuid)
        {
            if (contentGuid == Guid.Empty || !IsLanguageSeoTab())
                return;

            int languageID = -1;
            if (tabLanguageSEO.SelectedIndex > 0)
                languageID = Convert.ToInt32(tabLanguageSEO.SelectedTab.Value);

            if (languageID == -1)
                return;

            var content = new ContentLanguage(contentGuid, languageID);

            if (content == null || content.LanguageId == -1)
                return;

            content.MetaTitle = txtMetaTitle.Text.Trim();
            content.MetaKeywords = txtMetaKeywords.Text.Trim();
            content.MetaDescription = txtMetaDescription.Text.Trim();
            content.ExtraContent1 = txtAdditionalMetaTags.Text.Trim();
            content.Save();
        }

        #endregion

        void news_ContentChanged(object sender, ContentChangedEventArgs e)
        {
            IndexBuilderProvider indexBuilder = IndexBuilderManager.Providers["NewsIndexBuilderProvider"];
            if (indexBuilder != null)
            {
                indexBuilder.ContentChangedHandler(sender, e);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (news != null && !news.IsDeleted)
            {
                if (!canDelete)
                {
                    SiteUtils.RedirectToEditAccessDeniedPage();
                    return;
                }

                ContentDeleted.Create(siteSettings.SiteId, news.Title, "News", typeof(NewsDeleted).AssemblyQualifiedName, news.NewsID.ToString(), Page.User.Identity.Name);

                news.IsDeleted = true;
                news.ContentChanged += new ContentChangedEventHandler(news_ContentChanged);
                news.SaveDeleted();

                SiteUtils.QueueIndexing();

                LogActivity.Write("Delete news", news.Title);

                if (canViewList)
                    WebUtils.SetupRedirect(this, GetNewsListPage());
                else
                    SiteUtils.RedirectToHomepage();
            }
        }

        private string GetNewsListPage(string startzoneId = "")
        {
            if (startzoneId.Length > 0)
            {
                if (newsType > 0)
                    return SiteRoot + "/News/NewsList.aspx?type=" + newsType.ToString() + "&start=" + startzoneId;

                return SiteRoot + "/News/NewsList.aspx?start=" + startzoneId;
            }

            if (newsType > 0)
                return SiteRoot + "/News/NewsList.aspx?type=" + newsType.ToString();

            return SiteRoot + "/News/NewsList.aspx";
        }

        private string GetNewsEditPage(string startzoneId = "")
        {
            if (startzoneId.Length > 0)
            {
                if (newsType > 0)
                    return SiteRoot + "/News/NewsEdit.aspx?type=" + newsType.ToString() + "&start=" + startzoneId;

                return SiteRoot + "/News/NewsEdit.aspx?start=" + startzoneId;
            }

            if (newsType > 0)
                return SiteRoot + "/News/NewsEdit.aspx?type=" + newsType.ToString();

            return SiteRoot + "/News/NewsEdit.aspx";
        }

        private void PopulateCommentDaysDropdown()
        {
            ListItem item = ddCommentAllowedForDays.Items.FindByValue(displaySettings.DefaultCommentDaysAllowed.ToInvariantString());
            if (item != null)
            {
                ddCommentAllowedForDays.ClearSelection();
                item.Selected = true;
            }
        }

        private void PopulateLabels()
        {
            heading.Text = NewsHelper.GetNameByNewsType(newsType, NewsResources.EditNewsPageTitleFormat, NewsResources.EditNewsPageTitle);
            Page.Title = SiteUtils.FormatPageTitle(siteSettings, heading.Text);

            if (canViewList)
            {
                breadcrumb.ParentTitle = NewsHelper.GetNameByNewsType(newsType, NewsResources.NewsListFormat, NewsResources.NewsList);
                breadcrumb.ParentUrl = GetNewsListBreadCrumb();
            }

            breadcrumb.CurrentPageTitle = heading.Text;
            breadcrumb.CurrentPageUrl = GetNewsEditBreadCrumb();

            litContentTab.Text = NewsResources.ContentTab;
            litMetaTab.Text = NewsResources.MetaTab;

            litAttributeTab.Text = "<a aria-controls='" + tabAttribute.ClientID + "' role=\"tab\" data-toggle=\"tab\" href='#" + tabAttribute.ClientID + "'>" + NewsResources.Attributes + "</a>";
            litImagesTab.Text = "<a aria-controls='" + tabImages.ClientID + "' role=\"tab\" data-toggle=\"tab\" href='#" + tabImages.ClientID + "'>" + NewsResources.Images + "</a>";

            if (!Page.IsPostBack)
            {
                PopulateCommentDaysDropdown();
            }

            //btnAttributeUp.AlternateText = NewsResources.AttributeUpAlternateText;
            btnAttributeUp.ToolTip = NewsResources.AttributeUpAlternateText;
            //btnAttributeUp.ImageUrl = ImageSiteRoot + "/Data/SiteImages/up.gif";

            //btnAttributeDown.AlternateText = NewsResources.AttributeDownAlternateText;
            btnAttributeDown.ToolTip = NewsResources.AttributeDownAlternateText;
            //btnAttributeDown.ImageUrl = ImageSiteRoot + "/Data/SiteImages/dn.gif";

            UIHelper.AddConfirmationDialog(btnDeleteImage, NewsResources.ImageDeleteConfirmMessage);

            //btnDeleteAttribute.AlternateText = NewsResources.AttributeDeleteSelectedButton;
            btnDeleteAttribute.ToolTip = NewsResources.AttributeDeleteSelectedButton;
            //btnDeleteAttribute.ImageUrl = ImageSiteRoot + "/Data/SiteImages/" + WebConfigSettings.DeleteLinkImage;
            UIHelper.AddConfirmationDialog(btnDeleteAttribute, NewsResources.AttributeDeleteConfirmMessage);
            UIHelper.AddConfirmationDialog(btnDeleteAttributeLanguage, ResourceHelper.GetResourceString("Resource", "DeleteConfirmMessage"));

            edFullContent.WebEditor.ToolBar = ToolBar.FullWithTemplates;
            edBriefContent.WebEditor.ToolBar = ToolBar.FullWithTemplates;
            edBriefContent.WebEditor.Height = Unit.Pixel(300);
            edAttributeContent.WebEditor.ToolBar = ToolBar.FullWithTemplates;

            lnkPreview.Text = NewsResources.NewsEditPreviewLabel;

            //this resets the exit page prompt after an ajax update for categories
            //ScriptManager.RegisterStartupScript(this.UpdatePanel1, typeof(UpdatePanel),
            //      "requireExitPrompt", "\n<script type=\"text/javascript\">\n requireExitPrompt = true;  \n</script>", false);

            //UIHelper.DisableButtonAfterClick(
            //    btnUpdate,
            //    NewsResources.ButtonDisabledPleaseWait,
            //    Page.ClientScript.GetPostBackEventReference(this.btnUpdate, string.Empty)
            //    );

            //UIHelper.DisableButtonAfterClick(
            //    btnSaveAndContinue,
            //    NewsResources.ButtonDisabledPleaseWait,
            //    Page.ClientScript.GetPostBackEventReference(this.btnSaveAndContinue, string.Empty)
            //    );

            //UIHelper.DisableButtonAfterClick(
            //    btnSaveAndNew,
            //    NewsResources.ButtonDisabledPleaseWait,
            //    Page.ClientScript.GetPostBackEventReference(this.btnSaveAndNew, string.Empty)
            //    );

            btnDelete.Text = NewsResources.NewsEditDeleteButton;
            UIHelper.AddConfirmationDialog(btnDelete, NewsResources.NewsDeleteWarning);

            UIHelper.AddConfirmationDialog(btnDeleteLanguage, ResourceHelper.GetResourceString("Resource", "DeleteConfirmMessage"));

            reqTitle.ErrorMessage = NewsResources.TitleRequiredWarning;
            reqStartDate.ErrorMessage = NewsResources.NewsBeginDateRequiredHelp;
            this.dpBeginDate.ClockHours = ConfigurationManager.AppSettings["ClockHours"];
            regexUrl.ErrorMessage = NewsResources.FriendlyUrlRegexWarning;

            litDays.Text = NewsResources.NewsEditCommentsDaysLabel;

            FileAttachmentBrowser.TextBoxClientId = txtFileAttachment.ClientID;
            FileAttachmentBrowser.Text = NewsResources.FileBrowserLink;
        }

        private void LoadSettings()
        {
            canViewList = NewsPermission.CanViewList;
            canCreate = NewsPermission.CanCreate;
            canUpdate = NewsPermission.CanUpdate;
            canDelete = NewsPermission.CanDelete;

            startZone = WebUtils.ParseStringFromQueryString("start", startZone);

            if ((WebUser.IsAdminOrContentAdmin) || (SiteUtils.UserIsSiteEditor())) { isAdmin = true; }

            currentUser = SiteUtils.GetCurrentSiteUser();

            ScriptConfig.IncludeFancyBox = true;

            if (newsId > -1)
            {
                news = new News(siteSettings.SiteId, newsId);
                if (news != null && news.NewsID > 0)
                {
                    if (news.IsDeleted)
                    {
                        SiteUtils.RedirectToEditAccessDeniedPage();
                        return;
                    }

                    newsType = news.NewsType;
                    imageFolderPath = NewsHelper.MediaFolderPath(siteSettings.SiteId, news.NewsID);
                    thumbnailImageFolderPath = imageFolderPath + "thumbs/";
                }
            }

            SetupWorkflow();
            HideControls();

            AddClassToBody("admin-newsedit");

            if (newsType > 0)
                AddClassToBody("admin-newstype" + newsType.ToString());

            FileSystemProvider p = FileSystemManager.Providers[WebConfigSettings.FileSystemProvider];
            if (p != null) { fileSystem = p.GetFileSystem(); }

            liAttribute.Visible = (news != null & displaySettings.ShowAttribute);
            tabAttribute.Visible = liAttribute.Visible;

            liImages.Visible = (news != null & NewsConfiguration.UseImages);
            tabImages.Visible = liImages.Visible;
            divUploadImage.Visible = (!liImages.Visible);

            btnUpdateImage.Visible = (news != null && news.NewsID > 0);
            btnDeleteImage.Visible = btnUpdateImage.Visible;
            grid.Visible = btnUpdateImage.Visible;

            divSubTitle.Visible = displaySettings.ShowSubTitle;
            divFileAttachment.Visible = displaySettings.ShowAttachment;

            try
            {
                // this keeps the action from changing during ajax postback in folder based sites
                SiteUtils.SetFormAction(Page, Request.RawUrl);
            }
            catch (MissingMethodException)
            {
                //this method was introduced in .NET 3.5 SP1
            }

            //2015-11-25: copy news settings
            Button btnCopyNews = (Button)MPContent.FindControl("btnCopyNews");
            Button btnCopyModal = (Button)MPContent.FindControl("btnCopyModal");
            Panel pnlModal = (Panel)MPContent.FindControl("pnlModal");
            if (btnCopyNews != null && btnCopyModal != null && pnlModal != null)
            {
                var txtCopyNewsTitle = (TextBox)pnlModal.FindControl("txtCopyNewsTitle");
                var chkCopyNewsPublished = (CheckBox)pnlModal.FindControl("chkCopyNewsPublished");
                var divCopyNewsPublished = (System.Web.UI.HtmlControls.HtmlGenericControl)pnlModal.FindControl("divCopyNewsPublished");

                btnCopyModal.Visible = false;
                pnlModal.Visible = false;

                if (news != null && news.NewsID > 0 && canCreate)
                {
                    if (!Page.IsPostBack)
                        txtCopyNewsTitle.Text = "Copy of " + news.Title;
                    btnCopyNews.Text = ResourceHelper.GetResourceString("NewsResources", "CopyNewsButton");
                    btnCopyModal.Text = ResourceHelper.GetResourceString("NewsResources", "CopyNewsButton");
                    btnCopyModal.Attributes["data-target"] = "#" + pnlModal.ClientID;

                    btnCopyModal.Visible = true;
                    pnlModal.Visible = true;

                    if (WebConfigSettings.EnableContentWorkflow && siteSettings.EnableContentWorkflow)
                    {
                        if (workflowIsAvailable)
                        {
                            if (isAdmin)
                            {
                                divCopyNewsPublished.Visible = true;

                                if (!Page.IsPostBack)
                                    chkCopyNewsPublished.Checked = true;
                            }
                            else
                            {
                                divCopyNewsPublished.Visible = false;

                                if (!Page.IsPostBack)
                                    chkCopyNewsPublished.Checked = false;
                            }
                        }
                    }

                    btnCopyNews.Click += new EventHandler(btnCopyNews_Click);
                }
            }
        }

        private string GetNewsListBreadCrumb()
        {
            if (newsType > 0)
                return "~/News/NewsList.aspx?type=" + newsType.ToString();

            return "~/News/NewsList.aspx";
        }

        private string GetNewsEditBreadCrumb()
        {
            if (newsType > 0)
                return "~/News/NewsEdit.aspx?type=" + newsType.ToString();

            return "~/News/NewsEdit.aspx";
        }

        private void HideControls()
        {
            btnInsert.Visible = false;
            btnInsertAndNew.Visible = false;
            btnInsertAndClose.Visible = false;
            btnUpdate.Visible = false;
            btnUpdateAndNew.Visible = false;
            btnUpdateAndClose.Visible = false;
            btnDelete.Visible = false;

            btnAttributeUpdate.Visible = false;

            btnUpdateImage.Visible = false;
            btnDeleteImage.Visible = false;

            if (news == null)
            {
                btnInsert.Visible = canCreate;
                btnInsertAndNew.Visible = canCreate;
                btnInsertAndClose.Visible = (canCreate && canViewList);
            }
            else if (news != null && news.NewsID > 0)
            {
                if (!UserCanAuthorizeZone(news.ZoneID))
                {
                    SiteUtils.RedirectToEditAccessDeniedPage();
                    return;
                }

                btnUpdate.Visible = canUpdate;
                btnUpdateAndNew.Visible = (canUpdate && canCreate);
                btnUpdateAndClose.Visible = (canUpdate && canViewList);

                btnAttributeUpdate.Visible = canUpdate;

                btnUpdateImage.Visible = canUpdate;
                btnDeleteImage.Visible = canDelete;

                btnDelete.Visible = canDelete;
            }
        }

        private void LoadParams()
        {
            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();
            newsId = WebUtils.ParseInt32FromQueryString("NewsID", newsId);
            newsType = WebUtils.ParseInt32FromQueryString("type", newsType);

            if (newsType > 0)
            {
                bool found = false;
                List<EnumDefined> lstEnum = EnumDefined.LoadFromConfigurationXml("news", "newstype", "value");
                if (lstEnum.Count > 0)
                {
                    foreach (EnumDefined enumDefined in lstEnum)
                    {
                        if (newsType.ToString() == enumDefined.Value)
                        {
                            found = true;
                            break;
                        }
                    }
                }

                if (!found)
                    newsType = 0;
            }

            virtualRoot = WebUtils.GetApplicationRoot();
        }

        private void SetupScripts()
        {
            if (!Page.ClientScript.IsClientScriptBlockRegistered("sarissa"))
            {
                this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "sarissa", "<script src=\""
                    + ResolveUrl("~/ClientScript/sarissa/sarissa.js") + "\" type=\"text/javascript\"></script>");
            }

            if (!Page.ClientScript.IsClientScriptBlockRegistered("sarissa_ieemu_xpath"))
            {
                this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "sarissa_ieemu_xpath", "<script src=\""
                    + ResolveUrl("~/ClientScript/sarissa/sarissa_ieemu_xpath.js") + "\" type=\"text/javascript\"></script>");
            }

            SetupUrlSuggestScripts(this.txtTitle.ClientID, this.txtUrl.ClientID, this.hdnTitle.ClientID, this.spnUrlWarning.ClientID);
        }

        private void SetupUrlSuggestScripts(string inputText, string outputText, string referenceText, string warningSpan)
        {
            if (!Page.ClientScript.IsClientScriptBlockRegistered("friendlyurlsuggest"))
            {
                this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "friendlyurlsuggest", "<script src=\""
                    + ResolveUrl("~/ClientScript/friendlyurlsuggest_v2.js") + "\" type=\"text/javascript\"></script>");
            }

            string focusScript = string.Empty;
            if (newsId == -1) { focusScript = "document.getElementById('" + inputText + "').focus();"; }

            string hookupInputScript = "new UrlHelper( "
                + "document.getElementById('" + inputText + "'),  "
                + "document.getElementById('" + outputText + "'), "
                + "document.getElementById('" + referenceText + "'), "
                + "document.getElementById('" + warningSpan + "'), "
                + "\"" + SiteRoot + "/News/NewsUrlSuggestService.ashx" + "\""
                + "); " + focusScript;

            ScriptManager.RegisterStartupScript(this, this.GetType(), inputText + "urlscript", hookupInputScript, true);
        }

        #region Attribute

        string selAttribute = string.Empty;
        private void BindAttribute()
        {
            btnAttributeUp.Visible = false;
            btnAttributeDown.Visible = false;
            btnDeleteAttribute.Visible = false;

            if (news != null)
            {
                lbAttribute.Items.Clear();

                lbAttribute.Items.Add(new ListItem(NewsResources.AttributeNewLabel, ""));
                lbAttribute.DataSource = ContentAttribute.GetByContentAsc(news.NewsGuid);
                lbAttribute.DataBind();

                ListItem li = lbAttribute.Items.FindByValue(selAttribute);
                if (li != null)
                {
                    lbAttribute.ClearSelection();
                    li.Selected = true;
                }

                LanguageHelper.PopulateTab(tabAttributeLanguage, false);
            }
        }

        private void MoveUpDown(string direction)
        {
            if (news == null || news.NewsGuid == Guid.Empty)
                return;

            List<ContentAttribute> listAttribute = ContentAttribute.GetByContentAsc(news.NewsGuid);
            ContentAttribute attribute = null;
            if (lbAttribute.SelectedIndex > 0)
            {
                int delta;

                if (direction == "down")
                    delta = 3;
                else
                    delta = -3;

                attribute = listAttribute[lbAttribute.SelectedIndex - 1];
                attribute.DisplayOrder += delta;

                ContentAttribute.ResortAttribute(listAttribute);

                selAttribute = attribute.Guid.ToString();

                BindAttribute();
                PopulateAttributeControls();
            }
        }

        private void btnUpDown_Click(Object sender, EventArgs e)
        {
            string direction = ((LinkButton)sender).CommandName;
            MoveUpDown(direction);
        }

        void lbAttribute_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateAttributeControls();
        }

        void btnAttributeUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (!canUpdate)
                {
                    SiteUtils.RedirectToEditAccessDeniedPage();
                    return;
                }

                if (news != null && news.NewsID > 0 && lbAttribute.SelectedIndex > -1)
                {
                    ContentAttribute attribute = null;

                    if (lbAttribute.SelectedValue.Length > 0)
                        attribute = new ContentAttribute(new Guid(lbAttribute.SelectedValue));

                    bool isUpdate = true;
                    if (attribute == null || attribute.Guid == Guid.Empty)
                    {
                        attribute = new ContentAttribute();
                        attribute.SiteGuid = siteSettings.SiteGuid;
                        attribute.ContentGuid = news.NewsGuid;
                        attribute.DisplayOrder = ContentAttribute.GetNextSortOrder(news.NewsGuid);

                        isUpdate = false;
                    }

                    if (!IsAttributeLanguageTab())
                    {
                        attribute.Title = txtAttributeTitle.Text;
                        attribute.ContentText = edAttributeContent.Text;
                    }

                    if (attribute.Save())
                        SaveAttributeContentLanguage(attribute.Guid);

                    LogActivity.Write("Update news attribute", txtAttributeTitle.Text);

                    selAttribute = attribute.Guid.ToString();

                    BindAttribute();
                    PopulateAttributeControls();

                    news.ContentChanged += new ContentChangedEventHandler(news_ContentChanged);
                    SiteUtils.QueueIndexing();

                    if (isUpdate)
                        message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "UpdateSuccessMessage");
                    else
                        message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "InsertSuccessMessage");
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
        }


        void btnDeleteAttribute_Click(object sender, EventArgs e)
        {
            try
            {
                if (!canDelete)
                {
                    SiteUtils.RedirectToEditAccessDeniedPage();
                    return;
                }

                if (news != null && lbAttribute.SelectedValue.Length > 0)
                {
                    Guid guid = new Guid(lbAttribute.SelectedValue);
                    if (guid != Guid.Empty)
                    {
                        ContentLanguage.DeleteByContent(guid);
                        ContentAttribute.Delete(guid);
                        LogActivity.Write("Delete news attribute", lbAttribute.SelectedItem.Text);

                        news.ContentChanged += new ContentChangedEventHandler(news_ContentChanged);
                        SiteUtils.QueueIndexing();
                    }

                    selAttribute = lbAttribute.Items[lbAttribute.SelectedIndex - 1].Value;

                    BindAttribute();
                    PopulateAttributeControls();
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
        }

        protected void btnDeleteAttributeLanguage_Click(object sender, EventArgs e)
        {
            if (!IsAttributeLanguageTab())
                return;

            if (tabAttributeLanguage.SelectedIndex > 0 && lbAttribute.SelectedValue.Length == 36)
            {
                int languageId = Convert.ToInt32(tabAttributeLanguage.SelectedTab.Value);

                if (languageId > 0)
                {
                    ContentLanguage.Delete(new Guid(lbAttribute.SelectedValue), languageId);
                    message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "DeleteSuccessMessage");

                    PopulateAttributeControls();

                    news.ContentChanged += new ContentChangedEventHandler(news_ContentChanged);
                    SiteUtils.QueueIndexing();
                }
            }
        }

        protected void tabAttributeLanguage_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
        {
            PopulateAttributeControls();
        }

        private void PopulateAttributeControls()
        {
            btnAttributeUp.Visible = false;
            btnAttributeDown.Visible = false;

            if (lbAttribute.SelectedValue.Length > 0)
            {
                if (lbAttribute.Items.Count > 2)
                {
                    if (lbAttribute.SelectedIndex == 1)
                        btnAttributeDown.Visible = canUpdate;
                    else if (lbAttribute.SelectedIndex == (lbAttribute.Items.Count - 1))
                        btnAttributeUp.Visible = canUpdate;
                    else
                    {
                        btnAttributeDown.Visible = canUpdate;
                        btnAttributeUp.Visible = canUpdate;
                    }
                }

                btnDeleteAttribute.Visible = canDelete;
                btnAttributeUpdate.Text = ResourceHelper.GetResourceString("Resource", "UpdateButton");

                if (tabAttributeLanguage.Visible && tabAttributeLanguage.Tabs.Count == 1)
                    LanguageHelper.PopulateTab(tabAttributeLanguage, lbAttribute.SelectedValue.Length > 0);
            }
            else
            {
                btnDeleteAttribute.Visible = false;
                btnAttributeUpdate.Text = ResourceHelper.GetResourceString("Resource", "InsertButton");

                if (tabAttributeLanguage.Visible && tabAttributeLanguage.Tabs.Count != 1)
                    LanguageHelper.PopulateTab(tabAttributeLanguage, lbAttribute.SelectedValue.Length > 0);
            }

            PopulateDataLanguage(tabAttributeLanguage.SelectedTab);
        }

        private void PopulateDataLanguage(Telerik.Web.UI.RadTab tab)
        {
            txtAttributeTitle.Text = string.Empty;
            edAttributeContent.Text = string.Empty;
            btnDeleteAttributeLanguage.Visible = false;

            if (lbAttribute.SelectedValue.Length > 0)
            {
                ContentAttribute attribute = new ContentAttribute(new Guid(lbAttribute.SelectedValue));

                if (attribute == null || attribute.Guid == Guid.Empty)
                    return;

                if (IsAttributeLanguageTab())
                {
                    ContentLanguage content = new ContentLanguage(attribute.Guid, Convert.ToInt32(tab.Value));
                    if (content != null && content.Guid != Guid.Empty)
                    {
                        txtAttributeTitle.Text = content.Title;
                        edAttributeContent.Text = content.FullContent;
                        btnDeleteAttributeLanguage.Visible = true;
                    }
                }
                else
                {
                    txtAttributeTitle.Text = attribute.Title;
                    edAttributeContent.Text = attribute.ContentText;
                }
            }
        }

        private bool IsAttributeLanguageTab()
        {
            if (tabAttributeLanguage.Visible && tabAttributeLanguage.SelectedIndex > 0)
                return true;

            return false;
        }

        private void SaveAttributeContentLanguage(Guid contentGuid)
        {
            if (contentGuid == Guid.Empty || !IsAttributeLanguageTab())
                return;

            int languageID = -1;
            if (tabAttributeLanguage.SelectedIndex > 0)
                languageID = Convert.ToInt32(tabAttributeLanguage.SelectedTab.Value);

            if (languageID == -1)
                return;

            var content = new ContentLanguage(contentGuid, languageID);

            if (txtAttributeTitle.Text.Length > 0 || edAttributeContent.Text.Length > 0)
            {
                content.LanguageId = languageID;
                content.ContentGuid = contentGuid;
                content.SiteGuid = siteSettings.SiteGuid;
                content.Title = txtAttributeTitle.Text.Trim();
                content.FullContent = edAttributeContent.Text;
                content.Save();
            }
        }

        #endregion

        #region Images

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

            foreach (GridDataItem data in grid.Items)
            {
                Guid guid = new Guid(data.GetDataKeyValue("Guid").ToString());
                int languageId = (int)data.GetDataKeyValue("LanguageId");
                int displayOrder = (int)data.GetDataKeyValue("DisplayOrder");
                string title = data.GetDataKeyValue("Title").ToString();

                TextBox txtDisplayOrder = (TextBox)data.FindControl("txtDisplayOrder");
                DropDownList ddlLanguage = (DropDownList)data.FindControl("ddlLanguage");
                TextBox txtTitle = (TextBox)data.FindControl("txtTitle");
                RadAsyncUpload fupThumbnail = (RadAsyncUpload)data.FindControl("fupThumbnail");
                RadAsyncUpload fupImageFile = (RadAsyncUpload)data.FindControl("fupImageFile");

                int displayOrderNew = displayOrder;
                int.TryParse(txtDisplayOrder.Text, out displayOrderNew);

                int languageIdNew = languageId;
                if (ddlLanguage.SelectedValue.Length > 0)
                    int.TryParse(ddlLanguage.SelectedValue, out languageIdNew);

                if (
                    displayOrder != displayOrderNew
                    || languageId != languageIdNew
                    || title != txtTitle.Text.Trim()
                    || fupImageFile.UploadedFiles.Count > 0
                    || fupThumbnail.UploadedFiles.Count > 0
                    )
                {
                    ContentMedia media = new ContentMedia(guid);
                    if (media != null && media.Guid != Guid.Empty)
                    {
                        media.Title = txtTitle.Text.Trim();
                        media.DisplayOrder = displayOrderNew;
                        media.LanguageId = languageIdNew;

                        if (fupImageFile.UploadedFiles.Count > 0)
                        {
                            UploadedFile file = fupImageFile.UploadedFiles[0];

                            string ext = file.GetExtension();
                            if (SiteUtils.IsAllowedUploadBrowseFile(ext, WebConfigSettings.ImageFileExtensions))
                            {
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

                                //updating with a new image so delete the previous version
                                fileSystem.DeleteFile(imageFolderPath + media.MediaFile);

                                file.SaveAs(Server.MapPath(newImagePath));

                                media.MediaFile = newFileName;
                            }
                        }
                        if (fupThumbnail.UploadedFiles.Count > 0)
                        {
                            UploadedFile file = fupThumbnail.UploadedFiles[0];

                            string ext = file.GetExtension();
                            if (SiteUtils.IsAllowedUploadBrowseFile(ext, WebConfigSettings.ImageFileExtensions))
                            {
                                string newFileName = file.FileName.ToCleanFileName(WebConfigSettings.ForceLowerCaseForUploadedFiles);
                                string newImagePath = VirtualPathUtility.Combine(thumbnailImageFolderPath, newFileName);

                                if (media.ThumbnailFile == newFileName)
                                {
                                    // an existing image delete the old one
                                    fileSystem.DeleteFile(newImagePath);
                                }
                                else
                                {
                                    // this is a new newsImage instance, make sure we don't use the same file name as any other instance
                                    int i = 1;
                                    while (fileSystem.FileExists(VirtualPathUtility.Combine(thumbnailImageFolderPath, newFileName)))
                                    {
                                        newFileName = i.ToInvariantString() + newFileName;
                                        i += 1;
                                    }

                                }

                                newImagePath = VirtualPathUtility.Combine(thumbnailImageFolderPath, newFileName);

                                //updating with a new image so delete the previous version
                                fileSystem.DeleteFile(imageFolderPath + "thumbs/" + media.ThumbnailFile);

                                file.SaveAs(Server.MapPath(newImagePath));

                                media.ThumbnailFile = newFileName;
                            }
                        }

                        media.Save();
                    }
                }
            }

            grid.Rebind();
            updImages.Update();
        }

        protected void btnDeleteImage_Click(Object sender, EventArgs e)
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
                if (WebConfigSettings.AllowMultiLanguage)
                {
                    listLanguages = LanguageHelper.GetPublishedLanguages();
                }

                listMedia = ContentMedia.GetByContentDesc(news.NewsGuid);
                grid.DataSource = listMedia;

                if (listMedia.Count > 0)
                    btnDeleteImage.Visible = true;
            }

            if (listLanguages.Count > 1)
                grid.MasterTableView.GetColumn("LanguageID").Visible = true;
            else
                grid.MasterTableView.GetColumn("LanguageID").Visible = false;
        }

        List<Language> listLanguages = new List<Language>();
        protected void grid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is Telerik.Web.UI.GridDataItem)
            {
                Telerik.Web.UI.GridDataItem item = (Telerik.Web.UI.GridDataItem)e.Item;

                DropDownList ddlLanguage = (DropDownList)item.FindControl("ddlLanguage");
                string languageId = item.GetDataKeyValue("LanguageId").ToString();

                if (ddlLanguage != null && listLanguages.Count > 1)
                {
                    ddlLanguage.Items.Clear();
                    ddlLanguage.DataSource = listLanguages;
                    ddlLanguage.DataBind();

                    ddlLanguage.Items.Insert(0, new ListItem(NewsResources.NewsEditLanguageNotCareLabel, "-1"));

                    ListItem li = ddlLanguage.Items.FindByValue(languageId);
                    if (li != null)
                    {
                        ddlLanguage.ClearSelection();
                        li.Selected = true;
                    }
                }
            }
        }

        #endregion

        #region OnInit

        override protected void OnInit(EventArgs e)
        {
            base.OnInit(e);

            SiteUtils.SetupEditor(edFullContent, AllowSkinOverride, Page);
            SiteUtils.SetupEditor(edBriefContent, AllowSkinOverride, Page);
            SiteUtils.SetupEditor(edAttributeContent, AllowSkinOverride, Page);

            this.Load += new EventHandler(this.Page_Load);

            this.btnUpdate.Click += new EventHandler(btnUpdate_Click);
            this.btnUpdateAndNew.Click += new EventHandler(btnUpdateAndNew_Click);
            this.btnUpdateAndClose.Click += new EventHandler(btnUpdateAndClose_Click);
            this.btnInsert.Click += new EventHandler(btnInsert_Click);
            this.btnInsertAndNew.Click += new EventHandler(btnInsertAndNew_Click);
            this.btnInsertAndClose.Click += new EventHandler(btnInsertAndClose_Click);
            this.btnDelete.Click += new EventHandler(btnDelete_Click);

            btnDeleteAttribute.Click += new EventHandler(btnDeleteAttribute_Click);
            btnAttributeUpdate.Click += new EventHandler(btnAttributeUpdate_Click);
            lbAttribute.SelectedIndexChanged += new EventHandler(lbAttribute_SelectedIndexChanged);
            btnAttributeUp.Click += new EventHandler(btnUpDown_Click);
            btnAttributeDown.Click += new EventHandler(btnUpDown_Click);
        }

        #endregion

        #region Workflow

        private bool workflowIsAvailable = false;
        private bool isReviewRole = false;
        private int workflowId = -1;
        private int firstWorkflowStateId = -1;
        private int lastWorkflowStateId = -1;

        private void SetupWorkflow()
        {
            if (WebConfigSettings.EnableContentWorkflow && siteSettings.EnableContentWorkflow)
            {
                workflowId = WorkflowHelper.GetWorkflowId(News.FeatureGuid);
                workflowIsAvailable = WorkflowHelper.WorkflowIsAvailable(workflowId);
                if (workflowIsAvailable)
                {
                    firstWorkflowStateId = WorkflowHelper.GetFirstWorkflowStateId(workflowId);
                    lastWorkflowStateId = WorkflowHelper.GetLastWorkflowStateId(workflowId);

                    if (isAdmin)
                    {
                        divIsPublished.Visible = true;
                        //divStartDate.Visible = true;
                        //divEndDate.Visible = true;

                        if (!Page.IsPostBack)
                            chkIsPublished.Checked = true;
                    }
                    else
                    {
                        divIsPublished.Visible = false;
                        //divStartDate.Visible = false;
                        //divEndDate.Visible = false;

                        if (!Page.IsPostBack)
                            chkIsPublished.Checked = false;
                    }

                    if ((news == null || news.NewsID == -1))
                        canUpdate = canCreate;
                    else if (news.StateId.HasValue)
                    {
                        pnlWorkflow.Visible = true;

                        //Populate
                        statusIcon.ImageUrl = Page.ResolveUrl("~/Data/SiteImages/info.gif");
                        litCreatedBy.Text = news.CreatedByName;
                        litCreatedOn.Text = DateTimeHelper.GetLocalTimeString(news.LastModUtc, timeZone, timeOffset);

                        lnkRejectContent.NavigateUrl = SiteRoot + "/News/RejectContent.aspx?NewsID=" + newsId.ToInvariantString();
                        lnkRejectContent.ImageUrl = Page.ResolveUrl(WebConfigSettings.RejectContentImage);
                        lnkRejectContent.ToolTip = NewsResources.RejectContentToolTip;

                        ibApproveContent.CommandArgument = newsId.ToInvariantString();
                        ibApproveContent.ImageUrl = Page.ResolveUrl(WebConfigSettings.ApproveContentImage);
                        ibApproveContent.ToolTip = NewsResources.ApproveContentToolTip;

                        WorkflowState workflowState = WorkflowHelper.GetWorkflowState(workflowId, news.StateId.Value);
                        if (workflowState != null && workflowState.StateId > 0)
                        {
                            isReviewRole = WorkflowHelper.UserHasStatePermission(workflowId, news.StateId.Value) && UserCanAuthorizeZone(news.ZoneID);

                            statusIcon.ToolTip = workflowState.StateName;
                            litWorkflowStatus.Text = workflowState.StateName;
                        }

                        if (news.ApprovedUtc.HasValue)
                        {
                            divRecentActionBy.Visible = true;
                            divRecentActionOn.Visible = true;
                            litRecentActionBy.Text = news.ApprovedBy;
                            litRecentActionOn.Text = DateTimeHelper.GetLocalTimeString(news.ApprovedUtc, timeZone, timeOffset);
                        }

                        if (!news.IsPublished)
                        {
                            ibApproveContent.Visible = isReviewRole;

                            if (!string.IsNullOrEmpty(news.RejectedNotes))
                            {
                                divRejection.Visible = true;
                                ltlRejectionReason.Text = news.RejectedNotes;
                            }
                        }

                        if (news.StateId.Value == firstWorkflowStateId)
                        {
                            ibApproveContent.ImageUrl = Page.ResolveUrl(WebConfigSettings.RequestApprovalImage);
                            ibApproveContent.ToolTip = NewsResources.RequestApprovalToolTip;

                            if (news.UserGuid == currentUser.UserGuid && !news.IsPublished)
                            {
                                canUpdate = true;
                                canDelete = true;
                            }
                        }
                        else
                        {
                            lnkRejectContent.Visible = isReviewRole;
                        }
                    }
                }
            }
        }

        protected void ibApproveContent_Command(object sender, CommandEventArgs e)
        {
            if (currentUser == null || !isReviewRole)
                return;

            News news = new News(siteSettings.SiteId, Convert.ToInt32(e.CommandArgument));
            if (news == null || news.NewsID == -1 || !news.StateId.HasValue) { return; }

            news.StateId = WorkflowHelper.GetNextWorkflowStateId(workflowId, news.StateId.Value);
            news.ApprovedUserGuid = currentUser.UserGuid;
            news.ApprovedBy = Context.User.Identity.Name.Trim();
            news.ApprovedUtc = DateTime.UtcNow;
            news.RejectedNotes = null;
            bool result = news.SaveState(lastWorkflowStateId);

            if (result)
            {
                if (!WebConfigSettings.DisableWorkflowNotification)
                {
                    NewsHelper.SendApprovalRequestNotification(
                        SiteUtils.GetSmtpSettings(),
                        siteSettings,
                        workflowId,
                        currentUser,
                        news);
                }

                if (canUpdate || WorkflowHelper.UserHasStatePermission(workflowId, news.StateId.Value))
                {
                    WebUtils.SetupRedirect(this, Request.RawUrl);
                    return;
                }

                if (canViewList)
                    WebUtils.SetupRedirect(this, GetNewsListPage(ddZones.SelectedValue));
                else
                {
                    ZoneSettings zoneSettings = new ZoneSettings(siteSettings.SiteId, news.ZoneID);
                    WebUtils.SetupRedirect(this, SiteUtils.GetZoneUrl(zoneSettings));
                }
            }
        }

        #endregion

    }
}