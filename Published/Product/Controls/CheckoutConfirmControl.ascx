<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="CheckoutConfirmControl.ascx.cs"
    Inherits="CanhCam.Web.ProductUI.CheckoutConfirmControl" %>
<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Product" Namespace="CanhCam.Web.ProductUI" %>
<Site:CartDisplaySettings ID="displaySettings" runat="server" />

<div class="titlecart">
    <a class="active" href="/store/Cart.aspx"><span class="active">1.</span> <asp:Literal ID="ltrStep1"  Text="<%$Resources:StoreResources, CartStep1 %>"  runat="server"></asp:Literal></a>
</div>
<asp:Panel ID="pnlRegister" CssClass="wra-dky" runat="server">
    <div class="titlecart">
        <a class="active" href=""><span class="active">2.</span> <asp:Literal ID="Literal1"  Text="<%$Resources:StoreResources, CartStep2 %>"  runat="server"></asp:Literal></a>
    </div>
    <div class="titlecart">
        <a href=""><span>3.</span> <asp:Literal ID="Literal2"  Text="<%$Resources:StoreResources, CartStep3 %>"  runat="server"></asp:Literal></a>
    </div>
    <div class="titlecart">
        <a href=""><span>4.</span> <asp:Literal ID="Literal3"  Text="<%$Resources:StoreResources, CartStep4 %>"  runat="server"></asp:Literal></a>
    </div>
    <div class="clear">
    </div>
    <h1>
            <asp:Literal ID="Literal4"  Text="<%$Resources:StoreResources, CartStep2 %>"  runat="server"></asp:Literal></h1>
    <div class="login-buy-prd">
        <div class="title-login">
        <asp:Literal ID="Literal8"  Text="<%$Resources:StoreResources, NotReg %>"  runat="server"></asp:Literal>

            </div>
        <div class="bg-login-prd">
            <a id="A1" class="register-link-prd" href="<%$Resources:StoreResources, NotRegLink %>" runat="server">
                <asp:Literal ID="Literal9"  Text="<%$Resources:StoreResources, Register %>"  runat="server"></asp:Literal>

                <img src="/Data/Sites/1/media/btn-next.png" alt="" /></a>
        </div>
    </div>
