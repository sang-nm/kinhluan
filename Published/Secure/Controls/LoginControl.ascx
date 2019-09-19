<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="LoginControl.ascx.cs"
    Inherits="CanhCam.Web.UI.LoginControl" %>

<div class="panel-heading">
    <gb:SiteLabel ID="lblEnterUsernamePassword" runat="server" UseLabelTag="false" />
</div>
<portal:SiteLogin ID="LoginCtrl" runat="server" CssClass="loginForm">
    <LayoutTemplate>
        <asp:Panel ID="pnlLContainer" CssClass="panel-body" runat="server" DefaultButton="Login">
            <div class="form-horizontal">
                <div class="form-group">
                    <gb:SiteLabel ID="lblEmail" runat="server" CssClass="col-sm-2 control-label" ForControl="UserName" ConfigKey="SignInEmailLabel" />
                    <gb:SiteLabel ID="lblUserID" runat="server" CssClass="col-sm-2 control-label" ForControl="UserName" ConfigKey="ManageUsersLoginNameLabel" />
                    <div class="col-sm-10">
                        <asp:TextBox id="UserName" runat="server" CssClass="form-control" maxlength="100" />
                    </div>
                </div>
                <div class="form-group">
                    <gb:SiteLabel ID="lblPassword" runat="server" CssClass="col-sm-2 control-label" ForControl="Password" ConfigKey="SignInPasswordLabel" />
                    <div class="col-sm-10">
                        <asp:TextBox id="Password" runat="server" CssClass="form-control" textmode="password" />
                    </div>
                </div>
                <asp:Panel class="captcha" id="divCaptcha" runat="server">
                    <telerik:RadCaptcha ID="captcha" runat="server" EnableRefreshImage="true" 
                        CaptchaTextBoxCssClass="form-control" CaptchaTextBoxLabel="" ErrorMessage="<%$Resources:Resource, CaptchaFailureMessage %>" 
                        CaptchaTextBoxTitle="<%$Resources:Resource, CaptchaInstructions %>" 
                        CaptchaLinkButtonText="<%$Resources:Resource, CaptchaRefreshImage %>" />
                </asp:Panel>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <asp:CheckBox id="RememberMe" runat="server" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <asp:Button CssClass="btn btn-primary" ID="Login" CommandName="Login" runat="server" Text="Login" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <asp:Hyperlink id="lnkPasswordRecovery" runat="server" />&nbsp;
                        <asp:Hyperlink id="lnkRegisterExtraLink" runat="server" />
                    </div>
                </div>
            </div>
            <portal:gbLabel ID="FailureText" runat="server" CssClass="alert alert-danger" EnableViewState="false" />
        </asp:Panel>
    </LayoutTemplate>
</portal:SiteLogin>