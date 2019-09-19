using CanhCam.Business;
using CanhCam.Web.Framework;
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public partial class AuthorManagerComment : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLADDNews));
        KLAuthor author = null;
        int newID = -1;
        int totalpage = 0;
        int news = -1;
        string fillter = "";
        SiteUser current = null;
        int approved = -1;
        protected List<KLNewsComment> listcomment = null;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            ddlnew.SelectedIndexChanged += new EventHandler(Ddlnewtype_SelectedIndexChanged);
        }

        private void Ddlnewtype_SelectedIndexChanged(object sender, EventArgs e)
        {
            WebUtils.SetupRedirect(this, SiteRoot+ "/manage-comment?" + fillter + "NewsID=" + ddlnew.SelectedValue);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            PopulateLabels();
            LoadSettings();
            if (!IsPostBack)
            {

                PopulateControls();
            }
        }
        private void PopulateControls()
        {
            List<KLNews> lst = KLNews.GetPageByAuthor(1, 10000, out totalpage, author.AuthorID, "", false, true, false);
            foreach (var item in lst)
            {
                News temp = new News(siteSettings.SiteId, item.NewsID);
                item.Title = temp.Title;
                item.Datepost = temp.StartDate;
            }

            ddlnew.DataSource = lst;
            ddlnew.DataBind();
            ddlnew.SelectedValue = news.ToString();


        }

        protected virtual void PopulateLabels()
        {
            if (news != -1)
            {
                divfillter.Visible = false;
            }
        }

        protected virtual void LoadSettings()
        {
            current = SiteUtils.GetCurrentSiteUser();
            if (current != null)
            {
                news = WebUtils.ParseInt32FromQueryString("NewsID", news);
                author = KLAuthor.GetKLAuthorByUserID(current.UserId);
                if (author == null)
                {
                    WebUtils.SetupRedirect(this, SiteRoot);
                }
                listcomment = KLNewsComment.GetPageByAuthor(1,10000, out totalpage, author.AuthorID, approved, news, -1, -1);
                listviewComment.DataSource = listcomment.OrderBy(com=>com.IsPublish);
                listviewComment.DataBind();

                GeneralVariables.NameAuthor = current.Name;
                GeneralVariables.Level = author.LevelAuthor;
            }
            else
            {
                WebUtils.SetupRedirect(this, SiteRoot);
            }
        } 
        protected string getImageURL(int userid)
        {
            return AuthorHepper.GetAvatarAuthor(siteSettings.SiteId, userid);
        }

        protected bool getispublish(string ispub)
        {
            return !Convert.ToBoolean(ispub);
        }


        protected void listviewComment_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if(e.Item!=null)
            {
                ListViewDataItem dataItem = (ListViewDataItem)e.Item;
                Label lbCommentID = (Label)e.Item.FindControl("CommentID");
                try
                {
                    KLNewsComment com = new KLNewsComment(int.Parse(lbCommentID.Text));
                    KLNews news =new KLNews(com.NewsID,0);
                    if (String.Equals(e.CommandName.ToLower(), "approve"))
                    {

                        news.CommentCount = news.CommentCount + 1;
                        com.IsPublish = true;
                    }
                    else if (String.Equals(e.CommandName.ToLower(), "delete"))
                    {

                        int index = e.Item.DisplayIndex;
                        listviewComment.DeleteItem(index);
                        news.CommentCount = news.CommentCount - 1;
                        com.IsPublish = false;
                        com.ISDel = true;
                    }
                    news.Save();
                    com.Save();
                }
                catch (Exception)
                {
                }
               
            }
            
            WebUtils.SetupRedirect(this, Request.RawUrl);
        }

        protected void listviewComment_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {

        }
    }
}