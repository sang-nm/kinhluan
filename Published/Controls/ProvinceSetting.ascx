<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ProvinceSetting.ascx.cs" Inherits="CanhCam.Web.UI.ProvinceSetting" %>

<asp:DropDownList ID="ddProvince" runat="server" AppendDataBoundItems="true" 
            DataValueField="Guid" DataTextField="Name" EnableTheming="false">
    <asp:ListItem Value="" Text=""></asp:ListItem>
</asp:DropDownList>