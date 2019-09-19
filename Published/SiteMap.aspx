<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master" MaintainScrollPositionOnPostback="true"
    CodeBehind="SiteMap.aspx.cs" Inherits="CanhCam.Web.UI.Pages.SiteMapPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:SiteMapDisplaySettings ID="displaySettings" runat="server" />
    <div class="sitemap">
        <div class="sitemap-heading">
            <portal:HeadingControl id="heading" runat="server" />
        </div>
        <portal:gbTreeView ID="menu" runat="server" SkinID="SiteMapPage" />
        <div class="clear"></div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