</asp:Panel>
<asp:Panel ID="pnlAddress" Visible="false" CssClass="wra-ttin" runat="server">
    <div class="titlecart">
        <a class="active" href=""><span class="active">2 .</span> <asp:Literal ID="Literal5"  Text="<%$Resources:StoreResources, CartStep2 %>"  runat="server"></asp:Literal></a>
    </div>
    <div class="titlecart">
        <a class="active" href=""><span>3 .</span> <asp:Literal ID="Literal6"  Text="<%$Resources:StoreResources, CartStep3 %>"  runat="server"></asp:Literal></a>
    </div>
    <div class="titlecart">
        <a href=""><span>4 .</span> <asp:Literal ID="Literal7"  Text="<%$Resources:StoreResources, CartStep4 %>"  runat="server"></asp:Literal></a>
    </div>
    <div class="clear">
    </div>
    <h1>
        <asp:Literal ID="Literal10"  Text="<%$Resources:StoreResources, InfoAndPay %>"  runat="server"></asp:Literal>
           
    </h1>
        
    <div class="clear">
    </div>
    <div class="wrap-border">
        <div class="wrap-info-custommer">
            <div id="DivBiiling" runat="server">
                <div class="title-info">
                <asp:Literal ID="Literal1112"  Text="<%$Resources:StoreResources, CustomerInfo %>"  runat="server"></asp:Literal>

                    </div>
                <div class="form-info">
                    <div class="form-left">
                        <label for="">
                            <asp:Literal ID="Literal11"  Text="<%$Resources:StoreResources, FirstNameLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtFirstName" runat="server" MaxLength="100" />
                        <asp:RequiredFieldValidator ControlToValidate="txtFirstName" ID="RequiredFirstName"
                            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-right">
                        <label for="">
                                <asp:Literal ID="Literal12"  Text="<%$Resources:StoreResources, LastNameLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtLastName" runat="server" MaxLength="100" />
                        <asp:RequiredFieldValidator ControlToValidate="txtLastName" ID="RequiredLastName"
                            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="form-custommer cus2">
                        <label for="">
                                <asp:Literal ID="Literal13"  Text="<%$Resources:StoreResources, EmailLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtEmail" runat="server" MaxLength="100" />
                        <asp:RequiredFieldValidator ControlToValidate="txtEmail" ID="EmailRequired" runat="server"
                            Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="EmailRegex" runat="server" ControlToValidate="txtEmail"
                            Display="Dynamic" SetFocusOnError="true" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$"
                            ValidationGroup="address"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-custommer cus2">
                        <label for="">
                                <asp:Literal ID="Literal14"  Text="<%$Resources:StoreResources, PhoneLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtHomeNumber" runat="server" MaxLength="50" />
                        <asp:RequiredFieldValidator ControlToValidate="txtHomeNumber" ID="RequiredHomeNumber"
                            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                            
                    </div>
                    <div id="Div1" class="form-custommer cus2" runat="server" visible="false">
                        <label for="">
                                <asp:Literal ID="Literal15"  Text="<%$Resources:StoreResources, MobileLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtMobile" runat="server" MaxLength="50" />
                        <asp:RequiredFieldValidator ControlToValidate="txtMobile" ID="RequiredMobile" runat="server"
                            Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-custommer cus2">
                        <label for="">
                                <asp:Literal ID="Literal16"  Text="<%$Resources:StoreResources, AddressLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtAddress" runat="server" MaxLength="255" />
                        <asp:RequiredFieldValidator ControlToValidate="txtAddress" ID="RequiredAddress" runat="server"
                            Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                    </div>
                    <div class="clear">
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-custommer">
                                <label for="">
                                    <asp:Literal ID="Literal17"  Text="<%$Resources:StoreResources, ProvinceLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                                <div class="choose">
                                    <asp:DropDownList ID="ddProvince" AutoPostBack="true" DataValueField="Guid" DataTextField="Name"
                                        runat="server" />
                                    <asp:RequiredFieldValidator ControlToValidate="ddProvince" ID="RequiredProvince"
                                        runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-left">
                                <label for="">
                                        <asp:Literal ID="Literal18"  Text="<%$Resources:StoreResources, DistrictLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                                <div class="choose">
                                    <asp:DropDownList ID="ddDistrict" DataValueField="Guid" DataTextField="Name" runat="server"
                                        AutoPostBack="true" />
                                    <asp:RequiredFieldValidator ControlToValidate="ddDistrict" ID="RequiredFieldValidator1"
                                        runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-right">
                                <label for="">
                                        <asp:Literal ID="Literal19"  Text="<%$Resources:StoreResources, WardLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                                <div class="choose">
                                    <asp:DropDownList ID="ddWard" DataValueField="Guid" DataTextField="Name" runat="server" />
                                    <asp:RequiredFieldValidator ControlToValidate="ddWard" ID="RequiredFieldValidator2"
                                        runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="clear">
                    </div>
                    <div class="form-custommer">
                        <asp:CheckBox ID="chbSame" AutoPostBack="true" Checked="true" runat="server" /><label
                            for="" class="checkbox-address"><asp:Literal ID="Literal20"  Text="<%$Resources:StoreResources, SameAddress %>"  runat="server"></asp:Literal></label>
                    </div>
                </div>
            </div>
            <div id="divShipping" visible="false" runat="server">
                <div class="title-info">
                    <asp:Literal ID="Literal31"  Text="<%$Resources:StoreResources, ShippingAddressLabel %>"  runat="server"></asp:Literal></div>
                <div class="form-info">
                    <div class="form-left">
                        <label for="">
                            <asp:Literal ID="Literal21"  Text="<%$Resources:StoreResources, FirstNameLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtFirstNameShipping" runat="server" MaxLength="100" />
                        <asp:RequiredFieldValidator ControlToValidate="txtFirstNameShipping" ID="RequiredFieldValidator3"
                            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-right">
                        <label for="">
                            <asp:Literal ID="Literal22"  Text="<%$Resources:StoreResources, LastNameLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtLastNameShipping" runat="server" MaxLength="100" />
                        <asp:RequiredFieldValidator ControlToValidate="txtLastNameShipping" ID="RequiredFieldValidator4"
                            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                    </div>
                    <div class="clear">
                    </div>
                    <div class="form-custommer">
                        <label for="">
                            <asp:Literal ID="Literal23"  Text="<%$Resources:StoreResources, EmailLabel %>"  runat="server"></asp:Literal>(<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtEmailShipping" runat="server" MaxLength="100" />
                        <asp:RequiredFieldValidator ControlToValidate="txtEmailShipping" ID="RequiredFieldValidator5"
                            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmailShipping"
                            Display="Dynamic" SetFocusOnError="true" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$"
                            ValidationGroup="address"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-custommer">
                        <label for="">
                            <asp:Literal ID="Literal24"  Text="<%$Resources:StoreResources,PhoneLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtHomeNumberShipping" runat="server" MaxLength="50" />
                        <asp:RequiredFieldValidator ControlToValidate="txtHomeNumberShipping" ID="RequiredFieldValidator6"
                            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                            
                    </div>
                    <div id="Div2" class="form-custommer" runat="server" visible="false">
                        <label for="">
                            <asp:Literal ID="Literal25"  Text="<%$Resources:StoreResources, MobileLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtMobileShipping" runat="server" MaxLength="50" />
                        <asp:RequiredFieldValidator ControlToValidate="txtMobileShipping" ID="RequiredFieldValidator7"
                            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-custommer">
                        <label for="">
                            <asp:Literal ID="Literal26"  Text="<%$Resources:StoreResources, AddressLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                        <asp:TextBox ID="txtAddressShipping" runat="server" MaxLength="255" />
                        <asp:RequiredFieldValidator ControlToValidate="txtAddressShipping" ID="RequiredFieldValidator8"
                            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                    </div>
                    <div class="clear">
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="form-custommer">
                                <label for="">
                                    <asp:Literal ID="Literal27"  Text="<%$Resources:StoreResources, ProvinceLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                                <div class="choose">
                                    <asp:DropDownList ID="ddProvinceShipping" AutoPostBack="true" DataValueField="Guid"
                                        DataTextField="Name" runat="server" />
                                    <asp:RequiredFieldValidator ControlToValidate="ddProvinceShipping" ID="RequiredFieldValidator9"
                                        runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-left">
                                <label for="">
                                    <asp:Literal ID="Literal28"  Text="<%$Resources:StoreResources, DistrictLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                                <div class="choose">
                                    <asp:DropDownList ID="ddDistrictShipping" DataValueField="Guid" DataTextField="Name"
                                        AutoPostBack="true" runat="server" />
                                    <asp:RequiredFieldValidator ControlToValidate="ddDistrictShipping" ID="RequiredFieldValidator10"
                                        runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-right">
                                <label for="">
                                    <asp:Literal ID="Literal29"  Text="<%$Resources:StoreResources, WardLabel %>"  runat="server"></asp:Literal> (<span class="redcolor">*</span>)</label>
                                <div class="choose">
                                    <asp:DropDownList ID="ddWardShipping" DataValueField="Guid" DataTextField="Name"
                                        runat="server" />
                                    <asp:RequiredFieldValidator ControlToValidate="ddWardShipping" ID="RequiredFieldValidator11"
                                        runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="clear">
                    </div>
                </div>
            </div>
            <div class="note-cart">
                <label class="italic">
                    <i>(<span class="redcolor">*</span>)<asp:Literal ID="Literal30"  Text="<%$Resources:StoreResources, InforequestLabel %>"  runat="server"></asp:Literal> </i>
                </label>
                <br />
                <br />
                <%-- <label class="italic">
                    <i><span class="redcolor">Voucher giảm giá chỉ được dùng cho 1 đơn hàng có giá trị từ
                        600,000 VND trở lên</span> </i>
                </label>--%>
            </div>
        </div>
        <!--end wrap-info-custommer-->
        <div class="wrap-info-order">
            <div class="title-info">
                <asp:Literal ID="Literal32"  Text="<%$Resources:StoreResources, CartInfoLabel %>"  runat="server"></asp:Literal> </div>
        </div>
        <!--end wrap-info-order-->
        <div class="wrap-forms-of-payment">
            <div class="title-info">
                <asp:Literal ID="Literal37"  Text="<%$Resources:StoreResources, PaymentInfoLabel %>"  runat="server"></asp:Literal> </div>
            <div class="payment">
                <div class="payment-radio">
                    <asp:RadioButton ID="rdpPay2" Checked="false" runat="server" GroupName="payment" />
                    <asp:Literal ID="Literal33"  Text="<%$Resources:StoreResources, PayTranferLabel %>"  runat="server"></asp:Literal> 
                        
                    <%--<asp:Literal ID="Literal34"  Text="<%$Resources:StoreResources, BankInfoLabel %>"  runat="server"></asp:Literal> --%>
                        
                    <Site:HtmlModule  runat="server" ModuleId="108" />
                        
                        
                </div>
                <div class="payment-radio">
                    <asp:RadioButton ID="rdpPay1" Checked="true" runat="server" GroupName="payment" /> <asp:Literal ID="Literal35"  Text="<%$Resources:StoreResources, PayCODLabel %>"  runat="server"></asp:Literal> 
                        <asp:Literal ID="Literal36"  Text="<%$Resources:StoreResources, CODInfoLabel %>"  runat="server"></asp:Literal>
                        
                </div>
                <div id="Div3" class="payment-radio" runat="server" visible="false">
                    <asp:RadioButton ID="rdpPay3" Checked="false" runat="server" GroupName="payment" />Thẻ
                    ATM</div>
                <div id="Div4" class="payment-radio" runat="server" visible="false">
                    <asp:RadioButton ID="rdpPay4" Checked="false" runat="server" GroupName="payment" />Thẻ
                    quốc tế Master/Visa
                </div>
                <div id="Div5" class="payment-radio" runat="server" visible="false">
                    <asp:RadioButton ID="rdpPay5" Checked="false" runat="server" GroupName="payment" />Ví
                    điện tử ngân lượng</div>
            </div>
            <div id="Div6" runat="server" visible="false">
                <div class="title-info">
                    Phương thức vận chuyển</div>
                <div class="payment">
                    <div class="payment-radio">
                        <asp:RadioButton ID="rdpShip1" Checked="true" runat="server" GroupName="ship" />
                        Chuyển thường có đảm bảo <span>TP.HCM (2-3 ngày làm việc)<br />
                            Tỉnh/ thành khác (3-7 ngày làm việc)</span>
                    </div>
                    <div class="payment-radio">
                        <asp:RadioButton ID="rdpShip2" runat="server" GroupName="ship" />Chuyển phát nhanh
                        <span>TP.HCM (1 ngày làm việc)<br>
                            Tỉnh/ thành khác (1-3 ngày làm việc)</span></div>
                    <div class="payment-radio">
                        <a href="/bang-phi-van-chuyen" target="_blank">Xem thông tin phí vận chuyển</a></div>
                </div>
                <div class="title-info">
                    Thông tin đơn hàng</div>
                <div class="form-info">
                    <div class="form-custommer wrap0">
                        <label for="">
                            Tên công ty</label>
                        <asp:TextBox ID="txtInvoiceCompanyName" runat="server" MaxLength="100" />
                    </div>
                    <div class="form-custommer">
                        <label for="">
                            Địa chỉ</label>
                        <asp:TextBox ID="txtInvoiceCompanyAddress" runat="server" MaxLength="255" />
                    </div>
                    <div class="form-custommer">
                        <label for="">
                            Mã số thuế</label>
                        <asp:TextBox ID="txtInvoiceCompanyTaxCode" runat="server" MaxLength="50" />
                    </div>
                    <div class="form-custommer">
                        <label for="">
                            Ghi chú</label>
                        <asp:TextBox ID="txtOrderNote" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="form-custommer">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btnPaySub2" Text="<%$Resources:StoreResources, NextLabel %>" ValidationGroup="address" />
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
    <!--end wrap-border-->
</asp:Panel>