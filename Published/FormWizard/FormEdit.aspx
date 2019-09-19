<%@ Page ValidateRequest="false" Language="c#" CodeBehind="FormEdit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.FormWizard.Web.UI.FormEditPage" %>

<%@ Register TagPrefix="Site" TagName="WebFormControl" Src="~/FormWizard/Controls/WebFormControl.ascx" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:WebFormControl ID="webForm" runat="server" />
    <portal:SessionKeepAliveControl ID="ka1" runat="server" />
</asp:Content>