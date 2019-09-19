<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    Codebehind="CheckoutCompleted.aspx.cs" Inherits="CanhCam.Web.ProductUI.CheckoutCompletedPage" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Product" Namespace="CanhCam.Web.ProductUI" %>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:ProductDisplaySettings ID="displaySettings" runat="server" />
    <div class="cart mrt20 mrb20">
        <div class="container">
            <div class="row">
                <div class="clearfix cart-wrap">
                    <div class="col-sm-12">
                        <asp:Literal ID="litThankYouMessage" runat="server" />
                        <div class="order-processed mrt20">
                            <asp:HyperLink ID="hplBackHomepage" Text="Về trang chủ" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>