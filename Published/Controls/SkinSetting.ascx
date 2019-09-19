<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SkinSetting.ascx.cs" Inherits="CanhCam.Web.UI.SkinSetting" %>

<asp:DropDownList ID="dd" runat="server" DataValueField="Name" DataTextField="Name" EnableTheming="false" CssClass="form-control skinsetting"></asp:DropDownList>
<div class="input-group-addon">
    <i class="fa fa-search"></i>
    <asp:HyperLink id="lnkPreview" runat="server" CssClass="cp-link" />
</div>
<asp:Literal id="litHiddenPreviewLinks" runat="server" />