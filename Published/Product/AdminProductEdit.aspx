<%@ Page ValidateRequest="false" Language="c#" CodeBehind="AdminProductEdit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.ProductUI.AdminProductEditPage" %>

<%@ Register TagPrefix="Site" TagName="AdminProductEdit" Src="~/Product/Controls/AdminProductEditControl.ascx" %>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:AdminProductEdit ID="adminProductEdit" runat="server" 
        ProductType="0" EditPageUrl="/Product/AdminProductEdit.aspx" ListPageUrl="/Product/AdminProduct.aspx"
        />
</asp:Content>