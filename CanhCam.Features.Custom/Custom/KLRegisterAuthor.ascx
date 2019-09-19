<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLRegisterAuthor.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLRegisterAuthor" %>

<div class="container">
    <div class="row flex flex-wrap">
        <div class="col-xs-12 col-md-10 col-lg-8 col-xl-6 offset-md-1 offset-lg-2 offset-xl-3">
            <div class="signup-panel flex flex-wrap clearfix">
                <div class="signup-form clearfix" style="margin: 40px 0;">
                    <h1 class="headtitle">Đăng ký tài khoản
                    </h1>
                    <div>
                        <div class="form-horizontal">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="form-group clearfix">
                                        <label>Full Name</label>
                                        <asp:TextBox runat="server" ID="txtFullName" required="true" />

                                    </div>
                                    <div class="form-group clearfix">
                                        <label>Email</label>
                                        <asp:TextBox ID="txtEmail" runat="server" type="email" required="true" />
                                        <asp:Label runat="server" CssClass="label-danger" ID="lbemail"></asp:Label>

                                    </div>
                                    <div class="form-group clearfix">
                                        <label>Password</label>
                                        <asp:TextBox runat="server" ID="txtPass" TextMode="Password" required="true" />
                                    </div>
                                    <div class="form-group clearfix">
                                        <label>Password Comfirm</label>
                                        <asp:TextBox runat="server" ID="txtPass2" TextMode="Password" required="true" />
                                        <asp:Label runat="server" CssClass="label-danger" ID="lbcomfim"></asp:Label>
                                    </div>
                                    <div class="form-group clearfix">
                                        <label>Phone</label>
                                        <asp:TextBox runat="server" ID="txtPhone" required="true" />
                                    </div>
                                    <div class="form-btn clearfix">

                                        <label>Avatar</label><br />
                                        <asp:Image runat="server" ImageUrl="/Data/Sites/1/Author/Authordefault.png" Style="height: 70px; width: 70px;" />
                                        <telerik:RadAsyncUpload ID="fileImage" SkinID="radAsyncUploadSkin" AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                                    </div>
                                    <asp:Button CssClass="btn btn-default" ID="btnCreate" runat="server" Text="Create" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
