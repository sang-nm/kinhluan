using CanhCam.Business;
using CanhCam.Web.Framework;
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CanhCam.Web.CustomUI
{
    public partial class KLBookPosted : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLBookPosted));
        RadGridSEOPersister gridPersister;
        protected string EditPageUrl = "/Create-Book";
        KLAuthor author = null;
        SiteUser currentUser = null;
        string status = string.Empty;
        protected string siteroot = string.Empty;
        string search = string.Empty;
        public string Siteroot
        {
            get { return SiteRoot; }
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
            int iCount = KLBook.GetCount();
            int startRowIndex = isApplied ? 1 : grid.CurrentPageIndex + 1;
            int maximumRows = isApplied ? iCount : grid.PageSize;
            grid.VirtualItemCount = iCount;
            grid.AllowCustomPaging = !isApplied;
            grid.DataSource = KLBook.GetPageByAuthorid(startRowIndex, maximumRows, out iCount, author.AuthorID, txtsearch.Text);
        }

        private void Btncreate_Click(object sender, EventArgs e)
        {
            WebUtils.SetupRedirect(this, SiteRoot + "/create-book");
        }

        private void Btndelete_Click(object sender, EventArgs e)
        {
            try
            {
                bool isdeleted = false;

                foreach (GridDataItem data in grid.SelectedItems)
                {
                    int bookid = Convert.ToInt32(data.GetDataKeyValue("BookID"));
                    KLBook book = new KLBook(bookid);
                    if (book != null && book.BookID != -1)
                    {
                        KLBook.Delete(book.BookID);
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

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadParams();
        }

        private void LoadParams()
        {
            currentUser = SiteUtils.GetCurrentSiteUser();
            if (currentUser !=null)
            {
                author = KLAuthor.GetKLAuthorByUserID(currentUser.UserId);
            }
            else
            {
                WebUtils.SetupRedirect(this, SiteRoot);
            }
        }
        private void grid_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            grid.PagerStyle.EnableSEOPaging = false;
            bool isApplied = gridPersister.IsAppliedSortFilterOrGroup;
            int iCount = KLBook.GetCount();
            int startRowIndex = isApplied ? 1 : grid.CurrentPageIndex + 1;
            int maximumRows = isApplied ? iCount : grid.PageSize;
            grid.VirtualItemCount = iCount;
            grid.AllowCustomPaging = !isApplied;
            grid.DataSource = KLBook.GetPageByAuthorid(startRowIndex, maximumRows, out iCount,author.AuthorID,"");
        }
    }
}