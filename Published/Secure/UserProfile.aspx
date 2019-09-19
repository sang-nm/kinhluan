<%@ Page Language="c#" MaintainScrollPositionOnPostback="true" CodeBehind="UserProfile.aspx.cs"
    MasterPageFile="~/App_MasterPages/layout.Master" AutoEventWireup="false" Inherits="CanhCam.Web.UI.Pages.UserProfile" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" />
    <asp:Panel ID="pnlUser" runat="server" DefaultButton="btnUpdate" CssClass="wrap-secure wrap-userprofile admin-content col-md-12">
        <portal:HeadingPanel ID="heading" Text="<%$Resources:Resource, UserProfileMyProfileLabel %>" runat="server">
            <asp:Button CssClass="btn btn-default" ID="btnUpdate" runat="server" Text="" ValidationGroup="profile" />
            <asp:HyperLink SkinID="DefaultButton" ID="lnkChangePassword" runat="server"></asp:HyperLink>
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div id="divtabs" class="tabs workplace">
            <ul class="nav nav-tabs">
                <li class="active" role="presentation" id="liSecurity" runat="server">
                    <asp:Literal ID="litSecurityTab" runat="server" /></li>
                <li role="presentation" id="liProfile" runat="server">
                    <asp:Literal ID="litProfileTab" runat="server" /></li>
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane fade active in" id="tabSecurity">
                    <div class="form-horizontal">
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblUserName" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="ManageUsersUserNameLabel" />
                            <div class="col-sm-9">
                                <div class="input-group">
                                    <asp:TextBox ID="txtName" runat="server" TabIndex="10" MaxLength="100" CssClass="form-control" />
                                    <portal:gbHelpLink ID="gbHelpLink11" runat="server" HelpKey="userfullnamehelp" />
                                </div>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ValidationGroup="profile"
                                    Display="None" ErrorMessage="" ControlToValidate="txtName" SkinID="Profile"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regexUserName" runat="server" ControlToValidate="txtName"
                                    Display="None" ValidationExpression="" ValidationGroup="profile" Enabled="false"
                                    SkinID="Profile"></asp:RegularExpressionValidator>
                                <asp:CustomValidator ID="FailSafeUserNameValidator" runat="server" ControlToValidate="txtName"
                                    Display="None" ValidationGroup="profile" EnableClientScript="false" SkinID="Profile"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="SitelabelLoginName" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="ManageUsersLoginNameLabel" />
                            <div class="col-sm-9">
                                <p class="form-control-static">
                                    <asp:Literal ID="lblLoginName" runat="server" />
                                </p>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblEmail" runat="server" ForControl="txtEmail" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="ManageUsersEmailLabel" />
                            <div class="col-sm-9">
                                <div class="input-group">
                                    <asp:TextBox ID="txtEmail" runat="server" TabIndex="10" CssClass="form-control" />
                                    <portal:gbHelpLink ID="gbHelpLink1" runat="server" HelpKey="useremailhelp" />
                                </div>
                                <asp:RegularExpressionValidator ID="regexEmail" runat="server" ValidationGroup="profile"
                                    ErrorMessage="" ControlToValidate="txtEmail" Display="None" SkinID="Profile"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ValidationGroup="profile"
                                    ErrorMessage="" ControlToValidate="txtEmail" Display="none" SkinID="Profile"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div id="divOpenID" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="SiteLabel4" runat="server" ForControl="OpenIdLogin1" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="ManageUsersOpenIDURILabel" />
                            <div class="col-sm-9">
                                <p class="form-control-static">
                                    <asp:Label ID="lblOpenID" runat="server" />
                                    <asp:HyperLink ID="lnkOpenIDUpdate" runat="server" />
                                    <portal:OpenIdRpxNowLink ID="rpxLink" runat="server" Embed="false" UseOverlay="true" Visible="false" />
                                </p>
                            </div>
                        </div>
                        <asp:Panel ID="pnlSecurityQuestion" runat="server">
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="SiteLabel2" runat="server" ForControl="txtPasswordQuestion" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="UsersSecurityQuestionLabel" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtPasswordQuestion" runat="server" TabIndex="10" MaxLength="255"
                                            CssClass="form-control" />
                                        <portal:gbHelpLink ID="gbHelpLink2" runat="server" HelpKey="usersecurityquestionhelp" />
                                    </div>
                                    <asp:RequiredFieldValidator ControlToValidate="txtPasswordQuestion" ID="QuestionRequired"
                                        runat="server" Display="None" ValidationGroup="profile" SkinID="Profile"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="SiteLabel3" runat="server" ForControl="txtPasswordAnswer" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="UsersSecurityAnswerLabel" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtPasswordAnswer" runat="server" TabIndex="10" MaxLength="255"
                                            CssClass="form-control" />
                                        <portal:gbHelpLink ID="gbHelpLink3" runat="server" HelpKey="usersecurityanswerhelp" />
                                    </div>
                                    <asp:RequiredFieldValidator ControlToValidate="txtPasswordAnswer" ID="AnswerRequired"
                                        runat="server" Display="None" ValidationGroup="profile" SkinID="Profile"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </asp:Panel>
                        <div id="divEditorPreference" runat="server" visible="false" class="settingrow form-group">
                            <gb:SiteLabel ID="SiteLabel29" runat="server" ForControl="ddEditorProviders" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="SiteSettingsEditorProviderLabel" EnableViewState="false" />
                            <div class="col-sm-9">
                                <div class="input-group">
                                    <asp:DropDownList ID="ddEditorProviders" DataTextField="name" DataValueField="name"
                                        EnableViewState="true" EnableTheming="false" TabIndex="10" runat="server" CssClass="forminput">
                                    </asp:DropDownList>
                                    <portal:gbHelpLink ID="gbHelpLink5" runat="server" HelpKey="sitesettingssiteeditorproviderhelp" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane fade" id="tabProfile" runat="server">
                    <div class="form-horizontal">
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblCreatedDateLabel" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="ManageUsersCreatedDateLabel" />
                            <div class="col-sm-9">
                                <p class="form-control-static">
                                    <asp:Literal ID="lblCreatedDate" runat="server" />
                                </p>
                            </div>
                        </div>
                        <div id="divSkin" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="lblSkin" runat="server" ForControl="ddSkins" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="SiteSettingsSiteSkinLabel" />
                            <div class="col-sm-9">
                                <div class="input-group">
                                    <portal:SkinList ID="SkinSetting" runat="server" AddSiteDefaultOption="true" />
                                    <portal:gbHelpLink ID="gbHelpLink4" runat="server" HelpKey="userskinhelp" />
                                </div>
                            </div>
                        </div>
                        <div id="divAvatar" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="lblAvatar" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="UserProfileAvatarLabel" />
                            <div class="col-sm-9">
                                <portal:Avatar ID="userAvatar" runat="server" CssClass="forminput" />
                                <asp:HyperLink ID="lnkAvatarUpld" CssClass="cp-link" runat="server" />
                                <asp:ImageButton ID="btnUpdateAvartar" runat="server" />
                                <portal:gbHelpLink ID="avatarHelp" runat="server" RenderWrapper="false" HelpKey="useravatarhelp" />
                            </div>
                        </div>
                        <div id="divLiveMessenger" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="SiteLabel14" runat="server" ForControl="chkEnableLiveMessengerOnProfile"
                                CssClass="settinglabel control-label col-sm-3" ConfigKey="EnableLiveMessengerLabel" />
                            <div class="col-sm-9">
                                <asp:CheckBox ID="chkEnableLiveMessengerOnProfile" runat="server" />
                                <asp:HyperLink ID="lnkAllowLiveMessenger" runat="server" Text="Enable Live Messenger" />
                                <portal:gbHelpLink ID="gbHelpLink6" runat="server" HelpKey="livemessenger-user-help" />
                            </div>
                        </div>
                        <div id="divTimeZone" runat="server" visible="false" class="settingrow form-group">
                            <gb:SiteLabel ID="SiteLabel5" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="TimeZone">
                            </gb:SiteLabel>
                            <div class="col-sm-9">
                            <portal:TimeZoneIdSetting ID="timeZoneSetting" runat="server" />
                        </div></div>
                        <asp:Panel ID="pnlProfileProperties" runat="server">
                        </asp:Panel>
                        <%--<div class="settingrow form-group">
                            <gb:SiteLabel ID="lblTotalPostsLabel" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="ManageUsersTotalPostsLabel">
                            </gb:SiteLabel>
                            <div class="col-sm-9">
                                <asp:Label ID="lblTotalPosts" runat="server"></asp:Label>
                                <portal:ForumUserThreadLink ID="lnkUserPosts" runat="server" />
                            </div>
                        </div>--%>
                        <div class="settingrow form-group">
                            <asp:HyperLink ID="lnkPubProfile" Visible="false" runat="server" CssClass="settinglabel control-label col-sm-3 cp-link" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>