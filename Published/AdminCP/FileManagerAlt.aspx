<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" AutoEventWireup="false"
    MasterPageFile="~/App_MasterPages/layout.Master" CodeBehind="FileManagerAlt.aspx.cs"
    Inherits="CanhCam.Web.AdminUI.FileManagerAlt" %>

<%@ Register TagPrefix="admin" TagName="FileManager" Src="~/AdminCP/Controls/FileManager.ascx" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, AdminMenuFileManagerLink %>" CurrentPageUrl="~/AdminCP/FileManagerAlt.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:HyperLink SkinID="LinkButton" ID="lnkTreeView" Text="<%$Resources:Resource, TreeViewToggleLink %>" runat="server" />
        </portal:HeadingPanel>
        <div class="workplace">
            <admin:FileManager ID="fm1" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server">
</asp:Content>