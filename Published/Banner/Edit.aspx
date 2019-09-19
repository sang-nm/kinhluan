<%@ Page Language="c#" CodeBehind="Edit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.BannerUI.BannerEdit" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Banner" Namespace="CanhCam.Web.BannerUI" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:BannerDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:BannerResources, BannerEditImageLabel %>" CurrentPageUrl="~/Banner/Edit.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upButton" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:BannerResources, BannerEditUpdateButton %>" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndNew" Text="<%$Resources:Resource, UpdateAndNewButton %>" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsert" Text="<%$Resources:Resource, InsertButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndNew" Text="<%$Resources:Resource, InsertAndNewButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndClose" Text="<%$Resources:Resource, InsertAndCloseButton %>" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:BannerResources, BannerEditDeleteButton %>" CausesValidation="false" />
                    <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="workplace form-horizontal">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel" ResourceFile="Resource"
                    ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <portal:ComboBox ID="cobZones" SelectionMode="Multiple" runat="server" />
                </div>
            </div>
            <div id="divPosition" visible="false" runat="server" class="settingrow form-group">
                <gb:SiteLabel ID="lblPosition" runat="server" ForControl="chkListPosition" CssClass="settinglabel control-label col-sm-3"
                    ConfigKey="BannerPositionLabel" ResourceFile="BannerResources" />
                <div class="col-sm-9">
                    <asp:CheckBoxList ID="chkListPosition" runat="server" DataTextField="Name" DataValueField="Value" SkinID="Enum" />
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblOpenInNewWindow" runat="server" ForControl="chkOpenInNewWindow" CssClass="settinglabel control-label col-sm-3"
                    ConfigKey="OpenInNewWindowLabel" ResourceFile="BannerResources" />
                <div class="col-sm-9">
                    <asp:CheckBox ID="chkOpenInNewWindow" runat="server" />
                </div>
            </div>
            <asp:UpdatePanel ID="up" runat="server">
                <ContentTemplate>
                    <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                        EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                        CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblCaption" runat="server" ForControl="txtCaption" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="BannerCaptionLabel" ResourceFile="BannerResources" />
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtCaption" runat="server" MaxLength="255" />
                        </div>
                    </div>
                    <div id="divDescription" runat="server" class="settingrow form-group">
                        <gb:SiteLabel ID="lblDescription" runat="server" ForControl="txtDescription" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="BannerDescriptionLabel" ResourceFile="BannerResources" />
                        <div class="col-sm-9">
                            <div class="input-group">
                                <gbe:EditorControl ID="edDescription" runat="server" />
                                <asp:TextBox ID="txtDescription" Visible="false" runat="server" />
                                <portal:gbHelpLink ID="GbHelpLink3" runat="server" HelpKey="banneredit-description-help" />
                            </div>
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblUrl" ForControl="txtUrl" CssClass="settinglabel control-label col-sm-3" runat="server"
                            ConfigKey="BannerUrlLabel" ResourceFile="BannerResources" />
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtUrl" runat="server" MaxLength="255" />
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblImageFile" runat="server" ForControl="uplImageFile" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="BannerFileLabel" ResourceFile="BannerResources" />
                        <div class="col-sm-9">
                            <img alt="" id="imgImage" visible="false" runat="server" src="/Data/SiteImages/1x1.gif" />
                            <telerik:RadAsyncUpload ID="uplImageFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Disabled"
                                AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                        </div>
                    </div>
                    <div id="divThumb" runat="server" class="settingrow form-group">
                        <gb:SiteLabel ID="lblThumbnail" runat="server" ForControl="uplThumb" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="ThumbnailLabel" ResourceFile="BannerResources" />
                        <div class="col-sm-9">
                            <img alt="" id="imgThumb" visible="false" runat="server" src="/Data/SiteImages/1x1.gif" />
                            <telerik:RadAsyncUpload ID="uplThumb" SkinID="radAsyncUploadSkin" MultipleFileSelection="Disabled"
                                AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
