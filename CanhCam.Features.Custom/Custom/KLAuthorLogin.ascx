<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLAuthorLogin.ascx.cs" Inherits="CanhCam.Web.CustomUI.KLAuthorLogin" %>
<div class="container">
    <div class="row flex flex-wrap">
        <div class="col-xs-12 col-md-10 col-lg-8 col-xl-6 offset-md-1 offset-lg-2 offset-xl-3">
            <div class="signup-panel flex flex-wrap clearfix">
                <div class="signup-form clearfix" style="margin: 40px 0;">
                    <h1 class="headtitle">Đăng nhập
                    </h1>
                    <div>
                        <div class="form-horizontal">
                            <asp:Panel runat="server" DefaultButton="btnlogin">
                                <div class="form-group clearfix">
                                    <label>Email</label>
                                    <asp:TextBox runat="server" ID="txtEmail" required="true" />
                                </div>
                                <div class="form-group clearfix">
                                    <label>Password</label>
                                    <asp:TextBox runat="server" TextMode="Password" ID="txtPass" required="true" />
                                </div>
                                <portal:NotifyMessage CssClass="text-danger" ID="message" runat="server" />
                                <asp:Button runat="server" Text="Login" ID="btnlogin" />
                            </asp:Panel>
                        </div>
                        <div class="forgot-password"><a href="/reset-password">Forgot your password ? </a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

