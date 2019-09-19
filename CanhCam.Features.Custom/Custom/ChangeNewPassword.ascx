<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="ChangeNewPassword.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.ChangeNewPassword" %>

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
                                <div class="form-group clearfix form-newpass">
                                    <label>New Password</label>
                                    <asp:TextBox runat="server" ID="txtpass" required="true" TextMode="Password"  />
                                    <label class="lbstrongpass" id="lbstrongpass"></label>
                                </div>
                                <asp:Button runat="server" CssClas="btnchange" Text="Change Password" ID="btnlogin" />
                            </asp:Panel>
                        </div>
                    </div>
                    <div class="form-reset2" id="formreset2" runat="server" visible="false">
                        <div class="alert alert-success">
                            <strong>Change Password Success!</strong>
                             <h3>Web Will Auto Back to Home after <span id="timer" runat="server">5</span> seconds</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        function checkPasswordMatch() {
            var cfpas = $(this).val();
            if (cfpas.length < 8)
            {
                $('#lbstrongpass').text("Password not strong");
            }
            else
            {
                $('#lbstrongpass').text("Password strong");
            }
        }
        $(".form-newpass input").keyup(checkPasswordMatch);
       
    });
</script>