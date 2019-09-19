<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="AdvFileManager.ascx.cs"
    Inherits="CanhCam.Web.AdminUI.AdvFileManager" %>
<portal:gbLabel ID="lblDisabledMessage" runat="server" />
<div id="divFile" runat="server">
    <telerik:RadFileExplorer runat="server" Skin="Simple" Width="100%" ID="rfeFileExplorer">
        <Configuration EnableAsyncUpload="true"></Configuration>
    </telerik:RadFileExplorer>
</div>
