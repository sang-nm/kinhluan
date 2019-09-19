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
using System.Linq;
using CanhCam.Business.Khanh;
using System.Web;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsDetailControl : SiteModuleControl
    {
        #region Properties
        protected News News = null;
        protected KLAuthor Author = null;
        protected List<News> HotNews = null;
        private SiteSettings siteSettings = null;
        protected SiteUser currentUser = null;
        private int newsID = -1;
        private bool isUpdated = true;
        protected List<string> ListImageSlider = null;
        public string siteRoot
        {
            get { return SiteRoot; }
        }

        #endregion

        #region OnInit

        override protected void OnInit(EventArgs e)
        {
            this.Load += new EventHandler(this.Page_Load);
            base.OnInit(e);
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            currentUser = SiteUtils.GetCurrentSiteUser();
            siteSettings = CacheHelper.GetCurrentSiteSettings();
            newsID = WebUtils.ParseInt32FromQueryString("newsID", newsID);
            if (isUpdated)
            {
                updateViewCount(newsID);
                isUpdated = false;
            }
            ListImageSlider = GetListImageSlider(newsID);
            Author = GetAuthor(newsID);
            HotNews = GetHotNews();
            News = new News(siteSettings.SiteId, newsID);
        }

        protected KLAuthor GetAuthor(int newsID)
        {
            var News = KLNews.GetAll().Where(n => n.NewsID == newsID).SingleOrDefault();
            var author = new KLAuthor(News.AuthorID);
            return author;
        }

        protected List<string> GetListImageSlider(int newsId)
        {
            List<string> lstImageSlider = new List<string>();
            var news = new News(siteSettings.SiteId, newsId);
            List<string> filenames = ContentMedia.GetByContentAsc(news.NewsGuid).Select(x => x.MediaFile).ToList();
            foreach (var filename in filenames)
            {
                string urlImage = "/Data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/News/" + newsId + "/" + filename;
                lstImageSlider.Add(urlImage);
            }
            return lstImageSlider;
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

        private void SaveViewHistory(int newsID)
        {
            var viewHistory = new KLViewHistory();
            viewHistory.NewsID = newsID;
            viewHistory.FromDate = GetStartDate();
            viewHistory.ToDate = GetEndDate();
            viewHistory.Save();
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

        private void updateViewCount(int newsID)
        {
            var news = new News(siteSettings.SiteId, newsID);
            if(news !=null && news.NewsID > 0)
            {
                news.Viewed += 1;
                news.Save();
            }
        }

        private List<News> GetHotNews()
        {
            int row = News.GetCount(siteSettings.SiteId, -1, -1, -1, -1);
            return News.GetPageBySearch(siteSettings.SiteId, null, -1, 1, null, -1, -1, -1, null, null, null, null, null, -1, -1, null, 1, row).OrderByDescending(n=>n.Viewed).Take(3).ToList();
        }

        protected string AuthorImageUrl(int authorId)
        {
            var author = new KLAuthor(authorId);
            return "/Data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/Author/" + author.UserID + "/" + author.Avatar;
        }

    }
}