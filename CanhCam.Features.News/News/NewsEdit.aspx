<%@ Page ValidateRequest="false" Language="c#" CodeBehind="NewsEdit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.NewsUI.NewsEditPage" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.News" Namespace="CanhCam.Web.NewsUI" %>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:NewsDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:NewsResources, NewsEditHeading %>" CurrentPageUrl="~/News/NewsEdit.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upButton" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndNew" Text="<%$Resources:Resource, UpdateAndNewButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsert" Text="<%$Resources:Resource, InsertButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndNew" Text="<%$Resources:Resource, InsertAndNewButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndClose" Text="<%$Resources:Resource, InsertAndCloseButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="DefaultButton" ID="btnCopyModal" Visible="false" data-toggle="modal" data-target="#pnlModal" Text="Copy" runat="server" CausesValidation="false" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="Delete this item" CausesValidation="false" />
                    <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                    <asp:HyperLink SkinID="DefaultButton" ID="lnkPreview" Visible="false" runat="server" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Panel ID="pnlNews" runat="server" CssClass="workplace" DefaultButton="btnUpdate">
            <div id="divtabs" class="tabs">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#tabContent" aria-controls="tabContent" role="tab" data-toggle="tab">
                        <asp:Literal ID="litContentTab" runat="server" /></a></li>
                    <li id="liImages" class="newsedit-imagetab" runat="server">
                        <asp:Literal ID="litImagesTab" runat="server" /></li>
                    <li id="liAttribute" class="newsedit-attributetab" runat="server">
                        <asp:Literal ID="litAttributeTab" runat="server" /></li>
                    <li class="newsedit-metatab"><a href="#tabMeta" aria-controls="tabMeta" role="tab" data-toggle="tab">
                        <asp:Literal ID="litMetaTab" runat="server" /></a></li>
                </ul>
                <div class="tab-content">
                    <div id="tabContent" role="tabpanel" class="tab-pane fade active in">
                    <div class="form-horizontal">
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                                ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <div class="input-group">
                                    <asp:DropDownList ID="ddZones" runat="server" />
                                    <portal:gbHelpLink ID="GbHelpLink9" runat="server" HelpKey="newsedit-selectzone-help" />
                                </div>
                            </div>
                        </div>
                        <asp:UpdatePanel ID="up" runat="server">
                            <ContentTemplate>
                                <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                                    EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                    CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblTitle" runat="server" ForControl="txtTitle" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="NewsEditTitleLabel" ResourceFile="NewsResources" />
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtTitle" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                                            <portal:gbHelpLink ID="GbHelpLink1" runat="server" HelpKey="newsedit-title-help" />
                                        </div>
                                        <asp:RequiredFieldValidator ID="reqTitle" runat="server" ControlToValidate="txtTitle"
                                            Display="Dynamic" SetFocusOnError="true" CssClass="txterror" ValidationGroup="news" />
                                    </div>
                                </div>
                                <div id="divSubTitle" runat="server" class="settingrow form-group newsedit-subtitle">
                                    <gb:SiteLabel ID="lblSubTitle" runat="server" ForControl="txtSubTitle" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="SubTitle" ResourceFile="NewsResources" />
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtSubTitle" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                                            <portal:gbHelpLink ID="GbHelpLink2" runat="server" HelpKey="newsedit-subtitle-help" />
                                        </div>
                                    </div>
                                </div>
                                <div class="settingrow form-group newsedit-url">
                                    <gb:SiteLabel ID="lblUrl" runat="server" ForControl="txtUrl" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="NewsEditItemUrlLabel" ResourceFile="NewsResources" />
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtUrl" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                                            <portal:gbHelpLink ID="GbHelpLink3" runat="server" HelpKey="newsedit-url-help" />
                                        </div>
                                        <span id="spnUrlWarning" runat="server" style="font-weight: normal; display: none;"
                                            class="txterror"></span>
                                        <asp:HiddenField ID="hdnTitle" runat="server" />
                                        <asp:RegularExpressionValidator ID="regexUrl" runat="server" ControlToValidate="txtUrl"
                                            ValidationExpression="((http\://|https\://|~/){1}(\S+){0,1})" Display="Dynamic" SetFocusOnError="true"
                                            ValidationGroup="news" />
                                    </div>
                                </div>
                                <div class="settingrow form-group newsedit-excerpt">
                                    <gb:SiteLabel ID="lblBriefContent" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="BriefContentLabel"
                                        ResourceFile="NewsResources" />
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <gbe:EditorControl ID="edBriefContent" runat="server" />
                                            <portal:gbHelpLink ID="GbHelpLink4" runat="server" HelpKey="newsedit-briefcontent-help" />
                                        </div>
                                    </div>
                                </div>
                                <div class="settingrow form-group newsedit-content">
                                    <gb:SiteLabel ID="lblFullContent" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="Content"
                                        ResourceFile="NewsResources" />
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <gbe:EditorControl ID="edFullContent" runat="server" />
                                            <portal:gbHelpLink ID="GbHelpLink5" runat="server" HelpKey="newsedit-fullcontent-help" />
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <div class="settingrow form-group" runat="server" id="divUploadImage">
                            <gb:SiteLabel ID="lblImage" runat="server" ConfigKey="ImageFile" ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <telerik:RadAsyncUpload ID="fileImage" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic"
                                    AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                            </div>
                        </div>
                        <div id="divFileAttachment" runat="server" class="settingrow form-group newsedit-attachfile">
                            <gb:SiteLabel ID="FileAttachmentLabel" runat="server" ForControl="txtFileAttachment"
                                ResourceFile="NewsResources" ConfigKey="FileAttachmentLabel" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <div class="input-group">
                                    <asp:TextBox ID="txtFileAttachment" MaxLength="255" runat="server" />
                                    <div class="input-group-addon">
                                        <portal:FileBrowserTextBoxExtender ID="FileAttachmentBrowser" runat="server" BrowserType="file" />
                                    </div>
                                    <portal:gbHelpLink ID="GbHelpLink7" runat="server" HelpKey="newsedit-fileattachment-help" />
                                </div>
                            </div>
                        </div>
                        <div id="divPosition" visible="false" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="lblPosition" runat="server" ForControl="chlPosition" ConfigKey="NewsPositionSetting"
                                ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:CheckBoxList ID="chlPosition" DataValueField="Value" DataTextField="Name" runat="server" />
                            </div>
                        </div>
                        <div id="divShowOption" visible="false" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="lblShowOption" runat="server" ForControl="chlShowOption" ConfigKey="ShowOptionLabel"
                                ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:CheckBoxList ID="chlShowOption" runat="server" />
                            </div>
                        </div>
                        <div class="settingrow form-group newsedit-newwindow">
                            <gb:SiteLabel ID="lblOpenInNewWindow" runat="server" ForControl="chkOpenInNewWindow" ConfigKey="OpenInNewWindowLabel"
                                ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:CheckBox ID="chkOpenInNewWindow" runat="server" Checked="false" />
                            </div>
                        </div>
                        <div id="divIncludeInSearch" class="settingrow form-group" Visible="false" runat="server">
                            <gb:SiteLabel ID="Sitelabel4" runat="server" ForControl="chkIncludeInSearch" ConfigKey="IncludeInSearchLabel"
                                ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:CheckBox ID="chkIncludeInSearch" runat="server" Checked="false" />
                            </div>
                        </div>
                        <div id="divIncludeInSiteMap" class="settingrow form-group" Visible="false" runat="server">
                            <gb:SiteLabel ID="lblIncludeInSiteMap" runat="server" ForControl="chkIncludeInSiteMap" ConfigKey="IncludeInSiteMapLabel"
                                ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:CheckBox ID="chkIncludeInSiteMap" runat="server" Checked="false" />
                            </div>
                        </div>
                        <div id="divIncludeInFeed" class="settingrow form-group" Visible="false" runat="server">
                            <gb:SiteLabel ID="lblIncludeInFeed" runat="server" ForControl="chkIncludeInFeed" ConfigKey="IncludeInFeedLabel"
                                ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:CheckBox ID="chkIncludeInFeed" runat="server" Checked="false" />
                            </div>
                        </div>
                        <div id="divIsPublished" class="settingrow form-group newsedit-published newsedit-ispublished" runat="server">
                            <gb:SiteLabel ID="lblIsPublished" runat="server" ForControl="chkIsPublished" ConfigKey="IsPublishedLabel"
                                ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:CheckBox ID="chkIsPublished" runat="server" Checked="true" />
                            </div>
                        </div>
                        <div id="divStartDate" runat="server" class="settingrow form-group newsedit-published newsedit-startdate">
                            <gb:SiteLabel ID="lblStartDate" runat="server" ConfigKey="NewsEditStartDateLabel"
                                ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <gb:DatePickerControl ID="dpBeginDate" runat="server" ShowTime="True" SkinID="news"
                                    CssClass="forminput"></gb:DatePickerControl>
                                <portal:gbHelpLink ID="GbHelpLink10" runat="server" RenderWrapper="false" HelpKey="newsedit-startdate-help" />
                                <asp:RequiredFieldValidator ID="reqStartDate" runat="server" ControlToValidate="dpBeginDate"
                                    Display="Dynamic" SetFocusOnError="true" CssClass="txterror" ValidationGroup="news" />
                            </div>
                        </div>
                        <div id="divEndDate" runat="server" class="settingrow form-group newsedit-published newsedit-enddate">
                            <gb:SiteLabel ID="lblEndDate" runat="server" ConfigKey="EndDate" ResourceFile="NewsResources"
                                CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <gb:DatePickerControl ID="dpEndDate" runat="server" ShowTime="True" SkinID="news"
                                    CssClass="forminput"></gb:DatePickerControl>
                            </div>
                        </div>
                        <div id="divCommentAllowedForDays" class="settingrow form-group" runat="server" visible="false">
                            <gb:SiteLabel ID="lblCommentAllowedForDays" runat="server" ForControl="ddCommentAllowedForDays"
                                ConfigKey="NewsEditAllowedCommentsForDaysPrefix" ResourceFile="NewsResources"
                                CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:DropDownList ID="ddCommentAllowedForDays" EnableTheming="false" runat="server"
                                    CssClass="forminput">
                                    <asp:ListItem Value="-1" Text="<%$ Resources:NewsResources, NewsCommentsNotAllowed %>" />
                                    <asp:ListItem Value="0" Text="<%$ Resources:NewsResources, NewsCommentsUnlimited %>" />
                                    <asp:ListItem Value="1" Text="1" />
                                    <asp:ListItem Value="7" Text="7" />
                                    <asp:ListItem Value="15" Text="15" />
                                    <asp:ListItem Value="30" Text="30" />
                                    <asp:ListItem Value="45" Text="45" />
                                    <asp:ListItem Value="60" Text="60" />
                                    <asp:ListItem Value="90" Text="90" Selected="True" />
                                    <asp:ListItem Value="120" Text="120" />
                                </asp:DropDownList>
                                &nbsp;<asp:Literal ID="litDays" runat="server" />
                            </div>
                        </div>
                    </div>
                    </div>
                    <div id="tabImages" role="tabpanel" class="tab-pane fade" runat="server">
                        <asp:UpdatePanel ID="updImages" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="form-horizontal">
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblImageFile" runat="server" ConfigKey="ImageFile" ResourceFile="NewsResources"
                                            CssClass="settinglabel control-label col-sm-3" />
                                        <div class="col-sm-9">
                                            <telerik:RadAsyncUpload ID="uplImageFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic"
                                                AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                                        </div>
                                        <div class="settingrow form-group">
                                            <div class="col-sm-offset-3 col-sm-9">
                                                <asp:Button SkinID="DefaultButton" ID="btnUpdateImage" OnClick="btnUpdateImage_Click"
                                                    Text="<%$Resources:NewsResources, ImageUpdateButton %>" runat="server" CausesValidation="False" />
                                                <asp:Button SkinID="DefaultButton" ID="btnDeleteImage" Visible="false" OnClick="btnDeleteImage_Click"
                                                    Text="<%$Resources:NewsResources, ImageDeleteSelectedButton %>" runat="server"
                                                    CausesValidation="False" />
                                                <portal:gbHelpLink ID="GbHelpLink11" runat="server" RenderWrapper="false" HelpKey="newsedit-imageupload-help" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server"
                                    OnNeedDataSource="grid_NeedDataSource" OnItemDataBound="grid_ItemDataBound">
                                    <MasterTableView DataKeyNames="Guid,LanguageId,DisplayOrder,Title">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, ThumbnailLabel %>" >
                                                <ItemTemplate>
                                                    <portal:MediaElement ID="ml1" runat="server" Width="100" FileUrl='<%# thumbnailImageFolderPath + Eval("ThumbnailFile") %>' />
                                                    <telerik:RadAsyncUpload ID="fupThumbnail" SkinID="radAsyncUploadSkin" Width="100%" HideFileInput="true" MultipleFileSelection="Disabled"
                                                        AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, ImageFile %>" >
                                                <ItemTemplate>
                                                    <portal:MediaElement ID="ml2" runat="server" Width="100" FileUrl='<%# imageFolderPath + Eval("MediaFile") %>' />
                                                    <telerik:RadAsyncUpload ID="fupImageFile" SkinID="radAsyncUploadSkin" Width="100%" HideFileInput="true" MultipleFileSelection="Disabled"
                                                        AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsEditImageTitleLabel %>">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTitle" CssClass="input-grid" Width="97%" MaxLength="255" Text='<%# Eval("Title") %>'
                                                        runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="150" HeaderText="<%$Resources:NewsResources, NewsEditLanguageLabel %>" UniqueName="LanguageID">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlLanguage" AppendDataBoundItems="true" DataValueField="LanguageID" DataTextField="Name" runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:NewsResources, NewsEditDisplayOrderLabel %>">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" MaxLength="4" Text='<%# Eval("DisplayOrder") %>'
                                                        runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div id="tabAttribute" role="tabpanel" class="tab-pane fade" runat="server">
                        <asp:UpdatePanel ID="updAttribute" runat="server">
                            <ContentTemplate>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="input-group">
                                            <asp:ListBox ID="lbAttribute" Width="100%" Height="500" AutoPostBack="true" runat="server"
                                                AppendDataBoundItems="true" DataTextField="Title" DataValueField="Guid" />
                                            <div class="input-group-addon">
                                                <ul class="nav sorter">
                                                    <li><asp:LinkButton ID="btnAttributeUp" CommandName="up" runat="server"><i class="fa fa-angle-up"></i></asp:LinkButton></li>
                                                    <li><asp:LinkButton ID="btnAttributeDown" CommandName="down" runat="server"><i class="fa fa-angle-down"></i></asp:LinkButton></li>
                                                    <li><asp:LinkButton ID="btnDeleteAttribute" runat="server" CausesValidation="False"><i class="fa fa-trash-o"></i></asp:LinkButton></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <telerik:RadTabStrip ID="tabAttributeLanguage" OnTabClick="tabAttributeLanguage_TabClick" 
                                            EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                            CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                                        <div class="form-horizontal">
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="lblAttributeTitle" runat="server" CssClass="settinglabel control-label col-sm-3" ForControl="txtAttributeTitle" ConfigKey="AttributeTitle"
                                                    ResourceFile="NewsResources" />
                                                <div class="col-sm-9">
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtAttributeTitle" runat="server" MaxLength="255" />
                                                        <portal:gbHelpLink ID="GbHelpLink8" runat="server" HelpKey="newsedit-attribute-help" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <div class="col-sm-offset-3 col-sm-9">
                                                    <asp:Button SkinID="DefaultButton" ID="btnAttributeUpdate" ValidationGroup="Attribute" Text="<%$Resources:NewsResources, AttributeUpdateButton %>" runat="server" />
                                                    <asp:Button SkinID="DefaultButton" ID="btnDeleteAttributeLanguage" Visible="false" OnClick="btnDeleteAttributeLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="lblAttributeContent" runat="server" CssClass="settinglabel control-label" ConfigKey="AttributeContent"
                                                    ResourceFile="NewsResources" />
                                                <div>
                                                    <asp:RequiredFieldValidator ID="reqAttributeTitle" ControlToValidate="txtAttributeTitle" ErrorMessage="<%$Resources:NewsResources, AttributeTitleRequired %>"
                                                        ValidationGroup="Attribute" Display="Dynamic" CssClass="txterror" runat="server" />
                                                    <gbe:EditorControl ID="edAttributeContent" runat="server" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div id="tabMeta" role="tabpanel" class="tab-pane fade">
                        <div class="form-horizontal">
                            <asp:UpdatePanel ID="upSEO" runat="server">
                                <ContentTemplate>
                                    <telerik:RadTabStrip ID="tabLanguageSEO" OnTabClick="tabLanguageSEO_TabClick" 
                                        EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                        CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblMetaTitle" runat="server" ForControl="txtMetaTitle" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="MetaTitleLabel" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtMetaTitle" runat="server" MaxLength="65" />
                                                <portal:gbHelpLink ID="GbHelpLink6" runat="server" HelpKey="newsedit-metatitle-help" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblMetaDescription" runat="server" ForControl="txtMetaDescription" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="MetaDescriptionLabel" ResourceFile="NewsResources" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtMetaDescription" runat="server" MaxLength="156" />
                                                <portal:gbHelpLink ID="gbHelpLink22" runat="server" HelpKey="newsedit-metakeywords-help" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblMetaKeywords" runat="server" ForControl="txtMetaKeywords" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="MetaKeywordsLabel" ResourceFile="NewsResources" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtMetaKeywords" runat="server" MaxLength="156" />
                                                <portal:gbHelpLink ID="gbHelpLink23" runat="server" HelpKey="newsedit-metadescription-help" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblAdditionalMetaTags" ForControl="txtAdditionalMetaTags" CssClass="settinglabel control-label col-sm-3" runat="server" ConfigKey="MetaAdditionalLabel" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtAdditionalMetaTags" TextMode="MultiLine" runat="server" />
                                                <portal:gbHelpLink ID="gbHelpLink25" runat="server" HelpKey="newsedit-additionalmeta-help" />
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlWorkflow" CssClass="workplace form-horizontal" runat="server" Visible="false">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblContentStatusLabel" CssClass="settinglabel control-label col-sm-3" runat="server" ConfigKey="ContentStatusLabel" />
                <div class="col-sm-9">
                    <asp:Literal ID="litWorkflowStatus" runat="server" />
                    <asp:ImageButton ID="ibApproveContent" OnCommand="ibApproveContent_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleApproveContentLink" Visible="false" runat="server" />
                    <asp:HyperLink ID="lnkRejectContent" Visible="false" runat="server" />
                    <asp:Image ID="statusIcon" Visible="false" runat="server" />
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblCreatedBy" CssClass="settinglabel control-label col-sm-3" runat="server" ResourceFile="NewsResources" ConfigKey="CreatedByLabel" />
                <div class="col-sm-9">
                    <p class="form-control-static">
                        <asp:Literal ID="litCreatedBy" runat="server" />
                    </p>
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblCreatedOn" CssClass="settinglabel control-label col-sm-3" runat="server" ResourceFile="NewsResources" ConfigKey="CreatedOnLabel" />
                <div class="col-sm-9">
                    <p class="form-control-static">
                        <asp:Literal ID="litCreatedOn" runat="server" />
                    </p>
                </div>
            </div>
            <div id="divRecentActionBy" visible="false" runat="server" class="settingrow form-group">
                <gb:SiteLabel ID="lblRecentActionBy" CssClass="settinglabel control-label col-sm-3" runat="server" ResourceFile="NewsResources" ConfigKey="RecentActionByLabel" />
                <div class="col-sm-9">
                    <p class="form-control-static">
                        <asp:Literal ID="litRecentActionBy" runat="server" />
                    </p>
                </div>
            </div>
            <div id="divRecentActionOn" visible="false" runat="server" class="settingrow form-group">
                <gb:SiteLabel ID="lblRecentActionOn" CssClass="settinglabel control-label col-sm-3" runat="server" ResourceFile="NewsResources" ConfigKey="RecentActionOnLabel" />
                <div class="col-sm-9">
                    <p class="form-control-static">
                        <asp:Literal ID="litRecentActionOn" runat="server" />
                    </p>
                </div>
            </div>
            <div id="divRejection" visible="false" runat="server" class="settingrow form-group">
                <gb:SiteLabel ID="lblRejectionReason" CssClass="settinglabel control-label col-sm-3" runat="server" ConfigKey="RejectionCommentLabel" />
                <div class="col-sm-9">
                    <p class="form-control-static">
                        <asp:Literal ID="ltlRejectionReason" runat="server" />
                    </p>
                </div>
            </div>
        </asp:Panel>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
    <asp:Panel CssClass="modal fade" ID="pnlModal" Visible="false" runat="server" tabindex="-1" role="dialog" aria-labelledby="pnlModalLabel">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="pnlModalLabel">
                <gb:SiteLabel ID="lblCopyNews" runat="server" UseLabelTag="false" ConfigKey="CopyNewsLabel" ResourceFile="NewsResources" />
            </h4>
          </div>
          <div class="modal-body">
            <div class="form-horizontal">
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblCopyNewsTitle" runat="server" ConfigKey="CopyNewsTitleLabel" ResourceFile="NewsResources"
                        ForControl="txtCopyTitleName" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtCopyNewsTitle" runat="server" MaxLength="255" />
                        <asp:RequiredFieldValidator ID="reqCopyNewsTitle" runat="server" ControlToValidate="txtCopyNewsTitle"
                            Display="Dynamic" SetFocusOnError="true" CssClass="txterror" ValidationGroup="newsCopy" />
                    </div>
                </div>
                <div id="divCopyNewsPublished" runat="server" class="settingrow form-group">
                    <gb:SiteLabel ID="lblCopyNewsPublished" runat="server" ConfigKey="CopyNewsPublishedLabel" ResourceFile="NewsResources"
                        ForControl="chkCopyNewsPublished" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:CheckBox ID="chkCopyNewsPublished" runat="server" Checked="true" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblCopyNewsCopyImages" runat="server" ConfigKey="CopyNewsCopyImagesLabel" ResourceFile="NewsResources"
                        ForControl="chkCopyNewsCopyImages" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:CheckBox ID="chkCopyNewsCopyImages" runat="server" Checked="true" />
                    </div>
                </div>
            </div>
          </div>
          <div class="modal-footer">
            <asp:Button ID="btnCopyNews" CssClass="btn btn-primary" Text="Copy" ValidationGroup="newsCopy" runat="server" />
          </div>
        </div>
      </div>
    </asp:Panel>
</asp:Content>