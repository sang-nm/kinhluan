<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="OrderDetailToolTipControl.ascx.cs"
    Inherits="CanhCam.Web.ProductUI.OrderDetailToolTipControl" %>
<table cellspacing="0" cellpadding="0" class="OrderPopup">
    <tbody>
        <tr>
            <td class="QuickViewPanel BillingDetails">
                <h5><gb:SiteLabel ID="lblBillingInfo" runat="server" ConfigKey="OrderBillingInfo" ResourceFile="ProductResources" UseLabelTag="false" /></h5>
                <table cellspacing="0" cellpadding="0" style="width: 100%;">
                    <tbody>
                        <tr>
                            <td class="Key">
                                <gb:SiteLabel ID="lblCustomerInfo" runat="server" ConfigKey="OrderCustomerInfo" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Value">
                                <asp:Literal ID="litCustomerInfo" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Key">
                                <gb:SiteLabel ID="lblBillingEmail" runat="server" ConfigKey="OrderEmailLabel" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Value">
                                <asp:Literal ID="litBillingEmail" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Key">
                                <gb:SiteLabel ID="lblBillingPhone" runat="server" ConfigKey="OrderPhoneLabel" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Value">
                                <asp:Literal ID="litBillingPhone" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Key">
                                <gb:SiteLabel ID="lblCreatedOn" runat="server" ConfigKey="OrderCreatedOnLabel" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Value">
                                <asp:Literal ID="litCreatedOn" runat="server" />
                            </td>
                        </tr>
                        <tr class="hidden">
                            <td class="Key">
                                <gb:SiteLabel ID="lblPaymentMethod" runat="server" ConfigKey="OrderPaymentMethodLabel" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Value">
                                <asp:Literal ID="litPaymentMethod" runat="server" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
            <td class="Seperator">
            </td>
            <td id="tdShippingDetails" runat="server" class="QuickViewPanel ShippingDetails">
                <h5><gb:SiteLabel ID="lblShippingInfo" runat="server" ConfigKey="OrderShippingInfo" ResourceFile="ProductResources" UseLabelTag="false" /></h5>
                <table cellspacing="0" cellpadding="0" style="width: 100%;">
                    <tbody>
                        <tr>
                            <td class="Key">
                                <gb:SiteLabel ID="lblConsigneeInfo" runat="server" ConfigKey="OrderConsigneeInfo" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Value">
                                <asp:Literal ID="litConsigneeInfo" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Key">
                                <gb:SiteLabel ID="lblShippingEmail" runat="server" ConfigKey="OrderEmailLabel" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Value">
                                <asp:Literal ID="litShippingEmail" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Key">
                                <gb:SiteLabel ID="lblShippingPhone" runat="server" ConfigKey="OrderPhoneLabel" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Value">
                                <asp:Literal ID="litShippingPhone" runat="server" />
                            </td>
                        </tr>
                        <tr class="hidden">
                            <td class="Key">
                                <gb:SiteLabel ID="lblShippingMethod" runat="server" ConfigKey="OrderShippingMethodLabel" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Value">
                                <asp:Literal ID="litShippingMethod" runat="server" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
            <td class="Seperator">
            </td>
            <td class="QuickViewPanel OrderProducts">
                <table style="width: 100%; border-collapse: collapse;">
                    <tbody>
                        <asp:Repeater ID="rptOrderItems" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td style="width: 5px;">
                                        <%# Container.ItemIndex + 1 %>.
                                    </td>
                                    <td>
                                        <asp:Literal ID="litProduct" runat="server" />
                                    </td>
                                    <td>
                                        <%# Convert.ToDecimal(Eval("Quantity")) %>
                                    </td>
                                    <td style="width: 100px; text-align: right;">
                                        <asp:Literal ID="litSubTitle" Visible="false" runat="server" />
                                        <%#CanhCam.Web.ProductUI.ProductHelper.FormatPrice(Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))) %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                <div class="Seperator hidden"></div>
                <table visible="false" runat="server" class="hidden" cellspacing="0" cellpadding="0" style="width: 100%">
                    <tbody>
                        <tr>
                            <td class="Key">
                                <gb:SiteLabel ID="lblSubTotal" runat="server" ConfigKey="OrderSubTotalLabel" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Price">
                                <asp:Literal ID="litSubTotal" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Key">
                                <gb:SiteLabel ID="lblShippingFee" runat="server" ConfigKey="OrderShippingFeeLabel" ResourceFile="ProductResources" UseLabelTag="false" />:
                            </td>
                            <td class="Value">
                                <asp:Literal ID="litShippingFee" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Key">
                                <strong><gb:SiteLabel ID="lblOrderTotal" runat="server" ConfigKey="OrderTotalLabel" ResourceFile="ProductResources" UseLabelTag="false" />:</strong>
                            </td>
                            <td class="Price">
                                <strong>
                                    <asp:Literal ID="litOrderTotal" runat="server" />
                                </strong>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table>