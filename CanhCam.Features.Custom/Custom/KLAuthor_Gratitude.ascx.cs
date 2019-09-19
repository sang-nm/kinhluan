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
    public partial class KLAuthor_Gratitude : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLAuthor_Gratitude));
        protected List<KLGratitude> guests = null;
        protected int authorID = -1;
        protected int totalPage = 0;
        protected int pageSize = 2;
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
            loadParams();
        }

        private void loadParams()
        {
            authorID = WebUtils.ParseInt32FromQueryString("id", authorID);
            if (authorID > -1)
            {
                guests = KLGratitude.GetAll().Where(g => g.AuthorID == authorID).ToList();
            }
        }

        protected string getGuestImage(int authorid)
        {
            int userid = new KLAuthor(authorid).UserID;
            return AuthorHepper.GetAvatarAuthor(siteSettings.SiteId, userid);
        }
        protected string getName(int authorid)
        {
            KLAuthor author = new KLAuthor(authorID);
            SiteUser user = new SiteUser(siteSettings, author.UserID);
            return user.Name;

        }
    }
}