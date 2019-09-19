using CanhCam.Business;
using CanhCam.Net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public partial class ResetPassword : SiteModuleControl
    {
        SiteUser user = null;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            btnlogin.Click += Btnlogin_Click;
        }

        private void Btnlogin_Click(object sender, EventArgs e)
        {
            user = SiteUser.GetByEmail(siteSettings, txtEmail.Text);
            if (user == null)
            {
                message.ErrorMessage = "Email does not exist";
                return;
            }
            else
            {
                user.PasswordResetGuid = Guid.NewGuid();
                user.Save();
                string url = SiteRoot + "/change-new-password?userid=" + user.UserGuid + "&tokenid=" + user.PasswordResetGuid;
                string link = "<div style='background-color: #3572b0;'><a href=" + url + " target='_blank' style='color:#ffffff;/* text-decoration:none; */font-weight:bold;' >Reset Pasword</a></div>";
                if(sendmail(link, user.Email))
                {
                    formreset2.Visible = true;
                    spanemail.InnerText = user.Email;
                    formreset.Visible = false;
                }
                else
                {
                    message.ErrorMessage = "The system failed to send email please try again";
                    return;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private bool sendmail(string link, string mailto)
        {
            try
            {
                EmailTemplate template = EmailTemplate.Get(siteSettings.SiteId, "EmailResetPasswordAuthor", WorkingCulture.LanguageId);
                string subjectEmail = template.Subject.Replace("{SiteName}", siteSettings.SiteName);
                System.Text.StringBuilder messageEmail = new System.Text.StringBuilder();
                messageEmail.Append(template.HtmlBody);
                messageEmail.Replace("{Link}", link);
                string fromAddress = siteSettings.DefaultEmailFromAddress;
                string fromAlias = template.FromName;
                if (fromAlias.Length == 0)
                    fromAlias = siteSettings.DefaultFromEmailAlias;

                string emailTo = (template.ToAddresses.Length > 0 ? ";" + template.ToAddresses : "");
                string emailCc = template.CcAddresses;
                string emailBcc = template.BccAddresses;
                string emailReplyTo = (template.ReplyToAddress.Length > 0 ? ";" + template.ReplyToAddress : "");

                SmtpSettings smtpSettings = SiteUtils.GetSmtpSettings();
                EmailMessageTask messageTask = new EmailMessageTask(smtpSettings);
                messageTask.SiteGuid = siteSettings.SiteGuid;
                messageTask.EmailFrom = fromAddress;
                messageTask.EmailFromAlias = fromAlias;
                messageTask.EmailReplyTo = emailReplyTo;
                messageTask.EmailTo = mailto;
                messageTask.EmailCc = emailCc;
                messageTask.EmailBcc = emailBcc;
                messageTask.Subject = subjectEmail;
                messageTask.UseHtml = true;
                messageTask.HtmlBody = messageEmail.ToString();
                messageTask.QueueTask();
                WebTaskManager.StartOrResumeTasks();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}