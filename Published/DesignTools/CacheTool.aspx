<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="CacheTool.aspx.cs" Inherits="CanhCam.Web.AdminUI.CacheToolPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:DevTools, CacheTool %>" CurrentPageUrl="~/DesignTools/CacheTool.aspx"
        ParentTitle="<%$Resources:DevTools, DesignTools %>" ParentUrl="~/DesignTools/Default.aspx"
        RootTitle="<%$Resources:Resource, AdvancedToolsLink %>" RootUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="workplace">
            <asp:Button SkinID="DefaultButton" ID="btnCssCacheToggle" runat="server" />
            <div class="mrt10 mrb20">
                <gb:SiteLabel ID="lblCacheInfo" runat="server" CssClass="cssinfo" ConfigKey="CssCacheInfo"
                    ResourceFile="Resource" UseLabelTag="false" />
            </div>
            <asp:Button SkinID="DefaultButton" ID="btnResetSkinVersionGuid" runat="server" />
            <asp:Label ID="lblSkinGuid" runat="server" CssClass="skinguid" />
            <div class="mrt10">
                <gb:SiteLabel ID="SiteLabel1" runat="server" CssClass="cssinfo" ConfigKey="SkinVersionGuidInfo"
                    ResourceFile="Resource" UseLabelTag="false" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
