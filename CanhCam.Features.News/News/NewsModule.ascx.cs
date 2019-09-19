/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2014-07-04

using System;
using Resources;
using System.Web.UI;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsModule : SiteModuleControl, IWorkflow
    {
        private NewsConfiguration config = null;
        public NewsConfiguration Config
        {
            get { return config; }
            set { config = value; }
        }

        private bool forceLoadDetail = false;
        public bool ForceLoadDetail
        {
            get { return forceLoadDetail; }
            set { forceLoadDetail = value; }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            this.EnableViewState = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadSettings();
            PopulateLabels();
            PopulateControls();
        }

        private void PopulateControls()
        {
            if (config.LoadFirstItem || forceLoadDetail)
            {
                Control c = Page.LoadControl("~/News/Controls/NewsViewControl.ascx");
                if (c == null) { return; }

                if (c is NewsViewControl)
                {
                    NewsViewControl newsView = (NewsViewControl)c;
                    newsView.module = this.ModuleConfiguration;
                    newsView.Config = config;
                }

                placeHolder.Controls.Add(c);
            }
            else
            {
                Control c = Page.LoadControl("~/News/Controls/NewsListControl.ascx");
                if (c == null) { return; }

                if (c is NewsListControl)
                {
                    NewsListControl newsList = (NewsListControl)c;
                    newsList.ModuleId = ModuleId;
                    newsList.Config = config;
                    newsList.SiteRoot = SiteRoot;
                    newsList.ImageSiteRoot = ImageSiteRoot;
                    newsList.ModuleTitle = this.Title;
                }

                placeHolder.Controls.Add(c);
            }

            if (forceLoadDetail)
            {
                CmsBasePage basePage = Page as CmsBasePage;
                if (basePage != null)
                {
                    basePage.LoadSideContent(config.ShowLeftContent, config.ShowRightContent, config.ShowHiddenContents);
                    basePage.LoadAltContent(NewsConfiguration.ShowTopContent, NewsConfiguration.ShowBottomContent, config.ShowHiddenContents);
                }
            }
        }

        protected virtual void PopulateLabels()
        {

        }

        protected virtual void LoadSettings()
        {
            EnsureNewsConfiguration();

            if (this.ModuleConfiguration != null)
            {
                this.Title = ModuleConfiguration.ModuleTitle;
                this.Description = ModuleConfiguration.FeatureName;
            }
        }

        private void EnsureNewsConfiguration()
        {
            if (config == null)
                config = new NewsConfiguration(Settings);
        }

        #region IWorkflow Members

        public void SubmitForApproval()
        {
            //Do nothing
        }

        public void CancelChanges()
        {
            //Do nothing
        }

        public void Approve()
        {
            //Do nothing
        }

        #endregion

        public override bool UserHasPermission()
        {
            if (!Request.IsAuthenticated)
                return false;

            bool hasPermission = false;
            EnsureNewsConfiguration();

            if (NewsPermission.CanCreate)
            {
                if (config.NewsType > 0)
                    this.EditUrl = SiteRoot + "/News/NewsEdit.aspx?type=" + config.NewsType.ToString() + "&start=" + CurrentZone.ZoneId;
                else
                    this.EditUrl = SiteRoot + "/News/NewsEdit.aspx?start=" + CurrentZone.ZoneId;

                this.EditText = NewsResources.NewsInsertLabel;

                hasPermission = true;
            }

            if (NewsPermission.CanViewList)
            {
                if (config.NewsType > 0)
                {
                    string newsListLabel = NewsHelper.GetNameByNewsType(config.NewsType, NewsResources.NewsListFormat , NewsResources.NewsList);

                    this.LiteralExtraMarkup =
                        "<dd><a class='ActionLink newslistlink' href='"
                        + SiteRoot
                        + "/News/NewsList.aspx?type=" + config.NewsType + "&start=" + CurrentZone.ZoneId + "'>"
                        + newsListLabel + "</a></dd>";
                }
                else
                    this.LiteralExtraMarkup =
                        "<dd><a class='ActionLink newslistlink' href='"
                        + SiteRoot
                        + "/News/NewsList.aspx?start=" + CurrentZone.ZoneId + "'>"
                        + NewsResources.NewsList + "</a></dd>";

                hasPermission = true;
            }

            return hasPermission;
        }

    }
}