<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="AdminProductControl.ascx.cs" Inherits="CanhCam.Web.ProductUI.AdminProductControl" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Product" Namespace="CanhCam.Web.ProductUI" %>
<%@ Import Namespace="CanhCam.Web.ProductUI" %>

<Site:ProductDisplaySettings ID="displaySettings" runat="server" />
<portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
    CurrentPageTitle="<%$Resources:ProductResources, ProductListTitle %>" CurrentPageUrl="~/Product/AdminProduct.aspx" />
<div class="admin-content col-md-12">
    <portal:HeadingPanel ID="heading" runat="server">
        <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:ProductResources, ProductUpdateButton %>"
            runat="server" />
        <asp:HyperLink SkinID="InsertButton" ID="lnkInsert" Text="<%$Resources:Resource, InsertButton %>" runat="server" />
        <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:ProductResources, ProductDeleteSelectedButton %>"
            runat="server" CausesValidation="false" />
    </portal:HeadingPanel>
    <portal:NotifyMessage ID="message" runat="server" />    
    <asp:Panel ID="pnlSearch" CssClass="headInfo form-horizontal" DefaultButton="btnSearch" runat="server">
        <div class="settingrow form-group">
            <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
            <div class="col-sm-9">
                <asp:DropDownList ID="ddZones" AutoPostBack="false" runat="server" />
            </div>
        </div>
        <div class="settingrow form-group">
            <gb:SiteLabel ID="lblTitle" runat="server" ConfigKey="ProductNameLabel"
                ResourceFile="ProductResources" ForControl="txtTitle" CssClass="settinglabel control-label col-sm-3" />
            <div class="col-sm-9">
                <div class="input-group">
                    <asp:TextBox ID="txtTitle" runat="server" MaxLength="255" />
                    <div class="input-group-btn">
                        <asp:Button SkinID="DefaultButton" ID="btnSearch" Text="<%$Resources:ProductResources, ProductSearchButton %>"
                            runat="server" CausesValidation="false" />
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div class="workplace">
        <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
            <MasterTableView DataKeyNames="ProductId,ZoneId,DisplayOrder,ViewCount,Code,Price,OldPrice">
                <Columns>
                    <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>">
                        <ItemTemplate>
                            <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:ProductResources, ProductPictureHeading %>">
                        <ItemTemplate>
                            <portal:MediaElement ID="ml" runat="server" Width="90" FileUrl='<%# ProductHelper.GetImageFilePath(siteSettings.SiteId, Convert.ToInt32(Eval("ProductId")), Eval("ImageFile").ToString(), Eval("ThumbnailFile").ToString()) %>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="115" HeaderStyle-Wrap="false" HeaderText="<%$Resources:ProductResources, ProductCodeLabel %>" UniqueName="ProductCode">
                        <ItemTemplate>
                            <asp:TextBox ID="txtProductCode" Width="95"
                                MaxLength="50" Text='<%# Eval("Code") %>' runat="server" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductNameLabel %>">
                        <ItemTemplate>
                            <asp:HyperLink CssClass="cp-link" ID="Title" runat="server" Text='<%# Eval("Title").ToString() %>'
                                NavigateUrl='<%# ProductHelper.FormatProductUrl(Eval("Url").ToString(), Convert.ToInt32(Eval("ProductId")), Convert.ToInt32(Eval("ZoneId")))  %>'>
                            </asp:HyperLink>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:ProductResources, ProductPriceLabel %>" UniqueName="Price">
                        <ItemTemplate>
                            <asp:TextBox ID="txtPrice" SkinID="PriceTextBox" style="text-align:right"
                                MaxLength="50" Text='<%# ProductHelper.FormatPrice(Convert.ToDecimal(Eval("Price"))) %>' runat="server" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:ProductResources, ProductOldPriceLabel %>" UniqueName="OldPrice">
                        <ItemTemplate>
                            <asp:TextBox ID="txtOldPrice" SkinID="PriceTextBox" style="text-align:right"
                                MaxLength="50" Text='<%# ProductHelper.FormatPrice(Convert.ToDecimal(Eval("OldPrice"))) %>' runat="server" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:ProductResources, ProductDisplayOrderLabel %>">
                        <ItemTemplate>
                            <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox"
                                MaxLength="4" Text='<%# Eval("DisplayOrder") %>' runat="server" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn Visible="false" HeaderStyle-Width="100" HeaderText="<%$Resources:ProductResources, ProductViewCountLabel %>"
                        AllowFiltering="false">
                        <ItemTemplate>
                            <%# Eval("ViewCount") %>
                            <asp:TextBox ID="txtViewCount" SkinID="NumericTextBox" Visible="false"
                                MaxLength="9" Text='<%# Eval("ViewCount") %>' runat="server" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="50">
                        <ItemTemplate>
                            <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" 
                                Visible='<%# CanEditProduct(Convert.ToInt32(Eval("UserId")), Convert.ToBoolean(Eval("IsPublished")), Eval("StateId")) %>'
                                Text="<%$Resources:ProductResources, ProductEditLink %>" NavigateUrl='<%# siteRoot + EditPageUrl + "?ProductID=" + Eval("ProductId") %>'>
                            </asp:HyperLink>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
</div>