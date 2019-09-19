/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2015-05-18 //add ShowAllImagesInNewsList

using System;
using CanhCam.Web.Framework;
using Resources;
using System.Xml;
using CanhCam.Business;
using System.Collections.Generic;
using CanhCam.Business.WebHelpers;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsSpecial : SiteModuleControl
    {
        private NewsSpecialConfiguration config = null;
        private Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;
        private int pos = -1;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            this.EnableViewState = false;
        }

        protected virtual void Page_Load(object sender, EventArgs e)
        {
            LoadSettings();
            PopulateLabels();
            PopulateControls();
        }

        private void PopulateControls()
        {
            XmlDocument doc = new XmlDocument();

            doc.LoadXml("<NewsList></NewsList>");
            XmlElement root = doc.DocumentElement;

            XmlHelper.AddNode(doc, root, "ModuleTitle", this.Title);
            XmlHelper.AddNode(doc, root, "ZoneTitle", CurrentZone.Name);
            XmlHelper.AddNode(doc, root, "ViewMore", NewsResources.NewsMoreLinkText);

            if (ModuleConfiguration.ResourceFileDef.Length > 0 && ModuleConfiguration.ResourceKeyDef.Length > 0)
            {
                List<string> lstResourceKeys = ModuleConfiguration.ResourceKeyDef.SplitOnCharAndTrim(';');

                foreach (string item in lstResourceKeys)
                {
                    XmlHelper.AddNode(doc, root, item, ResourceHelper.GetResourceString(ModuleConfiguration.ResourceFileDef, item));
                }
            }

            CmsBasePage basePage = Page as CmsBasePage;
            bool userCanUpdate = NewsPermission.CanUpdate;
            SiteUser currentUser = SiteUtils.GetCurrentSiteUser();

            List<News> lstNews = new List<News>();
            int languageId = WorkingCulture.LanguageId;
            if (config.ZoneId > -1 || config.ZoneIds.Length > 0 || config.SortBy > 0)
            {
                string zoneRangeIds = string.Empty;

                if (config.ZoneIds.Length > 0)
                    zoneRangeIds = config.ZoneIds;
                else
                {
                    int zoneId = config.ZoneId;
                    if (zoneId == 0)
                        zoneId = CurrentZone.ZoneId;

                    zoneRangeIds = NewsHelper.GetChildZoneIdToSemiColonSeparatedString(siteSettings.SiteId, zoneId);
                }

                lstNews = News.GetPageBySearch2(1, config.MaxItemsToGet, siteSettings.SiteId, zoneRangeIds, 1, languageId, config.NewsType, config.Position, -1, null, null, null, null, null, null, null, config.SortBy);
            }
            else
                lstNews = News.GetPage(SiteId, -1, languageId, config.NewsType, config.Position, 1, config.MaxItemsToGet);

            foreach (News news in lstNews)
            {
                XmlElement newsXml = doc.CreateElement("News");
                root.AppendChild(newsXml);

                NewsHelper.BuildNewsDataXml(doc, newsXml, news, timeZone, timeOffset, NewsHelper.BuildEditLink(news, basePage, userCanUpdate, currentUser));

                if (config.ShowAllImagesInNewsList)
                    BuildNewsImagesXml(doc, newsXml, news, languageId);
            }

            XmlHelper.XMLTransform(xmlTransformer, SiteUtils.GetXsltBasePath("news", ModuleConfiguration.XsltFileName), doc);
        }

        protected virtual void PopulateLabels()
        {

        }

        public void BuildNewsImagesXml(
            XmlDocument doc,
            XmlElement newsXml,
            News news,
            int languageId)
        {
            string imageFolderPath = NewsHelper.MediaFolderPath(SiteId, news.NewsID);
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

        protected virtual void LoadSettings()
        {
            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();

            EnsureConfiguration();

            if (this.ModuleConfiguration != null)
            {
                this.Title = ModuleConfiguration.ModuleTitle;
                this.Description = ModuleConfiguration.FeatureName;
            }
        }

        private void EnsureConfiguration()
        {
            if (config == null)
                config = new NewsSpecialConfiguration(Settings);
        }

        public override bool UserHasPermission()
        {
            if (!Request.IsAuthenticated)
                return false;

            bool hasPermission = false;
            EnsureConfiguration();

            if (config.Position > 0)
            {
                if (WebUser.IsAdminOrContentAdmin && SiteUtils.UserIsSiteEditor())
                {
                    if (config.NewsType > 0)
                    {
                        string chooseNewsLabel = NewsHelper.GetNameByNewsType(config.NewsType, NewsResources.NewsSelectFormat, NewsResources.NewsSelectLabel);
                        this.LiteralExtraMarkup = "<dd><a class='ActionLink choosenewslink' href='"
                            + SiteRoot
                            + "/News/NewsSpecial.aspx?type=" + config.NewsType + "&pos=" + config.Position.ToString() + "'>" + chooseNewsLabel + "</a></dd>";
                    }
                    else
                        this.LiteralExtraMarkup = "<dd><a class='ActionLink choosenewslink' href='"
                            + SiteRoot
                            + "/News/NewsSpecial.aspx?pos=" + config.Position.ToString() + "'>" + NewsResources.NewsSelectLabel + "</a></dd>";

                    hasPermission = true;
                }
            }

            return hasPermission;
        }

    }
}