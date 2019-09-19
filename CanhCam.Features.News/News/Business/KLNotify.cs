using CanhCam.Data;
using CanhCam.Data.Khanh;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Business.Khanh
{
    public class KLNotify
    {

        #region Constructors

        public KLNotify()
        { }


        public KLNotify(
            int notifyid)
        {
            this.GetKLNotify(
                notifyid);
        }

        #endregion

        #region Private Properties

        private int notifyid = -1;
        private string userName_Action = string.Empty;
        private int authorID = -1;
        private string notifyType = string.Empty;
        private string notify = string.Empty;
        private string notifyLink = string.Empty;
        private bool viewed = false;
        private DateTime dateCreate = DateTime.Now;

        #endregion

        #region Public Properties

        public int Notifyid
        {
            get { return notifyid; }
            set { notifyid = value; }
        }
        public string UserName_Action
        {
            get { return userName_Action; }
            set { userName_Action = value; }
        }
        public int AuthorID
        {
            get { return authorID; }
            set { authorID = value; }
        }
        public string NotifyType
        {
            get { return notifyType; }
            set { notifyType = value; }
        }
        public string Notify
        {
            get { return notify; }
            set { notify = value; }
        }
        public string NotifyLink
        {
            get { return notifyLink; }
            set { notifyLink = value; }
        }
        public bool Viewed
        {
            get { return viewed; }
            set { viewed = value; }
        }
        public DateTime DateCreate
        {
            get { return dateCreate; }
            set { dateCreate = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLNotify.
        /// </summary>
        /// <param name="notifyid"> notifyid </param>
        private void GetKLNotify(
            int notifyid)
        {
            using (IDataReader reader = DBKLNotify.GetOne(
                notifyid))
            {
                if (reader.Read())
                {
                    this.notifyid = Convert.ToInt32(reader["Notifyid"]);
                    this.userName_Action = reader["UserName_Action"].ToString();
                    this.authorID = Convert.ToInt32(reader["AuthorID"]);
                    this.notifyType = reader["NotifyType"].ToString();
                    this.notify = reader["Notify"].ToString();
                    this.notifyLink = reader["NotifyLink"].ToString();
                    this.viewed = Convert.ToBoolean(reader["viewed"]);
                    this.dateCreate = Convert.ToDateTime(reader["DateCreate"]);
                }
            }

        }

        /// <summary>
        /// Persists a new instance of KLNotify. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLNotify.Create(
                this.userName_Action,
                this.authorID,
                this.notifyType,
                this.notify,
                this.notifyLink,
                this.viewed,
                this.dateCreate);

            this.notifyid = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLNotify. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLNotify.Update(
                this.notifyid,
                this.userName_Action,
                this.authorID,
                this.notifyType,
                this.notify,
                this.notifyLink,
                this.viewed,
                this.dateCreate);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLNotify. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            if (this.notifyid > 0)
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
        /// Deletes an instance of KLNotify. Returns true on success.
        /// </summary>
        /// <param name="notifyid"> notifyid </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int notifyid)
        {
            return DBKLNotify.Delete(
                notifyid);
        }


        /// <summary>
        /// Gets a count of KLNotify. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLNotify.GetCount();
        }

        private static List<KLNotify> LoadListFromReader(IDataReader reader)
        {
            List<KLNotify> kLNotifyList = new List<KLNotify>();
            try
            {
                while (reader.Read())
                {
                    KLNotify kLNotify = new KLNotify();
                    kLNotify.notifyid = Convert.ToInt32(reader["Notifyid"]);
                    kLNotify.userName_Action = reader["UserName_Action"].ToString();
                    kLNotify.authorID = Convert.ToInt32(reader["AuthorID"]);
                    kLNotify.notifyType = reader["NotifyType"].ToString();
                    kLNotify.notify = reader["Notify"].ToString();
                    kLNotify.notifyLink = reader["NotifyLink"].ToString();
                    kLNotify.viewed = Convert.ToBoolean(reader["viewed"]);
                    kLNotify.dateCreate = Convert.ToDateTime(reader["DateCreate"]);
                    kLNotifyList.Add(kLNotify);

                }
            }
            finally
            {
                reader.Close();
            }

            return kLNotifyList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLNotify.
        /// </summary>
        public static List<KLNotify> GetAll()
        {
            IDataReader reader = DBKLNotify.GetAll();
            return LoadListFromReader(reader);

        }

        public static List<KLNotify> GetPageByAuthorID(int pageNumber, int pageSize, out int totalPages, int authorid)
        {
            totalPages = 1;
            IDataReader reader = DBKLNotify.GetPageByAuthorID(pageNumber, pageSize, out totalPages, authorid);
            return LoadListFromReader(reader);
        }
        /// <summary>
        /// Gets an IList with page of instances of KLNotify.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLNotify> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLNotify.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }



        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLNotify.
        /// </summary>
        public static int CompareByNotifyid(KLNotify kLNotify1, KLNotify kLNotify2)
        {
            return kLNotify1.Notifyid.CompareTo(kLNotify2.Notifyid);
        }
        /// <summary>
        /// Compares 2 instances of KLNotify.
        /// </summary>
        public static int CompareByUserName_Action(KLNotify kLNotify1, KLNotify kLNotify2)
        {
            return kLNotify1.UserName_Action.CompareTo(kLNotify2.UserName_Action);
        }
        /// <summary>
        /// Compares 2 instances of KLNotify.
        /// </summary>
        public static int CompareByAuthorID(KLNotify kLNotify1, KLNotify kLNotify2)
        {
            return kLNotify1.AuthorID.CompareTo(kLNotify2.AuthorID);
        }
        /// <summary>
        /// Compares 2 instances of KLNotify.
        /// </summary>
        public static int CompareByNotifyType(KLNotify kLNotify1, KLNotify kLNotify2)
        {
            return kLNotify1.NotifyType.CompareTo(kLNotify2.NotifyType);
        }
        /// <summary>
        /// Compares 2 instances of KLNotify.
        /// </summary>
        public static int CompareByNotify(KLNotify kLNotify1, KLNotify kLNotify2)
        {
            return kLNotify1.Notify.CompareTo(kLNotify2.Notify);
        }
        /// <summary>
        /// Compares 2 instances of KLNotify.
        /// </summary>
        public static int CompareByNotifyLink(KLNotify kLNotify1, KLNotify kLNotify2)
        {
            return kLNotify1.NotifyLink.CompareTo(kLNotify2.NotifyLink);
        }
        /// <summary>
        /// Compares 2 instances of KLNotify.
        /// </summary>
        public static int CompareByDateCreate(KLNotify kLNotify1, KLNotify kLNotify2)
        {
            return kLNotify1.DateCreate.CompareTo(kLNotify2.DateCreate);
        }

        #endregion

    }
}