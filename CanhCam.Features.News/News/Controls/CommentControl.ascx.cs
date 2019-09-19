/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-07-29
/// Last Modified:			2013-07-29

using System;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using log4net;
using CanhCam.Business;
using CanhCam.Net;
using CanhCam.Web.Editor;
using CanhCam.Web.Framework;
using CanhCam.Web.UI;
using Resources;
using System.Xml;
using System.Configuration;
using CanhCam.Business.WebHelpers;

namespace CanhCam.Web.NewsUI
{
    public partial class CommentControl : UserControl, IUpdateCommentStats, IRefreshAfterPostback
    {
        #region Properties

        private static readonly ILog log = LogManager.GetLogger(typeof(CommentControl));

        protected NewsConfiguration config = new NewsConfiguration();
        private SiteUser currentUser = null;
        private News news = null;
        protected string DeleteLinkImage = "~/Data/SiteImages/" + WebConfigSettings.DeleteLinkImage;

        private int pageNumber = 1;
        private int totalPages = 1;

        protected int pageId = -1;

        protected bool allowComments = true;
        protected Double timeOffset = 0;
        private TimeZoneInfo timeZone = null;

        protected bool isEditable = false;

        protected string EditContentImage = ConfigurationManager.AppSettings["EditContentImage"];

        protected string SiteRoot = string.Empty;
        private CmsBasePage basePage;
        protected string RegexRelativeImageUrlPatern = @"^/.*[_a-zA-Z0-9]+\.(png|jpg|jpeg|gif|PNG|JPG|JPEG|GIF)$";

        public bool IsEditable
        {
            get { return isEditable; }
            set
            {
                isEditable = value;
            }
        }

        public NewsConfiguration Config
        {
            get { return config; }
            set { config = value; }
        }

        public News News
        {
            get { return news; }
            set 
            { 
                news = value; 
            }
        }

        #endregion

        #region OnInit

        override protected void OnInit(EventArgs e)
        {
            this.Load += new EventHandler(this.Page_Load);
            this.btnPostComment.Click += new EventHandler(this.btnPostComment_Click);
            this.dlComments.ItemCommand += new RepeaterCommandEventHandler(dlComments_ItemCommand);
            this.dlComments.ItemDataBound += new RepeaterItemEventHandler(dlComments_ItemDataBound);
            
            base.OnInit(e);
            basePage = Page as CmsBasePage;
            SiteRoot = basePage.SiteRoot;

            SiteUtils.SetupEditor(this.edComment, true, Page);
        }

        #endregion

        private void Page_Load(object sender, EventArgs e)
        {
            LoadSettings();

            if (!allowComments)
            {
                this.Visible = false;
                return;
            }

            PopulateLabels();
            PopulateControls();
        }

        protected virtual void PopulateControls()
        {
            SetupCommentSystem();
        }

        protected string FormatDate(object startDate, string format = "")
        {
            if (startDate == null)
                return string.Empty;

            if (timeZone != null)
            {
                return TimeZoneInfo.ConvertTimeFromUtc(Convert.ToDateTime(startDate), timeZone).ToString(format);
            }

            return Convert.ToDateTime(startDate).AddHours(timeOffset).ToString(format);
        }

        public void UpdateCommentStats(Guid contentGuid, int commentCount)
        {
            News.UpdateCommentCount(contentGuid, commentCount);
        }

