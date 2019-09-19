<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="CheckoutControl.ascx.cs" Inherits="CanhCam.Web.ProductUI.CheckoutControl" %>

<h2>Thông tin giao hàng</h2>
<div id="divBilling" class="forminput" runat="server">
    <div class="form-group">
        <gb:SiteLabel ID="lblFirstName" ForControl="txtFirstName" CssClass="label" Text="Tên người mua" ResourceFile="StoreResources" runat="server" />
        <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" MaxLength="100" />
        <asp:RequiredFieldValidator ControlToValidate="txtFirstName" ID="RequiredFirstName"
            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
    </div>
    <div id="Div1" visible="false" runat="server" class="form-group">
        <gb:SiteLabel ID="lblLastName" CssClass="label" ForControl="txtLastName" Text="<%$Resources:StoreResources, LastNameLabel %>" ResourceFile="StoreResources" runat="server" />
        <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" MaxLength="100" />
        <asp:RequiredFieldValidator ControlToValidate="txtLastName" ID="RequiredLastName"
            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
    </div>
    <div class="form-group">
        <gb:SiteLabel ID="lblHomeNumber" CssClass="label" ForControl="txtHomeNumber" Text="Điện thoại liên hệ" ResourceFile="StoreResources" runat="server" />
        <asp:TextBox ID="txtHomeNumber" CssClass="form-control" runat="server" MaxLength="50" />
        <asp:RequiredFieldValidator ControlToValidate="txtHomeNumber" ID="RequiredHomeNumber"
            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
    </div>
    <div class="form-group">
        <gb:SiteLabel ID="lblEmail" CssClass="label" ForControl="txtEmail" Text="Email liên hệ" ResourceFile="StoreResources" runat="server" />
        <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" MaxLength="100" />
        <asp:RequiredFieldValidator ControlToValidate="txtEmail" ID="EmailRequired" runat="server"
            Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
        <asp:RegularExpressionValidator ID="EmailRegex" runat="server" ControlToValidate="txtEmail"
            Display="Dynamic" SetFocusOnError="true" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$"
            ValidationGroup="address" />
    </div>
    <div id="Div2" class="form-group" runat="server" visible="false">
        <gb:SiteLabel ID="lblMobile" CssClass="label" ForControl="txtMobile" Text="<%$Resources:StoreResources, MobileLabel %>" ResourceFile="StoreResources" runat="server" />
        <asp:TextBox ID="txtMobile" runat="server" MaxLength="50" />
        <asp:RequiredFieldValidator ControlToValidate="txtMobile" ID="RequiredMobile" runat="server"
            Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
    </div>
    <div id="Div3" class="form-group" runat="server" visible="false">
        <gb:SiteLabel ID="lblAddress" CssClass="label" ForControl="txtAddress" Text="<%$Resources:StoreResources, AddressLabel %>" ResourceFile="StoreResources" runat="server" />
        <asp:TextBox ID="txtAddress" CssClass="form-control" runat="server" MaxLength="255" />
        <asp:RequiredFieldValidator ControlToValidate="txtAddress" ID="RequiredAddress" runat="server"
            Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" visible="false" runat="server">
        <ContentTemplate>
            <div class="form-group">
                <gb:SiteLabel ID="lblProvince" CssClass="label" ForControl="ddProvince" Text="<%$Resources:StoreResources, ProvinceLabel %>" ResourceFile="StoreResources" runat="server" />
                <asp:DropDownList ID="ddProvince" CssClass="form-control" AutoPostBack="true" DataValueField="Guid" DataTextField="Name" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="ddProvince" ID="RequiredProvince"
                    runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
            </div>
            <div class="form-group">
                <gb:SiteLabel ID="lblDistrict" CssClass="label" ForControl="ddDistrict" Text="<%$Resources:StoreResources, DistrictLabel %>" ResourceFile="StoreResources" runat="server" />
                <asp:DropDownList ID="ddDistrict" CssClass="form-control" DataValueField="Guid" DataTextField="Name" runat="server" AutoPostBack="true" />
                <asp:RequiredFieldValidator ControlToValidate="ddDistrict" ID="RequiredFieldValidator1"
                    runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
            </div>
            <div class="form-group">
                <gb:SiteLabel ID="lblWard" CssClass="label" ForControl="ddWard" Text="<%$Resources:StoreResources, WardLabel %>" ResourceFile="StoreResources" runat="server" />
                <asp:DropDownList ID="ddWard" CssClass="form-control" DataValueField="Guid" DataTextField="Name" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="ddWard" ID="RequiredFieldValidator2"
                    runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<h3>
    <asp:CheckBox ID="chbSame" AutoPostBack="true" Checked="true" Text="Thông tin người mua giống với người nhận" runat="server" />
