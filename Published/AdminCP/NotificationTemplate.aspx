<%@ Page CodeBehind="NotificationTemplate.aspx.cs" MaintainScrollPositionOnPostback="true"
    Language="c#" MasterPageFile="~/App_MasterPages/layout.Master" AutoEventWireup="false"
    Inherits="CanhCam.Web.AdminUI.NotificationTemplatePage" EnableEventValidation="false" %>

<%@ Register TagPrefix="portal" TagName="PublishType" Src="~/Controls/PublishTypeSetting.ascx" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, EmailTemplateLink %>" CurrentPageUrl="~/AdminCP/NotificationTemplate.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>"
                        runat="server" ValidationGroup="EmailTemplate" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" Visible="false" Text="<%$Resources:Resource, MessageTemplateDeleteButton %>"
                        runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <div class="row">
                        <div class="col-md-4">
                            <asp:ListBox ID="lbTemplates" Width="100%" Height="905" AutoPostBack="true" runat="server"
                                AppendDataBoundItems="true" DataTextField="Name" DataValueField="SystemCode" />
                        </div>
                        <div class="col-md-8">
                            <div class="form-horizontal">
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblSystemCode" runat="server" ForControl="txtSystemCode" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="EmailTemplateSystemCode" ShowRequired="true" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtSystemCode" runat="server" MaxLength="128" CssClass="forminput"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqSystemCode" SetFocusOnError="true" runat="server" ControlToValidate="txtSystemCode"
                                            Display="Dynamic" ValidationGroup="EmailTemplate" />
                                        <%--<asp:RegularExpressionValidator ID="regexSystemCode" runat="server" ControlToValidate="txtSystemCode"
                                            ValidationExpression="^([\s]?[a-zA-Z]+[_\-a-zA-Z0-9]+)*\z+" Display="Dynamic" ValidationGroup="EmailTemplate" SetFocusOnError="true" />--%>
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="EmailTemplateName" ShowRequired="true" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtName" CssClass="form-control" MaxLength="255" runat="server" />
                                        <asp:RequiredFieldValidator ID="reqTitle" SetFocusOnError="true" runat="server" ControlToValidate="txtName"
                                            Display="Dynamic" ValidationGroup="EmailTemplate" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblFromName" runat="server" ForControl="txtFromName" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="EmailTemplateFromName" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtFromName" CssClass="form-control" MaxLength="255"
                                            runat="server" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblReplyToAddress" runat="server" ForControl="txtReplyToAddress"
                                        CssClass="settinglabel control-label col-sm-3" ConfigKey="EmailTemplateReplyToAddress" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtReplyToAddress" CssClass="form-control" MaxLength="255"
                                            runat="server" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblToAddresses" runat="server" ForControl="txtToAddresses" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="EmailTemplateToAddresses" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtToAddresses" CssClass="form-control" MaxLength="500"
                                            runat="server" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblCcAddresses" runat="server" ForControl="txtCcAddresses" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="EmailTemplateCcAddresses" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtCcAddresses" CssClass="form-control" MaxLength="500"
                                            runat="server" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblBccAddresses" runat="server" ForControl="txtBccAddresses" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="EmailTemplateBccAddresses" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtBccAddresses" CssClass="form-control" MaxLength="500"
                                            runat="server" />
                                    </div>
                                </div>
                                <asp:Panel ID="pnlTokens" runat="server">
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel3" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="SupportedTokens"
                                            ForControl="txtSupportedTokens" />
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="txtSupportedTokens" CssClass="form-control" Width="100%" MaxLength="1024" runat="server" />
                                            <portal:gbHelpLink ID="hlpTokens" runat="server" />
                                        </div>
                                    </div>
                                </asp:Panel>
                                <asp:UpdatePanel ID="up" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                                            EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                            CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                                        <div class="settingrow form-group">
                                            <gb:SiteLabel ID="lblSubject" runat="server" ForControl="txtSubject" CssClass="settinglabel control-label col-sm-3"
                                                ConfigKey="EmailTemplateSubject" />
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="txtSubject" CssClass="form-control" MaxLength="255"
                                                    runat="server" />
                                                <%--<asp:RequiredFieldValidator ID="reqSubject" runat="server" SetFocusOnError="true"
                                                    ControlToValidate="txtSubject" Display="Dynamic" ValidationGroup="EmailTemplate" />--%>
                                            </div>
                                        </div>
                                        <div class="settingrow form-group">
                                            <gb:SiteLabel ID="lblBody" runat="server" CssClass="settinglabel control-label"
                                                ConfigKey="EmailTemplateBody" />
                                            <div>
                                                <gbe:EditorControl ID="edTemplate" runat="server" />
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />