/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			    2014-08-18
/// Last Modified:		    2014-08-18

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.UI
{

    public partial class NewsSortBySetting : UserControl, ISettingControl
    {
        
        #region ISettingControl

        public string GetValue()
        {
            return ddSortBy.SelectedValue;
        }

        public void SetValue(string val)
        {
            ListItem item = ddSortBy.Items.FindByValue(val);
            if (item != null)
            {
                ddSortBy.ClearSelection();
                item.Selected = true;
            }
        }

        #endregion

    }
}