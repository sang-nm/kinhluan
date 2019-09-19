using CanhCam.Business;
using CanhCam.Web.Framework;
using log4net;
using System;

namespace CanhCam.Web.CustomUI
{
    public partial class KLAuthorLayer : SiteModuleControl
    {

        private static readonly ILog log = LogManager.GetLogger(typeof(KLAuthorLayer));
        protected KLAuthor author = null;
        private int authorID = -1;
        private string navPath = null;
        protected SiteUser AuthorUser=null;

        public int AuthorID
        {
            get { return authorID; }
            set { authorID = value; }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            LoadParams();
            LoadNav();
        }

        private void LoadParams()
        {
            authorID = WebUtils.ParseInt32FromQueryString("id", authorID);
            if (authorID > -1)
            {
                author = new KLAuthor(authorID);
                AuthorUser = new SiteUser(siteSettings, author.UserID);
            }
        }

        private void LoadNav()
        {
            navPath = Request.RawUrl.Substring(0, Request.RawUrl.IndexOf("?"));
            if (navPath == "/articles-by-author")
            {
                nav1.Attributes.Add("class", "active");
            }
            else if (navPath == "/books-by-author")
            {
                nav2.Attributes.Add("class", "active");
            }
            else if (navPath == "/gratitude-author")
            {
                nav3.Attributes.Add("class", "active");
            }
            else
            {
            }
        }
        protected string getCatUrl(int authorID, string catalogs)
        {

            if (catalogs == "Articles")
            {
                return SiteRoot + "/articles-by-author?id=" + authorID;
            }
            else if (catalogs == "Books")
            {
                return SiteRoot + "/books-by-author?id=" + authorID;
            }
            else if (catalogs == "Gratitude")
            {
                return SiteRoot + "/gratitude-author?id=" + authorID;
            }
            else
            {
                return "/";
            }
        }

        protected string getAuthorImage(int authorId, string authorImg)
        {
            return "/data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/Author/" + authorId + "/" + authorImg;
        }
    }
}