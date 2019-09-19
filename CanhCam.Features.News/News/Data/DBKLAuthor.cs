// Author:					Ngo ba khanh
// Created:					2017-7-25
// Last Modified:			2017-7-25

using System;
using System.Data;

namespace CanhCam.Data
{

    public static class DBKLAuthor
    {

        /// <summary>
        /// Inserts a row in the gb_KLAuthor table. Returns new integer id.
        /// </summary>
        /// <param name="userID"> userID </param>
        /// <param name="name"> name </param>
        /// <param name="avatar"> avatar </param>
        /// <param name="levelAuthor"> levelAuthor </param>
        /// <param name="linkFacebook"> linkFacebook </param>
        /// <param name="linkTwitter"> linkTwitter </param>
        /// <param name="linkPinterest"> linkPinterest </param>
        /// <param name="linkInstagram"> linkInstagram </param>
        /// <param name="joinDate"> joinDate </param>
        /// <param name="articleCount"> articleCount </param>
        /// <param name="isDel"> isDel </param>
        /// <param name="isActive"> isActive </param>
        /// <returns>int</returns>
        public static int Create(
            int userID,
            string name,
            string avatar,
            string levelAuthor,
            string linkFacebook,
            string linkTwitter,
            string linkPinterest,
            string linkInstagram,
            DateTime joinDate,
            int articleCount,
            bool isDel,
            bool isActive)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLAuthor_Insert", 12);
            sph.DefineSqlParameter("@UserID", SqlDbType.Int, ParameterDirection.Input, userID);
            sph.DefineSqlParameter("@Name", SqlDbType.NVarChar, 100, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@Avatar", SqlDbType.NVarChar, 255, ParameterDirection.Input, avatar);
            sph.DefineSqlParameter("@LevelAuthor", SqlDbType.NVarChar, 100, ParameterDirection.Input, levelAuthor);
            sph.DefineSqlParameter("@LinkFacebook", SqlDbType.NVarChar, 100, ParameterDirection.Input, linkFacebook);
            sph.DefineSqlParameter("@LinkTwitter", SqlDbType.NVarChar, 100, ParameterDirection.Input, linkTwitter);
            sph.DefineSqlParameter("@LinkPinterest", SqlDbType.NVarChar, 100, ParameterDirection.Input, linkPinterest);
            sph.DefineSqlParameter("@LinkInstagram", SqlDbType.NVarChar, 100, ParameterDirection.Input, linkInstagram);
            sph.DefineSqlParameter("@JoinDate", SqlDbType.DateTime, ParameterDirection.Input, joinDate);
            sph.DefineSqlParameter("@ArticleCount", SqlDbType.Int, ParameterDirection.Input, articleCount);
            sph.DefineSqlParameter("@IsDel", SqlDbType.Bit, ParameterDirection.Input, isDel);
            sph.DefineSqlParameter("@IsActive", SqlDbType.Bit, ParameterDirection.Input, isActive);
            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }


        /// <summary>
        /// Updates a row in the gb_KLAuthor table. Returns true if row updated.
        /// </summary>
        /// <param name="authorID"> authorID </param>
        /// <param name="userID"> userID </param>
        /// <param name="name"> name </param>
        /// <param name="avatar"> avatar </param>
        /// <param name="levelAuthor"> levelAuthor </param>
        /// <param name="linkFacebook"> linkFacebook </param>
        /// <param name="linkTwitter"> linkTwitter </param>
        /// <param name="linkPinterest"> linkPinterest </param>
        /// <param name="linkInstagram"> linkInstagram </param>
        /// <param name="joinDate"> joinDate </param>
        /// <param name="articleCount"> articleCount </param>
        /// <param name="isDel"> isDel </param>
        /// <param name="isActive"> isActive </param>
        /// <returns>bool</returns>
        public static bool Update(
            int authorID,
            int userID,
            string name,
            string avatar,
            string levelAuthor,
            string linkFacebook,
            string linkTwitter,
            string linkPinterest,
            string linkInstagram,
            DateTime joinDate,
            int articleCount,
            bool isDel,
            bool isActive)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLAuthor_Update", 13);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@UserID", SqlDbType.Int, ParameterDirection.Input, userID);
            sph.DefineSqlParameter("@Name", SqlDbType.NVarChar, 100, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@Avatar", SqlDbType.NVarChar, 255, ParameterDirection.Input, avatar);
            sph.DefineSqlParameter("@LevelAuthor", SqlDbType.NVarChar, 100, ParameterDirection.Input, levelAuthor);
            sph.DefineSqlParameter("@LinkFacebook", SqlDbType.NVarChar, 100, ParameterDirection.Input, linkFacebook);
            sph.DefineSqlParameter("@LinkTwitter", SqlDbType.NVarChar, 100, ParameterDirection.Input, linkTwitter);
            sph.DefineSqlParameter("@LinkPinterest", SqlDbType.NVarChar, 100, ParameterDirection.Input, linkPinterest);
            sph.DefineSqlParameter("@LinkInstagram", SqlDbType.NVarChar, 100, ParameterDirection.Input, linkInstagram);
            sph.DefineSqlParameter("@JoinDate", SqlDbType.DateTime, ParameterDirection.Input, joinDate);
            sph.DefineSqlParameter("@ArticleCount", SqlDbType.Int, ParameterDirection.Input, articleCount);
            sph.DefineSqlParameter("@IsDel", SqlDbType.Bit, ParameterDirection.Input, isDel);
            sph.DefineSqlParameter("@IsActive", SqlDbType.Bit, ParameterDirection.Input, isActive);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Deletes a row from the gb_KLAuthor table. Returns true if row deleted.
        /// </summary>
        /// <param name="authorID"> authorID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int authorID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLAuthor_Delete", 1);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Gets an IDataReader with one row from the gb_KLAuthor table.
        /// </summary>
        /// <param name="authorID"> authorID </param>
        public static IDataReader GetOne(
            int authorID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLAuthor_SelectOne", 1);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            return sph.ExecuteReader();

        }

        /// <summary>
        /// Gets a count of rows in the gb_KLAuthor table.
        /// </summary>
        public static int GetCount()
        {

            return Convert.ToInt32(SqlHelper.ExecuteScalar(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLAuthor_GetCount",
                null));

        }

        /// <summary>
        /// Gets an IDataReader with all rows in the gb_KLAuthor table.
        /// </summary>
        public static IDataReader GetAll()
        {

            return SqlHelper.ExecuteReader(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLAuthor_SelectAll",
                null);

        }

        /// <summary>
        /// Gets a page of data from the gb_KLAuthor table.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static IDataReader GetPage(
            int pageNumber,
            int pageSize,
            out int totalPages)
        {
            totalPages = 1;
            int totalRows
                = GetCount();

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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLAuthor_SelectPage", 2);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();

        }

    }

}
