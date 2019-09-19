<%@ Page Language="C#" MasterPageFile="~/App_MasterPages/layout.Master" AutoEventWireup="false"
    CodeBehind="ContentManagerPreview.aspx.cs" Inherits="CanhCam.Web.AdminUI.ContentManagerPreview"
    Title="Untitled Page" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, AdminMenuContentManagerLink %>" CurrentPageUrl="~/AdminCP/ContentCatalog.aspx" />
    <asp:Panel ID="pnlPreview" runat="server" CssClass="admin-content col-md-12 contentmanagerpreview">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:HyperLink SkinID="DefaultButton" ID="lnkPublish" EnableViewState="false" runat="server" />
            <asp:HyperLink SkinID="LinkButton" ID="lnkBackToList" runat="server" Visible="false" />
        </portal:HeadingPanel>
        <div class="workplace">
            <asp:Panel ID="pnlWarning" runat="server" Visible="false">
                <gb:SiteLabel ID="lblWarning" runat="server" CssClass="txterror warning" ConfigKey="ContentManagerNonMultiPageFeatureWarning"
                    UseLabelTag="false" />
            </asp:Panel>
            <asp:Panel ID="pnlViewModule" runat="server"></asp:Panel>
        </div>
        <div class="clearfix"></div>
    </asp:Panel>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
