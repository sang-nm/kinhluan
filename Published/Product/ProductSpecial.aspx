<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ProductSpecial.aspx.cs" Inherits="CanhCam.Web.ProductUI.ProductSpecialPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:ProductResources, ProductSpecialTilte %>" CurrentPageUrl="~/Product/ProductSpecial.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-horizontal">
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                                        ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                                    <div class="col-sm-9">
                                        <asp:DropDownList ID="ddZones" Width="100%" runat="server" />
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
                            </div>
                            <telerik:RadGrid ID="grid1" SkinID="radGridSkin" runat="server">
                                <MasterTableView DataKeyNames="ProductId,Position">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="50" HeaderText="<%$Resources:ProductResources, ProductPictureHeading %>">
                                            <ItemTemplate>
                                                <portal:MediaElement ID="ml" runat="server" Width="40" FileUrl='<%# CanhCam.Web.ProductUI.ProductHelper.GetImageFilePath(siteSettings.SiteId, Convert.ToInt32(Eval("ProductId")), Eval("ImageFile").ToString(), Eval("ThumbnailFile").ToString()) %>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductNameLabel %>"
                                            DataField="Title" UniqueName="Title" SortExpression="Title" CurrentFilterFunction="Contains"
                                            AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                            <ItemTemplate>
                                                <asp:HyperLink CssClass="cp-link" ID="Title" runat="server" Text='<%# Eval("Title").ToString() %>'
                                                    NavigateUrl='<%# CanhCam.Web.ProductUI.ProductHelper.FormatProductUrl(Eval("Url").ToString(), Convert.ToInt32(Eval("ProductId")), Convert.ToInt32(Eval("ZoneId")))  %>'>
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="100" >
                                            <ItemTemplate>
                                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" 
                                                    Text="<%$Resources:ProductResources, ProductEditLink %>" NavigateUrl='<%# SiteRoot + "/Product/AdminProductEdit.aspx?ProductID=" + Eval("ProductID") %>'>
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                        <div class="col-md-1 text-center mrt50">
                            <asp:LinkButton ID="btnLeft" runat="server" CssClass="btnleft"><i class="fa fa-arrow-left text-16px"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnRight" runat="server" CssClass="btnright"><i class="fa fa-arrow-right text-16px"></i></asp:LinkButton>
                            <br />
                            <portal:gbHelpLink ID="GbHelpLink1" runat="server" RenderWrapper="false" HelpKey="productspecial-addremove-help" />
                        </div>
                        <div class="col-md-5">
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblPosition" runat="server" ForControl="ddlPosition" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="NewsPositionLabel" ResourceFile="NewsResources" />
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlPosition" AutoPostBack="true" runat="server" DataTextField="Name" DataValueField="Value" />
                                </div>
                            </div>
                            <telerik:RadGrid ID="grid2" SkinID="radGridSkin" runat="server">
                                <MasterTableView DataKeyNames="ProductId,Position">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="50" HeaderText="<%$Resources:ProductResources, ProductPictureHeading %>">
                                            <ItemTemplate>
                                                <portal:MediaElement ID="ml" runat="server" Width="40" FileUrl='<%# CanhCam.Web.ProductUI.ProductHelper.GetImageFilePath(siteSettings.SiteId, Convert.ToInt32(Eval("ProductId")), Eval("ImageFile").ToString(), Eval("ThumbnailFile").ToString()) %>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductNameLabel %>"
                                            DataField="Title" UniqueName="Title" SortExpression="Title" CurrentFilterFunction="Contains"
                                            AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                            <ItemTemplate>
                                                <asp:HyperLink CssClass="cp-link" ID="Title" runat="server" Text='<%# Eval("Title").ToString() %>'
                                                    NavigateUrl='<%# CanhCam.Web.ProductUI.ProductHelper.FormatProductUrl(Eval("Url").ToString(), Convert.ToInt32(Eval("ProductId")), Convert.ToInt32(Eval("ZoneId")))  %>'>
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="100">
                                            <ItemTemplate>
                                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" 
                                                    Text="<%$Resources:ProductResources, ProductEditLink %>" NavigateUrl='<%# SiteRoot + "/Product/AdminProductEdit.aspx?ProductID=" + Eval("ProductID") %>'>
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />