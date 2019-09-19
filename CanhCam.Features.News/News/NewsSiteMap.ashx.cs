/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2013-02-21

using System;
using System.Data;
using System.Globalization;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Xml;
using CanhCam.Business;
using CanhCam.Business.WebHelpers;

namespace CanhCam.Web.NewsUI
{
    /// <summary>
    /// Purpose: Renders a SiteMap as xml 
    /// in google site map protocol format
    /// https://www.google.com/webmasters/tools/docs/en/protocol.html
    /// for news posts that have friendly urls
    /// 
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class NewsSiteMap : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            GenerateSiteMap(context);
        }

        private void GenerateSiteMap(HttpContext context)
        {
            context.Response.Cache.SetExpires(DateTime.Now.AddMinutes(20));
            context.Response.Cache.SetCacheability(HttpCacheability.Public);

            context.Response.ContentType = "application/xml";
            Encoding encoding = new UTF8Encoding();
            context.Response.ContentEncoding = encoding;

            using (XmlTextWriter xmlTextWriter = new XmlTextWriter(context.Response.OutputStream, encoding))
            {
                xmlTextWriter.Formatting = Formatting.Indented;

                xmlTextWriter.WriteStartDocument();

                xmlTextWriter.WriteStartElement("urlset");
                xmlTextWriter.WriteStartAttribute("xmlns");
                xmlTextWriter.WriteValue("http://www.sitemaps.org/schemas/sitemap/0.9");
                xmlTextWriter.WriteEndAttribute();

                // add news post urls
                if (WebConfigSettings.EnableNewsSiteMap)
                    AddNewsUrls(context, xmlTextWriter);


                xmlTextWriter.WriteEndElement(); //urlset

                //end of document
                xmlTextWriter.WriteEndDocument();
            }
        }

        private void AddNewsUrls(HttpContext context, XmlTextWriter xmlTextWriter)
        {
            SiteSettings siteSettings = CacheHelper.GetCurrentSiteSettings();
            
            if (siteSettings == null) { return; }
           
            if (siteSettings.SiteGuid == Guid.Empty) { return; }

            using(IDataReader reader = News.GetNewsForSiteMap(siteSettings.SiteId, WorkingCulture.LanguageId))
            {
                while (reader.Read())
                {
                    string url = reader["Url"].ToString();
                    if (url.StartsWith("~/"))
                    {
                        xmlTextWriter.WriteStartElement("url");
                        xmlTextWriter.WriteElementString("loc", SiteUtils.GetNavigationSiteRoot(Convert.ToInt32(reader["ZoneID"])) + url.Replace("~", string.Empty));
                        xmlTextWriter.WriteElementString("lastmod", Convert.ToDateTime(reader["LastModUtc"]).ToString("u", CultureInfo.InvariantCulture).Replace(" ", "T"));

                        // maybe should use never for news posts but in case it changes we do want to be re-indexed
                        xmlTextWriter.WriteElementString("changefreq", "monthly");

                        xmlTextWriter.WriteElementString("priority", "0.5");

                        xmlTextWriter.WriteEndElement(); //url
                    }
                }
            }
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