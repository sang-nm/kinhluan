<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="NewsListControl.ascx.cs" Inherits="CanhCam.Web.NewsUI.NewsListControl" %>
<asp:Xml ID="xmlTransformer" runat="server"></asp:Xml>
<div id="divPager" runat="server" class="pages newspager">
    <portal:gbCutePager ID="pgr" runat="server" />
</div>