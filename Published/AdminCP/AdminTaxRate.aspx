<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminTaxRate.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdminTaxRatePage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, TaxRateAdminLink %>" CurrentPageUrl="~/AdminCP/AdminTaxRate.aspx"
        ParentTitle="<%$Resources:Resource, CoreDataAdministrationLink %>" ParentUrl="~/AdminCP/CoreData.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button  SkinID="InsertButton" ID="btnAddNew" runat="server" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="headInfo form-horizontal">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblCountry" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="TaxRateGridCountryHeader" />
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddCountry" runat="server" DataValueField="Guid" DataTextField="Name" AutoPostBack="true" />
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblGeoZone" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="TaxRateGridGeoZoneHeader" />
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddGeoZones" runat="server" DataValueField="Guid" DataTextField="Name" AutoPostBack="true" />
                </div>
            </div>
        </div>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="Guid" EditMode="InPlace" AllowPaging="false" AllowSorting="false">
                    <Columns>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <%# Eval("Description") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="settingrow">
                                    <gb:SiteLabel ID="lblDescription" runat="server" CssClass="settinglabel" ConfigKey="TaxRateGridDescriptionHeader"
                                        ResourceFile="Resource" />
                                    <asp:TextBox ID="txtDescription" Columns="20" Text='<%# Eval("Description") %>' runat="server"
                                        MaxLength="255" CssClass="forminput" />
                                </div>
                                <div class="settingrow">
                                    <gb:SiteLabel ID="lblTaxClass" runat="server" CssClass="settinglabel" ConfigKey="TaxRateGridTaxClassHeader"
                                        ResourceFile="Resource" />
                                    <asp:DropDownList ID="ddTaxClass" runat="server" DataValueField="Guid" DataTextField="Title"
                                        CssClass="forminput" />
                                </div>
                                <div class="settingrow">
                                    <gb:SiteLabel ID="lblPriority" runat="server" CssClass="settinglabel" ConfigKey="TaxRateGridPriorityHeader"
                                        ResourceFile="Resource" />
                                    <asp:TextBox ID="txtPriority" Columns="20" Text='<%# Eval("Priority") %>' runat="server"
                                        MaxLength="4" CssClass="forminput" />
                                </div>
                                <div class="settingrow">
                                    <gb:SiteLabel ID="lblRate" runat="server" CssClass="settinglabel" ConfigKey="TaxRateGridRateHeader"
                                        ResourceFile="Resource" />
                                    <asp:TextBox ID="txtRate" Columns="20" Text='<%# Eval("Rate") %>' runat="server"
                                        MaxLength="9" CssClass="forminput" />
                                </div>
                                <div class="settingrow">
                                    <label class="settinglabel"></label>
                                    <asp:Button ID="btnGridUpdate" SkinID="UpdateButton" runat="server" Text='<%# Resources.Resource.TaxRateGridUpdateButton %>'
                                        CommandName="Update" />
                                    <asp:Button ID="btnGridCancel" SkinID="CancelButton" runat="server" Text='<%# Resources.Resource.TaxRateGridCancelButton %>'
                                        CommandName="Cancel" />
                                    <asp:Button ID="btnGridDelete" SkinID="DeleteButton" runat="server" Text='<%# Resources.Resource.TaxRateGridDeleteButton %>'
                                        CommandName="Delete" />
                                </div>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <%# Eval("Rate") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="100">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CommandName="Edit" SkinID="EditButton"
                                    Text='<%# Resources.Resource.TaxRateGridEditButton %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
