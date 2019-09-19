/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			    2014-06-24
/// Last Modified:		    2014-06-24

using System;
using System.Linq;
using CanhCam.Web.Framework;
using CanhCam.Business;
using CanhCam.Net;
using System.Text;
using log4net;
using Resources;

namespace CanhCam.Web.NewsUI
{
    public partial class RejectContent : CmsNonBasePage
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(RejectContent));

        private int workflowId = -1;
        private bool isReviewRole = false;
        private int newsId = -1;
        private News news = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                SiteUtils.RedirectToLoginPage(this);
                return;
            }

            SecurityHelper.DisableBrowserCache();

            LoadSettings();

            if (!isReviewRole)
            {
                SiteUtils.RedirectToEditAccessDeniedPage();
                return;
            }

            PopulateLabels();

            if (!Page.IsPostBack)
            {
                if ((Request.UrlReferrer != null) && (hdnReturnUrl.Value.Length == 0))
                {
                    if (!Request.UrlReferrer.ToString().Contains("/News/RejectContent.aspx"))
                        hdnReturnUrl.Value = Request.UrlReferrer.ToString();
                }
            }
        }

        private void PopulateLabels()
        {
            heading.Text = NewsResources.RejectContentHeading;
            Title = SiteUtils.FormatPageTitle(siteSettings, heading.Text);

            btnUpdate.Text = NewsResources.RejectionPageUpdateButton;
            btnCancel.Text = NewsResources.NewsEditCancelButton;

            UIHelper.DisableButtonAfterClick(
                btnUpdate,
                ResourceHelper.GetResourceString("Resource", "ButtonDisabledPleaseWait"),
                Page.ClientScript.GetPostBackEventReference(this.btnUpdate, string.Empty)
                );

            string contentAuthorName = "?";
            if (news.CreatedByName.Length > 0)
                contentAuthorName = news.CreatedByName;
            else if (news.UserEmail.Length > 0)
                contentAuthorName = news.UserEmail;

            litRejectionIntroduction.Text = String.Format(NewsResources.RejectionIntroduction, NewsResources.RejectionPageUpdateButton, news.Title, contentAuthorName);
        }

        private void LoadSettings()
        {
            workflowId = WorkflowHelper.GetWorkflowId(News.FeatureGuid);
            newsId = WebUtils.ParseInt32FromQueryString("NewsID", -1);
            news = new News(siteSettings.SiteId, newsId);

            if (news != null && news.NewsID > 0 && news.StateId.HasValue)
                isReviewRole = WorkflowHelper.UserHasStatePermission(workflowId, news.StateId.Value) && UserCanAuthorizeZone(news.ZoneID);
            
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            SiteUser currentUser = SiteUtils.GetCurrentSiteUser();
            if (currentUser == null)
            {
                WebUtils.SetupRedirect(this, SiteUtils.GetCurrentZoneUrl());
                return;
            }

            DateTime? requestedUtc = news.ApprovedUtc;

            news.StateId = WorkflowHelper.GetFirstWorkflowStateId(workflowId);
            news.ApprovedUserGuid = currentUser.UserGuid;
            news.ApprovedBy = Context.User.Identity.Name.Trim();
            news.ApprovedUtc = DateTime.UtcNow;
            news.RejectedNotes = txtRejectionComments.Text.Trim();
            news.SaveState();
            
            if (!WebConfigSettings.DisableWorkflowNotification)
            {
                //SendRejectionNotification(
                //    SiteUtils.GetSmtpSettings(),
                //    siteSettings,
                //    requestedUtc,
                //    currentUser,
                //    txtRejectionComments.Text);

                string requestedDate = string.Empty;
                if (requestedUtc.HasValue)
                    requestedDate = DateTimeHelper.GetLocalTimeString(requestedUtc, SiteUtils.GetUserTimeZone(), SiteUtils.GetUserTimeOffset());

                WorkflowHelper.SendRejectionNotification(
                    workflowId, 
                    news.UserEmail, 
                    currentUser.Email, 
                    "{Title}", news.Title, 
                    "{RejectedDate}", requestedDate,
                    "{RejectionReason}", txtRejectionComments.Text,
                    "{RejectedBy}", currentUser.Name,
                    "{SiteName}", siteSettings.SiteName
                    );
            }

            SetupRedirect();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            SetupRedirect();
        }

        private void SetupRedirect()
        {
            if (hdnReturnUrl.Value.Length > 0)
            {
                if (!hdnReturnUrl.Value.ContainsCaseInsensitive("/News/RejectContent.aspx"))
                {
                    WebUtils.SetupRedirect(this, hdnReturnUrl.Value);
                    return;
                }
            }

            SiteUtils.RedirectToHomepage();
        }

        private void SendRejectionNotification(
            SmtpSettings smtpSettings,
            SiteSettings siteSettings,
            DateTime? requestedUtc,
            SiteUser rejectingUser,
            string rejectionReason
            )
        {
            string requestedDate = string.Empty;
            if (requestedUtc.HasValue)
                requestedDate = DateTimeHelper.GetLocalTimeString(requestedUtc, SiteUtils.GetUserTimeZone(), SiteUtils.GetUserTimeOffset());

            StringBuilder message = new StringBuilder();
            message.Append(MessageTemplate.GetMessage("ApprovalRequestRejectionNotification"));
            message.Replace("{Title}", news.Title);
            message.Replace("{ApprovalRequestedDate}", requestedDate);
            message.Replace("{RejectionReason}", rejectionReason);
            message.Replace("{RejectedBy}", rejectingUser.Name);

            if (!Email.IsValidEmailAddressSyntax(news.UserEmail))
            {
                //invalid address log it
                log.Error("Failed to send workflow rejection message, invalid recipient email "
                    + news.UserEmail
                    + " message was " + message.ToString());

                return;
            }

            EmailMessageTask messageTask = new EmailMessageTask(smtpSettings);
            messageTask.SiteGuid = siteSettings.SiteGuid;
            messageTask.EmailFrom = siteSettings.DefaultEmailFromAddress;
            messageTask.EmailFromAlias = siteSettings.DefaultFromEmailAlias;
            messageTask.EmailReplyTo = rejectingUser.Email;
            messageTask.EmailTo = news.UserEmail;
            messageTask.UseHtml = true;
            messageTask.Subject = MessageTemplate.GetMessage("ApprovalRequestRejectionNotificationSubject").Replace("{SiteName}", siteSettings.SiteName);
            messageTask.HtmlBody = message.ToString();
            messageTask.QueueTask();

            WebTaskManager.StartOrResumeTasks();

            //Email.Send(
            //            smtpSettings,
            //            siteSettings.DefaultEmailFromAddress,
            //            siteSettings.DefaultFromEmailAlias,
            //            rejectingUser.Email,
            //            news.UserEmail,
            //            string.Empty,
            //            string.Empty,
            //            MessageTemplate.GetMessage("ApprovalRequestRejectionNotificationSubject").Replace("{SiteName}", siteSettings.SiteName),
            //            message.ToString(),
            //            false,
            //            Email.PriorityNormal);
        }

    }
}
