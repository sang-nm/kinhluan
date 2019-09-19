/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-07-29
/// Last Modified:			2013-07-29

using System;
using System.Text;
using System.Web.UI;
using log4net;
using CanhCam.Business;
using CanhCam.Web.Framework;
using Resources;
using System.Collections;
using CanhCam.Business.WebHelpers;
using System.Web;
using System.IO;

namespace CanhCam.Web.NewsUI
{
    public partial class JobApplyControl : UserControl
    {
        #region Properties

        private static readonly ILog log = LogManager.GetLogger(typeof(JobApplyControl));

        protected int newsId = -1;
        private News news = null;
        private SiteUser currentUser = null;
        private SiteSettings siteSettings;
        private CmsDialogBasePage basePage;
        private string url = string.Empty;

        #endregion

        #region OnInit

        override protected void OnInit(EventArgs e)
        {
            this.Load += new EventHandler(this.Page_Load);
            this.btnPostComment.Click += new EventHandler(this.btnPostComment_Click);

            basePage = Page as CmsDialogBasePage;

            base.OnInit(e);
        }

        #endregion

        private void Page_Load(object sender, EventArgs e)
        {
            LoadSettings();

            if (news == null)
            {
                this.Visible = false;
                return;
            }

            PopulateLabels();

            if (!IsPostBack) { PopulateControls(); }
        }

        protected virtual void PopulateControls()
        {
            txtPosition.Text = news.Title;

            if (Request.IsAuthenticated)
            {
                SiteUser currentUser = SiteUtils.GetCurrentSiteUser();
                txtFullName.Text = currentUser.Name;
                txtEmail.Text = currentUser.Email;
            }
        }

