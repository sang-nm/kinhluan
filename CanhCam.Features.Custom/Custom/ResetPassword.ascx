<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="ResetPassword.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.ResetPassword" %>


<div class="container">
    <div class="row flex flex-wrap">
        <div class="col-xs-12 col-md-10 col-lg-8 col-xl-6 offset-md-1 offset-lg-2 offset-xl-3">
            <div class="signup-panel flex flex-wrap clearfix">
                <div class="signup-form clearfix" style="margin: 40px 0;">
                    <h1 class="headtitle">Reset Password
                    </h1>
                    <div class="form-reset" id="formreset" runat="server">
                        <div class="form-horizontal">
                            <asp:Panel runat="server" DefaultButton="btnlogin">
                                <div class="form-group clearfix">
                                    <label>Email</label>
                                    <asp:TextBox runat="server" ID="txtEmail" required="true" />
                                </div>
                                <portal:NotifyMessage CssClass="text-danger" ID="message" runat="server" />
                                <asp:Button runat="server" Text="Reset" ID="btnlogin" />
                            </asp:Panel>
                        </div>
                    </div>
                    <div class="form-reset2" id="formreset2" runat="server" visible="false">
                        <div class="alert alert-info">
                            <strong>Reset Password Success!</strong> An email has been sent to <span runat="server" id="spanemail"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
