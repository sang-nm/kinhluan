<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminGeoZone.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdminGeoZonePage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, GeoZoneAdministrationLink %>" CurrentPageUrl="~/AdminCP/AdminGeoZone.aspx"
        ParentTitle="<%$Resources:Resource, CountryAdministrationLink %>" ParentUrl="~/AdminCP/AdminCountry.aspx"
        RootTitle="<%$Resources:Resource, CoreDataAdministrationLink %>" RootUrl="~/AdminCP/CoreData.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="InsertButton" ID="btnAddNew" Text="<%$Resources:Resource, GeoZoneGridAddNewButton %>" runat="server" />
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, GeoZoneGridUpdateButton %>" runat="server" CausesValidation="false" />
            <asp:Button SkinID="CancelButton" ID="btnCancel" Visible="false" Text="<%$Resources:Resource, GeoZoneGridCancelButton %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:Resource, DeleteSelectedButton %>" runat="server" CausesValidation="false" />
            <asp:HyperLink CssClass="btn btn-link" ID="lnkBulkUpdate" Text="<%$Resources:Resource, ListViewToggleLink %>" runat="server" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="headInfo">
            <div class="row">
                <div class="col-sm-5">
                    <asp:DropDownList ID="ddCountry" CssClass="form-control" runat="server" DataTextField="Name" DataValueField="Guid" AutoPostBack="true" />
                </div>
            </div>
        </div>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="Guid,Name,IsPublished,DisplayOrder,Code">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, GeoZoneGridZoneHeader %>">
                            <ItemTemplate>
                                <asp:TextBox ID="txtName" CssClass="input-grid"
                                    MaxLength="255" Text='<%# Eval("Name") %>' runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, GeoZoneGridCodeHeader %>">
                            <ItemTemplate>
                                <asp:TextBox ID="txtCode" CssClass="input-grid"
                                    MaxLength="255" Width="75" Text='<%# Eval("Code") %>' runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, CountryGridDisplayOrderHeader %>">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox"
                                    MaxLength="4" Text='<%# Eval("DisplayOrder") %>' runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, CountryGridIsPublishedHeader %>">
                            <ItemTemplate>
                                <asp:CheckBox ID="chbIsPublished" Checked='<%# Eval("IsPublished") %>' runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="EditLink" Visible='<%#new Guid(Eval("Guid").ToString()) != Guid.Empty %>' runat="server" Text="<%# Resources.Resource.GeoZoneChildAdministration %>" 
                                    NavigateUrl='<%# SiteRoot + "/AdminCP/AdminGeoZone.aspx?country=" + countryGuid.ToString() + "&amp;parent=" + DataBinder.Eval(Container.DataItem,"Guid") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <portal:gbCutePager ID="pgrGeoZone" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />