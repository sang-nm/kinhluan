<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminCarts.aspx.cs" Inherits="CanhCam.Web.ProductUI.AdminCartsPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" >
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:ProductResources, CartAdminTitle %>" CurrentPageUrl="~/Product/AdminCarts.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <asp:UpdatePanel ID="up" runat="server">
            <ContentTemplate>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="headInfo form-horizontal">
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblCartType" ForControl="ddlCartType" CssClass="settinglabel control-label col-sm-3" ConfigKey="CartTypeLabel" ResourceFile="ProductResources" runat="server" />
                        <div class="col-sm-9">
                            <asp:DropDownList ID="ddlCartType" AutoPostBack="true" runat="server">
                                <asp:ListItem Value="1" Text="<%$Resources:ProductResources, CartTypeShoppingCart %>"></asp:ListItem>
                                <asp:ListItem Value="2" Text="<%$Resources:ProductResources, CartTypeWishlist %>"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <div class="row">
                            <div class="col-sm-3">
                                <asp:Button SkinID="DefaultButton" ID="btnDelete" Text="<%$Resources:Resource, DeleteSelectedButton %>"
                                    runat="server" CausesValidation="false" />
                                <asp:Button SkinID="DefaultButton" ID="btnClear" Text="<%$Resources:ProductResources, CartAdminDeleteOlderThan %>"
                                    runat="server" CausesValidation="false" />
                            </div>
                            <div class="col-sm-9">
                                <div class="input-group">
                                    
                                    <asp:TextBox ID="txtOlderDays" Text="90" MaxLength="4" runat="server" />
                                    <div class="input-group-addon">
                                        <asp:Literal ID="litDays" Text="<%$Resources:ProductResources, CartAdminDaysLabel %>" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="Guid" AllowPaging="false" AllowSorting="false">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, CartAdminProduct %>">
                                    <ItemTemplate>
                                        <%# GetProductUrl(Eval("ProductUrl").ToString(), Convert.ToInt32(Eval("ProductId")), Convert.ToInt32(Eval("ZoneId")), Eval("ProductTitle").ToString()) %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, CartAdminUserName %>">
                                    <ItemTemplate>
                                        <%# GetCustomerName(Convert.ToInt32(Eval("UserId")), Eval("CreatedByName").ToString(), Eval("UserGuid").ToString()) %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:ProductResources, CartAdminQuantity %>" DataField="Quantity" />
                                <telerik:GridBoundColumn HeaderText="<%$Resources:ProductResources, CartAdminIPAddress %>" DataField="CreatedFromIP" />
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, CartAdminCreatedDate %>">
                                    <ItemTemplate>
                                        <%# DateTimeHelper.Format(Convert.ToDateTime(Eval("CreatedUtc")), timeZone, "g", timeOffset)%>
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
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" 
    runat="server" >
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" 
    runat="server" >
</asp:Content>

