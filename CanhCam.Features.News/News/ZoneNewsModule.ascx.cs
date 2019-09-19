/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			    2013-04-05
/// Last Modified:		    2013-04-12

using System;
using System.Collections;
using CanhCam.Web.Framework;
using System.Web.UI.WebControls;
using CanhCam.Business;
using System.Web;
using CanhCam.Business.WebHelpers;
using System.Xml;
using Resources;
using System.Collections.Generic;

namespace CanhCam.Web.NewsUI
{
    public partial class ZoneNewsModule : SiteModuleControl
    {

        private ZoneNewsConfiguration config = null;
        private Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;

        private SiteMapDataSource siteMapDataSource;
        private bool isAdmin = false;
        private bool isContentAdmin = false;
        private bool isSiteEditor = false;
        private string secureSiteRoot = string.Empty;
        private string insecureSiteRoot = string.Empty;
        private bool resolveFullUrlsForMenuItemProtocolDifferences = false;
        private string navigationSiteRoot = string.Empty;
        private bool useFullUrlsForWebPage = false;
        private bool isSecureRequest = false;
        private SiteMapNode rootNode = null;
        private SiteMapNode startingNode = null;
        private gbSiteMapNode currentNode = null;

        private int languageId = -1;
        private int newsId = -1;
        private bool isMobileSkin = false;
        private int mobileOnly = (int)ContentPublishMode.MobileOnly;
        private int webOnly = (int)ContentPublishMode.WebOnly;

        private CmsBasePage basePage;
        private bool userCanUpdate = false;
        private SiteUser currentUser;

        #region OnInit

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            this.EnableViewState = false;

            this.Load += new EventHandler(Page_Load);
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {

            LoadSettings();
            PopulateLabels();
            PopulateControls();

        }

        private void PopulateControls()
        {
            if (HttpContext.Current == null) { return; }

            if (rootNode == null) { return; }

            XmlDocument doc = new XmlDocument();
            doc.LoadXml("<ZoneList></ZoneList>");

            XmlElement root = doc.DocumentElement;

            XmlHelper.AddNode(doc, root, "ModuleTitle", this.Title);
            XmlHelper.AddNode(doc, root, "ZoneTitle", CurrentZone.Name);
            XmlHelper.AddNode(doc, root, "Title", GetZoneTitle(currentNode));
            XmlHelper.AddNode(doc, root, "Url", FormatUrl(currentNode));
            XmlHelper.AddNode(doc, root, "Target", (currentNode.OpenInNewWindow == true ? "_blank" : "_self"));
            XmlHelper.AddNode(doc, root, "ImageUrl", (currentNode != null ? currentNode.PrimaryImage : string.Empty));
            XmlHelper.AddNode(doc, root, "SecondImageUrl", (currentNode != null ? currentNode.SecondImage : string.Empty));

            if (ModuleConfiguration.ResourceFileDef.Length > 0 && ModuleConfiguration.ResourceKeyDef.Length > 0)
            {
                List<string> lstResourceKeys = ModuleConfiguration.ResourceKeyDef.SplitOnCharAndTrim(';');

                foreach (string item in lstResourceKeys)
                {
                    XmlHelper.AddNode(doc, root, item, ResourceHelper.GetResourceString(ModuleConfiguration.ResourceFileDef, item));
                }
            }

            SiteMapNodeCollection allNodes = null;
            if (config.IsSubZone)
                allNodes = startingNode.ChildNodes;
            else
                allNodes = startingNode.GetAllNodes();

            foreach (SiteMapNode childNode in allNodes)
            {
                gbSiteMapNode gbNode = childNode as gbSiteMapNode;
                if (gbNode == null) { continue; }

                RenderNode(doc, root, gbNode);
            }

            XmlHelper.XMLTransform(xmlTransformer, SiteUtils.GetXsltBasePath("news", ModuleConfiguration.XsltFileName), doc);
        }

