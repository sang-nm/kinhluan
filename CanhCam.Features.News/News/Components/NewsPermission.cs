/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2014-06-25

using System;
using System.Linq;

namespace CanhCam.Web.NewsUI
{
    public static class NewsPermission
    {
        public const string ViewList = "Permissions.News.ViewList";
        public const string Create = "Permissions.News.Create";
        public const string Update = "Permissions.News.Update";
        public const string Delete = "Permissions.News.Delete";
        public const string ManageComment = "Permissions.News.ManageComment";

        public static bool CanViewList
        {
            get { return SiteUtils.UserHasPermission(ViewList); }
        }
        public static bool CanCreate
        {
            get { return SiteUtils.UserHasPermission(Create); }
        }
        public static bool CanUpdate
        {
            get { return SiteUtils.UserHasPermission(Update); }
        }
        public static bool CanDelete
        {
            get { return SiteUtils.UserHasPermission(Delete); }
        }
        public static bool CanManageComment
        {
            get { return SiteUtils.UserHasPermission(ManageComment); }
        }

    }
}