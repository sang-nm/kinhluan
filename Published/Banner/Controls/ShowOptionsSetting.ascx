<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShowOptionsSetting.ascx.cs" Inherits="CanhCam.Web.BannerUI.ShowOptionsSetting" %>

<asp:RadioButtonList ID="rdbListOptions" runat="server">
    <asp:ListItem Text="<%$Resources:BannerResources, ShowOptionsByZone %>" Value="0" />
    <asp:ListItem Text="<%$Resources:BannerResources, ShowOptionsByPosition %>" Value="1" />
    <asp:ListItem Text="<%$Resources:BannerResources, ShowOptionsBoth %>" Value="2" />
</asp:RadioButtonList>