
// Author:					Ngo ba khanh
// Created:					2017-8-2
// Last Modified:			2017-8-2

using System;
using System.Collections.Generic;
using System.Data;
using CanhCam.Data;

namespace CanhCam.Business
{

    public class KLViewHistory
    {

        #region Constructors

        public KLViewHistory()
        { }


        public KLViewHistory(
            int id)
        {
            this.GetKLViewHistory(
                id);
        }

        #endregion

        #region Private Properties

        private int iD = -1;
        private int newsID = -1;
        private DateTime viewDate = Convert.ToDateTime(DateTime.Now.ToShortDateString());
        private int viewCount = 0;
        private DateTime fromdate = DateTime.Now;
        private DateTime todate = DateTime.Now;

        #endregion

        #region Public Properties

        public int ID
        {
            get { return iD; }
            set { iD = value; }
        }
        public int NewsID
        {
            get { return newsID; }
            set { newsID = value; }
        }
        public DateTime ViewDate
        {
            get { return viewDate; }
            set { viewDate = value; }
        }
        public int ViewCount
        {
            get { return viewCount; }
            set { viewCount = value; }
        }

        public DateTime FromDate
        {
            get { return fromdate; }
            set { fromdate = value; }
        }

        public DateTime ToDate
        {
            get { return todate; }
            set { todate = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLViewHistory.
        /// </summary>
        /// <param name="id"> id </param>
        private void GetKLViewHistory(
            int id)
        {
            using (IDataReader reader = DBKLViewHistory.GetOne(
                id))
            {
                if (reader.Read())
                {
                    this.iD = Convert.ToInt32(reader["ID"]);
                    this.newsID = Convert.ToInt32(reader["NewsID"]);
                    this.viewDate = Convert.ToDateTime(reader["ViewDate"]);
                    this.viewCount = Convert.ToInt32(reader["ViewCount"]);
                }
            }

        }

        /// <summary>
        /// Persists a new instance of KLViewHistory. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLViewHistory.Create(
                this.newsID,
                this.viewDate,
                this.fromdate,
                this.todate);

            this.iD = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLViewHistory. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLViewHistory.Update(
                this.iD,
                this.newsID,
                this.viewDate,
                this.viewCount);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLViewHistory. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            //if (this.iD > 0)
            //{
            //    return this.Update();
            //}
            //else
            //{
                return this.Create();
            //}
        }




        #endregion

        #region Static Methods

        /// <summary>
        /// Deletes an instance of KLViewHistory. Returns true on success.
        /// </summary>
        /// <param name="id"> id </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int id)
        {
            return DBKLViewHistory.Delete(
                id);
        }


        /// <summary>
        /// Gets a count of KLViewHistory. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLViewHistory.GetCount();
        }

        private static List<KLViewHistory> LoadListFromReader(IDataReader reader)
        {
            List<KLViewHistory> kLViewHistoryList = new List<KLViewHistory>();
            try
            {
                while (reader.Read())
                {
                    KLViewHistory kLViewHistory = new KLViewHistory();
                   // kLViewHistory.iD = Convert.ToInt32(reader["ID"]);
                    kLViewHistory.newsID = Convert.ToInt32(reader["NewsID"]);
                    //kLViewHistory.viewDate = Convert.ToDateTime(reader["ViewDate"]);
                    kLViewHistory.viewCount = Convert.ToInt32(reader["ViewCount"]);
                    kLViewHistoryList.Add(kLViewHistory);

                }
            }
            finally
            {
                reader.Close();
            }

            return kLViewHistoryList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLViewHistory.
        /// </summary>
        public static List<KLViewHistory> GetTop6(DateTime fromdate, DateTime todate)
        {
            IDataReader reader = DBKLViewHistory.GetTop6(fromdate,todate);
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLViewHistory.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLViewHistory> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLViewHistory.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }



        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLViewHistory.
        /// </summary>
        public static int CompareByID(KLViewHistory kLViewHistory1, KLViewHistory kLViewHistory2)
        {
            return kLViewHistory1.ID.CompareTo(kLViewHistory2.ID);
        }
        /// <summary>
        /// Compares 2 instances of KLViewHistory.
        /// </summary>
        public static int CompareByNewsID(KLViewHistory kLViewHistory1, KLViewHistory kLViewHistory2)
        {
            return kLViewHistory1.NewsID.CompareTo(kLViewHistory2.NewsID);
        }
        /// <summary>
        /// Compares 2 instances of KLViewHistory.
        /// </summary>
        public static int CompareByViewDate(KLViewHistory kLViewHistory1, KLViewHistory kLViewHistory2)
        {
            return kLViewHistory1.ViewDate.CompareTo(kLViewHistory2.ViewDate);
        }
        /// <summary>
        /// Compares 2 instances of KLViewHistory.
        /// </summary>
        public static int CompareByViewCount(KLViewHistory kLViewHistory1, KLViewHistory kLViewHistory2)
        {
            return kLViewHistory1.ViewCount.CompareTo(kLViewHistory2.ViewCount);
        }

        #endregion


    }

}
