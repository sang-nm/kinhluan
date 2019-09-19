/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			    2014-08-18
/// Last Modified:		    2014-08-18

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CanhCam.Business;
using Resources;

namespace CanhCam.Web.UI
{

    public partial class ParentZoneSetting : UserControl, ISettingControl
    {

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (HttpContext.Current == null) { return; }
            EnsureItems();
        }

        private void EnsureItems()
        {
            if (ddZones == null)
            {
                ddZones = new DropDownList();

                if (this.Controls.Count == 0) { this.Controls.Add(ddZones); }
            }

            if (ddZones.Items.Count > 0) { return; }

            gbSiteMapProvider.PopulateListControl(ddZones, false, News.FeatureGuid);

            ddZones.Items.Insert(0, new ListItem(NewsResources.AutomaticallySelectCategory, "0"));
            ddZones.Items.Insert(0, new ListItem("", ""));
        }

        #region ISettingControl

        public string GetValue()
        {
            EnsureItems();
            return ddZones.SelectedValue;
        }

        public void SetValue(string val)
        {
            EnsureItems();
            ListItem item = ddZones.Items.FindByValue(val);
            if (item != null)
            {
                ddZones.ClearSelection();
                item.Selected = true;
            }
        }

        #endregion

    }
}