/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2014-06-25

using System;
using System.Collections.Generic;
using System.Threading;
using log4net;
using CanhCam.Business;
using CanhCam.Business.WebHelpers;
using CanhCam.SearchIndex;
using CanhCam.Web;
using CanhCam.Web.Framework;
using CanhCam.Web.NewsUI;

namespace CanhCam.Features
{

    public class NewsIndexBuilderProvider : IndexBuilderProvider
    {
        public NewsIndexBuilderProvider()
        { }

        private static readonly ILog log = LogManager.GetLogger(typeof(NewsIndexBuilderProvider));
        private static bool debugLog = log.IsDebugEnabled;

        public override void RebuildIndex(
            ZoneSettings zoneSettings,
            string indexPath)
        {
            if (WebConfigSettings.DisableSearchIndex) { return; }

            if (zoneSettings == null)
            {
                log.Error("zoneSettings object passed to NewsIndexBuilderProvider.RebuildIndex was null");
                return;
            }

            //don't index pending/unpublished zones
            if (!zoneSettings.IsPublished) { return; }

            log.Info("NewsIndexBuilderProvider indexing zone - " + zoneSettings.Name);

            //try
            //{
            Guid newsFeatureGuid = CanhCam.Business.News.FeatureGuid;
            ModuleDefinition newsFeature = new ModuleDefinition(newsFeatureGuid);

            List<CanhCam.Business.News> lstNews = CanhCam.Business.News.GetByZone(zoneSettings.SiteId, zoneSettings.ZoneId);

            // Language
            string listGuid = zoneSettings.ZoneGuid.ToString();
            string listNewsGuid = string.Empty;
            foreach (CanhCam.Business.News news in lstNews)
            {
                if (!listGuid.Contains(news.NewsGuid.ToString()))
                {
                    listGuid += ";" + news.NewsGuid.ToString();
                    listNewsGuid += ";" + news.NewsGuid.ToString();
                }
            }

            List<ContentLanguage> listContent = ContentLanguage.GetByListContent(listGuid);
            List<Language> listLanguages = LanguageHelper.GetPublishedLanguages();
            string defaultCulture = WebConfigSettings.DefaultLanguageCultureForContent;
            // End Language

            List<ContentAttribute> listAttribute = new List<ContentAttribute>();

            foreach (Language lang in listLanguages)
            {
                if (lang.LanguageCode.ToLower() != defaultCulture.ToLower())
                    listAttribute = ContentAttribute.GetByListContent(listNewsGuid, lang.LanguageID);
                else
                    listAttribute = ContentAttribute.GetByListContent(listNewsGuid);

                foreach (CanhCam.Business.News news in lstNews)
                {
                    CanhCam.SearchIndex.IndexItem indexItem = new CanhCam.SearchIndex.IndexItem();
                    indexItem.SiteId = zoneSettings.SiteId;
                    indexItem.ZoneId = zoneSettings.ZoneId;
                    indexItem.ZoneName = zoneSettings.Name;
                    indexItem.ViewRoles = zoneSettings.ViewRoles;
                    indexItem.ZoneViewRoles = zoneSettings.ViewRoles;
                    indexItem.FeatureId = newsFeatureGuid.ToString();
                    indexItem.FeatureName = newsFeature.FeatureName;
                    indexItem.FeatureResourceFile = newsFeature.ResourceFile;

                    indexItem.ItemGuid = news.NewsGuid;
                    indexItem.Title = news.Title;

                    string url = news.Url;
                    if (url.Length > 0)
                    {
                        if (url.StartsWith("http"))
                            indexItem.ViewPage = url;
                        else
                            indexItem.ViewPage = url.Replace("~/", string.Empty);
                    }
                    else
                    {
                        indexItem.ViewPage = "News/NewsDetail.aspx?zoneid="
                            + indexItem.ZoneId.ToInvariantString()
                            + "&NewsID=" + news.NewsID.ToString();
                    }

                    indexItem.PageMetaDescription = news.MetaDescription;
                    indexItem.PageMetaKeywords = news.MetaKeywords;

                    indexItem.CreatedUtc = news.StartDate;
                    indexItem.LastModUtc = news.LastModUtc;

                    //if (indexItem.ViewPage.Length > 0)
                    //{
                    indexItem.UseQueryStringParams = false;
                    //}
                    //else
                    //{
                    //    indexItem.ViewPage = "News/NewsDetail.aspx";
                    //}
                    indexItem.Content = SecurityHelper.RemoveMarkup(news.FullContent);
                    indexItem.ContentAbstract = SecurityHelper.RemoveMarkup(news.BriefContent);

                    indexItem.IsPublished = news.IsPublished;
                    indexItem.PublishBeginDate = news.StartDate;
                    indexItem.PublishEndDate = news.EndDate;

                    // Language
                    indexItem.LanguageCode = defaultCulture;
                    if (lang.LanguageCode.ToLower() != defaultCulture.ToLower())
                    {
                        indexItem.ZoneName = string.Empty;
                        indexItem.LanguageCode = lang.LanguageCode;
                        indexItem.RemoveOnly = true;

                        foreach (ContentLanguage ct in listContent)
                        {
                            if (lang.LanguageID == ct.LanguageId)
                            {
                                if (ct.ContentGuid == zoneSettings.ZoneGuid)
                                {
                                    indexItem.ZoneName = ct.Title;
                                }
                                else if (ct.ContentGuid == news.NewsGuid)
                                {
                                    indexItem.PageMetaDescription = ct.MetaDescription;
                                    indexItem.PageMetaKeywords = ct.MetaKeywords;
                                    indexItem.Title = ct.Title;
                                    indexItem.Content = SecurityHelper.RemoveMarkup(ct.FullContent);
                                    indexItem.ContentAbstract = SecurityHelper.RemoveMarkup(ct.BriefContent);

                                    indexItem.ViewPage = ct.Url.Replace("~/", string.Empty);
                                    indexItem.RemoveOnly = false;
                                }
                            }
                        }
                    }
                    // End Language

                    foreach (ContentAttribute attribute in listAttribute)
                    {
                        if (attribute.ContentGuid == news.NewsGuid)
                        {
                            indexItem.Content += " " + attribute.Title + " " + SecurityHelper.RemoveMarkup(attribute.ContentText);
                        }
                    }

                    CanhCam.SearchIndex.IndexHelper.RebuildIndex(indexItem, indexPath);

                    if (debugLog) log.Debug("Indexed " + indexItem.Title);
                }
            }
            //}
            //catch (Exception ex)
            //{
            //    log.Error(ex);
            //}
        }

