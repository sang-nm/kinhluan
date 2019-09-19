<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="EditSiteLogo.aspx.cs" Inherits="CanhCam.Web.AdminUI.EditSiteLogoPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, SiteSettingsSiteLogoLabel %>" CurrentPageUrl="~/AdminCP/EditSiteLogo.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="up" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnSave" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                        EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                        CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                    <gbe:EditorControl ID="editor" runat="server"></gbe:EditorControl>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
