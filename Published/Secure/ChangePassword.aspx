<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ChangePassword.aspx.cs" Inherits="CanhCam.Web.UI.Pages.ChangePassword" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" />
    <asp:Panel ID="pnlPassword" CssClass="wrap-secure wrap-changepass admin-content col-md-12" runat="server">
        <portal:HeadingPanel ID="heading" Text="<%$Resources:Resource, ChangePasswordLabel %>" runat="server"></portal:HeadingPanel>
        <asp:ChangePassword ID="ChangePassword1" Width="100%" runat="server">
            <ChangePasswordTemplate>
                <div class="workplace">
                    <div class="form-horizontal">
                        <asp:Panel ID="divCurrentPassword" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="lblCurrentPassword" runat="server" CssClass="settinglabel control-label col-sm-3" ForControl="CurrentPassword" ConfigKey="ChangePasswordCurrentPasswordLabel" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="CurrentPassword" EnableViewState="false" CssClass="form-control" runat="server" TextMode="password" />
                                <asp:RequiredFieldValidator ControlToValidate="CurrentPassword" ID="CurrentPasswordRequired"
                                    Display="Dynamic" runat="server" ValidationGroup="ChangePassword1"></asp:RequiredFieldValidator>
                            </div>
                        </asp:Panel>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblNewPassword" runat="server" CssClass="settinglabel control-label col-sm-3" ForControl="NewPassword" ConfigKey="ChangePasswordNewPasswordLabel" />
                            <div class="col-sm-9">
                                <telerik:RadTextBox runat="server" ID="NewPassword" EnableViewState="false" CssClass="form-control" Width="100%" EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" TextMode="Password" EnableSingleInputRendering="false">
                                    <PasswordStrengthSettings ShowIndicator="false"></PasswordStrengthSettings>
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator ControlToValidate="NewPassword" ID="NewPasswordRequired"
                                    runat="server" Display="Dynamic" ValidationGroup="ChangePassword1"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="NewPasswordRegex" runat="server" ControlToValidate="NewPassword"
                                    Display="Dynamic" ValidationGroup="ChangePassword1"></asp:RegularExpressionValidator>
                                <asp:CustomValidator ID="NewPasswordRulesValidator" runat="server" ControlToValidate="NewPassword"
                                    Display="Dynamic" ValidationGroup="ChangePassword1"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblConfirmNewPassword" runat="server" CssClass="settinglabel control-label col-sm-3" ForControl="ConfirmNewPassword" ConfigKey="ChangePasswordConfirmNewPasswordLabel" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="ConfirmNewPassword" EnableViewState="false" CssClass="form-control" runat="server" TextMode="password" />
                                <asp:RequiredFieldValidator ControlToValidate="ConfirmNewPassword" ID="ConfirmNewPasswordRequired"
                                    runat="server" Display="Dynamic" ValidationGroup="ChangePassword1"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                    ID="NewPasswordCompare" runat="server" Display="Dynamic" ValidationGroup="ChangePassword1"></asp:CompareValidator>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                                <asp:Button SkinID="DefaultButton" ID="ChangePasswordPushButton" CommandName="ChangePassword"
                                    Text="Change Password" runat="server" ValidationGroup="ChangePassword1" />
                                <asp:Button SkinID="DefaultButton" ID="CancelPushButton" CommandName="Cancel" Text="Cancel"
                                    runat="server" CausesValidation="false" />
                            </div>
                        </div>
                    </div>
                    <portal:gbLabel ID="FailureText" runat="server" CssClass="alert alert-danger" EnableViewState="false" />
                </div>
            </ChangePasswordTemplate>
            <SuccessTemplate>
                <portal:gbLabel ID="SuccessText" runat="server" CssClass="alert alert-success" Text="<%$Resources:Resource, ChangePasswordSuccessText %>" EnableViewState="false" />
            </SuccessTemplate>
        </asp:ChangePassword>
    </asp:Panel>
</asp:Content>