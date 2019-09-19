/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2014-10-25
/// 2015-11-27: Show attributes in new list

using System;
using System.Web.UI;
using log4net;
using CanhCam.Business;
using CanhCam.Business.WebHelpers;
using CanhCam.Web.Framework;
using Resources;
using System.Xml;
using System.Collections.Generic;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsListControl : UserControl
    {
        #region Properties

        private static readonly ILog log = LogManager.GetLogger(typeof(NewsListControl));

        private SiteSettings siteSettings = null;
        private int pageNumber = 1;
        private int totalPages = 1;
        private bool showCommentCounts = true;
        private Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;
        private CmsBasePage basePage = null;
        private Module module = null;
        protected NewsConfiguration config = new NewsConfiguration();
        private int zoneId = -1;
        private int moduleId = -1;

        private bool userCanUpdate = false;

        private string siteRoot = string.Empty;
        private string imageSiteRoot = string.Empty;
        protected bool allowComments = false;

        private SiteUser currentUser = null;

        public string SiteRoot
        {
            get { return siteRoot; }
            set { siteRoot = value; }
        }

        public string ImageSiteRoot
        {
            get { return imageSiteRoot; }
            set { imageSiteRoot = value; }
        }

        public int ModuleId
        {
            get { return moduleId; }
            set { moduleId = value; }
        }

        public NewsConfiguration Config
        {
            get { return config; }
            set { config = value; }
        }

        private string moduleTitle = string.Empty;
        public string ModuleTitle
        {
            get { return moduleTitle; }
            set { moduleTitle = value; }
        }

        #endregion

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            this.EnableViewState = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadSettings();

            if (config.LoadFirstItem)
            {
                Visible = false;
                return;
            }

            PopulateLabels();
            PopulateControls();
        }

        private void PopulateControls()
        {
            XmlDocument doc = GetPageXml(zoneId, pageNumber, config.PageSize, out totalPages);

            if (NewsHelper.IsAjaxRequest(Request) && WebUtils.ParseBoolFromQueryString("isajax", false))
            {
                Response.Write(XmlHelper.TransformXML(SiteUtils.GetXsltBasePath("news", config.XsltFileName), doc));
                Response.End();
                return;
            }

            XmlHelper.XMLTransform(xmlTransformer, SiteUtils.GetXsltBasePath("news", config.XsltFileName), doc);

            string pageUrlLeaveOutPageNumber = SiteUtils.BuildUrlLeaveOutParam(Request.RawUrl, "pagenumber");
            string pageUrl = pageUrlLeaveOutPageNumber;
            if (pageUrl.Contains("?"))
                pageUrl += "&amp;pagenumber={0}";
            else
                pageUrl += "?pagenumber={0}";

            pgr.PageURLFormat = pageUrl;
            pgr.ShowFirstLast = true;
            pgr.PageSize = config.PageSize;
            pgr.PageCount = totalPages;
            pgr.CurrentIndex = pageNumber;
            divPager.Visible = (totalPages > 1);

            // Canonical pagin
            string nextUrl = string.Format(pageUrl, pageNumber + 1).Replace("&amp;pagenumber=", "&pagenumber=");
            string previousUrl = string.Format(pageUrl, pageNumber - 1).Replace("&amp;pagenumber=", "&pagenumber=");
            if (totalPages > 1)
            {
                if (pageNumber == 1) // first page
                {
                    basePage.AdditionalMetaMarkup += "\n<link rel='next' href='" + nextUrl + "' />";
                }
                else if (pageNumber == totalPages) // last page
                {
                    basePage.AdditionalMetaMarkup += "\n<link rel='prev' href='" + previousUrl + "' />";
                }
                else //other pages
                {
                    basePage.AdditionalMetaMarkup += "\n<link rel='prev' href='" + previousUrl + "' />";
                    basePage.AdditionalMetaMarkup += "\n<link rel='next' href='" + nextUrl + "' />";
                }
            }

            if (WebUtils.ParseInt32FromQueryString("pagenumber", -1) == 1)
                basePage.AdditionalMetaMarkup += "\n<link rel=\"canonical\" href=\"" + pageUrlLeaveOutPageNumber + "\" />";
        }

        public XmlDocument GetPageXml(int zoneId,
            int pageNumber,
            int pageSize,
            out int totalPages)
        {
            XmlDocument doc = new XmlDocument();
            doc.LoadXml("<NewsList></NewsList>");
            XmlElement root = doc.DocumentElement;

            XmlHelper.AddNode(doc, root, "ModuleTitle", this.moduleTitle);
            XmlHelper.AddNode(doc, root, "ZoneTitle", basePage.CurrentZone.Name);
            XmlHelper.AddNode(doc, root, "ZoneDescription", basePage.CurrentZone.Description);
            XmlHelper.AddNode(doc, root, "ViewMore", NewsResources.NewsMoreLinkText);
            XmlHelper.AddNode(doc, root, "SiteUrl", basePage.SiteRoot); // add 2013-08-21 Hontam's project
            XmlHelper.AddNode(doc, root, "PageNumber", pageNumber.ToString()); // add 2014-10-25 RitaCorp's project
            if (module != null && module.ResourceFileDef.Length > 0 && module.ResourceKeyDef.Length > 0)
            {
                List<string> lstResourceKeys = module.ResourceKeyDef.SplitOnCharAndTrim(';');

                foreach (string item in lstResourceKeys)
                {
                    XmlHelper.AddNode(doc, root, item, ResourceHelper.GetResourceString(module.ResourceFileDef, item));
                }
            }

            int languageId = WorkingCulture.LanguageId;
            List<News> lstNews = new List<News>();

            if (basePage.ViewMode == PageViewMode.WorkInProgress
                && WebConfigSettings.EnableContentWorkflow
                && siteSettings.EnableContentWorkflow
                //&& userCanUpdate && basePage.UserCanAuthorizeZone(zoneId)
                )
            {
                Guid? userGuid = null;

                string stateIdList = string.Empty;
                int workflowId = WorkflowHelper.GetWorkflowId(News.FeatureGuid);
                int firstWorkflowStateId = WorkflowHelper.GetFirstWorkflowStateId(workflowId);
                List<WorkflowState> lstWorkflowStates = WorkflowHelper.GetWorkflowStates(workflowId);
                foreach (WorkflowState wfState in lstWorkflowStates)
                {
                    if (WorkflowHelper.UserHasStatePermission(lstWorkflowStates, wfState.StateId))
                    {
                        if (wfState.StateId == firstWorkflowStateId)
                            userGuid = currentUser.UserGuid;
                        else
                            userGuid = null;

                        stateIdList += wfState.StateId + ";";
                    }
                }

                totalPages = 1;
                int totalRows = News.GetCountBySearch(siteSettings.SiteId, zoneId.ToString(), config.NewsType, -1, stateIdList, languageId, -1, -1, null, null, null, null, userGuid, string.Empty);

                if (pageSize > 0) totalPages = totalRows / pageSize;

                if (totalRows <= pageSize)
                {
                    totalPages = 1;
                }
                else if (pageSize > 0)
                {
                    int remainder;
                    Math.DivRem(totalRows, pageSize, out remainder);
                    if (remainder > 0)
                    {
                        totalPages += 1;
                    }
                }

                lstNews = News.GetPageBySearch(siteSettings.SiteId, zoneId.ToString(), config.NewsType, -1, stateIdList, languageId, -1, -1, null, null, null, null, userGuid,-1,-1, string.Empty, pageNumber, pageSize);
            }
            else
            {
                if (config.ShowAllNews)
                {
                    string childZoneIds = NewsHelper.GetChildZoneIdToSemiColonSeparatedString(siteSettings.SiteId, zoneId);

                    totalPages = 1;
                    int totalRows = News.GetCountByListZone(siteSettings.SiteId, childZoneIds, config.NewsType, -1, languageId);

                    if (pageSize > 0) totalPages = totalRows / pageSize;

                    if (totalRows <= pageSize)
                    {
                        totalPages = 1;
                    }
                    else if (pageSize > 0)
                    {
                        int remainder;
                        Math.DivRem(totalRows, pageSize, out remainder);
                        if (remainder > 0)
                        {
                            totalPages += 1;
                        }
                    }

                    lstNews = News.GetPageByListZone(siteSettings.SiteId, childZoneIds, config.NewsType, -1, languageId, pageNumber, pageSize);
                }
                else
                {
                    totalPages = 1;
                    int totalRows = News.GetCount(siteSettings.SiteId, zoneId, languageId, -1, -1);

                    if (pageSize > 0) totalPages = totalRows / pageSize;

                    if (totalRows <= pageSize)
                    {
                        totalPages = 1;
                    }
                    else if (pageSize > 0)
                    {
                        int remainder;
                        Math.DivRem(totalRows, pageSize, out remainder);
                        if (remainder > 0)
                        {
                            totalPages += 1;
                        }
                    }

                    lstNews = News.GetPage(siteSettings.SiteId, zoneId, languageId, -1, -1, pageNumber, pageSize);
                }
            }

            int newsId = WebUtils.ParseInt32FromQueryString("NewsId", -1);
            foreach (News news in lstNews)
            {
                XmlElement newsXml = doc.CreateElement("News");
                root.AppendChild(newsXml);

                NewsHelper.BuildNewsDataXml(doc, newsXml, news, timeZone, timeOffset, NewsHelper.BuildEditLink(news, basePage, userCanUpdate, currentUser));

                XmlHelper.AddNode(doc, newsXml, "ApplyText", NewsResources.JobApplyLable);
                XmlHelper.AddNode(doc, newsXml, "ApplyUrl", this.SiteRoot + "/News/JobApplyDialog.aspx?zoneid=" + zoneId.ToString() + "&NewsID=" + news.NewsID.ToString());

                if (newsId > 0)
                    if (news.NewsID == newsId)
                        XmlHelper.AddNode(doc, newsXml, "IsActive", "true");

                if (config.ShowAllImagesInNewsList)
                    BuildNewsImagesXml(doc, newsXml, news, languageId);

                //2015-11-27
                if (config.ShowAttributesInNewsList)
                    BuildNewsAttributesXml(doc, newsXml, news.NewsGuid, languageId);
            }

            if (pageNumber < totalPages)
            {
                string pageUrl = SiteUtils.GetCurrentZoneUrl();

                if (pageUrl.Contains("?"))
                    pageUrl += "&pagenumber=" + (pageNumber + 1).ToString();
                else
                    pageUrl += "?pagenumber=" + (pageNumber + 1).ToString();

                XmlHelper.AddNode(doc, root, "NextPageUrl", pageUrl);
            }

            return doc;
        }

        public void BuildNewsImagesXml(
            XmlDocument doc,
            XmlElement newsXml,
            News news,
            int languageId)
        {
            string imageFolderPath = NewsHelper.MediaFolderPath(basePage.SiteId, news.NewsID);
            string thumbnailImageFolderPath = imageFolderPath + "thumbs/";

            List<ContentMedia> listMedia = ContentMedia.GetByContentDesc(news.NewsGuid);
            foreach (ContentMedia media in listMedia)
            {
                if (media.LanguageId == -1 || media.LanguageId == languageId)
                {
                    XmlElement element = doc.CreateElement("NewsImages");
                    newsXml.AppendChild(element);

                    XmlHelper.AddNode(doc, element, "Title", media.Title);
                    XmlHelper.AddNode(doc, element, "ImageUrl", Page.ResolveUrl(imageFolderPath + media.MediaFile));
                    XmlHelper.AddNode(doc, element, "ThumbnailUrl", Page.ResolveUrl(thumbnailImageFolderPath + media.ThumbnailFile));
                }
            }
        }

        public void BuildNewsAttributesXml(
            XmlDocument doc,
            XmlElement newsXml,
            Guid newsGuid,
            int languageId)
        {
            List<ContentAttribute> listAttributes = ContentAttribute.GetByContentAsc(newsGuid, languageId);
            foreach (ContentAttribute attribute in listAttributes)
            {
                XmlElement element = doc.CreateElement("NewsAttributes");
                newsXml.AppendChild(element);

                XmlHelper.AddNode(doc, element, "Title", attribute.Title);
                XmlHelper.AddNode(doc, element, "Content", attribute.ContentText);
            }
        }

        private string GetCVListLink(int newsId, int commentCount, bool isEditable)
        {
            if (!isEditable)
                return string.Empty;

            return "<a class='view-link gb-popup' title='" + NewsResources.JobViewCVTitle + "' href='" + this.SiteRoot + "/News/JobCVListDialog.aspx?zoneid=" + zoneId.ToString() + "&amp;NewsID=" + newsId
                + "'>" + string.Format(NewsResources.JobViewCVFormat, commentCount) + "</a>";
        }

        protected virtual void PopulateLabels()
        {

        }

        protected virtual void LoadSettings()
        {
            siteSettings = CacheHelper.GetCurrentSiteSettings();
            zoneId = WebUtils.ParseInt32FromQueryString("zoneid", zoneId);
            currentUser = SiteUtils.GetCurrentSiteUser();
            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();
            pageNumber = WebUtils.ParseInt32FromQueryString("pagenumber", pageNumber);

            if (Page is CmsBasePage)
            {
                basePage = Page as CmsBasePage;
                module = basePage.GetModule(moduleId, News.FeatureGuid);
            }

            userCanUpdate = NewsPermission.CanUpdate;

            if (module == null) { return; }

            allowComments = Config.AllowComments && showCommentCounts;

            if (config.AllowComments)
            {
                //if ((DisqusSiteShortName.Length > 0) && (config.CommentSystem == "disqus"))
                //{
                //    disqusFlag = "#disqus_thread";
                //    disqus.SiteShortName = DisqusSiteShortName;
                //    disqus.RenderCommentCountScript = true;
                //}

                //if ((IntenseDebateAccountId.Length > 0) && (config.CommentSystem == "intensedebate"))
                //{
                //    showCommentCounts = false;
                //}

                if (config.CommentSystem == "facebook")
                {
                    showCommentCounts = false;
                }
            }
        }
    }
}