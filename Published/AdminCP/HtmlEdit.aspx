<%@ Page Language="c#" CodeBehind="HtmlEdit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.ContentUI.EditHtml" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, EditHtmlSettingsLabel %>" CurrentPageUrl="~/AdminCP/HtmlEdit.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="up" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" runat="server" Text="" />
                    <asp:HyperLink SkinID="CancelButton" ID="lnkCancel" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />                
                <div class="workplace">
                    <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                        EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                        CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                    <gbe:EditorControl ID="edContent" runat="server" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:HiddenField ID="hdnReturnUrl" runat="server" />
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server">
</asp:Content>