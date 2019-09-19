using CanhCam.Business;
using CanhCam.Business.WebHelpers;
using CanhCam.Web.Framework;
using CanhCam.Web.UI;
using log4net;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public partial class NewsComments : SiteModuleControl, IRefreshAfterPostback
    {
        private int newsID = -1;
        private KLNews news = null;
        private KLAuthor author = null;
        KLNewsComment newcomment = null;
        SiteSettings siteSettings;
        int pagecomment = 1;
        int pagesizecomment = 10;
        protected Double timeOffset = 0;
        protected TimeZoneInfo timeZone = null;
        int totalpagecomment = 0;
        private static readonly ILog log = LogManager.GetLogger(typeof(NewsComments));
        private SiteUser currentUser = null;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            btnSendComment.Click += new EventHandler(BtnSendComment_Click);
        }

        private void BtnSendComment_Click(object sender, EventArgs e)
        {
            int num = SendComments();
            if (num != -1)
            {
                divmessagecomment.InnerHtml = AlertSuccess();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadSettings();
            PopulateControls();
        }

        private void LoadSettings()
        {
            currentUser = SiteUtils.GetCurrentSiteUser();
            newsID = WebUtils.ParseInt32FromQueryString("newsID", newsID);
            siteSettings = CacheHelper.GetCurrentSiteSettings();
            timeOffset = SiteUtils.GetUserTimeOffset();
            timeZone = SiteUtils.GetUserTimeZone();
            if (currentUser == null)
            {
                imgAvatar.ImageUrl = "/Data/Sites/1/Author/Authordefault.png";
                currentUser = SiteUser.GetByEmail(siteSettings, "Anonymous@kimluan.com");
            }
            else
            {
                author = KLAuthor.GetKLAuthorByUserID(currentUser.UserId);
                imgAvatar.ImageUrl = AuthorHepper.MediaFolderPath(1, author.UserID) + author.Avatar;
                txtEmail.Text = currentUser.Email;
                txtFullName.Text = currentUser.Name;
            }
            news = new KLNews(newsID, 0);
        }
        private void PopulateControls()
        {
            rptCommentTop.DataSource = KLNewsComment.GetPageByAuthor(pagecomment, pagesizecomment, out totalpagecomment, -1, 1, newsID, -1, -1);
            rptCommentTop.DataBind();
        }

        private int SendComments()
        {
            if (txtcomment.Text.Trim() != "")
            {
                newcomment = new KLNewsComment();
                try
                {


                    newcomment.Comment = txtcomment.Text;
                    newcomment.CreateDate = DateTime.Now;
                    newcomment.Email = txtEmail.Text;
                    newcomment.Name = txtFullName.Text;
                    newcomment.UserID = currentUser.UserId;
                    newcomment.NewsID = newsID;
                    newcomment.Save();
                    KLNotify notify = new KLNotify(); KLAuthor author = new KLAuthor(news.AuthorID);
                    notify.AuthorID = author.UserID;
                    notify.UserName_Action= txtFullName.Text;
                    notify.DateCreate = DateTime.Now;
                    notify.NotifyType = "Comment";
                    notify.Viewed = false;
                    News newsKL = new News(siteSettings.SiteId, news.NewsID);
                    notify.Notify =  ResourceFile.GetResourceString("CustomResources", "NotifyComment") + newsKL.Title;
                    notify.NotifyLink = SiteRoot + "/news-detail?newsID=" + news.NewsID;
                    notify.Save();
                }
                catch (Exception ex)
                {
                    log.Error(ex.Message);
                }
                return newcomment.CommentID;
            }
            return -1;
        }
        private static string TimeAgo(DateTime date, CultureInfo culture)
        {
            TimeSpan timeSince =  DateTime.Now.Subtract(date);

            if (timeSince.TotalSeconds < 1)
                return ResourceHelper.GetResourceString("CustomResources", "TimeAgoSecond", culture, false);
            if (timeSince.TotalSeconds < 60)
                return string.Format(ResourceHelper.GetResourceString("CustomResources", "TimeAgoSecondsFormat", culture, false), timeSince.Seconds);
            if (timeSince.TotalMinutes < 2)
                return ResourceHelper.GetResourceString("CustomResources", "TimeAgoMinute", culture, false);
            if (timeSince.TotalMinutes < 60)
                return string.Format(ResourceHelper.GetResourceString("CustomResources", "TimeAgoMinutesFormat", culture, false), timeSince.Minutes);
            if (timeSince.TotalMinutes < 120)
                return ResourceHelper.GetResourceString("CustomResources", "TimeAgoHour", culture, false);
            if (timeSince.TotalHours < 24)
                return string.Format(ResourceHelper.GetResourceString("CustomResources", "TimeAgoHoursFormat", culture, false), timeSince.Hours);
            if (timeSince.TotalDays < 2)
                return ResourceHelper.GetResourceString("CustomResources", "TimeAgoDay", culture, false);
            if (timeSince.TotalDays < 30)
                return string.Format(ResourceHelper.GetResourceString("CustomResources", "TimeAgoDaysFormat", culture, false), timeSince.Days);
            if (timeSince.TotalDays < 60)
                return ResourceHelper.GetResourceString("CustomResources", "TimeAgoMonth", culture, false);
            if (timeSince.TotalDays < 365)
                return string.Format(ResourceHelper.GetResourceString("CustomResources", "TimeAgoMonthsFormat", culture, false), Math.Round(timeSince.TotalDays / 30));
            if (timeSince.TotalDays < 730)
                return ResourceHelper.GetResourceString("CustomResources", "TimeAgoYear", culture, false);

            //last but not least...
            return string.Format(ResourceHelper.GetResourceString("CustomResources", "TimeAgoYearsFormat", culture, false), Math.Round(timeSince.TotalDays / 365));
        }
        protected string GetTimeAgo(DateTime date, TimeZoneInfo timeZone, double timeOffset, CultureInfo culture = null)
        {
            if (culture == null)
                culture = CultureInfo.CurrentCulture;

            if (timeZone != null)
            {
                return TimeAgo(TimeZoneInfo.ConvertTimeFromUtc(date, timeZone), culture);
            }

            return TimeAgo(date.AddHours(timeOffset), culture);
        }
        protected List<KLNewsComment> GetChildComments(int commentid)
        {
            return KLNewsComment.GetPageByAuthor(pagecomment, pagesizecomment, out totalpagecomment, -1, 1, newsID, -1, commentid);
        }
        #region IRefreshAfterPostback

        public void RefreshAfterPostback()
        {
            PopulateControls();
        }


        #endregion

        protected void rptComments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            TextBox txtsubname = (TextBox)e.Item.FindControl("txtsubname");
            TextBox txtsubemail = (TextBox)e.Item.FindControl("txtsubemail");
            TextBox txtsubcomment = (TextBox)e.Item.FindControl("txtsubcomment");
            HiddenField commentid = (HiddenField)e.Item.FindControl("hdcommentid");
            KLNewsComment subcomment = null;
            if (txtsubcomment.Text.Trim() != "")
            {
                subcomment = new KLNewsComment();
                try
                {
                    subcomment.Comment = txtsubcomment.Text;
                    subcomment.CreateDate = DateTime.Now;
                    subcomment.Email = txtsubemail.Text;
                    subcomment.Name = txtsubname.Text;
                    subcomment.UserID = currentUser.UserId;
                    subcomment.NewsID = newsID;
                    subcomment.CommentParentID = int.Parse(commentid.Value);
                    subcomment.Save();
                    KLNotify notify = new KLNotify();
                    KLAuthor author = new KLAuthor(news.AuthorID);
                    notify.AuthorID = author.UserID;
                    notify.UserName_Action = txtsubname.Text;
                    notify.DateCreate = DateTime.Now;
                    notify.NotifyType = "Comment";
                    notify.Viewed = false;
                    News newsKL = new News(siteSettings.SiteId, news.NewsID);
                    notify.Notify = ResourceFile.GetResourceString("CustomResources", "NotifyComment") + newsKL.Title;
                    notify.NotifyLink = SiteRoot + "/news-detail?newsID=" + news.NewsID;
                    notify.Save();
                    divmessagecomment.InnerHtml = AlertSuccess();
                }
                catch (Exception ex)
                {
                    log.Error(ex.Message);
                }
            }
        }
        private string AlertSuccess()
        {
            StringBuilder scripts = new StringBuilder();
            scripts.Append("<div class=\"alert alert-success alert-dismissable\">");
            scripts.Append("<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">×</a>");
            scripts.Append("<strong>Success!</strong> Your Comment Send Success. </div>");
            return scripts.ToString();
        }
        protected string getimgURL(int CommentId)
        {
            KLNewsComment com = new KLNewsComment(CommentId);
            return AuthorHepper.GetAvatarAuthor(siteSettings.SiteId, com.UserID);
        }

        protected void rptChildComments_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(currentUser.Name!= "Anonymous")
            {
                TextBox txtsubname = (TextBox)e.Item.FindControl("txtsubname");
                TextBox txtsubemail = (TextBox)e.Item.FindControl("txtsubemail");
                txtsubemail.Text = currentUser.Email;
                txtsubname.Text = currentUser.Name;
            }
        }
    }
}