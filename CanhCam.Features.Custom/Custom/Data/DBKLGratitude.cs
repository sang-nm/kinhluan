using System;
using System.Data;

namespace CanhCam.Data
{

    public static class DBKLGratitude
    {

        /// <summary>
        /// Inserts a row in the gb_KLGratitude table. Returns new integer id.
        /// </summary>
        /// <param name="name"> name </param>
        /// <param name="avatar"> avatar </param>
        /// <param name="createUtc"> createUtc </param>
        /// <param name="comment"> comment </param>
        /// <returns>int</returns>
        public static int Create(
            string name,
            string avatar,
            int authorID,
            DateTime createUtc,
            string comment)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLGratitude_Insert", 5);
            sph.DefineSqlParameter("@Name", SqlDbType.NChar, 10, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@Avatar", SqlDbType.NVarChar, 255, ParameterDirection.Input, avatar);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@CreateUtc", SqlDbType.DateTime, ParameterDirection.Input, createUtc);
            sph.DefineSqlParameter("@Comment", SqlDbType.NVarChar, -1, ParameterDirection.Input, comment);
            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }


        /// <summary>
        /// Updates a row in the gb_KLGratitude table. Returns true if row updated.
        /// </summary>
        /// <param name="guestID"> guestID </param>
        /// <param name="name"> name </param>
        /// <param name="avatar"> avatar </param>
        /// <param name="authorID"> authorID </param>
        /// <param name="createUtc"> createUtc </param>
        /// <param name="comment"> comment </param>
        /// <returns>bool</returns>
        public static bool Update(
            int guestID,
            string name,
            string avatar,
            int authorID,
            DateTime createUtc,
            string comment)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLGratitude_Update", 6);
            sph.DefineSqlParameter("@GuestID", SqlDbType.Int, ParameterDirection.Input, guestID);
            sph.DefineSqlParameter("@Name", SqlDbType.NChar, 10, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@Avatar", SqlDbType.NVarChar, 255, ParameterDirection.Input, avatar);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@CreateUtc", SqlDbType.DateTime, ParameterDirection.Input, createUtc);
            sph.DefineSqlParameter("@Comment", SqlDbType.NVarChar, -1, ParameterDirection.Input, comment);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Deletes a row from the gb_KLGratitude table. Returns true if row deleted.
        /// </summary>
        /// <param name="guestID"> guestID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int guestID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLGratitude_Delete", 1);
            sph.DefineSqlParameter("@GuestID", SqlDbType.Int, ParameterDirection.Input, guestID);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Gets an IDataReader with one row from the gb_KLGratitude table.
        /// </summary>
        /// <param name="guestID"> guestID </param>
        public static IDataReader GetOne(
            int guestID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLGratitude_SelectOne", 1);
            sph.DefineSqlParameter("@GuestID", SqlDbType.Int, ParameterDirection.Input, guestID);
            return sph.ExecuteReader();

        }

        /// <summary>
        /// Gets a count of rows in the gb_KLGratitude table.
        /// </summary>
        public static int GetCount()
        {

            return Convert.ToInt32(SqlHelper.ExecuteScalar(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLGratitude_GetCount",
                null));

        }

        /// <summary>
        /// Gets an IDataReader with all rows in the gb_KLGratitude table.
        /// </summary>
        public static IDataReader GetAll()
        {

            return SqlHelper.ExecuteReader(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLGratitude_SelectAll",
                null);

        }

        /// <summary>
        /// Gets a page of data from the gb_KLGratitude table.
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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLGratitude_SelectPage", 2);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();

        }

    }

}
