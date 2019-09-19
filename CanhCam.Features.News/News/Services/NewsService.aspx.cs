using CanhCam.Business;
using CanhCam.Business.Khanh;
using CanhCam.Web.Framework;
using log4net;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public partial class NewsService : CmsInitBasePage
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(NewsService));

        private string method = string.Empty;
        private NameValueCollection postParams = null;
        private SiteUser currentUser = null;
        string newsID = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentType = "text/json";
            Encoding encoding = new UTF8Encoding();
            Response.ContentEncoding = encoding;

            try
            {
                LoadParams();

                if (
                    method != "UpdateLike"
                    && method != "UpdateShare"
                )
                {
                    Response.Write(StringHelper.ToJsonString(new
                    {
                        success = false,
                        message = "No method found with the " + method
                    }));
                    return;
                }

                switch (method)
                {
                    case "UpdateLike":
                        if (!string.IsNullOrEmpty(postParams.Get("newsID")))
                            newsID = postParams.Get("newsID");
                        Response.Write(UpdateLike(int.Parse(newsID)));
                        break;
                    case "UpdateShare":
                        if (!string.IsNullOrEmpty(postParams.Get("newsID")))
                            newsID = postParams.Get("newsID");
                        Response.Write(UpdateShare(int.Parse(newsID)));
                        break;
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);

                Response.Write(StringHelper.ToJsonString(new
                {
                    success = false,
                    message = "Failed to process from the server. Please refresh the page and try one more time."
                }));
            }
        }

        private void LoadParams()
        {
            // don't accept get requests
            if (Request.HttpMethod != "POST") return;

            postParams = HttpUtility.ParseQueryString(Request.GetRequestBody());

            if (postParams.Get("method") != null)
                method = postParams.Get("method");

            currentUser = SiteUtils.GetCurrentSiteUser();
        }

        private string UpdateLike(int newsID)
        {
            bool isSuccess = false;
            var newsHistory = KLLikeHistory.GetAll().Where(h => h.NewsID == newsID&& h.AuthorID == GetAuthor(currentUser.UserId)).SingleOrDefault();
            if (newsHistory == null)
            {
                newsHistory = new KLLikeHistory();
                newsHistory.NewsID = newsID;
                newsHistory.AuthorID = GetAuthor(currentUser.UserId);
                newsHistory.CreateDate = DateTime.Now;
                newsHistory.Save();
                var news = KLNews.GetAll().Where(n => n.NewsID == newsID).SingleOrDefault();
                news.LikeCount += 1;
                isSuccess = news.Save();
            }
            else
            {
                KLLikeHistory.Delete(newsHistory.LikeID);
                var news = KLNews.GetAll().Where(n => n.NewsID == newsID).SingleOrDefault();
                news.LikeCount -= 1;
                isSuccess = news.Save();
            }
            return isSuccess ? "success" : "fail";
        }

        private string UpdateShare(int newsID)
        {
            var news = KLNews.GetAll().Where(n => n.NewsID == newsID).SingleOrDefault();
            news.ShareCount += 1;
            bool res = news.Save();
            return res ? "success" : "fail";
        }

        private int GetAuthor(int userId)
        {
            KLAuthor author = KLAuthor.GetAll().Where(a => a.UserID == userId).SingleOrDefault();
            return author.AuthorID;
        }
    }
}