/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2015-10-02 --Add new setting: ZoneIds

using System;
using System.Collections;
using CanhCam.Web.Framework;

namespace CanhCam.Web.NewsUI
{
    public class NewsSpecialConfiguration
    {
        public NewsSpecialConfiguration()
        { }

        public NewsSpecialConfiguration(Hashtable settings)
        {
            LoadSettings(settings);
        }

        private void LoadSettings(Hashtable settings)
        {
            if (settings == null || settings.Count == 0) { return; throw new ArgumentException("must pass in a hashtable of settings"); }

            //getLastestNews = WebUtils.ParseBoolFromHashtable(settings, "GetLastestNews", getLastestNews);
            maxItemsToGet = WebUtils.ParseInt32FromHashtable(settings, "MaxItemsToGet", maxItemsToGet);
            newsType = WebUtils.ParseInt32FromHashtable(settings, "NewsTypeSetting", newsType);
            position = WebUtils.ParseInt32FromHashtable(settings, "NewsPositionSetting", position);
            zoneId = WebUtils.ParseInt32FromHashtable(settings, "ParentZoneSetting", zoneId);
            if (settings["ParentZonesSetting"] != null)
                zoneIds = settings["ParentZonesSetting"].ToString();
            sortBy = WebUtils.ParseInt32FromHashtable(settings, "NewsSortBySetting", sortBy);
            showAllImagesInNewsList = WebUtils.ParseBoolFromHashtable(settings, "ShowAllImagesInNewsList", showAllImagesInNewsList);
        }

        private int newsType = 0;
        public int NewsType
        {
            get { return newsType; }
        }

        private int zoneId = -1;
        public int ZoneId
        {
            get { return zoneId; }
        }

        private string zoneIds = string.Empty;
        public string ZoneIds
        {
            get { return zoneIds; }
        }

        private int sortBy = 0;
        public int SortBy
        {
            get { return sortBy; }
        }

        private int position = -1;
        public int Position
        {
            get { return position; }
        }

        //private bool getLastestNews = false;
        //public bool GetLastestNews
        //{
        //    get { return getLastestNews; }
        //}

        private int maxItemsToGet = 5;
        public int MaxItemsToGet
        {
            get { return maxItemsToGet; }
        }

        private bool showAllImagesInNewsList = false;
        public bool ShowAllImagesInNewsList
        {
            get { return showAllImagesInNewsList; }
        }

    }
}