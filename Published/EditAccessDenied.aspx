<%@ Page CodeBehind="EditAccessDenied.aspx.cs" Language="c#" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.UI.Pages.EditAccessDenied" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <div class="errorPage">        
        <p class="name">401</p>
        <p class="description">
            <gb:SiteLabel ID="lblEditAccessDeniedLabel" runat="server" UseLabelTag="false" ConfigKey="EditAccessDeniedLabel" />
        </p>
        <p>
            <asp:HyperLink ID="lnkHome" CssClass="btn btn-warning" runat="server" />
        </p>        
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