        private void btnPostComment_Click(object sender, EventArgs e)
        {
            if (!ShouldAllowComments())
            {
                WebUtils.SetupRedirect(this, Request.RawUrl);
                return;
            }
            if (!IsValidComment())
            {
                //SetupInternalCommentSystem();
                PopulateControls();
                return;
            }
            if (news == null) { return; }

            if (news.AllowCommentsForDays < 0)
            {
                WebUtils.SetupRedirect(this, Request.RawUrl);
                return;
            }

            DateTime endDate = news.StartDate.AddDays((double)news.AllowCommentsForDays);

            if ((endDate < DateTime.UtcNow) && (news.AllowCommentsForDays > 0)) { return; }

            if (this.chkRememberMe.Checked)
            {
                SetCookies();
            }

            News.AddNewsComment(
                    news.NewsID,
                    this.txtName.Text,
                    this.txtCommentTitle.Text,
                    this.txtURL.Text,
                    edComment.Text,
                    DateTime.UtcNow);

            if (config.NotifyOnComment)
            {
                //added this due to news coment spam and need to be able to ban the ip of the spammer
                StringBuilder message = new StringBuilder();
                message.Append(basePage.SiteRoot + news.Url.Replace("~", string.Empty));

                message.Append("\n\nHTTP_USER_AGENT: " + Page.Request.ServerVariables["HTTP_USER_AGENT"] + "\n");
                message.Append("HTTP_HOST: " + Page.Request.ServerVariables["HTTP_HOST"] + "\n");
                message.Append("REMOTE_HOST: " + Page.Request.ServerVariables["REMOTE_HOST"] + "\n");
                message.Append("REMOTE_ADDR: " + SiteUtils.GetIP4Address() + "\n");
                message.Append("LOCAL_ADDR: " + Page.Request.ServerVariables["LOCAL_ADDR"] + "\n");
                message.Append("HTTP_REFERER: " + Page.Request.ServerVariables["HTTP_REFERER"] + "\n");

                SiteSettings siteSettings = CacheHelper.GetCurrentSiteSettings();

                if ((config.NotifyEmail.Length > 0) && (Email.IsValidEmailAddressSyntax(config.NotifyEmail)))
                {
                    EmailTemplate template = EmailTemplate.Get(siteSettings.SiteId, "NewsCommentNotification");

                    string fromAddress = siteSettings.DefaultEmailFromAddress;
                    string fromAlias = template.FromName;
                    if (fromAlias.Length == 0)
                        fromAlias = siteSettings.DefaultFromEmailAlias;
                    string toEmail = config.NotifyEmail;
                    if (template.ToAddresses.Length > 0)
                        toEmail += ";" + template.ToAddresses;

                    NewsHelper.SendCommentNotification(
                            SiteUtils.GetSmtpSettings(),
                            siteSettings.SiteGuid,
                            fromAddress,
                            fromAlias,
                            toEmail,
                            template.ReplyToAddress,
                            template.CcAddresses,
                            template.BccAddresses,
                            template.Subject,
                            template.HtmlBody,
                            siteSettings.SiteName,
                            message.ToString());
                }

                if (config.NotifyEmail != news.UserEmail)
                {
                    EmailTemplate template = EmailTemplate.Get(siteSettings.SiteId, "NewsCommentNotification");

                    string fromAddress = siteSettings.DefaultEmailFromAddress;
                    string fromAlias = template.FromName;
                    if (fromAlias.Length == 0)
                        fromAlias = siteSettings.DefaultFromEmailAlias;
                    string toEmail = news.UserEmail;
                    if (template.ToAddresses.Length > 0)
                        toEmail += ";" + template.ToAddresses;

                    NewsHelper.SendCommentNotification(
                            SiteUtils.GetSmtpSettings(),
                            siteSettings.SiteGuid,
                            fromAddress,
                            fromAlias,
                            toEmail,
                            template.ReplyToAddress,
                            template.CcAddresses,
                            template.BccAddresses,
                            template.Subject,
                            template.HtmlBody,
                            siteSettings.SiteName,
                            message.ToString());
                }
            }

            WebUtils.SetupRedirect(this, Request.RawUrl);
        }

        #region IRefreshAfterPostback

        public void RefreshAfterPostback()
        {
            PopulateControls();
        }

        #endregion

        private void PopulateLabels()
        {
            if (NewsConfiguration.UseLegacyCommentSystem)
            {
                edComment.WebEditor.ToolBar = ToolBar.AnonymousUser;
                edComment.WebEditor.Height = Unit.Pixel(170);

                captcha.ProviderName = basePage.SiteInfo.CaptchaProvider;
                captcha.Captcha.ControlID = "captcha" + news.NewsID.ToInvariantString();
                //captcha.RecaptchaPrivateKey = basePage.SiteInfo.RecaptchaPrivateKey;
                //captcha.RecaptchaPublicKey = basePage.SiteInfo.RecaptchaPublicKey;

                regexUrl.ErrorMessage = NewsResources.WebSiteUrlRegexWarning;
                commentListHeading.Text = NewsResources.NewsFeedbackLabel;

                btnPostComment.Text = NewsResources.NewsCommentPostCommentButton;
                SiteUtils.SetButtonAccessKey(btnPostComment, NewsResources.NewsCommentPostCommentButtonAccessKey);

                litCommentsClosed.Text = NewsResources.NewsCommentsClosedMessage;
                litCommentsRequireAuthentication.Text = NewsResources.CommentsRequireAuthenticationMessage;
            }
        }

        private void LoadSettings()
        {
            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();
            pageId = WebUtils.ParseInt32FromQueryString("pageid", -1);

            currentUser = SiteUtils.GetCurrentSiteUser();
            pageNumber = WebUtils.ParseInt32FromQueryString("pagecomment", pageNumber);
            RegexRelativeImageUrlPatern = SecurityHelper.RegexRelativeImageUrlPatern;

            if (
                (!this.Visible)
                || (news == null)
                || (news.NewsID == -1)
                || (pageId == -1)
                || (basePage.SiteInfo == null)
                )
            {
                // query string params have been manipulated
                allowComments = false;
                return;
            }
        }

        private void SetupCommentSystem()
        {
            if (!ShouldAllowComments())
            {
                pnlNewComment.Visible = false;
                pnlCommentsClosed.Visible = true;
                //divCommentService.Visible = false;

                pnlAntiSpam.Visible = false;
                captcha.Visible = false;
                captcha.Enabled = false;
                //comments.Visible = false;

                return;
            }

            string commentSystem = DetermineCommentSystem();

            switch (commentSystem)
            {
                case "disqus":
                    DisableLegacyNewsComments();

                    break;

                case "intensedebate":
                    DisableLegacyNewsComments();

                    break;

                case "facebook":

                    DisableLegacyNewsComments();

                    break;

                case "internal":
                default:
                    if (NewsConfiguration.UseLegacyCommentSystem)
                    {
                        SetupLegacyNewsComments();
                    }
                    else
                    {
                        DisableLegacyNewsComments();
                    }

                    break;
            }
        }

