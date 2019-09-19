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
    public partial class KLAuthorFollowing : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLAuthorFollowing));
        protected List<KLAuthor> authorList = new List<KLAuthor>();
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
            SiteUser currentUser = SiteUtils.GetCurrentSiteUser();
            if(currentUser!=null)
            {

                pagenum = WebUtils.ParseInt32FromQueryString("page", pagenum);
                
                var lst = KLFowllowAuthor.GetPageByAuthorID(pagenum, pageSize, out totalPage, currentUser.UserId);
                foreach (var item in lst)
                {
                    KLAuthor author = KLAuthor.GetKLAuthorByUserID(item.AuthorID);
                    authorList.Add(author);
                }
            }
            else
            {

            }


        }
    }
}