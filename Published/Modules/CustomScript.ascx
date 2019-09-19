<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomScript.ascx.cs" Inherits="CanhCam.Web.UI.CustomScriptModule" %>

<portal:BasePanel ID="pnlOuterWrap" Visible="false" runat="server">
    <asp:Literal ID="litScriptUrl" runat="server" EnableViewState="false" />
    <asp:Literal ID="litScript" runat="server" EnableViewState="false" />
</portal:BasePanel>