<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="PagePermissionsMenu.aspx.cs" Inherits="CanhCam.Web.AdminUI.PagePermissionsMenuPage" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
    <ul class="simplelist">
        <li>
            <asp:HyperLink ID="lnkPageViewRoles" runat="server" CssClass="lnkPageViewRoles" />
        </li>
        <li>
            <asp:HyperLink ID="lnkPageEditRoles" runat="server" CssClass="lnkPageEditRoles" />
        </li>
        <li>
            <asp:HyperLink ID="lnkPageDraftRoles" runat="server" CssClass="lnkPageDraftRoles" />
        </li>
        <li>
            <asp:HyperLink ID="lnkChildPageRoles" runat="server" CssClass="lnkChildPageRoles" />
        </li>
    </ul>
</asp:Content>