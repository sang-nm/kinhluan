<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SignInOrRegisterPrompt.ascx.cs"
    Inherits="CanhCam.Web.UI.SignInOrRegisterPrompt" %>
    
<div class="floatpanel signinorregister">
<div class="signinorregisterinstructions">
    <strong><asp:Literal ID="litLoginInstructions" runat="server" /></strong>
</div>
<div class="floatpanel">
    <asp:Literal ID="litLoginPrompt" runat="server" /><br />
    <asp:HyperLink ID="lnkLogin" runat="server" Text="Login" />
</div>
<div class="floatpanel">
    <asp:Literal ID="litRegisterPrompt" runat="server" /><br />
    <asp:HyperLink ID="lnkRegister" runat="server" Text="Register" />
</div>
<div id="divAdditionalRegisterOptions" runat="server" visible="false" class="clearpanel">
<div>
    <asp:Literal ID="litAdditionalRegisterOptions" runat="server" />
</div>
<div id="divOpenId" runat="server" class="floatpanel">
    <asp:Literal ID="litRegisterWithOpenId" runat="server" /><br />
    <asp:HyperLink ID="lnkRegisterWithOpenId" runat="server" Text="Login" />
</div>
<div id="divWindowsLive" runat="server" class="floatpanel">
    <asp:Literal ID="litRegisterWithWindowsLive" runat="server" /><br />
    <asp:HyperLink ID="lnkRegisterWithWindowsLive" runat="server" Text="Register" />
</div>

</div>
<asp:Panel ID="pnlJanrain" runat="server" CssClass="clearpanel" Visible="false" EnableViewState="false">
    <portal:OpenIdRpxNowLink id="janrainWidet" runat="server" />
</asp:Panel>
</div>
