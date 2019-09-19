<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="AdminProductEditControl.ascx.cs" Inherits="CanhCam.Web.ProductUI.AdminProductEditControl" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Product" Namespace="CanhCam.Web.ProductUI" %>
<%@ Register TagPrefix="Site" TagName="ProductRelated" Src="~/Product/Controls/ProductRelatedControl.ascx" %>

<Site:ProductDisplaySettings ID="displaySettings" runat="server" />
<portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
    CurrentPageTitle="<%$Resources:ProductResources, ProductAddNewTitle %>" CurrentPageUrl="~/Product/AdminProductEdit.aspx" />
<div class="admin-content col-md-12">
    <asp:UpdatePanel ID="upButton" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <portal:HeadingPanel ID="heading" runat="server">
                <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" ValidationGroup="product" runat="server" />
                <asp:Button SkinID="UpdateButton" ID="btnUpdateAndNew" Text="<%$Resources:Resource, UpdateAndNewButton %>" ValidationGroup="product" runat="server" />
                <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" ValidationGroup="product" runat="server" />
                <asp:Button SkinID="InsertButton" ID="btnInsert" Text="<%$Resources:Resource, InsertButton %>" ValidationGroup="product" runat="server" />
                <asp:Button SkinID="InsertButton" ID="btnInsertAndNew" Text="<%$Resources:Resource, InsertAndNewButton %>" ValidationGroup="product" runat="server" />
                <asp:Button SkinID="InsertButton" ID="btnInsertAndClose" Text="<%$Resources:Resource, InsertAndCloseButton %>" ValidationGroup="product" runat="server" />
                <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="Delete this item" CausesValidation="false" />
                <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                <asp:HyperLink SkinID="DefaultButton" ID="lnkPreview" Visible="false" runat="server" />
            </portal:HeadingPanel>
            <portal:NotifyMessage ID="message" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="workplace">
        <asp:Panel ID="pnlNews" runat="server" DefaultButton="btnUpdate">
            <div id="divtabs" class="tabs">
                <ul class="nav nav-tabs">
                    <li role="presentation" class="active"><a aria-controls="tabContent" role="tab" data-toggle="tab" href="#tabContent">
                        <asp:Literal ID="litContentTab" runat="server" /></a></li>
                    <li role="presentation" id="liImages" runat="server">
                        <asp:Literal ID="litImagesTab" runat="server" /></li>
                    <li role="presentation" id="liAttribute" runat="server">
                        <asp:Literal ID="litAttributeTab" runat="server" /></li>
                    <li role="presentation" id="liCustomField" visible="false" runat="server">
                        <asp:Literal ID="litCustomFieldTab" runat="server" />
                    </li>
                    <li role="presentation" id="liRelatedProduct" runat="server">
                        <asp:Literal ID="litRelatedProductTab" runat="server" />
                    </li>
                    <li role="presentation"><a aria-controls="tabMeta" role="tab" data-toggle="tab" href="#tabMeta">
                        <asp:Literal ID="litMetaTab" runat="server" /></a></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane fade active in" id="tabContent">
                        <div class="form-horizontal">
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                                    ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddZones" runat="server" />
                                        <portal:gbHelpLink ID="GbHelpLink9" runat="server" HelpKey="productedit-selectzone-help" />
                                    </div>
                                </div>
                            </div>
                            <div id="divProductCode" runat="server" class="settingrow form-group product-code">
                                <gb:SiteLabel ID="lblProductCode" runat="server" ConfigKey="ProductCodeLabel" ResourceFile="ProductResources"
                                    ForControl="txtProductCode" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtProductCode" MaxLength="50" runat="server" />
                                        <portal:gbHelpLink ID="GbHelpLink12" runat="server" HelpKey="productedit-productcode-help" />
                                    </div>
                                </div>
                            </div>
                            <div id="divPrice" runat="server" class="settingrow form-group product-price">
                                <gb:SiteLabel ID="lblPrice" runat="server" ConfigKey="ProductPriceLabel" ResourceFile="ProductResources"
                                    ForControl="txtPrice" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtPrice" SkinID="PriceTextBox" MaxLength="50" runat="server" />
                                        <portal:gbHelpLink ID="GbHelpLink13" runat="server" HelpKey="productedit-price-help" />
                                    </div>
                                </div>
                            </div>
                            <div id="divOldPrice" runat="server" class="settingrow form-group product-oldprice">
                                <gb:SiteLabel ID="lblOldPrice" runat="server" ConfigKey="ProductOldPriceLabel" ResourceFile="ProductResources"
                                    ForControl="txtOldPrice" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtOldPrice" SkinID="PriceTextBox" MaxLength="50" runat="server" />
                                        <portal:gbHelpLink ID="GbHelpLink14" runat="server" HelpKey="productedit-oldprice-help" />
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
                                            ConfigKey="ProductNameLabel" ResourceFile="ProductResources" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtTitle" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                                                <portal:gbHelpLink ID="GbHelpLink1" runat="server" HelpKey="productedit-title-help" />
                                            </div>
                                            <asp:RequiredFieldValidator ID="reqTitle" runat="server" ControlToValidate="txtTitle"
                                                Display="Dynamic" SetFocusOnError="true" CssClass="txterror" ValidationGroup="product" />
                                        </div>
                                    </div>
                                    <div id="divSubTitle" runat="server" class="settingrow form-group product-subtitle">
                                        <gb:SiteLabel ID="SiteLabel15" runat="server" ForControl="txtSubTitle" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="SubTitle" ResourceFile="NewsResources" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtSubTitle" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                                                <portal:gbHelpLink ID="GbHelpLink2" runat="server" HelpKey="productedit-subtitle-help" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel5" runat="server" ForControl="txtUrl" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="NewsEditItemUrlLabel" ResourceFile="NewsResources" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtUrl" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                                                <portal:gbHelpLink ID="GbHelpLink3" runat="server" HelpKey="productedit-url-help" />
                                            </div>
                                            <span id="spnUrlWarning" runat="server" style="font-weight: normal; display: none;"
                                                class="txterror"></span>
                                            <asp:HiddenField ID="hdnTitle" runat="server" />
                                            <asp:RegularExpressionValidator ID="regexUrl" runat="server" ControlToValidate="txtUrl"
                                                ValidationExpression="((http\://|https\://|~/){1}(\S+){0,1})" Display="Dynamic" SetFocusOnError="true"
                                                ValidationGroup="product" />
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel11" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="BriefContentLabel"
                                            ResourceFile="NewsResources" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <gbe:EditorControl ID="edBriefContent" runat="server" />
                                                <portal:gbHelpLink ID="GbHelpLink4" runat="server" HelpKey="productedit-briefcontent-help" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel17" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="Content"
                                            ResourceFile="NewsResources" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <gbe:EditorControl ID="edFullContent" runat="server" />
                                                <portal:gbHelpLink ID="GbHelpLink5" runat="server" HelpKey="productedit-fullcontent-help" />
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
                            <div id="divFileAttachment" runat="server" class="settingrow form-group product-attachfile">
                                <gb:SiteLabel ID="FileAttachmentLabel" runat="server" ForControl="txtFileAttachment"
                                    ResourceFile="NewsResources" ConfigKey="FileAttachmentLabel" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtFileAttachment" MaxLength="255" runat="server" />
                                        <div class="input-group-addon">
                                            <portal:FileBrowserTextBoxExtender ID="FileAttachmentBrowser" runat="server" BrowserType="file" />
                                        </div>
                                        <portal:gbHelpLink ID="GbHelpLink7" runat="server" HelpKey="productedit-fileattachment-help" />
                                    </div>
                                </div>
                            </div>
                            <div ID="divProductTags" class="settingrow form-group product-tags" runat="server">
                                <gb:SiteLabel ID="lblProductTags" runat="server" ForControl="autProductTags" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="ProductTagsLabel" ResourceFile="ProductResources"></gb:SiteLabel>
                                <div class="col-sm-9">
                                    <telerik:RadAutoCompleteBox ID="autProductTags" SkinID="radAutoCompleteBoxSkin"
                                        Width="100%" DropDownWidth="100%" AllowCustomEntry="true"
                                        WebServiceSettings-Path="~/Product/AdminProductEdit.aspx" WebServiceSettings-Method="GetProductTags"
                                        runat="server"></telerik:RadAutoCompleteBox>
                                </div>
                            </div>
                            <div id="divPosition" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="lblPosition" runat="server" ForControl="chlPosition" ConfigKey="NewsPositionSetting"
                                    ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <asp:CheckBoxList ID="chlPosition" SkinID="Enum" DataValueField="Value" DataTextField="Name" runat="server" />
                                </div>
                            </div>
                            <div id="divShowOption" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="lblShowOption" runat="server" ForControl="chlShowOption" ConfigKey="ShowOptionLabel"
                                    ResourceFile="ProductResources" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <asp:CheckBoxList ID="chlShowOption" SkinID="Enum" runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblOpenInNewWindow" runat="server" ForControl="chkOpenInNewWindow" ConfigKey="OpenInNewWindowLabel"
                                    ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkOpenInNewWindow" runat="server" Checked="false" />
                                </div>
                            </div>
                            <div id="divIsPublished" class="settingrow form-group" runat="server">
                                <gb:SiteLabel ID="lblIsPublished" runat="server" ForControl="chkIsPublished" ConfigKey="IsPublishedLabel"
                                    ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkIsPublished" runat="server" Checked="true" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblStartDate" runat="server" ConfigKey="NewsEditStartDateLabel"
                                    ResourceFile="NewsResources" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <gb:DatePickerControl ID="dpBeginDate" runat="server" ShowTime="True" SkinID="product"
                                        CssClass="forminput"></gb:DatePickerControl>
                                    <portal:gbHelpLink ID="GbHelpLink10" runat="server" RenderWrapper="false" HelpKey="productedit-startdate-help" />
                                    <asp:RequiredFieldValidator ID="reqStartDate" runat="server" ControlToValidate="dpBeginDate"
                                        Display="Dynamic" SetFocusOnError="true" CssClass="txterror" ValidationGroup="product" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblEndDate" runat="server" ConfigKey="EndDate" ResourceFile="NewsResources"
                                    CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <gb:DatePickerControl ID="dpEndDate" runat="server" ShowTime="True" SkinID="product"
                                        CssClass="forminput"></gb:DatePickerControl>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="tabImages" runat="server">
                        <asp:UpdatePanel ID="updImages" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="form-horizontal">
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblProductImages" runat="server" ConfigKey="ProductImagesLabel" ResourceFile="ProductResources"
                                            CssClass="settinglabel control-label col-sm-3" />
                                        <div class="col-sm-9">
                                            <telerik:RadAsyncUpload ID="uplImageFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic" HideFileInput="true"
                                                AllowedFileExtensions="jpg,jpeg,gif,png" Localization-Select="<%$Resources:ProductResources, SelectFromComputerLabel %>" runat="server" />
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblVideoPath" runat="server" ConfigKey="ProductVideoUrlLabel" ResourceFile="ProductResources"
                                            CssClass="settinglabel control-label col-sm-3" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtVideoPath" MaxLength="255" runat="server" />
                                                <div class="input-group-addon">
                                                    <portal:FileBrowserTextBoxExtender ID="VideoFileBrowser" Text='<%$Resources:ProductResources, BrowserOnServerLink %>' runat="server" BrowserType="video" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <asp:Button SkinID="DefaultButton" ID="btnUpdateImage" OnClick="btnUpdateImage_Click"
                                                Text="<%$Resources:ProductResources, ProductUpdateButton %>" runat="server" CausesValidation="False" />
                                            <asp:Button SkinID="DefaultButton" ID="btnDeleteImage" Visible="false" OnClick="btnDeleteImage_Click"
                                                Text="<%$Resources:ProductResources, ProductDeleteSelectedButton %>" runat="server"
                                                CausesValidation="False" />
                                            <portal:gbHelpLink ID="GbHelpLink11" runat="server" RenderWrapper="false" HelpKey="productedit-mediaupload-help" />
                                        </div>
                                    </div>
                                </div>
                                <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server"
                                    OnNeedDataSource="grid_NeedDataSource" OnItemDataBound="grid_ItemDataBound">
                                    <MasterTableView DataKeyNames="Guid,LanguageId,DisplayOrder,Title,MediaType,MediaFile,ThumbnailFile">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductThumbnailLabel %>" >
                                                <ItemTemplate>
                                                    <portal:MediaElement ID="ml1" runat="server" Width="100" FileUrl='<%# CanhCam.Web.ProductUI.ProductHelper.GetMediaFilePath(thumbnailImageFolderPath, Eval("ThumbnailFile").ToString()) %>' />
                                                    <telerik:RadAsyncUpload ID="fupThumbnail" SkinID="radAsyncUploadSkin" Width="100%" HideFileInput="true" MultipleFileSelection="Disabled"
                                                        AllowedFileExtensions="jpg,jpeg,gif,png" Localization-Select="<%$Resources:ProductResources, SelectFromComputerLabel %>" runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductImagesLabel %>" UniqueName="MediaFile">
                                                <ItemTemplate>
                                                    <portal:MediaElement ID="ml2" runat="server" Width="100" IncludeDownloadLinkForMedia="false" FileUrl='<%# CanhCam.Web.ProductUI.ProductHelper.GetMediaFilePath(imageFolderPath, Eval("MediaFile").ToString()) %>' />
                                                    <telerik:RadAsyncUpload ID="fupImageFile" SkinID="radAsyncUploadSkin" Width="100%" HideFileInput="true" MultipleFileSelection="Disabled"
                                                        AllowedFileExtensions="jpg,jpeg,gif,png" Localization-Select="<%$Resources:ProductResources, SelectFromComputerLabel %>" runat="server" />
                                                    <asp:TextBox ID="txtVideoPath" MaxLength="255" Text='<%# Eval("MediaFile").ToString().Contains("/") ? Eval("MediaFile").ToString() : "" %>' runat="server" />
                                                    <portal:FileBrowserTextBoxExtender ID="VideoFileBrowser" Text='<%$Resources:VideoResources, FileBrowserLink %>' runat="server" BrowserType="video" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductImageTitleLabel %>">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTitle" CssClass="input-grid" Width="97%" MaxLength="255" Text='<%# Eval("Title") %>'
                                                        runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <%--<telerik:GridTemplateColumn HeaderStyle-Width="150" HeaderText="<%$Resources:ProductResources, ProductPictureTypeLabel %>" UniqueName="MediaType">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlMediaType" AppendDataBoundItems="true" DataValueField="CustomFieldOptionID" DataTextField="Name" runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>--%>
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
                    <div role="tabpanel" class="tab-pane fade" id="tabAttribute" runat="server">
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
                                                        <portal:gbHelpLink ID="GbHelpLink8" runat="server" HelpKey="productedit-attribute-help" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <div class="col-sm-offset-3 col-sm-9">
                                                    <asp:Button SkinID="DefaultButton" ID="btnAttributeUpdate" Text="<%$Resources:NewsResources, AttributeUpdateButton %>" runat="server" />
                                                    <asp:Button SkinID="DefaultButton" ID="btnDeleteAttributeLanguage" Visible="false" OnClick="btnDeleteAttributeLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="lblAttributeContent" runat="server" CssClass="settinglabel" ConfigKey="AttributeContent"
                                                    ResourceFile="NewsResources" />
                                                <div>
                                                    <gbe:EditorControl ID="edAttributeContent" runat="server" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="tabCustomField" visible="false" runat="server">
                        <div class="form-horizontal">
                            <asp:Repeater ID="rptCustomFields" runat="server">
                                <ItemTemplate>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblText" runat="server" Text='<%#Eval("Name") %>' ForControl="txtField" CssClass="settinglabel control-label col-sm-3" />
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="txtField" runat="server" />
                                            <asp:DropDownList ID="ddlField" AppendDataBoundItems="true" DataTextField="Name" DataValueField="CustomFieldOptionID" runat="server" />
                                            <asp:CheckBoxList ID="cblField" DataTextField="Name" DataValueField="CustomFieldOptionID" SkinID="Enum" runat="server" />
                                            <asp:HiddenField ID="hdfCustomFieldId" Value='<%#Eval("CustomFieldId")%>' runat="server" />
                                            <asp:HiddenField ID="hdfDataType" Value='<%#Eval("DataType")%>' runat="server" />
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="tabRelatedProduct" runat="server">
                        <Site:ProductRelated ID="relatedProduct" runat="server" />
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="tabMeta">
                        <asp:UpdatePanel ID="upSEO" runat="server">
                            <ContentTemplate>
                                <telerik:RadTabStrip ID="tabLanguageSEO" OnTabClick="tabLanguageSEO_TabClick" 
                                    EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                    CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                                <div class="form-horizontal">
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblMetaTitle" runat="server" ForControl="txtMetaTitle" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="MetaTitleLabel" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtMetaTitle" runat="server" MaxLength="65" />
                                                <portal:gbHelpLink ID="GbHelpLink6" runat="server" HelpKey="productedit-metatitle-help" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblMetaDescription" runat="server" ForControl="txtMetaDescription" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="MetaDescriptionLabel" ResourceFile="NewsResources" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtMetaDescription" runat="server" MaxLength="156" />
                                                <portal:gbHelpLink ID="gbHelpLink22" runat="server" HelpKey="productedit-metakeywords-help" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblMetaKeywords" runat="server" ForControl="txtMetaKeywords" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="MetaKeywordsLabel" ResourceFile="NewsResources" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtMetaKeywords" runat="server" MaxLength="156" />
                                                <portal:gbHelpLink ID="gbHelpLink23" runat="server" HelpKey="productedit-metadescription-help" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblAdditionalMetaTags" ForControl="txtAdditionalMetaTags" CssClass="settinglabel control-label col-sm-3" runat="server" ConfigKey="MetaAdditionalLabel" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtAdditionalMetaTags" CssClass="form-control" TextMode="MultiLine" runat="server" />
                                                <portal:gbHelpLink ID="gbHelpLink25" runat="server" HelpKey="productedit-additionalmeta-help" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
    <portal:SessionKeepAliveControl ID="ka1" runat="server" />
</div>