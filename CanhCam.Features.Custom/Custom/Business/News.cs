/// Author:			    Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			2013-01-01
/// Last Modified:		2014-06-25

using System;
using System.Data;
using log4net;
using CanhCam.Data;
using System.Collections.Generic;

namespace CanhCam.Business
{
    public class News : IIndexableContent
    {
        private const string featureGuid = "4521d7a5-1a5e-488c-a10a-a5d9e9659c77";

        public static Guid FeatureGuid
        {
            get { return new Guid(featureGuid); }
        }

        #region Constructors

        public News()
        { }

        public News(int siteId, int newsId)
        {
            if (newsId > -1)
            {
                GetNews(siteId, newsId, -1);
            }
        }

        public News(int siteId, int newsId, int languageId)
        {
            if (newsId > -1)
            {
                GetNews(siteId, newsId, languageId);
            }
        }

        #endregion

        #region Private Properties

        private static readonly ILog log = LogManager.GetLogger(typeof(News));

        private int siteID = -1;
        private int newsID = -1;
        private int zoneID = -1;
        private string title = string.Empty;
        private string subTitle = string.Empty;
        private string url = string.Empty;
        private string code = string.Empty;
        private bool openInNewWindow = false;
        private bool includeInSearch = true;
        private bool includeInSiteMap = true;
        private bool includeInFeed = true;
        private string briefContent = string.Empty;
        private string fullContent = string.Empty;
        private int newsType = 0;
        private int position = 0;
        private int showOption = 0;
        private bool isPublished = false;
        private DateTime startDate = DateTime.UtcNow;
        private DateTime endDate = DateTime.MaxValue;
        private int displayOrder = 0;
        private int viewed = 0;
        private bool isDeleted = false;
        private int allowCommentsForDays = 60;
        private int commentCount = 0;
        private string metaTitle = string.Empty;
        private string metaKeywords = string.Empty;
        private string metaDescription = string.Empty;
        private string additionalMetaTags = string.Empty;
        private string compiledMeta = string.Empty;
        private string fileAttachment = string.Empty;
        private Guid newsGuid = Guid.Empty;
        private Guid userGuid = Guid.Empty;
        private DateTime createdUtc = DateTime.UtcNow;
        private DateTime lastModUtc = DateTime.UtcNow;
        private Guid lastModUserGuid = Guid.Empty;
        private int userID = -1;

        private Guid? approvedUserGuid = null;
        private DateTime? approvedUtc = null;
        private string approvedBy = null;
        private string rejectedNotes = null;
        private int? stateID = -1;

        private int previousNewsId = -1;
        private int nextNewsId = -1;
        private int nextZoneId = -1;
        private int previousZoneId = -1;
        private string previousNewsUrl = string.Empty;
        private string previousNewsTitle = string.Empty;
        private string nextNewsUrl = string.Empty;
        private string nextNewsTitle = string.Empty;
        private bool isLastNews = false;
        private bool isFirstNews = false;

        private string searchIndexPath = string.Empty;
        private string createdByName = string.Empty;

        private string imageFile = string.Empty;
        private string thumbnailFile = string.Empty;

        #endregion

        #region Public Properties

