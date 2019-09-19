using CanhCam.Business;
using CanhCam.FileSystem;
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
    public partial class KLAuthorList : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLAuthorList));
        protected List<KLAuthor> authorList = null;
        protected int totalPage = 0;
        protected int pageSize = 12;
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
            LoadParams();
        }

        private void LoadParams()
        {
            pagenum = WebUtils.ParseInt32FromQueryString("page", pagenum);
            authorList = KLAuthor.GetPageIsActive(pagenum, pageSize, out totalPage);
        }
        protected string getAuthorUrl(int authorID)
        {
            int languageId = WorkingCulture.LanguageId;
            if (languageId > 0)
                return "/" + WorkingCulture.Name + "/articles-by-author?id=" + authorID;
            else
                return "/articles-by-author?id=" + authorID;
        }

        protected string getAuthorImg(int authorId, string authorImg)
        {
            return "/Data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/Author/" + authorId + "/" + authorImg;
        }
    }
}