<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="CheckoutConfirm.aspx.cs" Inherits="CanhCam.Web.StoreUI.CheckoutConfirmPage" %>

<%--<%@ Register TagPrefix="ws" TagName="Register" Src="~/Store/Controls/RegisterControl.ascx" %>--%>
<%@ Register TagPrefix="gb" TagName="Login" Src="~/Store/Controls/LoginControl.ascx" %>
<%@ Register TagPrefix="ws" TagName="CartList" Src="~/Store/Controls/CartListSummaryControl.ascx" %>
<%@ Register TagPrefix="Site" TagName="HtmlModule" Src="~/Modules/HtmlModule.ascx" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <div class="titlecart">
        <a class="active" href="/Store/Cart.aspx"><span class="active">1.</span> <asp:Literal ID="ltrStep1"  Text="<%$Resources:StoreResources, CartStep1 %>"  runat="server"></asp:Literal></a>
    </div>
    <div class="titlecart">
        <a class="active" href="/Store/Checkout.aspx"><span class="active">2 .</span><asp:Literal ID="Literal1"  Text="<%$Resources:StoreResources, CartStep2 %>"  runat="server"></asp:Literal></a>
    </div>
    <div class="titlecart">
        <a class="active" href="/Store/Checkout.aspx"><span class="active">3 .</span><asp:Literal ID="Literal2"  Text="<%$Resources:StoreResources, CartStep3 %>"  runat="server"></asp:Literal></a>
    </div>
    <div class="titlecart">
        <a class="active" href=""><span>4 .</span><asp:Literal ID="Literal3"  Text="<%$Resources:StoreResources, CartStep4 %>"  runat="server"></asp:Literal></a>
    </div>
    <div class="clear">
    </div>
    <asp:Panel ID="pnlRegister" CssClass="wra-dky" runat="server">
        <h1>
           <asp:Literal ID="Literal4"  Text="<%$Resources:StoreResources, CartStep4 %>"  runat="server"></asp:Literal>
        </h1>
       
        <div class="clear">
        </div>
        <div class="wrap-border">
            <div class="wrap-info-custommer confirm-cus">
                <div id="DivBiiling" runat="server">
                    <div class="title-info">
                        <asp:Literal ID="Literal1112"  Text="<%$Resources:StoreResources, CustomerInfo %>"  runat="server"></asp:Literal></div>
                    <div class="form-info">
                        <div class="form-left">
                            <label for="">
                                 <asp:Literal ID="Literal11"  Text="<%$Resources:StoreResources, FirstNameLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrFirstName" runat="server" /></strong>
                        </div>
                        <div class="form-right">
                            <label for="">
                                 <asp:Literal ID="Literal5"  Text="<%$Resources:StoreResources, LastNameLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrLastName" runat="server" /></strong>
                        </div>
                        <div class="clear">
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                <asp:Literal ID="Literal6"  Text="<%$Resources:StoreResources, EmailLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrEmail" runat="server" /></strong>
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                 <asp:Literal ID="Literal7"  Text="<%$Resources:StoreResources, PhoneLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrHomeNumber" runat="server" /></strong>
                        </div>
                        <div class="form-custommer" runat="server" visible="false">
                            <label for="">
                                 <asp:Literal ID="Literal8"  Text="<%$Resources:StoreResources, MobileLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrMobile" runat="server" /></strong>
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                 <asp:Literal ID="Literal9"  Text="<%$Resources:StoreResources, AddressLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrAddress" runat="server" /></strong>
                        </div>
                        <div class="clear">
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                 <asp:Literal ID="Literal10"  Text="<%$Resources:StoreResources, ProvinceLabel %>"  runat="server"></asp:Literal> :</label>
                            <div class="choose">
                                <strong>
                                    <asp:Literal ID="ltrProvince" runat="server"></asp:Literal></strong>
                            </div>
                        </div>
                        <div class="form-left">
                            <label for="">
                                <asp:Literal ID="Literal12"  Text="<%$Resources:StoreResources, DistrictLabel %>"  runat="server"></asp:Literal> :</label>
                            <div class="choose">
                                <strong>
                                    <asp:Literal ID="ltrDistrict" runat="server" /></strong>
                            </div>
                        </div>
                        <div class="form-right">
                            <label for="">
                                 <asp:Literal ID="Literal13"  Text="<%$Resources:StoreResources, WardLabel %>"  runat="server"></asp:Literal> :</label>
                            <div class="choose">
                                <strong>
                                    <asp:Literal ID="ltrWard" runat="server" /></strong>
                            </div>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                </div>
                <div id="divShipping" runat="server">
                    <div class="title-info">
                         <asp:Literal ID="Literal31"  Text="<%$Resources:StoreResources, ShippingAddressLabel %>"  runat="server"></asp:Literal></div>
                    <div class="form-info">
                        <div class="form-left">
                            <label for="">
                                 <asp:Literal ID="Literal21"  Text="<%$Resources:StoreResources, FirstNameLabel %>"  runat="server"></asp:Literal>  :</label>
                            <strong>
                                <asp:Literal ID="ltrFirstNameShipping" runat="server" /></strong>
                        </div>
                        <div class="form-right">
                            <label for="">
                                <asp:Literal ID="Literal22"  Text="<%$Resources:StoreResources, LastNameLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrLastNameShipping" runat="server" /></strong>
                        </div>
                        <div class="clear">
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                <asp:Literal ID="Literal14"  Text="<%$Resources:StoreResources, EmailLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrEmailShipping" runat="server" /></strong>
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                <asp:Literal ID="Literal15"  Text="<%$Resources:StoreResources, PhoneLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrHomeNumberShipping" runat="server" /></strong>
                        </div>
                        <div id="Div1" class="form-custommer" runat="server" visible="false">
                            <label for="">
                                <asp:Literal ID="Literal16"  Text="<%$Resources:StoreResources, MobileLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrMobileShipping" runat="server" /></strong>
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                <asp:Literal ID="Literal17"  Text="<%$Resources:StoreResources, AddressLabel %>"  runat="server"></asp:Literal> :</label>
                            <strong>
                                <asp:Literal ID="ltrAddressShipping" runat="server" /></strong>
                        </div>
                        <div class="clear">
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                <asp:Literal ID="Literal18"  Text="<%$Resources:StoreResources, ProvinceLabel %>"  runat="server"></asp:Literal> :</label>
                            <div class="choose">
                                <strong>
                                    <asp:Literal ID="ltrProvinceShipping" runat="server" /></strong>
                            </div>
                        </div>
                        <div class="form-left">
                            <label for="">
                                <asp:Literal ID="Literal19"  Text="<%$Resources:StoreResources, DistrictLabel %>"  runat="server"></asp:Literal> :</label>
                            <div class="choose">
                                <strong>
                                    <asp:Literal ID="ltrDistrictShipping" runat="server" /></strong>
                            </div>
                        </div>
                        <div class="form-right">
                            <label for="">
                                <asp:Literal ID="Literal20"  Text="<%$Resources:StoreResources, WardLabel %>"  runat="server"></asp:Literal> :</label>
                            <div class="choose">
                                <strong>
                                    <asp:Literal ID="ltrWardShipping" runat="server" /></strong>
                            </div>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                </div>
                <%--<div class="note-cart">
                    <label class="italic">
                        <i>Thông tin được yêu cầu cung cấp </i>
                    :</label>
                </div>--%>
            </div>
            <!--end wrap-info-custommer-->
            <div class="wrap-info-order">
                <div class="title-info">
                    <asp:Literal ID="Literal32"  Text="<%$Resources:StoreResources, CartInfoLabel %>"  runat="server"></asp:Literal></div>
                <ws:CartList ID="cartList" IsShoppingCart="false" runat="server" />
            </div>
            <!--end wrap-info-order-->
            <div class="wrap-forms-of-payment">
                <div class="title-info">
                    <asp:Literal ID="Literal37"  Text="<%$Resources:StoreResources, PaymentInfoLabel %>"  runat="server"></asp:Literal> </div>
                <div class="payment">
                    <div class="payment-radio">
                        <asp:RadioButton ID="rdpPay2" Enabled="false" runat="server" GroupName="payment" />
                        <asp:Literal ID="Literal33"  Text="<%$Resources:StoreResources, PayTranferLabel %>"  runat="server"></asp:Literal> 
                        
                        <asp:Literal ID="Literal34"  Text="<%$Resources:StoreResources, BankInfoLabel %>"  runat="server"></asp:Literal>
                    </div>
                    <div class="payment-radio">
                        <asp:RadioButton ID="rdpPay1" Enabled="false" runat="server" GroupName="payment" /><asp:Literal ID="Literal35"  Text="<%$Resources:StoreResources, PayCODLabel %>"  runat="server"></asp:Literal> 
                         <asp:Literal ID="Literal36"  Text="<%$Resources:StoreResources, CODInfoLabel %>"  runat="server"></asp:Literal>
                        
                    </div>
                    <div id="Div2" class="payment-radio" runat="server" visible="false">
                        <asp:RadioButton ID="rdpPay3" Enabled="false" runat="server" GroupName="payment" />Thẻ
                        ATM</div>
                    <div id="Div3" class="payment-radio" runat="server" visible="false">
                        <asp:RadioButton ID="rdpPay4" Enabled="false" runat="server" GroupName="payment" />Thẻ
                        quốc tế Master/Visa
                    </div>
                    <div id="Div4" class="payment-radio" runat="server" visible="false">
                        <asp:RadioButton ID="rdpPay5" Enabled="false" runat="server" GroupName="payment" />Ví
                        điện tử ngân lượng</div>
                </div>
                <div id="Div5" runat="server" visible="false">
                    <div class="title-info">
                        Phương thức vận chuyển</div>
                    <div class="payment">
                        <div class="payment-radio">
                            <asp:RadioButton ID="rdpShip1" Enabled="false" Checked="true" runat="server" GroupName="ship" />
                            Chuyển thường có đảm bảo <span>TP.HCM (2-3 ngày làm việc)<br />
                                Tỉnh/ thành khác (3-7 ngày làm việc)</span>
                        </div>
                        <div class="payment-radio">
                            <asp:RadioButton ID="rdpShip2" Enabled="false" runat="server" GroupName="ship" />Chuyển
                            phát nhanh <span>TP.HCM (1 ngày làm việc)<br>
                                Tỉnh/ thành khác (1-3 ngày làm việc)</span></div>
                        <%-- <div class="payment-radio">
                        <a href="#">Xem thông tin phí vận chuyển</a></div>--%>
                    </div>
                    <div class="title-info">
                        Thông tin đơn hàng</div>
                    <div class="form-info">
                        <div class="form-custommer wrap0">
                            <label for="">
                                Tên công ty:</label>
                            <strong>
                                <asp:Literal ID="ltrOrderName" runat="server" /></strong>
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                Địa chỉ:</label>
                            <strong>
                                <asp:Literal ID="ltrOrderAddress" runat="server" /></strong>
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                Mã số thuế:</label>
                            <strong>
                                <asp:Literal ID="ltrOrderTaxCode" runat="server" /></strong>
                        </div>
                        <div class="form-custommer">
                            <label for="">
                                Ghi chú:</label>
                            <strong>
                                <asp:Literal ID="ltrNote" runat="server"></asp:Literal></strong>
                        </div>
                    </div>
                </div>
                <div class="form-custommer">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btnPaySub2" Text="<%$Resources:StoreResources, CartStep4 %>" 
                        ValidationGroup="address" />
                </div>
            </div>
            <div class="clear">
            </div>
        </div>
    </asp:Panel>
    <!--end wrap-border-->
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />