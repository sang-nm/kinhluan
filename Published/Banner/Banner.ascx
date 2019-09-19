<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="Banner.ascx.cs" Inherits="CanhCam.Web.BannerUI.BannerControl" %>
<asp:Xml ID="xmlTransformer" runat="server"></asp:Xml>
<div id="divPager" visible="false" runat="server" class="pages">
    <portal:gbCutePager ID="pgr" runat="server" />
</div>