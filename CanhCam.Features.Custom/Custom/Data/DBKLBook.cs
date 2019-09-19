using CanhCam.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Data
{
    public class DBKLBook
    {


        /// <summary>
		/// Inserts a row in the KLBook table. Returns new integer id.
		/// </summary>
		/// <param name="authorID"> authorID </param>
		/// <param name="title"> title </param>
		/// <param name="image"> image </param>
		/// <param name="url"> url </param>
		/// <param name="description"> description </param>
		/// <param name="isPublish"> isPublish </param>
		/// <param name="isDelected"> isDelected </param>
		/// <returns>int</returns>
		public static int Create(
			int authorID, 
			string title, 
			string image, 
			string url, 
			string description, 
			bool isPublish, 
			bool isDelected) 
		{
			SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLBook_Insert", 7);
			sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
			sph.DefineSqlParameter("@Title", SqlDbType.NVarChar, 255, ParameterDirection.Input, title);
			sph.DefineSqlParameter("@Image", SqlDbType.NVarChar, 255, ParameterDirection.Input, image);
			sph.DefineSqlParameter("@Url", SqlDbType.NVarChar, 255, ParameterDirection.Input, url);
			sph.DefineSqlParameter("@Description", SqlDbType.NVarChar, -1, ParameterDirection.Input, description);
			sph.DefineSqlParameter("@IsPublish", SqlDbType.Bit, ParameterDirection.Input, isPublish);
			sph.DefineSqlParameter("@IsDelected", SqlDbType.Bit, ParameterDirection.Input, isDelected);
			int newID = Convert.ToInt32(sph.ExecuteScalar());
			return newID;
		}


		/// <summary>
		/// Updates a row in the KLBook table. Returns true if row updated.
		/// </summary>
		/// <param name="bookID"> bookID </param>
		/// <param name="authorID"> authorID </param>
		/// <param name="title"> title </param>
		/// <param name="image"> image </param>
		/// <param name="url"> url </param>
		/// <param name="description"> description </param>
		/// <param name="isPublish"> isPublish </param>
		/// <param name="isDelected"> isDelected </param>
		/// <returns>bool</returns>
		public static bool Update(
			int  bookID, 
			int authorID, 
			string title, 
			string image, 
			string url, 
			string description, 
			bool isPublish, 
			bool isDelected) 
		{
			SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLBook_Update", 8);
			sph.DefineSqlParameter("@BookID", SqlDbType.Int, ParameterDirection.Input, bookID);
			sph.DefineSqlParameter("@AuthorID", SqlDbType.Int, ParameterDirection.Input, authorID);
			sph.DefineSqlParameter("@Title", SqlDbType.NVarChar, 255, ParameterDirection.Input, title);
			sph.DefineSqlParameter("@Image", SqlDbType.NVarChar, 255, ParameterDirection.Input, image);
			sph.DefineSqlParameter("@Url", SqlDbType.NVarChar, 255, ParameterDirection.Input, url);
			sph.DefineSqlParameter("@Description", SqlDbType.NVarChar, -1, ParameterDirection.Input, description);
			sph.DefineSqlParameter("@IsPublish", SqlDbType.Bit, ParameterDirection.Input, isPublish);
			sph.DefineSqlParameter("@IsDelected", SqlDbType.Bit, ParameterDirection.Input, isDelected);
			int rowsAffected = sph.ExecuteNonQuery();
			return (rowsAffected > 0);
			
		}
		
		/// <summary>
		/// Deletes a row from the KLBook table. Returns true if row deleted.
		/// </summary>
		/// <param name="bookID"> bookID </param>
		/// <returns>bool</returns>
		public static bool Delete(
			int bookID) 
		{
			SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetWriteConnectionString(), "gb_KLBook_Delete", 1);
			sph.DefineSqlParameter("@BookID", SqlDbType.Int, ParameterDirection.Input, bookID);
			int rowsAffected = sph.ExecuteNonQuery();
			return (rowsAffected > 0);
			
		}
		
		/// <summary>
		/// Gets an IDataReader with one row from the KLBook table.
		/// </summary>
		/// <param name="bookID"> bookID </param>
		public static IDataReader GetOne(
			int  bookID)  
		{
			SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLBook_SelectOne", 1);
			sph.DefineSqlParameter("@BookID", SqlDbType.Int, ParameterDirection.Input, bookID);
			return sph.ExecuteReader();
			
		}
		
		/// <summary>
		/// Gets a count of rows in the KLBook table.
		/// </summary>
		public static int GetCount()
		{
			
			return Convert.ToInt32(SqlHelper.ExecuteScalar(
				ConnectionString.GetReadConnectionString(),
				CommandType.StoredProcedure,
                "gb_KLBook_GetCount",
				null));
	
		}
		
		/// <summary>
		/// Gets an IDataReader with all rows in the KLBook table.
		/// </summary>
		public static IDataReader GetAll()
		{
			
			return SqlHelper.ExecuteReader(
				ConnectionString.GetReadConnectionString(),
				CommandType.StoredProcedure,
                "gb_KLBook_SelectAll",
				null);
	
		}
		
		/// <summary>
		/// Gets a page of data from the KLBook table.
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
			
			SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLBook_SelectPage", 2);
			sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
			sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
			return sph.ExecuteReader();
		
		}
        public static int GetCountByAuthorid(int authorid)
        {
            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLBook_GetCountByAuthorid", 1);
            sph.DefineSqlParameter("@authorid", SqlDbType.Int, ParameterDirection.Input, authorid);

            return Convert.ToInt32(sph.ExecuteScalar());

        }
        public static IDataReader GetPageByAuthorid(
        int pageNumber,
        int pageSize,
        out int totalPages,int authorid,string keyword)
        {
            totalPages = 1;
            int totalRows
                = GetCountByAuthorid(authorid);

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

            SqlParameterHelper sph = new SqlParameterHelper(ConnectionString.GetReadConnectionString(), "gb_KLBook_SelectPageByAuthorID", 3);
            sph.DefineSqlParameter("@PageNumber", SqlDbType.Int, ParameterDirection.Input, pageNumber);
            sph.DefineSqlParameter("@PageSize", SqlDbType.Int, ParameterDirection.Input, pageSize);
            sph.DefineSqlParameter("@Keyword", SqlDbType.NVarChar, 100, ParameterDirection.Input, keyword);
            sph.DefineSqlParameter("@Authorid", SqlDbType.Int, ParameterDirection.Input, authorid);
            return sph.ExecuteReader();

        }

    }

}
