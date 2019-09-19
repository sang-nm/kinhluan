using CanhCam.Business;
using CanhCam.Web.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public partial class klAuthorChangePassword : SiteModuleControl
    {
        SiteUser current = null;
        KLAuthor author = null;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            btncreate.Click += new EventHandler(Btncreate_Click);
        }

        private void Btncreate_Click(object sender, EventArgs e)
        {
            Save();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadParam();
        }
        private void LoadParam()
        {
            current = SiteUtils.GetCurrentSiteUser();
            author = KLAuthor.GetKLAuthorByUserID(current.UserId);
            GeneralVariables.NameAuthor = current.Name;
            GeneralVariables.Level = author.LevelAuthor;
            hduserid.Value = current.UserId.ToString();
        }
        private int Save()
        {
            Page.Validate("Books");

            if (!Page.IsValid)
                return -1;
            current.Password = txtcfpass.Text;
            if (current.Save())
            {
                LogActivity.Write("Update Password ", current.Name);
                message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "UpdateAuthorSuccess");
            }
            return current.UserId;
        }
    }
}