/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			    2013-05-15
/// Last Modified:		    2013-07-12

using System;
using System.Text;
using CanhCam.Business;
using CanhCam.Net;
using CanhCam.Web.Framework;
using Resources;
using log4net;
using CanhCam.Business.WebHelpers;

namespace CanhCam.Web.NewsUI
{
    public partial class EmailSubjectDialog : CmsDialogBasePage
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(EmailSubjectDialog));

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += Page_Load;
            this.btnSend.Click += btnSend_Click;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadSettings();
            PopulateLabels();
            PopulateControls();
        }

        private void PopulateControls()
        {
            if (!Page.IsPostBack)
            {
                if (Request.IsAuthenticated)
                {
                    SiteUser siteUser = SiteUtils.GetCurrentSiteUser();
                    if (siteUser != null)
                    {
                        this.txtEmail.Text = siteUser.Email;
                        this.txtName.Text = siteUser.Name;
                    }
                }
            }
        }

        private void btnSend_Click(object sender, EventArgs e)
        {
            bool isValid = true;
            reqEmail.Validate();
            if (!reqEmail.IsValid) { isValid = false; }
            regexEmail.Validate();
            if (!regexEmail.IsValid) { isValid = false; }

            reqToEmail.Validate();
            if (!reqToEmail.IsValid) { isValid = false; }
            regexToEmail.Validate();
            if (!regexToEmail.IsValid) { isValid = false; }

            if (isValid)
            {
                //string messageTemplate = MessageTemplate.GetMessage("EmailSubjectNotification");
                //string url = WebUtils.ParseStringFromQueryString("u", string.Empty);

                //StringBuilder message = new StringBuilder();
                //message.Append(messageTemplate);
                //message.Replace("{SiteName}", siteSettings.SiteName);
                //message.Replace("{Name}", txtName.Text);
                //message.Replace("{Email}", txtEmail.Text);
                //message.Replace("{Link}", url);
                //message.Replace("{Message}", txtMessage.Text);

                //string fromAddress = siteSettings.DefaultEmailFromAddress;

                EmailTemplate template = EmailTemplate.Get(siteSettings.SiteId, "EmailSubjectNotification", WorkingCulture.LanguageId);
                string subjectEmail = template.Subject.Replace("{SiteName}", siteSettings.SiteName).Replace("{Subject}", txtSubject.Text.Trim());
                string url = WebUtils.ParseStringFromQueryString("u", string.Empty);

                StringBuilder message = new StringBuilder();
                message.Append(template.HtmlBody);
                message.Replace("{SiteName}", siteSettings.SiteName);
                message.Replace("{Name}", txtName.Text);
                message.Replace("{Email}", txtEmail.Text);
                message.Replace("{Link}", url);
                message.Replace("{Message}", txtMessage.Text);

                string fromAddress = siteSettings.DefaultEmailFromAddress;
                string fromAlias = template.FromName;
                if (fromAlias.Length == 0)
                    fromAlias = siteSettings.DefaultFromEmailAlias;

                string emailTo = (template.ToAddresses.Length > 0 ? ";" + template.ToAddresses : "");
                string emailCc = template.CcAddresses;
                string emailBcc = template.BccAddresses;
                string emailReplyTo = (template.ReplyToAddress.Length > 0 ? ";" + template.ReplyToAddress : "");

                SmtpSettings smtpSettings = SiteUtils.GetSmtpSettings();

                try
                {
                    //Email.SendEmail(
                    //    smtpSettings,
                    //    fromAddress,
                    //    txtEmail.Text,
                    //    txtToEmail.Text,
                    //    string.Empty,
                    //    string.Empty,
                    //    "[" + siteSettings.SiteName + "]" + (this.txtSubject.Text.Trim() != "" ? (": " + this.txtSubject.Text.Trim()) : ""),
                    //    message.ToString(),
                    //    true,
                    //    "Normal");

                    EmailMessageTask messageTask = new EmailMessageTask(smtpSettings);
                    messageTask.SiteGuid = siteSettings.SiteGuid;
                    messageTask.EmailFrom = fromAddress;
                    messageTask.EmailFromAlias = fromAlias;
                    messageTask.EmailReplyTo = txtEmail.Text.Trim() + emailReplyTo;
                    messageTask.EmailTo = txtToEmail.Text.Trim() + emailTo;
                    messageTask.EmailCc = emailCc;
                    messageTask.EmailBcc = emailBcc;
                    messageTask.UseHtml = true;
                    messageTask.Subject = subjectEmail;
                    messageTask.HtmlBody = message.ToString();
                    messageTask.QueueTask();

                    WebTaskManager.StartOrResumeTasks();
                }
                catch (Exception ex)
                {
                    log.Error("Error sending email from address was " + fromAddress + " to address was " + txtToEmail.Text, ex);
                }

                this.lblMessage.Text = MessageTemplate.GetMessage("EmailSubjectThankYouMessage", NewsResources.EmailSubjectThankYouLabel);
                this.pnlSend.Visible = false;
                SetupScript();
            }
        }

        private void SetupScript()
        {
            StringBuilder script = new StringBuilder();

            script.Append("<script type=\"text/javascript\">");
            script.Append("setTimeout(function(){parent.$.fancybox.close()},3000);");
            script.Append("</script>");

            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "cbemailsubjectclose", script.ToString());
        }

        private void PopulateLabels()
        {
            this.reqEmail.ToolTip = NewsResources.EmailSubjectEmailAddressRequired;
            this.regexEmail.ToolTip = NewsResources.EmailSubjectValidEmailAddressLabel;

            this.reqToEmail.ToolTip = NewsResources.EmailSubjectToEmailAddressRequired;
            this.regexToEmail.ToolTip = NewsResources.EmailSubjectValidToEmailAddressLabel;
        }

        private void LoadSettings()
        {
            regexEmail.ValidationExpression = SecurityHelper.RegexEmailValidationPattern;
            regexToEmail.ValidationExpression = SecurityHelper.RegexEmailValidationPattern;

            CmsBasePage basePage = Page as CmsBasePage;
            if (basePage != null) { basePage.ScriptConfig.IncludeFancyBox = true; }
        }
    }
}