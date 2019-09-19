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
    public partial class AuthorManageGratitude : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(AuthorManageGratitude));
        protected List<KLGratitude> grat = null;
        private KLAuthor aut = null;
        private SiteUser current = null;
        protected int pagenum = 1;
        protected int pageSize = 5;
        protected int totalPage = 1;
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
            if (!IsPostBack)
            {
            }
        }

        private void LoadSettings()
        {
            current = SiteUtils.GetCurrentSiteUser();
            if (current != null)
            {
                aut = KLAuthor.GetKLAuthorByUserID(current.UserId);
                if (aut == null)
                {
                    WebUtils.SetupRedirect(this, SiteRoot);
                }
                grat = KLGratitude.GetAll().Where(g => g.AuthorID == aut.AuthorID).ToList();
                listviewGratitude.DataSource = grat.OrderByDescending(x => x.CreateUtc);
                listviewGratitude.DataBind();

                GeneralVariables.NameAuthor = current.Name;
                GeneralVariables.Level = aut.LevelAuthor;
            }
            else
            {
                WebUtils.SetupRedirect(this, SiteRoot);
            }
        }

        protected string getImageURL()
        {
            return AuthorHepper.GetAvatarAuthor(siteSettings.SiteId, current.UserId);
        }

        protected void listviewGratitude_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.Item != null)
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                Label lbGuestID = (Label)e.Item.FindControl("GuestID");
                try
                {
                    if (String.Equals(e.CommandName.ToLower(), "fix"))
                    {
                        KLGratitude grat = new KLGratitude(int.Parse(lbGuestID.Text));
                        WebUtils.SetupRedirect(this, SiteRoot +"/add-gratitude?GuestID="+ grat.GuestID);
                    }
                    else if (String.Equals(e.CommandName.ToLower(), "delete"))
                    {
                        int index = e.Item.DisplayIndex;
                        listviewGratitude.DeleteItem(index);
                        KLGratitude.Delete(int.Parse(lbGuestID.Text));
                        WebUtils.SetupRedirect(this, SiteRoot + "/add-gratitude");
                    }
                    //int index = e.Item.DisplayIndex;
                    //listviewGratitude.DeleteItem(index);
                    //KLGratitude.Delete(int.Parse(lbGuestID.Text));
                }
                catch (Exception ex)
                {
                    log.Error(ex.Message);
                }
            }
            //WebUtils.SetupRedirect(this, Request.RawUrl);
        }

        protected void listviewGratitude_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
        }
        
    }
}