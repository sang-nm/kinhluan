<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="RegisterWithOpenID.aspx.cs" Inherits="CanhCam.Web.UI.Pages.RegisterWithOpenId" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <gb:CornerRounderTop ID="ctop1" runat="server" />
    <asp:Panel ID="pnlRegister" runat="server" CssClass="panelwrapper register">
        <div class="modulecontent">
            <fieldset>
                <legend>
                    <gb:SiteLabel ID="lblRegisterLabel" runat="server" ConfigKey="OpenIDRegistrationHeading"
                        UseLabelTag="false" />
                </legend>
                <asp:Panel ID="pnlAuthenticated" runat="server" Visible="false">
                    <asp:Literal ID="litAlreadyAuthenticated" runat="server" />
                </asp:Panel>
                <asp:Panel ID="pnlRegisterWrapper" runat="server">
                    <asp:Panel ID="pnlOpenID" runat="server" CssClass="floatpanel" Visible="true">
                        <div id="divAgreement" runat="server">
                        </div>
                        <portal:gbOpenIdRegister ID="OpenIdLogin1" runat="server" CssClass="openid_login"
                            RequestCountry="Request" RequestEmail="Require" RequestGender="Request" RequestPostalCode="Request"
                            RequestTimeZone="Request" />
                        <br />
                        <asp:Label ID="lblLoginFailed" runat="server" EnableViewState="False" Visible="False" />
                        <asp:Label ID="lblLoginCanceled" runat="server" EnableViewState="False" Visible="False" />
                        <asp:Literal ID="litResult" runat="server" />
                    </asp:Panel>
                    <asp:Panel ID="pnlNeededProfileProperties" runat="server" Visible="false">
                        <div class="settingrow">
                            <gb:SiteLabel ID="SiteLabel1" runat="server" CssClass="settinglabel" ConfigKey="OpenIDLabel">
                            </gb:SiteLabel>
                            <asp:Literal ID="litOpenIDURI" runat="server" />
                        </div>
                        <div id="divEmailDisplay" runat="server" class="settingrow">
                            <gb:SiteLabel ID="SiteLabel2" runat="server" CssClass="settinglabel" ConfigKey="RegisterEmailLabel">
                            </gb:SiteLabel>
                            <asp:Literal ID="litEmail" runat="server" />
                        </div>
                        <div id="divEmailInput" runat="server" class="settingrow">
                            <gb:SiteLabel ID="lblRegisterEmail1" runat="server" ForControl="txtEmail" CssClass="settinglabel"
                                ConfigKey="RegisterEmailLabel" />
                            <asp:TextBox ID="txtEmail" runat="server" Columns="30" MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="txtEmail" ID="EmailRequired" runat="server"
                                ValidationGroup="profile" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtEmail"
                                ValidationGroup="profile" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                        <asp:Panel ID="pnlRequiredProfileProperties" runat="server">
                        </asp:Panel>
                        <div class="modulebuttonrow">
                            <asp:Button ID="btnCreateUser" runat="server" Text="Register" />
                        </div>
                        <div>
                            <asp:Literal ID="litInfoNeededMessage" runat="server" />
                        </div>
                    </asp:Panel>
                </asp:Panel>
                <div class="clearpanel">
                    <asp:Label ID="lblError" runat="server" CssClass="txterror" />
                </div>
            </fieldset>
        </div>
    </asp:Panel>
    <gb:CornerRounderBottom ID="cbottom1" runat="server" />
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
