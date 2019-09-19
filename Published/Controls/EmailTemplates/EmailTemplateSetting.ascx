<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EmailTemplateSetting.ascx.cs" Inherits="CanhCam.Web.UI.EmailTemplateSetting" %>

<asp:DropDownList ID="dd" runat="server" AppendDataBoundItems="true" DataValueField="SystemCode" DataTextField="Name">
</asp:DropDownList>
<asp:HyperLink ID="lnkNotificationTemplate" CssClass="cp-link" runat="server" />