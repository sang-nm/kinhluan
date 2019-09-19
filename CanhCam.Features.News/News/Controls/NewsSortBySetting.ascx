<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewsSortBySetting.ascx.cs" Inherits="CanhCam.Web.UI.NewsSortBySetting" %>

<asp:DropDownList ID="ddSortBy" runat="server" DataValueField="Value" DataTextField="Name">
    <asp:ListItem Value="" Text=""></asp:ListItem>
    <asp:ListItem Value="5" Text="<%$Resources:NewsResources, NewsSortByMostViewed %>"></asp:ListItem>
    <asp:ListItem Value="15" Text="<%$Resources:NewsResources, NewsSortByCreatedOn %>"></asp:ListItem>
    <asp:ListItem Value="10" Text="<%$Resources:NewsResources, NewsSortByRandom %>"></asp:ListItem>
</asp:DropDownList>