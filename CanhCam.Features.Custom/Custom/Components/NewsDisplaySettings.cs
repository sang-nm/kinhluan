/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:			    2014-05-02
/// Last Modified:		    2014-05-02

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    /// <summary>
    /// This control doesn't render anything, it is used only as a themeable collection of settings for things we would like to be able to configure from theme.skin
    /// </summary>
    public class NewsDisplaySettings : WebControl
    {
        private bool showAttribute = true;
        public bool ShowAttribute
        {
            get { return showAttribute; }
            set { showAttribute = value; }
        }

        private bool showGroupImages = false;
        public bool ShowGroupImages
        {
            get { return showGroupImages; }
            set { showGroupImages = value; }
        }

        private bool showNextPreviousLink = false;
        public bool ShowNextPreviousLink
        {
            get { return showNextPreviousLink; }
            set { showNextPreviousLink = value; }
        }

        private int defaultCommentDaysAllowed = 90;
        public int DefaultCommentDaysAllowed
        {
            get { return defaultCommentDaysAllowed; }
            set { defaultCommentDaysAllowed = value; }
        }

        private string resizeBackgroundColor = "#FFFFFF";
        public string ResizeBackgroundColor
        {
            get { return resizeBackgroundColor; }
            set { resizeBackgroundColor = value; }
        }
        
        private bool showSubTitle = false;
        public bool ShowSubTitle
        {
            get { return showSubTitle; }
            set { showSubTitle = value; }
        }

        private bool showAttachment = false;
        public bool ShowAttachment
        {
            get { return showAttachment; }
            set { showAttachment = value; }
        }

        private int thumbnailWidth = 100;
        public int ThumbnailWidth
        {
            get { return thumbnailWidth; }
            set { thumbnailWidth = value; }
        }

        private int thumbnailHeight = 75;
        public int ThumbnailHeight
        {
            get { return thumbnailHeight; }
            set { thumbnailHeight = value; }
        }

        protected override void Render(HtmlTextWriter writer)
        {
            if (HttpContext.Current == null)
            {
                writer.Write("[" + this.ID + "]");
                return;
            }

            // nothing to render
        }
    }
}