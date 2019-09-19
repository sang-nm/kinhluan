<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLEditAuthor.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLEditAuthor" %>
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
                                    <asp:Button ID="btncreate" Text="<%$Resources:CustomResources, SaveButton %>" runat="server" CausesValidation="False" />
                                </div>
                            </div>
                            <portal:NotifyMessage ID="message" runat="server" />
                            <div class="col-sm-12">
                                
                        <div class="signup-form clearfix" style="margin: 40px 0;">
                            <h1 class="headtitle">
                                Edit Infomation
                            </h1>
                            <div >
                                <div class="form-horizontal">
                                    
                                    <div class="col-sm-6 form-group clearfix">
                                        <label>Full Name</label>
                                        <asp:TextBox runat="server" ID="txtFullName" required="true" ValidationGroup="author"/>

                                    </div>
                                    
                                    <div class="col-sm-6 form-group clearfix">
                                        <label>Description Author</label>
                                        <telerik:RadEditor runat="server" ID="editDescription" ValidationGroup="author"/>

                                    </div>
                                    <div class="col-sm-6 form-group clearfix">
                                        <label>Email</label>
                                        <asp:TextBox ID="txtEmail" runat="server" type="email" required="true" ValidationGroup="author"/>
                                        <asp:Label runat="server" CssClass="label-danger" ID="lbemail"></asp:Label>
                                    </div>
                                    <div class="col-sm-6 form-group clearfix">
                                        <label>Phone</label>
                                        <asp:TextBox runat="server" ID="txtPhone"  ValidationGroup="author"/>
                                    </div>
                                    <div class="col-sm-6 form-group clearfix">
                                        <label>Link Facebook</label>
                                        <asp:TextBox runat="server" ID="txtfb" />
                                    </div>
                                    <div class="col-sm-6 form-group clearfix">
                                        <label>Link Twinter</label>
                                        <asp:TextBox runat="server" ID="txttwinter" />
                                    </div>
                                    <div class="col-sm-6 form-group clearfix">
                                        <label>Link Pinterest</label>
                                        <asp:TextBox runat="server" ID="txtpinterest" />
                                    </div>
                                    <div class="col-sm-6 form-group clearfix">
                                        <label>Link Instagram</label>
                                        <asp:TextBox runat="server" ID="txtinstagram" />
                                    </div>
                                    <div class="col-sm-6 form-btn clearfix">
                                         <label>Avatar</label><br />
                                    <asp:Image ID="ImageAvatar" Width="100px" runat="server" />
                                 <telerik:RadAsyncUpload ID="fileImage" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic"
                                    AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
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