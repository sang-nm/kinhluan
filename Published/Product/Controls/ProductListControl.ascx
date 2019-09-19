<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ProductListControl.ascx.cs" Inherits="CanhCam.Web.ProductUI.ProductListControl" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Product" Namespace="CanhCam.Web.ProductUI" %>
<Site:ProductDisplaySettings ID="displaySettings" runat="server" />
<asp:Xml ID="xmlTransformer" runat="server"></asp:Xml>
<div id="divPager" runat="server" class="pages productpager">
    <portal:gbCutePager ID="pgr" runat="server" />
</div>