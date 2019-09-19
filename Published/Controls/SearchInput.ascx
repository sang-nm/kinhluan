<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="SearchInput.ascx.cs" Inherits="CanhCam.Web.UI.SearchInput" %>

<portal:BasePanel ID="pnlSearch" runat="server" DefaultButton="btnSearch" CssClass="searchbox">
    <gb:WatermarkTextBox ID="txtSearch" runat="server" />
    <asp:Literal ID="litSeparator" runat="server" EnableViewState="false" />
    <button id="btnSearch" runat="server" class="searchbutton" onserverclick="btnSearch_Click" causesvalidation="false">
        <asp:Literal ID="litSearch" EnableViewState="false" runat="server" />
    </button>
</portal:BasePanel>