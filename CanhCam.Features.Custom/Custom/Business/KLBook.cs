using CanhCam.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Business
{

    public class KLBook
    {

        #region Constructors

        public KLBook()
        { }


        public KLBook(
            int bookID)
        {
            this.GetKLBook(
                bookID);
        }

        #endregion

        #region Private Properties

        private int bookID = -1;
        private int authorID = -1;
        private string title = string.Empty;
        private string image = string.Empty;
        private string url = string.Empty;
        private string description = string.Empty;
        private bool isPublish = false;
        private bool isDelected = false;

        #endregion

        #region Public Properties

        public int BookID
        {
            get { return bookID; }
            set { bookID = value; }
        }
        public int AuthorID
        {
            get { return authorID; }
            set { authorID = value; }
        }
        public string Title
        {
            get { return title; }
            set { title = value; }
        }
        public string Image
        {
            get { return image; }
            set { image = value; }
        }
        public string Url
        {
            get { return url; }
            set { url = value; }
        }
        public string Description
        {
            get { return description; }
            set { description = value; }
        }
        public bool IsPublish
        {
            get { return isPublish; }
            set { isPublish = value; }
        }
        public bool IsDelected
        {
            get { return isDelected; }
            set { isDelected = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLBook.
        /// </summary>
        /// <param name="bookID"> bookID </param>
        private void GetKLBook(
            int bookID)
        {
            using (IDataReader reader = DBKLBook.GetOne(
                bookID))
            {
                if (reader.Read())
                {
                    this.bookID = Convert.ToInt32(reader["BookID"]);
                    this.authorID = Convert.ToInt32(reader["AuthorID"]);
                    this.title = reader["Title"].ToString();
                    this.image = reader["Image"].ToString();
                    this.url = reader["Url"].ToString();
                    this.description = reader["Description"].ToString();
                    this.isPublish = Convert.ToBoolean(reader["IsPublish"]);
                    this.isDelected = Convert.ToBoolean(reader["IsDelected"]);
                }
            }

        }

        /// <summary>
        /// Persists a new instance of KLBook. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLBook.Create(
                this.authorID,
                this.title,
                this.image,
                this.url,
                this.description,
                this.isPublish,
                this.isDelected);

            this.bookID = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLBook. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLBook.Update(
                this.bookID,
                this.authorID,
                this.title,
                this.image,
                this.url,
                this.description,
                this.isPublish,
                this.isDelected);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLBook. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            if (this.bookID > 0)
            {
                return this.Update();
            }
            else
            {
                return this.Create();
            }
        }




        #endregion

        #region Static Methods

        /// <summary>
        /// Deletes an instance of KLBook. Returns true on success.
        /// </summary>
        /// <param name="bookID"> bookID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int bookID)
        {
            return DBKLBook.Delete(
                bookID);
        }


        /// <summary>
        /// Gets a count of KLBook. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLBook.GetCount();
        }

        private static List<KLBook> LoadListFromReader(IDataReader reader)
        {
            List<KLBook> KLBookList = new List<KLBook>();
            try
            {
                while (reader.Read())
                {
                    KLBook KLBook = new KLBook();
                    KLBook.bookID = Convert.ToInt32(reader["BookID"]);
                    KLBook.authorID = Convert.ToInt32(reader["AuthorID"]);
                    KLBook.title = reader["Title"].ToString();
                    KLBook.image = reader["Image"].ToString();
                    KLBook.url = reader["Url"].ToString();
                    KLBook.description = reader["Description"].ToString();
                    KLBook.isPublish = Convert.ToBoolean(reader["IsPublish"]);
                    KLBook.isDelected = Convert.ToBoolean(reader["IsDelected"]);
                    KLBookList.Add(KLBook);

                }
            }
            finally
            {
                reader.Close();
            }

            return KLBookList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLBook.
        /// </summary>
        public static List<KLBook> GetAll()
        {
            IDataReader reader = DBKLBook.GetAll();
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLBook.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLBook> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLBook.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }

        public static List<KLBook> GetPageByAuthorid(int pageNumber, int pageSize, out int totalPages,int authorid,string keyword)
        {
            totalPages = 1;
            IDataReader reader = DBKLBook.GetPageByAuthorid(pageNumber, pageSize, out totalPages,authorid, keyword);
            return LoadListFromReader(reader);
        }

        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLBook.
        /// </summary>
        public static int CompareByBookID(KLBook KLBook1, KLBook KLBook2)
        {
            return KLBook1.BookID.CompareTo(KLBook2.BookID);
        }
        /// <summary>
        /// Compares 2 instances of KLBook.
        /// </summary>
        public static int CompareByAuthorID(KLBook KLBook1, KLBook KLBook2)
        {
            return KLBook1.AuthorID.CompareTo(KLBook2.AuthorID);
        }
        /// <summary>
        /// Compares 2 instances of KLBook.
        /// </summary>
        public static int CompareByTitle(KLBook KLBook1, KLBook KLBook2)
        {
            return KLBook1.Title.CompareTo(KLBook2.Title);
        }
        /// <summary>
        /// Compares 2 instances of KLBook.
        /// </summary>
        public static int CompareByImage(KLBook KLBook1, KLBook KLBook2)
        {
            return KLBook1.Image.CompareTo(KLBook2.Image);
        }
        /// <summary>
        /// Compares 2 instances of KLBook.
        /// </summary>
        public static int CompareByUrl(KLBook KLBook1, KLBook KLBook2)
        {
            return KLBook1.Url.CompareTo(KLBook2.Url);
        }
        /// <summary>
        /// Compares 2 instances of KLBook.
        /// </summary>
        public static int CompareByDescription(KLBook KLBook1, KLBook KLBook2)
        {
            return KLBook1.Description.CompareTo(KLBook2.Description);
        }

        #endregion


    }

}
