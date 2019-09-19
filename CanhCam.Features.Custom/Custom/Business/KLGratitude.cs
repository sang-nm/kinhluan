using CanhCam.Data;
using System;
using System.Collections.Generic;
using System.Data;

namespace CanhCam.Business
{
    public class KLGratitude
    {

        #region Constructors

        public KLGratitude()
        { }


        public KLGratitude(
            int guestID)
        {
            this.GetKLGratitude(
                guestID);
        }

        #endregion

        #region Private Properties

        private int guestID = -1;
        private string name = string.Empty;
        private string avatar = string.Empty;
        private int authorID = -1;
        private DateTime createUtc = DateTime.Now;
        private string comment = string.Empty;

        #endregion

        #region Public Properties

        public int GuestID
        {
            get { return guestID; }
            set { guestID = value; }
        }
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        public string Avatar
        {
            get { return avatar; }
            set { avatar = value; }
        }
        public int AuthorID
        {
            get { return authorID; }
            set { authorID = value; }
        }
        public DateTime CreateUtc
        {
            get { return createUtc; }
            set { createUtc = value; }
        }
        public string Comment
        {
            get { return comment; }
            set { comment = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLGratitude.
        /// </summary>
        /// <param name="guestID"> guestID </param>
        private void GetKLGratitude(
            int guestID)
        {
            using (IDataReader reader = DBKLGratitude.GetOne(
                guestID))
            {
                if (reader.Read())
                {
                    this.guestID = Convert.ToInt32(reader["GuestID"]);
                    this.name = reader["Name"].ToString();
                    this.avatar = reader["Avatar"].ToString();
                    this.authorID = Convert.ToInt32(reader["AuthorID"]);
                    this.createUtc = Convert.ToDateTime(reader["CreateUtc"]);
                    this.comment = reader["Comment"].ToString();
                }
            }

        }

        /// <summary>
        /// Persists a new instance of KLGratitude. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLGratitude.Create(
                this.name,
                this.avatar,
                this.authorID,
                this.createUtc,
                this.comment);

            this.guestID = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLGratitude. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLGratitude.Update(
                this.guestID,
                this.name,
                this.avatar,
                this.authorID,
                this.createUtc,
                this.comment);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLGratitude. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            if (this.guestID > 0)
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
        /// Deletes an instance of KLGratitude. Returns true on success.
        /// </summary>
        /// <param name="guestID"> guestID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int guestID)
        {
            return DBKLGratitude.Delete(
                guestID);
        }


        /// <summary>
        /// Gets a count of KLGratitude. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLGratitude.GetCount();
        }

        private static List<KLGratitude> LoadListFromReader(IDataReader reader)
        {
            List<KLGratitude> kLGratitudeList = new List<KLGratitude>();
            try
            {
                while (reader.Read())
                {
                    KLGratitude kLGratitude = new KLGratitude();
                    kLGratitude.guestID = Convert.ToInt32(reader["GuestID"]);
                    kLGratitude.name = reader["Name"].ToString();
                    kLGratitude.avatar = reader["Avatar"].ToString();
                    kLGratitude.authorID = Convert.ToInt32(reader["AuthorID"]);
                    kLGratitude.createUtc = Convert.ToDateTime(reader["CreateUtc"]);
                    kLGratitude.comment = reader["Comment"].ToString();
                    kLGratitudeList.Add(kLGratitude);

                }
            }
            finally
            {
                reader.Close();
            }

            return kLGratitudeList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLGratitude.
        /// </summary>
        public static List<KLGratitude> GetAll()
        {
            IDataReader reader = DBKLGratitude.GetAll();
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLGratitude.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLGratitude> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLGratitude.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }



        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLGratitude.
        /// </summary>
        public static int CompareByGuestID(KLGratitude kLGratitude1, KLGratitude kLGratitude2)
        {
            return kLGratitude1.GuestID.CompareTo(kLGratitude2.GuestID);
        }
        /// <summary>
        /// Compares 2 instances of KLGratitude.
        /// </summary>
        public static int CompareByName(KLGratitude kLGratitude1, KLGratitude kLGratitude2)
        {
            return kLGratitude1.Name.CompareTo(kLGratitude2.Name);
        }
        /// <summary>
        /// Compares 2 instances of KLGratitude.
        /// </summary>
        public static int CompareByAvatar(KLGratitude kLGratitude1, KLGratitude kLGratitude2)
        {
            return kLGratitude1.Avatar.CompareTo(kLGratitude2.Avatar);
        }
        /// <summary>
        /// Compares 2 instances of KLGratitude.
        /// </summary>
        public static int CompareByAuthorID(KLGratitude kLGratitude1, KLGratitude kLGratitude2)
        {
            return kLGratitude1.AuthorID.CompareTo(kLGratitude2.AuthorID);
        }
        /// <summary>
        /// Compares 2 instances of KLGratitude.
        /// </summary>
        public static int CompareByCreateUtc(KLGratitude kLGratitude1, KLGratitude kLGratitude2)
        {
            return kLGratitude1.CreateUtc.CompareTo(kLGratitude2.CreateUtc);
        }
        /// <summary>
        /// Compares 2 instances of KLGratitude.
        /// </summary>
        public static int CompareByComment(KLGratitude kLGratitude1, KLGratitude kLGratitude2)
        {
            return kLGratitude1.Comment.CompareTo(kLGratitude2.Comment);
        }

        #endregion


    }

}