        private void RenderNode(XmlDocument doc, XmlElement xmlElement, gbSiteMapNode gbNode)
        {
            if (!ShouldRender(gbNode)) { return; }

            XmlElement item = doc.CreateElement("Zone");
            xmlElement.AppendChild(item);

            XmlHelper.AddNode(doc, item, "ZoneId", gbNode.ZoneId.ToInvariantString());
            XmlHelper.AddNode(doc, item, "Depth", gbNode.Depth.ToInvariantString());
            XmlHelper.AddNode(doc, item, "ChildCount", gbNode.ChildNodes.Count.ToInvariantString());
            XmlHelper.AddNode(doc, item, "IsClickable", gbNode.IsClickable.ToString().ToLower());
            XmlHelper.AddNode(doc, item, "Url", FormatUrl(gbNode));
            XmlHelper.AddNode(doc, item, "Target", (gbNode.OpenInNewWindow == true ? "_blank" : "_self"));
            XmlHelper.AddNode(doc, item, "Title", GetZoneTitle(gbNode));
            XmlHelper.AddNode(doc, item, "Description", GetDescription(gbNode));
            XmlHelper.AddNode(doc, item, "ImageUrl", gbNode.PrimaryImage);
            XmlHelper.AddNode(doc, item, "SecondImageUrl", gbNode.SecondImage);

            List<News> lstNews = new List<News>();

            if (config.ShowAllNews)
            {
                string zoneIds = NewsHelper.GetChildZoneIdToSemiColonSeparatedString(siteSettings.SiteId, gbNode.ZoneId);
                if (config.MaxItemsToGet == 0)
                {
                    int iCount = News.GetCountByListZone(siteSettings.SiteId, zoneIds, -1, config.NewsPosition, languageId);
                    XmlHelper.AddNode(doc, item, "NewsCount", iCount.ToString());
                }
                else if (config.MaxItemsToGet > 0)
                    lstNews = News.GetPageByListZone(siteSettings.SiteId, zoneIds, -1, config.NewsPosition, languageId, 1, config.MaxItemsToGet);
                else
                {
                    int iCount = News.GetCountByListZone(siteSettings.SiteId, zoneIds, -1, config.NewsPosition, languageId);
                    XmlHelper.AddNode(doc, item, "NewsCount", iCount.ToString());

                    lstNews = News.GetPageByListZone(siteSettings.SiteId, zoneIds, -1, config.NewsPosition, languageId, 1, Math.Abs(config.MaxItemsToGet));
                }
            }
            else
            {
                if (config.MaxItemsToGet == 0)
                {
                    int iCount = News.GetCount(siteSettings.SiteId, gbNode.ZoneId, -1, config.NewsPosition, languageId);
                    XmlHelper.AddNode(doc, item, "NewsCount", iCount.ToString());
                }
                else if (config.MaxItemsToGet > 0)
                    lstNews = News.GetPage(siteSettings.SiteId, gbNode.ZoneId, languageId, -1, config.NewsPosition, 1, config.MaxItemsToGet);
                else
                {
                    int iCount = News.GetCount(siteSettings.SiteId, gbNode.ZoneId, -1, config.NewsPosition, languageId);
                    XmlHelper.AddNode(doc, item, "NewsCount", iCount.ToString());

                    lstNews = News.GetPage(siteSettings.SiteId, gbNode.ZoneId, languageId, -1, config.NewsPosition, 1, Math.Abs(config.MaxItemsToGet));
                }
            }

            foreach (News news in lstNews)
            {
                XmlElement newsXml = doc.CreateElement("News");
                item.AppendChild(newsXml);

                NewsHelper.BuildNewsDataXml(doc, newsXml, news, timeZone, timeOffset, NewsHelper.BuildEditLink(news, basePage, userCanUpdate, currentUser));

                if (news.NewsID == newsId)
                    XmlHelper.AddNode(doc, newsXml, "IsActive", "true");

                if (config.ShowAllImagesInNewsList)
                    BuildNewsImagesXml(doc, newsXml, news, languageId);
            }

            if ((currentNode != null)
                && (currentNode.ZoneGuid == gbNode.ZoneGuid) // Selected
                )
            {
                XmlHelper.AddNode(doc, item, "IsActive", "true");
            }
            else
            {
                XmlHelper.AddNode(doc, item, "IsActive", "false");
            }

            if (gbNode.ChildNodes.Count > 0)
            {
                foreach (SiteMapNode childNode in gbNode.ChildNodes)
                {
                    gbSiteMapNode gbChildNode = childNode as gbSiteMapNode;
                    if (gbChildNode == null) { continue; }

                    RenderNode(doc, item, gbChildNode);
                }
            }
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

        private string GetZoneTitle(gbSiteMapNode mapNode)
        {
            if (mapNode == null)
                return string.Empty;

            string title = mapNode.Title;
            if (languageId > 0 && mapNode["Title" + languageId.ToString()] != null)
                title = mapNode["Title" + languageId.ToString()];

            return title;
        }

        private string GetDescription(gbSiteMapNode mapNode)
        {
            if (mapNode == null)
                return string.Empty;

            string str = mapNode.Description;
            if (languageId > 0 && mapNode["Description" + languageId.ToString()] != null)
                str = mapNode["Description" + languageId.ToString()];

            return str;
        }

        private bool ShouldRender(gbSiteMapNode mapNode)
        {
            if (mapNode == null) { return false; }

            if (
                languageId > 0
                && mapNode["Title" + languageId.ToString()] == null
                )
                return false;

            if (mapNode.Roles == null)
            {
                if ((!isAdmin) && (!isContentAdmin) && (!isSiteEditor)) { return false; }
            }
            else
            {
                if ((!isAdmin) && (mapNode.Roles.Count == 1) && (mapNode.Roles[0].ToString() == "Admins")) { return false; }

                if ((!isAdmin) && (!isContentAdmin) && (!isSiteEditor) && (!WebUser.IsInRoles(mapNode.Roles))) { return false; }
            }

            //if (!mapNode.IncludeInMenu && config.IsSubMenu) { return false; }
            if (!mapNode.IsPublished) { return false; }

            if (config.ZonePosition > 0)
            {
                if ((mapNode.Position & config.ZonePosition) == 0)
                    return false;
            }

            if ((mapNode.HideAfterLogin) && (Page.Request.IsAuthenticated)) { return false; }

            if ((!isMobileSkin) && (mapNode.PublishMode == mobileOnly)) { return false; }

            if ((isMobileSkin) && (mapNode.PublishMode == webOnly)) { return false; }

            return true;
        }

        private bool GetClickable(gbSiteMapNode mapNode)
        {
            if (mapNode == null)
                return false;

            bool isClickable = false;
            if (languageId > 0)
            {
                if (mapNode["IsClickable" + languageId.ToString()] != null)
                    isClickable = Convert.ToBoolean(mapNode["IsClickable" + languageId.ToString()]);
            }
            else
                isClickable = mapNode.IsClickable;

            return isClickable;
        }

        private string FormatUrl(gbSiteMapNode mapNode)
        {
            if (!GetClickable(mapNode))
                return "#";

            string url = string.Empty;
            if (WebConfigSettings.EnableHierarchicalFriendlyUrls)
            {
                url = mapNode.UrlExpand;
                if (languageId > 0 && mapNode["UrlExpand" + languageId.ToString()] != null)
                    url = mapNode["UrlExpand" + languageId.ToString()];
            }
            else
            {
                url = mapNode.Url;
                if (languageId > 0 && mapNode["Url" + languageId.ToString()] != null)
                    url = mapNode["Url" + languageId.ToString()];
            }

            string itemUrl = Page.ResolveUrl(url);
            bool useFullUrls = false;

            if (resolveFullUrlsForMenuItemProtocolDifferences)
            {
                if (isSecureRequest)
                {
                    if (
                        (!mapNode.UseSsl)
                        && (!siteSettings.UseSslOnAllPages)
                        && (url.StartsWith("~/") || url.StartsWith("/"))
                        )
                    {
                        itemUrl = insecureSiteRoot + url.Replace("~/", "/");
                        useFullUrls = true;
                    }
                }
                else
                {
                    if ((mapNode.UseSsl) || (siteSettings.UseSslOnAllPages))
                    {
                        if (url.StartsWith("~/") || url.StartsWith("/"))
                        {
                            itemUrl = secureSiteRoot + url.Replace("~/", "/");
                            useFullUrls = true;
                        }
                    }
                }
            }

            if (
                !useFullUrls
                && useFullUrlsForWebPage
                && (url.StartsWith("~/") || url.StartsWith("/"))
                )
                itemUrl = navigationSiteRoot + url.Replace("~/", "/");

            return itemUrl;
        }

        private void PopulateLabels()
        {

        }

        private void LoadSettings()
        {
            EnsureConfiguration();

            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();

            languageId = WorkingCulture.LanguageId;
            newsId = WebUtils.ParseInt32FromQueryString("NewsId", -1);

            isAdmin = WebUser.IsAdmin;
            if (!isAdmin) { isContentAdmin = WebUser.IsContentAdmin; }
            if ((!isAdmin) && (!isContentAdmin)) { isSiteEditor = SiteUtils.UserIsSiteEditor(); }

            basePage = Page as CmsBasePage;
            userCanUpdate = NewsPermission.CanUpdate;
            currentUser = SiteUtils.GetCurrentSiteUser();

            useFullUrlsForWebPage = WebConfigSettings.UseFullUrlsForWebPage;
            resolveFullUrlsForMenuItemProtocolDifferences = WebConfigSettings.ResolveFullUrlsForMenuItemProtocolDifferences;
            navigationSiteRoot = WebUtils.GetSiteRoot();
            if (resolveFullUrlsForMenuItemProtocolDifferences)
            {
                secureSiteRoot = WebUtils.GetSecureSiteRoot();
                insecureSiteRoot = secureSiteRoot.Replace("https", "http");
            }

            isSecureRequest = SiteUtils.IsSecureRequest();
            isMobileSkin = SiteUtils.UseMobileSkin();
            siteMapDataSource = new SiteMapDataSource();
            siteMapDataSource.SiteMapProvider = "canhcamsite" + siteSettings.SiteId.ToInvariantString();

            rootNode = siteMapDataSource.Provider.RootNode;
            currentNode = SiteUtils.GetCurrentZoneSiteMapNode(rootNode);
            startingNode = rootNode;

            if (config.IsSubZone)
            {
                startingNode = currentNode;
            }
        }

        private void EnsureConfiguration()
        {
            if (config == null)
                config = new ZoneNewsConfiguration(Settings);
        }

        public override bool UserHasPermission()
        {
            if (!Request.IsAuthenticated)
                return false;

            bool hasPermission = false;
            bool isAdminOrContentAdmin = WebUser.IsAdminOrContentAdmin && SiteUtils.UserIsSiteEditor();
            EnsureConfiguration();

            if (config.ZonePosition > 0)
            {
                if (isAdminOrContentAdmin || WebUser.IsInRoles(siteSettings.RolesThatCanManageZones))
                {
                    this.LiteralExtraMarkup = "<dd><a class='ActionLink choosezonelink' href='"
                            + SiteRoot
                            + "/AdminCP/ZonePosition.aspx?pos=" + config.ZonePosition.ToString() + "'>" + ResourceHelper.GetResourceString("Resource", "ZoneSelectLabel") + "</a></dd>";

                    hasPermission = true;
                }
            }

            if (config.NewsPosition > 0)
            {
                if (isAdminOrContentAdmin)
                {
                    this.LiteralExtraMarkup += "<dd><a class='ActionLink choosenewslink' href='"
                            + SiteRoot
                            + "/News/NewsSpecial.aspx?pos=" + config.NewsPosition.ToString() + "'>" + NewsResources.NewsSelectLabel + "</a></dd>";

                    hasPermission = true;
                }
            }

            return hasPermission;
        }

    }

