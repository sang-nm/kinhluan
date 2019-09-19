<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="ParentZoneDialog.aspx.cs" Inherits="CanhCam.Web.UI.ParentZoneDialog" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server">
    <asp:Literal ID="litStyleLink" runat="server" />
</asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <asp:SiteMapDataSource ID="SiteMapData" runat="server" ShowStartingNode="false" />
    <div style="padding: 5px 5px 5px 5px;" class="parentzonedialog">
        <div class="settingrow">
            <asp:HyperLink ID="lnkRoot" runat="server" Visible="false" CssClass="rootlink" />
        </div>
        <portal:gbTreeView ID="tree" runat="server" SkinID="ParentZoneDialog" ContainerCssClass="treecontainer"
            RenderLiCssClasses="true" RenderAnchorCss="false" LiCssClass="leaf" LiRootExpandableCssClass="root"
            LiRootNonExpandableCssClass="root leaf" LiNonRootExpnadableCssClass="parent"
            LiSelectedCssClass="selected" LiChildSelectedCssClass="childselected" LiParentSelectedCssClass="parentselected"
            AnchorCssClass="inactive" AnchorSelectedCssClass="current" />
    </div>
</asp:Content>