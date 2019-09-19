<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="NewsViewControl.ascx.cs"
    Inherits="CanhCam.Web.NewsUI.NewsViewControl" %>

<%@ Register TagPrefix="Site" TagName="Comment" Src="~/News/Controls/CommentControl.ascx" %>
<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.News" Namespace="CanhCam.Web.NewsUI" %>
<portal:ContentExpiredLabel ID="expired" runat="server" EnableViewState="false" Visible="false" />
<asp:Panel ID="pnlInnerWrap" runat="server">
    <Site:NewsDisplaySettings ID="displaySettings" runat="server" />
    <asp:Panel ID="pnlWorkflow" CssClass="workflow-action" runat="server" Visible="false">
        <asp:ImageButton ID="ibApproveContent" OnCommand="ibApproveContent_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleApproveContentLink" Visible="false" runat="server" />
        <asp:HyperLink ID="lnkRejectContent" Visible="false" runat="server" />
        <asp:Image ID="statusIcon" Visible="false" runat="server" />
    </asp:Panel>
    <asp:Xml ID="xmlTransformer" runat="server"></asp:Xml>
    <div id="divPager" runat="server" class="pages newsdetailpager">
        <portal:gbCutePager ID="pgr" runat="server" />
    </div>
    <Site:Comment ID="comment" runat="server" />
</asp:Panel>