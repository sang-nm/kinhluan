using CanhCam.Business;
using CanhCam.FileSystem;
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
    public partial class KLADDGratitude : SiteModuleControl
    {
        KLAuthor author = null;
        KLGratitude gratitude = null;
        private int guestid = -1;
        SiteUser currentuser = null;
        private static readonly ILog log = LogManager.GetLogger(typeof(KLRegisterAuthor));
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            btncreate.Click += new EventHandler(Btncreate_Click);
            btnupdate.Click += new EventHandler(Btnupdate_Click);
        }

        private void Btncreate_Click(object sender, EventArgs e)
        {
            int num = Save();
            if (num != -1)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/add-gratitude?GuestID=" + num.ToString());
                txtgratitude.Text = string.Empty;
            }
        }

        private void Btnupdate_Click(object sender, EventArgs e)
        {
            int num = Update(gratitude.GuestID);
            if (num != -1)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/add-gratitude?GuestID=" + num.ToString());
                txtgratitude.Text = string.Empty;
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
        private void PopulateControls()
        {
            
        }

        protected virtual void PopulateLabels()
        {

        }

        protected virtual void LoadSettings()
        {
            currentuser = SiteUtils.GetCurrentSiteUser();
            author = KLAuthor.GetKLAuthorByUserID(currentuser.UserId);

            currentuser = SiteUtils.GetCurrentSiteUser();
            if (currentuser == null)
            {
                WebUtils.SetupRedirect(this, SiteRoot);
            }
            else
            {
                author = KLAuthor.GetKLAuthorByUserID(currentuser.UserId);
            }
            guestid = WebUtils.ParseInt32FromQueryString("GuestID", guestid);

            if (guestid != -1)
            {
                gratitude = new KLGratitude(guestid);
                txtgratitude.Text = gratitude.Comment;
            }
        }

        private int Save()
        {
            if (txtgratitude.Text.Trim() == "")
                return -1;
                
            if (currentuser == null)
                return -1;

            try
            {
                gratitude = new KLGratitude();
                gratitude.Name = author.Name;
                gratitude.Avatar = author.Avatar;
                gratitude.AuthorID = author.AuthorID;
                gratitude.CreateUtc = DateTime.Now;
                gratitude.Comment = txtgratitude.Text;
            }
            catch (Exception ex)
            {
                log.Error(ex.Message);
            }
            if (gratitude.Save())
            {
                LogActivity.Write("Post Gratitude", gratitude.Comment);
                message.SuccessMessage = ResourceHelper.GetResourceString("CustomResources", "PostSuccessMessage");
            }
            return gratitude.GuestID;
        }

        private int Update(int gId)
        {
            if (txtgratitude.Text.Trim() == "")
                return -1;

            if (currentuser == null)
                return -1;

            try
            {
                gratitude = new KLGratitude(gId);
                gratitude.Name = author.Name;
                gratitude.Avatar = author.Avatar;
                gratitude.AuthorID = author.AuthorID;
                gratitude.CreateUtc = DateTime.Now;
                gratitude.Comment = txtgratitude.Text;
            }
            catch (Exception ex)
            {
                log.Error(ex.Message);
            }
            if (gratitude.Save())
            {
                LogActivity.Write("Update Gratitude", gratitude.Comment);
                message.SuccessMessage = ResourceHelper.GetResourceString("CustomResources", "UpdateSuccessMessage");
            }
            return gratitude.GuestID;
        }
    }
}