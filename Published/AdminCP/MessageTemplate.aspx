<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="MessageTemplate.aspx.cs" Inherits="CanhCam.Web.AdminUI.MessageTemplatePage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" >
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, MessageTemplateLink %>" CurrentPageUrl="~/AdminCP/MessageTemplate.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>"
                        runat="server" ValidationGroup="messagetemplate" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" Visible="false" Text="<%$Resources:Resource, MessageTemplateDeleteButton %>"
                        runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <div class="row">
                        <div class="col-sm-4">
                            <asp:ListBox ID="lbTemplates" Width="100%" Height="567" AutoPostBack="true" runat="server"
                                AppendDataBoundItems="true" DataTextField="Name" DataValueField="SystemCode" />
                        </div>
                        <div class="col-sm-8">
                            <div class="form-horizontal">
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblSystemCode" runat="server" ForControl="txtSystemCode" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="MessageTemplateSystemCodeLabel" ShowRequired="true" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtSystemCode" runat="server" />
                                        <asp:RequiredFieldValidator ID="reqSystemCode" runat="server" Display="Dynamic" ControlToValidate="txtSystemCode"
                                            ValidationGroup="messagetemplate" SetFocusOnError="true" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="MessageTemplateNameLabel" ShowRequired="true" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtName" runat="server" />
                                        <asp:RequiredFieldValidator ID="reqName" runat="server" Display="Dynamic" ControlToValidate="txtName"
                                            ValidationGroup="messagetemplate" SetFocusOnError="true" />
                                    </div>
                                </div>
                                <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                                    EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                    CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblContent" runat="server" ForControl="edContentText" CssClass="settinglabel control-label"
                                        ConfigKey="MessageTemplateContentLabel" />
                                    <gbe:EditorControl id="edContentText" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" 
    runat="server" >
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" 
    runat="server" >
</asp:Content>

