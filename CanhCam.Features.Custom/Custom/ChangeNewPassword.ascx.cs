using CanhCam.Business;
using CanhCam.Web.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public partial class ChangeNewPassword : SiteModuleControl
    {
        SiteUser user = null;
        Guid userid = Guid.Empty;
        Guid token = Guid.Empty;
        Timer time;
        int countdow = 5;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            btnlogin.Click += Btnlogin_Click;
        }

        private void Btnlogin_Click(object sender, EventArgs e)
        {
            if(txtpass.Text.Trim().Length>8)
            {
                user.Password = txtpass.Text;
                user.Save();
                formreset2.Visible = true;
                formreset.Visible = false;
                GeneralVariables.NameAuthor = user.Name;
                KLAuthor author = KLAuthor.GetKLAuthorByUserID(user.UserId);
                GeneralVariables.Level = author.LevelAuthor;
                if (user.Email != "")
                {
                    if ((siteSettings.UseEmailForLogin))
                    {
                        FormsAuthentication.SetAuthCookie(user.Email, false);
                        SiteUtils.CreateAndStoreSessionToken(user);
                    }

                }
                else
                {
                    if ((!siteSettings.UseEmailForLogin))
                    {
                        FormsAuthentication.SetAuthCookie(user.LoginName, false);

                        SiteUtils.CreateAndStoreSessionToken(user);

                    }
                }
                time = new Timer();
                time.Tick += Time_Tick;
                time.Interval=1000;
                time.Enabled = true;
            }
            else
            {
                
            }
        }

        private void Time_Tick(object sender, EventArgs e)
        {
            if(countdow==0)
            {
                time.Enabled = false;
                WebUtils.SetupRedirect(this, SiteRoot);//Link Detail News
            }
            timer.InnerText = countdow.ToString();
            countdow--;

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadParam();
        }
        private void LoadParam()
        {
            userid = WebUtils.ParseGuidFromQueryString("userid", userid);
            token = WebUtils.ParseGuidFromQueryString("tokenid", token);
            user = new SiteUser(siteSettings, userid);
            if(user.PasswordResetGuid==token)
            {
                user.PasswordResetGuid = Guid.NewGuid();
                user.Save();
            }
        }
    }
}