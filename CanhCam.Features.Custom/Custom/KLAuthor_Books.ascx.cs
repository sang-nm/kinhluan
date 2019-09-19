using CanhCam.Business;
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
    public partial class KLAuthor_Books : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLAuthor_Books));
        protected List<KLBook> book = null;
        protected int authorID = -1;
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
            LoadParams();
        }
        private void LoadParams()
        {
            pagenum = WebUtils.ParseInt32FromQueryString("page", pagenum);
            authorID = WebUtils.ParseInt32FromQueryString("id", authorID);
            //xong
            if (authorID > -1)
            {
                book = KLBook.GetPageByAuthorid(pagenum, pageSize, out totalPage,authorID,"").ToList();
            }
        }

        protected string getBookUrl(int BookID)
        {
            int languageId = WorkingCulture.LanguageId;
            if (languageId > 0)
                return "/" + WorkingCulture.Name + "/books-by-author?id=" + BookID;
            else
                return "/books-by-author?id=" + BookID;
        }

        protected string BookImageUrl(int bookID, string bookimg)
        {
            return "/Data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/book/" + bookID +"/"+ bookimg;
        }
        
    }
}