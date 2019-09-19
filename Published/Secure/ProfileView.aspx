<%@ Page Language="c#" CodeBehind="ProfileView.aspx.cs" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.UI.Pages.ProfileView" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="form-horizontal">
        <div class="settingrow form-group">
            <gb:SiteLabel ID="lblCreatedDateLabel" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="ManageUsersCreatedDateLabel" />
            <div class="col-sm-9"><p class="form-control-static"><asp:Label ID="lblCreatedDate" runat="server"></asp:Label></p></div>
        </div>
        <div class="settingrow form-group">
            <gb:SiteLabel ID="lblUserNameLabel" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="ManageUsersUserNameLabel" />
            <div class="col-sm-9"><p class="form-control-static"><asp:Label ID="lblUserName" runat="server" /></p></div>
        </div>
        <div id="divAvatar" runat="server" class="settingrow form-group">
            <gb:SiteLabel ID="lblAvatar" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="UserProfileAvatarLabel" />
            <div class="col-sm-9"><portal:Avatar ID="userAvatar" runat="server" /></div>
        </div>
        <asp:Panel ID="pnlTimeZone" runat="server" Visible="false" CssClass="settingrow form-group">
            <gb:SiteLabel ID="lblTimeZoneLabel" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="TimeZone" />
            <div class="col-sm-9"><p class="form-control-static"><asp:Label ID="lblTimeZone" runat="server" /></p></div>
        </asp:Panel>
        <div id="divLiveMessenger" runat="server" visible="false" class="settingrow form-group messengerpanel">
            <portal:LiveMessengerControl ID="chat1" runat="server" SkinID="profile" Width="400"
                Height="300" Invitee="" InviteeDisplayName="" OverrideCulture="" UseTheme="false"
                ThemName="" />
        </div>
        <NeatHtml:UntrustedContent ID="UntrustedContent2" runat="server" ClientScriptUrl="~/ClientScript/NeatHtml.js">
            <asp:Panel ID="pnlProfileProperties" runat="server">
            </asp:Panel>
        </NeatHtml:UntrustedContent>
    </div>
    <portal:gbLabel ID="lblMessage" runat="server" CssClass="alert alert-info" />
</asp:Content>