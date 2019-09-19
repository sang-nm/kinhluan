<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="klAuthorChangePassword.ascx.cs" Inherits="CanhCam.Web.CustomUI.klAuthorChangePassword" %>


<%@ Register Src="~/Custom/LeftMenu.ascx" TagPrefix="portal" TagName="LeftMenu" %>


<div class="container">
    <div class="row flex flex-wrap">
        <div class="col-xs-12 col-lg-3">
            <portal:LeftMenu runat="server" ID="LeftMenu" />
        </div>
        <div class="col-xs-12 col-lg-9">
            <section class="user-page clearfix">
                <div class="row flex flex-wrap">
                    <div class="col-xs-12">
                        <section class="comment clearfix">
                            <div class="user-tool clearfix">
                                <%--  <div class="btn-save"><a href="#">Save to drafts</a></div>
                                <div class="btn-export"><a href="#">Post</a></div>--%>
                                <div class="btn-save">
                                    <asp:Button ID="btncreate" CssClass="btncreate" Text="<%$Resources:CustomResources, SaveButton %>" runat="server" CausesValidation="False" disabled="true"/>
                                </div>
                            </div>
                            <portal:NotifyMessage ID="message" runat="server" />
                            <div class="col-sm-12">
                                <div class="signup-form clearfix" style="margin: 40px 0;">
                                    <h1 class="headtitle">Change Password
                                    </h1>
                                    <div class="row form-author">
                                        <div class="form-horizontal form-info">
                                            <asp:HiddenField ID="hduserid" runat="server" />
                                            <div class="form-group clearfix">
                                                <label>Currrent Password</label>
                                                <asp:TextBox runat="server" ID="txtcurrentpass" CssClass="txtcurrentpass" required="true" TextMode="Password" ValidationGroup="authorpass"/>
                                                <Label class="label label-danger "  ID="lbcurrentpass" ></Label>
                                            </div>
                                            
                                            <div class="form-group clearfix form-newpass">
                                                <label>New Password</label>
                                                <asp:TextBox runat="server"  ID="txtpass" required="true" TextMode="Password" ValidationGroup="authorpass"/>
                                            </div>
                                            
                                            <div class="form-group clearfix form-comfirm ">
                                                <label>New Password Comfirm</label>
                                                <asp:TextBox runat="server" ID="txtcfpass" required="true" TextMode="Password" ValidationGroup="authorpass"/>
                                                <Label class="label label-danger " id="lbcfpass"   ></Label>
                                            </div>
                                         
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        function checkPasswordMatch() {
            var cfpas = $(this).val();
            var pass = $('.form-newpass input').val();
            if (cfpas != pass) {
                $('#lbcfpass').text("New passwords must match");
                $('.btncreate').attr("disabled", true);
            }
            else {
                $('#lbcfpass').text("");
                $('.btncreate').attr("disabled", false);
            }
        }
        $(".form-comfirm input").keyup(checkPasswordMatch);
        $('.txtcurrentpass').focusout(function () {
            var userid = $('#ctl00_mainContent_ctl00_hduserid').val();
            var pass = $(this).val();
            $.ajax({
                type: "POST",
                url: "/Custom/Services/NewsServices.aspx",
                data: { "method": "ComfirmPass", "userid": userid, "pass": pass},
                contentType: "application/json; charset=utf-8",
                success: function (result) {
                    if (result.success == true)
                        $('#lbcurrentpass').text("");
                    else
                    {
                        $('#lbcurrentpass').text("Wrong password");
                    }
                },
                error: function (errMsg) {
                    alert(errMsg);
                }
            });
            $('form').submit(function (e) {
                var bol = false;
                var cfpas = $('.form-newpass input').val();
                var pass = $('.form-comfirm input').val();
                if (cfpas == pass)
                    bol = true;
                if (bol != true)
                {
                    $('#lbcfpass').text("New passwords must match");
                    $('.form-newpass input').focus();
                    e.preventDefault();
                }
            });
        });
    });
</script>