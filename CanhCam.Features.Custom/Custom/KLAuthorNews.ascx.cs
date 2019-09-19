using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using CanhCam.Business;
using CanhCam.Web.Framework;

namespace CanhCam.Web.CustomUI
{
    public partial class KLAuthorNews : SiteModuleControl
    {

        private static readonly ILog log = LogManager.GetLogger(typeof(KLADDNews));
        RadGridSEOPersister gridPersister;
        private string editPageUrl = "/create-news";
        KLAuthor author = null;
        string status = string.Empty;
        protected string siteroot = string.Empty;
        bool isapproved = false;
        bool isdraft = false;
        bool all = false;
        string search = string.Empty;
        public string Siteroot
        {
            get { return SiteRoot; } 
        }
        public string EditPageUrl
        {
            get { return Page.ResolveUrl(editPageUrl); }
            set { editPageUrl = value; }
        }
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            gridPersister = new RadGridSEOPersister(grid);
            grid.NeedDataSource += new GridNeedDataSourceEventHandler(grid_NeedDataSource);
            btncreate.Click += new EventHandler(Btncreate_Click);
            btndelete.Click += new EventHandler(Btndelete_Click);
            btnsearch.Click += new EventHandler(Btnsearch_Click);
        }

        private void Btnsearch_Click(object sender, EventArgs e)
        {

            grid.PagerStyle.EnableSEOPaging = false;
            bool isApplied = gridPersister.IsAppliedSortFilterOrGroup;
            int iCount = KLNews.GetCount();
            int startRowIndex = isApplied ? 1 : grid.CurrentPageIndex + 1;
            int maximumRows = isApplied ? iCount : grid.PageSize;
            grid.VirtualItemCount = iCount;
            grid.AllowCustomPaging = !isApplied;
            List<KLNews> lst = KLNews.GetPageByAuthor(startRowIndex, maximumRows, out iCount, author.AuthorID, txtsearch.Text, isdraft, isapproved, all);
            foreach (var item in lst)
            {
                News temp = new News(siteSettings.SiteId, item.NewsID);
                item.Title = temp.Title;
                item.Datepost = temp.StartDate;
            }
            grid.DataSource = lst;
            grid.Rebind();
        }

        private void Btndelete_Click(object sender, EventArgs e)
        {

            try
            {
                bool isdeleted = false;

                foreach (GridDataItem data in grid.SelectedItems)
                {
                    int newid = Convert.ToInt32(data.GetDataKeyValue("NewsID"));
                    News news = new News(siteSettings.SiteId, newid);
                    if (news != null && news.NewsID != -1)
                    {
                        news.IsDeleted = true;
                        news.IsPublished = false;
                        news.Save();
                    }
                    isdeleted = true;
                }

                if (isdeleted)
                {
                    SiteUtils.QueueIndexing();
                    CurrentPage.UpdateLastModifiedTime();
                    grid.Rebind();
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
        }

        private void Btncreate_Click(object sender, EventArgs e)
        {
            WebUtils.SetupRedirect(this, SiteRoot + "/create-news" );
        }

        private void grid_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            grid.PagerStyle.EnableSEOPaging = false;
            bool isApplied = gridPersister.IsAppliedSortFilterOrGroup;
            int iCount = KLNews.GetCount();
            int startRowIndex = isApplied ? 1 : grid.CurrentPageIndex + 1;
            int maximumRows = isApplied ? iCount : grid.PageSize;
            grid.VirtualItemCount = iCount;
            grid.AllowCustomPaging = !isApplied;
            List<KLNews> lst = KLNews.GetPageByAuthor(startRowIndex, maximumRows, out iCount,author.AuthorID,"", isdraft, isapproved,all);
            foreach (var item in lst)
            {
                News temp = new News(siteSettings.SiteId, item.NewsID);
                item.Title = temp.Title;
                item.Datepost = temp.StartDate;
            }
            grid.DataSource = lst;
        }
        private void PopulateControls()
        {

        }

        protected virtual void PopulateLabels()
        {
        }

        protected virtual void LoadSettings()
        {
            SiteUser site = SiteUtils.GetCurrentSiteUser();
            author = KLAuthor.GetKLAuthorByUserID(site.UserId);
            if (author == null)
            {
                WebUtils.SetupRedirect(this, SiteRoot);
            }
            GeneralVariables.NameAuthor = site.Name;
            GeneralVariables.Level = author.LevelAuthor;
            search = WebUtils.ParseStringFromQueryString("search", search);
            status = WebUtils.ParseStringFromQueryString("status", status);
            switch (status)
            {
                case "":
                    all = true;
                    break;
                case "draft":
                    isdraft = true;
                    isapproved = false;
                    break;

                case "posted":
                    isapproved = true;
                    isdraft = false;
                    break;

                case "pending":
                    isapproved = false;
                    break;
            }
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
        protected int getviewcount(int newsid)
        {
            News temp = new News(siteSettings.SiteId, newsid);
            return temp.Viewed;

        }
        protected int getcommentcount(int newsid)
        {
            return KLNewsComment.GetCountByNewsID(newsid);
        }
    }
}