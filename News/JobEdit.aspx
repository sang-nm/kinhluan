<%@ Page ValidateRequest="false" Language="c#" CodeBehind="JobEdit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.NewsUI.JobEditPage" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.News" Namespace="CanhCam.Web.NewsUI" %>
<%@ Register TagPrefix="uc" TagName="NewsEditControl" Src="~/News/Controls/NewsEditControl.ascx" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:JobsDisplaySettings ID="displaySettings" runat="server" />
    <uc:NewsEditControl ID="newsEdit" runat="server"
        PageTitle="<%$Resources:NewsResources, EditNewsPageTitle %>" PageHeading="<%$Resources:NewsResources, NewsEditHeading %>"
        NewsType="2" ShowAttribute="true" />
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />