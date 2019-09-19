using CanhCam.Business;
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
    public partial class KLAuthorMail : SiteModuleControl
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(KLAuthorMail));
        protected int totalPage = 0;
        protected int pageSize = 12;
        protected int pagenum = 1;
        protected string siteRoot = string.Empty;
        public string SiteRoot
        {
            get { return siteRoot; }
            set { siteRoot = value; }
        }
        SiteUser current = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadParam();
        }
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
        }
        private void LoadParam()
        {
            pagenum = WebUtils.ParseInt32FromQueryString("page", pagenum);
            current = SiteUtils.GetCurrentSiteUser();
            rptnotify.DataSource = KLNotify.GetPageByAuthorID(pagenum, pageSize, out totalPage, current.UserId);
            rptnotify.DataBind();
        }

        protected void rptnotify_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.Item!=null)
            {
               if(e.CommandName== "Remove")
                {
                    try
                    {
                        HiddenField hd = (HiddenField)e.Item.FindControl("hdnotifyid");
                        if(KLNotify.Delete(int.Parse(hd.Value)))
                        {
                            e.Item.Visible = false;
                            LogActivity.Write("Remove Notify by ID is", hd.Value);
                            message.SuccessMessage = ResourceHelper.GetResourceString("Resource", "RemoveNotify");
                        }
                    }
                    catch (Exception ex)
                    {
                        log.Error(ex.Message);
                    }
                }

            }
        }
    }
}