/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2014-06-28

using System;
using System.Text;
using System.Web.UI;
using log4net;
using CanhCam.Business;
using CanhCam.Business.WebHelpers;
using CanhCam.Web.Framework;
using Resources;
using System.Xml;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsViewControl : UserControl
    {
        #region Properties

        private static readonly ILog log = LogManager.GetLogger(typeof(NewsViewControl));

        private NewsConfiguration config = new NewsConfiguration();
        private SiteUser currentUser = null;
        private string virtualRoot;
        private News news = null;
        private Module md;

        private int zoneId = -1;
        private int newsId = -1;
        private int languageId = -1;
        private int pageNumber = 1;
        private int totalPages = 1;

        private bool parametersAreInvalid = false;
        private Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;

        private string siteRoot = string.Empty;
        private CmsBasePage basePage;
        private bool userCanUpdate = false;

        public Module module
        {
            get { return md; }
            set { md = value; }
        }

        public NewsConfiguration Config
        {
            get { return config; }
            set { config = value; }
        }

        #endregion

        #region OnInit

        override protected void OnInit(EventArgs e)
        {
            this.Load += new EventHandler(this.Page_Load);
            base.OnInit(e);
            //this.EnableViewState = this.UserCanEditPage();
            basePage = Page as CmsBasePage;
            siteRoot = basePage.SiteRoot;
        }

        #endregion

        protected virtual void Page_Load(object sender, EventArgs e)
        {
            LoadParams();

            if (parametersAreInvalid)
            {
                pnlInnerWrap.Visible = false;
                return;
            }

            LoadSettings();

            //SetupRssLink();
            PopulateLabels();

            if (!IsPostBack && newsId > 0)
            {
                PopulateControls();
                basePage.LastPageVisited = Request.RawUrl;
            }
        }

        protected void PopulateControls()
        {
            if (parametersAreInvalid)
            {
                pnlInnerWrap.Visible = false;
                return;
            }

            if (news.IsDeleted)
            {
                if (WebConfigSettings.Custom404Page.Length > 0)
                    Server.Transfer(WebConfigSettings.Custom404Page);
                else
                    Server.Transfer("~/PageNotFound.aspx");

                return;
            }

            if (news.IsPublished && news.EndDate < DateTime.UtcNow)
            {
                expired.Visible = true;
                //http://support.google.com/webmasters/bin/answer.py?hl=en&answer=40132
                // 410 means the resource is gone but once existed
                // google treats it as more permanent than a 404
                // and it should result in de-indexing the content
                Response.StatusCode = 410;
                Response.StatusDescription = "Content Expired";
                if (
                    !NewsPermission.CanUpdate
                    || !basePage.UserCanAuthorizeZone(news.ZoneID)
                    )
                {
                    pnlInnerWrap.Visible = false;
                    return;
                }
            }

            // if not published only the editor can see it
            if (!news.IsPublished)
            {
                bool stopRedirect = false;

                if (WebConfigSettings.EnableContentWorkflow && basePage.SiteInfo.EnableContentWorkflow)
                {
                    if (news.StateId.HasValue && WorkflowHelper.UserHasStatePermission(workflowId, news.StateId.Value))
                        stopRedirect = true;
                }
                else
                {
                    if (
                            (currentUser != null && currentUser.UserGuid == news.UserGuid)
                            || (NewsPermission.CanUpdate && basePage.UserCanAuthorizeZone(news.ZoneID))
                        )
                    {
                        stopRedirect = true;
                    }
                }

                if (!stopRedirect)
                {
                    pnlInnerWrap.Visible = false;
                    WebUtils.SetupRedirect(this, SiteUtils.GetCurrentZoneUrl());
                    return;
                }
            }

            SetupMetaTags();

            XmlDocument doc = new XmlDocument();
            doc.LoadXml("<NewsDetail></NewsDetail>");
            XmlElement root = doc.DocumentElement;

            //XmlHelper.AddNode(doc, root, "ModuleTitle", module.ModuleTitle);
            XmlHelper.AddNode(doc, root, "ZoneTitle", basePage.CurrentZone.Name);
            XmlHelper.AddNode(doc, root, "ZoneDescription", basePage.CurrentZone.Description);
            XmlHelper.AddNode(doc, root, "ViewMore", NewsResources.NewsMoreLinkText);
            XmlHelper.AddNode(doc, root, "Title", news.Title);
            XmlHelper.AddNode(doc, root, "SubTitle", news.SubTitle);
            XmlHelper.AddNode(doc, root, "ZoneUrl", SiteUtils.GetCurrentZoneUrl());

            if (module.ResourceFileDef.Length > 0 && module.ResourceKeyDef.Length > 0)
            {
                List<string> lstResourceKeys = module.ResourceKeyDef.SplitOnCharAndTrim(';');

                foreach (string item in lstResourceKeys)
                {
                    XmlHelper.AddNode(doc, root, item, ResourceHelper.GetResourceString(module.ResourceFileDef, item));
                }
            }

            XmlHelper.AddNode(doc, root, "EditLink", NewsHelper.BuildEditLink(news, basePage, userCanUpdate, currentUser));

            //XmlHelper.AddNode(doc, root, "ViewCVLink", GetCVListLink(news.NewsID, news.CommentCount, NewsPermission.CanManageComment));
            XmlHelper.AddNode(doc, root, "ApplyText", NewsResources.JobApplyLable);
            XmlHelper.AddNode(doc, root, "ApplyUrl", this.siteRoot + "/News/JobApplyDialog.aspx?zoneid=" + zoneId.ToString() + "&NewsID=" + newsId.ToString());

            XmlHelper.AddNode(doc, root, "ShowOption", news.ShowOption.ToString());

            XmlHelper.AddNode(doc, root, "CreatedDate", FormatDate(news.StartDate, NewsResources.NewsDateFormat));
            XmlHelper.AddNode(doc, root, "CreatedTime", FormatDate(news.StartDate, NewsResources.NewsTimeFormat));
            XmlHelper.AddNode(doc, root, "CreatedDD", FormatDate(news.StartDate, "dd"));
            XmlHelper.AddNode(doc, root, "CreatedYY", FormatDate(news.StartDate, "yy"));
            XmlHelper.AddNode(doc, root, "CreatedYYYY", FormatDate(news.StartDate, "yyyy"));
            XmlHelper.AddNode(doc, root, "CreatedMM", FormatDate(news.StartDate, "MM"));
            if (WorkingCulture.DefaultName.ToLower() == "vi-vn")
            {
                string monthVI = "Tháng " + FormatDate(news.StartDate, "MM");
                XmlHelper.AddNode(doc, root, "CreatedMMM", monthVI);
                XmlHelper.AddNode(doc, root, "CreatedMMMM", monthVI);
            }
            else
            {
                XmlHelper.AddNode(doc, root, "CreatedMMM", FormatDate(news.StartDate, "MMM"));
                XmlHelper.AddNode(doc, root, "CreatedMMMM", FormatDate(news.StartDate, "MMMM"));
            }

            XmlHelper.AddNode(doc, root, "Code", news.Code);
            XmlHelper.AddNode(doc, root, "BriefContent", news.BriefContent);
            XmlHelper.AddNode(doc, root, "FullContent", news.FullContent);
            XmlHelper.AddNode(doc, root, "ViewCount", news.Viewed.ToString());
            XmlHelper.AddNode(doc, root, "FileUrl", news.FileAttachment);

            if (displaySettings.ShowNextPreviousLink)
            {
                BuildNextPreviousXml(doc, root);
            }

            XmlHelper.AddNode(doc, root, "FacebookLike", RenderFacebookLike());
            XmlHelper.AddNode(doc, root, "PlusOne", RenderPlusOne());
            XmlHelper.AddNode(doc, root, "TweetThis", RenderTweetThis());
            XmlHelper.AddNode(doc, root, "Print", RenderPrinter());
            XmlHelper.AddNode(doc, root, "Email", RenderEmailSubject());
            XmlHelper.AddNode(doc, root, "FullUrl", NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID));

            if (displaySettings.ShowAttribute)
                BuildNewsAttributesXml(doc, root, languageId);

            BuildNewsImagesXml(doc, root);

            #region Start news other

            BuildNewsOtherXml(doc, root, zoneId, pageNumber, config.RelatedItemsToShow, out totalPages);
            if (NewsHelper.IsAjaxRequest(Request) && WebUtils.ParseBoolFromQueryString("isajax", false))
            {
                Response.Write(XmlHelper.TransformXML(SiteUtils.GetXsltBasePath("news", config.XsltFileNameDetailPage), doc));
                Response.End();
                return;
            }

            string pageUrlLeaveOutPageNumber = NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID);

            if (config.HidePaginationOnDetailPage)
                divPager.Visible = false;
            else
            {
                string pageUrl = pageUrlLeaveOutPageNumber;
                if (WebUtils.ParseInt32FromQueryString("NewsId", -1) == -1 && config.LoadFirstItem)
                    pageUrl = SiteUtils.GetCurrentZoneUrl();

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
            }

            if (WebUtils.ParseInt32FromQueryString("pagenumber", -1) == 1)
                basePage.AdditionalMetaMarkup += "\n<link rel=\"canonical\" href=\"" + pageUrlLeaveOutPageNumber + "\" />";

            #endregion

            XmlHelper.XMLTransform(xmlTransformer, SiteUtils.GetXsltBasePath("news", config.XsltFileNameDetailPage), doc);

            News.IncrementViewedCount(news.NewsID);
        }

        private string GetCVListLink(int newsId, int commentCount, bool isEditable)
        {
            if (!isEditable)
                return string.Empty;

            return "<a class='view-link gb-popup' title='" + NewsResources.JobViewCVTitle + "' href='" + this.siteRoot + "/News/JobCVListDialog.aspx?zoneid=" + zoneId.ToString() + "&amp;NewsID=" + newsId
                + "'>" + string.Format(NewsResources.JobViewCVFormat, commentCount) + "</a>";
        }

        private void SetupMetaTags()
        {
            string title = news.Title;
            if (news.MetaTitle.Length > 0)
            {
                basePage.Title = news.MetaTitle;
                title = news.MetaTitle;
            }
            else
            {
                basePage.Title = SiteUtils.FormatPageTitle(basePage.SiteInfo, news.Title);
            }

            if (news.MetaKeywords.Length > 0)
            {
                basePage.MetaKeywordCsv = news.MetaKeywords;
            }
            else if (basePage.SiteInfo.MetaKeyWords.Length > 0)
            {
                basePage.MetaKeywordCsv = basePage.SiteInfo.GetMetaKeyWords(WorkingCulture.LanguageId);
            }

            if (news.MetaDescription.Length > 0)
            {
                basePage.MetaDescription = news.MetaDescription;
            }
            else if (news.BriefContent.Length > 0)
            {
                basePage.MetaDescription = UIHelper.CreateExcerpt(news.BriefContent, 156);
            }
            else if (news.FullContent.Length > 0)
            {
                basePage.MetaDescription = UIHelper.CreateExcerpt(news.FullContent, 156);
            }

            if (title.Length > 0)
                basePage.AdditionalMetaMarkup += "\n<meta property=\"og:title\" content=\"" + title + "\" />";
            if (basePage.MetaDescription.Length > 0)
                basePage.AdditionalMetaMarkup += "\n<meta property=\"og:description\" content=\"" + basePage.MetaDescription + "\" />";

            basePage.AdditionalMetaMarkup += "\n<meta property=\"og:url\" content=\"" + NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID) + "\" />";
            basePage.AdditionalMetaMarkup += "\n<meta property=\"og:site_name\" content=\"" + basePage.SiteInfo.SiteName + "\" />";
            basePage.AdditionalMetaMarkup += "\n<meta property=\"og:type\" content=\"article\" />";

            if (title.Length > 0)
                basePage.AdditionalMetaMarkup += "\n<meta itemprop=\"name\" content=\"" + title + "\" />";
            if (basePage.MetaDescription.Length > 0)
                basePage.AdditionalMetaMarkup += "\n<meta itemprop=\"description\" content=\"" + basePage.MetaDescription + "\" />";

            ZoneSettings currentZone = CacheHelper.GetCurrentZone();
            if (basePage.SiteInfo.MetaAdditional.Length > 0)
            {
                basePage.AdditionalMetaMarkup = basePage.SiteInfo.MetaAdditional;
            }
            if (currentZone.AdditionalMetaTags.Length > 0)
            {
                basePage.AdditionalMetaMarkup += currentZone.AdditionalMetaTags;
            }
            if (news.AdditionalMetaTags.Length > 0)
            {
                basePage.AdditionalMetaMarkup += news.AdditionalMetaTags;
            }
        }

        #region GenXML

        public void BuildNextPreviousXml(
            XmlDocument doc,
            XmlElement root)
        {
            news.LoadNextPrevious(languageId);

            if ((news.PreviousNewsId > -1) || (news.PreviousNewsUrl.Length > 0))
            {
                XmlHelper.AddNode(doc, root, "PreviousLink", "<a href='" + NewsHelper.FormatNewsUrl(news.PreviousNewsUrl, news.PreviousNewsId, news.PreviousZoneId) + "' title='" + news.PreviousNewsTitle + "'>" + NewsResources.NewsPreviousLink + "</a>");
                XmlHelper.AddNode(doc, root, "PreviousUrl", NewsHelper.FormatNewsUrl(news.PreviousNewsUrl, news.PreviousNewsId, news.PreviousZoneId));
                XmlHelper.AddNode(doc, root, "PreviousNewsTitle", news.PreviousNewsTitle);
                XmlHelper.AddNode(doc, root, "PreviousTitle", NewsResources.NewsPreviousLink.Replace("<<", "").Replace(">>", ""));
                XmlHelper.AddNode(doc, root, "IsFirstNews", news.IsFirstNews.ToString().ToLower());
                XmlHelper.AddNode(doc, root, "IsLastNews", news.IsLastNews.ToString().ToLower());
            }
            if ((news.NextNewsId > -1) || (news.NextNewsUrl.Length > 0))
            {
                XmlHelper.AddNode(doc, root, "NextLink", "<a href='" + NewsHelper.FormatNewsUrl(news.NextNewsUrl, news.NextNewsId, news.NextZoneId) + "' title='" + news.NextNewsTitle + "'>" + NewsResources.NewsNextLink + "</a>");
                XmlHelper.AddNode(doc, root, "NextUrl", NewsHelper.FormatNewsUrl(news.NextNewsUrl, news.NextNewsId, news.NextZoneId));
                XmlHelper.AddNode(doc, root, "NextNewsTitle", news.NextNewsTitle);
                XmlHelper.AddNode(doc, root, "NextTitle", NewsResources.NewsNextLink.Replace("<<", "").Replace(">>", ""));
                XmlHelper.AddNode(doc, root, "IsFirstNews", news.IsFirstNews.ToString().ToLower());
                XmlHelper.AddNode(doc, root, "IsLastNews", news.IsLastNews.ToString().ToLower());
            }
        }

        public void BuildNewsImagesXml(
            XmlDocument doc,
            XmlElement root)
        {
            string imageFolderPath = NewsHelper.MediaFolderPath(basePage.SiteId, news.NewsID);
            string thumbnailImageFolderPath = imageFolderPath + "thumbs/";
            string siteRoot = WebUtils.GetSiteRoot();

            int defaultLanguageId = -1;
            string defaultCulture = WebConfigSettings.DefaultLanguageCulture;
            if (defaultCulture.Length > 0)
                defaultLanguageId = LanguageHelper.GetLanguageIdByCulture(defaultCulture);

            List<int> listDisplayOrder = new List<int>();
            List<ContentMedia> listMedia = ContentMedia.GetByContentDesc(news.NewsGuid);
            foreach (ContentMedia media in listMedia)
            {
                if (media.LanguageId == -1 || media.LanguageId == languageId || (languageId == -1 && media.LanguageId == defaultLanguageId))
                {
                    BuildNewsImagesXml(doc, root, media, imageFolderPath, thumbnailImageFolderPath);

                    if (displaySettings.ShowGroupImages)
                    {
                        if (!listDisplayOrder.Contains(media.DisplayOrder))
                        {
                            listDisplayOrder.Add(media.DisplayOrder);
                            XmlElement groupImages = doc.CreateElement("GroupImages");
                            root.AppendChild(groupImages);
                            XmlHelper.AddNode(doc, groupImages, "DisplayOrder", media.DisplayOrder.ToString());

                            foreach (ContentMedia media2 in listMedia)
                            {
                                if ((media2.LanguageId == -1 || media2.LanguageId == languageId || (languageId == -1 && media2.LanguageId == defaultLanguageId))
                                    && (media2.DisplayOrder == media.DisplayOrder))
                                {
                                    BuildNewsImagesXml(doc, groupImages, media2, imageFolderPath, thumbnailImageFolderPath);
                                }
                            }
                        }
                    }

                    string relativePath = siteRoot + Page.ResolveUrl(imageFolderPath + media.MediaFile);
                    basePage.AdditionalMetaMarkup += "\n<meta property=\"og:image\" content=\"" + relativePath + "\" />";
                    basePage.AdditionalMetaMarkup += "\n<meta itemprop=\"image\" content=\"" + relativePath + "\" />";
                }
            }
        }

        public void BuildNewsImagesXml(
            XmlDocument doc,
            XmlElement root,
            ContentMedia media,
            string imageFolderPath,
            string thumbnailImageFolderPath)
        {
            XmlElement element = doc.CreateElement("NewsImages");
            root.AppendChild(element);

            XmlHelper.AddNode(doc, element, "Title", media.Title);
            XmlHelper.AddNode(doc, element, "DisplayOrder", media.DisplayOrder.ToString());
            XmlHelper.AddNode(doc, element, "ImageUrl", Page.ResolveUrl(imageFolderPath + media.MediaFile));
            XmlHelper.AddNode(doc, element, "ThumbnailUrl", Page.ResolveUrl(thumbnailImageFolderPath + media.ThumbnailFile));
        }

        public void BuildNewsOtherXml(
            XmlDocument doc,
            XmlElement root,
            int zoneId,
            int pageNumber,
            int pageSize,
            out int totalPages)
        {
            XmlHelper.AddNode(doc, root, "NewsOtherText", NewsResources.OtherNewsLabel);
            XmlHelper.AddNode(doc, root, "ProductOtherText", NewsResources.OtherProductLabel);
            XmlHelper.AddNode(doc, root, "ProjectOtherText", NewsResources.OtherProjectLabel);

            List<News> lstNews = new List<News>();
            if (pageSize < 0)
            {
                pageSize = -pageSize;
                totalPages = 1;
                int totalRows = News.GetCount(basePage.SiteId, zoneId, languageId, -1, -1);

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

                lstNews = News.GetPage(basePage.SiteId, zoneId, languageId, -1, -1, pageNumber, pageSize);
            }
            else
            {
                lstNews = News.GetPageNewsOther(zoneId, news.NewsID, languageId, config.NewsType, pageNumber, pageSize, out totalPages);
            }

            foreach (News news in lstNews)
            {
                XmlElement newsXml = doc.CreateElement("NewsOther");
                root.AppendChild(newsXml);

                NewsHelper.BuildNewsDataXml(doc, newsXml, news, timeZone, timeOffset, NewsHelper.BuildEditLink(news, basePage, userCanUpdate, currentUser));

                if (news.NewsID == newsId)
                    XmlHelper.AddNode(doc, newsXml, "IsActive", "true");
            }

            if (pageNumber < totalPages)
            {
                string pageUrl = NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID);

                int iNewsId = WebUtils.ParseInt32FromQueryString("NewsId", -1);
                if (iNewsId == -1 && config.LoadFirstItem)
                    pageUrl = SiteUtils.GetCurrentZoneUrl();

                if (pageUrl.Contains("?"))
                    pageUrl += "&pagenumber=" + (pageNumber + 1).ToString();
                else
                    pageUrl += "?pagenumber=" + (pageNumber + 1).ToString();

                XmlHelper.AddNode(doc, root, "NextPageUrl", pageUrl);
            }
        }

        public void BuildNewsAttributesXml(
            XmlDocument doc,
            XmlElement root, int languageId)
        {
            List<ContentAttribute> listAttributes = ContentAttribute.GetByContentAsc(news.NewsGuid, languageId);
            foreach (ContentAttribute attribute in listAttributes)
            {
                XmlElement element = doc.CreateElement("NewsAttributes");
                root.AppendChild(element);

                XmlHelper.AddNode(doc, element, "Title", attribute.Title);
                XmlHelper.AddNode(doc, element, "Content", attribute.ContentText);
            }
        }

        #endregion

        #region Render Social plugin

        private string RenderTweetThis()
        {
            string twitterWidgets = "<script type=\"text/javascript\">\n"
                                  + "!function (d, s, id) {\n"
                                  + "var js, fjs = d.getElementsByTagName(s)[0];\n"
                                  + "if (!d.getElementById(id)) {\n"
                                  + "js = d.createElement(s);\n"
                                  + "js.id = id; js.src = \"//platform.twitter.com/widgets.js\";\n"
                                  + "fjs.parentNode.insertBefore(js, fjs);\n"
                                  + "}\n"
                                  + "} (document, \"script\", \"twitter-wjs\");"
                                  + "</script>\n";

            Page.ClientScript.RegisterClientScriptBlock(typeof(Page),
                         "twitterwidgets", twitterWidgets);

            string twitterUrl = "https://twitter.com/share";

            string tweetThis = "<a class='twitter-share-button'";
            tweetThis += " title='Tweet This'";
            tweetThis += " href='" + twitterUrl + "'";
            tweetThis += " data-url='" + NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID) + "'";
            tweetThis += " data-text='" + news.Title + "'";
            tweetThis += " data-count='horizontal'";
            tweetThis += "></a>";

            return tweetThis;
        }

        private string RenderPlusOne()
        {
            Page.ClientScript.RegisterStartupScript(typeof(Page),
                             "gplusone", "\n<script type=\"text/javascript\" src=\""
                             + "https://apis.google.com/js/plusone.js" + "\"></script>", false);

            string plusOne = "<div class='g-plusone' data-size='medium' data-count='true'";
            plusOne += " data-href='" + NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID);
            plusOne += "'></div>";

            return plusOne;
        }

        private string RenderFacebookLike()
        {
            string facebook = string.Empty;

            if (WebConfigSettings.DisableFacebookLikeButton) { return facebook; }

            string facebookWidgets = "<script type=\"text/javascript\">\n"
                                  + "(function (d, s, id) {\n"
                                  + "var js, fjs = d.getElementsByTagName(s)[0];\n"
                                  + "if (d.getElementById(id)) return;\n"
                                  + "js = d.createElement(s); js.id = id\n"
                                  + "js.async=true;\n"
                                  + "js.src = \"//connect.facebook.net/en_US/all.js#xfbml=1\";\n"
                                  + "fjs.parentNode.insertBefore(js, fjs);\n"
                                  + "} (document, 'script', 'facebook-jssdk'));\n"
                                  + "</script>\n";

            Page.ClientScript.RegisterClientScriptBlock(typeof(Page),
                         "facebookwidgets", facebookWidgets);

            facebook = "<a class='fb-like'";
            facebook += " data-href='" + NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID) + "'";
            facebook += " data-send='false'";
            facebook += " data-layout='button_count'";
            facebook += " data-width='100'";
            facebook += " data-show-faces='false'";
            facebook += "></a>";

            return facebook;
        }

        private string RenderPrinter()
        {
            string url = WebUtils.GetUrlWithoutQueryString(Context.Request.RawUrl)
                + "?skin=printerfriendly"
                + WebUtils.BuildQueryString(WebUtils.GetQueryString(Context.Request.RawUrl), "skin");

            return string.Format("<a href='{0}' target='_blank' title='{1}' rel='nofollow'><span>{2}</span></a>",
                        Context.Server.HtmlEncode(url),
                        NewsResources.NewsPrintLink,
                        NewsResources.NewsPrintLink);
        }

        private string RenderEmailSubject()
        {
            SetupEmailSubjectScript();

            return string.Format("<a href='{0}' class='email-link' target='_blank' title='{1}' rel='nofollow'><span>{2}</span></a>",
                        siteRoot + "/News/EmailSubjectDialog.aspx?u=" + Context.Server.HtmlEncode(NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID)),
                        NewsResources.NewsEmailLink,
                        NewsResources.NewsEmailLink);
        }

        private void SetupEmailSubjectScript()
        {
            basePage.ScriptConfig.IncludeFancyBox = true;

            StringBuilder script = new StringBuilder();

            script.Append("<script type=\"text/javascript\">");

            string fancyBoxConfig = "{type:'iframe', width:500, height:400, title:{type:'outside'} }";
            script.Append("$('.popup-iframe a.email-link').fancybox(" + fancyBoxConfig + "); ");

            script.Append("</script>");

            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "cbemailsubjectinit", script.ToString());
        }

        #endregion

        protected string FormatDate(object startDate, string format = "")
        {
            if (startDate == null)
                return string.Empty;

            if (timeZone != null)
            {
                return TimeZoneInfo.ConvertTimeFromUtc(Convert.ToDateTime(startDate), timeZone).ToString(format);
            }

            return Convert.ToDateTime(startDate).AddHours(timeOffset).ToString(format);
        }

        private void PopulateLabels()
        {

        }

        private void LoadSettings()
        {
            if ((news == null || news.NewsID == -1) && newsId > 0)
                news = new News(basePage.SiteId, newsId, languageId);

            currentUser = SiteUtils.GetCurrentSiteUser();
            userCanUpdate = NewsPermission.CanUpdate;
            pageNumber = WebUtils.ParseInt32FromQueryString("pagenumber", pageNumber);

            SetupWorkflow();
            //SetupCommentSystem();
        }

        //private void SetupCommentSystem()
        //{
        //    comment.Config = config;
        //    comment.News = news;
        //    comment.IsEditable = isEditable;
        //}

        private void LoadParams()
        {
            virtualRoot = WebUtils.GetApplicationRoot();
            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();
            zoneId = WebUtils.ParseInt32FromQueryString("zoneId", -1);
            newsId = WebUtils.ParseInt32FromQueryString("NewsId", -1);
            languageId = WorkingCulture.LanguageId;

            int iNewsId = WebUtils.ParseInt32FromQueryString("NewsId", -1);
            if (iNewsId == -1 && config.LoadFirstItem)
            {
                news = News.GetOneByZone(zoneId, languageId);
                if (news != null && news.NewsID > 0)
                    newsId = Convert.ToInt32(news.NewsID);
            }

            if (zoneId == -1) parametersAreInvalid = true;
            if (newsId == -1) parametersAreInvalid = true;
            //if (!basePage.UserCanViewPage(moduleId)) { parametersAreInvalid = true; }
        }

        #region Workflow

        private bool workflowIsAvailable = false;
        private bool isReviewRole = false;
        private int workflowId = -1;
        private int firstWorkflowStateId = -1;
        private int lastWorkflowStateId = -1;

        private void SetupWorkflow()
        {
            if (WebConfigSettings.EnableContentWorkflow && basePage.SiteInfo.EnableContentWorkflow)
            {
                workflowId = WorkflowHelper.GetWorkflowId(News.FeatureGuid);
                workflowIsAvailable = WorkflowHelper.WorkflowIsAvailable(workflowId);
                if (workflowIsAvailable)
                {
                    firstWorkflowStateId = WorkflowHelper.GetFirstWorkflowStateId(workflowId);
                    lastWorkflowStateId = WorkflowHelper.GetLastWorkflowStateId(workflowId);

                    if (news != null && news.NewsID > 0 && news.StateId.HasValue)
                    {
                        pnlWorkflow.Visible = true;

                        //Populate
                        statusIcon.ImageUrl = Page.ResolveUrl("~/Data/SiteImages/info.gif");

                        lnkRejectContent.NavigateUrl = siteRoot + "/News/RejectContent.aspx?NewsID=" + newsId.ToInvariantString();
                        lnkRejectContent.ImageUrl = Page.ResolveUrl(WebConfigSettings.RejectContentImage);
                        lnkRejectContent.ToolTip = NewsResources.RejectContentToolTip;

                        ibApproveContent.CommandArgument = newsId.ToInvariantString();
                        ibApproveContent.ImageUrl = Page.ResolveUrl(WebConfigSettings.ApproveContentImage);
                        ibApproveContent.ToolTip = NewsResources.ApproveContentToolTip;

                        WorkflowState workflowState = WorkflowHelper.GetWorkflowState(workflowId, news.StateId.Value);
                        if (workflowState != null && workflowState.StateId > 0)
                        {
                            isReviewRole = (WorkflowHelper.UserHasStatePermission(workflowId, news.StateId.Value) && basePage.UserCanAuthorizeZone(zoneId));

                            statusIcon.ToolTip = workflowState.StateName;
                            statusIcon.Visible = isReviewRole;
                        }

                        if (!news.IsPublished)
                        {
                            ibApproveContent.Visible = isReviewRole;
                        }

                        if (news.StateId.Value == firstWorkflowStateId)
                        {
                            ibApproveContent.ImageUrl = Page.ResolveUrl(WebConfigSettings.RequestApprovalImage);
                            ibApproveContent.ToolTip = NewsResources.RequestApprovalToolTip;
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

            News news = new News(basePage.SiteId, Convert.ToInt32(e.CommandArgument));
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
                        basePage.SiteInfo,
                        workflowId,
                        currentUser,
                        news);
                }

                WebUtils.SetupRedirect(this, Request.RawUrl);
            }
        }

        #endregion

    }
}