
// Author:					Ngo ba khanh
// Created:					2017-7-25
// Last Modified:			2017-7-25

using System;
using System.Collections.Generic;
using System.Data;
using CanhCam.Data;

namespace CanhCam.Business
{

    public class KLLevel
    {

        #region Constructors

        public KLLevel()
        { }


        public KLLevel(
            int levelID)
        {
            this.GetKLLevel(
                levelID);
        }

        #endregion

        #region Private Properties

        private int levelID = -1;
        private string name = string.Empty;
        private int from = -1;
        private string to = string.Empty;

        #endregion

        #region Public Properties

        public int LevelID
        {
            get { return levelID; }
            set { levelID = value; }
        }
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        public int From
        {
            get { return from; }
            set { from = value; }
        }
        public string To
        {
            get { return to; }
            set { to = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLLevel.
        /// </summary>
        /// <param name="levelID"> levelID </param>
        private void GetKLLevel(
            int levelID)
        {
            using (IDataReader reader = DBKLLevel.GetOne(
                levelID))
            {
                if (reader.Read())
                {
                    this.levelID = Convert.ToInt32(reader["LevelID"]);
                    this.name = reader["Name"].ToString();
                    this.from = Convert.ToInt32(reader["From"]);
                    this.to = reader["To"].ToString();
                }
            }

        }

        /// <summary>
        /// Persists a new instance of KLLevel. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLLevel.Create(
                this.name,
                this.from,
                this.to);

            this.levelID = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLLevel. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLLevel.Update(
                this.levelID,
                this.name,
                this.from,
                this.to);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLLevel. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            if (this.levelID > 0)
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
        /// Deletes an instance of KLLevel. Returns true on success.
        /// </summary>
        /// <param name="levelID"> levelID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int levelID)
        {
            return DBKLLevel.Delete(
                levelID);
        }


        /// <summary>
        /// Gets a count of KLLevel. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLLevel.GetCount();
        }

        private static List<KLLevel> LoadListFromReader(IDataReader reader)
        {
            List<KLLevel> kLLevelList = new List<KLLevel>();
            try
            {
                while (reader.Read())
                {
                    KLLevel kLLevel = new KLLevel();
                    kLLevel.levelID = Convert.ToInt32(reader["LevelID"]);
                    kLLevel.name = reader["Name"].ToString();
                    kLLevel.from = Convert.ToInt32(reader["From"]);
                    kLLevel.to = reader["To"].ToString();
                    kLLevelList.Add(kLLevel);

                }
            }
            finally
            {
                reader.Close();
            }

            return kLLevelList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLLevel.
        /// </summary>
        public static List<KLLevel> GetAll()
        {
            IDataReader reader = DBKLLevel.GetAll();
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLLevel.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLLevel> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLLevel.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }



        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLLevel.
        /// </summary>
        public static int CompareByLevelID(KLLevel kLLevel1, KLLevel kLLevel2)
        {
            return kLLevel1.LevelID.CompareTo(kLLevel2.LevelID);
        }
        /// <summary>
        /// Compares 2 instances of KLLevel.
        /// </summary>
        public static int CompareByName(KLLevel kLLevel1, KLLevel kLLevel2)
        {
            return kLLevel1.Name.CompareTo(kLLevel2.Name);
        }
        /// <summary>
        /// Compares 2 instances of KLLevel.
        /// </summary>
        public static int CompareByFrom(KLLevel kLLevel1, KLLevel kLLevel2)
        {
            return kLLevel1.From.CompareTo(kLLevel2.From);
        }
        /// <summary>
        /// Compares 2 instances of KLLevel.
        /// </summary>
        public static int CompareByTo(KLLevel kLLevel1, KLLevel kLLevel2)
        {
            return kLLevel1.To.CompareTo(kLLevel2.To);
        }

        #endregion


    }

}
