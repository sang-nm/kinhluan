<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master" 
    CodeBehind="FileManagerAltDialog.aspx.cs" Inherits="CanhCam.Web.Dialog.FileManagerAltDialog" %>

<%@ Register TagPrefix="admin" TagName="FileManager" Src="~/AdminCP/Controls/FileManager.ascx" %>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="mrb10">
        <asp:HyperLink ID="lnkAltFileManager" runat="server" NavigateUrl="FileManagerDialog.aspx" />
    </div>
    <div style="width:98%">
        <admin:FileManager ID="fm1" runat="server" />
    </div>
</asp:Content>