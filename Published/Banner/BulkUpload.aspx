<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="BulkUpload.aspx.cs" Inherits="CanhCam.Web.BannerUI.BulkUploadPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:HeadingControl ID="heading" runat="server" />
    <div class="settingrow" id="divLanguage" visible="false" runat="server">
        <gb:SiteLabel ID="Sitelabel4" runat="server" ForControl="ddLanguage" CssClass="settinglabel"
            ConfigKey="BannerEditLanguageLabel" ResourceFile="BannerResources"></gb:SiteLabel>
        <asp:DropDownList ID="ddLanguage" AppendDataBoundItems="true"
            DataTextField="Name" DataValueField="LangCode" runat="server" />
    </div>
    <div class="settingrow">
        <label class="settinglabel">&nbsp;</label>
        <div class="left">
            <telerik:RadAsyncUpload ID="uplImageFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic"
                AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
        </div>
        <div class="clear"></div>
    </div>
    <div class="tabs-button">
        <asp:Button CssClass="cp-button" ID="btnUpload" runat="server" />&nbsp;
        <asp:HyperLink ID="lnkCancel" runat="server" CssClass="cp-link" />&nbsp;
        <asp:Label ID="lblError" runat="server" CssClass="txterror"></asp:Label>
        <asp:HiddenField ID="hdnReturnUrl" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />