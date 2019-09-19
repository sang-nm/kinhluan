<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="PageNotFound.aspx.cs" Inherits="CanhCam.Web.PageNotFoundPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <div class="errorPage">
        <p class="name">404</p>
        <p class="description">
            <asp:Literal ID="litTitle" runat="server" />
        </p>        
        <p>
            <asp:HyperLink ID="hplHomepage" CssClass="btn btn-warning" runat="server" />
            <asp:Literal ID="litErrorMessage" Visible="false" runat="server" EnableViewState="false" />
        </p>        
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />