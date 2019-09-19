<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="NewsEditControl.ascx.cs" Inherits="CanhCam.Web.NewsUI.NewsEditControl" %>

<div class="admin-content">
    <div class="heading">
        <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
            CurrentPageTitle="<%$Resources:NewsResources, NewsEditHeading %>" CurrentPageUrl="~/News/NewsEdit.aspx" />
        <portal:HeadingControl ID="heading" runat="server" />
    </div>
    <div class="toolbox">
        <asp:Button CssClass="active" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" ValidationGroup="news" runat="server" />
        <asp:Button CssClass="active" ID="btnUpdateAndNew" Text="<%$Resources:Resource, UpdateAndNewButton %>" ValidationGroup="news" runat="server" />
        <asp:Button CssClass="active" ID="btnUpdateAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" ValidationGroup="news" runat="server" />
        <asp:Button CssClass="active" ID="btnInsert" Text="<%$Resources:Resource, InsertButton %>" ValidationGroup="news" runat="server" />
        <asp:Button CssClass="active" ID="btnInsertAndNew" Text="<%$Resources:Resource, InsertAndNewButton %>" ValidationGroup="news" runat="server" />
        <asp:Button CssClass="active" ID="btnInsertAndClose" Text="<%$Resources:Resource, InsertAndCloseButton %>" ValidationGroup="news" runat="server" />
        <asp:Button ID="btnDelete" runat="server" Text="Delete this item" CausesValidation="false" />
        <asp:HyperLink ID="lnkPreview" Visible="false" runat="server" />
    </div>
    <portal:NotifyMessage ID="message" runat="server" />
    <asp:HiddenField ID="hdnHxToRestore" runat="server" />
    <asp:ImageButton ID="btnRestoreFromGreyBox" runat="server" />
    <asp:Panel ID="pnlNews" runat="server" DefaultButton="btnUpdate">
        <div id="divtabs" class="gb-tabs">
            <ul>
                <li class="selected"><a href="#tabContent">
                    <asp:Literal ID="litContentTab" runat="server" /></a></li>
                <li id="liImages" runat="server">
                    <asp:Literal ID="litImagesTab" runat="server" /></li>
                <li id="liAttribute" runat="server">
                    <asp:Literal ID="litAttributeTab" runat="server" /></li>
                <li><a href="#tabMeta">
                    <asp:Literal ID="litMetaTab" runat="server" /></a></li>
            </ul>
            <div id="tabContent">
                <div class="settingrow">
                    <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                        ForControl="ddZones" CssClass="settinglabel" />
                    <asp:DropDownList ID="ddZones" runat="server" />
                    <portal:gbHelpLink ID="GbHelpLink9" runat="server" HelpKey="newsedit-selectzone-help" />
                </div>
                <asp:UpdatePanel ID="up" runat="server">
                    <ContentTemplate>
                        <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                            EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                            CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                        <div class="settingrow">
                            <gb:SiteLabel ID="lblTitle" runat="server" ForControl="txtTitle" CssClass="settinglabel"
                                ConfigKey="NewsEditTitleLabel" ResourceFile="NewsResources" />
                            <asp:TextBox ID="txtTitle" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                            <portal:gbHelpLink ID="GbHelpLink1" runat="server" HelpKey="newsedit-title-help" />
                            <asp:RequiredFieldValidator ID="reqTitle" runat="server" ControlToValidate="txtTitle"
                                Display="Dynamic" SetFocusOnError="true" CssClass="txterror" ValidationGroup="news" />
                        </div>
                        <div class="settingrow field-hide news-subtitle">
                            <gb:SiteLabel ID="SiteLabel15" runat="server" ForControl="txtSubTitle" CssClass="settinglabel"
                                ConfigKey="SubTitle" ResourceFile="NewsResources" />
                            <asp:TextBox ID="txtSubTitle" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                            <portal:gbHelpLink ID="GbHelpLink2" runat="server" HelpKey="newsedit-subtitle-help" />
                        </div>
                        <div class="settingrow">
                            <gb:SiteLabel ID="SiteLabel5" runat="server" ForControl="txtUrl" CssClass="settinglabel"
                                ConfigKey="NewsEditItemUrlLabel" ResourceFile="NewsResources" />
                            <asp:TextBox ID="txtUrl" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                            <portal:gbHelpLink ID="GbHelpLink3" runat="server" HelpKey="newsedit-url-help" />
                            <span id="spnUrlWarning" runat="server" style="font-weight: normal; display: none;"
                                class="txterror"></span>
                            <asp:HiddenField ID="hdnTitle" runat="server" />
                            <asp:RegularExpressionValidator ID="regexUrl" runat="server" ControlToValidate="txtUrl"
                                ValidationExpression="((http\://|https\://|~/){1}(\S+){0,1})" Display="Dynamic" SetFocusOnError="true"
                                ValidationGroup="news" />
                        </div>
                        <div class="settingrow">
                            <gb:SiteLabel ID="SiteLabel11" runat="server" CssClass="settinglabel" ConfigKey="BriefContentLabel"
                                ResourceFile="NewsResources" />
                            <gbe:EditorControl ID="edBriefContent" runat="server" />
                            <portal:gbHelpLink ID="GbHelpLink4" runat="server" HelpKey="newsedit-briefcontent-help" />
                        </div>
                        <div class="settingrow">
                            <gb:SiteLabel ID="SiteLabel17" runat="server" CssClass="settinglabel" ConfigKey="Content"
                                ResourceFile="NewsResources" />
                            <gbe:EditorControl ID="edFullContent" runat="server" />
                            <portal:gbHelpLink ID="GbHelpLink5" runat="server" HelpKey="newsedit-fullcontent-help" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="settingrow" runat="server" id="divUploadImage">
                    <gb:SiteLabel ID="lblImage" runat="server" ConfigKey="ImageFile" ResourceFile="NewsResources" CssClass="settinglabel" />
                    <telerik:RadAsyncUpload ID="fileImage" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic"
                        AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                </div>
                <div class="settingrow field-hide news-attachfile">
                    <gb:SiteLabel ID="FileAttachmentLabel" runat="server" ForControl="txtFileAttachment"
                        ResourceFile="NewsResources" ConfigKey="FileAttachmentLabel" CssClass="settinglabel" />
                    <asp:TextBox ID="txtFileAttachment" MaxLength="255" runat="server" />
                    <portal:FileBrowserTextBoxExtender ID="FileAttachmentBrowser" runat="server" BrowserType="file" />
                    <portal:gbHelpLink ID="GbHelpLink7" runat="server" HelpKey="newsedit-fileattachment-help" />
                </div>
                <div id="divPosition" visible="false" runat="server" class="settingrow">
                    <gb:SiteLabel ID="lblPosition" runat="server" ForControl="chlPosition" ConfigKey="NewsPositionSetting"
                        ResourceFile="NewsResources" CssClass="settinglabel" />
                    <asp:CheckBoxList ID="chlPosition" DataValueField="Value" DataTextField="Name" runat="server" />
                </div>
                <div id="divShowOption" visible="false" runat="server" class="settingrow">
                    <gb:SiteLabel ID="lblShowOption" runat="server" ForControl="chlShowOption" ConfigKey="ShowOptionLabel"
                        ResourceFile="NewsResources" CssClass="settinglabel" />
                    <asp:CheckBoxList ID="chlShowOption" runat="server" />
                </div>
                <div class="settingrow">
                    <gb:SiteLabel ID="lblOpenInNewWindow" runat="server" ForControl="chkOpenInNewWindow" ConfigKey="OpenInNewWindowLabel"
                        ResourceFile="NewsResources" CssClass="settinglabel" />
                    <asp:CheckBox ID="chkOpenInNewWindow" runat="server" Checked="false" />
                </div>
                <div id="divIncludeInSearch" class="settingrow" Visible="false" runat="server">
                    <gb:SiteLabel ID="Sitelabel4" runat="server" ForControl="chkIncludeInSearch" ConfigKey="IncludeInSearchLabel"
                        ResourceFile="NewsResources" CssClass="settinglabel" />
                    <asp:CheckBox ID="chkIncludeInSearch" runat="server" Checked="false" />
                </div>
                <div id="divIncludeInSiteMap" class="settingrow" Visible="false" runat="server">
                    <gb:SiteLabel ID="lblIncludeInSiteMap" runat="server" ForControl="chkIncludeInSiteMap" ConfigKey="IncludeInSiteMapLabel"
                        ResourceFile="NewsResources" CssClass="settinglabel" />
                    <asp:CheckBox ID="chkIncludeInSiteMap" runat="server" Checked="false" />
                </div>
                <div id="divIncludeInFeed" class="settingrow" Visible="false" runat="server">
                    <gb:SiteLabel ID="lblIncludeInFeed" runat="server" ForControl="chkIncludeInFeed" ConfigKey="IncludeInFeedLabel"
                        ResourceFile="NewsResources" CssClass="settinglabel" />
                    <asp:CheckBox ID="chkIncludeInFeed" runat="server" Checked="false" />
                </div>
                <div id="divIsPublished" class="settingrow" runat="server">
                    <gb:SiteLabel ID="lblIsPublished" runat="server" ForControl="chkIsPublished" ConfigKey="IsPublishedLabel"
                        ResourceFile="NewsResources" CssClass="settinglabel" />
                    <asp:CheckBox ID="chkIsPublished" runat="server" Checked="true" />
                </div>
                <div class="settingrow">
                    <gb:SiteLabel ID="lblStartDate" runat="server" ConfigKey="NewsEditStartDateLabel"
                        ResourceFile="NewsResources" CssClass="settinglabel" />
                    <gb:DatePickerControl ID="dpBeginDate" runat="server" ShowTime="True" SkinID="news"
                        CssClass="forminput"></gb:DatePickerControl>
                    <portal:gbHelpLink ID="GbHelpLink10" runat="server" HelpKey="newsedit-startdate-help" />
                    <asp:RequiredFieldValidator ID="reqStartDate" runat="server" ControlToValidate="dpBeginDate"
                        Display="Dynamic" SetFocusOnError="true" CssClass="txterror" ValidationGroup="news" />
                </div>
                <div class="settingrow">
                    <gb:SiteLabel ID="lblEndDate" runat="server" ConfigKey="EndDate" ResourceFile="NewsResources"
                        CssClass="settinglabel" />
                    <gb:DatePickerControl ID="dpEndDate" runat="server" ShowTime="True" SkinID="news"
                        CssClass="forminput"></gb:DatePickerControl>
                </div>
                <div id="divCommentAllowedForDays" class="settingrow" runat="server" visible="false">
                    <gb:SiteLabel ID="lblCommentAllowedForDays" runat="server" ForControl="ddCommentAllowedForDays"
                        ConfigKey="NewsEditAllowedCommentsForDaysPrefix" ResourceFile="NewsResources"
                        CssClass="settinglabel" />
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
                <div class="newshistory">
                    <asp:UpdatePanel ID="updHx" UpdateMode="Conditional" runat="server">
                        <Triggers>
                            <asp:PostBackTrigger ControlID="grdHistory" />
                        </Triggers>
                        <ContentTemplate>
                            <asp:Panel ID="pnlHistory" runat="server" Visible="false">
                                <div class="settingrow">
                                    <gb:SiteLabel ID="SiteLabel10" runat="server" CssClass="settinglabel" ConfigKey="VersionHistory"
                                        ResourceFile="NewsResources" />
                                </div>
                                <div class="settingrow">
                                    <gb:gbGridView ID="grdHistory" runat="server" CssClass="editgrid" AutoGenerateColumns="false"
                                        DataKeyNames="Guid">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# DateTimeHelper.GetTimeZoneAdjustedDateTimeString(Eval("CreatedUtc"), timeOffset)%>
                                                    <br />
                                                    <%# Eval("UserName") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%# DateTimeHelper.GetTimeZoneAdjustedDateTimeString(Eval("HistoryUtc"), timeOffset)%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="lnkcompare" runat="server" CssClass="gb-popup" NavigateUrl='<%# SiteRoot + "/News/NewsCompare.aspx?NewsID=" + newsId + "&h=" + Eval("Guid") %>'
                                                        Text='<%# Resources.NewsResources.CompareHistoryToCurrentLink %>' ToolTip='<%# Resources.NewsResources.CompareHistoryToCurrentLink %>'
                                                        DialogCloseText='<%# Resources.NewsResources.DialogCloseLink %>' />
                                                    <asp:Button ID="btnRestoreToEditor" runat="server" Text='<%# Resources.NewsResources.RestoreToEditorButton %>'
                                                        CommandName="RestoreToEditor" CommandArgument='<%# Eval("Guid") %>' />
                                                    <asp:Button ID="btnDelete" runat="server" CommandName="DeleteHistory" CommandArgument='<%# Eval("Guid") %>'
                                                        Visible='<%# isAdmin %>' Text='<%# Resources.NewsResources.DeleteHistoryButton %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </gb:gbGridView>
                                </div>
                                <portal:gbCutePager ID="pgrHistory" runat="server" />
                                <div id="divHistoryDelete" runat="server" class="settingrow">
                                    <gb:SiteLabel ID="SiteLabel8" runat="server" CssClass="settinglabel" ConfigKey="spacer" />
                                    <asp:Button CssClass="form-button" ID="btnDeleteHistory" runat="server" />
                                </div>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div id="tabImages" runat="server">
                <asp:UpdatePanel ID="updImages" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="settingrow">
                            <gb:SiteLabel ID="lblImageFile" runat="server" ConfigKey="ImageFile" ResourceFile="NewsResources"
                                CssClass="left" />&nbsp;
                            <div class="left">
                                <telerik:RadAsyncUpload ID="uplImageFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic"
                                    AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                            </div>
                            <div class="left">
                                <portal:gbHelpLink ID="GbHelpLink11" runat="server" HelpKey="newsedit-imageupload-help" />
                                <asp:Button CssClass="form-button" ID="btnUpdateImage" OnClick="btnUpdateImage_Click"
                                    Text="<%$Resources:NewsResources, ImageUpdateButton %>" runat="server" CausesValidation="False" />
                                <asp:Button CssClass="form-button" ID="btnDeleteImage" Visible="false" OnClick="btnDeleteImage_Click"
                                    Text="<%$Resources:NewsResources, ImageDeleteSelectedButton %>" runat="server"
                                    CausesValidation="False" />
                            </div>
                            <div class="clear"></div>
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
            <div id="tabAttribute" runat="server">
                <asp:UpdatePanel ID="updAttribute" runat="server">
                    <ContentTemplate>
                        <div class="left suffix_2" style="width: 22%;">
                            <asp:ListBox ID="lbAttribute" Width="100%" Height="500" AutoPostBack="true" runat="server"
                                AppendDataBoundItems="true" DataTextField="Title" DataValueField="Guid" />
                        </div>
                        <div class="left" style="width: 2%">
                            <asp:ImageButton ID="btnUp" CommandName="up" runat="server" />
                            <br />
                            <asp:ImageButton ID="btnDown" CommandName="down" runat="server" />
                        </div>
                        <div class="left" style="width: 74%">
                            <telerik:RadTabStrip ID="tabAttributeLanguage" OnTabClick="tabAttributeLanguage_TabClick" 
                                EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                            <div class="settingrow">
                                <gb:SiteLabel ID="lblAttributeTitle" runat="server" CssClass="settinglabel" ForControl="txtAttributeTitle" ConfigKey="AttributeTitle"
                                    ResourceFile="NewsResources" />
                                <asp:TextBox ID="txtAttributeTitle" runat="server" MaxLength="255" />
                                <portal:gbHelpLink ID="GbHelpLink8" runat="server" HelpKey="newsedit-attribute-help" />
                                <%--<asp:RequiredFieldValidator ID="reqAttributeTitle" ControlToValidate="txtAttributeTitle" ErrorMessage="<%$Resources:NewsResources, AttributeTitleRequired %>"
                                    ValidationGroup="Attribute" Display="Dynamic" CssClass="txterror" runat="server" />--%>
                                <asp:Button CssClass="form-button" ID="btnAttributeUpdate" Text="<%$Resources:NewsResources, AttributeUpdateButton %>" runat="server" />
                                <asp:Button CssClass="form-button" ID="btnAttributeDelete" Text="<%$Resources:NewsResources, AttributeDeleteSelectedButton %>" runat="server" CausesValidation="False" />
                            </div>
                            <div class="settingrow">
                                <gb:SiteLabel ID="lblAttributeContent" runat="server" CssClass="settinglabel" ConfigKey="AttributeContent"
                                    ResourceFile="NewsResources" />
                                <gbe:EditorControl ID="edAttributeContent" runat="server" />
                            </div>
                        </div>
                        <div class="clear"></div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div id="tabMeta">
                <asp:UpdatePanel ID="upSEO" runat="server">
                    <ContentTemplate>
                        <telerik:RadTabStrip ID="tabLanguageSEO" OnTabClick="tabLanguageSEO_TabClick" 
                            EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                            CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                        <div class="settingrow">
                            <gb:SiteLabel ID="lblMetaTitle" runat="server" ForControl="txtMetaTitle" CssClass="settinglabel"
                                ConfigKey="MetaTitleLabel" />
                            <asp:TextBox ID="txtMetaTitle" runat="server" MaxLength="65" />
                            <portal:gbHelpLink ID="GbHelpLink6" runat="server" HelpKey="newsedit-metatitle-help" />
                        </div>
                        <div class="settingrow">
                            <gb:SiteLabel ID="SiteLabel7" runat="server" ForControl="txtMetaKeywords" CssClass="settinglabel"
                                ConfigKey="MetaKeywordsLabel" ResourceFile="NewsResources" />
                            <asp:TextBox ID="txtMetaKeywords" runat="server" MaxLength="156" />
                            <portal:gbHelpLink ID="gbHelpLink23" runat="server" HelpKey="newsedit-metadescription-help" />
                        </div>
                        <div class="settingrow">
                            <gb:SiteLabel ID="SiteLabel6" runat="server" ForControl="txtMetaDescription" CssClass="settinglabel"
                                ConfigKey="MetaDescriptionLabel" ResourceFile="NewsResources" />
                            <asp:TextBox ID="txtMetaDescription" runat="server" MaxLength="156" />
                            <portal:gbHelpLink ID="gbHelpLink22" runat="server" HelpKey="newsedit-metakeywords-help" />
                        </div>
                        <div class="settingrow">
                            <gb:SiteLabel ID="lblAdditionalMetaTags" ForControl="txtAdditionalMetaTags" CssClass="settinglabel" runat="server" ConfigKey="MetaAdditionalLabel" />
                            <asp:TextBox ID="txtAdditionalMetaTags" TextMode="MultiLine" runat="server" />
                            <portal:gbHelpLink ID="gbHelpLink25" runat="server" HelpKey="newsedit-additionalmeta-help" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </asp:Panel>
    <%--<asp:Panel ID="pnlWorkflowStatus" runat="server" Visible="false">
        <table cellspacing="0" cellpadding="0">
            <tr>
                <td width="150"><gb:SiteLabel ID="lblContentStatusLabel" runat="server" ConfigKey="ContentStatusLabel" /></td>
                <td>
                    <asp:Literal ID="litWorkflowStatus" runat="server"></asp:Literal>
                    <asp:ImageButton ID="ibPostDraftContentForApproval" OnCommand="ibPostDraftContentForApproval_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModulePostDraftForApprovalLink" Visible="false" runat="server" />
                    <asp:ImageButton ID="ibApproveContent" OnCommand="ibApproveContent_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleApproveContentLink" Visible="false" runat="server" />
                    <asp:HyperLink ID="lnkRejectContent" Visible="false" runat="server" />
                    <asp:ImageButton ID="ibCancelChanges" OnCommand="ibCancelChanges_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleCancelChangesLink" Visible="false" runat="server" />
                    <asp:Image ID="statusIcon" Visible="false" runat="server" />
                </td>
            </tr>
            <tr>
                <td><gb:SiteLabel ID="lblRecentActionBy" runat="server" ConfigKey="RejectedBy" /></td>
                <td><asp:Literal ID="litRecentActionBy" runat="server"></asp:Literal></td>
            </tr>
            <tr>
                <td><gb:SiteLabel ID="lblRecentActionOn" runat="server" ConfigKey="RejectedOn" /></td>
                <td><asp:Literal ID="litRecentActionOn" runat="server"></asp:Literal></td>
            </tr>
            <tr id="trRejection1" runat="server">
                <td><gb:SiteLabel ID="lblContentLastEditBy" runat="server" ConfigKey="ContentLastEditBy" /></td>
                <td><asp:Literal ID="litCreatedBy" runat="server"></asp:Literal></td>
            </tr>
            <tr id="trRejection2" runat="server">
                <td><gb:SiteLabel ID="lblRejectionReason" runat="server" ConfigKey="RejectionCommentLabel" /></td>
                <td><asp:Literal ID="ltlRejectionReason" runat="server"></asp:Literal></td>
            </tr>
        </table>
    </asp:Panel>--%>
    <portal:SessionKeepAliveControl ID="ka1" runat="server" />
</div>