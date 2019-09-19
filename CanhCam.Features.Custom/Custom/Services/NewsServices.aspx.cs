using CanhCam.Business;
using CanhCam.Web.Framework;
using log4net;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanhCam.Web.CustomUI
{
    public partial class NewsServices : CmsInitBasePage
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(NewsServices));

        private string method = string.Empty;
        private NameValueCollection postParams = null;
        protected void Page_Load(object sender, EventArgs e)
        {

            Response.ContentType = "text/json";
            Encoding encoding = new UTF8Encoding();
            Response.ContentEncoding = encoding;
            try
            {

                LoadParams();
                if (method == "GetBooks")
                {
                    Response.Write(GetBooks());
                    return;
                }
                else if (method == "ComfirmPass")
                {
                    int userid = Convert.ToInt32(postParams.Get("userid"));
                    string pass = postParams.Get("pass");
                    SiteUser user = new SiteUser(siteSettings, userid);
                    bool bol = false;
                    if (pass == user.Password)
                        bol = true;
                    Response.Write(StringHelper.ToJsonString(new
                    {
                        success = bol,
                    })
                    );
                    return;
                }
                else if (method == "GetNotify")
                {
                    int userid = Convert.ToInt32(postParams.Get("userid"));
                    int total = 1;
                    List<KLNotify> lst = KLNotify.GetPageByAuthorID(1,8,out total,userid);
                    Response.Write(StringHelper.ToJsonString(new
                    {
                        success = true,
                        data = lst.OrderByDescending(org => org.DateCreate)
                    }));
                    return;
                }
                else if (method == "ViewNotify")
                {
                    int notifyid = Convert.ToInt32(postParams.Get("notifyid"));
                    KLNotify notify = new KLNotify(notifyid);
                    notify.Viewed = true;
                    notify.Save();
                    Response.Write(StringHelper.ToJsonString(new
                    {
                        success = true,
                    }));
                    return;
                }
                else if ( method != "GetBooks"
                    && method != "ComfirmPass"
                    && method != "GetNotify"
                    && method != "ViewNotify")
                {
                    Response.Write(StringHelper.ToJsonString(new
                    {
                        success = false,
                        message = "No method found with the " + method
                    }));
                    return;
                }

            }
            catch (Exception ex)
            {
                log.Error(ex);
                Response.Write(StringHelper.ToJsonString(new
                {
                    success = false,
                    message = "Failed to process from the server. Please refresh the page and try one more time."
                }));
            }
        }

        private string GetBooks()
        {
            KLBook books = new KLBook();
            try
            {
                books = new KLBook(int.Parse(postParams.Get("bookid")));
                return StringHelper.ToJsonString(new
                {
                    success = true,
                    bookTitle = books.Title,
                    bookImageSrc = "/data/Sites/1/Book/"+books.BookID+"/" + books.Image,
                    bookDesc = books.Description,
                    bookUrl = books.Url
                });
            }
            catch (Exception ex)
            {
                log.Error(ex.Message);
            }

            return null;
        }

        private void LoadParams()
        {
            // don't accept get requests
            if (Request.HttpMethod != "POST") { return; }

            postParams = HttpUtility.ParseQueryString(Request.GetRequestBody());

            if (postParams.Get("method") != null)
                method = postParams.Get("method");
        }
    }
}