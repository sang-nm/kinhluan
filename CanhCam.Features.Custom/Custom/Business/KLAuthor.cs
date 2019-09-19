using CanhCam.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Business
{
    public class KLAuthor
    {

        #region Constructors

        public KLAuthor()
        { }


        public KLAuthor(
            int authorID)
        {
            this.GetKLAuthor(
                authorID);
        }

        #endregion

        #region Private Properties

        private int authorID = -1;
        private int userID = -1;
        private string name = string.Empty;
        private string avatar = string.Empty;
        private string levelAuthor = string.Empty;
        private string linkFacebook = string.Empty;
        private string linkTwitter = string.Empty;
        private string linkPinterest = string.Empty;
        private string linkInstagram = string.Empty;
        private DateTime joinDate = DateTime.Now;
        private int articleCount = -1;
        private bool isDel = false;
        private bool isActive = false;

        #endregion

        #region Public Properties

        public int AuthorID
        {
            get { return authorID; }
            set { authorID = value; }
        }
        public int UserID
        {
            get { return userID; }
            set { userID = value; }
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
        public string LevelAuthor
        {
            get { return levelAuthor; }
            set { levelAuthor = value; }
        }
        public string LinkFacebook
        {
            get { return linkFacebook; }
            set { linkFacebook = value; }
        }
        public string LinkTwitter
        {
            get { return linkTwitter; }
            set { linkTwitter = value; }
        }
        public string LinkPinterest
        {
            get { return linkPinterest; }
            set { linkPinterest = value; }
        }
        public string LinkInstagram
        {
            get { return linkInstagram; }
            set { linkInstagram = value; }
        }
        public DateTime JoinDate
        {
            get { return joinDate; }
            set { joinDate = value; }
        }
        public int ArticleCount
        {
            get { return articleCount; }
            set { articleCount = value; }
        }
        public bool IsDel
        {
            get { return isDel; }
            set { isDel = value; }
        }
        public bool IsActive
        {
            get { return isActive; }
            set { isActive = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLAuthor.
        /// </summary>
        /// <param name="authorID"> authorID </param>
        private void GetKLAuthor(
            int authorID)
        {
            using (IDataReader reader = DBKLAuthor.GetOne(
                authorID))
            {
                if (reader.Read())
                {
                    this.authorID = Convert.ToInt32(reader["AuthorID"]);
                    this.userID = Convert.ToInt32(reader["UserID"]);
                    this.name = reader["Name"].ToString();
                    this.avatar = reader["Avatar"].ToString();
                    this.levelAuthor = reader["LevelAuthor"].ToString();
                    this.linkFacebook = reader["LinkFacebook"].ToString();
                    this.linkTwitter = reader["LinkTwitter"].ToString();
                    this.linkPinterest = reader["LinkPinterest"].ToString();
                    this.linkInstagram = reader["LinkInstagram"].ToString();
                    this.joinDate = Convert.ToDateTime(reader["JoinDate"]);
                    this.articleCount = Convert.ToInt32(reader["ArticleCount"]);
                    this.isDel = Convert.ToBoolean(reader["IsDel"]);
                    this.isActive = Convert.ToBoolean(reader["IsActive"]);
                }
            }

        }

        public static KLAuthor GetKLAuthorByUserID(
            int UserID)
        {
            KLAuthor author = new KLAuthor();
            using (IDataReader reader = DBKLAuthor.GetOneByUserID(
                UserID))
            {
                if (reader.Read())
                {
                    author.authorID = Convert.ToInt32(reader["AuthorID"]);
                    author.userID = Convert.ToInt32(reader["UserID"]);
                    author.name = reader["Name"].ToString();
                    author.avatar = reader["Avatar"].ToString();
                    author.levelAuthor = reader["LevelAuthor"].ToString();
                    author.linkFacebook = reader["LinkFacebook"].ToString();
                    author.linkTwitter = reader["LinkTwitter"].ToString();
                    author.linkPinterest = reader["LinkPinterest"].ToString();
                    author.linkInstagram = reader["LinkInstagram"].ToString();
                    author.joinDate = Convert.ToDateTime(reader["JoinDate"]);
                    author.articleCount = Convert.ToInt32(reader["ArticleCount"]);
                    author.isDel = Convert.ToBoolean(reader["IsDel"]);
                    author.isActive = Convert.ToBoolean(reader["IsActive"]);
                }
            }
            return author;
        }

        /// <summary>
        /// Persists a new instance of KLAuthor. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLAuthor.Create(
                this.userID,
                this.name,
                this.avatar,
                this.levelAuthor,
                this.linkFacebook,
                this.linkTwitter,
                this.linkPinterest,
                this.linkInstagram,
                this.joinDate,
                this.articleCount,
                this.isDel,
                this.isActive);

            this.authorID = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLAuthor. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLAuthor.Update(
                this.authorID,
                this.userID,
                this.name,
                this.avatar,
                this.levelAuthor,
                this.linkFacebook,
                this.linkTwitter,
                this.linkPinterest,
                this.linkInstagram,
                this.joinDate,
                this.articleCount,
                this.isDel,
                this.isActive);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLAuthor. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            if (this.authorID > 0)
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
        /// Deletes an instance of KLAuthor. Returns true on success.
        /// </summary>
        /// <param name="authorID"> authorID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int authorID)
        {
            return DBKLAuthor.Delete(
                authorID);
        }


        /// <summary>
        /// Gets a count of KLAuthor. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLAuthor.GetCount();
        }

        private static List<KLAuthor> LoadListFromReader(IDataReader reader)
        {
            List<KLAuthor> kLAuthorList = new List<KLAuthor>();
            try
            {
                while (reader.Read())
                {
                    KLAuthor kLAuthor = new KLAuthor();
                    kLAuthor.authorID = Convert.ToInt32(reader["AuthorID"]);
                    kLAuthor.userID = Convert.ToInt32(reader["UserID"]);
                    kLAuthor.name = reader["Name"].ToString();
                    kLAuthor.avatar = reader["Avatar"].ToString();
                    kLAuthor.levelAuthor = reader["LevelAuthor"].ToString();
                    kLAuthor.linkFacebook = reader["LinkFacebook"].ToString();
                    kLAuthor.linkTwitter = reader["LinkTwitter"].ToString();
                    kLAuthor.linkPinterest = reader["LinkPinterest"].ToString();
                    kLAuthor.linkInstagram = reader["LinkInstagram"].ToString();
                    kLAuthor.joinDate = Convert.ToDateTime(reader["JoinDate"]);
                    kLAuthor.articleCount = Convert.ToInt32(reader["ArticleCount"]);
                    kLAuthor.isDel = Convert.ToBoolean(reader["IsDel"]);
                    kLAuthor.isActive = Convert.ToBoolean(reader["IsActive"]);
                    kLAuthorList.Add(kLAuthor);

                }
            }
            finally
            {
                reader.Close();
            }

            return kLAuthorList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLAuthor.
        /// </summary>
        public static List<KLAuthor> GetAll()
        {
            IDataReader reader = DBKLAuthor.GetAll();
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLAuthor.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLAuthor> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLAuthor.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }


        public static List<KLAuthor> GetPageIsActive(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLAuthor.GetPageIsActive(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }

        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByAuthorID(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.AuthorID.CompareTo(kLAuthor2.AuthorID);
        }
        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByUserID(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.UserID.CompareTo(kLAuthor2.UserID);
        }
        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByName(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.Name.CompareTo(kLAuthor2.Name);
        }
        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByAvatar(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.Avatar.CompareTo(kLAuthor2.Avatar);
        }
        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByLevelAuthor(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.LevelAuthor.CompareTo(kLAuthor2.LevelAuthor);
        }
        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByLinkFacebook(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.LinkFacebook.CompareTo(kLAuthor2.LinkFacebook);
        }
        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByLinkTwitter(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.LinkTwitter.CompareTo(kLAuthor2.LinkTwitter);
        }
        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByLinkPinterest(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.LinkPinterest.CompareTo(kLAuthor2.LinkPinterest);
        }
        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByLinkInstagram(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.LinkInstagram.CompareTo(kLAuthor2.LinkInstagram);
        }
        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByJoinDate(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.JoinDate.CompareTo(kLAuthor2.JoinDate);
        }
        /// <summary>
        /// Compares 2 instances of KLAuthor.
        /// </summary>
        public static int CompareByArticleCount(KLAuthor kLAuthor1, KLAuthor kLAuthor2)
        {
            return kLAuthor1.ArticleCount.CompareTo(kLAuthor2.ArticleCount);
        }

        #endregion


    }
}