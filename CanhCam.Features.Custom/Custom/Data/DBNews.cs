/// Author:			    Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			2013-01-01
/// Last Modified:		2013-03-10

using System;
using System.Data;
using System.Text;

namespace CanhCam.Data
{
    public static class DBNews
    {
        public static IDataReader GetSingleNews(int siteId, int newsId, int languageId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectOne", 3);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            return sph.ExecuteReader();
        }

        public static IDataReader GetSingleNews(
            int zoneId,
            DateTime currentTime,
            int languageId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectOneByZone", 3);
            sph.DefineSqlParameter("@ZoneID", SqlDbType.Int, ParameterDirection.Input, zoneId);
            sph.DefineSqlParameter("@CurrentTime", SqlDbType.DateTime, ParameterDirection.Input, currentTime);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            return sph.ExecuteReader();
        }

        public static bool DeleteNews(int newsId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_News_Delete", 1);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > -1);
        }

        public static bool DeleteBySite(int siteId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_News_DeleteBySite", 1);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > -1);
        }

        #region Create

        public static int Create(
            int siteID,
            int zoneID,
            string title,
            string subTitle,
            string url,
            string code,
            bool openInNewWindow,
            bool includeInSearch,
            bool includeInSiteMap,
            bool includeInFeed,
            string briefContent,
            string fullContent,
            int newsType,
            int position,
            int showOption,
            bool isPublished,
            DateTime startDate,
            DateTime endDate,
            int displayOrder,
            int viewed,
            bool isDeleted,
            int allowCommentsForDays,
            int commentCount,
            string metaTitle,
            string metaKeywords,
            string metaDescription,
            string additionalMetaTags,
            string compiledMeta,
            string fileAttachment,
            Guid newsGuid,
            Guid userGuid,
            DateTime createdUtc,
            DateTime lastModUtc,
            Guid lastModUserGuid)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_News_Insert", 34);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteID);
            sph.DefineSqlParameter("@ZoneID", SqlDbType.Int, ParameterDirection.Input, zoneID);
            sph.DefineSqlParameter("@Title", SqlDbType.NVarChar, 255, ParameterDirection.Input, title);
            sph.DefineSqlParameter("@SubTitle", SqlDbType.NVarChar, 255, ParameterDirection.Input, subTitle);
            sph.DefineSqlParameter("@Url", SqlDbType.NVarChar, 255, ParameterDirection.Input, url);
            sph.DefineSqlParameter("@Code", SqlDbType.NVarChar, 255, ParameterDirection.Input, code);
            sph.DefineSqlParameter("@OpenInNewWindow", SqlDbType.Bit, ParameterDirection.Input, openInNewWindow);
            sph.DefineSqlParameter("@IncludeInSearch", SqlDbType.Bit, ParameterDirection.Input, includeInSearch);
            sph.DefineSqlParameter("@IncludeInSiteMap", SqlDbType.Bit, ParameterDirection.Input, includeInSiteMap);
            sph.DefineSqlParameter("@IncludeInFeed", SqlDbType.Bit, ParameterDirection.Input, includeInFeed);
            sph.DefineSqlParameter("@BriefContent", SqlDbType.NVarChar, -1, ParameterDirection.Input, briefContent);
            sph.DefineSqlParameter("@FullContent", SqlDbType.NVarChar, -1, ParameterDirection.Input, fullContent);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@Position", SqlDbType.Int, ParameterDirection.Input, position);
            sph.DefineSqlParameter("@ShowOption", SqlDbType.Int, ParameterDirection.Input, showOption);
            sph.DefineSqlParameter("@IsPublished", SqlDbType.Bit, ParameterDirection.Input, isPublished);
            sph.DefineSqlParameter("@StartDate", SqlDbType.DateTime, ParameterDirection.Input, startDate);
            if (endDate < DateTime.MaxValue)
            {
                sph.DefineSqlParameter("@EndDate", SqlDbType.DateTime, ParameterDirection.Input, endDate);
            }
            else
            {
                sph.DefineSqlParameter("@EndDate", SqlDbType.DateTime, ParameterDirection.Input, DBNull.Value);
            }
            sph.DefineSqlParameter("@DisplayOrder", SqlDbType.Int, ParameterDirection.Input, displayOrder);
            sph.DefineSqlParameter("@Viewed", SqlDbType.Int, ParameterDirection.Input, viewed);
            sph.DefineSqlParameter("@IsDeleted", SqlDbType.Bit, ParameterDirection.Input, isDeleted);
            sph.DefineSqlParameter("@AllowCommentsForDays", SqlDbType.Int, ParameterDirection.Input, allowCommentsForDays);
            sph.DefineSqlParameter("@CommentCount", SqlDbType.Int, ParameterDirection.Input, commentCount);
            sph.DefineSqlParameter("@MetaTitle", SqlDbType.NVarChar, 255, ParameterDirection.Input, metaTitle);
            sph.DefineSqlParameter("@MetaKeywords", SqlDbType.NVarChar, 255, ParameterDirection.Input, metaKeywords);
            sph.DefineSqlParameter("@MetaDescription", SqlDbType.NVarChar, 255, ParameterDirection.Input, metaDescription);
            sph.DefineSqlParameter("@AdditionalMetaTags", SqlDbType.NVarChar, -1, ParameterDirection.Input, additionalMetaTags);
            sph.DefineSqlParameter("@CompiledMeta", SqlDbType.NVarChar, -1, ParameterDirection.Input, compiledMeta);
            sph.DefineSqlParameter("@FileAttachment", SqlDbType.NVarChar, 255, ParameterDirection.Input, fileAttachment);
            sph.DefineSqlParameter("@NewsGuid", SqlDbType.UniqueIdentifier, ParameterDirection.Input, newsGuid);
            sph.DefineSqlParameter("@UserGuid", SqlDbType.UniqueIdentifier, ParameterDirection.Input, userGuid);
            sph.DefineSqlParameter("@CreatedUtc", SqlDbType.DateTime, ParameterDirection.Input, createdUtc);
            sph.DefineSqlParameter("@LastModUtc", SqlDbType.DateTime, ParameterDirection.Input, lastModUtc);
            sph.DefineSqlParameter("@LastModUserGuid", SqlDbType.UniqueIdentifier, ParameterDirection.Input, lastModUserGuid);

            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }
        #endregion

        #region Update
        
        public static bool Update(
            int newsID,
            int zoneID,
            string title,
            string subTitle,
            string url,
            string code,
            bool openInNewWindow,
            bool includeInSearch,
            bool includeInSiteMap,
            bool includeInFeed,
            string briefContent,
            string fullContent,
            int newsType,
            int position,
            int showOption,
            bool isPublished,
            DateTime startDate,
            DateTime endDate,
            int displayOrder,
            int viewed,
            bool isDeleted,
            int allowCommentsForDays,
            string metaTitle,
            string metaKeywords,
            string metaDescription,
            string additionalMetaTags,
            string compiledMeta,
            string fileAttachment,
            DateTime lastModUtc,
            Guid lastModUserGuid)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_News_Update", 30);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsID);
            sph.DefineSqlParameter("@ZoneID", SqlDbType.Int, ParameterDirection.Input, zoneID);
            sph.DefineSqlParameter("@Title", SqlDbType.NVarChar, 255, ParameterDirection.Input, title);
            sph.DefineSqlParameter("@SubTitle", SqlDbType.NVarChar, 255, ParameterDirection.Input, subTitle);
            sph.DefineSqlParameter("@Url", SqlDbType.NVarChar, 255, ParameterDirection.Input, url);
            sph.DefineSqlParameter("@Code", SqlDbType.NVarChar, 255, ParameterDirection.Input, code);
            sph.DefineSqlParameter("@OpenInNewWindow", SqlDbType.Bit, ParameterDirection.Input, openInNewWindow);
            sph.DefineSqlParameter("@IncludeInSearch", SqlDbType.Bit, ParameterDirection.Input, includeInSearch);
            sph.DefineSqlParameter("@IncludeInSiteMap", SqlDbType.Bit, ParameterDirection.Input, includeInSiteMap);
            sph.DefineSqlParameter("@IncludeInFeed", SqlDbType.Bit, ParameterDirection.Input, includeInFeed);
            sph.DefineSqlParameter("@BriefContent", SqlDbType.NVarChar, -1, ParameterDirection.Input, briefContent);
            sph.DefineSqlParameter("@FullContent", SqlDbType.NVarChar, -1, ParameterDirection.Input, fullContent);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@Position", SqlDbType.Int, ParameterDirection.Input, position);
            sph.DefineSqlParameter("@ShowOption", SqlDbType.Int, ParameterDirection.Input, showOption);
            sph.DefineSqlParameter("@IsPublished", SqlDbType.Bit, ParameterDirection.Input, isPublished);
            sph.DefineSqlParameter("@StartDate", SqlDbType.DateTime, ParameterDirection.Input, startDate);
            if (endDate < DateTime.MaxValue)
            {
                sph.DefineSqlParameter("@EndDate", SqlDbType.DateTime, ParameterDirection.Input, endDate);
            }
            else
            {
                sph.DefineSqlParameter("@EndDate", SqlDbType.DateTime, ParameterDirection.Input, DBNull.Value);
            }
            sph.DefineSqlParameter("@DisplayOrder", SqlDbType.Int, ParameterDirection.Input, displayOrder);
            sph.DefineSqlParameter("@Viewed", SqlDbType.Int, ParameterDirection.Input, viewed);
            sph.DefineSqlParameter("@IsDeleted", SqlDbType.Bit, ParameterDirection.Input, isDeleted);
            sph.DefineSqlParameter("@AllowCommentsForDays", SqlDbType.Int, ParameterDirection.Input, allowCommentsForDays);
            sph.DefineSqlParameter("@MetaTitle", SqlDbType.NVarChar, 255, ParameterDirection.Input, metaTitle);
            sph.DefineSqlParameter("@MetaKeywords", SqlDbType.NVarChar, 255, ParameterDirection.Input, metaKeywords);
            sph.DefineSqlParameter("@MetaDescription", SqlDbType.NVarChar, 255, ParameterDirection.Input, metaDescription);
            sph.DefineSqlParameter("@AdditionalMetaTags", SqlDbType.NVarChar, -1, ParameterDirection.Input, additionalMetaTags);
            sph.DefineSqlParameter("@CompiledMeta", SqlDbType.NVarChar, -1, ParameterDirection.Input, compiledMeta);
            sph.DefineSqlParameter("@FileAttachment", SqlDbType.NVarChar, 255, ParameterDirection.Input, fileAttachment);
            sph.DefineSqlParameter("@LastModUtc", SqlDbType.DateTime, ParameterDirection.Input, lastModUtc);
            sph.DefineSqlParameter("@LastModUserGuid", SqlDbType.UniqueIdentifier, ParameterDirection.Input, lastModUserGuid);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);
        }

        #endregion

        public static int GetCount(
            int siteId,
            int zoneId,
            DateTime currentTime,
            int languageId,
            int newsType,
            int position)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_GetCount", 6);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@ZoneID", SqlDbType.Int, ParameterDirection.Input, zoneId);
            sph.DefineSqlParameter("@CurrentTime", SqlDbType.DateTime, ParameterDirection.Input, currentTime);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@Position", SqlDbType.Int, ParameterDirection.Input, position);
            return Convert.ToInt32(sph.ExecuteScalar());
        }

        public static IDataReader GetPage(
            int siteId,
            int zoneId,
            DateTime currentTime,
            int languageId,
            int newsType,
            int position,
            int pageNumber,
            int pageSize)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectPage", 8);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@ZoneID", SqlDbType.Int, ParameterDirection.Input, zoneId);
            sph.DefineSqlParameter("@CurrentTime", SqlDbType.DateTime, ParameterDirection.Input, currentTime);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@Position", SqlDbType.Int, ParameterDirection.Input, position);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();
        }

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
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_GetCountBySearch", 14);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@ListZoneID", SqlDbType.NVarChar, 255, ParameterDirection.Input, listZoneId);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@IsPublished", SqlDbType.Int, ParameterDirection.Input, isPublished);
            sph.DefineSqlParameter("@ListStateID", SqlDbType.NVarChar, 255, ParameterDirection.Input, listStateId);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            sph.DefineSqlParameter("@Position", SqlDbType.Int, ParameterDirection.Input, position);
            sph.DefineSqlParameter("@ShowOption", SqlDbType.Int, ParameterDirection.Input, showOption);
            sph.DefineSqlParameter("@StartDateFrom", SqlDbType.DateTime, ParameterDirection.Input, startDateFrom);
            sph.DefineSqlParameter("@StartDateTo", SqlDbType.DateTime, ParameterDirection.Input, startDateTo);
            sph.DefineSqlParameter("@EndDateFrom", SqlDbType.DateTime, ParameterDirection.Input, endDateFrom);
            sph.DefineSqlParameter("@EndDateTo", SqlDbType.DateTime, ParameterDirection.Input, endDateTo);
            sph.DefineSqlParameter("@UserGuid", SqlDbType.UniqueIdentifier, ParameterDirection.Input, userGuid);
            sph.DefineSqlParameter("@Keyword", SqlDbType.NVarChar, 255, ParameterDirection.Input, keyword);
            return Convert.ToInt32(sph.ExecuteScalar());
        }

        public static IDataReader GetPageBySearch(
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
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectPageBySearch", 16);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@ListZoneID", SqlDbType.NVarChar, 255, ParameterDirection.Input, listZoneId);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@IsPublished", SqlDbType.Int, ParameterDirection.Input, isPublished);
            sph.DefineSqlParameter("@ListStateID", SqlDbType.NVarChar, 255, ParameterDirection.Input, listStateId);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            sph.DefineSqlParameter("@Position", SqlDbType.Int, ParameterDirection.Input, position);
            sph.DefineSqlParameter("@ShowOption", SqlDbType.Int, ParameterDirection.Input, showOption);
            sph.DefineSqlParameter("@StartDateFrom", SqlDbType.DateTime, ParameterDirection.Input, startDateFrom);
            sph.DefineSqlParameter("@StartDateTo", SqlDbType.DateTime, ParameterDirection.Input, startDateTo);
            sph.DefineSqlParameter("@EndDateFrom", SqlDbType.DateTime, ParameterDirection.Input, endDateFrom);
            sph.DefineSqlParameter("@EndDateTo", SqlDbType.DateTime, ParameterDirection.Input, endDateTo);
            sph.DefineSqlParameter("@UserGuid", SqlDbType.UniqueIdentifier, ParameterDirection.Input, userGuid);
            sph.DefineSqlParameter("@Keyword", SqlDbType.NVarChar, 255, ParameterDirection.Input, keyword);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();
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
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_GetCountBySearch2", 14);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@ZoneIDs", SqlDbType.NVarChar, ParameterDirection.Input, zoneIds);
            sph.DefineSqlParameter("@PublishStatus", SqlDbType.Int, ParameterDirection.Input, publishStatus);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@Position", SqlDbType.Int, ParameterDirection.Input, position);
            sph.DefineSqlParameter("@ShowOption", SqlDbType.Int, ParameterDirection.Input, showOption);
            sph.DefineSqlParameter("@NewsIDs", SqlDbType.NVarChar, ParameterDirection.Input, newsIds);
            sph.DefineSqlParameter("@ExcludeNewsIDs", SqlDbType.NVarChar, ParameterDirection.Input, excludeNewsIds);
            sph.DefineSqlParameter("@StartDate", SqlDbType.DateTime, ParameterDirection.Input, startDate);
            sph.DefineSqlParameter("@EndDate", SqlDbType.DateTime, ParameterDirection.Input, endDate);
            sph.DefineSqlParameter("@Keyword", SqlDbType.NVarChar, 255, ParameterDirection.Input, keyword);
            sph.DefineSqlParameter("@StateIDs", SqlDbType.NVarChar, ParameterDirection.Input, stateIds);
            sph.DefineSqlParameter("@UserGuid", SqlDbType.UniqueIdentifier, ParameterDirection.Input, userGuid);
            return Convert.ToInt32(sph.ExecuteScalar());
        }

        public static IDataReader GetPageBySearch2(
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
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectPageBySearch2", 17);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@ZoneIDs", SqlDbType.NVarChar, ParameterDirection.Input, zoneIds);
            sph.DefineSqlParameter("@PublishStatus", SqlDbType.Int, ParameterDirection.Input, publishStatus);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@Position", SqlDbType.Int, ParameterDirection.Input, position);
            sph.DefineSqlParameter("@ShowOption", SqlDbType.Int, ParameterDirection.Input, showOption);
            sph.DefineSqlParameter("@NewsIDs", SqlDbType.NVarChar, ParameterDirection.Input, newsIds);
            sph.DefineSqlParameter("@ExcludeNewsIDs", SqlDbType.NVarChar, ParameterDirection.Input, excludeNewsIds);
            sph.DefineSqlParameter("@StartDate", SqlDbType.DateTime, ParameterDirection.Input, startDate);
            sph.DefineSqlParameter("@EndDate", SqlDbType.DateTime, ParameterDirection.Input, endDate);
            sph.DefineSqlParameter("@Keyword", SqlDbType.NVarChar, 255, ParameterDirection.Input, keyword);
            sph.DefineSqlParameter("@StateIDs", SqlDbType.NVarChar, ParameterDirection.Input, stateIds);
            sph.DefineSqlParameter("@UserGuid", SqlDbType.UniqueIdentifier, ParameterDirection.Input, userGuid);
            sph.DefineSqlParameter("@OrderBy", SqlDbType.Int, ParameterDirection.Input, orderBy);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();
        }

        public static IDataReader GetByZone(int siteId, int zoneId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectByZone", 2);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@ZoneID", SqlDbType.Int, ParameterDirection.Input, zoneId);
            return sph.ExecuteReader();
        }

        #region NewsOther

        private static int GetCountNewsOther(int zoneId, int newsId, DateTime currentTime, int languageId, int newsType)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_GetCountNewsOther", 5);
            sph.DefineSqlParameter("@ZoneID", SqlDbType.Int, ParameterDirection.Input, zoneId);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            sph.DefineSqlParameter("@CurrentTime", SqlDbType.DateTime, ParameterDirection.Input, currentTime);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);

            return Convert.ToInt32(sph.ExecuteScalar());
        }

        public static IDataReader GetPageNewsOther(
            int zoneId,
            int newsId,
            DateTime currentTime,
            int languageId,
            int newsType,
            int pageNumber,
            int pageSize,
            out int totalPages)
        {
            totalPages = 1;
            int totalRows = GetCountNewsOther(zoneId, newsId, currentTime, languageId, newsType);

            if (pageSize > 0) totalPages = totalRows / pageSize;

            if (totalRows <= pageSize)
            {
                totalPages = 1;
            }
            else if (pageSize > 0)
            {
                int remainder;
                Math.DivRem(totalRows, pageSize, out remainder);
                if (remainder > 0)
                {
                    totalPages += 1;
                }
            }
            
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectPageNewsOther", 7);
            sph.DefineSqlParameter("@ZoneID", SqlDbType.Int, ParameterDirection.Input, zoneId);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            sph.DefineSqlParameter("@CurrentTime", SqlDbType.DateTime, ParameterDirection.Input, currentTime);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();
        }

        #endregion

        public static IDataReader GetNextPreviousNews(
            int newsId,
            int zoneId,
            int languageId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectNextPrevious", 4);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            sph.DefineSqlParameter("@ZoneID", SqlDbType.Int, ParameterDirection.Input, zoneId);
            sph.DefineSqlParameter("@CurrentTime", SqlDbType.DateTime, ParameterDirection.Input, DateTime.UtcNow);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            return sph.ExecuteReader();
        }

        public static int GetCountByListZone(
            int siteId,
            string listZoneId,
            int newsType,
            int position,
            int languageId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_GetCountByListZone", 6);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@ListZoneID", SqlDbType.NVarChar, ParameterDirection.Input, listZoneId);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@CurrentTime", SqlDbType.DateTime, ParameterDirection.Input, DateTime.UtcNow);
            sph.DefineSqlParameter("@Position", SqlDbType.Int, ParameterDirection.Input, position);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            return Convert.ToInt32(sph.ExecuteScalar());
        }

        public static IDataReader GetPageByListZone(
            int siteId,
            string listZoneId,
            int newsType,
            int position,
            int languageId,
            int pageNumber,
            int pageSize)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectPageByListZone", 8);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@ListZoneID", SqlDbType.NVarChar, ParameterDirection.Input, listZoneId);
            sph.DefineSqlParameter("@NewsType", SqlDbType.Int, ParameterDirection.Input, newsType);
            sph.DefineSqlParameter("@CurrentTime", SqlDbType.DateTime, ParameterDirection.Input, DateTime.UtcNow);
            sph.DefineSqlParameter("@Position", SqlDbType.Int, ParameterDirection.Input, position);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();
        }

        public static IDataReader GetNewsForSiteMap(int siteId, int languageId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectForSiteMap", 3);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            sph.DefineSqlParameter("@CurrentTime", SqlDbType.DateTime, ParameterDirection.Input, DateTime.UtcNow);
            return sph.ExecuteReader();
        }

        public static IDataReader GetByGuids(
           int siteId,
           string newsGuids,
           int publishStatus,
           int languageId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_News_SelectByGuids", 4);
            sph.DefineSqlParameter("@SiteID", SqlDbType.Int, ParameterDirection.Input, siteId);
            sph.DefineSqlParameter("@NewsGuids", SqlDbType.NVarChar, ParameterDirection.Input, newsGuids);
            sph.DefineSqlParameter("@PublishStatus", SqlDbType.Int, ParameterDirection.Input, publishStatus);
            sph.DefineSqlParameter("@LanguageID", SqlDbType.Int, ParameterDirection.Input, languageId);
            return sph.ExecuteReader();
        }

        public static bool UpdateState(int newsId, int? stateId, DateTime? approvedUtc, Guid? approvedUserGuid, string approvedBy, string rejectedNotes)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_News_UpdateState", 6);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            sph.DefineSqlParameter("@StateID", SqlDbType.Int, ParameterDirection.Input, stateId);
            sph.DefineSqlParameter("@ApprovedUtc", SqlDbType.DateTime, ParameterDirection.Input, approvedUtc);
            sph.DefineSqlParameter("@ApprovedUserGuid", SqlDbType.UniqueIdentifier, ParameterDirection.Input, approvedUserGuid);
            sph.DefineSqlParameter("@ApprovedBy", SqlDbType.NVarChar, 100, ParameterDirection.Input, approvedBy);
            sph.DefineSqlParameter("@RejectedNotes", SqlDbType.NVarChar, ParameterDirection.Input, rejectedNotes);

            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > -1);
        }

        public static bool UpdateDeleted(int newsId, bool isDeleted)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_News_UpdateDeleted", 2);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            sph.DefineSqlParameter("@IsDeleted", SqlDbType.Bit, ParameterDirection.Input, isDeleted);

            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > -1);
        }

        public static bool IncrementViewedCount(int newsId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_News_IncrementViewedCount", 1);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);

            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > -1);
        }

        //public static bool UpdateViewedCount(int newsId, int viewedCount)
        //{
        //    StringBuilder sqlCommand = new StringBuilder();
        //    // TODO: use stored proc

        //    sqlCommand.Append("UPDATE gb_News SET Viewed = @ViewedCount ");
        //    sqlCommand.Append("WHERE NewsID = @NewsID  ");

        //    SqlParameterHelper sph = new SqlParameterHelper(
        //        ConnectionString.GetWriteConnectionString(),
        //        sqlCommand.ToString(),
        //        CommandType.Text, 2);

        //    sph.DefineSqlParameter("@ViewedCount", SqlDbType.Int, ParameterDirection.Input, viewedCount);
        //    sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
        //    int rowsAffected = sph.ExecuteNonQuery();
        //    return (rowsAffected > 0);
        //}

        public static bool UpdateZone(int newsId, int zoneId)
        {

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_News_UpdateZone", 2);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            sph.DefineSqlParameter("@ZoneID", SqlDbType.Int, ParameterDirection.Input, zoneId);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);
        }

        #region Comment

        public static bool UpdateCommentCount(Guid newsGuid, int commentCount)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_News_UpdateCommentCount", 2);
            sph.DefineSqlParameter("@NewsGuid", SqlDbType.UniqueIdentifier, ParameterDirection.Input, newsGuid);
            sph.DefineSqlParameter("@CommentCount", SqlDbType.Int, ParameterDirection.Input, commentCount);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > -1);
        }

        public static bool AddNewsComment(
          int newsId,
          string name,
          string title,
          string url,
          string comment,
          string address,
          string email,
          string phone,
          string attachFile1,
          string attachFile2,
          DateTime createdDate)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_NewsComment_Insert", 11);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            sph.DefineSqlParameter("@Name", SqlDbType.NVarChar, 255, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@Title", SqlDbType.NVarChar, 255, ParameterDirection.Input, title);
            sph.DefineSqlParameter("@URL", SqlDbType.NVarChar, 255, ParameterDirection.Input, url);
            sph.DefineSqlParameter("@Comment", SqlDbType.NVarChar, -1, ParameterDirection.Input, comment);
            sph.DefineSqlParameter("@Address", SqlDbType.NVarChar, 255, ParameterDirection.Input, address);
            sph.DefineSqlParameter("@Email", SqlDbType.NVarChar, 255, ParameterDirection.Input, email);
            sph.DefineSqlParameter("@Phone", SqlDbType.NVarChar, 255, ParameterDirection.Input, phone);
            sph.DefineSqlParameter("@AttachFile1", SqlDbType.NVarChar, 255, ParameterDirection.Input, attachFile1);
            sph.DefineSqlParameter("@AttachFile2", SqlDbType.NVarChar, 255, ParameterDirection.Input, attachFile2);
            sph.DefineSqlParameter("@CreatedDate", SqlDbType.DateTime, ParameterDirection.Input, createdDate);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);
        }

        public static bool DeleteAllCommentsForNews(int newsId)
        {
            StringBuilder sqlCommand = new StringBuilder();
            // TODO: use stored proc

            sqlCommand.Append("DELETE FROM gb_NewsComments  ");
            sqlCommand.Append("WHERE NewsID = @NewsID  ");

            SqlParameterHelper sph = new SqlParameterHelper(
                ConnectionString.GetWriteConnectionString(),
                sqlCommand.ToString(),
                CommandType.Text, 1);

            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);
        }

        public static bool DeleteNewsComment(int commentId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_NewsComment_Delete", 1);
            sph.DefineSqlParameter("@NewsCommentID", SqlDbType.Int, ParameterDirection.Input, commentId);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > -1);
        }

        public static IDataReader GetNewsComments(int newsId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_NewsComment_Select", 1);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            return sph.ExecuteReader();
        }

        public static int GetCountNewsComment(int newsId)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_NewsComment_GetCount", 1);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            return Convert.ToInt32(sph.ExecuteScalar());
        }

        public static IDataReader GetPageNewsComments(
            int newsId,
            int pageNumber,
            int pageSize,
            out int totalPages)
        {
            totalPages = 1;
            int totalRows = GetCountNewsComment(newsId);

            if (pageSize > 0) totalPages = totalRows / pageSize;

            if (totalRows <= pageSize)
            {
                totalPages = 1;
            }
            else
            {
                int remainder;
                Math.DivRem(totalRows, pageSize, out remainder);
                if (remainder > 0)
                {
                    totalPages += 1;
                }
            }

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_NewsComment_SelectPage", 3);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsId);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();
        }

        #endregion

    }
}