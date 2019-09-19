using CanhCam.Business;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public partial class LeftMenu : SiteModuleControl
    {
        protected string Name = "";
        protected string Level = "";
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Name = GeneralVariables.NameAuthor;
            Level = GeneralVariables.Level;
        }
    }
}