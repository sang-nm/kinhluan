<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="FileManagerDialog.aspx.cs"
     MasterPageFile="~/App_MasterPages/DialogMaster.Master" Inherits="CanhCam.Web.Dialog.FileManagerDialog" %>

<%@ Register TagPrefix="admin" TagName="AdvFileManager" Src="~/AdminCP/Controls/AdvFileManager.ascx" %>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="mrb10">
        <asp:HyperLink ID="lnkAltFileManager" runat="server" NavigateUrl="FileManagerAltDialog.aspx" />
    </div>
    <div style="width:99%">
        <admin:AdvFileManager ID="fm2" runat="server" />
    </div>
</asp:Content>