/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2014-06-25
/// Last Modified:			2014-06-25

using System;
using log4net;
using CanhCam.Business;
using CanhCam.Business.WebHelpers;
using Telerik.Web.UI;
using CanhCam.Web.Framework;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsSpecialPage : CmsNonBasePage
    {

        private static readonly ILog log = LogManager.GetLogger(typeof(NewsSpecialPage));
        RadGridSEOPersister gridPersister1;
        RadGridSEOPersister gridPersister2;
        
        private int pos = -1;
        private bool canEditAnything = false;
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
            
            if (!canEditAnything)
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
            int iCount = News.GetCountBySearch(siteSettings.SiteId, ListZoneId, newsType, isPublished, status, -1, -1, -1, null, null, null, null, null, txtTitle.Text.Trim());
            int startRowIndex = isApplied ? 1 : grid1.CurrentPageIndex + 1;
            int maximumRows = isApplied ? iCount : grid1.PageSize;

            grid1.VirtualItemCount = iCount;
            grid1.AllowCustomPaging = !isApplied;

            grid1.DataSource = News.GetPageBySearch(siteSettings.SiteId, ListZoneId, newsType, isPublished, status, -1, -1, -1, null, null, null, null, null,-1,-1, txtTitle.Text.Trim(), startRowIndex, maximumRows);
        }

        void grid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            grid2.PagerStyle.EnableSEOPaging = false;

            int position = -1;
            int.TryParse(ddlPosition.SelectedValue, out position);

            if (position == -1)
            {
                grid2.DataSource = new List<News>();
                return;
            }

            int isPublished = -1;
            string status = string.Empty;

            bool isApplied = gridPersister2.IsAppliedSortFilterOrGroup;
            int iCount = News.GetCountBySearch(siteSettings.SiteId, ListZoneId, newsType, isPublished, status, -1, position, -1, null, null, null, null, null, txtTitle.Text.Trim());
            int startRowIndex = isApplied ? 1 : grid2.CurrentPageIndex + 1;
            int maximumRows = isApplied ? iCount : grid2.PageSize;

            grid2.VirtualItemCount = iCount;
            grid2.AllowCustomPaging = !isApplied;

            grid2.DataSource = News.GetPageBySearch(siteSettings.SiteId, ListZoneId, newsType, isPublished, status, -1, position, -1, null, null, null, null, null,-1,-1, txtTitle.Text.Trim(), startRowIndex, maximumRows);
        }

        private string ListZoneId
        {
            get
            {
                if (ddZones.SelectedValue.Length > 0)
                {
                    if (ddZones.SelectedValue == "-1")
                        return "";

                    return ddZones.SelectedValue;
                }

                return "0";
            }
        }

        #endregion

        #region Event

        void btnLeft_Click(object sender, EventArgs e)
        {
            UpdateNewsPosition(false);
        }

        void btnRight_Click(object sender, EventArgs e)
        {
            UpdateNewsPosition(true);
        }

        private bool UpdateNewsPosition(bool moveRight)
        {
            if (ddlPosition.SelectedValue.Length == 0)
                return false;

            bool isUpdated = false;
            if (moveRight)
            {
                foreach (GridDataItem data in grid1.SelectedItems)
                {
                    int newsId = Convert.ToInt32(data.GetDataKeyValue("NewsID"));
                    int position = Convert.ToInt32(data.GetDataKeyValue("Position"));

                    int positionNew = position;
                    int.TryParse(ddlPosition.SelectedValue, out positionNew);

                    if ((position & positionNew) == 0)
                    {
                        News news = new News(SiteId, newsId);

                        if (news != null && news.NewsID > 0)
                        {
                            news.Position = (news.Position | positionNew);
                            if (news.Position < 0)
                                news.Position = 0;

                            if (news.Save())
                            {
                                LogActivity.Write("Change news position", news.Title);

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
                    int position = Convert.ToInt32(data.GetDataKeyValue("Position"));

                    int positionNew = position;
                    int.TryParse(ddlPosition.SelectedValue, out positionNew);

                    if ((position & positionNew) > 0)
                    {
                        News news = new News(SiteId, newsId);

                        if (news != null && news.NewsID > 0)
                        {
                            news.Position = (news.Position - positionNew);
                            if (news.Position < 0)
                                news.Position = 0;

                            if (news.Save())
                            {
                                LogActivity.Write("Change news position", news.Title);

                                isUpdated = true;
                            }
                        }
                    }
                }
            }

            if (isUpdated)
            {
                grid2.Rebind();

                message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "UpdateSuccessMessage");

                return true;
            }

            return false;
        }
        
        void btnSearch_Click(object sender, EventArgs e)
        {
            grid1.Rebind();
            grid2.Rebind();
        }

        //void ddZones_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    grid1.Rebind();
        //}

        void ddlPosition_SelectedIndexChanged(object sender, EventArgs e)
        {
            grid2.Rebind();
        }

        #endregion

        #region Protected methods

        #endregion

        #region Populate

        private void PopulateLabels()
        {
            heading.Text = NewsHelper.GetNameByNewsType(newsType, Resources.NewsResources.NewsSpecialTilteFormat, Resources.NewsResources.NewsSpecialTilte);
            Page.Title = SiteUtils.FormatPageTitle(siteSettings, heading.Text);

            //btnRight.ImageUrl = "~/Data/SiteImages/rt2.gif";
            //btnLeft.ImageUrl = "~/Data/SiteImages/lt2.gif";

            if (NewsPermission.CanViewList)
            {
                breadcrumb.ParentTitle = NewsHelper.GetNameByNewsType(newsType, Resources.NewsResources.NewsListFormat, Resources.NewsResources.NewsList);
                breadcrumb.ParentUrl = GetNewsListBreadCrumb();
            }

            breadcrumb.CurrentPageTitle = heading.Text;
            breadcrumb.CurrentPageUrl = GetNewsSpecialBreadCrumb();

            lblPosition.ConfigKey = "";
            lblPosition.Text = Resources.NewsResources.NewsSelectedListLabel;
            ddlPosition.Style.Add("display", "none");
        }

        private string GetNewsListBreadCrumb()
        {
            if (newsType > 0)
                return "~/News/NewsList.aspx?type=" + newsType.ToString();

            return "~/News/NewsList.aspx";
        }

        private string GetNewsSpecialBreadCrumb()
        {
            string positionParam = string.Empty;
            if (pos > 0)
                positionParam = "pos=" + pos.ToString();

            if (newsType > 0)
            {
                positionParam = "&" + positionParam;
                return "~/News/NewsSpecial.aspx?type=" + newsType.ToString() + positionParam;
            }

            positionParam = "?" + positionParam;
            return "~/News/NewsSpecial.aspx" + positionParam;
        }

        private void PopulateControls()
        {
            List<EnumDefined> list = EnumDefined.LoadFromConfigurationXml("news");
            ddlPosition.DataSource = list;
            ddlPosition.DataBind();

            ListItem li = ddlPosition.Items.FindByValue(pos.ToString());
            if (li != null)
            {
                ddlPosition.ClearSelection();
                li.Selected = true;
            }

            PopulateZoneList();
        }

        #endregion

        #region Populate Zone List

        private void PopulateZoneList()
        {
            gbSiteMapProvider.PopulateListControl(ddZones, false, News.FeatureGuid);

            if (canEditAnything)
                ddZones.Items.Insert(0, new ListItem(ResourceHelper.GetResourceString("Resource", "All"), "-1"));
        }

        #endregion

        #region LoadSettings

        private void LoadSettings()
        {
            newsType = WebUtils.ParseInt32FromQueryString("type", newsType);
            canEditAnything = WebUser.IsAdminOrContentAdmin && SiteUtils.UserIsSiteEditor();
            pos = WebUtils.ParseInt32FromQueryString("pos", pos);
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

            //ddZones.SelectedIndexChanged += new EventHandler(ddZones_SelectedIndexChanged);
            btnSearch.Click += new EventHandler(btnSearch_Click);
            ddlPosition.SelectedIndexChanged += new EventHandler(ddlPosition_SelectedIndexChanged);

            gridPersister1 = new RadGridSEOPersister(grid1);
            gridPersister2 = new RadGridSEOPersister(grid2);
        }

        #endregion

    }
}