        public int NewsID
        {
            get { return newsID; }
            set { newsID = value; }
        }
        public int ZoneID
        {
            get { return zoneID; }
            set { zoneID = value; }
        }
        public string Title
        {
            get { return title; }
            set { title = value; }
        }
        public string SubTitle
        {
            get { return subTitle; }
            set { subTitle = value; }
        }
        public string Url
        {
            get { return url; }
            set { url = value; }
        }
        public string Code
        {
            get { return code; }
            set { code = value; }
        }
        public bool OpenInNewWindow
        {
            get { return openInNewWindow; }
            set { openInNewWindow = value; }
        }
        public bool IncludeInSearch
        {
            get { return includeInSearch; }
            set { includeInSearch = value; }
        }
        public bool IncludeInSiteMap
        {
            get { return includeInSiteMap; }
            set { includeInSiteMap = value; }
        }
        public bool IncludeInFeed
        {
            get { return includeInFeed; }
            set { includeInFeed = value; }
        }
        public string BriefContent
        {
            get { return briefContent; }
            set { briefContent = value; }
        }
        public string FullContent
        {
            get { return fullContent; }
            set { fullContent = value; }
        }
        public int NewsType
        {
            get { return newsType; }
            set { newsType = value; }
        }
        public int Position
        {
            get { return position; }
            set { position = value; }
        }
        public int ShowOption
        {
            get { return showOption; }
            set { showOption = value; }
        }
        public bool IsPublished
        {
            get { return isPublished; }
            set { isPublished = value; }
        }
        public DateTime StartDate
        {
            get { return startDate; }
            set { startDate = value; }
        }
        public DateTime EndDate
        {
            get { return endDate; }
            set { endDate = value; }
        }
        public int DisplayOrder
        {
            get { return displayOrder; }
            set { displayOrder = value; }
        }
        public int Viewed
        {
            get { return viewed; }
            set { viewed = value; }
        }
        public bool IsDeleted
        {
            get { return isDeleted; }
            set { isDeleted = value; }
        }
        public int AllowCommentsForDays
        {
            get { return allowCommentsForDays; }
            set { allowCommentsForDays = value; }
        }
        public int CommentCount
        {
            get { return commentCount; }
            set { commentCount = value; }
        }
        public string MetaTitle
        {
            get { return metaTitle; }
            set { metaTitle = value; }
        }
        public string AdditionalMetaTags
        {
            get { return additionalMetaTags; }
            set { additionalMetaTags = value; }
        }
        public string MetaKeywords
        {
            get { return metaKeywords; }
            set { metaKeywords = value; }
        }
        public string MetaDescription
        {
            get { return metaDescription; }
            set { metaDescription = value; }
        }
        public string CompiledMeta
        {
            get { return compiledMeta; }
            set { compiledMeta = value; }
        }
        public string FileAttachment
        {
            get { return fileAttachment; }
            set { fileAttachment = value; }
        }
        public Guid NewsGuid
        {
            get { return newsGuid; }
            set { newsGuid = value; }
        }
        public Guid UserGuid
        {
            get { return userGuid; }
            set { userGuid = value; }
        }
        public DateTime CreatedUtc
        {
            get { return createdUtc; }
            set { createdUtc = value; }
        }
        public DateTime LastModUtc
        {
            get { return lastModUtc; }
            set { lastModUtc = value; }
        }
        public Guid LastModUserGuid
        {
            get { return lastModUserGuid; }
            set { lastModUserGuid = value; }
        }

        public int UserID
        {
            get { return userID; }
            set { userID = value; }
        }

        public int? StateId
        {
            get { return stateID; }
            set { stateID = value; }
        }
        public Guid? ApprovedUserGuid
        {
            get { return approvedUserGuid; }
            set { approvedUserGuid = value; }
        }
        public DateTime? ApprovedUtc
        {
            get { return approvedUtc; }
            set { approvedUtc = value; }
        }
        public string ApprovedBy
        {
            get { return approvedBy; }
            set { approvedBy = value; }
        }
        public string RejectedNotes
        {
            get { return rejectedNotes; }
            set { rejectedNotes = value; }
        }

        private string userEmail = string.Empty;
        public string UserEmail
        {
            get { return userEmail; }

        }

        public string CreatedByName
        {
            get { return createdByName; }
            set { createdByName = value; }
        }

        public int PreviousNewsId
        {
            get 
            { 
                return previousNewsId; 
            }
        }
        public int PreviousZoneId
        {
            get { return previousZoneId; }
        }
        public int NextNewsId
        {
            get { return nextNewsId; }
        }
        public int NextZoneId
        {
            get { return nextZoneId; }
        }
        public string PreviousNewsUrl
        {
            get { return previousNewsUrl; }

        }
        public string NextNewsUrl
        {
            get { return nextNewsUrl; }
        }
        public string PreviousNewsTitle
        {
            get { return previousNewsTitle; }
        }
        public string NextNewsTitle
        {
            get { return nextNewsTitle; }
        }
        public bool IsLastNews
        {
            get { return isLastNews; }
            set { isLastNews = value; }
        }
        public bool IsFirstNews
        {
            get { return isFirstNews; }
            set { isFirstNews = value; }
        }

