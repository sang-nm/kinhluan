using CanhCam.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Business
{
    public class KLFowllowAuthor
    {


        #region Constructors

        public KLFowllowAuthor()
        { }


        public KLFowllowAuthor(
            int followID)
        {
            this.GetKLFowllowAuthor(
                followID);
        }

        #endregion

        #region Private Properties

        private int followID = -1;
        private int userID = -1;
        private int authorID = -1;
        private DateTime dateStartFollow = DateTime.Now;

        #endregion

        #region Public Properties

        public int FollowID
        {
            get { return followID; }
            set { followID = value; }
        }
        public int UserID
        {
            get { return userID; }
            set { userID = value; }
        }
        public int AuthorID
        {
            get { return authorID; }
            set { authorID = value; }
        }
        public DateTime DateStartFollow
        {
            get { return dateStartFollow; }
            set { dateStartFollow = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLFowllowAuthor.
        /// </summary>
        /// <param name="followID"> followID </param>
        private void GetKLFowllowAuthor(
            int followID)
        {
            using (IDataReader reader = DBKLFowllowAuthor.GetOne(
                followID))
            {
                if (reader.Read())
                {
                    this.followID = Convert.ToInt32(reader["FollowID"]);
                    this.userID = Convert.ToInt32(reader["UserID"]);
                    this.authorID = Convert.ToInt32(reader["AuthorID"]);
                    this.dateStartFollow = Convert.ToDateTime(reader["DateStartFollow"]);
                }
            }

        }

        /// <summary>
        /// Persists a new instance of KLFowllowAuthor. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLFowllowAuthor.Create(
                this.userID,
                this.authorID,
                this.dateStartFollow);

            this.followID = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLFowllowAuthor. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLFowllowAuthor.Update(
                this.followID,
                this.userID,
                this.authorID,
                this.dateStartFollow);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLFowllowAuthor. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            if (this.followID > 0)
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
        /// Deletes an instance of KLFowllowAuthor. Returns true on success.
        /// </summary>
        /// <param name="followID"> followID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int followID)
        {
            return DBKLFowllowAuthor.Delete(
                followID);
        }


        /// <summary>
        /// Gets a count of KLFowllowAuthor. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLFowllowAuthor.GetCount();
        }

        private static List<KLFowllowAuthor> LoadListFromReader(IDataReader reader)
        {
            List<KLFowllowAuthor> kLFowllowAuthorList = new List<KLFowllowAuthor>();
            try
            {
                while (reader.Read())
                {
                    KLFowllowAuthor kLFowllowAuthor = new KLFowllowAuthor();
                    kLFowllowAuthor.followID = Convert.ToInt32(reader["FollowID"]);
                    kLFowllowAuthor.userID = Convert.ToInt32(reader["UserID"]);
                    kLFowllowAuthor.authorID = Convert.ToInt32(reader["AuthorID"]);
                    kLFowllowAuthor.dateStartFollow = Convert.ToDateTime(reader["DateStartFollow"]);
                    kLFowllowAuthorList.Add(kLFowllowAuthor);

                }
            }
            finally
            {
                reader.Close();
            }

            return kLFowllowAuthorList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLFowllowAuthor.
        /// </summary>
        public static List<KLFowllowAuthor> GetAll()
        {
            IDataReader reader = DBKLFowllowAuthor.GetAll();
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLFowllowAuthor.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLFowllowAuthor> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLFowllowAuthor.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }

        public static List<KLFowllowAuthor> GetPageByAuthorID(int pageNumber, int pageSize, out int totalPages,int authorid)
        {
            totalPages = 1;
            IDataReader reader = DBKLFowllowAuthor.GetPageByAuthor(pageNumber, pageSize, out totalPages, authorid);
            return LoadListFromReader(reader);
        }




        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLFowllowAuthor.
        /// </summary>
        public static int CompareByFollowID(KLFowllowAuthor kLFowllowAuthor1, KLFowllowAuthor kLFowllowAuthor2)
        {
            return kLFowllowAuthor1.FollowID.CompareTo(kLFowllowAuthor2.FollowID);
        }
        /// <summary>
        /// Compares 2 instances of KLFowllowAuthor.
        /// </summary>
        public static int CompareByUserID(KLFowllowAuthor kLFowllowAuthor1, KLFowllowAuthor kLFowllowAuthor2)
        {
            return kLFowllowAuthor1.UserID.CompareTo(kLFowllowAuthor2.UserID);
        }
        /// <summary>
        /// Compares 2 instances of KLFowllowAuthor.
        /// </summary>
        public static int CompareByAuthorID(KLFowllowAuthor kLFowllowAuthor1, KLFowllowAuthor kLFowllowAuthor2)
        {
            return kLFowllowAuthor1.AuthorID.CompareTo(kLFowllowAuthor2.AuthorID);
        }
        /// <summary>
        /// Compares 2 instances of KLFowllowAuthor.
        /// </summary>
        public static int CompareByDateStartFollow(KLFowllowAuthor kLFowllowAuthor1, KLFowllowAuthor kLFowllowAuthor2)
        {
            return kLFowllowAuthor1.DateStartFollow.CompareTo(kLFowllowAuthor2.DateStartFollow);
        }

        #endregion

    }
}