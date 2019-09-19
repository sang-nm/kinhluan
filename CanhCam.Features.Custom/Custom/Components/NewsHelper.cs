/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			    2013-03-03
/// Last Modified:		    2014-08-19

using System;
using System.Drawing;
using System.IO;
using log4net;
using CanhCam.Business;
using CanhCam.FileSystem;
using CanhCam.Web.Framework;
using System.Web.Hosting;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Web;
using CanhCam.Net;
using System.Text;
using System.Xml;

namespace CanhCam.Web.CustomUI
{
    public static class NewsHelper
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(NewsHelper));

        public static void ProcessImage(ContentMedia contentImage, IFileSystem fileSystem, string virtualRoot, string originalFileName, Color backgroundColor)
        {
            string originalPath = virtualRoot + contentImage.MediaFile;
            string thumbnailPath = virtualRoot + "thumbs/" + contentImage.ThumbnailFile;

            fileSystem.CopyFile(originalPath, thumbnailPath, true);

            CanhCam.Web.ImageHelper.ResizeImage(
                thumbnailPath,
                IOHelper.GetMimeType(Path.GetExtension(thumbnailPath)),
                contentImage.ThumbNailWidth,
                contentImage.ThumbNailHeight,
                backgroundColor);
        }

        public static void DeleteImages(ContentMedia contentImage, IFileSystem fileSystem, string virtualRoot)
        {
            string imageVirtualPath = virtualRoot + contentImage.MediaFile;
            fileSystem.DeleteFile(imageVirtualPath);

            imageVirtualPath = virtualRoot + "thumbs/" + contentImage.ThumbnailFile;
            fileSystem.DeleteFile(imageVirtualPath);
        }

        public static string MediaFolderPath(int siteId)
        {
            return "~/Data/Sites/" + siteId.ToInvariantString() + "/News/";
        }

        public static string MediaFolderPath(int siteId, int newsId)
        {
            return MediaFolderPath(siteId) + newsId.ToInvariantString() + "/";
        }

        public static string AttachmentsPath(int siteId, int newsId)
        {
            return MediaFolderPath(siteId, newsId) + "Attachments/";
        }

        public static string FormatNewsUrl(string url, int newsId, int zoneId)
        {
            if (url.Length > 0)
            {
                if (url.StartsWith("http"))
                {
                    string siteRoot = WebUtils.GetSiteRoot();
                    return url.Replace("http://~", siteRoot).Replace("https://~", siteRoot.Replace("http:", "https")); ;
                }

                return SiteUtils.GetNavigationSiteRoot(zoneId) + url.Replace("~", string.Empty);
            }

            return SiteUtils.GetNavigationSiteRoot(zoneId) + "/News/NewsDetail.aspx?zoneid=" + zoneId.ToInvariantString()
                + "&NewsID=" + newsId.ToInvariantString();
        }

        public static string BuildEditLink(News news, CmsBasePage basePage, bool userCanUpdate, SiteUser currentUser)
        {
            if (PageView.UserViewMode == PageViewMode.View)
                return string.Empty;

            if (!basePage.UserCanAuthorizeZone(news.ZoneID))
                return string.Empty;

           

            if (WebConfigSettings.EnableContentWorkflow && basePage.SiteInfo.EnableContentWorkflow && !news.IsPublished)
            {
                if (news.StateId.HasValue)
                {
                    int workflowId = WorkflowHelper.GetWorkflowId(News.FeatureGuid);
                    int firstWorkflowStateId = WorkflowHelper.GetFirstWorkflowStateId(workflowId);

                    if (news.StateId.Value == firstWorkflowStateId)
                    {
                        if (currentUser == null) { return string.Empty; }
                      
                    }
                }
            }

            return string.Empty;
        }
        

        //public static void DeleteEmptyFolder(string virtualPath)
        //{
        //    string fileSystemPath = HostingEnvironment.MapPath(virtualPath);

        //    try
        //    {
        //        string[] files = Directory.GetFiles(fileSystemPath);
        //        if(files.Length == 0)
        //            Directory.Delete(fileSystemPath, false);
        //    }
        //    catch (Exception ex)
        //    {
        //        try
        //        {
        //            System.Threading.Thread.Sleep(0);
        //            Directory.Delete(fileSystemPath, false);
        //        }
        //        catch (Exception)
        //        {

        //        }
        //    }
        //}

        public static void DeleteFolder(int siteId, int newsId)
        {
            string virtualPath = MediaFolderPath(siteId, newsId);
            string fileSystemPath = HostingEnvironment.MapPath(virtualPath);

            try
            {
                DeleteDirectory(fileSystemPath);
            }
            catch (Exception)
            {
                try
                {
                    System.Threading.Thread.Sleep(0);
                    Directory.Delete(fileSystemPath, false);
                }
                catch (Exception)
                {

                }

                //log.Error(ex);
            }
        }

        public static void DeleteDirectory(string fileSystemPath)
        {
            if (Directory.Exists(fileSystemPath))
            {
                string[] files = Directory.GetFiles(fileSystemPath);
                string[] dirs = Directory.GetDirectories(fileSystemPath);

                foreach (string file in files)
                {
                    File.SetAttributes(file, FileAttributes.Normal);
                    File.Delete(file);
                }

                while (Directory.GetFiles(fileSystemPath).Length > 0)
                {
                    System.Threading.Thread.Sleep(10);
                }

                foreach (string dir in dirs)
                {
                    DeleteDirectory(dir);
                }

                Directory.Delete(fileSystemPath, true);
            }
        }

        public static bool VerifyNewsFolders(IFileSystem fileSystem, string virtualRoot)
        {
            bool result = false;

            string originalPath = virtualRoot;
            string thumbnailPath = virtualRoot + "thumbs/";

            try
            {
                if (!fileSystem.FolderExists(originalPath))
                {
                    fileSystem.CreateFolder(originalPath);
                }

                if (!fileSystem.FolderExists(thumbnailPath))
                {
                    fileSystem.CreateFolder(thumbnailPath);
                }

                result = true;
            }
            catch (UnauthorizedAccessException ex)
            {
                log.Error("Error creating directories in NewsHelper.VerifyNewsFolders", ex);
            }

            return result;
        }

        public static string GetChildZoneIdToSemiColonSeparatedString(int siteId, int parentZoneId)
        {
            SiteMapDataSource siteMapDataSource = new SiteMapDataSource();
            siteMapDataSource.SiteMapProvider = "canhcamsite" + siteId.ToInvariantString();

            SiteMapNode rootNode = siteMapDataSource.Provider.RootNode;
            SiteMapNode startingNode = null;

            if (rootNode == null) { return null; }

            string listChildZoneIds = parentZoneId + ";";

            if (parentZoneId > -1)
            {
                SiteMapNodeCollection allNodes = rootNode.GetAllNodes();
                foreach (SiteMapNode childNode in allNodes)
                {
                    gbSiteMapNode gbNode = childNode as gbSiteMapNode;
                    if (gbNode == null) { continue; }

                    if (Convert.ToInt32(gbNode.Key) == parentZoneId)
                    {
                        startingNode = gbNode;
                        break;
                    }
                }
            }
            else
            {
                startingNode = rootNode;
            }

            if (startingNode == null)
                return string.Empty;

            SiteMapNodeCollection childNodes = startingNode.GetAllNodes();
            foreach (gbSiteMapNode childNode in childNodes)
            {
                listChildZoneIds += childNode.Key + ";";
            }

            return listChildZoneIds;
        }

        public static string GetNewsTarget(object openInNewWindow)
        {
            if (openInNewWindow != null)
            {
                bool isBlank = (bool)openInNewWindow;

                if (isBlank)
                    return "_blank";
            }

            return "_self";
        }

        public static string GetNameByNewsType(int newsType, string newsTypeNameFormat, string defaultName)
        {
            if (newsType > 0)
            {
                List<EnumDefined> lstEnum = EnumDefined.LoadFromConfigurationXml("news", "newstype", "value");
                foreach (EnumDefined item in lstEnum)
                {
                    if (item.Value == newsType.ToString())
                    {
                        return string.Format(newsTypeNameFormat, item.Name);
                    }
                }
            }

            return defaultName;
        }

        public static Color GetColor(string resizeBackgroundColor)
        {
            try
            {
                return ColorTranslator.FromHtml(resizeBackgroundColor);
            }
            catch (Exception)
            {

            }

            return Color.White;
        }

        //public static Module GetModule(PageSettings currentPage, Guid featureGuid)
        //{
        //    if (currentPage == null) { return null; }

        //    foreach (Module m in currentPage.Modules)
        //    {
        //        if (m.FeatureGuid == featureGuid && m.PaneName.ToLower() == "contentpane")
        //        {
        //            return m;
        //        }
        //    }

        //    foreach (Module m in currentPage.Modules)
        //    {
        //        if (m.FeatureGuid == featureGuid)
        //        {
        //            return m;
        //        }
        //    }

        //    return null;
        //}

        public static void SendCommentNotification(
            SmtpSettings smtpSettings,
            Guid siteGuid,
            string fromAddress,
            string fromAlias,
            string toEmail,
            string replyEmail,
            string ccEmail,
            string bccEmail,
            string subject,
            string messageTemplate,
            string siteName,
            string messageToken)
        {

            if (string.IsNullOrEmpty(messageTemplate))
                return;

            StringBuilder message = new StringBuilder();
            message.Append(messageTemplate);
            message.Replace("{SiteName}", siteName);
            message.Replace("{Message}", messageToken);
            subject = subject.Replace("{SiteName}", siteName);

            //try
            //{
            //    Email.SendEmail(
            //        smtpSettings,
            //        fromAddress,
            //        toEmail,
            //        replyEmail,
            //        ccEmail,
            //        bccEmail,
            //        subject,
            //        message.ToString(),
            //        true,
            //        "Normal");
            //}
            //catch (Exception ex)
            //{
            //    log.Error("Error sending email from address was " + fromAddress + " to address was " + toEmail, ex);
            //}

            EmailMessageTask messageTask = new EmailMessageTask(smtpSettings);
            messageTask.SiteGuid = siteGuid;
            messageTask.EmailFrom = fromAddress;
            messageTask.EmailFromAlias = fromAlias;
            messageTask.EmailReplyTo = replyEmail;
            messageTask.EmailTo = toEmail;
            messageTask.EmailCc = ccEmail;
            messageTask.EmailBcc = bccEmail;
            messageTask.UseHtml = true;
            messageTask.Subject = subject;
            messageTask.HtmlBody = message.ToString();
            messageTask.QueueTask();

            WebTaskManager.StartOrResumeTasks();
        }

        public static void SendApprovalRequestNotification(
            SmtpSettings smtpSettings,
            SiteSettings siteSettings,
            int workflowId,
            SiteUser submittingUser,
            News draftNews
            )
        {
            if (!draftNews.StateId.HasValue)
                return;

            WorkflowState workflowState = WorkflowHelper.GetWorkflowState(workflowId, draftNews.StateId.Value);

            if (workflowState == null || workflowState.StateId == -1)
                return;

            if (workflowState.ReviewRoles.Length == 0
                || workflowState.NotifyTemplate.Length == 0) //"ApprovalRequestNotification"
                return;

            string approvalRoles = workflowState.ReviewRoles;

            gbSiteMapNode gbNode = SiteUtils.GetSiteMapNodeByZoneId(draftNews.ZoneID);

            if (gbNode != null)
            {
                List<string> authorizedRoles = gbNode.AuthorizedRoles.SplitOnCharAndTrim(';');
                List<string> reviewRoles = workflowState.ReviewRoles.SplitOnCharAndTrim(';');

                if (authorizedRoles.Count > 0 && reviewRoles.Count > 0)
                {
                    approvalRoles = string.Empty;

                    foreach (string reviewRole in reviewRoles)
                    {
                        foreach (string role in authorizedRoles)
                        {
                            if (reviewRole.ToLower() == role.ToLower())
                            {
                                approvalRoles += reviewRole + ";";
                            }
                        }
                    }
                }
            }

            List<string> emailAddresses = SiteUser.GetEmailAddresses(siteSettings.SiteId, approvalRoles);

            int queuedMessageCount = 0;

            EmailTemplate template = EmailTemplate.Get(siteSettings.SiteId, workflowState.NotifyTemplate);
            string subject = template.Subject.Replace("{SiteName}", siteSettings.SiteName);
            string messageTemplate = template.HtmlBody;

            List<string> emailTo = (template.ToAddresses.Length > 0 ? ";" + template.ToAddresses : "").SplitOnCharAndTrim(';');

            string emailToAddress = string.Empty;
            foreach (string email in emailAddresses)
            {
                if (WebConfigSettings.EmailAddressesToExcludeFromAdminNotifications.IndexOf(email, StringComparison.InvariantCultureIgnoreCase) > -1) { continue; }
                if (!Email.IsValidEmailAddressSyntax(email)) { continue; }

                if (!emailToAddress.Contains(email + ";"))
                    emailToAddress += email + ";";
            }
            foreach (string email in emailTo)
            {
                if (WebConfigSettings.EmailAddressesToExcludeFromAdminNotifications.IndexOf(email, StringComparison.InvariantCultureIgnoreCase) > -1) { continue; }
                if (!Email.IsValidEmailAddressSyntax(email)) { continue; }

                if (!emailToAddress.Contains(email + ";"))
                    emailToAddress += email + ";";
            }

            string replyEmail = submittingUser.Email;
            if (template.ReplyToAddress.Length > 0)
                replyEmail += ";" + template.ReplyToAddress;

            string fromEmailAlias = (template.FromName.Length > 0 ? template.FromName : siteSettings.DefaultFromEmailAlias);

            StringBuilder message = new StringBuilder();
            message.Append(messageTemplate);
            message.Replace("{Title}", draftNews.Title);
            message.Replace("{SubmittedDate}", DateTimeHelper.GetLocalTimeString(draftNews.ApprovedUtc, SiteUtils.GetUserTimeZone(), SiteUtils.GetUserTimeOffset()));
            message.Replace("{SubmittedBy}", submittingUser.Name);
            message.Replace("{ContentUrl}", NewsHelper.FormatNewsUrl(draftNews.Url, draftNews.NewsID, draftNews.ZoneID));

            EmailMessageTask messageTask = new EmailMessageTask(smtpSettings);
            messageTask.SiteGuid = siteSettings.SiteGuid;
            messageTask.EmailFrom = siteSettings.DefaultEmailFromAddress;
            messageTask.EmailFromAlias = fromEmailAlias;
            messageTask.EmailReplyTo = replyEmail;
            messageTask.EmailTo = emailToAddress;
            messageTask.EmailCc = template.CcAddresses;
            messageTask.EmailBcc = template.BccAddresses;
            messageTask.UseHtml = true;
            messageTask.Subject = subject;
            messageTask.HtmlBody = message.ToString();
            messageTask.QueueTask();
            queuedMessageCount += 1;

            //Email.Send(
            //        smtpSettings,
            //        siteSettings.DefaultEmailFromAddress,
            //        siteSettings.DefaultFromEmailAlias,
            //        submittingUser.Email,
            //        email,
            //        string.Empty,
            //        string.Empty,
            //        messageSubject,
            //        message.ToString(),
            //        false,
            //        Email.PriorityNormal);

            WebTaskManager.StartOrResumeTasks();
        }

        public static bool IsAjaxRequest(HttpRequest request) //public static bool IsAjaxRequest(this HttpRequest request)
        {
            if (request == null)
            {
                throw new ArgumentNullException("request");
            }
            var context = HttpContext.Current;
            var isCallbackRequest = false;// callback requests are ajax requests
            if (context != null && context.CurrentHandler != null && context.CurrentHandler is System.Web.UI.Page)
            {
                isCallbackRequest = ((System.Web.UI.Page)context.CurrentHandler).IsCallback;
            }
            return isCallbackRequest || (request["X-Requested-With"] == "XMLHttpRequest") || (request.Headers["X-Requested-With"] == "XMLHttpRequest");
        }

        #region XmlData

        public static XmlDocument BuildNewsDataXml(XmlDocument doc, XmlElement newsXml, News news, TimeZoneInfo timeZone, double timeOffset, string editLink)
        {
            XmlHelper.AddNode(doc, newsXml, "Title", news.Title);
            XmlHelper.AddNode(doc, newsXml, "SubTitle", news.SubTitle);
            XmlHelper.AddNode(doc, newsXml, "Url", NewsHelper.FormatNewsUrl(news.Url, news.NewsID, news.ZoneID));
            XmlHelper.AddNode(doc, newsXml, "Target", NewsHelper.GetNewsTarget(news.OpenInNewWindow));
            XmlHelper.AddNode(doc, newsXml, "ShowOption", news.ShowOption.ToString());
            XmlHelper.AddNode(doc, newsXml, "NewsId", news.NewsID.ToString()); //2016-08-11

            string imageFolderPath = NewsHelper.MediaFolderPath(news.SiteId, news.NewsID);
            string thumbnailImageFolderPath = imageFolderPath + "thumbs/";
            if (news.ImageFile.Length > 0)
                XmlHelper.AddNode(doc, newsXml, "ImageUrl", VirtualPathUtility.ToAbsolute(imageFolderPath + news.ImageFile));
            if (news.ThumbnailFile.Length > 0)
                XmlHelper.AddNode(doc, newsXml, "ThumbnailUrl", VirtualPathUtility.ToAbsolute(thumbnailImageFolderPath + news.ThumbnailFile));

            XmlHelper.AddNode(doc, newsXml, "EditLink", editLink);

            XmlHelper.AddNode(doc, newsXml, "BriefContent", news.BriefContent);
            XmlHelper.AddNode(doc, newsXml, "FullContent", news.FullContent);
            XmlHelper.AddNode(doc, newsXml, "ViewCount", news.Viewed.ToString());
            XmlHelper.AddNode(doc, newsXml, "CommentCount", news.CommentCount.ToString());
            XmlHelper.AddNode(doc, newsXml, "FileUrl", news.FileAttachment);

            object startDate = news.StartDate;
            XmlHelper.AddNode(doc, newsXml, "CreatedDate", FormatDate(startDate, timeZone, timeOffset, ResourceHelper.GetResourceString("NewsResources", "NewsDateFormat")));
            XmlHelper.AddNode(doc, newsXml, "CreatedTime", FormatDate(startDate, timeZone, timeOffset, ResourceHelper.GetResourceString("NewsResources", "NewsTimeFormat")));
            XmlHelper.AddNode(doc, newsXml, "CreatedDD", FormatDate(startDate, timeZone, timeOffset, "dd"));
            XmlHelper.AddNode(doc, newsXml, "CreatedYY", FormatDate(startDate, timeZone, timeOffset, "yy"));
            XmlHelper.AddNode(doc, newsXml, "CreatedYYYY", FormatDate(startDate, timeZone, timeOffset, "yyyy"));
            XmlHelper.AddNode(doc, newsXml, "CreatedMM", FormatDate(startDate, timeZone, timeOffset, "MM"));
            if (System.Globalization.CultureInfo.CurrentCulture.Name.ToLower() == "vi-vn")
            {
                string monthVI = "Tháng " + FormatDate(startDate, timeZone, timeOffset, "MM");
                XmlHelper.AddNode(doc, newsXml, "CreatedMMM", monthVI);
                XmlHelper.AddNode(doc, newsXml, "CreatedMMMM", monthVI);
            }
            else
            {
                XmlHelper.AddNode(doc, newsXml, "CreatedMMM", FormatDate(startDate, timeZone, timeOffset, "MMM"));
                XmlHelper.AddNode(doc, newsXml, "CreatedMMMM", FormatDate(startDate, timeZone, timeOffset, "MMMM"));
            }

            if (news.EndDate != DateTime.MaxValue)
                XmlHelper.AddNode(doc, newsXml, "EndDate", FormatDate(news.EndDate, timeZone, timeOffset, ResourceHelper.GetResourceString("NewsResources", "NewsDateFormat")));

            return doc;
        }

        public static string FormatDate(object startDate, TimeZoneInfo timeZone, double timeOffset, string format = "")
        {
            if (startDate == null)
                return string.Empty;

            if (timeZone != null)
            {
                return TimeZoneInfo.ConvertTimeFromUtc(Convert.ToDateTime(startDate), timeZone).ToString(format);
            }

            return Convert.ToDateTime(startDate).AddHours(timeOffset).ToString(format);
        }

        #endregion

    }
}
