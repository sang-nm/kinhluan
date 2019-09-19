/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			    2014-08-18
/// Last Modified:		    2014-08-18

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CanhCam.Business;
using Resources;
using System.Collections.Generic;
using CanhCam.Web.Framework;

namespace CanhCam.Web.UI
{

    public partial class ParentZonesSetting : UserControl, ISettingControl
    {

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (HttpContext.Current == null) { return; }
            EnsureItems();
        }

        private void EnsureItems()
        {
            if (cobZones == null)
            {
                cobZones = new ComboBox();

                if (this.Controls.Count == 0) { this.Controls.Add(cobZones); }
            }

            if (cobZones.Items.Count > 0) { return; }

            gbSiteMapProvider.PopulateListControl(cobZones, false, News.FeatureGuid);

            cobZones.Items.Insert(0, new ListItem(NewsResources.AutomaticallySelectCategory, "0"));
        }

        #region ISettingControl

        public string GetValue()
        {
            EnsureItems();

            List<string> selectedZoneIds = new List<string>();
            foreach (ListItem li in cobZones.SelectedItems)
                selectedZoneIds.Add(li.Value);

            return string.Join(";", selectedZoneIds.ToArray());
        }

        public void SetValue(string val)
        {
            EnsureItems();

            cobZones.ClearSelection();
            if (val.Length > 0)
            {
                List<string> selectedZoneIds = val.SplitOnCharAndTrim(';');
                foreach (string zoneId in selectedZoneIds)
                {
                    ListItem item = cobZones.Items.FindByValue(zoneId);
                    if (item != null)
                        item.Selected = true;
                }
            }
        }

        #endregion

    }
}