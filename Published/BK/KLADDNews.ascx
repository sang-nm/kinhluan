<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLADDNews.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLADDNews" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Custom" Namespace="CanhCam.Web.CustomUI" %>
<%@ Register Src="~/Custom/LeftMenu.ascx" TagPrefix="portal" TagName="LeftMenu" %>

<Site:NewsDisplaySettings ID="displaySettings" runat="server" />
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
                                <div class="btn-review">
                                    <asp:Button ID="btnreview" Text="<%$Resources:CustomResources, ReviewButton %>" runat="server" CausesValidation="False" />
                                </div>
                                <div class="btn-export">
                                    <asp:Button ID="btnpost" Text="<%$Resources:CustomResources, PostButton %>" runat="server" CausesValidation="False" />
                                </div>
                                <div class="btn-save">
                                    <asp:Button ID="btndraft" Text="<%$Resources:CustomResources, DraftsButton %>" runat="server" CausesValidation="False" />
                                </div>
                                <div class="btn-save">
                                    <asp:Button ID="btncreate" Text="<%$Resources:CustomResources, CreateButton %>" runat="server" CausesValidation="False" />
                                </div>
                            </div>
                            <portal:NotifyMessage ID="message" runat="server" />
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#profile" role="tab" data-toggle="tab">Content</a>
                                </li>
                                <li class="nav-item" id="litabimages" runat="server">
                                    <a class="nav-link" href="#buzz" role="tab" data-toggle="tab">Images</a>
                                </li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane fade in active" id="profile">
                                    <div class="form-editor">
                                        <div class="form-group">
                                            <label>Category: </label>
                                            <asp:DropDownList runat="server" ID="ddlnewtype" DataTextField="Name" DataValueField="NewsTypeID" AutoPostBack="true" ></asp:DropDownList>
                                        </div>
                                        <div class="form-group">
                                            <label>Category Child: </label>
                                            <asp:DropDownList runat="server" ID="ddlnewtypechild" DataTextField="Name" DataValueField="NewsTypeID" AutoPostBack="true"></asp:DropDownList>
                                        </div>
                                        <div class="form-group">
                                            <label>Title: </label>
                                            <asp:TextBox ID="newstitle" runat="server" type="text" />
                                        </div>
                                        <div class="form-group">
                                            <label>Short content: </label>
                                            <telerik:RadEditor ID="shortcontent" runat="server" Width="100%">
                                            </telerik:RadEditor>
                                            <portal:gbHelpLink ID="GbHelpLink1" runat="server" HelpKey="productedit-briefcontent-help" />
                                        </div>
                                        <div class="form-group">
                                            <label>Content: </label>
                                             <telerik:RadEditor ID="fullcontent" runat="server" Width="100%">

                                            </telerik:RadEditor>
                                            <portal:gbHelpLink ID="GbHelpLink3" runat="server" HelpKey="productedit-briefcontent-help" />
                                        </div>
                                    </div>
                                </div>
                                <div role="tabpanel" class="tab-pane fade" id="buzz">

                                    <asp:UpdatePanel ID="updImages" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="form-horizontal">
                                                <div class="settingrow form-group">
                                                    <gb:SiteLabel ID="lblImageFile" runat="server" ConfigKey="ImageFile" ResourceFile="CustomResources"
                                                        CssClass="settinglabel control-label col-sm-3" />
                                                    <div class="col-sm-9">
                                                        <telerik:RadAsyncUpload ID="uplImageFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic"
                                                            AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                                                    </div>
                                                    <div class="settingrow form-group">
                                                        <div class="col-sm-offset-3 col-sm-9">
                                                            <asp:Button SkinID="DefaultButton" ID="btnUpdateImage" OnClick="btnUpdateImage_Click"
                                                                Text="<%$Resources:CustomResources, ImageUpdateButton %>" runat="server" CausesValidation="False" />
                                                            <asp:Button SkinID="DefaultButton" ID="btnDeleteImage" Visible="false" OnClick="btnDeleteImage_Click"
                                                                Text="<%$Resources:CustomResources, ImageDeleteSelectedButton %>" runat="server"
                                                                CausesValidation="False" />
                                                            <portal:gbHelpLink ID="GbHelpLink11" runat="server" RenderWrapper="false" HelpKey="newsedit-imageupload-help" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server"
                                                OnNeedDataSource="grid_NeedDataSource" OnItemDataBound="grid_ItemDataBound">
                                                <MasterTableView DataKeyNames="Guid,LanguageId,DisplayOrder,Title">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                                                            <ItemTemplate>
                                                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:CustomResources, ImageFile %>">
                                                            <ItemTemplate>
                                                                <portal:MediaElement ID="ml2" runat="server" Width="100" FileUrl='<%# imageFolderPath + Eval("MediaFile") %>' />
                                                                <telerik:RadAsyncUpload ID="fupImageFile" SkinID="radAsyncUploadSkin" Width="100%" HideFileInput="true" MultipleFileSelection="Disabled"
                                                                    AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:CustomResources, ImageTitleLabel %>">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtTitle" CssClass="input-grid" Width="97%" MaxLength="255" Text='<%# Eval("Title") %>'
                                                                    runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:CustomResources, DisplayOrderLabel %>">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" MaxLength="4" Text='<%# Eval("DisplayOrder") %>'
                                                                    runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                                                    </Columns>
                                                </MasterTableView>
                                            </telerik:RadGrid>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </section>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
