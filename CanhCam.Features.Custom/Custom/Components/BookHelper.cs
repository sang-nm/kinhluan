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
using System.Xml;

namespace CanhCam.Web.CustomUI
{
    public class BookHelper
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(BookHelper));

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
            fileSystem.DeleteFile(imageVirtualPath);

            imageVirtualPath = virtualRoot + "thumbs/" + contentImage.ThumbnailFile;
            fileSystem.DeleteFile(imageVirtualPath);
        }

        public static string MediaFolderPath(int siteId)
        {
            return "~/Data/Sites/" + siteId.ToInvariantString() + "/Book/";
        }

        public static string MediaFolderPath(int siteId, int Bookid)
        {
            return MediaFolderPath(siteId) + Bookid.ToInvariantString() + "/";
        }

        public static string AttachmentsPath(int siteId, int Bookid)
        {
            return MediaFolderPath(siteId, Bookid) + "Attachments/";
        }

        public static string FormatBookUrl(string url, int Bookid, int zoneId)
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

            return SiteUtils.GetNavigationSiteRoot(zoneId) + "/Book/BookDetail.aspx?zoneid=" + zoneId.ToInvariantString()
                + "&Bookid=" + Bookid.ToInvariantString();
        }
        

        public static void DeleteFolder(int siteId, int Bookid)
        {
            string virtualPath = MediaFolderPath(siteId, Bookid);
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

        public static bool VerifyBookFolders(IFileSystem fileSystem, string virtualRoot)
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
                log.Error("Error creating directories in BookHelper.VerifyBookFolders", ex);
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

        public static string GetBookTarget(object openInNewWindow)
        {
            if (openInNewWindow != null)
            {
                bool isBlank = (bool)openInNewWindow;

                if (isBlank)
                    return "_blank";
            }

            return "_self";
        }

        public static string GetNameByBookType(int BookType, string BookTypeNameFormat, string defaultName)
        {
            if (BookType > 0)
            {
                List<EnumDefined> lstEnum = EnumDefined.LoadFromConfigurationXml("Books", "BooksType", "value");
                foreach (EnumDefined item in lstEnum)
                {
                    if (item.Value == BookType.ToString())
                    {
                        return string.Format(BookTypeNameFormat, item.Name);
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
      

    }
}
