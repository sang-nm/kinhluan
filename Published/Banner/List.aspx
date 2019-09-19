<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="List.aspx.cs" Inherits="CanhCam.Web.BannerUI.BannerList" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Banner" Namespace="CanhCam.Web.BannerUI" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:BannerDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:BannerResources, ImageListHeading %>" CurrentPageUrl="~/Banner/List.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:BannerResources, BannerEditUpdateButton %>" runat="server" />
            <asp:HyperLink SkinID="InsertButton" ID="lnkInsert" Text="<%$Resources:BannerResources, InsertLink %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:BannerResources, BannerListDeleteSelectedButton %>" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="headInfo form-horizontal">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                    ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddZones" AutoPostBack="true" runat="server" />
                </div>
            </div>
            <div id="divBulkUpload" runat="server" class="settingrow form-group">
                <gb:SiteLabel ID="lblBulkUpload" runat="server" ForControl="txtISOCode2" CssClass="settinglabel control-label col-sm-3"
                    ResourceFile="BannerResources" ConfigKey="BulkUploadLink" />
                <div class="col-sm-9">
                    <telerik:RadAsyncUpload ID="uplImageFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic"
                        AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
                </div>
            </div>
            <div class="settingrow form-group">
                <div class="col-sm-offset-3 col-sm-9">
                    <asp:Button SkinID="DefaultButton" ID="btnUpload" runat="server" />
                    <portal:gbHelpLink ID="GbHelpLink1" runat="server" RenderWrapper="false" HelpKey="bannerlist-bulkupload-help" />
                </div>
            </div>
        </div>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="ItemID,DisplayOrder,Position">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:BannerResources, BannerListImageHeader %>">
                            <ItemTemplate>
                                <%# GetFullImageMarkup(Eval("ImageFile").ToString(), Eval("Caption").ToString())%>
                                <div><%# Eval("Caption").ToString()%></div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:BannerResources, ThumbnailLabel %>">
                            <ItemTemplate>
                                <%# GetThumnailMarkup(Eval("ThumbnailFile").ToString(), Eval("Caption").ToString())%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:BannerResources, BannerPositionLabel %>">
                            <ItemTemplate>
                                <asp:CheckBoxList ID="chkListPosition" runat="server" DataTextField="Name" DataValueField="Value" SkinID="Enum" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:BannerResources, BannerDisplayOrderLabel %>">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" MaxLength="4" Text='<%# Eval("DisplayOrder") %>'
                                    runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="100">
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" Text="<%# Resources.BannerResources.BannerEditImageLink %>" 
                                    NavigateUrl='<%# this.SiteRoot + "/Banner/Edit.aspx?ItemID=" + DataBinder.Eval(Container.DataItem,"ItemID") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />