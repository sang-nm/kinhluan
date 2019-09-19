<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminCountryBulk.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdminCountryBulkPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, CountryAdministrationLink %>" CurrentPageUrl="~/AdminCP/AdminCountryBulk.aspx"
        ParentTitle="<%$Resources:Resource, CoreDataAdministrationLink %>" ParentUrl="~/AdminCP/CoreData.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="InsertButton" ID="btnAddNew" Text="<%$Resources:Resource, CountryGridAddNewButton %>" runat="server" />
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, CountryGridUpdateButton %>" runat="server" CausesValidation="false" />
            <asp:Button SkinID="CancelButton" ID="btnCancel" Visible="false" Text="<%$Resources:Resource, CountryGridCancelButton %>" runat="server" />
            <asp:HyperLink SkinID="LinkButton" ID="lnkGridView" Text="<%$Resources:Resource, GridViewToggleLink %>" runat="server" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
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
                                        ConfigKey="CountryGridNameHeader" />
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
                                <gb:SiteLabel ID="lblISOCode2" runat="server" ForControl="txtISOCode2" CssClass="control-label col-sm-3"
                                        ConfigKey="CountryGridISOCode2Header" />
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtISOCode2" MaxLength="2" CssClass="form-control" Width="75" Text='<%# Eval("ISOCode2") %>' runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblISOCode3" runat="server" ForControl="txtISOCode3" CssClass="control-label col-sm-3"
                                        ConfigKey="CountryGridISOCode3Header" />
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtISOCode3" MaxLength="3" CssClass="form-control" Width="75" Text='<%# Eval("ISOCode3") %>' runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblDisplayOrder" runat="server" ForControl="txtDisplayOrder" CssClass="control-label col-sm-3"
                                        ConfigKey="CountryGridDisplayOrderHeader" />
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" CssClass="form-control" MaxLength="4" Text='<%# Eval("DisplayOrder") %>' runat="server" />
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
            <portal:gbCutePager ID="pgrCountry" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />