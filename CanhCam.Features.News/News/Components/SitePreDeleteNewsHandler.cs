/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2013-03-10

using System;
using CanhCam.Business.WebHelpers;
using log4net;

namespace CanhCam.Features
{
    public class SitePreDeleteNewsHandler : SitePreDeleteHandlerProvider
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(SitePreDeleteNewsHandler));

        public SitePreDeleteNewsHandler()
        { }

        public override void DeleteSiteContent(int siteId)
        {
            CanhCam.Business.News.DeleteBySite(siteId);
        }
    }
}