        private void btnPostComment_Click(object sender, EventArgs e)
        {
            if (!IsValidComment())
            {
                return;
            }
            if (news == null) { return; }

            //if (news.AllowCommentsForDays < 0)
            //{
            //    WebUtils.SetupRedirect(this, Request.RawUrl);
            //    return;
            //}

            //DateTime endDate = news.StartDate.AddDays((double)news.AllowCommentsForDays);
            //if ((endDate < DateTime.UtcNow) && (news.AllowCommentsForDays > 0)) { return; }

            string attachFile1 = null;
            string attachFile2 = null;
            string attachmentsPath = NewsHelper.AttachmentsPath(siteSettings.SiteId, news.NewsID);
            if (uplAttachFile1.UploadedFiles.Count > 0 || uplAttachFile2.UploadedFiles.Count > 0)
            {
                try
                {
                    string fileSystemPath = Server.MapPath(attachmentsPath);

                    if (!Directory.Exists(fileSystemPath))
                    {
                        Directory.CreateDirectory(fileSystemPath);
                    }
                }
                catch (Exception ex)
                {

                }
            }

            if (uplAttachFile1.UploadedFiles.Count > 0)
            {
                if (SiteUtils.IsAllowedUploadBrowseFile(uplAttachFile1.UploadedFiles[0].GetExtension(), NewsConfiguration.JobApplyAttachFileExtensions))
                {
                    attachFile1 = uplAttachFile1.UploadedFiles[0].FileName.ToCleanFileName(WebConfigSettings.ForceLowerCaseForUploadedFiles);

                    int i = 1;
                    while (File.Exists(VirtualPathUtility.Combine(attachmentsPath, attachFile1)))
                    {
                        attachFile1 = i.ToInvariantString() + attachFile1;
                        i += 1;
                    }
                }
            }
            if (uplAttachFile2.UploadedFiles.Count > 0)
            {
                if (SiteUtils.IsAllowedUploadBrowseFile(uplAttachFile2.UploadedFiles[0].GetExtension(), NewsConfiguration.JobApplyAttachFileExtensions))
                {
                    attachFile2 = uplAttachFile2.UploadedFiles[0].FileName.ToCleanFileName(WebConfigSettings.ForceLowerCaseForUploadedFiles);

                    int i = 1;
                    while (File.Exists(VirtualPathUtility.Combine(attachmentsPath, attachFile2)))
                    {
                        attachFile2 = i.ToInvariantString() + attachFile2;
                        i += 1;
                    }
                }
            }

            News.AddNewsComment(
                        news.NewsID,
                        txtFullName.Text,
                        txtPosition.Text,
                        url,
                        txtMessage.Text,
                        txtAddress.Text,
                        txtEmail.Text,
                        txtPhone.Text,
                        attachFile1,
                        attachFile2,
                        DateTime.UtcNow);

            if (!string.IsNullOrEmpty(attachFile1))
            {
                string newAttachmentsPath = VirtualPathUtility.Combine(attachmentsPath, attachFile1);
                uplAttachFile1.UploadedFiles[0].SaveAs(Server.MapPath(newAttachmentsPath));
            }
            if (!string.IsNullOrEmpty(attachFile2))
            {
                string newAttachmentsPath = VirtualPathUtility.Combine(attachmentsPath, attachFile2);
                uplAttachFile2.UploadedFiles[0].SaveAs(Server.MapPath(newAttachmentsPath));
            }

            try
            {
                StringBuilder message = new StringBuilder();

                //message.Append(string.Format("<a target='_blank' href='{0}'>{1}</a>", url, url) + "<br /><br />");

                if (!string.IsNullOrEmpty(txtPosition.Text.Trim()))
                    message.Append("<b>" + NewsResources.JobPositionLabel + ":</b> " + txtPosition.Text.Trim() + "<br />");
                if (!string.IsNullOrEmpty(txtFullName.Text.Trim()))
                    message.Append("<b>" + NewsResources.JobFullNameLabel + ":</b> " + txtFullName.Text.Trim() + "<br />");
                if (!string.IsNullOrEmpty(txtAddress.Text.Trim()))
                    message.Append("<b>" + NewsResources.JobAddressLabel + ":</b> " + txtAddress.Text.Trim() + "<br />");
                if (!string.IsNullOrEmpty(txtEmail.Text.Trim()))
                    message.Append("<b>" + NewsResources.JobEmailLabel + ":</b> " + txtEmail.Text.Trim() + "<br />");
                if (!string.IsNullOrEmpty(txtPhone.Text.Trim()))
                    message.Append("<b>" + NewsResources.JobPhoneLabel + ":</b> " + txtPhone.Text.Trim() + "<br />");
                if (!string.IsNullOrEmpty(attachFile1))
                {
                    string attachFile = string.Format("<a target='_blank' href='{0}'>{1}</a>", basePage.SiteRoot + Page.ResolveUrl(NewsHelper.AttachmentsPath(siteSettings.SiteId, newsId)) + attachFile1, attachFile1);
                    message.Append("<b>" + NewsResources.JobAttachFile1Label + ":</b> " + attachFile + "<br />");
                }
                if (!string.IsNullOrEmpty(attachFile2))
                {
                    string attachFile = string.Format("<a target='_blank' href='{0}'>{1}</a>", basePage.SiteRoot + Page.ResolveUrl(NewsHelper.AttachmentsPath(siteSettings.SiteId, newsId)) + attachFile2, attachFile2);
                    message.Append("<b>" + NewsResources.JobAttachFile2Label + ":</b> " + attachFile + "<br />");
                }

                message.Append("<b>" + NewsResources.JobMessageLabel + ":</b><br />" + SiteUtils.ChangeRelativeUrlsToFullyQualifiedUrls(SiteUtils.GetNavigationSiteRoot(), WebUtils.GetSiteRoot(), txtMessage.Text));
                message.Append("<br /><br />");

                EmailTemplate template = EmailTemplate.Get(siteSettings.SiteId, "JobApplyNotification");

                string fromAddress = siteSettings.DefaultEmailFromAddress;
                string fromAlias = template.FromName;
                if (fromAlias.Length == 0)
                    fromAlias = siteSettings.DefaultFromEmailAlias;

                NewsHelper.SendCommentNotification(
                            SiteUtils.GetSmtpSettings(),
                            siteSettings.SiteGuid,
                            fromAddress,
                            fromAlias,
                            template.ToAddresses,
                            template.ReplyToAddress,
                            template.CcAddresses,
                            template.BccAddresses,
                            template.Subject,
                            template.HtmlBody,
                            siteSettings.SiteName,
                            message.ToString());
            }
            catch (Exception ex)
            {
                log.Error("Error sending email from address was " + siteSettings.DefaultEmailFromAddress + " to address was " + siteSettings.CompanyPublicEmail, ex);
            }

            lblMessage.Text = MessageTemplate.GetMessage("JobApplyThankYouMessage", NewsResources.JobApplyThankYouLabel);
            pnlNewComment.Visible = false;
        }

