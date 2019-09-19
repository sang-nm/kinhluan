<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="Gallery.ascx.cs" Inherits="CanhCam.Web.GalleryUI.GalleryControl" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.ImageGallery" Namespace="CanhCam.Web.GalleryUI" %>
<Site:GalleryDisplaySettings ID="displaySettings" runat="server" />
<asp:Xml ID="xmlTransformer" runat="server"></asp:Xml>
<div id="divPager" visible="false" runat="server" class="pages">
    <portal:gbCutePager ID="pgr" runat="server" />
</div>