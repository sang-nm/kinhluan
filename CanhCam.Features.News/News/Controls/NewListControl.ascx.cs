/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2014-07-04

using System;
using System.Collections.Generic;
using CanhCam.Business;
using log4net;
using CanhCam.Business.WebHelpers;
using CanhCam.Web.Framework;
using System.Linq;
using CanhCam.Business.Khanh;
using System.Web.Services;

namespace CanhCam.Web.NewsUI
{
    public partial class NewListControl : SiteModuleControl
    {
        #region Properties

        private static readonly ILog log = LogManager.GetLogger(typeof(NewsListControl));

        private SiteSettings siteSettings = null;
        protected int pageNumber = 1;
        protected int totalPages = 1;
        private int pageSize = 9;
        private Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;
        protected NewsConfiguration config = new NewsConfiguration();
        private int zoneId = -1;
        private int typeId = -1;
        private string siteRoot = string.Empty;

        protected SiteUser currentUser = null;


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

        protected List<News> lst_news = null;
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
            double totalRow = News.GetCount(siteSettings.SiteId, -1, -1, -1, -1);
            totalPages = (int)Math.Ceiling(totalRow / pageSize);
            typeId = WebUtils.ParseInt32FromQueryString("typeId", typeId);
            lst_news = News.GetPageBySearch(siteSettings.SiteId, null, 0, 1, null, -1, -1, -1, null, null, null, null, null, -1, typeId, string.Empty, pageNumber, pageSize).OrderByDescending(n => n.Viewed).ToList();
        }

        protected void LoadSettings()
        {
            siteSettings = CacheHelper.GetCurrentSiteSettings();
            zoneId = WebUtils.ParseInt32FromQueryString("zoneid", zoneId);
            currentUser = SiteUtils.GetCurrentSiteUser();
            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();
            pageNumber = WebUtils.ParseInt32FromQueryString("pagenumber", pageNumber);
        }

        protected string NewsImageUrl(int newsId)
        {
            return "/Data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/News/" + newsId + "/" + getFileNameImage(newsId);
        }
        protected string getFileNameImage(int newsId)
        {
            var news = new News(siteSettings.SiteId, newsId);
            string fileName = ContentMedia.GetByContentAsc(news.NewsGuid).Select(x => x.MediaFile).FirstOrDefault();
            return fileName;
        }

        protected string AuthorImageUrl(int authorId)
        {
            var author = new KLAuthor(authorId);
            return "/Data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/Author/" + author.UserID + "/" + author.Avatar;
        }



        protected string GetAuthorName(int Id)
        {
            var author = new KLAuthor(Id);
            return author.Name;
        }

        protected string GetAuthorAvatar(int Id)
        {
            var author = new KLAuthor(Id);
            return author.Avatar;
        }

        protected bool CheckLiked(int newsID)
        {
            try
            {
                List<KLLikeHistory> lstLiked = KLLikeHistory.GetAll().Where(l => l.AuthorID == GetAuthor(currentUser.UserId)).ToList();
                foreach (var item in lstLiked)
                {
                    if (newsID == item.NewsID)
                        return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                return false;
                log.Error(ex.Message);
            }
        }

        private int GetAuthor(int userId)
        {
            var author = KLAuthor.GetAll().Where(a => a.UserID == userId).SingleOrDefault();
            return author.AuthorID;
        }
        protected List<KLNewType> GetNewsType(int newsTypeID)
        {
            List<KLNewType> lstNewsType = new List<KLNewType>();
            var newsType = new KLNewType(newsTypeID);
            if (newsType.ParentID > 0)
            {
                var newsTypeParent = new KLNewType(newsType.ParentID);
                lstNewsType.Add(newsTypeParent);
            }
            lstNewsType.Add(newsType);
            return lstNewsType;
        }
    }
}