        public override void ContentChangedHandler(
            object sender,
            ContentChangedEventArgs e)
        {
            if (WebConfigSettings.DisableSearchIndex) { return; }
            if (sender == null) return;
            if (!(sender is CanhCam.Business.News)) return;

            CanhCam.Business.News news = (CanhCam.Business.News)sender;
            SiteSettings siteSettings = CacheHelper.GetCurrentSiteSettings();
            news.SiteId = siteSettings.SiteId;
            news.SearchIndexPath = CanhCam.SearchIndex.IndexHelper.GetSearchIndexPath(siteSettings.SiteId);

            if (e.IsDeleted)
            {
                CanhCam.SearchIndex.IndexHelper.RemoveIndexItem(
                        news.ZoneID,
                        news.NewsGuid);
            }
            else
            {
                if (ThreadPool.QueueUserWorkItem(new WaitCallback(IndexItem), news))
                {
                    if (debugLog) log.Debug("NewsIndexBuilderProvider.IndexItem queued");
                }
                else
                {
                    log.Error("Failed to queue a thread for NewsIndexBuilderProvider.IndexItem");
                }

                //IndexItem(news);
            }
        }

        private static void IndexItem(object o)
        {
            if (WebConfigSettings.DisableSearchIndex) { return; }
            if (o == null) return;
            if (!(o is CanhCam.Business.News)) return;

            CanhCam.Business.News content = o as CanhCam.Business.News;
            IndexItem(content);
        }

