<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ServerVariables.aspx.cs" Inherits="CanhCam.Web.AdminUI.ServerVariablesPage" %>

<%@ Register TagPrefix="dev" TagName="ServerVars" Src="~/DevAdmin/Controls/ServerVars.ascx" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:DevTools, ServerVariablesLink %>" CurrentPageUrl="~/DevAdmin/ServerVariables.aspx"
        ParentTitle="<%$Resources:DevTools, DevToolsHeading %>" ParentUrl="~/DevAdmin/Default.aspx"
        RootTitle="<%$Resources:Resource, AdvancedToolsLink %>" RootUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="workplace">
            <dev:ServerVars id="sv1" runat="server" />
            <portal:Woopra ID="woopra11" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