        /// <summary>
        /// This is not persisted to the db. It is only set and used when indexing forum threads in the search index.
        /// Its a convenience because when we queue the task to index on a new thread we can only pass one object.
        /// So we store extra properties here so we don't need any other objects.
        /// </summary>
        public int SiteId
        {
            get { return siteID; }
            set { siteID = value; }
        }

        /// <summary>
        /// This is not persisted to the db. It is only set and used when indexing forum threads in the search index.
        /// Its a convenience because when we queue the task to index on a new thread we can only pass one object.
        /// So we store extra properties here so we don't need any other objects.
        /// </summary>
        public string SearchIndexPath
        {
            get { return searchIndexPath; }
            set { searchIndexPath = value; }
        }

        public string ImageFile
        {
            get { return imageFile; }
            set { imageFile = value; }
        }

        public string ThumbnailFile
        {
            get { return thumbnailFile; }
            set { thumbnailFile = value; }
        }

        #endregion

        #region Private Methods

        private void GetNews(int siteID, int newsID, int languageId)
        {
            PopulateNews(this, DBNews.GetSingleNews(siteID, newsID, languageId));
        }

        protected static void PopulateNews(News news, IDataReader reader)
        {
            try
            {
                if (reader.Read())
                {
                    news.newsID = Convert.ToInt32(reader["NewsID"]);
                    news.siteID = Convert.ToInt32(reader["SiteID"]);
                    news.zoneID = Convert.ToInt32(reader["ZoneID"]);
                    news.title = reader["Title"].ToString();
                    news.subTitle = reader["SubTitle"].ToString();
                    news.url = reader["Url"].ToString();
                    news.code = reader["Code"].ToString();
                    news.openInNewWindow = Convert.ToBoolean(reader["OpenInNewWindow"]);
                    news.includeInSearch = Convert.ToBoolean(reader["IncludeInSearch"]);
                    news.includeInSiteMap = Convert.ToBoolean(reader["IncludeInSiteMap"]);
                    news.includeInFeed = Convert.ToBoolean(reader["IncludeInFeed"]);
                    news.briefContent = reader["BriefContent"].ToString();
                    news.fullContent = reader["FullContent"].ToString();
                    news.newsType = Convert.ToInt32(reader["NewsType"]);
                    news.position = Convert.ToInt32(reader["Position"]);
                    news.showOption = Convert.ToInt32(reader["ShowOption"]);
                    news.isPublished = Convert.ToBoolean(reader["IsPublished"]);
                    news.startDate = Convert.ToDateTime(reader["StartDate"]);
                    if (reader["EndDate"] != DBNull.Value)
                    {
                        news.endDate = Convert.ToDateTime(reader["EndDate"]);
                    }
                    news.displayOrder = Convert.ToInt32(reader["DisplayOrder"]);
                    news.viewed = Convert.ToInt32(reader["Viewed"]);
                    news.isDeleted = Convert.ToBoolean(reader["IsDeleted"]);
                    if (reader["AllowCommentsForDays"] != DBNull.Value)
                    {
                        news.allowCommentsForDays = Convert.ToInt32(reader["AllowCommentsForDays"]);
                    }
                    news.commentCount = Convert.ToInt32(reader["CommentCount"]);
                    if (reader["MetaTitle"] != DBNull.Value)
                    {
                        news.metaTitle = reader["MetaTitle"].ToString();
                    }
                    if (reader["AdditionalMetaTags"] != DBNull.Value)
                    {
                        news.additionalMetaTags = reader["AdditionalMetaTags"].ToString();
                    }
                    news.metaKeywords = reader["MetaKeywords"].ToString();
                    news.metaDescription = reader["MetaDescription"].ToString();
                    news.compiledMeta = reader["CompiledMeta"].ToString();
                    news.fileAttachment = reader["FileAttachment"].ToString();
                    news.newsGuid = new Guid(reader["NewsGuid"].ToString());

                    news.userEmail = reader["Email"].ToString();
                    string var = reader["UserGuid"].ToString();
                    if (var.Length == 36) news.userGuid = new Guid(var);

                    news.createdUtc = Convert.ToDateTime(reader["CreatedUtc"]);
                    if (reader["LastModUtc"] != DBNull.Value)
                    {
                        news.lastModUtc = Convert.ToDateTime(reader["LastModUtc"]);
                    }
                    var = reader["LastModUserGuid"].ToString();
                    if (var.Length == 36) news.lastModUserGuid = new Guid(var);

                    if (reader["StateID"] != DBNull.Value)
                        news.stateID = Convert.ToInt32(reader["StateID"].ToString());

                    if (reader["CreatedByName"] != DBNull.Value)
                    {
                        news.createdByName = reader["CreatedByName"].ToString();
                    }

                    if (reader["ApprovedUserGuid"] != DBNull.Value)
                    {
                        news.approvedUserGuid = new Guid(reader["ApprovedUserGuid"].ToString());
                    }
                    if (reader["ApprovedUtc"] != DBNull.Value)
                    {
                        news.approvedUtc = Convert.ToDateTime(reader["ApprovedUtc"]);
                    }
                    if (reader["ApprovedBy"] != DBNull.Value)
                    {
                        news.approvedBy = reader["ApprovedBy"].ToString();
                    }
                    if (reader["RejectedNotes"] != DBNull.Value)
                    {
                        news.rejectedNotes = reader["RejectedNotes"].ToString();
                    }
                }
            }
            finally
            {
                reader.Close();
            }
        }

