<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductSortBySetting.ascx.cs" Inherits="CanhCam.Web.ProductUI.ProductSortBySetting" %>

<asp:DropDownList ID="ddSortBy" runat="server" DataValueField="Value" DataTextField="Name">
    <asp:ListItem Value="" Text=""></asp:ListItem>
    <%--<asp:ListItem Value="5" Text="<%$Resources:ProductResources, ProductSortByMostViewed %>"></asp:ListItem>
    <asp:ListItem Value="15" Text="<%$Resources:ProductResources, ProductSortByCreatedOn %>"></asp:ListItem>
    <asp:ListItem Value="20" Text="<%$Resources:ProductResources, ProductSortByRandom %>"></asp:ListItem>--%>
</asp:DropDownList>