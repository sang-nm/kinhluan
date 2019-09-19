using CanhCam.Business;
using CanhCam.FileSystem;
using CanhCam.Net;
using CanhCam.Web;
using CanhCam.Web.Editor;
using CanhCam.Web.Framework;
using log4net;
using Resources;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace CanhCam.Web.CustomUI
{
    public partial class KLRegisterAuthor : SiteModuleControl
    {
        bool comfim = false;
        private IFileSystem fileSystem = null;
        private static readonly ILog log = LogManager.GetLogger(typeof(KLRegisterAuthor));
        protected string imageFolderPath;
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(Page_Load);
            btnCreate.Click += new EventHandler(BtnCreate_Click);
        }

        private void BtnCreate_Click(object sender, EventArgs e)
        {
            var num = Save();
            if(num!=-1)
            {
                WebUtils.SetupRedirect(this, SiteRoot+"/Register-Success");//link account
            }

        }
        

        protected void Page_Load(object sender, EventArgs e)
        {
            PopulateLabels();
            LoadSettings();
            if (!IsPostBack)
            {
                PopulateControls();
            }
        }
        private void PopulateControls()
        {

        }

        protected virtual void PopulateLabels()
        {
        }

        protected virtual void LoadSettings()
        {

            FileSystemProvider p = FileSystemManager.Providers[WebConfigSettings.FileSystemProvider];
            if (p != null) { fileSystem = p.GetFileSystem(); }
        }
        void checkpass()
        {
         
            if(SiteUser.GetByEmail(siteSettings,txtEmail.Text.Trim())==null)
            {
                if (txtPass2.Text == txtPass.Text)
                {
                    comfim = true;
                    lbcomfim.Text = "";
                }
                else
                {
                    lbcomfim.Text = "Passwords must be the same";
                }
            }
            else
            {
                lbemail.Text = "Email already exists";
            }
            
        }
        private int Save()
        {
            checkpass();
            if (comfim)
            {
                try
                {
                    var full = txtFullName.Text.Trim().Split(' ');
                    string Fist = "";
                    string Last = "";
                    for (int i = 0; i < full.Length; i++)
                    {
                        if ((i + 1) < full.Length)
                        {
                            Last += full[i];
                        }
                        else
                        {
                            Fist += full[i];
                        }
                    }
                    SiteUser user = new SiteUser(siteSettings)
                    {
                        Name = txtFullName.Text.Trim(),
                        FirstName = Fist,
                        LastName = Last,
                        Email = txtEmail.Text.Trim(),
                        LoginName = txtFullName.Text.Trim().Replace(' ', '-'),
                        Password = txtPass2.Text,
                    };
                    user.Save();
                    user = new SiteUser(siteSettings, txtFullName.Text.Replace(' ', '-'));
                    KLAuthor author = null;

                    imageFolderPath = AuthorHepper.MediaFolderPath(siteSettings.SiteId, user.UserId);
                    if (user.Save())
                    {
                        author = new KLAuthor()
                        {
                            ArticleCount = 0,
                            UserID = user.UserId,
                            IsDel = false,
                            LevelAuthor = "Basic",
                            Name = txtFullName.Text,
                            IsActive = false,
                        };
                        if (fileImage.UploadedFiles.Count > 0)
                        {
                            imageFolderPath = AuthorHepper.MediaFolderPath(siteSettings.SiteId, user.UserId);


                            AuthorHepper.VerifyAuthorFolders(fileSystem, imageFolderPath);

                            foreach (UploadedFile file in fileImage.UploadedFiles)
                            {
                                string ext = file.GetExtension();
                                if (SiteUtils.IsAllowedUploadBrowseFile(ext, WebConfigSettings.ImageFileExtensions))
                                {
                                    ContentMedia media = new ContentMedia();
                                    media.SiteGuid = siteSettings.SiteGuid;
                                    //image.Title = txtImageTitle.Text;
                                    media.DisplayOrder = 0;

                                    string newFileName = file.FileName.ToCleanFileName(WebConfigSettings.ForceLowerCaseForUploadedFiles);
                                    string newImagePath = VirtualPathUtility.Combine(imageFolderPath, newFileName);

                                    if (media.MediaFile == newFileName)
                                    {
                                        // an existing image delete the old one
                                        fileSystem.DeleteFile(newImagePath);
                                    }
                                    else
                                    {
                                        // this is a new newsImage instance, make sure we don't use the same file name as any other instance
                                        int i = 1;
                                        while (fileSystem.FileExists(VirtualPathUtility.Combine(imageFolderPath, newFileName)))
                                        {
                                            newFileName = i.ToInvariantString() + newFileName;
                                            i += 1;
                                        }

                                    }

                                    newImagePath = VirtualPathUtility.Combine(imageFolderPath, newFileName);

                                    file.SaveAs(Server.MapPath(newImagePath));

                                    media.MediaFile = newFileName;
                                    media.ThumbnailFile = newFileName;

                                    author.Avatar = newFileName;
                                    media.Save();
                                    AuthorHepper.ProcessImage(media, fileSystem, imageFolderPath, file.FileName);
                                }
                            }
                        }
                    }
                    author.Save();
                    
                    Role role = new Role(siteSettings.SiteId, "Author");
                    Role.AddUser(role.RoleId, author.UserID, role.RoleGuid, user.UserGuid);

                    if (!sendmail(user.Name, user.Email))
                        return -1;

                    return author.UserID;
                }
                catch (Exception ex)
                {
                    log.Error(ex.Message);
                }
            }
            return -1;
        }



        private bool sendmail(string authorname, string mailto)
        {
            try
            {
                EmailTemplate template = EmailTemplate.Get(siteSettings.SiteId, "EmailRegisterAuthor", WorkingCulture.LanguageId);
                string subjectEmail = template.Subject.Replace("{SiteName}", siteSettings.SiteName);
                System.Text.StringBuilder messageEmail = new System.Text.StringBuilder();
                messageEmail.Append(template.HtmlBody);
                messageEmail.Replace("{Name}", authorname);
                string fromAddress = siteSettings.DefaultEmailFromAddress;
                string fromAlias = template.FromName;
                if (fromAlias.Length == 0)
                    fromAlias = siteSettings.DefaultFromEmailAlias;

                string emailTo = (template.ToAddresses.Length > 0 ? ";" + template.ToAddresses : "");
                string emailCc = template.CcAddresses;
                string emailBcc = template.BccAddresses;
                string emailReplyTo = (template.ReplyToAddress.Length > 0 ? ";" + template.ReplyToAddress : "");

                SmtpSettings smtpSettings = SiteUtils.GetSmtpSettings();
                EmailMessageTask messageTask = new EmailMessageTask(smtpSettings);
                messageTask.SiteGuid = siteSettings.SiteGuid;
                messageTask.EmailFrom = fromAddress;
                messageTask.EmailFromAlias = fromAlias;
                messageTask.EmailReplyTo = emailReplyTo;
                messageTask.EmailTo = mailto;
                messageTask.EmailCc = emailCc;
                messageTask.EmailBcc = emailBcc;
                messageTask.Subject = subjectEmail;
                messageTask.UseHtml = true;
                messageTask.HtmlBody = messageEmail.ToString();
                messageTask.QueueTask();
                WebTaskManager.StartOrResumeTasks();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}