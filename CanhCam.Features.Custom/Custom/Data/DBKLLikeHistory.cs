// Author:					Tran Quoc Vuong
// Created:					2017-8-11
// Last Modified:			2017-8-11

using System;
using System.Data;

namespace CanhCam.Data.Tri
{

    public static class DBKLLikeHistory
    {

        /// <summary>
        /// Inserts a row in the gb_KLLikeHistory table. Returns new integer id.
        /// </summary>
        /// <param name="authorID"> authorID </param>
        /// <param name="newsID"> newsID </param>
        /// <param name="createDate"> createDate </param>
        /// <returns>int</returns>
        public static int Create(
            int authorID,
            int newsID,
            DateTime createDate)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLLikeHistory_Insert", 3);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsID);
            sph.DefineSqlParameter("@CreateDate", SqlDbType.DateTime, ParameterDirection.Input, createDate);
            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }


        /// <summary>
        /// Updates a row in the gb_KLLikeHistory table. Returns true if row updated.
        /// </summary>
        /// <param name="likeID"> likeID </param>
        /// <param name="authorID"> authorID </param>
        /// <param name="newsID"> newsID </param>
        /// <param name="createDate"> createDate </param>
        /// <returns>bool</returns>
        public static bool Update(
            int likeID,
            int authorID,
            int newsID,
            DateTime createDate)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLLikeHistory_Update", 4);
            sph.DefineSqlParameter("@LikeID", SqlDbType.Int, ParameterDirection.Input, likeID);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsID);
            sph.DefineSqlParameter("@CreateDate", SqlDbType.DateTime, ParameterDirection.Input, createDate);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Deletes a row from the gb_KLLikeHistory table. Returns true if row deleted.
        /// </summary>
        /// <param name="likeID"> likeID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int likeID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLLikeHistory_Delete", 1);
            sph.DefineSqlParameter("@LikeID", SqlDbType.Int, ParameterDirection.Input, likeID);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Gets an IDataReader with one row from the gb_KLLikeHistory table.
        /// </summary>
        /// <param name="likeID"> likeID </param>
        public static IDataReader GetOne(
            int likeID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLLikeHistory_SelectOne", 1);
            sph.DefineSqlParameter("@LikeID", SqlDbType.Int, ParameterDirection.Input, likeID);
            return sph.ExecuteReader();

        }

        /// <summary>
        /// Gets a count of rows in the gb_KLLikeHistory table.
        /// </summary>
        public static int GetCount()
        {

            return Convert.ToInt32(SqlHelper.ExecuteScalar(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLLikeHistory_GetCount",
                null));

        }

        /// <summary>
        /// Gets an IDataReader with all rows in the gb_KLLikeHistory table.
        /// </summary>
        public static IDataReader GetAll()
        {

            return SqlHelper.ExecuteReader(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLLikeHistory_SelectAll",
                null);

        }

        /// <summary>
        /// Gets a page of data from the gb_KLLikeHistory table.
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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLLikeHistory_SelectPage", 2);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();

        }

    }

}
