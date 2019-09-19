using CanhCam.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CanhCam.Business
{
    public class KLNewsComment
    {

        #region Constructors

        public KLNewsComment()
        { }


        public KLNewsComment(
            int commentID)
        {
            this.GetKLNewsComment(
                commentID);
        }

        #endregion

        #region Private Properties

        private int commentID = -1;
        private int commentParentID = -1;
        private int newsID = -1;
        private int userID = -1;
        private string name = string.Empty;
        private string title = string.Empty;
        private string email = string.Empty;
        private DateTime createDate = DateTime.Now;
        private string phone = string.Empty;
        private string comment = string.Empty;
        private bool isPublish = false;
        private bool iSDel = false;

        private string newstitle = string.Empty;


        #endregion

        #region Public Properties

        public string Newstitle
        {
            get { return newstitle; }
            set { newstitle = value; }
        }
        public int CommentID
        {
            get { return commentID; }
            set { commentID = value; }
        }
        public int CommentParentID
        {
            get { return commentParentID; }
            set { commentParentID = value; }
        }
        public int NewsID
        {
            get { return newsID; }
            set { newsID = value; }
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
        public string Title
        {
            get { return title; }
            set { title = value; }
        }
        public string Email
        {
            get { return email; }
            set { email = value; }
        }
        public DateTime CreateDate
        {
            get { return createDate; }
            set { createDate = value; }
        }
        public string Phone
        {
            get { return phone; }
            set { phone = value; }
        }
        public string Comment
        {
            get { return comment; }
            set { comment = value; }
        }
        public bool IsPublish
        {
            get { return isPublish; }
            set { isPublish = value; }
        }
        public bool ISDel
        {
            get { return iSDel; }
            set { iSDel = value; }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Gets an instance of KLNewsComment.
        /// </summary>
        /// <param name="commentID"> commentID </param>
        private void GetKLNewsComment(
            int commentID)
        {
            using (IDataReader reader = DBKLNewsComment.GetOne(
                commentID))
            {
                if (reader.Read())
                {
                    this.commentID = Convert.ToInt32(reader["CommentID"]);
                    this.commentParentID = Convert.ToInt32(reader["CommentParentID"]);
                    this.newsID = Convert.ToInt32(reader["NewsID"]);
                    this.userID = Convert.ToInt32(reader["UserID"]);
                    this.name = reader["Name"].ToString();
                    this.title = reader["Title"].ToString();
                    this.email = reader["Email"].ToString();
                    this.createDate = Convert.ToDateTime(reader["CreateDate"]);
                    this.phone = reader["Phone"].ToString();
                    this.comment = reader["Comment"].ToString();
                    this.isPublish = Convert.ToBoolean(reader["IsPublish"]);
                    this.iSDel = Convert.ToBoolean(reader["ISDel"]);
                }
            }

        }

        /// <summary>
        /// Persists a new instance of KLNewsComment. Returns true on success.
        /// </summary>
        /// <returns></returns>
        private bool Create()
        {
            int newID = 0;

            newID = DBKLNewsComment.Create(
                this.commentParentID,
                this.newsID,
                this.userID,
                this.name,
                this.title,
                this.email,
                this.createDate,
                this.phone,
                this.comment,
                this.isPublish,
                this.iSDel);

            this.commentID = newID;

            return (newID > 0);

        }


        /// <summary>
        /// Updates this instance of KLNewsComment. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        private bool Update()
        {

            return DBKLNewsComment.Update(
                this.commentID,
                this.commentParentID,
                this.newsID,
                this.userID,
                this.name,
                this.title,
                this.email,
                this.createDate,
                this.phone,
                this.comment,
                this.isPublish,
                this.iSDel);

        }





        #endregion

        #region Public Methods

        /// <summary>
        /// Saves this instance of KLNewsComment. Returns true on success.
        /// </summary>
        /// <returns>bool</returns>
        public bool Save()
        {
            if (this.commentID > 0)
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
        /// Deletes an instance of KLNewsComment. Returns true on success.
        /// </summary>
        /// <param name="commentID"> commentID </param>
        /// <returns>bool</returns>
        public static bool Delete(
            int commentID)
        {
            return DBKLNewsComment.Delete(
                commentID);
        }


        /// <summary>
        /// Gets a count of KLNewsComment. 
        /// </summary>
        public static int GetCount()
        {
            return DBKLNewsComment.GetCount();
        }
        public static int GetCountByNewsID(int newsid)
        {
            return DBKLNewsComment.GetCountByNewsID(newsid);
        }
        private static List<KLNewsComment> LoadListFromReader(IDataReader reader)
        {
            List<KLNewsComment> kLNewsCommentList = new List<KLNewsComment>();
            try
            {
                while (reader.Read())
                {
                    KLNewsComment kLNewsComment = new KLNewsComment();
                    kLNewsComment.commentID = Convert.ToInt32(reader["CommentID"]);
                    kLNewsComment.commentParentID = Convert.ToInt32(reader["CommentParentID"]);
                    kLNewsComment.newsID = Convert.ToInt32(reader["NewsID"]);
                    kLNewsComment.userID = Convert.ToInt32(reader["UserID"]);
                    kLNewsComment.name = reader["Name"].ToString();
                    kLNewsComment.title = reader["Title"].ToString();
                    kLNewsComment.email = reader["Email"].ToString();
                    kLNewsComment.createDate = Convert.ToDateTime(reader["CreateDate"]);
                    kLNewsComment.phone = reader["Phone"].ToString();
                    kLNewsComment.comment = reader["Comment"].ToString();
                    kLNewsComment.isPublish = Convert.ToBoolean(reader["IsPublish"]);
                    kLNewsComment.iSDel = Convert.ToBoolean(reader["ISDel"]);
                    try
                    {
                        kLNewsComment.newstitle = Convert.ToString(reader["NewsTitle"]);
                    }
                    catch (Exception)
                    {
                    }
                    kLNewsCommentList.Add(kLNewsComment);

                }
            }
            finally
            {
                reader.Close();
            }

            return kLNewsCommentList;

        }

        /// <summary>
        /// Gets an IList with all instances of KLNewsComment.
        /// </summary>
        public static List<KLNewsComment> GetAll()
        {
            IDataReader reader = DBKLNewsComment.GetAll();
            return LoadListFromReader(reader);

        }

        /// <summary>
        /// Gets an IList with page of instances of KLNewsComment.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="totalPages">total pages</param>
        public static List<KLNewsComment> GetPage(int pageNumber, int pageSize, out int totalPages)
        {
            totalPages = 1;
            IDataReader reader = DBKLNewsComment.GetPage(pageNumber, pageSize, out totalPages);
            return LoadListFromReader(reader);
        }


        public static List<KLNewsComment> GetPageByAuthor(int pageNumber, int pageSize, out int totalPages, int authorid, int isapproved, int newsid, int newtype,int parent)
        {
            totalPages = 1;
            IDataReader reader = DBKLNewsComment.GetPageByAuthor(pageNumber, pageSize, out totalPages, authorid, isapproved, newsid, newtype, parent);
            return LoadListFromReader(reader);
        }

        #endregion

        #region Comparison Methods

        /// <summary>
        /// Compares 2 instances of KLNewsComment.
        /// </summary>
        public static int CompareByCommentID(KLNewsComment kLNewsComment1, KLNewsComment kLNewsComment2)
        {
            return kLNewsComment1.CommentID.CompareTo(kLNewsComment2.CommentID);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsComment.
        /// </summary>
        public static int CompareByCommentParentID(KLNewsComment kLNewsComment1, KLNewsComment kLNewsComment2)
        {
            return kLNewsComment1.CommentParentID.CompareTo(kLNewsComment2.CommentParentID);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsComment.
        /// </summary>
        public static int CompareByNewsID(KLNewsComment kLNewsComment1, KLNewsComment kLNewsComment2)
        {
            return kLNewsComment1.NewsID.CompareTo(kLNewsComment2.NewsID);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsComment.
        /// </summary>
        public static int CompareByUserID(KLNewsComment kLNewsComment1, KLNewsComment kLNewsComment2)
        {
            return kLNewsComment1.UserID.CompareTo(kLNewsComment2.UserID);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsComment.
        /// </summary>
        public static int CompareByName(KLNewsComment kLNewsComment1, KLNewsComment kLNewsComment2)
        {
            return kLNewsComment1.Name.CompareTo(kLNewsComment2.Name);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsComment.
        /// </summary>
        public static int CompareByTitle(KLNewsComment kLNewsComment1, KLNewsComment kLNewsComment2)
        {
            return kLNewsComment1.Title.CompareTo(kLNewsComment2.Title);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsComment.
        /// </summary>
        public static int CompareByEmail(KLNewsComment kLNewsComment1, KLNewsComment kLNewsComment2)
        {
            return kLNewsComment1.Email.CompareTo(kLNewsComment2.Email);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsComment.
        /// </summary>
        public static int CompareByCreateDate(KLNewsComment kLNewsComment1, KLNewsComment kLNewsComment2)
        {
            return kLNewsComment1.CreateDate.CompareTo(kLNewsComment2.CreateDate);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsComment.
        /// </summary>
        public static int CompareByPhone(KLNewsComment kLNewsComment1, KLNewsComment kLNewsComment2)
        {
            return kLNewsComment1.Phone.CompareTo(kLNewsComment2.Phone);
        }
        /// <summary>
        /// Compares 2 instances of KLNewsComment.
        /// </summary>
        public static int CompareByComment(KLNewsComment kLNewsComment1, KLNewsComment kLNewsComment2)
        {
            return kLNewsComment1.Comment.CompareTo(kLNewsComment2.Comment);
        }

        #endregion

    }
}