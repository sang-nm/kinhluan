using CanhCam.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Data
{
    public class DBKLFowllowAuthor
    {

        /// <summary>
        /// Inserts a row in the gb_KLFowllowAuthor table. Returns new integer id.
        /// </summary>
        /// <param name="userID"> userID </param>
        /// <param name="authorID"> authorID </param>
        /// <param name="dateStartFollow"> dateStartFollow </param>
        /// <returns>int</returns>
        public static int Create(
            int userID,
            int authorID,
            DateTime dateStartFollow)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLFowllowAuthor_Insert", 3);
            sph.DefineSqlParameter("@UserID", SqlDbType.Int, ParameterDirection.Input, userID);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@DateStartFollow", SqlDbType.DateTime, ParameterDirection.Input, dateStartFollow);
            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }


        /// <summary>
        /// Updates a row in the gb_KLFowllowAuthor table. Returns true if row updated.
        /// </summary>
        /// <param name="followID"> followID </param>
        /// <param name="userID"> userID </param>
        /// <param name="authorID"> authorID </param>
        /// <param name="dateStartFollow"> dateStartFollow </param>
        /// <returns>bool</returns>
        public static bool Update(
            int followID,
            int userID,
            int authorID,
            DateTime dateStartFollow)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLFowllowAuthor_Update", 4);
            sph.DefineSqlParameter("@FollowID", SqlDbType.Int, ParameterDirection.Input, followID);
            sph.DefineSqlParameter("@UserID", SqlDbType.Int, ParameterDirection.Input, userID);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@DateStartFollow", SqlDbType.DateTime, ParameterDirection.Input, dateStartFollow);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Deletes a row from the gb_KLFowllowAuthor table. Returns true if row deleted.
        /// </summary>
        /// <param name="followID"> followID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int followID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLFowllowAuthor_Delete", 1);
            sph.DefineSqlParameter("@FollowID", SqlDbType.Int, ParameterDirection.Input, followID);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Gets an IDataReader with one row from the gb_KLFowllowAuthor table.
        /// </summary>
        /// <param name="followID"> followID </param>
        public static IDataReader GetOne(
            int followID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLFowllowAuthor_SelectOne", 1);
            sph.DefineSqlParameter("@FollowID", SqlDbType.Int, ParameterDirection.Input, followID);
            return sph.ExecuteReader();

        }

        /// <summary>
        /// Gets a count of rows in the gb_KLFowllowAuthor table.
        /// </summary>
        public static int GetCount()
        {

            return Convert.ToInt32(SqlHelper.ExecuteScalar(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLFowllowAuthor_GetCount",
                null));

        }

        /// <summary>
        /// Gets an IDataReader with all rows in the gb_KLFowllowAuthor table.
        /// </summary>
        public static IDataReader GetAll()
        {

            return SqlHelper.ExecuteReader(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLFowllowAuthor_SelectAll",
                null);

        }

        /// <summary>
        /// Gets a page of data from the gb_KLFowllowAuthor table.
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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLFowllowAuthor_SelectPage", 2);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();

        }


        public static IDataReader GetPageByAuthor(
            int pageNumber,
            int pageSize,
            out int totalPages,int authorid)
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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLFowllowAuthor_SelectPageForAuthorID", 3);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            sph.DefineSqlParameter("@Authorid", SqlDbType.Int, ParameterDirection.Input, authorid);
            return sph.ExecuteReader();

        }

    }
}