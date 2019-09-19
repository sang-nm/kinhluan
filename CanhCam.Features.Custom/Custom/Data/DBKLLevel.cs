// Author:					Ngo ba khanh
// Created:					2017-7-25
// Last Modified:			2017-7-25

using System;
using System.Data;

namespace CanhCam.Data
{

    public static class DBKLLevel
    {

        /// <summary>
        /// Inserts a row in the gb_KLLevel table. Returns new integer id.
        /// </summary>
        /// <param name="name"> name </param>
        /// <param name="from"> from </param>
        /// <param name="to"> to </param>
        /// <returns>int</returns>
        public static int Create(
            string name,
            int from,
            string to)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLLevel_Insert", 3);
            sph.DefineSqlParameter("@Name", SqlDbType.NVarChar, 50, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@From", SqlDbType.Int, ParameterDirection.Input, from);
            sph.DefineSqlParameter("@To", SqlDbType.NChar, 10, ParameterDirection.Input, to);
            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }


        /// <summary>
        /// Updates a row in the gb_KLLevel table. Returns true if row updated.
        /// </summary>
        /// <param name="levelID"> levelID </param>
        /// <param name="name"> name </param>
        /// <param name="from"> from </param>
        /// <param name="to"> to </param>
        /// <returns>bool</returns>
        public static bool Update(
            int levelID,
            string name,
            int from,
            string to)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLLevel_Update", 4);
            sph.DefineSqlParameter("@LevelID", SqlDbType.Int, ParameterDirection.Input, levelID);
            sph.DefineSqlParameter("@Name", SqlDbType.NVarChar, 50, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@From", SqlDbType.Int, ParameterDirection.Input, from);
            sph.DefineSqlParameter("@To", SqlDbType.NChar, 10, ParameterDirection.Input, to);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Deletes a row from the gb_KLLevel table. Returns true if row deleted.
        /// </summary>
        /// <param name="levelID"> levelID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int levelID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLLevel_Delete", 1);
            sph.DefineSqlParameter("@LevelID", SqlDbType.Int, ParameterDirection.Input, levelID);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Gets an IDataReader with one row from the gb_KLLevel table.
        /// </summary>
        /// <param name="levelID"> levelID </param>
        public static IDataReader GetOne(
            int levelID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLLevel_SelectOne", 1);
            sph.DefineSqlParameter("@LevelID", SqlDbType.Int, ParameterDirection.Input, levelID);
            return sph.ExecuteReader();

        }

        /// <summary>
        /// Gets a count of rows in the gb_KLLevel table.
        /// </summary>
        public static int GetCount()
        {

            return Convert.ToInt32(SqlHelper.ExecuteScalar(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLLevel_GetCount",
                null));

        }

        /// <summary>
        /// Gets an IDataReader with all rows in the gb_KLLevel table.
        /// </summary>
        public static IDataReader GetAll()
        {

            return SqlHelper.ExecuteReader(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLLevel_SelectAll",
                null);

        }

        /// <summary>
        /// Gets a page of data from the gb_KLLevel table.
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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLLevel_SelectPage", 2);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();

        }

    }

}
