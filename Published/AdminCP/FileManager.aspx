<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" AutoEventWireup="false"
    MasterPageFile="~/App_MasterPages/layout.Master" CodeBehind="FileManager.aspx.cs"
    Inherits="CanhCam.Web.AdminUI.FileManagerPage" %>

<%@ Register TagPrefix="admin" TagName="AdvFileManager" Src="~/AdminCP/Controls/AdvFileManager.ascx" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, AdminMenuFileManagerLink %>" CurrentPageUrl="~/AdminCP/FileManager.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:HyperLink SkinID="LinkButton" ID="lnkGridView" Text="<%$Resources:Resource, GridViewToggleLink %>" runat="server" />
        </portal:HeadingPanel>
        <div class="workplace">
            <admin:AdvFileManager ID="fm2" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