        /// <summary>
        /// Persists a new instance of New. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;
            newsGuid = Guid.NewGuid();
            createdUtc = DateTime.UtcNow;

            newID = DBNews.Create(
                this.siteID,
                this.zoneID,
                this.title,
                this.subTitle,
                this.url,
                this.code,
                this.openInNewWindow,
                this.includeInSearch,
                this.includeInSiteMap,
                this.includeInFeed,
                this.briefContent,
                this.fullContent,
                this.newsType,
                this.position,
                this.showOption,
                this.isPublished,
                this.startDate,
                this.endDate,
                this.displayOrder,
                this.viewed,
                this.isDeleted,
                this.allowCommentsForDays,
                this.commentCount,
                this.metaTitle,
                this.metaKeywords,
                this.metaDescription,
                this.additionalMetaTags,
                this.compiledMeta,
                this.fileAttachment,
                this.newsGuid,
                this.userGuid,
                this.createdUtc,
                this.lastModUtc,
                this.lastModUserGuid);

            this.newsID = newID;

            bool result = (newID > 0);

            //IndexHelper.IndexItem(this);
            if (result)
            {
                ContentChangedEventArgs e = new ContentChangedEventArgs();
                OnContentChanged(e);
            }

            return result;
        }

        private bool Update()
        {
            this.lastModUtc = DateTime.UtcNow;
            bool result = DBNews.Update(
                this.newsID,
                this.zoneID,
                this.title,
                this.subTitle,
                this.url,
                this.code,
                this.openInNewWindow,
                this.includeInSearch,
                this.includeInSiteMap,
                this.includeInFeed,
                this.briefContent,
                this.fullContent,
                this.newsType,
                this.position,
                this.showOption,
                this.isPublished,
                this.startDate,
                this.endDate,
                this.displayOrder,
                this.viewed,
                this.isDeleted,
                this.allowCommentsForDays,
                this.metaTitle,
                this.metaKeywords,
                this.metaDescription,
                this.additionalMetaTags,
                this.compiledMeta,
                this.fileAttachment,
                this.lastModUtc,
                this.lastModUserGuid);

            if (result)
            {
                ContentChangedEventArgs e = new ContentChangedEventArgs();
                OnContentChanged(e);
            }

            return result;
        }

        #endregion

        #region Public Methods

        public bool Save()
        {
            if (this.newsID > 0)
            {
                return Update();
            }
            else
            {
                return Create();
            }
        }

        public bool Delete()
        {
            DBNews.DeleteAllCommentsForNews(this.newsID);
            bool result = DBNews.DeleteNews(this.newsID);

            if (result)
            {
                ContentChangedEventArgs e = new ContentChangedEventArgs();
                e.IsDeleted = true;
                OnContentChanged(e);
            }

            return result;
        }

        public bool SaveState(int lastWorkflowStateId = -1)
        {
            bool result = DBNews.UpdateState(this.newsID, this.StateId, this.approvedUtc, this.approvedUserGuid, this.approvedBy, this.rejectedNotes);

            if (result)
            {
                if (this.stateID == lastWorkflowStateId)
                {
                    if (!this.isPublished)
                    {
                        this.isPublished = true;
                        this.Save();
                    }
                }
                else if (this.isPublished)
                {
                    this.isPublished = false;
                    this.Save();
                }

                ContentChangedEventArgs e = new ContentChangedEventArgs();
                OnContentChanged(e);
            }

            return result;
        }

        public bool SaveDeleted()
        {
            bool result = DBNews.UpdateDeleted(this.newsID, this.isDeleted);

            if (result)
            {
                ContentChangedEventArgs e = new ContentChangedEventArgs();
                e.IsDeleted = this.isDeleted;
                OnContentChanged(e);
            }

            return result;
        }

        public void LoadNextPrevious()
        {
            LoadNextPrevious(-1);
        }

        public void LoadNextPrevious(int languageId)
        {
            using (IDataReader reader = DBNews.GetNextPreviousNews(this.newsID, this.zoneID, languageId))
            {
                if (reader.Read())
                {
                    if (reader["PreviousNewsID"] != DBNull.Value)
                        this.previousNewsId = Convert.ToInt32(reader["PreviousNewsID"].ToString());
                    if (reader["NextNewsID"] != DBNull.Value)
                        this.nextNewsId = Convert.ToInt32(reader["NextNewsID"].ToString());
                    if (reader["PreviousZoneID"] != DBNull.Value)
                        this.previousZoneId = Convert.ToInt32(reader["PreviousZoneID"].ToString());
                    if (reader["NextZoneID"] != DBNull.Value)
                        this.nextZoneId = Convert.ToInt32(reader["NextZoneID"].ToString());
                    if (reader["PreviousNewsUrl"] != DBNull.Value)
                        this.previousNewsUrl = reader["PreviousNewsUrl"].ToString();
                    if (reader["PreviousNewsTitle"] != DBNull.Value)
                        this.previousNewsTitle = reader["PreviousNewsTitle"].ToString();
                    if (reader["NextNewsUrl"] != DBNull.Value)
                        this.nextNewsUrl = reader["NextNewsUrl"].ToString();
                    if (reader["NextNewsTitle"] != DBNull.Value)
                        this.nextNewsTitle = reader["NextNewsTitle"].ToString();

                    if (reader["IsFirstNews"] != DBNull.Value)
                        this.isFirstNews = Convert.ToBoolean(reader["IsFirstNews"]);
                    if (reader["IsLastNews"] != DBNull.Value)
                        this.isLastNews = Convert.ToBoolean(reader["IsLastNews"]);
                }
            }
        }

        #endregion

        #region Static Methods

        public static int GetCountByListZone(
            int siteId,
            string listZoneId,
            int newsType,
            int position,
            int languageId)
        {
            return DBNews.GetCountByListZone(siteId, listZoneId, newsType, position, languageId);
        }

        public static List<News> GetPageByListZone(
            int siteId,
            string listZoneId,
            int newsType,
            int position,
            int languageId,
            int pageNumber,
            int pageSize)
        {
            return LoadListFromReader(DBNews.GetPageByListZone(siteId, listZoneId, newsType, position, languageId, pageNumber, pageSize));
        }

        public static News GetOneByZone(int zoneId, int languageId)
        {
            News news = new News();
            PopulateNews(news, DBNews.GetSingleNews(zoneId, DateTime.UtcNow, languageId));

            return news;
        }

        public static int GetCount(
            int siteId,
            int zoneId,
            int languageId,
            int newsType,
            int position)
        {
            return DBNews.GetCount(siteId, zoneId, DateTime.UtcNow, languageId, newsType, position);
        }

