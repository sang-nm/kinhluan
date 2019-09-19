using CanhCam.Business;
using CanhCam.Web;
using CanhCam.Web.Framework;
using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public partial class KLAuthorLogin : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLAuthorLogin));

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            btnlogin.Click += new EventHandler(Btnlogin_Click);
        }

        private void Btnlogin_Click(object sender, EventArgs e)
        {
            if (LoginAuthor())
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/author-news");//link account
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
        }
        bool LoginAuthor()
        {
            if (!SiteUser.EmailExistsInDB(siteSettings.SiteId, txtEmail.Text))
            {
                message.Message = "Email Don't Exists";
                return false;
            }
            else
            {

                string result = SiteUser.Login(siteSettings, txtEmail.Text, txtPass.Text);
                if (result != "")
                {
                    try
                    {
                        SiteUser temp = SiteUser.GetByEmail(siteSettings, txtEmail.Text);
                        KLAuthor authorlogin = KLAuthor.GetKLAuthorByUserID(temp.UserId);
                        if (authorlogin.IsActive != false)
                        {

                            GeneralVariables.NameAuthor = temp.Name;
                            GeneralVariables.Level = authorlogin.LevelAuthor;
                            if (temp.Email != "")
                            {
                                if ((siteSettings.UseEmailForLogin))
                                {
                                    FormsAuthentication.SetAuthCookie(temp.Email, false);
                                    SiteUtils.CreateAndStoreSessionToken(temp);
                                }

                            }
                            else
                            {
                                if ((!siteSettings.UseEmailForLogin))
                                {
                                    FormsAuthentication.SetAuthCookie(temp.LoginName, false);

                                    SiteUtils.CreateAndStoreSessionToken(temp);

                                }
                            }

                            return true;
                        }
                        else
                        {
                            message.Message = "This Account not yet approved";
                        }
                    }
                    catch (Exception ex)
                    {
                        log.Error(ex.Message);
                    }


                }
                else
                {
                    message.Message = "Password Wrong";
                }
            }

            return false;
        }
    }
}