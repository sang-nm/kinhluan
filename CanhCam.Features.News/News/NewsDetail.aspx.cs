/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2015-01-30

using System;
using CanhCam.Web.Framework;
using CanhCam.Business;
using System.Web;
using System.Web.UI;
using log4net;
using CanhCam.Business.WebHelpers;
using System.Collections;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsDetail : CmsBasePage
    {
        #region OnInit

        private static readonly ILog log = LogManager.GetLogger(typeof(NewsDetail));

        protected override void OnPreInit(EventArgs e)
        {
            AllowSkinOverride = true;
            base.OnPreInit(e);
        }

        override protected void OnInit(EventArgs e)
        {
            this.Load += new EventHandler(this.Page_Load);

            base.OnInit(e);
        }

        #endregion

        private void Page_Load(object sender, EventArgs e)
        {
            if (!CurrentZone.AllowBrowserCache)
            {
                SecurityHelper.DisableBrowserCache();
            }

            bool redirected = RedirectIfNeeded();
            if (redirected) { return; }

            // Modified: 2015-01-30 Load all contents from Center Pane
            bool isAdmin = WebUser.IsAdmin;
            bool isContentAdmin = false;
            bool isSiteEditor = false;
            if (!isAdmin)
            {
                isContentAdmin = WebUser.IsContentAdmin;
                isSiteEditor = SiteUtils.UserIsSiteEditor();
            }

            bool forceShowViewMode = false;
            bool forceShowWorkflow = false;
            bool enabledWorkflow = WebConfigSettings.EnableContentWorkflow && siteSettings.EnableContentWorkflow;

            NewsConfiguration config = null;
            foreach (Module module in CurrentPage.Modules)
            {
                if (StringHelper.IsCaseInsensitiveMatch(module.PaneName, "contentpane")
                    && StringHelper.IsCaseInsensitiveMatch(module.ControlSource, "News/NewsModule.ascx"))
                {
                    Hashtable settings = CacheHelper.GetModuleSettings(module.ModuleId);
                    config = new NewsConfiguration(settings);
                    break;
                }
            }

            foreach (Module module in CurrentPage.Modules)
            {
                if (StringHelper.IsCaseInsensitiveMatch(module.PaneName, "contentpane"))
                {
                    if (config == null || !config.ShowHiddenContents)
                        if (!ModuleIsVisible(module)) { continue; }

                    if (
                        (!WebUser.IsInRoles(module.ViewRoles))
                        && (!isContentAdmin)
                        && (!isSiteEditor)
                        )
                    {
                        continue;
                    }

                    if ((module.ViewRoles == "Admins;") && (!isAdmin)) { continue; }

                    if (!ShouldShowModule(module)) { continue; }

                    Control parent = this.MPContent;

                    if ((module.CacheTime == 0) || (WebConfigSettings.DisableContentCache))
                    {
                        try
                        {
                            Control c = Page.LoadControl("~/" + module.ControlSource);
                            if (c == null) { continue; }

                            if (c is NewsModule)
                            {
                                NewsModule siteModule = (NewsModule)c;
                                siteModule.SiteId = siteSettings.SiteId;
                                siteModule.ModuleConfiguration = module;
                                siteModule.ForceLoadDetail = true;

                                if (
                                    Request.IsAuthenticated
                                    && siteModule.UserHasPermission()
                                    )
                                {
                                    forceShowViewMode = true;
                                    forceShowWorkflow = enabledWorkflow;
                                }

                                parent.Controls.Add(c);
                            }
                            else if (c is SiteModuleControl)
                            {
                                if (
                                    !(config != null && config.HideOtherContentsOnDetailPage)
                                    || (config != null && config.ShowHiddenContents && module.HideFromAuthenticated && module.HideFromUnauthenticated)
                                    )
                                {
                                    SiteModuleControl siteModule = (SiteModuleControl)c;
                                    siteModule.SiteId = siteSettings.SiteId;
                                    siteModule.ModuleConfiguration = module;

                                    if (
                                        Request.IsAuthenticated
                                        && siteModule.UserHasPermission()
                                        )
                                    {
                                        forceShowViewMode = true;
                                        if (enabledWorkflow && siteModule is IWorkflow)
                                            forceShowWorkflow = true;
                                    }

                                    parent.Controls.Add(c);
                                }
                            }
                        }
                        catch (HttpException ex)
                        {
                            log.Error("failed to load control " + module.ControlSource, ex);
                        }
                    }
                    else
                    {
                        CachedSiteModuleControl siteModule = new CachedSiteModuleControl();

                        siteModule.SiteId = siteSettings.SiteId;
                        siteModule.ModuleConfiguration = module;
                        parent.Controls.Add(siteModule);
                    }

                    parent.Visible = true;
                    parent.Parent.Visible = true;
                }
            } //end foreach

            SetupViewModeControls(forceShowViewMode, forceShowWorkflow);

            AddClassToBody("news-detail-page");
        }

        private bool RedirectIfNeeded()
        {
            if (!UserCanViewZone())
            {
                if (!Request.IsAuthenticated)
                {
                    if (WebConfigSettings.UseRawUrlForCmsPageLoginRedirects)
                    {
                        SiteUtils.RedirectToLoginPage(this);
                    }
                    else
                    {
                        SiteUtils.RedirectToLoginPage(this, SiteUtils.GetCurrentZoneUrl());
                    }
                    return true;

                }
                else
                {
                    SiteUtils.RedirectToAccessDeniedPage(this);
                    return true;
                }
            }

            return false;
        }

        protected override void OnError(EventArgs e)
        {
            Exception lastError = Server.GetLastError();
            if ((lastError != null) && (lastError is NullReferenceException) && Page.IsPostBack)
            {
                if (lastError.StackTrace.Contains("Recaptcha"))
                {
                    Server.ClearError();
                    WebUtils.SetupRedirect(this, Request.RawUrl);
                }
            }
        }
    }
}