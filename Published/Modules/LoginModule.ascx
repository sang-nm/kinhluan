<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="LoginModule.ascx.cs"
    Inherits="CanhCam.Web.Modules.LoginModule" %>
<%@ Register TagPrefix="gb" TagName="Login" Src="~/Secure/Controls/LoginControl.ascx" %>
<portal:LoginModuleDisplaySettings ID="displaySettings" runat="server" />
<div id="sslWarning" runat="server" class="sslwarning">
    <gb:SiteLabel ID="lblSslWarning" runat="server" CssClass="txterror warning" ConfigKey="UseSslWarning"
        ResourceFile="Resource" UseLabelTag="false" />
</div>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
    <ContentTemplate>
        <gb:Login ID="login1" runat="server" SetRedirectUrl="false" />
    </ContentTemplate>
</asp:UpdatePanel>
<portal:OpenIdRpxNowLink ID="janrainWidet" runat="server" />
<portal:WelcomeMessage ID="WelcomeMessage" runat="server" RenderAsListItem="false" SkinID="LoginModule" />
<portal:Avatar ID="avatar1" runat="server" AutoConfigure="true" />
<asp:Literal ID="litBreak" runat="server" EnableViewState="false" />
<portal:LogoutLink ID="LogoutLink" runat="server" RenderAsListItem="false" CssClass="logoutlink" />