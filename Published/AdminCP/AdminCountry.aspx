<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminCountry.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdminCountryPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, CountryAdministrationLink %>" CurrentPageUrl="~/AdminCP/AdminCountry.aspx"
        ParentTitle="<%$Resources:Resource, CoreDataAdministrationLink %>" ParentUrl="~/AdminCP/CoreData.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="InsertButton" ID="btnAddNew" Text="<%$Resources:Resource, CountryGridAddNewButton %>" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, CountryGridUpdateButton %>" runat="server" CausesValidation="false" />
                    <asp:Button SkinID="CancelButton" ID="btnCancel" Visible="false" Text="<%$Resources:Resource, CountryGridCancelButton %>" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:Resource, CountryGridDeleteSelectedButton %>" runat="server" CausesValidation="false" />
                    <asp:HyperLink SkinID="LinkButton" ID="lnkBulkUpdate" Text="<%$Resources:Resource, ListViewToggleLink %>" runat="server" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="Guid,Name,IsPublished,DisplayOrder,ISOCode2,ISOCode3" AllowFilteringByColumn="true">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, CountryGridNameHeader %>" DataField="Name" SortExpression="Name" 
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtName" CssClass="input-grid" MaxLength="255" Text='<%# Eval("Name") %>' runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" ID="txtName1" Text='<%# Bind("Name") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, CountryGridISOCode2Header %>" DataField="ISOCode2" SortExpression="ISOCode2" 
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtISOCode2" CssClass="input-grid"
                                            MaxLength="2" Width="75" Text='<%# Eval("ISOCode2") %>' runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, CountryGridISOCode3Header %>" DataField="ISOCode3" SortExpression="ISOCode3" 
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtISOCode3" CssClass="input-grid"
                                            MaxLength="3" Width="75" Text='<%# Eval("ISOCode3") %>' runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:Resource, CountryGridIsPublishedHeader %>" DataType="System.Boolean" DataField="IsPublished"
                                    AutoPostBackOnFilter="true" ShowFilterIcon="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chbIsPublished" Checked='<%# Eval("IsPublished") %>' runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:Resource, CountryGridDisplayOrderHeader %>" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox"
                                            MaxLength="4" Text='<%# Eval("DisplayOrder") %>' runat="server" />
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