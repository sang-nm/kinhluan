<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="CommentDialog.aspx.cs" Inherits="CanhCam.Web.NewsUI.CommentDialog" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <portal:CommentEditor ID="commentEditor" runat="server" />
</asp:Content>
