/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2013-04-04

using System;
using System.Collections;
using CanhCam.Web.Framework;

namespace CanhCam.Web.NewsUI
{
    /// <summary>
    /// Encapsulates the feature instance configuration loaded from module settings into a more friendly object
    /// </summary>
    public partial class NewsConfiguration
    {
        public NewsConfiguration()
        { }

        public NewsConfiguration(Hashtable settings)
        {
            LoadSettings(settings);
        }

        private void LoadSettings(Hashtable settings)
        {
            if (settings == null || settings.Count == 0) { return; throw new ArgumentException("must pass in a hashtable of settings"); }

            pageSize = WebUtils.ParseInt32FromHashtable(settings, "ItemsPerPageSetting", pageSize);

            showLeftContent = WebUtils.ParseBoolFromHashtable(settings, "ShowPageLeftContentSetting", showLeftContent);
            showRightContent = WebUtils.ParseBoolFromHashtable(settings, "ShowPageRightContentSetting", showRightContent);
            showAllNews = WebUtils.ParseBoolFromHashtable(settings, "ShowAllNewsFromChildZoneSetting", showAllNews);

            //allowComments = WebUtils.ParseBoolFromHashtable(settings, "NewsAllowComments", allowComments);
            //notifyOnComment = WebUtils.ParseBoolFromHashtable(settings, "ContentNotifyOnComment", notifyOnComment);
            //requireApprovalForComments = WebUtils.ParseBoolFromHashtable(settings, "RequireApprovalForComments", requireApprovalForComments);
            //defaultCommentDaysAllowed = WebUtils.ParseInt32FromHashtable(settings, "NewsCommentForDaysDefault", defaultCommentDaysAllowed);
            //allowCommentTitle = WebUtils.ParseBoolFromHashtable(settings, "AllowCommentTitle", allowCommentTitle);
            //allowWebSiteUrlForComments = WebUtils.ParseBoolFromHashtable(settings, "AllowWebSiteUrlForComments", allowWebSiteUrlForComments);
            //useCaptcha = WebUtils.ParseBoolFromHashtable(settings, "NewsUseCommentSpamBlocker", useCaptcha);
            //requireAuthenticationForComments = WebUtils.ParseBoolFromHashtable(settings, "RequireAuthenticationForComments", requireAuthenticationForComments);
            //commentSystem = settings["CommentSystemSetting"].ToString();
            //enableContentVersioning = WebUtils.ParseBoolFromHashtable(settings, "NewsEnableVersioningSetting", enableContentVersioning);

            relatedItemsToShow = WebUtils.ParseInt32FromHashtable(settings, "RelatedItemsToShow", relatedItemsToShow);

            //allowedEditMinutesForUnModeratedPosts = WebUtils.ParseInt32FromHashtable(settings, "AllowedEditMinutesForUnModeratedPosts", allowedEditMinutesForUnModeratedPosts);

            if(settings["XsltFileName"] != null)
                xsltFileName = settings["XsltFileName"].ToString();
            if (settings["XsltFileNameDetailPage"] != null)
                xsltFileNameDetailPage = settings["XsltFileNameDetailPage"].ToString();

            newsType = WebUtils.ParseInt32FromHashtable(settings, "NewsTypeSetting", newsType);

            if (settings["LoadFirstItemSetting"] != null)
                loadFirstItem = WebUtils.ParseBoolFromHashtable(settings, "LoadFirstItemSetting", loadFirstItem);

            showAllImagesInNewsList = WebUtils.ParseBoolFromHashtable(settings, "ShowAllImagesInNewsList", showAllImagesInNewsList);
            showAttributesInNewsList = WebUtils.ParseBoolFromHashtable(settings, "ShowAttributesInNewsList", showAttributesInNewsList);
            showHiddenContents = WebUtils.ParseBoolFromHashtable(settings, "ShowHiddenContentsOnDetailPage", showHiddenContents);
            hideOtherContentsOnDetailPage = WebUtils.ParseBoolFromHashtable(settings, "HideOtherContentsOnDetailPage", hideOtherContentsOnDetailPage);
            hidePaginationOnDetailPage = WebUtils.ParseBoolFromHashtable(settings, "HidePaginationOnDetailPage", hidePaginationOnDetailPage);
        }

        private bool hidePaginationOnDetailPage = false;
        public bool HidePaginationOnDetailPage
        {
            get { return hidePaginationOnDetailPage; }
        }

        private bool showHiddenContents = false;
        public bool ShowHiddenContents
        {
            get { return showHiddenContents; }
        }

        private bool hideOtherContentsOnDetailPage = false;
        public bool HideOtherContentsOnDetailPage
        {
            get { return hideOtherContentsOnDetailPage; }
        }

        private int newsType = 0;
        public int NewsType
        {
            get { return newsType; }
        }

        private string xsltFileName = string.Empty;
        public string XsltFileName
        {
            get { return xsltFileName; }
        }

        private string xsltFileNameDetailPage = string.Empty;
        public string XsltFileNameDetailPage
        {
            get { return xsltFileNameDetailPage; }
        }

        private bool loadFirstItem = false;
        public bool LoadFirstItem
        {
            get { return loadFirstItem; }
        }

        // for now this is hard coded maybe will promote it to a configurable setting later
        // users can only edit their own posts unless in one of these roles
        // this module doesn't currently have an approval process for news posts
        // only now adding support for multiple users who can only edit their own posts
        //private string approverRoles = "Admins;Content Administrators;";
        //public string ApproverRoles
        //{
        //    get { return approverRoles; }
        //}

        //private int allowedEditMinutesForUnModeratedPosts = 10;
        //public int AllowedEditMinutesForUnModeratedPosts
        //{
        //    get { return allowedEditMinutesForUnModeratedPosts; }
        //}

        private bool requireApprovalForComments = false;
        public bool RequireApprovalForComments
        {
            get { return requireApprovalForComments; }
        }

        private int relatedItemsToShow = 5;
        public int RelatedItemsToShow
        {
            get { return relatedItemsToShow; }
        }

        #region Comment System

        private bool notifyOnComment = false;
        public bool NotifyOnComment
        {
            get { return notifyOnComment; }
        }

        private bool allowComments = false;
        public bool AllowComments
        {
            get { return allowComments; }
        }

        public static bool UseLegacyCommentSystem
        {
            get { return ConfigHelper.GetBoolProperty("Article:UseLegacyCommentSystem", true); }
        }

        private bool allowCommentTitle = true;
        public bool AllowCommentTitle
        {
            get { return allowCommentTitle; }
        }

        private bool allowWebSiteUrlForComments = true;
        public bool AllowWebSiteUrlForComments
        {
            get { return allowWebSiteUrlForComments; }
        }

        private bool useCaptcha = false;
        public bool UseCaptcha
        {
            get { return useCaptcha; }
        }

        private bool requireAuthenticationForComments = false;
        public bool RequireAuthenticationForComments
        {
            get { return requireAuthenticationForComments; }
        }

        private string commentSystem = "internal";
        public string CommentSystem
        {
            get { return commentSystem; }
        }

        #endregion

        private string notifyEmail = string.Empty;
        public string NotifyEmail
        {
            get { return notifyEmail; }
        }

        private bool enableContentVersioning = false;
        public bool EnableContentVersioning
        {
            get { return enableContentVersioning; }
        }

        private bool showAllNews = false;
        public bool ShowAllNews
        {
            get { return showAllNews; }
        }

        private bool showAllImagesInNewsList = false;
        public bool ShowAllImagesInNewsList
        {
            get { return showAllImagesInNewsList; }
        }

        private bool showAttributesInNewsList = false;
        public bool ShowAttributesInNewsList
        {
            get { return showAttributesInNewsList; }
        }

        private bool showLeftContent = true;
        public bool ShowLeftContent
        {
            get { return showLeftContent; }
        }

        private bool showRightContent = true;
        public bool ShowRightContent
        {
            get { return showRightContent; }
        }

        private int pageSize = 10;
        public int PageSize
        {
            get { return pageSize; }
        }

        public static string BingMapDistanceUnit
        {
            get { return ConfigHelper.GetStringProperty("Article:BingMapDistanceUnit", "VERouteDistanceUnit.Mile"); }
        }

        /// <summary>
        /// If true and the skin is using altcontent1 it will load the page content for that in the news detail view
        /// </summary>
        public static bool ShowTopContent
        {
            get { return ConfigHelper.GetBoolProperty("Article:ShowTopContent", true); }
        }

        /// <summary>
        /// If true and the skin is using altcontent2 it will load the page content for that in the news detail view
        /// </summary>
        public static bool ShowBottomContent
        {
            get { return ConfigHelper.GetBoolProperty("Article:ShowBottomContent", true); }
        }

        /// <summary>
        /// 165 is the max recommended by google
        /// </summary>
        public static int MetaDescriptionMaxLengthToGenerate
        {
            get { return ConfigHelper.GetIntProperty("Article:MetaDescriptionMaxLengthToGenerate", 165); }
        }

        public static bool UseNoIndexFollowMetaOnLists
        {
            get { return ConfigHelper.GetBoolProperty("Article:UseNoIndexFollowMetaOnLists", true); }
        }

        public static bool UseHtmlDiff
        {
            get { return ConfigHelper.GetBoolProperty("Article:UseHtmlDiff", true); }
        }

        //public static bool SecurePostsByUser
        //{
        //    get { return ConfigHelper.GetBoolProperty("Article:SecurePostsByUser", false); }
        //}

        public static bool UseImages
        {
            get { return ConfigHelper.GetBoolProperty("Article:UseImages", true); }
        }

        public static int JobApplyAttachFileSize
        {
            get { return ConfigHelper.GetIntProperty("Article:JobApplyAttachFileSize", 1); } // 1 MB
        }
        public static string JobApplyAttachFileNote
        {
            get { return ConfigHelper.GetStringProperty("Article:JobApplyAttachFileNote", "rar,zip,doc,docx,pdf, <1MB"); }
        }
        public static string JobApplyAttachFileExtensions
        {
            get { return ConfigHelper.GetStringProperty("Article:JobApplyAttachFileExtensions", ".rar|.zip|.doc|.docx|.pdf"); }
        }
    }
}