        public static List<News> GetPageNewsOther(
           int zoneId,
           int newsId,
           int languageId,
           int newsType,
           int pageNumber,
           int pageSize,
           out int totalPages)
        {
            return LoadListFromReader(DBNews.GetPageNewsOther(zoneId, newsId, DateTime.UtcNow, languageId, newsType, pageNumber, pageSize, out totalPages));
        }

        public static List<News> GetPage(
            int siteId,
            int zoneId,
            int languageId,
            int newsType,
            int position,
            int pageNumber,
            int pageSize)
        {
            return LoadListFromReader(DBNews.GetPage(siteId, zoneId, DateTime.UtcNow, languageId, newsType, position, pageNumber, pageSize));
        }

        [Obsolete("This method is deprecated and may be removed in future versions. You should use GetCountBySearch2 instead.")]
        public static int GetCountBySearch(
            int siteId,
            string listZoneId,
            int newsType,
            int isPublished,
            string listStateId,
            int languageId,
            int position,
            int showOption,
            DateTime? startDateFrom,
            DateTime? startDateTo,
            DateTime? endDateFrom,
            DateTime? endDateTo,
            Guid? userGuid,
            string keyword)
        {
            return DBNews.GetCountBySearch(siteId, listZoneId, newsType, isPublished, listStateId, languageId, position, showOption, startDateFrom, startDateTo, endDateFrom, endDateTo, userGuid, keyword);
        }

        [Obsolete("This method is deprecated and may be removed in future versions. You should use GetPageBySearch2 instead.")]
        public static List<News> GetPageBySearch(
            int siteId,
            string listZoneId,
            int newsType,
            int isPublished,
            string listStateId,
            int languageId,
            int position,
            int showOption,
            DateTime? startDateFrom,
            DateTime? startDateTo,
            DateTime? endDateFrom,
            DateTime? endDateTo,
            Guid? userGuid,
            string keyword,
            int pageNumber,
            int pageSize)
        {
            return LoadListFromReader(DBNews.GetPageBySearch(siteId, listZoneId, newsType, isPublished, listStateId, languageId, position, showOption, startDateFrom, startDateTo, endDateFrom, endDateTo, userGuid, keyword, pageNumber, pageSize));
        }

        public static int GetCountBySearch2(
            int siteId = -1,
            string zoneIds = null,
            int publishStatus = -1,
            int languageId = -1,
            int newsType = -1,
            int position = -1,
            int showOption = -1,
            string newsIds = null,
            string excludeNewsIds = null,
            DateTime? startDate = null,
            DateTime? endDate = null,
            string keyword = null,
            string stateIds = null,
            Guid? userGuid = null)
        {
            return DBNews.GetCountBySearch2(siteId, zoneIds, publishStatus, languageId, newsType, position, showOption, newsIds, excludeNewsIds, startDate, endDate, keyword, stateIds, userGuid);
        }

        public static List<News> GetPageBySearch2(
            int pageNumber = 1,
            int pageSize = 32767,
            int siteId = -1,
            string zoneIds = null,
            int publishStatus = -1,
            int languageId = -1,
            int newsType = -1,
            int position = -1,
            int showOption = -1,
            string newsIds = null,
            string excludeNewsIds = null,
            DateTime? startDate = null,
            DateTime? endDate = null,
            string keyword = null,
            string stateIds = null,
            Guid? userGuid = null,
            int orderBy = 0)
        {
            return LoadListFromReader(DBNews.GetPageBySearch2(pageNumber, pageSize, siteId, zoneIds, publishStatus, languageId, newsType, position, showOption, newsIds, excludeNewsIds, startDate, endDate, keyword, stateIds, userGuid, orderBy));
        }

        public static bool DeleteBySite(int siteId)
        {
            return DBNews.DeleteBySite(siteId);
        }

        public static List<News> GetByZone(int siteId, int zoneId)
        {
            return LoadListFromReader(DBNews.GetByZone(siteId, zoneId), false, false);
        }

        public static IDataReader GetNewsForSiteMap(int siteId, int languageId)
        {
            return DBNews.GetNewsForSiteMap(siteId, languageId);
        }

        public static List<News> GetByGuids(
           int siteId,
           string newsGuids,
           int publishStatus = -1,
           int languageId = -1)
        {
            return LoadListFromReader(DBNews.GetByGuids(siteId, newsGuids, publishStatus, languageId));
        }

        protected static List<News> LoadListFromReader(IDataReader reader, bool loadUser = true, bool loadImage = true)
        {
            List<News> newList = new List<News>();
            try
            {
                while (reader.Read())
                {
                    News item = new News();
                    item.siteID = Convert.ToInt32(reader["SiteID"]);
                    item.newsID = Convert.ToInt32(reader["NewsID"]);
                    item.zoneID = Convert.ToInt32(reader["ZoneID"]);
                    item.title = reader["Title"].ToString();
                    item.subTitle = reader["SubTitle"].ToString();
                    item.url = reader["Url"].ToString();
                    item.code = reader["Code"].ToString();
                    item.openInNewWindow = Convert.ToBoolean(reader["OpenInNewWindow"]);
                    item.includeInSearch = Convert.ToBoolean(reader["IncludeInSearch"]);
                    item.includeInSiteMap = Convert.ToBoolean(reader["IncludeInSiteMap"]);
                    item.includeInFeed = Convert.ToBoolean(reader["IncludeInFeed"]);
                    item.briefContent = reader["BriefContent"].ToString();
                    item.fullContent = reader["FullContent"].ToString();
                    item.newsType = Convert.ToInt32(reader["NewsType"]);
                    item.position = Convert.ToInt32(reader["Position"]);
                    item.showOption = Convert.ToInt32(reader["ShowOption"]);
                    item.isPublished = Convert.ToBoolean(reader["IsPublished"]);
                    item.startDate = Convert.ToDateTime(reader["StartDate"]);
                    if (reader["EndDate"] != DBNull.Value)
                    {
                        item.endDate = Convert.ToDateTime(reader["EndDate"]);
                    }
                    item.displayOrder = Convert.ToInt32(reader["DisplayOrder"]);
                    item.viewed = Convert.ToInt32(reader["Viewed"]);
                    item.isDeleted = Convert.ToBoolean(reader["IsDeleted"]);
                    item.allowCommentsForDays = Convert.ToInt32(reader["AllowCommentsForDays"]);
                    item.commentCount = Convert.ToInt32(reader["CommentCount"]);
                    if (reader["MetaTitle"] != DBNull.Value)
                    {
                        item.metaTitle = reader["MetaTitle"].ToString();
                    }
                    if (reader["AdditionalMetaTags"] != DBNull.Value)
                    {
                        item.additionalMetaTags = reader["AdditionalMetaTags"].ToString();
                    }
                    item.metaKeywords = reader["MetaKeywords"].ToString();
                    item.metaDescription = reader["MetaDescription"].ToString();
                    item.compiledMeta = reader["CompiledMeta"].ToString();
                    item.fileAttachment = reader["FileAttachment"].ToString();
                    item.newsGuid = new Guid(reader["NewsGuid"].ToString());
                    item.userGuid = new Guid(reader["UserGuid"].ToString());
                    item.createdUtc = Convert.ToDateTime(reader["CreatedUtc"]);
                    item.lastModUtc = Convert.ToDateTime(reader["LastModUtc"]);
                    item.lastModUserGuid = new Guid(reader["LastModUserGuid"].ToString());

                    //if (reader["ApprovedUtc"] != DBNull.Value)
                    //{
                    //    item.approvedUtc = Convert.ToDateTime(reader["ApprovedUtc"]);
                    //}
                    //if (reader["ApprovedBy"] != DBNull.Value)
                    //{
                    //    item.approvedBy = reader["ApprovedBy"].ToString();
                    //}
                    //if (reader["ApprovedUserGuid"] != DBNull.Value)
                    //{
                    //    item.approvedUserGuid = new Guid(reader["ApprovedUserGuid"].ToString());
                    //}
                    //if (reader["RejectedNotes"] != DBNull.Value)
                    //{
                    //    item.rejectedNotes = reader["RejectedNotes"].ToString();
                    //}
                    if (reader["StateID"] != DBNull.Value)
                    {
                        item.stateID = Convert.ToInt32(reader["StateID"]);
                    }
                    if (loadUser)
                    {
                        if (reader["CreatedByName"] != DBNull.Value)
                        {
                            item.createdByName = reader["CreatedByName"].ToString();
                        }
                        item.userID = Convert.ToInt32(reader["UserID"]);
                    }

                    if (loadImage)
                    {
                        if (reader["ImageFile"] != DBNull.Value)
                        {
                            item.ImageFile = reader["ImageFile"].ToString();
                        }
                        if (reader["ThumbnailFile"] != DBNull.Value)
                        {
                            item.ThumbnailFile = reader["ThumbnailFile"].ToString();
                        }
                    }

                    newList.Add(item);
                }
            }
            finally
            {
                reader.Close();
            }

            return newList;
        }

        public static bool IncrementViewedCount(int newsId)
        {
            return DBNews.IncrementViewedCount(newsId);
        }

        public static bool UpdateZone(int newsId, int zoneId)
        {
            return DBNews.UpdateZone(newsId, zoneId);
        }

        public static bool UpdateCommentCount(Guid newsGuid, int commentCount)
        {
            return DBNews.UpdateCommentCount(newsGuid, commentCount);
        }

        public static bool DeleteNewsComment(int commentId)
        {
            return DBNews.DeleteNewsComment(commentId);
        }

        public static IDataReader GetNewsComments(int newsId)
        {
            return DBNews.GetNewsComments(newsId);
        }

        public static IDataReader GetPageNewsComments(int newsId, int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBNews.GetPageNewsComments(newsId, pageNumber, pageSize, out totalPages);

            return reader;
        }

        public static DataTable GetNewsCommentsTable(int moduleId, int newsId)
        {
            DataTable dataTable = new DataTable();

            dataTable.Columns.Add("Comment", typeof(string));
            dataTable.Columns.Add("Name", typeof(string));

            using (IDataReader reader = DBNews.GetNewsComments(newsId))
            {
                while (reader.Read())
                {
                    DataRow row = dataTable.NewRow();

                    row["Comment"] = reader["Comment"];
                    row["Name"] = reader["Name"];

                    dataTable.Rows.Add(row);
                }
            }

            return dataTable;
        }

        public static bool AddNewsComment(
            int newsId,
            String name,
            String title,
            String url,
            String comment,
            DateTime dateCreated)
        {
            if (name == null)
            {
                name = "unknown";
            }
            if (name.Length < 1)
            {
                name = "unknown";
            }

            if ((title != null) && (url != null) && (comment != null))
            {
                if (title.Length > 255)
                {
                    title = title.Substring(0, 255);
                }

                if (name.Length > 255)
                {
                    name = name.Substring(0, 255);
                }

                if (url.Length > 255)
                {
                    url = url.Substring(0, 255);
                }

                return DBNews.AddNewsComment(
                    newsId,
                    name,
                    title,
                    url,
                    comment,
                    null,
                    null,
                    null,
                    null,
                    null,
                    dateCreated);
            }

            return false;
        }

        public static bool AddNewsComment(
            int newsId,
            String name,
            String title,
            String url,
            String comment,
            String address,
            String email,
            String phone,
            String attachFile1,
            String attachFile2,
            DateTime dateCreated)
        {
            if (name == null)
            {
                name = "unknown";
            }
            if (name.Length < 1)
            {
                name = "unknown";
            }

            if ((title != null) && (url != null) && (comment != null))
            {
                if (title.Length > 100)
                {
                    title = title.Substring(0, 100);
                }

                if (name.Length > 100)
                {
                    name = name.Substring(0, 100);
                }

                if (url.Length > 200)
                {
                    url = url.Substring(0, 200);
                }

                return DBNews.AddNewsComment(
                    newsId,
                    name,
                    title,
                    url,
                    comment,
                    address,
                    email,
                    phone,
                    attachFile1,
                    attachFile2,
                    dateCreated);
            }

            return false;
        }

        #endregion

        #region IIndexableContent

        public event ContentChangedEventHandler ContentChanged;

        protected void OnContentChanged(ContentChangedEventArgs e)
        {
            if (ContentChanged != null)
            {
                ContentChanged(this, e);
            }
        }

        #endregion
    }
}