        private static void IndexItem(CanhCam.Business.News news)
        {
            if (WebConfigSettings.DisableSearchIndex) { return; }

            if (news == null)
            {
                if (log.IsErrorEnabled)
                {
                    log.Error("news object passed to NewsIndexBuilderProvider.IndexItem was null");
                }
                return;
            }

            Guid newsFeatureGuid = CanhCam.Business.News.FeatureGuid;
            ModuleDefinition newsFeature = new ModuleDefinition(newsFeatureGuid);

            List<ContentAttribute> listAttribute = new List<ContentAttribute>();
            // Language
            List<Language> listLanguages = LanguageHelper.GetPublishedLanguages();
            string defaultCulture = WebConfigSettings.DefaultLanguageCultureForContent;
            // End Language

            ZoneSettings zoneSettings = new ZoneSettings(news.SiteId, news.ZoneID);
            //don't index pending/unpublished pages
            if (!zoneSettings.IsPublished) { return; }

            foreach (Language lang in listLanguages)
            {
                CanhCam.SearchIndex.IndexItem indexItem = new CanhCam.SearchIndex.IndexItem();
                if (news.SearchIndexPath.Length > 0)
                {
                    indexItem.IndexPath = news.SearchIndexPath;
                }
                indexItem.SiteId = news.SiteId;
                indexItem.ZoneId = zoneSettings.ZoneId;
                indexItem.ZoneName = zoneSettings.Name;
                indexItem.ViewRoles = zoneSettings.ViewRoles;
                indexItem.ZoneViewRoles = zoneSettings.ViewRoles;

                indexItem.PageMetaDescription = news.MetaDescription;
                indexItem.PageMetaKeywords = news.MetaKeywords;
                indexItem.ItemGuid = news.NewsGuid;
                indexItem.Title = news.Title;
                indexItem.Content = news.FullContent;
                indexItem.ContentAbstract = news.BriefContent;
                indexItem.FeatureId = newsFeatureGuid.ToString();
                indexItem.FeatureName = newsFeature.FeatureName;
                indexItem.FeatureResourceFile = newsFeature.ResourceFile;

                //indexItem.OtherContent = stringBuilder.ToString();
                indexItem.IsPublished = news.IsPublished;
                indexItem.PublishBeginDate = news.StartDate;
                indexItem.PublishEndDate = news.EndDate;

                indexItem.CreatedUtc = news.StartDate;
                indexItem.LastModUtc = news.LastModUtc;

                if (news.Url.Length > 0)
                {
                    if (news.Url.StartsWith("http"))
                        indexItem.ViewPage = news.Url;
                    else
                        indexItem.ViewPage = news.Url.Replace("~/", string.Empty);
                }
                else
                {
                    indexItem.ViewPage = "News/NewsDetail.aspx?zoneid="
                        + indexItem.ZoneId.ToInvariantString()
                        + "&NewsID=" + news.NewsID.ToInvariantString()
                        ;
                }

                indexItem.UseQueryStringParams = false;

                // Language
                string listGuid = zoneSettings.ZoneGuid.ToString()
                                + ";" + news.NewsGuid.ToString();
                List<ContentLanguage> listContent = ContentLanguage.GetByListContent(listGuid);
                indexItem.LanguageCode = defaultCulture;
                if (lang.LanguageCode.ToLower() != defaultCulture.ToLower())
                {
                    indexItem.LanguageCode = lang.LanguageCode;
                    indexItem.RemoveOnly = true;

                    foreach (ContentLanguage ct in listContent)
                    {
                        if (lang.LanguageID == ct.LanguageId)
                        {
                            if (ct.ContentGuid == zoneSettings.PageGuid)
                            {
                                indexItem.ZoneName = ct.Title;
                            }
                            else if (ct.ContentGuid == news.NewsGuid)
                            {
                                indexItem.PageMetaDescription = ct.MetaDescription;
                                indexItem.PageMetaKeywords = ct.MetaKeywords;
                                indexItem.Title = ct.Title;
                                indexItem.Content = SecurityHelper.RemoveMarkup(ct.FullContent);
                                indexItem.ContentAbstract = SecurityHelper.RemoveMarkup(ct.BriefContent);

                                indexItem.ViewPage = ct.Url.Replace("~/", string.Empty);
                                indexItem.RemoveOnly = false;
                            }
                        }
                    }

                    listAttribute = ContentAttribute.GetByContentAsc(news.NewsGuid, lang.LanguageID);
                }
                else
                {
                    listAttribute = ContentAttribute.GetByContentAsc(news.NewsGuid);
                }
                // End Language

                foreach (ContentAttribute attribute in listAttribute)
                {
                    indexItem.Content += " " + attribute.Title + " " + SecurityHelper.RemoveMarkup(attribute.ContentText);
                }

                if (news.IsDeleted)
                    indexItem.RemoveOnly = true;

                CanhCam.SearchIndex.IndexHelper.RebuildIndex(indexItem);
            }

            if (debugLog) log.Debug("Indexed " + news.Title);
        }
    }
}
