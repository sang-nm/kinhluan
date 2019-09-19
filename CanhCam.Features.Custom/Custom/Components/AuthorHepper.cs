using CanhCam.Business;
using CanhCam.FileSystem;
using CanhCam.Net;
using CanhCam.Web.Framework;
using log4net;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Hosting;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public static class AuthorHepper
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(AuthorHepper));

        public static void ProcessImage(ContentMedia contentImage, IFileSystem fileSystem, string virtualRoot,
                                        string originalFileName)
        {
            string originalPath = virtualRoot + contentImage.MediaFile;
            string thumbnailPath = virtualRoot + "thumbs/" + contentImage.ThumbnailFile;

            fileSystem.CopyFile(originalPath, thumbnailPath, true);

            CanhCam.Web.ImageHelper.ResizeImage(
                thumbnailPath,
                IOHelper.GetMimeType(Path.GetExtension(thumbnailPath)),
                contentImage.ThumbNailWidth,
                contentImage.ThumbNailHeight,
                Color.Yellow);
        }
        public static void DeleteImages(ContentMedia contentImage, IFileSystem fileSystem, string virtualRoot)
        {
            string imageVirtualPath = virtualRoot + contentImage.MediaFile;

            if (!contentImage.MediaFile.ContainsCaseInsensitive("/"))
                fileSystem.DeleteFile(imageVirtualPath);

            if (!contentImage.ThumbnailFile.ContainsCaseInsensitive("/"))
            {
                imageVirtualPath = virtualRoot + "thumbs/" + contentImage.ThumbnailFile;
                fileSystem.DeleteFile(imageVirtualPath);
            }
        }

        public static string MediaFolderPath(int siteId)
        {
            return "~/Data/Sites/" + siteId.ToInvariantString() + "/Author/";
        }

        public static string MediaFolderPath(int siteId, int authorId)
        {
            return MediaFolderPath(siteId) + authorId.ToInvariantString() + "/";
        }

        public static string GetAvatarAuthor(int siteId, int authorId)
        {
            KLAuthor author =KLAuthor.GetKLAuthorByUserID(authorId);
            if (author.Avatar == "")
                return "/Data/Sites/" + siteId.ToInvariantString() + "/Author/Authordefault.png";
            return "/Data/Sites/" + siteId.ToInvariantString() + "/Author/" + authorId.ToInvariantString() + "/" + author.Avatar;
        }
        public static string PublicFolderPath(int siteId, int authorId)
        {
            return MediaFolderPath(siteId) + authorId.ToInvariantString() + "/Public/";
        }
        public static string GetMediaFilePath(string mediaFolderPath, string mediaFile)
        {
            if (mediaFile.Length == 0)
                return string.Empty;

            if (mediaFile.Contains("/"))
                return mediaFile;

            return VirtualPathUtility.ToAbsolute(mediaFolderPath) + mediaFile;
        }

        public static string GetImageFilePath(int siteId, int AuthorId, string imageFile, string thumbnail)
        {
            if (imageFile.Length == 0 && thumbnail.Length == 0)
                return string.Empty;

            if (thumbnail.Contains("/"))
                return thumbnail;

            string mediaFolderPath = System.Web.VirtualPathUtility.ToAbsolute(AuthorHepper.MediaFolderPath(siteId, AuthorId));
            if (!string.IsNullOrEmpty(thumbnail))
                return mediaFolderPath + "thumbs/" + thumbnail;

            if (imageFile.Contains("/"))
                return imageFile;

            return mediaFolderPath + imageFile;
        }

        public static string AttachmentsPath(int siteId, int newsId)
        {
            return MediaFolderPath(siteId, newsId) + "Attachments/";
        }
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
                    System.Threading.Thread.Sleep(10);

                foreach (string dir in dirs)
                    DeleteDirectory(dir);

                Directory.Delete(fileSystemPath, true);
            }
        }

        public static bool VerifyAuthorFolders(IFileSystem fileSystem, string virtualRoot)
        {
            bool result = false;

            string originalPath = virtualRoot;
            string thumbnailPath = virtualRoot + "thumbs/";
            string publicPath = virtualRoot + "Public/";
            try
            {
                if (!fileSystem.FolderExists(originalPath))
                    fileSystem.CreateFolder(originalPath);

                if (!fileSystem.FolderExists(thumbnailPath))
                    fileSystem.CreateFolder(thumbnailPath);

                if (!fileSystem.FolderExists(publicPath))
                    fileSystem.CreateFolder(publicPath);

                result = true;
            }
            catch (UnauthorizedAccessException ex)
            {
                log.Error("Error creating directories in AuthorHepper.VerifyAuthorFolders", ex);
            }

            return result;
        }

        public static string GetRangeZoneIdsToSemiColonSeparatedString(int siteId, int parentZoneId)
        {
            SiteMapDataSource siteMapDataSource = new SiteMapDataSource();
            siteMapDataSource.SiteMapProvider = "canhcamsite" + siteId.ToInvariantString();

            SiteMapNode rootNode = siteMapDataSource.Provider.RootNode;
            SiteMapNode startingNode = null;

            if (rootNode == null) return null;

            string listChildZoneIds = parentZoneId + ";";

            if (parentZoneId > -1)
            {
                SiteMapNodeCollection allNodes = rootNode.GetAllNodes();
                foreach (SiteMapNode childNode in allNodes)
                {
                    gbSiteMapNode gbNode = childNode as gbSiteMapNode;
                    if (gbNode == null) continue;

                    if (Convert.ToInt32(gbNode.Key) == parentZoneId)
                    {
                        startingNode = gbNode;
                        break;
                    }
                }
            }
            else
                startingNode = rootNode;

            if (startingNode == null)
                return string.Empty;

            SiteMapNodeCollection childNodes = startingNode.GetAllNodes();
            foreach (gbSiteMapNode childNode in childNodes)
                listChildZoneIds += childNode.Key + ";";

            return listChildZoneIds;
        }

        public static string GetAuthorTarget(object openInNewWindow)
        {
            if (openInNewWindow != null)
            {
                bool isBlank = (bool)openInNewWindow;

                if (isBlank)
                    return "_blank";
            }

            return "_self";
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

        //public static Module FindAuthorModule(PageSettings currentPage)
        //{
        //    foreach (Module m in currentPage.Modules)
        //    {
        //        if (m.FeatureGuid == Author.FeatureGuid) return m;

        //        if (m.ControlSource == "Author/AuthorModule.ascx") return m;

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

        public const string QueryStringViewModeParam = "view";
        public const string QueryStringPageNumberParam = "pagenumber";
        public static string BuildFilterUrlLeaveOutPageNumber(string rawUrl, bool fullUrl = false)
        {
            string pageUrl = SiteUtils.BuildUrlLeaveOutParam(rawUrl, AuthorHepper.QueryStringPageNumberParam, false);
            return SiteUtils.BuildUrlLeaveOutParam(pageUrl, "isajax", fullUrl);
        }

        public static string BuildFilterUrlLeaveOutPageNumber(string rawUrl, string paramName, string paramValue)
        {
            string pageUrl = SiteUtils.BuildUrlLeaveOutParam(rawUrl, AuthorHepper.QueryStringPageNumberParam, false);
            pageUrl = SiteUtils.BuildUrlLeaveOutParam(pageUrl, "isajax", false);
            pageUrl = SiteUtils.BuildUrlLeaveOutParam(pageUrl, paramName);

            if (paramValue.Length > 0)
            {
                if (pageUrl.Contains("?"))
                    pageUrl += string.Format("&{0}={1}", paramName, paramValue);
                else
                    pageUrl += string.Format("?{0}={1}", paramName, paramValue);
            }

            return pageUrl;
        }

    }
}