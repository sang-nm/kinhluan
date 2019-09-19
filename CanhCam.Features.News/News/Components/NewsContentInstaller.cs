/// Author:			        Tran Quoc Vuong - itqvuong@gmail.com - tqvuong263@yahoo.com
/// Created:				2013-02-21
/// Last Modified:			2013-03-10

using System.IO;
using System.Xml;
using System.Web.Hosting;
using CanhCam.Business;
using CanhCam.Web;
using CanhCam.Web.Framework;

namespace CanhCam.Features.NewsUI
{
    public class NewsContentInstaller : IContentInstaller
    {
        public void InstallContent(Module module, string configInfo)
        {
            if (string.IsNullOrEmpty(configInfo)) { return; }

            SiteSettings siteSettings = new SiteSettings(module.SiteId);
            SiteUser admin = SiteUser.GetNewestUser(siteSettings);

            XmlDocument xml = new XmlDocument();

            using (StreamReader stream = File.OpenText(HostingEnvironment.MapPath(configInfo)))
            {
                xml.LoadXml(stream.ReadToEnd());
            }

            XmlNode postsNode = null;
            foreach (XmlNode n in xml.DocumentElement.ChildNodes)
            {
                if (n.Name == "posts")
                {
                    postsNode = n;
                    break;
                }
            }

            if (postsNode != null)
            {
                foreach (XmlNode node in postsNode.ChildNodes)
                {
                    if (node.Name == "post")
                    {
                        XmlAttributeCollection postAttrributes = node.Attributes;
                        

                        News b = new News();
                        b.ModuleGuid = module.ModuleGuid;
                        b.ModuleID = module.ModuleId;

                        if ((postAttrributes["title"] != null) && (postAttrributes["title"].Value.Length > 0))
                        {
                            b.Title = postAttrributes["title"].Value;
                        }

                        b.Url = "~/" + SiteUtils.SuggestFriendlyUrl(b.Title, siteSettings);

                        foreach (XmlNode descriptionNode in node.ChildNodes)
                        {
                            if (descriptionNode.Name == "excerpt")
                            {
                                b.BriefContent = descriptionNode.InnerText;
                                break;
                            }
                        }

                        foreach (XmlNode descriptionNode in node.ChildNodes)
                        {
                            if (descriptionNode.Name == "description")
                            {
                                b.FullContent = descriptionNode.InnerText;
                                break;
                            }
                        }

                        b.UserGuid = admin.UserGuid;

                        if (b.Save())
                        {
                            FriendlyUrl newFriendlyUrl = new FriendlyUrl();
                            newFriendlyUrl.SiteId = siteSettings.SiteId;
                            newFriendlyUrl.SiteGuid = siteSettings.SiteGuid;
                            newFriendlyUrl.PageGuid = b.NewsGuid;
                            newFriendlyUrl.Url = b.Url.Replace("~/", string.Empty);
                            newFriendlyUrl.RealUrl = "~/News/NewsDetail.aspx?pageid="
                                + module.PageId.ToInvariantString()
                                + "&mid=" + b.ModuleID.ToInvariantString()
                                + "&NewsID=" + b.NewsID.ToInvariantString();

                            newFriendlyUrl.Save();
                        }
                    }
                }
            }
            
            foreach (XmlNode node in xml.DocumentElement.ChildNodes)
            {
                if (node.Name == "moduleSetting")
                {
                    XmlAttributeCollection settingAttributes = node.Attributes;

                    if ((settingAttributes["settingKey"] != null) && (settingAttributes["settingKey"].Value.Length > 0))
                    {
                        string key = settingAttributes["settingKey"].Value;
                        string val = string.Empty;
                        if (settingAttributes["settingValue"] != null)
                        {
                            val = settingAttributes["settingValue"].Value;
                        }

                        ModuleSettings.UpdateModuleSetting(module.ModuleGuid, module.ModuleId, key, val);
                    }
                }
            }
        }
    }
}