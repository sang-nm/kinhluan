<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminGeoZoneBulk.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdminGeoZoneBulkPage" %>

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
            <asp:HyperLink CssClass="btn btn-link" ID="lnkGridView" Text="<%$Resources:Resource, GridViewToggleLink %>" runat="server" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="mrb10">
            <div class="row">
                <div class="col-sm-5">
                    <asp:DropDownList ID="ddCountry" CssClass="form-control" runat="server" DataTextField="Name" DataValueField="Guid" AutoPostBack="true" />
                </div>
            </div>
        </div>
        <div class="workplace">
            <asp:Repeater ID="rpt" OnItemDataBound="rpt_ItemDataBound" runat="server">
                <HeaderTemplate>
                    <div class="form-horizontal">
                        <div class="row">
                </HeaderTemplate>
                <FooterTemplate>
                        </div>
                    </div>
                </FooterTemplate>
                <ItemTemplate>
                    <div class="col-sm-6">
                        <div class="bulkzone">
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" CssClass="control-label col-sm-3"
                                        ConfigKey="GeoZoneGridZoneHeader" />
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtName" MaxLength="255" CssClass="form-control" Text='<%# Eval("Name") %>' runat="server" />
                                    <asp:HiddenField ID="hdnDataKeyValue" runat="server" Value='<%#Eval("Guid") %>' />
                                </div>
                            </div>
                            <%if (WebConfigSettings.AllowMultiLanguage)
                            { %>
                                <asp:Repeater ID="rptLanguages" OnItemDataBound="rptLanguages_ItemDataBound" runat="server">
                                    <ItemTemplate>
                                        <div class="settingrow form-group">
                                            <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" CssClass="control-label col-sm-3"
                                                    Text='<%#Eval("Name")%>' />
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="txtName" MaxLength="255" CssClass="form-control" runat="server" />
                                                <asp:HiddenField ID="hdnLanguageId" runat="server" Value='<%#Eval("LanguageId") %>' />
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            <% }%>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblCode" runat="server" ForControl="txtCode" CssClass="control-label col-sm-3"
                                        ConfigKey="GeoZoneGridCodeHeader" />
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtCode" MaxLength="255" CssClass="form-control" Width="75" Text='<%# Eval("Code") %>' runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblDisplayOrder" runat="server" ForControl="txtDisplayOrder" CssClass="control-label col-sm-3"
                                        ConfigKey="CountryGridDisplayOrderHeader" />
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" CssClass="form-control" MaxLength="4"
                                        Text='<%# Eval("DisplayOrder") %>' runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblIsPublished" runat="server" ForControl="chbIsPublished" CssClass="control-label col-sm-3"
                                        ConfigKey="CountryGridIsPublishedHeader" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chbIsPublished" Checked='<%# Eval("IsPublished") %>' runat="server" />
                                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server"
                                            OnCommand="btnDelete_Command" CommandArgument='<%# Eval("Guid").ToString() %>'
                                            Text="<%$Resources:Resource, CountryGridDeleteButton %>" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <portal:gbCutePager ID="pgrGeoZone" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />