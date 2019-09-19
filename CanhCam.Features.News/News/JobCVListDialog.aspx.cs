/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2013-07-17

using System;
using CanhCam.Web.Framework;
using CanhCam.Business;
using Resources;
using Telerik.Web.UI;
using log4net;
using System.Data;
using CanhCam.Business.WebHelpers;
using System.Web.Hosting;
using System.IO;

namespace CanhCam.Web.NewsUI
{
    public partial class JobCVListDialog : CmsDialogBasePage
    {

        #region Properties

        private static readonly ILog log = LogManager.GetLogger(typeof(JobCVListDialog));

        protected int zoneId = -1;
        private int newsId = -1;
        private SiteSettings siteSettings;

        protected Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;

        protected string RegexRelativeImageUrlPatern = @"^/.*[_a-zA-Z0-9]+\.(png|jpg|jpeg|gif|PNG|JPG|JPEG|GIF)$";

        private int pageNumber = 1;
        private int pageSize = 15;
        private int totalPages = 0;

        #endregion

        #region Load

        protected void Page_Load(object sender, EventArgs e)
        {
            SecurityHelper.DisableBrowserCache();

            LoadParams();
            LoadSettings();
            PopulateLabels();

            if (!SiteUtils.UserHasPermission("Permissions.News.ManageJobCV"))
            {
                SiteUtils.RedirectToAccessDeniedPage(this);
                return;
            }

            if (!Page.IsPostBack)
                PopulateControls();
        }

        #endregion

        #region Event

        void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                bool isDeleted = false;

                foreach (GridDataItem data in grid.SelectedItems)
                {
                    int intNewsID = Convert.ToInt32(data.GetDataKeyValue("NewsID"));
                    int newsCommentID = Convert.ToInt32(data.GetDataKeyValue("NewsCommentID"));

                    string virtualPath = NewsHelper.AttachmentsPath(siteSettings.SiteId, intNewsID);
                    string fileSystemPath = HostingEnvironment.MapPath(virtualPath);

                    try
                    {
                        NewsHelper.DeleteDirectory(fileSystemPath);
                    }
                    catch (Exception ex)
                    {
                        try
                        {
                            System.Threading.Thread.Sleep(0);
                            Directory.Delete(fileSystemPath, false);
                        }
                        catch (Exception)
                        {

                        }
                    }

                    News.DeleteNewsComment(newsCommentID);
                    isDeleted = true;
                }

                if (isDeleted)
                {
                    PopulateControls();
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
        }

        #endregion

        #region Protected

        protected string FormatDate(DateTime startDate)
        {
            if (timeZone != null)
            {
                return TimeZoneInfo.ConvertTimeFromUtc(startDate, timeZone).ToString();
            }

            return startDate.AddHours(timeOffset).ToString();
        }

        protected string GetAttachFile(int newsID, object attachFile1, object attachFile2)
        {
            string attachFile = string.Empty;
            if (attachFile1 != null && attachFile1.ToString().Length > 0)
            {
                attachFile += string.Format("<a class='cp-link' target='_blank' href='{0}'>{1}</a>", Page.ResolveUrl(NewsHelper.AttachmentsPath(siteSettings.SiteId, newsId)) + attachFile1, attachFile1);
            }
            if (attachFile2 != null && attachFile1.ToString().Length > 0)
            {
                if (!string.IsNullOrEmpty(attachFile))
                {
                    attachFile += "<br />";
                }
                attachFile += string.Format("<a class='cp-link' target='_blank' href='{0}'>{1}</a>", Page.ResolveUrl(NewsHelper.AttachmentsPath(siteSettings.SiteId, newsId)) + attachFile2, attachFile2);
            }

            return attachFile;
        }

        #endregion

        #region Populate

        private void PopulateLabels()
        {
            Title = SiteUtils.FormatPageTitle(siteSettings, NewsResources.JobViewCVTitle);
            
            lnkRefresh.NavigateUrl = Request.RawUrl;
            lnkRefresh.Text = NewsResources.JobApplyRefreshLink;

            lnkViewAll.Text = NewsResources.JobApplyViewAllCVLabel;
            lnkViewAll.NavigateUrl = SiteRoot + "/News/JobCVListDialog.aspx?zoneId=" + zoneId.ToString();
            lnkViewAll.Visible = (newsId > 0);

            UIHelper.AddConfirmationDialog(btnDelete, NewsResources.NewsDeleteMultiWarning);
        }

        private void PopulateControls()
        {
            using (IDataReader dataReader = News.GetPageNewsComments(newsId, pageNumber, pageSize, out totalPages))
            {
                if (this.totalPages > 1)
                {
                    string pageUrl = SiteRoot + "/News/JobCVListDialog.aspx?zoneid=" + zoneId.ToString() + "&amp;NewsID=" + newsId + "&amp;pagenumber={0}";

                    pgr.Visible = true;
                    pgr.PageURLFormat = pageUrl;
                    pgr.ShowFirstLast = true;
                    pgr.CurrentIndex = pageNumber;
                    pgr.PageSize = pageSize;
                    pgr.PageCount = totalPages;

                }
                else
                {
                    pgr.Visible = false;
                }

                grid.DataSource = dataReader;
                grid.CurrentPageIndex = pageNumber - 1;
                grid.PageSize = pageSize;
                grid.AllowPaging = false;
                grid.DataBind();
            }
        }

        #endregion

        #region LoadSettings

        private void LoadSettings()
        {
            siteSettings = CacheHelper.GetCurrentSiteSettings();
            RegexRelativeImageUrlPatern = SecurityHelper.RegexRelativeImageUrlPatern;
        }

        #endregion

        #region LoadParams

        private void LoadParams()
        {
            zoneId = WebUtils.ParseInt32FromQueryString("zoneid", zoneId);
            newsId = WebUtils.ParseInt32FromQueryString("NewsID", newsId);

            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();
        }

        #endregion

        #region OnInit

        override protected void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(this.Page_Load);

            btnDelete.Click += new EventHandler(btnDelete_Click);
        }

        #endregion

    }
}
