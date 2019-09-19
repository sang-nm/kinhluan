<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="FAQsModule.ascx.cs" Inherits="CanhCam.Web.FAQsUI.FAQsModule" %>

<asp:Xml ID="xmlTransformer" runat="server"></asp:Xml>
<div id="divPager" runat="server" class="pages">
    <portal:gbCutePager ID="pgr" runat="server" />
</div>