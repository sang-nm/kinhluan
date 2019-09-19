<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLADDBook.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLADDBook" %>
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
                                
                                <div class="btn-save">
                                    <asp:Button ID="btncreate" Text="<%$Resources:CustomResources, CreateButton %>" runat="server" CausesValidation="False" />
                                </div>
                            <portal:NotifyMessage ID="message" runat="server" />
                            </div>
                            <div class="form-editor">
                                <div class="form-group">
                                    <label>Title: </label>
                                    <asp:TextBox runat="server" ID="txttitle"/>
                                </div>
                                <div class="form-group">
                                    <label>Link Book (Url): </label>
                                    <asp:TextBox runat="server" ID="txtURl"/>
                                </div>
                                <div class="form-group">
                                    <label>Image File: </label>
                                    <telerik:RadAsyncUpload ID="fileImages" SkinID="radAsyncUploadSkin" AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                                </div>

                                <div class="form-group">
                                    <label>Short content: </label>
                                    <gbe:EditorControl ID="fullcontent" runat="server" />
                                    <portal:gbHelpLink ID="GbHelpLink3" runat="server" HelpKey="productedit-briefcontent-help" />

                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>

