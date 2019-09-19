/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2014-06-22
/// Last Modified:			2014-06-22

using System;
using log4net;
using CanhCam.SearchIndex;
using CanhCam.Business;
using CanhCam.Business.WebHelpers;
using Telerik.Web.UI;
using CanhCam.Web.Framework;
using System.Collections.Generic;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsMovePage : CmsNonBasePage
    {

        private static readonly ILog log = LogManager.GetLogger(typeof(NewsMovePage));
        RadGridSEOPersister gridPersister1;
        RadGridSEOPersister gridPersister2;

        private int newsType = 0;

        #region Load

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                SiteUtils.RedirectToLoginPage(this);
                return;
            }

            LoadSettings();

            if (!WebUser.IsAdminOrContentAdmin && !SiteUtils.UserIsSiteEditor())
            {
                SiteUtils.RedirectToAccessDeniedPage(this);
                return;
            }

            PopulateLabels();

            if (!Page.IsPostBack)
                PopulateControls();
        }

        #endregion

        #region "RadGrid Event"

        void grid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            grid1.PagerStyle.EnableSEOPaging = false;

            int isPublished = -1;
            string status = string.Empty;

            bool isApplied = gridPersister1.IsAppliedSortFilterOrGroup;
            int iCount = News.GetCountBySearch(siteSettings.SiteId, ddZones1.SelectedValue, newsType, isPublished, status, -1, -1, -1, null, null, null, null, null, null);
            int startRowIndex = isApplied ? 1 : grid1.CurrentPageIndex + 1;
            int maximumRows = isApplied ? iCount : grid1.PageSize;

            grid1.VirtualItemCount = iCount;
            grid1.AllowCustomPaging = !isApplied;

            grid1.DataSource = News.GetPageBySearch(siteSettings.SiteId, ddZones1.SelectedValue, newsType, isPublished, status, -1, -1, -1, null, null, null, null, null,-1,-1, null, startRowIndex, maximumRows);
        }

        void grid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            grid2.PagerStyle.EnableSEOPaging = false;

            int isPublished = -1;
            string status = string.Empty;

            bool isApplied = gridPersister2.IsAppliedSortFilterOrGroup;
            int iCount = News.GetCountBySearch(siteSettings.SiteId, ddZones2.SelectedValue, newsType, isPublished, status, -1, -1, -1, null, null, null, null, null, null);
            int startRowIndex = isApplied ? 1 : grid2.CurrentPageIndex + 1;
            int maximumRows = isApplied ? iCount : grid2.PageSize;

            grid2.VirtualItemCount = iCount;
            grid2.AllowCustomPaging = !isApplied;

            grid2.DataSource = News.GetPageBySearch(siteSettings.SiteId, ddZones2.SelectedValue, newsType, isPublished, status, -1, -1, -1, null, null, null, null, null,-1,-1, null, startRowIndex, maximumRows);
        }

        #endregion

        #region Event

        void btnLeft_Click(object sender, EventArgs e)
        {
            UpdateNewsZone(false);
        }

        void btnRight_Click(object sender, EventArgs e)
        {
            UpdateNewsZone(true);
        }

        private bool UpdateNewsZone(bool moveRight)
        {
            if (
                ddZones1.SelectedValue.Length == 0
                || ddZones2.SelectedValue.Length == 0
                || ddZones1.SelectedValue == ddZones2.SelectedValue
                )
                return false;

            bool isUpdated = false;
            if (moveRight)
            {
                foreach (GridDataItem data in grid1.SelectedItems)
                {
                    int newsId = Convert.ToInt32(data.GetDataKeyValue("NewsID"));
                    int zoneId = Convert.ToInt32(data.GetDataKeyValue("ZoneID"));

                    int zoneIdNew = zoneId;
                    int.TryParse(ddZones2.SelectedValue, out zoneIdNew);

                    if (zoneIdNew != zoneId && zoneIdNew > 0 && zoneId.ToString() == ddZones1.SelectedValue)
                    {
                        News news = new News(SiteId, newsId);

                        if (news != null && news.NewsID > 0)
                        {
                            if (News.UpdateZone(newsId, zoneIdNew))
                            {
                                List<FriendlyUrl> friendlyUrls = FriendlyUrl.GetByPageGuid(news.NewsGuid);
                                foreach (FriendlyUrl item in friendlyUrls)
                                {
                                    item.RealUrl = "~/News/NewsDetail.aspx?zoneid="
                                        + zoneIdNew.ToInvariantString()
                                        + "&NewsID=" + news.NewsID.ToInvariantString();

                                    item.Save();
                                }

                                news.ContentChanged += new ContentChangedEventHandler(news_ContentChanged);

                                LogActivity.Write("Change news zone", news.Title);

                                isUpdated = true;
                            }
                        }
                    }
                }
            }
            else
            {
                foreach (GridDataItem data in grid2.SelectedItems)
                {
                    int newsId = Convert.ToInt32(data.GetDataKeyValue("NewsID"));
                    int zoneId = Convert.ToInt32(data.GetDataKeyValue("ZoneID"));

                    int zoneIdNew = zoneId;
                    int.TryParse(ddZones1.SelectedValue, out zoneIdNew);

                    if (zoneIdNew != zoneId && zoneIdNew > 0 && zoneId.ToString() == ddZones2.SelectedValue)
                    {
                        News news = new News(SiteId, newsId);

                        if (news != null && news.NewsID > 0)
                        {
                            if (News.UpdateZone(newsId, zoneIdNew))
                            {
                                List<FriendlyUrl> friendlyUrls = FriendlyUrl.GetByPageGuid(news.NewsGuid);
                                foreach (FriendlyUrl item in friendlyUrls)
                                {
                                    item.RealUrl = "~/News/NewsDetail.aspx?zoneid="
                                        + zoneIdNew.ToInvariantString()
                                        + "&NewsID=" + news.NewsID.ToInvariantString();

                                    item.Save();
                                }

                                news.ContentChanged += new ContentChangedEventHandler(news_ContentChanged);

                                LogActivity.Write("Change news zone", news.Title);

                                isUpdated = true;
                            }
                        }
                    }
                }
            }

            if (isUpdated)
            {
                SiteUtils.QueueIndexing();

                grid1.Rebind();
                grid2.Rebind();

                message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "UpdateSuccessMessage");

                return true;
            }

            return false;
        }

        void news_ContentChanged(object sender, ContentChangedEventArgs e)
        {
            IndexBuilderProvider indexBuilder = IndexBuilderManager.Providers["NewsIndexBuilderProvider"];
            if (indexBuilder != null)
            {
                indexBuilder.ContentChangedHandler(sender, e);
            }
        }

        void ddZones1_SelectedIndexChanged(object sender, EventArgs e)
        {
            grid1.Rebind();
        }

        void ddZones2_SelectedIndexChanged(object sender, EventArgs e)
        {
            grid2.Rebind();
        }

        #endregion

        #region Protected methods

        #endregion

        #region Populate

        private void PopulateLabels()
        {
            heading.Text = NewsHelper.GetNameByNewsType(newsType, Resources.NewsResources.NewsMoveTilteFormat, Resources.NewsResources.NewsMoveTilte);
            Page.Title = SiteUtils.FormatPageTitle(siteSettings, heading.Text);

            //btnRight.ImageUrl = "~/Data/SiteImages/rt2.gif";
            //btnRight.AlternateText = Resources.NewsResources.NewsMoveRightAlternateText;
            btnRight.ToolTip = Resources.NewsResources.NewsMoveRightAlternateText;

            //btnLeft.ImageUrl = "~/Data/SiteImages/lt2.gif";
            //btnLeft.AlternateText = Resources.NewsResources.NewsMoveLeftAlternateText;
            btnLeft.ToolTip = Resources.NewsResources.NewsMoveLeftAlternateText;

            if (NewsPermission.CanViewList)
            {
                breadcrumb.ParentTitle = NewsHelper.GetNameByNewsType(newsType, Resources.NewsResources.NewsListFormat, Resources.NewsResources.NewsList);
                breadcrumb.ParentUrl = GetNewsListBreadCrumb();
            }

            breadcrumb.CurrentPageTitle = heading.Text;
            breadcrumb.CurrentPageUrl = GetNewsMoveBreadCrumb();
        }

        private string GetNewsListBreadCrumb()
        {
            if (newsType > 0)
                return "~/News/NewsList.aspx?type=" + newsType.ToString();

            return "~/News/NewsList.aspx";
        }

        private string GetNewsMoveBreadCrumb()
        {
            if (newsType > 0)
                return "~/News/NewsMove.aspx?type=" + newsType.ToString();

            return "~/News/NewsMove.aspx";
        }

        private void PopulateControls()
        {
            PopulateZoneList();
        }

        #endregion

        #region Populate Zone List

        private void PopulateZoneList()
        {
            gbSiteMapProvider.PopulateListControl(ddZones1, false, News.FeatureGuid);
            gbSiteMapProvider.PopulateListControl(ddZones2, false, News.FeatureGuid);
        }

        #endregion

        #region LoadSettings

        private void LoadSettings()
        {
            newsType = WebUtils.ParseInt32FromQueryString("type", newsType);
        }

        #endregion

        #region OnInit

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            this.Load += new EventHandler(this.Page_Load);

            btnLeft.Click += new EventHandler(btnLeft_Click);
            btnRight.Click += new EventHandler(btnRight_Click);

            grid1.NeedDataSource += new Telerik.Web.UI.GridNeedDataSourceEventHandler(grid1_NeedDataSource);
            grid2.NeedDataSource += new Telerik.Web.UI.GridNeedDataSourceEventHandler(grid2_NeedDataSource);

            ddZones1.SelectedIndexChanged += new EventHandler(ddZones1_SelectedIndexChanged);
            ddZones2.SelectedIndexChanged += new EventHandler(ddZones2_SelectedIndexChanged);

            gridPersister1 = new RadGridSEOPersister(grid1);
            gridPersister2 = new RadGridSEOPersister(grid2);
        }

        #endregion

    }
}
