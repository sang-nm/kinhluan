<%@ Control Language="c#" AutoEventWireup="False" CodeBehind="BreadcrumbsControl.ascx.cs" Inherits="CanhCam.Web.UI.BreadcrumbsControl" %>
<portal:BasePanel ID="pnlWrapper" runat="server" EnableViewState="false">
    <portal:SiteMapPath ID="breadCrumbsControl" runat="server" Visible="false" EnableViewState="false">
        <RootNodeTemplate>
            <asp:Literal ID="litRootNode" EnableViewState="false" runat="server" />
        </RootNodeTemplate>
        <NodeTemplate>
            <asp:Literal ID="litNode" EnableViewState="false" runat="server" />
        </NodeTemplate>
        <CurrentNodeTemplate>
            <asp:Literal ID="litCurrentNode" EnableViewState="false" runat="server" />
        </CurrentNodeTemplate>
    </portal:SiteMapPath>
    <asp:Literal ID="childCrumbs" runat="server" EnableViewState="false" />
</portal:BasePanel>