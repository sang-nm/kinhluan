<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ProductViewControl.ascx.cs"
    Inherits="CanhCam.Web.ProductUI.ProductViewControl" %>

<%@ Register TagPrefix="Site" TagName="Comment" Src="~/Product/Controls/CommentControl.ascx" %>
<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Product" Namespace="CanhCam.Web.ProductUI" %>
<portal:ContentExpiredLabel ID="expired" runat="server" EnableViewState="false" Visible="false" />
<asp:Panel ID="pnlInnerWrap" runat="server">
    <Site:ProductDisplaySettings ID="displaySettings" runat="server" />
    <asp:Xml ID="xmlTransformer" runat="server"></asp:Xml>
    <div id="divPager" runat="server" class="pages productdetailpager">
        <portal:gbCutePager ID="pgr" runat="server" />
    </div>
    <Site:Comment ID="comment" runat="server" />
</asp:Panel>