</h3>
<div id="divShipping" class="forminput" visible="false" runat="server">
    <div class="form-group">
        <gb:SiteLabel ID="lblFirstNameShipping" CssClass="label" ForControl="txtFirstNameShipping" Text="Tên người nhận" ResourceFile="StoreResources" runat="server" />
        <asp:TextBox ID="txtFirstNameShipping" CssClass="form-control" runat="server" MaxLength="100" />
        <asp:RequiredFieldValidator ControlToValidate="txtFirstNameShipping" ID="RequiredFieldValidator3"
            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
    </div>
    <div id="Div4" class="form-group" visible="false" runat="server">
        <gb:SiteLabel ID="lblLastNameShipping" CssClass="label" ForControl="txtLastNameShipping" Text="<%$Resources:StoreResources, LastNameLabel %>" runat="server" />
        <asp:TextBox ID="txtLastNameShipping" CssClass="form-control" runat="server" MaxLength="100" />
        <asp:RequiredFieldValidator ControlToValidate="txtLastNameShipping" ID="RequiredFieldValidator4"
            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
    </div>
    <div class="form-group">
        <gb:SiteLabel ID="lblAddressShipping" CssClass="label" ForControl="txtAddressShipping" Text="Địa chỉ người nhận" ResourceFile="StoreResources" runat="server" />
        <asp:TextBox ID="txtAddressShipping" CssClass="form-control" runat="server" MaxLength="255" />
        <asp:RequiredFieldValidator ControlToValidate="txtAddressShipping" ID="RequiredFieldValidator8"
            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
    </div>
    <div class="form-group">
        <gb:SiteLabel ID="lblHomeNumberShipping" CssClass="label" ForControl="txtHomeNumberShipping" Text="Điện thoại liên hệ" ResourceFile="StoreResources" runat="server" />
        <asp:TextBox ID="txtHomeNumberShipping" CssClass="form-control" runat="server" MaxLength="50" />
        <asp:RequiredFieldValidator ControlToValidate="txtHomeNumberShipping" ID="RequiredFieldValidator6"
            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
    </div>
    <div id="Div5" class="form-group" visible="false" runat="server">
        <gb:SiteLabel ID="lblEmailShipping" CssClass="label" ForControl="txtEmailShipping" Text="<%$Resources:StoreResources, EmailLabel %>" runat="server" />
        <asp:TextBox ID="txtEmailShipping" CssClass="form-control" runat="server" MaxLength="100" />
        <asp:RequiredFieldValidator ControlToValidate="txtEmailShipping" ID="reqEmailShipping"
            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
        <asp:RegularExpressionValidator ID="regEmailShipping" runat="server" ControlToValidate="txtEmailShipping"
            Display="Dynamic" SetFocusOnError="true" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$"
            ValidationGroup="address" />
    </div>
    <div id="Div6" class="form-group" runat="server" visible="false">
        <gb:SiteLabel ID="lblMobileShipping" CssClass="label" ForControl="txtMobileShipping" Text="<%$Resources:StoreResources, MobileLabel %>" runat="server" />
        <asp:TextBox ID="txtMobileShipping" CssClass="form-control" runat="server" MaxLength="50" />
        <asp:RequiredFieldValidator ControlToValidate="txtMobileShipping" ID="reqMobileShipping"
            runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
    </div>
    <asp:UpdatePanel ID="UpdatePanel2" visible="false" runat="server">
        <ContentTemplate>
            <div class="form-group">
                <gb:SiteLabel ID="lblProvinceShipping" CssClass="label" ForControl="ddProvinceShipping" Text="<%$Resources:StoreResources, ProvinceLabel %>" runat="server" />
                <asp:DropDownList ID="ddProvinceShipping" CssClass="form-control" AutoPostBack="true" DataValueField="Guid" DataTextField="Name" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="ddProvinceShipping" ID="RequiredFieldValidator9"
                    runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
            </div>
            <div class="form-group">
                <gb:SiteLabel ID="lblDistrictShipping" CssClass="label" ForControl="ddDistrictShipping" Text="<%$Resources:StoreResources, DistrictLabel %>" runat="server" />
                <asp:DropDownList ID="ddDistrictShipping" CssClass="form-control" DataValueField="Guid" DataTextField="Name" AutoPostBack="true" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="ddDistrictShipping" ID="RequiredFieldValidator10"
                    runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
            </div>
            <div class="form-group">
                <gb:SiteLabel ID="lblWardShipping" CssClass="label" ForControl="ddWardShipping" Text="<%$Resources:StoreResources, WardLabel %>" runat="server" />
                <asp:DropDownList ID="ddWardShipping" CssClass="form-control" DataValueField="Guid" DataTextField="Name" runat="server" />
                <asp:RequiredFieldValidator ControlToValidate="ddWardShipping" ID="RequiredFieldValidator11"
                    runat="server" Display="Dynamic" SetFocusOnError="true" ValidationGroup="address" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<div class="cart-sum mrt20">
    <asp:Button ID="btnSubmit" runat="server" CssClass="btn-cart" Text="Gửi đơn hàng" ValidationGroup="address" />
</div>