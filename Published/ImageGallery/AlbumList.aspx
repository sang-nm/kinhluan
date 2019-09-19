<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AlbumList.aspx.cs" Inherits="CanhCam.Web.GalleryUI.AlbumList" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.ImageGallery" Namespace="CanhCam.Web.GalleryUI" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:GalleryDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:GalleryResources, AlbumListLink %>" CurrentPageUrl="~/ImageGallery/AlbumList.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:BannerResources, BannerEditUpdateButton %>" runat="server" />
            <asp:HyperLink SkinID="InsertButton" ID="lnkInsert" Text="<%$Resources:BannerResources, InsertLink %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:BannerResources, BannerListDeleteSelectedButton %>" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <asp:UpdatePanel ID="up" runat="server">
            <ContentTemplate>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="headInfo form-horizontal">
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                            ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                        <div class="col-sm-9">
                            <asp:DropDownList ID="ddZones" AutoPostBack="true" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="AlbumId,DisplayOrder,Position">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:GalleryResources, AlbumTitleLabel %>">
                                    <ItemTemplate>
                                        <%# GetPhotoMarkup(Eval("AlbumId").ToString(), Eval("WebImageFile").ToString(), Eval("Title").ToString(), "200")%>
                                        <div>
                                            <%# GetAlbumTitle(Eval("Title").ToString(), Eval("ItemCount").ToString(), Convert.ToInt32(Eval("AlbumType")))%>
                                        </div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:GalleryResources, AlbumPositionLabel %>" UniqueName="Position">
                                    <ItemTemplate>
                                        <asp:CheckBoxList ID="chkListPosition" runat="server" DataTextField="Name" DataValueField="Value" SkinID="Enum" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:GalleryResources, GalleryDisplayOrderLabel %>">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" MaxLength="4" Text='<%# Eval("DisplayOrder") %>'
                                            runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="100" UniqueName="Edit">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="EditLink" CssClass="cp-link" runat="server" Text="<%# Resources.GalleryResources.GalleryEditLink %>" 
                                            NavigateUrl='<%# this.SiteRoot + "/ImageGallery/AlbumEdit.aspx?AlbumID=" + DataBinder.Eval(Container.DataItem,"AlbumId") %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />