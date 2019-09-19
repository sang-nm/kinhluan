using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Data
{
    public class DBKLNews
    {
        public static IDataReader GetOnebyNewID(
           int NewID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNews_SelectOneByNewID", 1);
            sph.DefineSqlParameter("@NewID", SqlDbType.Int, ParameterDirection.Input, NewID);
            return sph.ExecuteReader();

        }
        /// <summary>
        /// Inserts a row in the gb_KLNews table. Returns new integer id.
        /// </summary>
        /// <param name="newsID"> newsID </param>
        /// <param name="authorID"> authorID </param>
        /// <param name="viewCount"> viewCount </param>
        /// <param name="shareCount"> shareCount </param>
        /// <param name="commentCount"> commentCount </param>
        /// <param name="likeCount"> likeCount </param>
        /// <param name="approvedBy"> approvedBy </param>
        /// <param name="newType"> newType </param>
        /// <param name="newlsevel"> newlsevel </param>
        /// <param name="newstotalpoint"> newstotalpoint </param>
        /// <param name="isdraft"> isdraft </param>
        /// <param name="isapproved"> isapproved </param>
        /// <returns>int</returns>
        public static int Create(
            int newsID,
            int authorID,
            int viewCount,
            int shareCount,
            int commentCount,
            int likeCount,
            string approvedBy,
            int newType,
            int newlsevel,
            int newstotalpoint,
            bool isdraft,
            bool isapproved)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNews_Insert", 12);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsID);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@ViewCount", SqlDbType.Int, ParameterDirection.Input, viewCount);
            sph.DefineSqlParameter("@ShareCount", SqlDbType.Int, ParameterDirection.Input, shareCount);
            sph.DefineSqlParameter("@CommentCount", SqlDbType.Int, ParameterDirection.Input, commentCount);
            sph.DefineSqlParameter("@LikeCount", SqlDbType.Int, ParameterDirection.Input, likeCount);
            sph.DefineSqlParameter("@ApprovedBy", SqlDbType.NVarChar, 100, ParameterDirection.Input, approvedBy);
            sph.DefineSqlParameter("@NewType", SqlDbType.Int, ParameterDirection.Input, newType);
            sph.DefineSqlParameter("@Newlsevel", SqlDbType.Int, ParameterDirection.Input, newlsevel);
            sph.DefineSqlParameter("@Newstotalpoint", SqlDbType.Int, ParameterDirection.Input, newstotalpoint);
            sph.DefineSqlParameter("@Isdraft", SqlDbType.Bit, ParameterDirection.Input, isdraft);
            sph.DefineSqlParameter("@Isapproved", SqlDbType.Bit, ParameterDirection.Input, isapproved);
            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }


        /// <summary>
        /// Updates a row in the gb_KLNews table. Returns true if row updated.
        /// </summary>
        /// <param name="kLNewID"> kLNewID </param>
        /// <param name="newsID"> newsID </param>
        /// <param name="authorID"> authorID </param>
        /// <param name="viewCount"> viewCount </param>
        /// <param name="shareCount"> shareCount </param>
        /// <param name="commentCount"> commentCount </param>
        /// <param name="likeCount"> likeCount </param>
        /// <param name="approvedBy"> approvedBy </param>
        /// <param name="newType"> newType </param>
        /// <param name="newlsevel"> newlsevel </param>
        /// <param name="newstotalpoint"> newstotalpoint </param>
        /// <param name="isdraft"> isdraft </param>
        /// <param name="isapproved"> isapproved </param>
        /// <returns>bool</returns>
        public static bool Update(
            int kLNewID,
            int newsID,
            int authorID,
            int viewCount,
            int shareCount,
            int commentCount,
            int likeCount,
            string approvedBy,
            int newType,
            int newlsevel,
            int newstotalpoint,
            bool isdraft,
            bool isapproved)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNews_Update", 13);
            sph.DefineSqlParameter("@KLNewID", SqlDbType.Int, ParameterDirection.Input, kLNewID);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsID);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@ViewCount", SqlDbType.Int, ParameterDirection.Input, viewCount);
            sph.DefineSqlParameter("@ShareCount", SqlDbType.Int, ParameterDirection.Input, shareCount);
            sph.DefineSqlParameter("@CommentCount", SqlDbType.Int, ParameterDirection.Input, commentCount);
            sph.DefineSqlParameter("@LikeCount", SqlDbType.Int, ParameterDirection.Input, likeCount);
            sph.DefineSqlParameter("@ApprovedBy", SqlDbType.NVarChar, 100, ParameterDirection.Input, approvedBy);
            sph.DefineSqlParameter("@NewType", SqlDbType.Int, ParameterDirection.Input, newType);
            sph.DefineSqlParameter("@Newlsevel", SqlDbType.Int, ParameterDirection.Input, newlsevel);
            sph.DefineSqlParameter("@Newstotalpoint", SqlDbType.Int, ParameterDirection.Input, newstotalpoint);
            sph.DefineSqlParameter("@Isdraft", SqlDbType.Bit, ParameterDirection.Input, isdraft);
            sph.DefineSqlParameter("@Isapproved", SqlDbType.Bit, ParameterDirection.Input, isapproved);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Deletes a row from the gb_KLNews table. Returns true if row deleted.
        /// </summary>
        /// <param name="kLNewID"> kLNewID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int kLNewID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNews_Delete", 1);
            sph.DefineSqlParameter("@KLNewID", SqlDbType.Int, ParameterDirection.Input, kLNewID);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Gets an IDataReader with one row from the gb_KLNews table.
        /// </summary>
        /// <param name="kLNewID"> kLNewID </param>
        public static IDataReader GetOne(
            int kLNewID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNews_SelectOne", 1);
            sph.DefineSqlParameter("@KLNewID", SqlDbType.Int, ParameterDirection.Input, kLNewID);
            return sph.ExecuteReader();

        }

        /// <summary>
        /// Gets a count of rows in the gb_KLNews table.
        /// </summary>
        public static int GetCount()
        {

            return Convert.ToInt32(SqlHelper.ExecuteScalar(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLNews_GetCount",
                null));

        }

        /// <summary>
        /// Gets an IDataReader with all rows in the gb_KLNews table.
        /// </summary>
        public static IDataReader GetAll()
        {

            return SqlHelper.ExecuteReader(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLNews_SelectAll",
                null);

        }

        /// <summary>
        /// Gets a page of data from the gb_KLNews table.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        /// 

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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNews_SelectPage", 2);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();

        }

        public static int GetCountByAuthor(int authorid)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNews_GetCountByAuthorId", 1);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, authorid);
            return Convert.ToInt32(sph.ExecuteScalar());
        }

        public static IDataReader GetPageByAuthor(
           int pageNumber,
           int pageSize,
           out int totalPages,int AuthorID,string keyword,bool isdraft,bool isapoproved,bool all)
        {
            totalPages = 1;
            int totalRows
                = GetCountByAuthor(AuthorID);

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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNews_SelectPageByAuthorID", 7);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            sph.DefineSqlParameter("@Authorid", SqlDbType.Int, ParameterDirection.Input, AuthorID);
            sph.DefineSqlParameter("@Keyword", SqlDbType.NVarChar,100, ParameterDirection.Input, keyword);
            sph.DefineSqlParameter("@all", SqlDbType.Bit, ParameterDirection.Input, all);
            sph.DefineSqlParameter("@Isapproved", SqlDbType.Bit, ParameterDirection.Input, isapoproved);
            sph.DefineSqlParameter("@Isdraft", SqlDbType.Bit, ParameterDirection.Input, isdraft);
            return sph.ExecuteReader();

        }


    }
}