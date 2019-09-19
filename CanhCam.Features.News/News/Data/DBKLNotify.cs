using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Data.Khanh
{
    public class DBKLNotify
    {

        /// <summary>
        /// Inserts a row in the gb_KLNotify table. Returns new integer id.
        /// </summary>
        /// <param name="userName_Action"> userName_Action </param>
        /// <param name="authorID"> authorID </param>
        /// <param name="notifyType"> notifyType </param>
        /// <param name="notify"> notify </param>
        /// <param name="notifyLink"> notifyLink </param>
        /// <param name="viewed"> viewed </param>
        /// <param name="dateCreate"> dateCreate </param>
        /// <returns>int</returns>
        public static int Create(
            string userName_Action,
            int authorID,
            string notifyType,
            string notify,
            string notifyLink,
            bool viewed,
            DateTime dateCreate)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNotify_Insert", 7);
            sph.DefineSqlParameter("@UserName_Action", SqlDbType.NVarChar, 100, ParameterDirection.Input, userName_Action);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@NotifyType", SqlDbType.NVarChar, 50, ParameterDirection.Input, notifyType);
            sph.DefineSqlParameter("@Notify", SqlDbType.NVarChar, 255, ParameterDirection.Input, notify);
            sph.DefineSqlParameter("@NotifyLink", SqlDbType.NVarChar, 255, ParameterDirection.Input, notifyLink);
            sph.DefineSqlParameter("@viewed", SqlDbType.Bit, ParameterDirection.Input, viewed);
            sph.DefineSqlParameter("@DateCreate", SqlDbType.DateTime, ParameterDirection.Input, dateCreate);
            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }


        /// <summary>
        /// Updates a row in the gb_KLNotify table. Returns true if row updated.
        /// </summary>
        /// <param name="notifyid"> notifyid </param>
        /// <param name="userName_Action"> userName_Action </param>
        /// <param name="authorID"> authorID </param>
        /// <param name="notifyType"> notifyType </param>
        /// <param name="notify"> notify </param>
        /// <param name="notifyLink"> notifyLink </param>
        /// <param name="viewed"> viewed </param>
        /// <param name="dateCreate"> dateCreate </param>
        /// <returns>bool</returns>
        public static bool Update(
            int notifyid,
            string userName_Action,
            int authorID,
            string notifyType,
            string notify,
            string notifyLink,
            bool viewed,
            DateTime dateCreate)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNotify_Update", 8);
            sph.DefineSqlParameter("@Notifyid", SqlDbType.Int, ParameterDirection.Input, notifyid);
            sph.DefineSqlParameter("@UserName_Action", SqlDbType.NVarChar, 100, ParameterDirection.Input, userName_Action);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
            sph.DefineSqlParameter("@NotifyType", SqlDbType.NVarChar, 50, ParameterDirection.Input, notifyType);
            sph.DefineSqlParameter("@Notify", SqlDbType.NVarChar, 255, ParameterDirection.Input, notify);
            sph.DefineSqlParameter("@NotifyLink", SqlDbType.NVarChar, 255, ParameterDirection.Input, notifyLink);
            sph.DefineSqlParameter("@viewed", SqlDbType.Bit, ParameterDirection.Input, viewed);
            sph.DefineSqlParameter("@DateCreate", SqlDbType.DateTime, ParameterDirection.Input, dateCreate);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Deletes a row from the gb_KLNotify table. Returns true if row deleted.
        /// </summary>
        /// <param name="notifyid"> notifyid </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int notifyid)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNotify_Delete", 1);
            sph.DefineSqlParameter("@Notifyid", SqlDbType.Int, ParameterDirection.Input, notifyid);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Gets an IDataReader with one row from the gb_KLNotify table.
        /// </summary>
        /// <param name="notifyid"> notifyid </param>
        public static IDataReader GetOne(
            int notifyid)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNotify_SelectOne", 1);
            sph.DefineSqlParameter("@Notifyid", SqlDbType.Int, ParameterDirection.Input, notifyid);
            return sph.ExecuteReader();

        }

        /// <summary>
        /// Gets a count of rows in the gb_KLNotify table.
        /// </summary>
        public static int GetCount()
        {

            return Convert.ToInt32(SqlHelper.ExecuteScalar(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLNotify_GetCount",
                null));

        }

        /// <summary>
        /// Gets an IDataReader with all rows in the gb_KLNotify table.
        /// </summary>
        public static IDataReader GetAll()
        {

            return SqlHelper.ExecuteReader(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLNotify_SelectAll",
                null);

        }

        /// <summary>
        /// Gets a page of data from the gb_KLNotify table.
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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNotify_SelectPage", 2);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();

        }

        public static int GetCountByAuthorID(int authorid)
        {

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNotify_GetCountByAuthorID", 1);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorid);

            return Convert.ToInt32(sph.ExecuteScalar());

        }
        public static IDataReader GetPageByAuthorID(
           int pageNumber,
           int pageSize,
           out int totalPages,int authorid)
        {
            totalPages = 1;
            int totalRows
                = GetCountByAuthorID(authorid);

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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNotify_SelectPageByAuthorID", 3);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorid);
            return sph.ExecuteReader();

        }
    }
}