<%@ Page Language="c#" CodeBehind="GalleryEdit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.GalleryUI.GalleryEdit" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.ImageGallery" Namespace="CanhCam.Web.GalleryUI" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:GalleryDisplaySettings ID="displaySettings" runat="server" />
    <portal:HeadingControl ID="heading" runat="server" />
    <asp:Panel ID="pnlEdit" runat="server" DefaultButton="btnUpdate">
        <div class="settingrow">
            <gb:SiteLabel ID="lblCaption" runat="server" ForControl="txtCaption" CssClass="settinglabel"
                ConfigKey="GalleryCaptionLabel" ResourceFile="GalleryResources"></gb:SiteLabel>
            <asp:TextBox ID="txtCaption" runat="server" MaxLength="255"></asp:TextBox>
        </div>
        <div class="settingrow" id="divAlbum" runat="server">
            <gb:SiteLabel ID="Sitelabel4" runat="server" ForControl="cobAlbum" CssClass="settinglabel"
                ConfigKey="GalleryAlbumLabel" ResourceFile="GalleryResources"></gb:SiteLabel>
            <telerik:RadComboBox ID="cobAlbum" AllowCustomText="true" MaxLength="255" SkinID="radComboBoxSkin"
                DataTextField="Title" DataValueField="AlbumID" runat="server">
            </telerik:RadComboBox>
        </div>
        <div class="settingrow">
            <gb:SiteLabel ID="Sitelabel2" runat="server" ForControl="txtUrl" CssClass="settinglabel"
                ConfigKey="GalleryUrlLabel" ResourceFile="GalleryResources"></gb:SiteLabel>
            <asp:TextBox ID="txtUrl" runat="server" MaxLength="255"></asp:TextBox>
        </div>
        <div class="settingrow">
            <gb:SiteLabel ID="lblDisplayOrder" runat="server" ForControl="txtDisplayOrder" CssClass="settinglabel"
                ConfigKey="GalleryDisplayOrderLabel" ResourceFile="GalleryResources"></gb:SiteLabel>
            <asp:TextBox ID="txtDisplayOrder" runat="server" MaxLength="4" Width="50" Text="0"></asp:TextBox>
        </div>
        <div class="settingrow">
            <label class="settinglabel">
                &nbsp;</label>
            <img alt="" id="imgThumb" runat="server" src="/Data/SiteImages/1x1.gif" />
        </div>
        <div class="settingrow">
            <gb:SiteLabel ID="Sitelabel3" runat="server" ForControl="uplImageFile" CssClass="settinglabel"
                ConfigKey="GalleryFileLabel" ResourceFile="GalleryResources"></gb:SiteLabel>
            <div class="left">
                <telerik:RadAsyncUpload ID="uplImageFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Disabled"
                    AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                <portal:gbHelpLink ID="GbHelpLink1" runat="server" HelpKey="galleryedit-imageupload-help" />
            </div>
            <div class="clear">
            </div>
        </div>
        <div class="settingrow">
            <portal:gbLabel ID="lblMessage" runat="server" CssClass="txterror" />
        </div>
        <div class="tabs-button">
            <asp:Button CssClass="form-button" ID="btnUpdate" runat="server" />&nbsp;
            <asp:Button CssClass="form-button" ID="btnDelete" runat="server" CausesValidation="false" />&nbsp;
            <asp:HyperLink ID="lnkCancel" runat="server" CssClass="cp-link" />
        </div>
    </asp:Panel>
    <asp:HiddenField ID="hdnReturnUrl" runat="server" />
    <portal:SessionKeepAliveControl ID="ka1" runat="server" />
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
