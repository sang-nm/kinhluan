/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-07-29
/// Last Modified:			2013-07-29

using System;
using System.Web.UI;
using CanhCam.Web.UI;

namespace CanhCam.Web.NewsUI
{
    public partial class NewsDetailTemplatesSetting : UserControl, ISettingControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        #region ISettingControl

        public string GetValue()
        {
            return ddlTemplates.SelectedValue;
        }

        public void SetValue(string val)
        {
            PopulateControls();

            var item = ddlTemplates.Items.FindByValue(val);
            if (item != null){
                ddlTemplates.ClearSelection();
                item.Selected=true;
            }
        }

        #endregion

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            PopulateControls();
        }

        private void PopulateControls()
        {
            if (ddlTemplates.Items.Count > 0) { return; }

            ddlTemplates.DataValueField = "Value";
            ddlTemplates.DataTextField = "Name";
            ddlTemplates.DataSource = EnumDefined.LoadFromConfigurationXml("news", "templatedetail", "xsltname");
            ddlTemplates.DataBind();
        }
    }
}