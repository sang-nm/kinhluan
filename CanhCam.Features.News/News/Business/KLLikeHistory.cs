
// Author:					Tran Quoc Vuong
// Created:					2017-8-11
// Last Modified:			2017-8-11

using CanhCam.Data;
using System;
using System.Collections.Generic;
using System.Data;

namespace CanhCam.Business
{

    public class KLLikeHistory
    {

        #region Constructors

        public KLLikeHistory()
        { }


        public KLLikeHistory(
            int likeID)
        {
            this.GetKLLikeHistory(
                likeID);
        }

        #endregion

        #region Private Properties

        private int likeID = -1;
        private int authorID = -1;
        private int newsID = -1;
        private DateTime createDate = DateTime.Now;

        #endregion

        #region Public Properties

        public int LikeID
        {
            get { return likeID; }
            set { likeID = value; }
        }
        public int AuthorID
        {
            get { return authorID; }
            set { authorID = value; }
        }
        public int NewsID
        {
            get { return newsID; }
            set { newsID = value; }
        }
        public DateTime CreateDate
        {
            get { return createDate; }
            set { createDate = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLLikeHistory.
        /// </summary>
        /// <param name="likeID"> likeID </param>
        private void GetKLLikeHistory(
            int likeID)
        {
            using (IDataReader reader = DBKLLikeHistory.GetOne(
                likeID))
            {
                if (reader.Read())
                {
                    this.likeID = Convert.ToInt32(reader["LikeID"]);
                    this.authorID = Convert.ToInt32(reader["AuthorID"]);
                    this.newsID = Convert.ToInt32(reader["NewsID"]);
                    this.createDate = Convert.ToDateTime(reader["CreateDate"]);
                }
            }

        }

        /// <summary>
        /// Persists a new instance of KLLikeHistory. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLLikeHistory.Create(
                this.authorID,
                this.newsID,
                this.createDate);

            this.likeID = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLLikeHistory. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLLikeHistory.Update(
                this.likeID,
                this.authorID,
                this.newsID,
                this.createDate);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLLikeHistory. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            if (this.likeID > 0)
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
        /// Deletes an instance of KLLikeHistory. Returns true on success.
        /// </summary>
        /// <param name="likeID"> likeID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int likeID)
        {
            return DBKLLikeHistory.Delete(
                likeID);
        }


        /// <summary>
        /// Gets a count of KLLikeHistory. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLLikeHistory.GetCount();
        }

        private static List<KLLikeHistory> LoadListFromReader(IDataReader reader)
        {
            List<KLLikeHistory> kLLikeHistoryList = new List<KLLikeHistory>();
            try
            {
                while (reader.Read())
                {
                    KLLikeHistory kLLikeHistory = new KLLikeHistory();
                    kLLikeHistory.likeID = Convert.ToInt32(reader["LikeID"]);
                    kLLikeHistory.authorID = Convert.ToInt32(reader["AuthorID"]);
                    kLLikeHistory.newsID = Convert.ToInt32(reader["NewsID"]);
                    kLLikeHistory.createDate = Convert.ToDateTime(reader["CreateDate"]);
                    kLLikeHistoryList.Add(kLLikeHistory);

                }
            }
            finally
            {
                reader.Close();
            }

            return kLLikeHistoryList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLLikeHistory.
        /// </summary>
        public static List<KLLikeHistory> GetAll()
        {
            IDataReader reader = DBKLLikeHistory.GetAll();
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLLikeHistory.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLLikeHistory> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLLikeHistory.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }



        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLLikeHistory.
        /// </summary>
        public static int CompareByLikeID(KLLikeHistory kLLikeHistory1, KLLikeHistory kLLikeHistory2)
        {
            return kLLikeHistory1.LikeID.CompareTo(kLLikeHistory2.LikeID);
        }
        /// <summary>
        /// Compares 2 instances of KLLikeHistory.
        /// </summary>
        public static int CompareByAuthorID(KLLikeHistory kLLikeHistory1, KLLikeHistory kLLikeHistory2)
        {
            return kLLikeHistory1.AuthorID.CompareTo(kLLikeHistory2.AuthorID);
        }
        /// <summary>
        /// Compares 2 instances of KLLikeHistory.
        /// </summary>
        public static int CompareByNewsID(KLLikeHistory kLLikeHistory1, KLLikeHistory kLLikeHistory2)
        {
            return kLLikeHistory1.NewsID.CompareTo(kLLikeHistory2.NewsID);
        }
        /// <summary>
        /// Compares 2 instances of KLLikeHistory.
        /// </summary>
        public static int CompareByCreateDate(KLLikeHistory kLLikeHistory1, KLLikeHistory kLLikeHistory2)
        {
            return kLLikeHistory1.CreateDate.CompareTo(kLLikeHistory2.CreateDate);
        }

        #endregion


    }

}
