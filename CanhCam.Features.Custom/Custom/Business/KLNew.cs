using CanhCam.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Business
{
    public class KLNews
    {

        #region Constructors

        public KLNews()
        { }


        public KLNews(
            int KLNewsID)
        {
            this.GetKLNews(
                KLNewsID);
        }

        public KLNews(
            int NewsID,int temp=0)
        {
            this.GetKLNewsByMNewID(
                NewsID);
        }
        #endregion

        #region Private Properties

        private int kLNewID = -1;
        private int newsID = -1;
        private int authorID = -1;
        private int viewCount = -1;
        private int shareCount = -1;
        private int commentCount = -1;
        private int likeCount = -1;
        private string approvedBy = string.Empty;
        private string newapprovedBy = string.Empty;
        private DateTime datepost = DateTime.Now;
        private int newType = -1;
        private int newlsevel = -1;
        private int newstotalpoint = -1;
        private bool isdraft = false;
        private bool isapproved = false;


        private string title = string.Empty;
        private string fullContent = string.Empty;
        private string briefContent = string.Empty;
        private bool isDeleted = false;
        private bool isPublish = true;

        #endregion

        #region Public Properties

        public string Title
        {
            get { return title; }
            set { title = value; }
        }
        public DateTime Datepost
        {
            get { return datepost; }
            set { datepost = value; }
        }
        public string FullContent
        {
            get { return fullContent; }
            set { fullContent = value; }
        }
        public string BriefContent
        {
            get { return briefContent; }
            set { briefContent = value; }
        }
        public bool IsDeleted
        {
            get { return isDeleted; }
            set { isDeleted = value; }
        }
        public bool IsPublish
        {
            get { return isPublish; }
            set { isPublish = value; }
        }
        public int KLNewID
        {
            get { return kLNewID; }
            set { kLNewID = value; }
        }
        public int NewsID
        {
            get { return newsID; }
            set { newsID = value; }
        }
        public int AuthorID
        {
            get { return authorID; }
            set { authorID = value; }
        }
        public int ViewCount
        {
            get { return viewCount; }
            set { viewCount = value; }
        }
        public int ShareCount
        {
            get { return shareCount; }
            set { shareCount = value; }
        }
        public int CommentCount
        {
            get { return commentCount; }
            set { commentCount = value; }
        }
        public int LikeCount
        {
            get { return likeCount; }
            set { likeCount = value; }
        }
        public string ApprovedBy
        {
            get { return approvedBy; }
            set { approvedBy = value; }
        }
        public string NewApprovedBy
        {
            get { return newapprovedBy; }
            set { newapprovedBy = value; }
        }
        public int NewType
        {
            get { return newType; }
            set { newType = value; }
        }
        public int Newlsevel
        {
            get { return newlsevel; }
            set { newlsevel = value; }
        }
        public int Newstotalpoint
        {
            get { return newstotalpoint; }
            set { newstotalpoint = value; }
        }
        public bool Isdraft
        {
            get { return isdraft; }
            set { isdraft = value; }
        }
        public bool Isapproved
        {
            get { return isapproved; }
            set { isapproved = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLNew.
        /// </summary>
        /// <param name="kLNewID"> kLNewID </param>
        private void GetKLNews(
            int kLNewID)
        {
            using (IDataReader reader = DBKLNews.GetOne(
                kLNewID))
            {
                if (reader.Read())
                {
                    this.kLNewID = Convert.ToInt32(reader["KLNewID"]);
                    this.newsID = Convert.ToInt32(reader["NewsID"]);
                    this.authorID = Convert.ToInt32(reader["AuthorID"]);
                    this.viewCount = Convert.ToInt32(reader["ViewCount"]);
                    this.shareCount = Convert.ToInt32(reader["ShareCount"]);
                    this.commentCount = Convert.ToInt32(reader["CommentCount"]);
                    this.likeCount = Convert.ToInt32(reader["LikeCount"]);
                    this.approvedBy = reader["ApprovedBy"].ToString();
                    this.newType = Convert.ToInt32(reader["NewType"]);
                    this.newlsevel = Convert.ToInt32(reader["Newlsevel"]);
                    this.newstotalpoint = Convert.ToInt32(reader["Newstotalpoint"]);
                    this.isdraft = Convert.ToBoolean(reader["Isdraft"]);
                    this.isapproved = Convert.ToBoolean(reader["Isapproved"]);
                    //
                    //this.title = Convert.ToString(reader["KLTitle"]);
                    //this.fullContent = Convert.ToString(reader["KLFullContent"]);
                    //this.briefContent = Convert.ToString(reader["KLBriefContent"]);
                    //this.isDeleted = Convert.ToBoolean(reader["KLIsDeleted"]);
                    //this.isPublish = Convert.ToBoolean(reader["KLIsPublished"]);
                }
            }

        }
        private void GetKLNewsByMNewID(
           int kLNewID)
        {
            using (IDataReader reader = DBKLNews.GetOnebyNewID(
                kLNewID))
            {
                if (reader.Read())
                {
                    this.kLNewID = Convert.ToInt32(reader["KLNewID"]);
                    this.newsID = Convert.ToInt32(reader["NewsID"]);
                    this.authorID = Convert.ToInt32(reader["AuthorID"]);
                    this.viewCount = Convert.ToInt32(reader["ViewCount"]);
                    this.shareCount = Convert.ToInt32(reader["ShareCount"]);
                    this.commentCount = Convert.ToInt32(reader["CommentCount"]);
                    this.likeCount = Convert.ToInt32(reader["LikeCount"]);
                    this.approvedBy = reader["ApprovedBy"].ToString();
                    this.newType = Convert.ToInt32(reader["NewType"]);
                    this.newlsevel = Convert.ToInt32(reader["Newlsevel"]);
                    this.newstotalpoint = Convert.ToInt32(reader["Newstotalpoint"]);
                    this.isdraft = Convert.ToBoolean(reader["Isdraft"]);
                    this.isapproved = Convert.ToBoolean(reader["Isapproved"]);
                    //
                    //this.title = Convert.ToString(reader["KLTitle"]);
                    //this.fullContent = Convert.ToString(reader["KLFullContent"]);
                    //this.briefContent = Convert.ToString(reader["KLBriefContent"]);
                    //this.isDeleted = Convert.ToBoolean(reader["KLIsDeleted"]);
                    //this.isPublish = Convert.ToBoolean(reader["KLIsPublished"]);
                }
            }

        }
        /// <summary>
        /// Persists a new instance of KLNews. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLNews.Create(
                this.newsID,
                this.authorID,
                this.viewCount,
                this.shareCount,
                this.commentCount,
                this.likeCount,
                this.approvedBy,
                this.newType,
                this.newlsevel,
                this.newstotalpoint,
                this.isdraft,
                this.isapproved);

            this.kLNewID = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLNew. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLNews.Update(
                this.kLNewID,
                this.newsID,
                this.authorID,
                this.viewCount,
                this.shareCount,
                this.commentCount,
                this.likeCount,
                this.approvedBy,
                this.newType,
                this.newlsevel,
                this.newstotalpoint,
                this.isdraft,
                this.isapproved);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLNew. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            if (this.kLNewID > 0)
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
        /// Deletes an instance of KLNew. Returns true on success.
        /// </summary>
        /// <param name="kLNewID"> kLNewID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int kLNewID)
        {
            return DBKLNews.Delete(
                kLNewID);
        }


        /// <summary>
        /// Gets a count of KLNews. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLNews.GetCount();
        }

        private static List<KLNews> LoadListFromReader(IDataReader reader)
        {
            List<KLNews> KLNewList = new List<KLNews>();
            try
            {
                while (reader.Read())
                {
                    KLNews KLNew = new KLNews();
                    KLNew.kLNewID = Convert.ToInt32(reader["KLNewID"]);
                    KLNew.newsID = Convert.ToInt32(reader["NewsID"]);
                    KLNew.authorID = Convert.ToInt32(reader["AuthorID"]);
                    KLNew.viewCount = Convert.ToInt32(reader["ViewCount"]);
                    KLNew.shareCount = Convert.ToInt32(reader["ShareCount"]);
                    KLNew.commentCount = Convert.ToInt32(reader["CommentCount"]);
                    KLNew.likeCount = Convert.ToInt32(reader["LikeCount"]);
                    KLNew.approvedBy = reader["ApprovedBy"].ToString();
                    KLNew.newType = Convert.ToInt32(reader["NewType"]);
                    KLNew.newlsevel = Convert.ToInt32(reader["Newlsevel"]);
                    KLNew.newstotalpoint = Convert.ToInt32(reader["Newstotalpoint"]);
                    KLNew.isdraft = Convert.ToBoolean(reader["Isdraft"]);
                    //
                    try
                    {
                        KLNew.isapproved = Convert.ToBoolean(reader["Isapproved"]);
                        KLNew.Datepost = Convert.ToDateTime(reader["StartDate"]);
                        KLNew.title = Convert.ToString(reader["KLTitle"]);
                        KLNew.newapprovedBy = Convert.ToString(reader["NewsApprovedBy"]);
                    }
                    catch (Exception)
                    {
                    }
                    KLNewList.Add(KLNew);

                }
            }
            finally
            {
                reader.Close();
            }

            return KLNewList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLNew.
        /// </summary>
        public static List<KLNews> GetAll()
        {
            IDataReader reader = DBKLNews.GetAll();
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLNew.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLNews> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLNews.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }
        public static List<KLNews> GetPageByAuthor(int pageNumber, int pageSize, out int totalPages, int AuthorID, string keyword, bool isdraft,bool isapproved,bool all)
        {
            totalPages = 1;
            IDataReader reader = DBKLNews.GetPageByAuthor(pageNumber, pageSize, out totalPages,AuthorID,keyword,isdraft, isapproved, all);
            return LoadListFromReader(reader);
        }


        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByKLNewID(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.KLNewID.CompareTo(kLNew2.KLNewID);
        }
        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByNewsID(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.NewsID.CompareTo(kLNew2.NewsID);
        }
        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByAuthorID(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.AuthorID.CompareTo(kLNew2.AuthorID);
        }
        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByViewCount(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.ViewCount.CompareTo(kLNew2.ViewCount);
        }
        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByShareCount(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.ShareCount.CompareTo(kLNew2.ShareCount);
        }
        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByCommentCount(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.CommentCount.CompareTo(kLNew2.CommentCount);
        }
        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByLikeCount(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.LikeCount.CompareTo(kLNew2.LikeCount);
        }
        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByApprovedBy(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.ApprovedBy.CompareTo(kLNew2.ApprovedBy);
        }
        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByNewType(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.NewType.CompareTo(kLNew2.NewType);
        }
        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByNewlsevel(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.Newlsevel.CompareTo(kLNew2.Newlsevel);
        }
        /// <summary>
        /// Compares 2 instances of KLNew.
        /// </summary>
        public static int CompareByNewstotalpoint(KLNews kLNew1, KLNews kLNew2)
        {
            return kLNew1.Newstotalpoint.CompareTo(kLNew2.Newstotalpoint);
        }

        #endregion



    }
}