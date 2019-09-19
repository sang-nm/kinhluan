<%@ Page Language="c#" CodeBehind="Compare.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.ProductUI.CompareProductsPage" %>

<%@ Register TagPrefix="Site" TagName="CompareProduct" Src="~/Product/Controls/ProductCompareControl.ascx" %>
<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Product" Namespace="CanhCam.Web.ProductUI" %>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:ProductDisplaySettings ID="displaySettings" runat="server" />
    <Site:CompareProduct ID="CompareProduct1" XSLTFile="Detail" runat="server" />
</asp:Content>