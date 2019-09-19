<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminMenu.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdminMenuPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, AdminMenuLink %>" CurrentPageUrl="~/AdminCP/AdminMenu.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:HyperLink ID="lnkInsert"  SkinID="InsertButton" Text="<%$Resources:Resource, InsertLink %>" runat="server" />
                    <asp:Button ID="btnUpdate" SkinID="UpdateButton" Text="<%$Resources:Resource, UpdateButton %>" runat="server" />
                    <asp:Button ID="btnDelete" SkinID="DeleteButton" Text="<%$Resources:Resource, DeleteSelectedButton %>" runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="MenuID,DisplayOrder,IsVisible,ResourceFile,KeyName" AllowFilteringByColumn="true">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, AdminMenuName %>" DataField="Name" 
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                    <ItemTemplate>
                                        <%#Eval("DepthIndicator")%>
                                        <%#Eval("Name")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, AdminMenuUrlLabel %>" DataField="Url" 
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%" />
                                <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:Resource, AdminMenuIsVisibleLabel %>" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsVisible" Checked='<%# Convert.ToBoolean(Eval("IsVisible")) %>' runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:Resource, DisplayOrderLabel %>" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox"
                                            MaxLength="4" Text='<%# Eval("DisplayOrder") %>' runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="50" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:HyperLink CssClass="cp-link" ID="lnkEdit" runat="server" 
                                            Text="<%$Resources:Resource, EditLink %>" NavigateUrl='<%# SiteRoot + "/AdminCP/AdminMenuEdit.aspx?MenuID=" + Eval("MenuID") %>'>
                                        </asp:HyperLink>
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
