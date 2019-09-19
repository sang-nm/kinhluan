/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			    2014-02-04
/// Last Modified:		    2014-05-08

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CanhCam.Business;

namespace CanhCam.Web.UI
{

    public partial class NewsPositionSetting : UserControl, ISettingControl
    {
        
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (HttpContext.Current == null) { return; }
            EnsureItems();
        }

        private void EnsureItems()
        {
            if (ddPosition == null)
            {
                ddPosition = new DropDownList();
                ddPosition.DataValueField = "Value";
                ddPosition.DataTextField = "Name";

                if (this.Controls.Count == 0) { this.Controls.Add(ddPosition); }
            }

            if (ddPosition.Items.Count > 0) { return; }

            ddPosition.DataSource = EnumDefined.LoadFromConfigurationXml("news");
            ddPosition.DataBind();

            ddPosition.Items.Insert(0, new ListItem("", "-1"));
        }

        #region ISettingControl

        public string GetValue()
        {
            EnsureItems();
            return ddPosition.SelectedValue;
        }

        public void SetValue(string val)
        {
            EnsureItems();
            ListItem item = ddPosition.Items.FindByValue(val);
            if (item != null)
            {
                ddPosition.ClearSelection();
                item.Selected = true;
            }
        }

        #endregion

    }
}