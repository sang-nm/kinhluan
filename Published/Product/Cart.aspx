<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    Codebehind="Cart.aspx.cs" Inherits="CanhCam.Web.ProductUI.CartPage" %>

<%@ Register TagPrefix="Site" TagName="CartList" Src="~/Product/Controls/CartListControl.ascx" %>
<%@ Register TagPrefix="Site" TagName="Checkout" Src="~/Product/Controls/CheckoutControl.ascx" %>
<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Product" Namespace="CanhCam.Web.ProductUI" %>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:ProductDisplaySettings ID="displaySettings" runat="server" />
    <div class="cart mrt20 mrb20">
        <div class="container">
            <div class="clearfix cart-wrap">
                <div class="col-sm-8 cart-list">
                    <Site:CartList ID="cartList" runat="server" />
                </div>
                <div class="col-sm-4 cart-info cc-contact-basic">
                    <Site:Checkout ID="checkout" runat="server" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>