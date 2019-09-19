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

    public partial class NewTypeEdit : CmsNonBasePage
    {

        private static readonly ILog log = LogManager.GetLogger(typeof(NewTypeEdit));
        protected int PageId = -1;
        protected int ModuleId = 76;
        private bool canEditAnything = false;
        private int languageId = -1;
        protected int typeId = -1;
        private KLNewsType newsType = null;
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
            getNewsType();

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
            Title = SiteUtils.FormatPageTitle(siteSettings, CustomResources.NewsTypeOption);
            heading.Text = CustomResources.NewsTypeOption;

            breadcrumb.ParentTitle = CustomResources.NewsTypeList;
            breadcrumb.ParentUrl = "~/custom/NewTypeList.aspx";

            UIHelper.AddConfirmationDialog(btnDelete, CustomResources.DeleteMultiWarning);

            //edFullContent.WebEditor.ToolBar = ToolBar.FullWithTemplates;
            //description.WebEditor.ToolBar = ToolBar.FullWithTemplates;
            //description.WebEditor.Height = Unit.Pixel(300);
        }

        private void PopulateData()
        {
            if (newsType != null)
            {
                ddlParent.SelectedValue= newsType.ParentID.ToString();
                txtName.Text = newsType.Name;
                txtUrl.Text = newsType.Url;
                //ckDelete.Checked = newsType.IsDelected;
            }
        }

        private void getNewsType()
        {
            ddlParent.DataSource = KLNewsType.GetAll().Where(p => p.IsDelected != true).ToList();
            ddlParent.DataBind();
        }

        private void LoadSettings()
        {
            languageId = WorkingCulture.LanguageId;
            canEditAnything = WebUser.IsAdminOrContentAdmin || SiteUtils.UserIsSiteEditor();
            AddClassToBody("NewTypeEdit");
        }

        private void LoadParams()
        {
            PageId = WebUtils.ParseInt32FromQueryString("pageid", PageId);
            ModuleId = WebUtils.ParseInt32FromQueryString("mid", ModuleId);
            typeId = WebUtils.ParseInt32FromQueryString("TypeID", typeId);

            if (typeId > -1)
            {
                newsType = new KLNewsType(typeId);
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

            if (newsType == null)
            {
                btnInsert.Visible = true;
                btnInsertAndNew.Visible = true;
                btnInsertAndClose.Visible = true;
            }
            else if (newsType != null && newsType.NewsTypeID > 0)
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
                WebUtils.SetupRedirect(this, SiteRoot + "/Custom/NewTypeEdit.aspx?TypeID=" + nId.ToString());
            }
        }

        void btnInsertAndClose_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/Custom/NewTypeList.aspx");
            }
        }

        void btnInsertAndNew_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/Custom/NewTypeEdit.aspx");
            }
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/Custom/NewTypeEdit.aspx?TypeID=" + nId.ToString());
            }
        }

        void btnUpdateAndClose_Click(object sender, EventArgs e)
        {
            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/Custom/NewTypeList.aspx");
            }
        }

        void btnUpdateAndNew_Click(object sender, EventArgs e)
        {

            int nId = Save();
            if (nId > 0)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/Custom/NewTypeEdit.aspx");
            }
        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (newsType != null && newsType.NewsTypeID > 0)
            {
                LogActivity.Write("Delete news category ", newsType.Name);
                KLNewsType.Delete(newsType.NewsTypeID);
                WebUtils.SetupRedirect(this, SiteRoot + "/Custtom/NewTypeList.aspx");

            }
        }

        private int Save()
        {
            Page.Validate("NewType");

            if (!Page.IsValid)
                return -1;


            if (newsType == null)
            {
                newsType = new KLNewsType();
            }

            newsType.Name = txtName.Text;
            newsType.Url = txtUrl.Text;
            if (ddlParent.SelectedValue != "Gốc")
                newsType.ParentID = int.Parse(ddlParent.SelectedValue);
            // newsType.IsDelected = ckDelete.Checked;

            newsType.Save();
            if (newsType.NewsTypeID > 0)
            {
                LogActivity.Write("Update news category ", newsType.Name);
                message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "UpdateSuccessMessage");
            }
            else
            {
                LogActivity.Write("Create new  news category ", newsType.Name);
                message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "InsertSuccessMessage");
            }

            return newsType.NewsTypeID;
        }
    }
}
