using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Data
{
    public class DBKLNewsType
    {

        /// <summary>
        /// Inserts a row in the gb_KLNewType table. Returns new integer id.
        /// </summary>
        /// <param name="name"> name </param>
        /// <param name="url"> url </param>
        /// <param name="parentID"> parentID </param>
        /// <param name="isDelected"> isDelected </param>
        /// <returns>int</returns>
        public static int Create(
            string name,
            string url,
            int parentID,
            bool isDelected)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNewType_Insert", 4);
            sph.DefineSqlParameter("@Name", SqlDbType.NVarChar, 100, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@Url", SqlDbType.NVarChar, 100, ParameterDirection.Input, url);
            sph.DefineSqlParameter("@ParentID", SqlDbType.Int, ParameterDirection.Input, parentID);
            sph.DefineSqlParameter("@IsDelected", SqlDbType.Bit, ParameterDirection.Input, isDelected);
            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }


        /// <summary>
        /// Updates a row in the gb_KLNewType table. Returns true if row updated.
        /// </summary>
        /// <param name="newsTypeID"> newsTypeID </param>
        /// <param name="name"> name </param>
        /// <param name="url"> url </param>
        /// <param name="parentID"> parentID </param>
        /// <param name="isDelected"> isDelected </param>
        /// <returns>bool</returns>
        public static bool Update(
            int newsTypeID,
            string name,
            string url,
            int parentID,
            bool isDelected)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNewType_Update", 5);
            sph.DefineSqlParameter("@NewsTypeID", SqlDbType.Int, ParameterDirection.Input, newsTypeID);
            sph.DefineSqlParameter("@Name", SqlDbType.NVarChar, 100, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@Url", SqlDbType.NVarChar, 100, ParameterDirection.Input, url);
            sph.DefineSqlParameter("@ParentID", SqlDbType.Int, ParameterDirection.Input, parentID);
            sph.DefineSqlParameter("@IsDelected", SqlDbType.Bit, ParameterDirection.Input, isDelected);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Deletes a row from the gb_KLNewType table. Returns true if row deleted.
        /// </summary>
        /// <param name="newsTypeID"> newsTypeID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int newsTypeID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNewType_Delete", 1);
            sph.DefineSqlParameter("@NewsTypeID", SqlDbType.Int, ParameterDirection.Input, newsTypeID);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Gets an IDataReader with one row from the gb_KLNewType table.
        /// </summary>
        /// <param name="newsTypeID"> newsTypeID </param>
        public static IDataReader GetOne(
            int newsTypeID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNewType_SelectOne", 1);
            sph.DefineSqlParameter("@NewsTypeID", SqlDbType.Int, ParameterDirection.Input, newsTypeID);
            return sph.ExecuteReader();

        }

        /// <summary>
        /// Gets a count of rows in the gb_KLNewType table.
        /// </summary>
        public static int GetCount()
        {

            return Convert.ToInt32(SqlHelper.ExecuteScalar(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLNewType_GetCount",
                null));

        }

        /// <summary>
        /// Gets an IDataReader with all rows in the gb_KLNewType table.
        /// </summary>
        public static IDataReader GetAll()
        {

            return SqlHelper.ExecuteReader(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLNewType_SelectAll",
                null);

        }

        /// <summary>
        /// Gets a page of data from the gb_KLNewType table.
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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNewType_SelectPage", 2);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();

        }


    }
}