using CanhCam.Business;
using CanhCam.Business.Tri;
using CanhCam.Business.WebHelpers;
using CanhCam.Web;
using CanhCam.Web.CustomUI;
using CanhCam.Web.Editor;
using CanhCam.Web.Framework;
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public partial class KLAuthor_Articles : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLAuthor_Articles));


        private SiteSettings siteSettings = null;
        private SiteUser currentUser = null;
        private int zoneId = -1;
        private Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;

        protected KLAuthor author = null;
        private int authorID = -1;
        protected List<KLNews> news = null;
        protected int totalPage = 0;
        protected int pageSize = 8;
        protected int pagenum = 1;
        protected string siteRoot = string.Empty;
        public string SiteRoot
        {
            get { return siteRoot; }
            set { siteRoot = value; }
        }
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadSettings();
            LoadParams();
        }
        
        private void LoadSettings()
        {
            siteSettings = CacheHelper.GetCurrentSiteSettings();
            zoneId = WebUtils.ParseInt32FromQueryString("zoneid", zoneId);
            currentUser = SiteUtils.GetCurrentSiteUser();
            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();
        }
        private void LoadParams()
        {
            authorID = WebUtils.ParseInt32FromQueryString("id", authorID);
            if (authorID > -1)
            {
                author = new KLAuthor(authorID);
            }

            pagenum = WebUtils.ParseInt32FromQueryString("page", pagenum);

            news = KLNews.GetPageByAuthor(pagenum, pageSize, out totalPage, author.AuthorID, "", false, true, false).ToList();
        }

        protected string getArticleUrl(int newsID)
        {
            int languageId = WorkingCulture.LanguageId;
            try
            {
                if (languageId > 0)
                    return "/" + WorkingCulture.Name + "/news-detail?newsID=" + newsID;
                else
                    return "/news-detail?newsID=" + newsID;
            }
            catch (Exception)
            {
                if (languageId > 0)
                    return "/" + WorkingCulture.Name + "/news-detail?newsID=25";
                else
                    return "/news-detail?newsID=25";
            }

        }
        protected string getStartDate(int newID)
        {
            News tem = new News(siteSettings.SiteId, newID);
            return tem.StartDate.ToString("dd/MM/yyyy");
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
        protected string NewsImageUrl(int newsId)
        {
            return "/Data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/News/" + newsId + "/" + getFileNameImage(newsId);
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
        protected string getTitileNews(int newsId)
        {
            var news = new News(siteSettings.SiteId, newsId);
            return news.Title;
        }

        protected string GetAuthorName(int Id)
        {
            var author = new KLAuthor(Id);
            return author.Name;
        }

        protected int getView(int newsId)
        {
            var news = new News(siteSettings.SiteId, newsId);
            return news.Viewed;
        }

        

        protected List<KLNewsType> GetNewsType(int newsTypeID)
        {
            List<KLNewsType> lstNewsType = new List<KLNewsType>();
            var newsType = new KLNewsType(newsTypeID);
            if (newsType.ParentID > 0)
            {
                var newsTypeParent = new KLNewsType(newsType.ParentID);
                lstNewsType.Add(newsTypeParent);
            }
            lstNewsType.Add(newsType);
            return lstNewsType;
        }
        
    }
}