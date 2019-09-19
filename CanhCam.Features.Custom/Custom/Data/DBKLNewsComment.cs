using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Data
{
    public class DBKLNewsComment
    {

        /// <summary>
        /// Inserts a row in the gb_KLNewsComment table. Returns new integer id.
        /// </summary>
        /// <param name="commentParentID"> commentParentID </param>
        /// <param name="newsID"> newsID </param>
        /// <param name="userID"> userID </param>
        /// <param name="name"> name </param>
        /// <param name="title"> title </param>
        /// <param name="email"> email </param>
        /// <param name="createDate"> createDate </param>
        /// <param name="phone"> phone </param>
        /// <param name="comment"> comment </param>
        /// <param name="isPublish"> isPublish </param>
        /// <param name="iSDel"> iSDel </param>
        /// <returns>int</returns>
        public static int Create(
            int commentParentID,
            int newsID,
            int userID,
            string name,
            string title,
            string email,
            DateTime createDate,
            string phone,
            string comment,
            bool isPublish,
            bool iSDel)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNewsComment_Insert", 11);
            sph.DefineSqlParameter("@CommentParentID", SqlDbType.Int, ParameterDirection.Input, commentParentID);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsID);
            sph.DefineSqlParameter("@UserID", SqlDbType.Int, ParameterDirection.Input, userID);
            sph.DefineSqlParameter("@Name", SqlDbType.NVarChar, 150, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@Title", SqlDbType.NVarChar, 100, ParameterDirection.Input, title);
            sph.DefineSqlParameter("@Email", SqlDbType.NVarChar, 150, ParameterDirection.Input, email);
            sph.DefineSqlParameter("@CreateDate", SqlDbType.DateTime, ParameterDirection.Input, createDate);
            sph.DefineSqlParameter("@Phone", SqlDbType.VarChar, 12, ParameterDirection.Input, phone);
            sph.DefineSqlParameter("@Comment", SqlDbType.NVarChar, -1, ParameterDirection.Input, comment);
            sph.DefineSqlParameter("@IsPublish", SqlDbType.Bit, ParameterDirection.Input, isPublish);
            sph.DefineSqlParameter("@ISDel", SqlDbType.Bit, ParameterDirection.Input, iSDel);
            int newID = Convert.ToInt32(sph.ExecuteScalar());
            return newID;
        }


        /// <summary>
        /// Updates a row in the gb_KLNewsComment table. Returns true if row updated.
        /// </summary>
        /// <param name="commentID"> commentID </param>
        /// <param name="commentParentID"> commentParentID </param>
        /// <param name="newsID"> newsID </param>
        /// <param name="userID"> userID </param>
        /// <param name="name"> name </param>
        /// <param name="title"> title </param>
        /// <param name="email"> email </param>
        /// <param name="createDate"> createDate </param>
        /// <param name="phone"> phone </param>
        /// <param name="comment"> comment </param>
        /// <param name="isPublish"> isPublish </param>
        /// <param name="iSDel"> iSDel </param>
        /// <returns>bool</returns>
        public static bool Update(
            int commentID,
            int commentParentID,
            int newsID,
            int userID,
            string name,
            string title,
            string email,
            DateTime createDate,
            string phone,
            string comment,
            bool isPublish,
            bool iSDel)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNewsComment_Update", 12);
            sph.DefineSqlParameter("@CommentID", SqlDbType.Int, ParameterDirection.Input, commentID);
            sph.DefineSqlParameter("@CommentParentID", SqlDbType.Int, ParameterDirection.Input, commentParentID);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsID);
            sph.DefineSqlParameter("@UserID", SqlDbType.Int, ParameterDirection.Input, userID);
            sph.DefineSqlParameter("@Name", SqlDbType.NVarChar, 150, ParameterDirection.Input, name);
            sph.DefineSqlParameter("@Title", SqlDbType.NVarChar, 100, ParameterDirection.Input, title);
            sph.DefineSqlParameter("@Email", SqlDbType.NVarChar, 150, ParameterDirection.Input, email);
            sph.DefineSqlParameter("@CreateDate", SqlDbType.DateTime, ParameterDirection.Input, createDate);
            sph.DefineSqlParameter("@Phone", SqlDbType.VarChar, 12, ParameterDirection.Input, phone);
            sph.DefineSqlParameter("@Comment", SqlDbType.NVarChar, -1, ParameterDirection.Input, comment);
            sph.DefineSqlParameter("@IsPublish", SqlDbType.Bit, ParameterDirection.Input, isPublish);
            sph.DefineSqlParameter("@ISDel", SqlDbType.Bit, ParameterDirection.Input, iSDel);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Deletes a row from the gb_KLNewsComment table. Returns true if row deleted.
        /// </summary>
        /// <param name="commentID"> commentID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int commentID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLNewsComment_Delete", 1);
            sph.DefineSqlParameter("@CommentID", SqlDbType.Int, ParameterDirection.Input, commentID);
            int rowsAffected = sph.ExecuteNonQuery();
            return (rowsAffected > 0);

        }

        /// <summary>
        /// Gets an IDataReader with one row from the gb_KLNewsComment table.
        /// </summary>
        /// <param name="commentID"> commentID </param>
        public static IDataReader GetOne(
            int commentID)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNewsComment_SelectOne", 1);
            sph.DefineSqlParameter("@CommentID", SqlDbType.Int, ParameterDirection.Input, commentID);
            return sph.ExecuteReader();

        }

        /// <summary>
        /// Gets a count of rows in the gb_KLNewsComment table.
        /// </summary>
        public static int GetCount()
        {

            return Convert.ToInt32(SqlHelper.ExecuteScalar(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLNewsComment_GetCount",
                null));

        }
        public static int GetCountByNewsID(int newid)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNewsComment_GetCountByNewID", 1);
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newid);

            return Convert.ToInt32(sph.ExecuteScalar());

        }

        /// <summary>
        /// Gets an IDataReader with all rows in the gb_KLNewsComment table.
        /// </summary>
        public static IDataReader GetAll()
        {

            return SqlHelper.ExecuteReader(
                ConnectionString.GetReadConnectionString(),
                CommandType.StoredProcedure,
                "gb_KLNewsComment_SelectAll",
                null);

        }

        /// <summary>
        /// Gets a page of data from the gb_KLNewsComment table.
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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNewsComment_SelectPage", 2);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            return sph.ExecuteReader();

        }
        public static IDataReader GetPageByAuthor(
             int pageNumber,
             int pageSize,
             out int totalPages, int authorid, int isapproved, int newtype, int newsid,int parentid)
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
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLNewsComment_SelectPageByAuthor", 7);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorid);
            sph.DefineSqlParameter("@isapproved", SqlDbType.Int, ParameterDirection.Input, isapproved);
            sph.DefineSqlParameter("@NewType", SqlDbType.Int, ParameterDirection.Input, newtype); 
            sph.DefineSqlParameter("@NewsID", SqlDbType.Int, ParameterDirection.Input, newsid);
            sph.DefineSqlParameter("@ParentID", SqlDbType.Int, ParameterDirection.Input, parentid);
            return sph.ExecuteReader();

        }



    }
}