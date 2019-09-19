<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="GoogleMapDialog.aspx.cs" Inherits="CanhCam.Web.DealerUI.GoogleMapDialog" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <portal:LocationMap ID="gmap" runat="server" EnableMapType="true" EnableZoom="true" ShowInfoWindow="true" EnableLocalSearch="false"></portal:LocationMap>
</asp:Content>