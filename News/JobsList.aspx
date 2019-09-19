<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="JobsList.aspx.cs" Inherits="CanhCam.Web.NewsUI.JobsListPage" %>

<%@ Register TagPrefix="uc" TagName="NewsManageControl" Src="~/News/Controls/NewsManageControl.ascx" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <uc:NewsManageControl ID="newsManage" runat="server"
        PageTitle="<%$Resources:NewsResources, NewsList %>" PageHeading="<%$Resources:NewsResources, NewsList %>"
        NewsType="2" />
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />