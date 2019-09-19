// Author:					Ngo ba khanh
// Created:					2017-8-2
// Last Modified:			2017-8-2

using System;
using System.Data;

namespace CanhCam.Data
{

    public static class DBKLViewHistory
    {

        /// <summary>
        /// Inserts a row in the gb_KLViewHistory table. Returns new integer id.
        /// </summary>
        /// <param name="newsID"> newsID </param>
        /// <param name="viewDate"> viewDate </param>
        /// <param name="viewCount"> viewCount </param>
        /// <returns>int</returns>
        public static int Create(
            int newsID,
            DateTime viewDate,
            DateTime fromdate,
            DateTime todate)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLViewHistory_Insert", 3);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsID);
            sph.DefineSqlParameter("@ViewDate", SqlDbType.DateTime, ParameterDirection.Input, viewDate);
            sph.DefineSqlParameter("@FromDate", SqlDbType.DateTime, ParameterDirection.Input, fromdate);
            sph.DefineSqlParameter("@ToDate", SqlDbType.DateTime, ParameterDirection.Input, todate);
            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }


        /// <summary>
        /// Updates a row in the gb_KLViewHistory table. Returns true if row updated.
        /// </summary>
        /// <param name="id"> id </param>
        /// <param name="newsID"> newsID </param>
        /// <param name="viewDate"> viewDate </param>
        /// <param name="viewCount"> viewCount </param>
        /// <returns>bool</returns>
        public static bool Update(
            int id,
            int newsID,
            DateTime viewDate,
            int viewCount)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLViewHistory_Update", 4);
            sph.DefineSqlParameter("@ID", SqlDbType.Int, ParameterDirection.Input, id);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsID);
            sph.DefineSqlParameter("@ViewDate", SqlDbType.DateTime, ParameterDirection.Input, viewDate);
            sph.DefineSqlParameter("@ViewCount", SqlDbType.Int, ParameterDirection.Input, viewCount);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Deletes a row from the gb_KLViewHistory table. Returns true if row deleted.
        /// </summary>
        /// <param name="id"> id </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int id)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLViewHistory_Delete", 1);
            sph.DefineSqlParameter("@ID", SqlDbType.Int, ParameterDirection.Input, id);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Gets an IDataReader with one row from the gb_KLViewHistory table.
        /// </summary>
        /// <param name="id"> id </param>
        public static IDataReader GetOne(
            int id)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLViewHistory_SelectOne", 1);
            sph.DefineSqlParameter("@ID", SqlDbType.Int, ParameterDirection.Input, id);
            return sph.ExecuteReader();

        }

        /// <summary>
        /// Gets a count of rows in the gb_KLViewHistory table.
        /// </summary>
        public static int GetCount()
        {

            return Convert.ToInt32(SqlHelper.ExecuteScalar(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLViewHistory_GetCount",
                null));

        }

        /// <summary>
        /// Gets an IDataReader with all rows in the gb_KLViewHistory table.
        /// </summary>
        public static IDataReader GetTop6(
            DateTime fromdate,
            DateTime todate)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLViewHistory_SelectAll", 2);
            sph.DefineSqlParameter("@FromDate", SqlDbType.DateTime, ParameterDirection.Input, fromdate);
            sph.DefineSqlParameter("@ToDate", SqlDbType.DateTime, ParameterDirection.Input, todate);
            return sph.ExecuteReader();
        }

        /// <summary>
        /// Gets a page of data from the gb_KLViewHistory table.
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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLViewHistory_SelectPage", 2);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();

        }

    }

}

