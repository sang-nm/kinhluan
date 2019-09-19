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
using System.Web.UI.WebControls;
using System.Web.UI;

namespace CanhCam.Web.NewsUI
{
    public partial class HomeControl : SiteModuleControl
    {
        #region Properties

        private static readonly ILog log = LogManager.GetLogger(typeof(NewsListControl));

        private SiteSettings siteSettings = null;
        protected NewsConfiguration config = new NewsConfiguration();
        private int zoneId = -1;
        private int like = -1;
        private string siteRoot = string.Empty;
        private string imageSiteRoot = string.Empty;
        protected bool allowComments = false;
        protected SiteUser currentUser = null;
        protected List<News> lstNewsTop5 = null;
        protected List<News> lstNewsMostOfWeek = null;
        protected List<KLAuthor> lstAuthorMostArticle = null;

        public string SiteRoot
        {
            get { return siteRoot; }
            set { siteRoot = value; }
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
            //totalPages = News.GetCountBySearch(siteSettings.SiteId, zoneId.ToString(), config.NewsType, -1, null, -1, -1, -1, null, null, null, null, null, string.Empty);
            int totalRow = News.GetCount(siteSettings.SiteId, -1, -1, -1, -1);
            lstNewsTop5 = News.GetPageBySearch(siteSettings.SiteId, null, 0, 1, null, -1, -1, -1, null, null, null, null, null, -1, -1, string.Empty, 1, totalRow).OrderByDescending(n => n.Viewed).Take(5).ToList();
            lstNewsMostOfWeek = GetNewsMostOfWeek();
            lstAuthorMostArticle = KLAuthor.GetAll().Where(a => a.IsActive == true).OrderByDescending(n => n.ArticleCount).Take(10).ToList();
            if(like>0)
            {
                KLNews news = KLNews.GetAll().Where(n => n.NewsID == like).SingleOrDefault();
                news.LikeCount += 1;
                news.Save();
            }
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


        private List<News> GetNewsMostOfWeek()
        {
            List<KLViewHistory> lstViewHistory = KLViewHistory.GetTop6(GetStartDate(),GetEndDate());
            List<News> ListMostOfWeek = new List<News>();
            foreach (var v in lstViewHistory)
            {
                var news = new News(siteSettings.SiteId, v.NewsID);
                ListMostOfWeek.Add(news);
            }
            return ListMostOfWeek;
        }
        private void LoadSettings()
        {
            siteSettings = CacheHelper.GetCurrentSiteSettings();
            zoneId = WebUtils.ParseInt32FromQueryString("zoneid", zoneId);
            currentUser = SiteUtils.GetCurrentSiteUser();
        }

        private DateTime GetStartDate()
        {
            DateTime baseDate = DateTime.Today;
            var thisWeekStart = baseDate.AddDays(-7);
            return thisWeekStart;
        }

        private DateTime GetEndDate()
        {
            DateTime baseDate = DateTime.Today;
            int startdate = (int)baseDate.DayOfWeek;
            var thisWeekEnd = baseDate.AddDays(7 - startdate).AddSeconds(-1);
            return thisWeekEnd;
        }

        protected string NewsImageUrl(int newsId)
        {
            return "/Data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/News/" + newsId +"/" + getFileNameImage(newsId);
        }

        protected string AuthorImageUrl(int authorId)
        {
            var author = new KLAuthor(authorId);
            return "/Data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/Author/" + author.UserID + "/" + author.Avatar;
        }

        protected string getFileNameImage(int newsId)
        {
            var news = new News(siteSettings.SiteId, newsId);
            string fileName = ContentMedia.GetByContentAsc(news.NewsGuid).Select(x => x.MediaFile).FirstOrDefault();
            return fileName;
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

        protected List<KLNewType> GetNewsType(int newsTypeID)
        {
            List<KLNewType> lstNewsType = new List<KLNewType>();
            var newsType = new KLNewType(newsTypeID);
            if(newsType.ParentID > 0)
            {
                var newsTypeParent = new KLNewType(newsType.ParentID);
                lstNewsType.Add(newsTypeParent);
            }
            lstNewsType.Add(newsType);
            return lstNewsType;
        }
    }
}