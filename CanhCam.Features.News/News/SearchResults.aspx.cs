/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2014-09-02
/// Last Modified:			2015-04-01

using log4net;
using CanhCam.Business;
using CanhCam.Business.WebHelpers;
using CanhCam.Web.Framework;
using CanhCam.SearchIndex;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Threading;
using System.Web.UI.WebControls;
using CanhCam.Web.UI;
using System.Xml;

namespace CanhCam.Web.NewsUI
{

    public partial class SearchResults : CmsBasePage
    {

        private static readonly ILog log = LogManager.GetLogger(typeof(SearchResults));

        private string query = string.Empty;
        private int pageNumber = 1;
        private int pageSize = WebConfigSettings.SearchResultsPageSize;
        private int totalHits = 0;
        private int totalPages = 1;
        private bool indexVerified = false;
        private bool isSiteEditor = false;
        private bool queryErrorOccurred = false;
        private TimeZoneInfo timeZone = null;
        private double timeOffset;

        #region OnInit

        override protected void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(this.Page_Load);
            this.btnDoSearch.Click += new EventHandler(btnDoSearch_Click);
            btnRebuildSearchIndex.Click += new EventHandler(btnRebuildSearchIndex_Click);

            if (WebConfigSettings.ShowLeftColumnOnSearchResults) { StyleCombiner.AlwaysShowLeftColumn = true; }
            if (WebConfigSettings.ShowRightColumnOnSearchResults) { StyleCombiner.AlwaysShowRightColumn = true; }
        }

        #endregion

        private void Page_Load(object sender, EventArgs e)
        {
            if (SiteUtils.SslIsAvailable()) { SiteUtils.ForceSsl(); }

            LoadSettings();

            this.query = string.Empty;

            if (siteSettings == null)
            {
                siteSettings = CacheHelper.GetCurrentSiteSettings();
            }

            PopulateLabels();

            string primarySearchProvider = SiteUtils.GetPrimarySearchProvider();

            switch (primarySearchProvider)
            {
                case "google":
                    pnlInternalSearch.Visible = false;
                    pnlBingSearch.Visible = false;
                    pnlGoogleSearch.Visible = true;
                    gcs.Visible = true;

                    break;

                case "bing":
                    pnlInternalSearch.Visible = false;
                    pnlBingSearch.Visible = true;
                    pnlGoogleSearch.Visible = false;
                    bingSearch.Visible = true;
                    break;

                case "internal":
                default:

                    if (WebConfigSettings.DisableSearchIndex)
                    {
                        WebUtils.SetupRedirect(this, SiteUtils.GetNavigationSiteRoot());
                        return;
                    }

                    pnlInternalSearch.Visible = true;
                    pnlBingSearch.Visible = false;
                    pnlGoogleSearch.Visible = false;
                    SetupInternalSearch();
                    break;
            }

            SetupViewModeControls(false, false);
            LoadAltContent(displaySettings.IncludeTopContent, displaySettings.IncludeBottomContent, displaySettings.PageId);
            LoadSideContent(displaySettings.IncludeLeftContent, displaySettings.IncludeRightContent, displaySettings.PageId);
        }

        private void SetupInternalSearch()
        {
            if (SiteUtils.ShowAlternateSearchIfConfigured())
            {
                string bingApiId = SiteUtils.GetBingApiId();
                string googleCustomSearchId = SiteUtils.GetGoogleCustomSearchId();
                if ((bingApiId.Length > 0) || (googleCustomSearchId.Length > 0)) { spnAltSearchLinks.Visible = true; }

                lnkBingSearch.Visible = (bingApiId.Length > 0);
                lnkGoogleSearch.Visible = (googleCustomSearchId.Length > 0);
            }

            // got here by a cross page postback from another page if Page.PreviousPage is not null
            // this occurs when the search input is used in the skin rather than the search link
            if (Page.PreviousPage != null)
            {
                HandleCrossPagePost();
            }
            else
            {
                DoSearch();
            }

            txtSearchInput.Focus();
        }

        private void HandleCrossPagePost()
        {
            SearchInput previousPageSearchInput = (SearchInput)PreviousPage.Master.FindControl("SearchInput1");
            // try in page if not found in masterpage
            if (previousPageSearchInput == null) { previousPageSearchInput = (SearchInput)PreviousPage.FindControl("SearchInput1"); }

            if (previousPageSearchInput != null)
            {
                TextBox prevSearchTextBox = (TextBox)previousPageSearchInput.FindControl("txtSearch");
                if ((prevSearchTextBox != null) && (prevSearchTextBox.Text.Length > 0))
                {
                    //this.txtSearchInput.Text = prevSearchTextBox.Text;
                    WebUtils.SetupRedirect(this, SiteRoot + "/News/SearchResults.aspx?q=" + Server.UrlEncode(prevSearchTextBox.Text));
                    return;
                }
            }

            DoSearch();
        }