        private bool ShouldAllowComments()
        {
            //comments closed globally
            if (!config.AllowComments) { return false; }

            // comments not allowed on this post
            if (news.AllowCommentsForDays < 0) { return false; }

            return true;
        }

        private bool CommentsAreOpen()
        {
            //comments closed globally
            if (!config.AllowComments) { return false; }

            // comments not allowed on this post
            if (news.AllowCommentsForDays < 0) { return false; }

            //no limit on comments for this post
            if (news.AllowCommentsForDays == 0) { return true; }

            if (news.AllowCommentsForDays > 0) //limited to a specific number of days
            {
                DateTime endDate = news.StartDate.AddDays((double)news.AllowCommentsForDays);

                if (endDate > DateTime.UtcNow) { return true; }

            }

            return false;
        }

        private string DetermineCommentSystem()
        {
            // don't use new external comment system for existing posts that already have comments
            if (news.CommentCount > 0) { return "internal"; }

            return config.CommentSystem;
        }

        private void DisableLegacyNewsComments()
        {
            pnlAntiSpam.Visible = false;
            captcha.Visible = false;
            captcha.Enabled = false;
            pnlFeedback.Visible = false;
        }

        private void SetupLegacyNewsComments()
        {
            pnlFeedback.Visible = true;
            fldEnterComments.Visible = CommentsAreOpen();
            pnlCommentsClosed.Visible = !fldEnterComments.Visible;

            if ((!config.UseCaptcha) || (!fldEnterComments.Visible) || (Request.IsAuthenticated))
            {
                pnlAntiSpam.Visible = false;
                captcha.Visible = false;
                captcha.Enabled = false;
            }

            divCommentUrl.Visible = config.AllowWebSiteUrlForComments;

            if ((config.RequireAuthenticationForComments) && (!Request.IsAuthenticated))
            {
                pnlNewComment.Visible = false;
                pnlCommentsRequireAuthentication.Visible = true;
            }

            if (!IsPostBack)
            {
                txtCommentTitle.Text = "re: " + news.Title;

                if (Request.IsAuthenticated)
                {
                    SiteUser currentUser = SiteUtils.GetCurrentSiteUser();
                    this.txtName.Text = currentUser.Name;
                    txtURL.Text = currentUser.WebSiteUrl;
                }
                else
                {
                    if (CookieHelper.CookieExists("newsUser"))
                    {
                        this.txtName.Text = CookieHelper.GetCookieValue("newsUser");
                    }
                    if (CookieHelper.CookieExists("newsUrl"))
                    {
                        this.txtURL.Text = CookieHelper.GetCookieValue("newsUrl");
                    }
                }
            }

            using (IDataReader dataReader = News.GetNewsComments(news.NewsID))
            {
                dlComments.DataSource = dataReader;
                dlComments.DataBind();
            }
        }

        protected string FormatCommentDate(DateTime startDate)
        {
            if (timeZone != null)
            {
                return TimeZoneInfo.ConvertTimeFromUtc(startDate, timeZone).ToString();
            }

            return startDate.AddHours(timeOffset).ToString();
        }

        private bool IsValidComment()
        {
            if (!allowComments) { return false; }

            //if ((config.CommentSystem != "internal") && (news.CommentCount == 0)) { return false; }

            if (edComment.Text.Length == 0) { return false; }
            if (edComment.Text == "<p>&#160;</p>") { return false; }

            bool result = true;

            try
            {

                Page.Validate("newscomments");
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
                //if ((result) && (config.UseCaptcha))
                if ((config.UseCaptcha) && (pnlAntiSpam.Visible))
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

        /// <summary>
        /// Handles the item command
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        protected void dlComments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteComment")
            {
                News.DeleteNewsComment(int.Parse(e.CommandArgument.ToString()));
                WebUtils.SetupRedirect(this, Request.RawUrl);
            }
        }

        void dlComments_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            LinkButton btnDelete = e.Item.FindControl("btnDelete") as LinkButton;
            UIHelper.AddConfirmationDialog(btnDelete, NewsResources.NewsDeleteCommentWarning);
        }

        private void SetCookies()
        {
            HttpCookie newsUserCookie = new HttpCookie("newsUser", this.txtName.Text);
            newsUserCookie.Expires = DateTime.Now.AddMonths(1);
            Response.Cookies.Add(newsUserCookie);

            HttpCookie newsUrlCookie = new HttpCookie("LinkUrl", this.txtURL.Text);
            newsUrlCookie.Expires = DateTime.Now.AddMonths(1);
            Response.Cookies.Add(newsUrlCookie);
        }

        //protected override void Render(HtmlTextWriter writer)
        //{
        //    if ((Page.IsPostBack) &&(!pnlFeedback.Visible))
        //    { 
        //        WebUtils.SetupRedirect(this, Request.RawUrl); 
        //        return; 
        //    }

        //    base.Render(writer);
        //}

    }
}