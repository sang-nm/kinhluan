using CanhCam.Business;
using CanhCam.Business.WebHelpers;
using CanhCam.Web.Framework;
using log4net;
using Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CanhCam.Web.CustomUI
{
    public partial class AuthorLevelList : CmsNonBasePage
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(AuthorLevelList));
        RadGridSEOPersister gridPersister;
        private SiteSettings siteSettings;
        private Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;
        private SiteUser currentUser = null;
        private string startZone = string.Empty;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                SiteUtils.RedirectToLoginPage(this);
                return;
            }
            PopulateLabels();
        }

        #region "RadGrid Event"

        void grid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            bool isApplied = gridPersister.IsAppliedSortFilterOrGroup;
            int iCount = KLLevel.GetCount();
            int startRowIndex = isApplied ? 1 : grid.CurrentPageIndex + 1;
            int maximumRows = isApplied ? iCount : grid.PageSize;

            grid.DataSource = KLLevel.GetPage(startRowIndex, maximumRows, out iCount);
        }

        void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {

                bool isDeleted = false;
                foreach (GridDataItem data in grid.SelectedItems)
                {
                    int levelId = Convert.ToInt32(data.GetDataKeyValue("LevelID"));
                    KLLevel level = new KLLevel(levelId);

                    if (level != null && level.LevelID != -1)
                    {
                        KLLevel.Delete(level.LevelID);
                        isDeleted = true;
                    }
                }

                if (isDeleted)
                {
                    SiteUtils.QueueIndexing();
                    grid.Rebind();

                    message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "DeleteSuccessMessage");
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
        }

        void btnSearch_Click(object sender, EventArgs e)
        {
            grid.Rebind();
        }

        #endregion

        #region Protected methods




        #endregion

        #region Populate

        private void PopulateLabels()
        {
            heading.Text = NewsResources.AuthorLevel;
            Page.Title = SiteUtils.FormatPageTitle(siteSettings, heading.Text);

            breadcrumb.CurrentPageTitle = heading.Text;
            //breadcrumb.CurrentPageUrl = GetNewsListBreadCrumb(); 
        }


        #endregion


        #region LoadSettings

        private void LoadSettings()
        {
            currentUser = SiteUtils.GetCurrentSiteUser();
            siteSettings = CacheHelper.GetCurrentSiteSettings();
        }

        #endregion


        #region OnInit

        override protected void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(this.Page_Load);

            //btnSearch.Click += new EventHandler(btnSearch_Click);
           // btnUpdate.Click += new EventHandler(btnUpdate_Click);
            btnDelete.Click += new EventHandler(btnDelete_Click);
            btnInsert.Click += new EventHandler(BtnInsert_Click);
            this.grid.NeedDataSource += new Telerik.Web.UI.GridNeedDataSourceEventHandler(grid_NeedDataSource);
            this.grid.ItemDataBound += new GridItemEventHandler(grid_ItemDataBound);
            gridPersister = new RadGridSEOPersister(grid);
        }

        private void BtnInsert_Click(object sender, EventArgs e)
        {
            WebUtils.SetupRedirect(this, SiteRoot + "/News/AuthorLevelEdit.aspx");
        }

        #endregion

        void grid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            //if (e.Item is GridDataItem)
            //{
            //    GridDataItem item = (GridDataItem)e.Item;

            //    int stateId = Convert.ToInt32(item.GetDataKeyValue("StateId"));

            //    if (stateId == -1)
            //        return;

            //    int newsId = Convert.ToInt32(item.GetDataKeyValue("NewsID"));
            //    int zoneId = Convert.ToInt32(item.GetDataKeyValue("ZoneID"));
            //    bool isPublished = Convert.ToBoolean(item.GetDataKeyValue("IsPublished"));

            //    var ibApproveContent = (ImageButton)item.FindControl("ibApproveContent");
            //    var lnkRejectContent = (HyperLink)item.FindControl("lnkRejectContent");
            //    var litWorkflowStatus = (Literal)item.FindControl("litWorkflowStatus");

            //    lnkRejectContent.NavigateUrl = SiteRoot + "/News/RejectContent.aspx?NewsID=" + newsId.ToInvariantString();
            //    lnkRejectContent.ImageUrl = Page.ResolveUrl(WebConfigSettings.RejectContentImage);
            //    //lnkRejectContent.ToolTip = NewsResources.RejectContentToolTip;

            //    ibApproveContent.CommandArgument = newsId.ToInvariantString();
            //    ibApproveContent.ImageUrl = Page.ResolveUrl(WebConfigSettings.ApproveContentImage);
            //   // ibApproveContent.ToolTip = NewsResources.ApproveContentToolTip;

            //    bool isReviewRole = false;

            //    WorkflowState workflowState = WorkflowHelper.GetWorkflowState(workflowId, stateId);
            //    if (workflowState != null && workflowState.StateId > 0)
            //    {
            //        isReviewRole = (WorkflowHelper.UserHasStatePermission(workflowId, stateId) && UserCanAuthorizeZone(zoneId));

            //        litWorkflowStatus.Text = workflowState.StateName;
            //    }

            //    if (!isPublished)
            //    {
            //        ibApproveContent.Visible = isReviewRole;
            //    }

            //    if (stateId == firstWorkflowStateId)
            //    {
            //        ibApproveContent.ImageUrl = Page.ResolveUrl(WebConfigSettings.RequestApprovalImage);
            //       // ibApproveContent.ToolTip = NewsResources.RequestApprovalToolTip;
            //    }
            //    else
            //    {
            //        lnkRejectContent.Visible = isReviewRole;
            //    }
            // }
        }
    }
}