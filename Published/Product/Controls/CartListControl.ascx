<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="CartListControl.ascx.cs" Inherits="CanhCam.Web.ProductUI.CartListControl" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Product" Namespace="CanhCam.Web.ProductUI" %>
<Site:CartDisplaySettings ID="displaySettings" runat="server" />

<h2 class="cart-title">
    <asp:Literal ID="litShoppingCart" Visible="false" runat="server" />
    Thông tin đơn hàng
</h2>
<asp:UpdatePanel ID="up" runat="server">
    <ContentTemplate>
        <asp:Panel ID="pnlEmptyCart" CssClass="cart-empty" Visible="false" runat="server">
            <asp:Literal ID="litEmptyCart" runat="server" />
        </asp:Panel>
        <asp:Panel ID="pnlShoppingCart" runat="server">
            <asp:Repeater ID="rptCartItems" runat="server">
                <HeaderTemplate>
                    <table class="table">
                        <tr>
                            <th class="col1">
                                <asp:Literal ID="litProductHeading" runat="server" Text="<%$Resources:ProductResources, CartProductHeading %>" />
                            </th>
                            <th class="col2">
                                <asp:Literal ID="litCartPriceHeading" runat="server" Text="<%$Resources:ProductResources, CartPriceHeading %>" />
                            </th>
                            <th class="col3">
                                <asp:Literal ID="litQuantityHeading" runat="server" Text="<%$Resources:ProductResources, CartQuantityHeading %>" />
                            </th>
                            <th class="col4">
                                Thành tiền
                            </th>
                            <th class="col5">
                                <asp:Literal ID="litRemoveHeading" runat="server" Text="<%$Resources:ProductResources, CartRemoveHeading %>" />
                            </th>
                        </tr>
                </HeaderTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
                <ItemTemplate>
                    <tr>
                        <td class="col1">
                            <p>
                                <asp:Literal ID="litProductImage" runat="server" />
                            </p>
                            <p>
                                <asp:Literal ID="litProduct" runat="server" />
                            </p>
                        </td>
                        <td class="col2"><asp:Literal ID="litPrice" runat="server" /></td>
                        <td class="col3">
                            <asp:TextBox ID="txtQuantity" Visible="false" MaxLength="2" runat="server"
                                Text='<%# Eval("Quantity") %>' />
                            <telerik:RadNumericTextBox ID="nxtQuantity" Visible="false" AutoPostBack="true" Text='<%# Eval("Quantity") %>'
                                MinValue="0" NumberFormat-DecimalDigits="0" Type="Number" ShowSpinButtons="true"
                                MaxLength="20" EnabledStyle-HorizontalAlign="Center" Width="65" runat="server" />
                            <asp:DropDownList ID="ddQuantity" runat="server" />
                        </td>
                        <td class="col4">
                            
                        </td>
                        <td class="col5">
                            <asp:HiddenField ID="hdfItemGuid" Value='<%# Eval("Guid") %>' runat="server" />
                            <asp:HiddenField ID="hdfAttributesXml" Value='<%# Eval("AttributesXml") %>' runat="server" />
                            <asp:CheckBox ID="chkRemove" runat="server" />
                            <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Visible="false" CommandArgument='<%# Eval("ProductId") %>' CommandName="Delete" />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
            <div class="clearfix text-right sum-cart">
                <div id="divHidden" runat="server" visible="false">
                    <asp:LinkButton ID="btnContinueBack" runat="server" Text="<%$Resources:StoreResources, CartContinueBack %>" />
                    <asp:LinkButton ID="btnContinueNext" runat="server" Text="<%$Resources:StoreResources, CartContinueNext %>" />
                    <asp:Literal ID="litTotalLabel" runat="server" Text="<%$Resources:StoreResources, CartSubTotalHeading %>" />: 
                    <asp:Literal ID="litTotal" runat="server" />
                </div>
                <h4>
                    <asp:Literal ID="litSubTotalLabel" runat="server" Text="<%$Resources:StoreResources, CartTotalLabel %>" />: 
                    <asp:Literal ID="litSubTotal" runat="server" />
                </h4>
                <asp:Button ID="btnUpdateCart" CssClass="btn-cart" OnClick="btnUpdateCart_Click" Text="Cập nhật đơn hàng" runat="server" />
            </div>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>