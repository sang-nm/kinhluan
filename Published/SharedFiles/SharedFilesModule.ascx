<%@ Control Language="c#" AutoEventWireup="true" CodeBehind="SharedFilesModule.ascx.cs"
    Inherits="CanhCam.Web.SharedFilesUI.SharedFilesModule" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.SharedFiles" Namespace="CanhCam.Web.SharedFilesUI" %>
<Site:SharedFilesDisplaySettings ID="displaySettings" runat="server" />
<asp:Xml ID="xmlTransformer" runat="server"></asp:Xml>
<div id="divPager" visible="false" runat="server" class="pages">
    <portal:gbCutePager ID="pgr" runat="server" />
</div>