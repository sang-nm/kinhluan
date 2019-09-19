using CanhCam.Business;
using CanhCam.Web;
using CanhCam.Web.Editor;
using CanhCam.Web.Framework;
using CanhCam.Web.CustomUI;
using Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using CanhCam.FileSystem;
using log4net;
using CanhCam.Business.WebHelpers;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsTypeControl : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(NewsTypeControl));
        protected List<KLNewType> parentType = null;
        private SiteSettings siteSettings = null;
        private Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;
        private int zoneId = -1;
        private string siteRoot = string.Empty;
        protected SiteUser currentUser = null;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            parentType = KLNewType.GetAll().Where(t => t.ParentID == -1).ToList();
        }

        protected List<KLNewType> GetChildType(int parentId)
        {
            return KLNewType.GetAll().Where(t => t.ParentID == parentId).ToList();
        }
        protected void LoadSettings()
        {
            siteSettings = CacheHelper.GetCurrentSiteSettings();
            zoneId = WebUtils.ParseInt32FromQueryString("zoneid", zoneId);
            currentUser = SiteUtils.GetCurrentSiteUser();
            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();
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

        protected List<News> GetNews(int typeId)
        {
            LoadSettings();
            int totalRow = News.GetCount(siteSettings.SiteId, -1, -1, -1, -1);
            return News.GetPageBySearch(siteSettings.SiteId, null, 0, 1, null, -1, -1, -1, null, null, null, null, null, -1, typeId, string.Empty, 1, totalRow).OrderByDescending(n => n.StartDate).Take(5).ToList();
        }

    }
}