        private void PopulateLabels()
        {
            captcha.ProviderName = siteSettings.CaptchaProvider;
            captcha.Captcha.ControlID = "captcha" + news.NewsID.ToInvariantString();
            //captcha.RecaptchaPrivateKey = basePage.SiteInfo.RecaptchaPrivateKey;
            //captcha.RecaptchaPublicKey = basePage.SiteInfo.RecaptchaPublicKey;
            //regexUrl.ToolTip = NewsResources.WebSiteUrlRegexWarning;

            btnPostComment.Text = NewsResources.NewsCommentPostCommentButton;
            SiteUtils.SetButtonAccessKey(btnPostComment, NewsResources.NewsCommentPostCommentButtonAccessKey);
        }

        private void LoadSettings()
        {
            newsId = WebUtils.ParseInt32FromQueryString("NewsID", newsId);

            siteSettings = CacheHelper.GetCurrentSiteSettings();

            news = new News(siteSettings.SiteId, newsId, WorkingCulture.LanguageId);

            if (news == null || news.NewsID == -1)
            {
                news = null;
                return;
            }

            url = WebUtils.ParseStringFromQueryString("u", string.Empty);
            if (url.Length == 0)
                url = NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID);

            basePage.Title = SiteUtils.FormatPageTitle(siteSettings, news.Title);
            basePage.MetaDescription = news.MetaDescription;
            basePage.MetaKeywords = news.MetaKeywords;

            currentUser = SiteUtils.GetCurrentSiteUser();

            pnlAntiSpam.Visible = false;
            captcha.Visible = false;
            captcha.Enabled = false;

            uplAttachFile1.MaxFileSize = NewsConfiguration.JobApplyAttachFileSize * 1048576;
            uplAttachFile1.AllowedFileExtensions = NewsConfiguration.JobApplyAttachFileExtensions.Replace(".", string.Empty).Split('|');
            uplAttachFile2.MaxFileSize = uplAttachFile1.MaxFileSize;
            uplAttachFile2.AllowedFileExtensions = uplAttachFile1.AllowedFileExtensions;

            var litAttachFileNote1 = this.FindControl("litAttachFileNote1") as System.Web.UI.WebControls.Literal;
            var litAttachFileNote2 = this.FindControl("litAttachFileNote2") as System.Web.UI.WebControls.Literal;
            if (litAttachFileNote1 != null && litAttachFileNote2 != null)
            {
                litAttachFileNote1.Text = NewsConfiguration.JobApplyAttachFileNote;
                litAttachFileNote2.Text = NewsConfiguration.JobApplyAttachFileNote;
            }
        }

        private bool IsValidComment()
        {
            if (txtMessage.Text.Length == 0) { return false; }

            bool result = true;

            try
            {
                result = Page.IsValid;
            }
            catch (NullReferenceException)
            {
                //Recaptcha throws nullReference here if it is not visible/disabled
            }
            catch (ArgumentNullException)
            {
                //manipulation can make the Challenge null on recaptcha
            }

            try
            {
                if ((pnlAntiSpam.Visible))
                {
                    //result = captcha.IsValid;
                    bool captchaIsValid = captcha.IsValid;
                    if (captchaIsValid)
                    {
                        if (!result)
                        {
                            // they solved the captcha but somehting else is invalid
                            // don't make them solve the captcha again
                            pnlAntiSpam.Visible = false;
                            captcha.Visible = false;
                            captcha.Enabled = false;

                        }

                    }
                    else
                    {
                        //captcha was invalid
                        result = false;
                    }
                }
            }
            catch (NullReferenceException)
            {
                return false;
            }
            catch (ArgumentNullException)
            {
                //manipulation can make the Challenge null on recaptcha
                return false;
            }

            return result;
        }

    }
}