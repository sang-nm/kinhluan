using CanhCam.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Business
{
    public class KLNewsType
    {
        #region Constructors

        public KLNewsType()
        { }


        public KLNewsType(
            int newsTypeID)
        {
            this.GetKLNewsType(
                newsTypeID);
        }

        #endregion

        #region Private Properties

        private int newsTypeID = -1;
        private string name = string.Empty;
        private string url = string.Empty;
        private int parentID = -1;
        private bool isDelected = false;

        #endregion

        #region Public Properties

        public int NewsTypeID
        {
            get { return newsTypeID; }
            set { newsTypeID = value; }
        }
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        public string Url
        {
            get { return url; }
            set { url = value; }
        }
        public int ParentID
        {
            get { return parentID; }
            set { parentID = value; }
        }
        public bool IsDelected
        {
            get { return isDelected; }
            set { isDelected = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLNewsType.
        /// </summary>
        /// <param name="newsTypeID"> newsTypeID </param>
        private void GetKLNewsType(
            int newsTypeID)
        {
            using (IDataReader reader = DBKLNewsType.GetOne(
                newsTypeID))
            {
                if (reader.Read())
                {
                    this.newsTypeID = Convert.ToInt32(reader["NewsTypeID"]);
                    this.name = reader["Name"].ToString();
                    this.url = reader["Url"].ToString();
                    this.parentID = Convert.ToInt32(reader["ParentID"]);
                    this.isDelected = Convert.ToBoolean(reader["IsDelected"]);
                }
            }

        }

        /// <summary>
        /// Persists a new instance of KLNewsType. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLNewsType.Create(
                this.name,
                this.url,
                this.parentID,
                this.isDelected);

            this.newsTypeID = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLNewsType. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLNewsType.Update(
                this.newsTypeID,
                this.name,
                this.url,
                this.parentID,
                this.isDelected);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLNewsType. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            if (this.newsTypeID > 0)
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
        /// Deletes an instance of KLNewsType. Returns true on success.
        /// </summary>
        /// <param name="newsTypeID"> newsTypeID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int newsTypeID)
        {
            return DBKLNewsType.Delete(
                newsTypeID);
        }


        /// <summary>
        /// Gets a count of KLNewsType. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLNewsType.GetCount();
        }

        private static List<KLNewsType> LoadListFromReader(IDataReader reader)
        {
            List<KLNewsType> KLNewsTypeList = new List<KLNewsType>();
            try
            {
                while (reader.Read())
                {
                    KLNewsType KLNewsType = new KLNewsType();
                    KLNewsType.newsTypeID = Convert.ToInt32(reader["NewsTypeID"]);
                    KLNewsType.name = reader["Name"].ToString();
                    KLNewsType.url = reader["Url"].ToString();
                    KLNewsType.parentID = Convert.ToInt32(reader["ParentID"]);
                    KLNewsType.isDelected = Convert.ToBoolean(reader["IsDelected"]);
                    KLNewsTypeList.Add(KLNewsType);

                }
            }
            finally
            {
                reader.Close();
            }

            return KLNewsTypeList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLNewsType.
        /// </summary>
        public static List<KLNewsType> GetAll()
        {
            IDataReader reader = DBKLNewsType.GetAll();
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLNewsType.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLNewsType> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLNewsType.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }



        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLNewsType.
        /// </summary>
        public static int CompareByNewsTypeID(KLNewsType KLNewsType1, KLNewsType KLNewsType2)
        {
            return KLNewsType1.NewsTypeID.CompareTo(KLNewsType2.NewsTypeID);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsType.
        /// </summary>
        public static int CompareByName(KLNewsType KLNewsType1, KLNewsType KLNewsType2)
        {
            return KLNewsType1.Name.CompareTo(KLNewsType2.Name);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsType.
        /// </summary>
        public static int CompareByUrl(KLNewsType KLNewsType1, KLNewsType KLNewsType2)
        {
            return KLNewsType1.Url.CompareTo(KLNewsType2.Url);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsType.
        /// </summary>
        public static int CompareByParentID(KLNewsType KLNewsType1, KLNewsType KLNewsType2)
        {
            return KLNewsType1.ParentID.CompareTo(KLNewsType2.ParentID);
        }

        #endregion


    }
}