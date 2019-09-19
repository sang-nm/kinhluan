<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="LoginControl.ascx.cs"
    Inherits="CanhCam.Web.UI.LoginControl" %>
<portal:SiteLogin ID="LoginCtrl" runat="server" CssClass="logincontrol">
    <LayoutTemplate>
        <asp:Panel id="pnlLContainer" runat="server" defaultbutton="Login">
            <div class="wrap01">
                <strong>
                    <gb:SiteLabel ID="lblEmail" runat="server" ForControl="UserName" ConfigKey="SignInEmailLabel">
                    </gb:SiteLabel>
                    <gb:SiteLabel ID="lblUserID" runat="server" ForControl="UserName" ConfigKey="ManageUsersLoginNameLabel">
                    </gb:SiteLabel>
                </strong>
                <br />
                <asp:TextBox ID="UserName" runat="server" CssClass="normaltextbox signinbox" MaxLength="100" />
            </div>
            <div class="wrap01">
                <strong>
                    <gb:SiteLabel ID="lblPassword" runat="server" ForControl="Password" ConfigKey="SignInPasswordLabel">
                    </gb:SiteLabel>
                </strong>
                <br />
                <asp:TextBox ID="Password" runat="server" CssClass="normaltextbox passwordbox" TextMode="password" />
            </div>
            <div class="wrap01">
                <asp:CheckBox id="RememberMe" runat="server" />
            </div>
            <asp:Panel class="wrap01" id="divCaptcha" runat="server">
                <gb:CaptchaControl ID="captcha" runat="server" />
            </asp:Panel>
            <div class="wrap01">
                <asp:Button CssClass="cp-button" ID="Login" CommandName="Login" runat="server" Text="Login" />
                <asp:Hyperlink id="lnkPasswordRecovery" runat="server" CssClass="cp-link"/>&nbsp;
                <asp:Hyperlink id="lnkRegisterExtraLink" runat="server" CssClass="cp-link" />
            </div>
            <div class="cp-error">
                <portal:gbLabel ID="FailureText" runat="server" CssClass="txterror" EnableViewState="false" />
            </div>
        </asp:Panel>
    </LayoutTemplate>
</portal:SiteLogin>