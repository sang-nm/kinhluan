/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2013-02-21 

using System;
using System.Web;
using System.Web.Services;
using System.Text;
using System.Xml;
using CanhCam.Business;
using CanhCam.Business.WebHelpers;
using Resources;

namespace CanhCam.Web.NewsUI
{
    /// <summary>
    /// A service to suggest a friendly url for a news
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class NewsUrlSuggestService : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            SendResponse(context);
        }

        private void SendResponse(HttpContext context)
        {
            if (context == null) return;

            context.Response.Expires = -1;
            context.Response.ContentType = "application/xml";
            Encoding encoding = new UTF8Encoding();

            XmlTextWriter xmlTextWriter = new XmlTextWriter(context.Response.OutputStream, encoding);
            xmlTextWriter.Formatting = Formatting.Indented;

            xmlTextWriter.WriteStartDocument();
            xmlTextWriter.WriteStartElement("DATA");
            string warning = string.Empty;

            if (context.Request.Params.Get("pn") != null)
            {
                String pageName = context.Request.Params.Get("pn");

                SiteSettings siteSettings = CacheHelper.GetCurrentSiteSettings();

                if (siteSettings != null)
                {
                    String friendlyUrl = SiteUtils.SuggestFriendlyUrl(pageName, siteSettings);

                    if (WebPageInfo.IsPhysicalWebPage("~/" + friendlyUrl))
                    {
                        warning = NewsResources.NewsUrlConflictWithPhysicalPageError;
                    }

                    xmlTextWriter.WriteStartElement("fn");
                    
                    xmlTextWriter.WriteString("~/" + friendlyUrl);
                    
                    xmlTextWriter.WriteEndElement();

                    xmlTextWriter.WriteStartElement("wn");
                    xmlTextWriter.WriteString(warning);
                    xmlTextWriter.WriteEndElement();
                }
            }
            else
            {
                if (context.Request.Params.Get("cu") != null)
                {
                    String enteredUrl = context.Server.UrlDecode(context.Request.Params.Get("cu"));
                    if (WebPageInfo.IsPhysicalWebPage(enteredUrl))
                    {
                        warning = NewsResources.NewsUrlConflictWithPhysicalPageError;
                    }

                    xmlTextWriter.WriteStartElement("wn");
                    xmlTextWriter.WriteString(warning);
                    xmlTextWriter.WriteEndElement();
                }
            }

            //end of document
            xmlTextWriter.WriteEndElement();
            xmlTextWriter.WriteEndDocument();

            xmlTextWriter.Close();
            //Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
