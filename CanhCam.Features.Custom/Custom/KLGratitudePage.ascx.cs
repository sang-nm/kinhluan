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
    public partial class KLGratitudePage : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLGratitudePage));
        protected List<KLGratitude> guest = null;
        protected KLAuthor au = null;
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
            guest = KLGratitude.GetAll().OrderByDescending(g => g.CreateUtc).ToList();
        }

        protected int getUserID(int authorID)
        {
            au = new KLAuthor(authorID);
            return au.UserID;
        }

        protected string getName(int authorID)
        {
            au = new KLAuthor(authorID);
            return au.Name;
        }
        protected string getGuestImage(int authorID)
        {
            au = new KLAuthor(authorID);
            return "/Data/Sites/" + siteSettings.SiteId.ToInvariantString() + "/Author/" + getUserID(authorID) + "/" + au.Avatar;
        }
    }
}