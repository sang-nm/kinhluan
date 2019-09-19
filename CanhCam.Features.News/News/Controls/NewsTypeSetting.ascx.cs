/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2013-03-13

using System;
using System.Web.UI;
using CanhCam.Web.UI;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsTypeSetting : UserControl, ISettingControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        #region ISettingControl

        public string GetValue()
        {
            return ddlNewsType.SelectedValue;
        }

        public void SetValue(string val)
        {
            PopulateControls();
            
            var item = ddlNewsType.Items.FindByValue(val);
            if (item != null)
            {
                ddlNewsType.ClearSelection();
                item.Selected = true;
            }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            PopulateControls();
        }

        private void PopulateControls()
        {
            if (ddlNewsType.Items.Count > 0) { return; }

            ddlNewsType.DataValueField = "Value";
            ddlNewsType.DataTextField = "Name";
            ddlNewsType.DataSource = EnumDefined.LoadFromConfigurationXml("news", "newstype", "value");
            ddlNewsType.DataBind();
        }

        #endregion
    }
}