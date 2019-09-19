<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="JobApply.aspx.cs" Inherits="CanhCam.Web.NewsUI.JobApply" %>

<%@ Register TagPrefix="Site" TagName="JobApply" Src="~/News/Controls/JobApplyControl.ascx" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <Site:JobApply ID="jobApply" runat="server" />
</asp:Content>