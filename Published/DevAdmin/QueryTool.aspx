<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="QueryTool.aspx.cs" Inherits="CanhCam.Web.AdminUI.QueryToolPage" %>

<%@ Register TagPrefix="dev" TagName="QueryTool" Src="~/DevAdmin/Controls/QueryTool.ascx" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:DevTools, QueryToolLink %>" CurrentPageUrl="~/DevAdmin/QueryTool.aspx"
        ParentTitle="<%$Resources:DevTools, DevToolsHeading %>" ParentUrl="~/DevAdmin/Default.aspx"
        RootTitle="<%$Resources:Resource, AdvancedToolsLink %>" RootUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="workplace">
            <dev:QueryTool id="qt1" runat="server" />
            <portal:Woopra ID="woopra11" runat="server" />
        </div>
    </div>
</asp:Content>