<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ProductCompareControl.ascx.cs" Inherits="CanhCam.Web.ProductUI.ProductCompareControl" %>

<div class="compare-products">
    <div class="page-title">
        <asp:Literal ID="litProductCompareTitle" Text="<%$Resources:ProductResources, ProductCompareTitle %>" runat="server" />
    </div>
    <div class="clear">
    </div>
    <div class="body-wrap">
        <asp:LinkButton ID="btnClearCompareProductsList" CssClass="clear-list" OnClick="btnClearCompareProductsList_Click"
            runat="server" Text="<%$Resources:ProductResources, ProductCompareClearList %>" />
        <table cellpadding="0" cellspacing="0" border="0" id="tblCompareProducts" runat="server"
            class="compare-products-table">
        </table>
        <div class="back-link">
            <asp:LinkButton ID="btnBack" CssClass="clear-list" OnClick="btnBack_Click"
                runat="server" Text="<%$Resources:ProductResources, ProductCompareBackButton %>" />
            <asp:HiddenField ID="hdnReturnUrl" runat="server" />
        </div>
    </div>
</div>