        private List<string> GetUserRoles()
        {
            List<string> userRoles = new List<string>();

            userRoles.Add("All Users");
            if (Request.IsAuthenticated)
            {
                SiteUser currentUser = SiteUtils.GetCurrentSiteUser();
                if (currentUser != null)
                {
                    using (IDataReader reader = SiteUser.GetRolesByUser(siteSettings.SiteId, currentUser.UserId))
                    {
                        while (reader.Read())
                        {
                            userRoles.Add(reader["RoleName"].ToString());
                        }
                    }
                }
            }

            return userRoles;
        }

        private void DoSearch()
        {
            if (Page.IsPostBack) { return; }

            if (Request.QueryString.Get("q") == null) { return; }

            query = Request.QueryString.Get("q");

            if (this.query.Length == 0) { return; }

            //txtSearchInput.Text = Server.HtmlEncode(query).Replace("&quot;", "\"") ;
            txtSearchInput.Text = SecurityHelper.SanitizeHtml(query);
            if (WebConfigSettings.EscapingSpecialCharactersInKeyword)
            {
                query = query.Replace("-", "\\-");
            }

            queryErrorOccurred = false;

            CanhCam.SearchIndex.IndexItemCollection searchResults = CanhCam.SearchIndex.IndexHelper.Search(
                siteSettings.SiteId,
                isSiteEditor,
                GetUserRoles(),
                News.FeatureGuid,
                CultureInfo.CurrentUICulture.Name,
                DateTime.MinValue,
                DateTime.MaxValue,
                query,
                WebConfigSettings.EnableSearchResultsHighlighting,
                WebConfigSettings.SearchResultsFragmentSize,
                pageNumber,
                pageSize,
                WebConfigSettings.SearchMaxClauseCount,
                out totalHits,
                out queryErrorOccurred);

            XmlDocument doc = new XmlDocument();
            doc.LoadXml("<NewsList></NewsList>");
            XmlElement root = doc.DocumentElement;

            XmlHelper.AddNode(doc, root, "SiteRoot", SiteRoot);
            XmlHelper.AddNode(doc, root, "TotalNews", totalHits.ToString());
            XmlHelper.AddNode(doc, root, "Keyword", Server.HtmlEncode(query));
            XmlHelper.AddNode(doc, root, "ProductText", ResourceHelper.GetResourceString("ProductResources", "ProductFeatureName"));
            XmlHelper.AddNode(doc, root, "NewsText", ResourceHelper.GetResourceString("NewsResources", "NewsFeatureName"));

            if (searchResults.Count == 0)
            {
                if (InitIndexIfNeeded())
                    return;

                if (txtSearchInput.Text.Length > 0)
                {
                    string noResults = Resources.NewsResources.SearchResultsNotFound;
                    if (queryErrorOccurred) noResults = ResourceHelper.GetResourceString("Resource", "SearchQueryInvalid");

                    XmlHelper.AddNode(doc, root, "NoResults", noResults);
                }
            }
            else
            {
                float duration = searchResults.ExecutionTime * 0.0000001F;
                string searchSumary = string.Format(Resources.NewsResources.SearchResultsFormat, totalHits.ToString(CultureInfo.InvariantCulture), Server.HtmlEncode(query), duration.ToString());

                XmlHelper.AddNode(doc, root, "SearchSumary", searchSumary);
                XmlHelper.AddNode(doc, root, "Duration", duration.ToString());

                totalPages = 1;

                if (pageSize > 0) { totalPages = totalHits / pageSize; }

                if (totalHits <= pageSize)
                {
                    totalPages = 1;
                }
                else
                {
                    int remainder;
                    Math.DivRem(totalHits, pageSize, out remainder);
                    if (remainder > 0)
                    {
                        totalPages += 1;
                    }
                }

                string searchUrl = SiteRoot
                    + "/News/SearchResults.aspx?q=" + Server.UrlEncode(query)
                    + "&amp;p={0}";

                pgrTop.PageURLFormat = searchUrl;
                pgrTop.ShowFirstLast = true;
                pgrTop.CurrentIndex = pageNumber;
                pgrTop.PageSize = pageSize;
                pgrTop.PageCount = totalPages;
                pgrTop.Visible = (totalPages > 1);

                pgrBottom.PageURLFormat = searchUrl;
                pgrBottom.ShowFirstLast = true;
                pgrBottom.CurrentIndex = pageNumber;
                pgrBottom.PageSize = pageSize;
                pgrBottom.PageCount = totalPages;
                pgrBottom.Visible = (totalPages > 1);

                string newsGuids = string.Empty;
                string sepa = string.Empty;
                foreach (IndexItem item in searchResults)
                {
                    if (!newsGuids.ContainsCaseInsensitive(item.ItemGuid.ToString()))
                    {
                        newsGuids += sepa + item.ItemGuid.ToString();
                        sepa = ";";
                    }
                }

                if (newsGuids.Length > 0)
                {
                    List<News> lstNews = News.GetByGuids(siteSettings.SiteId, newsGuids, 1, WorkingCulture.LanguageId);
                    foreach (News news in lstNews)
                    {
                        XmlElement newsXml = doc.CreateElement("News");
                        root.AppendChild(newsXml);

                        NewsHelper.BuildNewsDataXml(doc, newsXml, news, timeZone, timeOffset, string.Empty);

                        if (WebConfigSettings.EnableSearchResultsHighlighting)
                        {
                            foreach (IndexItem item in searchResults)
                            {
                                if (item.ItemGuid == news.NewsGuid)
                                {
                                    XmlHelper.AddNode(doc, newsXml, "HighlightContent", item.Intro);

                                    break;
                                }
                            }
                        }
                    }
                }
            }

            XmlHelper.XMLTransform(xmlTransformer, SiteUtils.GetXsltBasePath("news", "NewsSearchResults.xslt"), doc);
        }

