
// Author:					Ngo ba khanh
// Created:					2017-7-24
// Last Modified:			2017-7-24

using System;
using System.Collections.Generic;
using System.Data;
using CanhCam.Data;

namespace CanhCam.Business
{

    public class KLNewType
    {

        #region Constructors

        public KLNewType()
        { }


        public KLNewType(
            int newsTypeID)
        {
            this.GetKLNewType(
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
        /// Gets an instance of KLNewType.
        /// </summary>
        /// <param name="newsTypeID"> newsTypeID </param>
        private void GetKLNewType(
            int newsTypeID)
        {
            using (IDataReader reader = DBKLNewType.GetOne(
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
        /// Persists a new instance of KLNewType. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLNewType.Create(
                this.name,
                this.url,
                this.parentID,
                this.isDelected);

            this.newsTypeID = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLNewType. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLNewType.Update(
                this.newsTypeID,
                this.name,
                this.url,
                this.parentID,
                this.isDelected);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLNewType. Returns true on success.
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
        /// Deletes an instance of KLNewType. Returns true on success.
        /// </summary>
        /// <param name="newsTypeID"> newsTypeID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int newsTypeID)
        {
            return DBKLNewType.Delete(
                newsTypeID);
        }


        /// <summary>
        /// Gets a count of KLNewType. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLNewType.GetCount();
        }

        private static List<KLNewType> LoadListFromReader(IDataReader reader)
        {
            List<KLNewType> kLNewTypeList = new List<KLNewType>();
            try
            {
                while (reader.Read())
                {
                    KLNewType kLNewType = new KLNewType();
                    kLNewType.newsTypeID = Convert.ToInt32(reader["NewsTypeID"]);
                    kLNewType.name = reader["Name"].ToString();
                    kLNewType.url = reader["Url"].ToString();
                    kLNewType.parentID = Convert.ToInt32(reader["ParentID"]);
                    kLNewType.isDelected = Convert.ToBoolean(reader["IsDelected"]);
                    kLNewTypeList.Add(kLNewType);

                }
            }
            finally
            {
                reader.Close();
            }

            return kLNewTypeList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLNewType.
        /// </summary>
        public static List<KLNewType> GetAll()
        {
            IDataReader reader = DBKLNewType.GetAll();
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLNewType.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLNewType> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLNewType.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }



        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLNewType.
        /// </summary>
        public static int CompareByNewsTypeID(KLNewType kLNewType1, KLNewType kLNewType2)
        {
            return kLNewType1.NewsTypeID.CompareTo(kLNewType2.NewsTypeID);
        }
        /// <summary>
        /// Compares 2 instances of KLNewType.
        /// </summary>
        public static int CompareByName(KLNewType kLNewType1, KLNewType kLNewType2)
        {
            return kLNewType1.Name.CompareTo(kLNewType2.Name);
        }
        /// <summary>
        /// Compares 2 instances of KLNewType.
        /// </summary>
        public static int CompareByUrl(KLNewType kLNewType1, KLNewType kLNewType2)
        {
            return kLNewType1.Url.CompareTo(kLNewType2.Url);
        }
        /// <summary>
        /// Compares 2 instances of KLNewType.
        /// </summary>
        public static int CompareByParentID(KLNewType kLNewType1, KLNewType kLNewType2)
        {
            return kLNewType1.ParentID.CompareTo(kLNewType2.ParentID);
        }

        #endregion


    }

}