    public class ZoneNewsConfiguration
    {
        public ZoneNewsConfiguration()
        { }

        public ZoneNewsConfiguration(Hashtable settings)
        {
            LoadSettings(settings);
        }

        private void LoadSettings(Hashtable settings)
        {
            if (settings == null || settings.Count == 0) { return; throw new ArgumentException("must pass in a hashtable of settings"); }

            isSubZone = WebUtils.ParseBoolFromHashtable(settings, "IsSubZoneSetting", isSubZone);
            maxItemsToGet = WebUtils.ParseInt32FromHashtable(settings, "MaxItemsToGet", maxItemsToGet);
            newsPosition = WebUtils.ParseInt32FromHashtable(settings, "NewsPositionSetting", newsPosition);
            showAllNews = WebUtils.ParseBoolFromHashtable(settings, "ShowAllNewsFromChildZoneSetting", showAllNews);
            zonePosition = WebUtils.ParseInt32FromHashtable(settings, "ZonePositionSetting", zonePosition);
            showAllImagesInNewsList = WebUtils.ParseBoolFromHashtable(settings, "ShowAllImagesInNewsList", showAllImagesInNewsList);
        }

        private int maxItemsToGet = 10;
        public int MaxItemsToGet
        {
            get { return maxItemsToGet; }
        }

        private int newsPosition = -1;
        public int NewsPosition
        {
            get { return newsPosition; }
        }

        private int zonePosition = -1;
        public int ZonePosition
        {
            get { return zonePosition; }
        }

        private bool isSubZone = false;
        public bool IsSubZone
        {
            get { return isSubZone; }
        }

        private bool showAllNews = false;
        public bool ShowAllNews
        {
            get { return showAllNews; }
        }

        private bool showAllImagesInNewsList = false;
        public bool ShowAllImagesInNewsList
        {
            get { return showAllImagesInNewsList; }
        }
    }

}