        private bool InitIndexIfNeeded()
        {
            if (indexVerified) { return false; }

            indexVerified = true;
            if (!CanhCam.SearchIndex.IndexHelper.VerifySearchIndex(siteSettings))
            {
                this.lblMessage.Text = ResourceHelper.GetResourceString("Resource", "SearchResultsBuildingIndexMessage");
                Thread.Sleep(5000); //wait 5 seconds
                SiteUtils.QueueIndexing();

                return true;
            }

            return false;
        }

        //private void ShowNoResults()
        //{
        //    if (queryErrorOccurred)
        //    {
        //        litNoResults.Text = ResourceHelper.GetResourceString("Resource", "SearchQueryInvalid");
        //    }

        //    divResults.Visible = false;
        //    pnlNoResults.Visible = (txtSearchInput.Text.Length > 0);
        //}

        private void btnDoSearch_Click(object sender, EventArgs e)
        {
            string redirectUrl = SiteRoot + "/News/SearchResults.aspx?q="
                    + Server.UrlEncode(this.txtSearchInput.Text);

            WebUtils.SetupRedirect(this, redirectUrl);
        }

        void btnRebuildSearchIndex_Click(object sender, EventArgs e)
        {
            IndexingQueue.DeleteAll();
            CanhCam.SearchIndex.IndexHelper.DeleteSearchIndex(siteSettings);
            CanhCam.SearchIndex.IndexHelper.VerifySearchIndex(siteSettings);

            this.lblMessage.Text = ResourceHelper.GetResourceString("Resource", "SearchResultsBuildingIndexMessage");
            Thread.Sleep(5000); //wait 5 seconds
            SiteUtils.QueueIndexing();
        }

        private void LoadSettings()
        {
            isSiteEditor = WebUser.IsAdminOrContentAdmin || (SiteUtils.UserIsSiteEditor());
            pageNumber = WebUtils.ParseInt32FromQueryString("p", true, 1);
            timeZone = SiteUtils.GetUserTimeZone();
            timeOffset = SiteUtils.GetUserTimeOffset();
        }

        private void PopulateLabels()
        {
            if (siteSettings == null) return;

            Title = SiteUtils.FormatPageTitle(siteSettings, ResourceHelper.GetResourceString("ProductResources", "SearchPageTitle"));
            heading.Text = ResourceHelper.GetResourceString("ProductResources", "SearchPageTitle");

            MetaDescription = string.Format(CultureInfo.InvariantCulture,
                ResourceHelper.GetResourceString("Resource", "MetaDescriptionSearchFormat"), siteSettings.SiteName);

            lblMessage.Text = string.Empty;
            btnDoSearch.Text = ResourceHelper.GetResourceString("Resource", "SearchButtonText");

            btnRebuildSearchIndex.Text = ResourceHelper.GetResourceString("Resource", "SearchRebuildIndexButton");
            UIHelper.AddConfirmationDialog(btnRebuildSearchIndex, ResourceHelper.GetResourceString("Resource", "SearchRebuildIndexWarning"));

            divDelete.Visible = (WebConfigSettings.ShowRebuildSearchIndexButtonToAdmins && WebUser.IsAdmin && ViewMode != PageViewMode.View);

            litAltSearchMessage.Text = ResourceHelper.GetResourceString("Resource", "AltSearchPrompt");
            lnkBingSearch.Text = ResourceHelper.GetResourceString("Resource", "SearchThisSiteWithBing");
            lnkBingSearch.NavigateUrl = SiteRoot + "/BingSearch.aspx";
            lnkGoogleSearch.Text = ResourceHelper.GetResourceString("Resource", "SearchThisSiteWithGoogle");
            lnkGoogleSearch.NavigateUrl = SiteRoot + "/GoogleSearch.aspx";

            //this page has no content other than nav
            SiteUtils.AddNoIndexFollowMeta(Page);

            AddClassToBody("searchresults newssearchresults");
        }
    }
}