/// Created:			    2017-7-24
/// Last Modified:		    2017-7-24

using System;
using CanhCam.Web.Framework;
using CanhCam.Business;
using Resources;
using log4net;
using CanhCam.Business.WebHelpers;
using System.Web.UI;
using System.Data;
using System.Linq;
using Telerik.Web.UI;

namespace CanhCam.Web.CustomUI
{

    public partial class AuthorLevelEdit : CmsNonBasePage
    {

        private static readonly ILog log = LogManager.GetLogger(typeof(AuthorLevelEdit));
        protected int PageId = -1;
        protected int ModuleId = 76;
        private bool canEditAnything = false;
        private int languageId = -1;
        protected int levelId = -1;
        private KLLevel level = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                SiteUtils.RedirectToLoginPage(this);
                return;
            }

            SecurityHelper.DisableBrowserCache();

            LoadSettings();
            LoadParams();
            PopulateLabels();

            SecurityHelper.DisableBrowserCache();
            if (!IsPostBack)
            {
                PopulateData();
            }

            if (!Request.IsAuthenticated)
            {
                SiteUtils.RedirectToLoginPage(this);
                return;
            }
        }


        private void PopulateLabels()
        {
            Title = SiteUtils.FormatPageTitle(siteSettings, "Add/Edit Level");
            heading.Text = "Add/Edit Level";

            breadcrumb.ParentTitle = NewsResources.AuthorLevel;
            breadcrumb.ParentUrl = "~/News/AuthorLevelList.aspx";

            UIHelper.AddConfirmationDialog(btnDelete, NewsResources.NewsDeleteMultiWarning);

            //edFullContent.WebEditor.ToolBar = ToolBar.FullWithTemplates;
            //description.WebEditor.ToolBar = ToolBar.FullWithTemplates;
            //description.WebEditor.Height = Unit.Pixel(300);
        }

        private void PopulateData()
        {
            if (level != null)
            {
                txtName.Text = level.Name;
                txtFrom.Text = level.From.ToString();
                txtTo.Text = level.To;
                //ckDelete.Checked = newsType.IsDelected;
            }
        }


        private void LoadSettings()
        {
            languageId = WorkingCulture.LanguageId;
            canEditAnything = WebUser.IsAdminOrContentAdmin || SiteUtils.UserIsSiteEditor();
            AddClassToBody("AuthorLevel");
        }

        private void LoadParams()
        {
            PageId = WebUtils.ParseInt32FromQueryString("pageid", PageId);
            ModuleId = WebUtils.ParseInt32FromQueryString("mid", ModuleId);
            levelId = WebUtils.ParseInt32FromQueryString("LevelID", levelId);

            if (levelId > -1)
            {
                level = new KLLevel(levelId);
            }
            HideControls();
        }


        private void HideControls()
        {
            btnInsert.Visible = false;
            btnInsertAndNew.Visible = false;
            btnInsertAndClose.Visible = false;
            btnUpdate.Visible = false;
            btnUpdateAndNew.Visible = false;
            btnUpdateAndClose.Visible = false;
            btnDelete.Visible = false;

            if (level == null)
            {
                btnInsert.Visible = true;
                btnInsertAndNew.Visible = true;
                btnInsertAndClose.Visible = true;
            }
            else if (level != null && level.LevelID > 0)
            {
                btnUpdate.Visible = true;
                btnUpdateAndNew.Visible = true;
                btnUpdateAndClose.Visible = true;
                btnDelete.Visible = true;
            }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            btnDelete.Click += new EventHandler(btnDelete_Click);
            btnUpdate.Click += new EventHandler(btnUpdate_Click);

            this.btnUpdateAndNew.Click += new EventHandler(btnUpdateAndNew_Click);
            this.btnUpdateAndClose.Click += new EventHandler(btnUpdateAndClose_Click);
            this.btnInsert.Click += new EventHandler(btnInsert_Click);
            this.btnInsertAndNew.Click += new EventHandler(btnInsertAndNew_Click);
            this.btnInsertAndClose.Click += new EventHandler(btnInsertAndClose_Click);
        }

        void btnAdd_Click(object sender, EventArgs e)
        {

            //if (string.IsNullOrEmpty(txtCategoryName.Text.Trim()))
            //{
            //    message.ErrorMessage = CustomResources.CategoryNameRequiredLabel;
            //    return;
            //}

            //Category obj = new Category(txtCategoryName.Text.Trim().ToLower());
            //if (obj != null && obj.CategoryId > 0)
            //{
            //    message.ErrorMessage = CustomResources.CategoryExisted;
            //    return;
            //}
            //else
            //{
            //    obj = new Category();
            //    obj.CategoryName = txtCategoryName.Text.Trim();
            //    obj.DisplayOrder = -1;
            //    obj.CategoryGuid = Guid.NewGuid();
            //    if (obj.Save())
            //    {
            //        message.SuccessMessage = CustomResources.SaveSuccessful;
            //        grid.Rebind();
            //        txtCategoryName.Text = "";
            //    }
            //    else
            //    {
            //        message.ErrorMessage = CustomResources.SaveError;
            //        return;
            //    }
            //}

        }

        void btnInsert_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/News/AuthorLevelEdit.aspx?TypeID=" + nId.ToString());
            }
        }

        void btnInsertAndClose_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/News/AuthorLevelList.aspx");
            }
        }

        void btnInsertAndNew_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/News/AuthorLevelList.aspx");
            }
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/News/AuthorLevelEdit.aspx?LevelID=" + nId.ToString());
            }
        }

        void btnUpdateAndClose_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/News/AuthorLevelList.aspx");
            }
        }

        void btnUpdateAndNew_Click(object sender, EventArgs e)
        {

            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/News/AuthorLevelEdit.aspx");
            }
        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (level != null && level.LevelID > 0)
            {
                LogActivity.Write("Delete level ", level.Name);
                KLLevel.Delete(level.LevelID);
                WebUtils.SetupRedirect(this, SiteRoot + "/News/AuthorLevelList.aspx");

            }
        }

        private int Save()
        {
            Page.Validate("AuthorLevel");

            if (!Page.IsValid)
                return -1;


            if (level == null)
            {
                level = new KLLevel();
            }

            level.Name = txtName.Text;
            level.From = int.Parse(txtFrom.Text);
            level.To = txtTo.Text;
           

            level.Save();
            if (level.LevelID > 0)
            {
                LogActivity.Write("Update level ", level.Name);
                message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "UpdateSuccessMessage");
            }
            else
            {
                LogActivity.Write("Create new level ", level.Name);
                message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "InsertSuccessMessage");
            }

            return level.LevelID;
        }
    }
}
