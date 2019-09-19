<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminCurrency.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdminCurrencyPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, CurrencyAdministrationLink %>" CurrentPageUrl="~/AdminCP/AdminCurrency.aspx"
        ParentTitle="<%$Resources:Resource, CoreDataAdministrationLink %>" ParentUrl="~/AdminCP/CoreData.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="InsertButton" ID="btnAddNew" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, CurrencyDeleteSelectedButton %>" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="Guid,Title" EditMode="InPlace">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>">
                                    <ItemTemplate>
                                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, CurrencyGridTitleHeading %>">
                                    <ItemTemplate>
                                        <%# Eval("Title") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <div class="form-horizontal">
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="lblTitle" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="CurrencyGridTitleHeading"
                                                    ResourceFile="Resource" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtTitle" Columns="20" Text='<%# Eval("Title") %>' runat="server"
                                                        MaxLength="50" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="lblCode" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="CurrencyGridCodeHeading"
                                                    ResourceFile="Resource" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtCode" Columns="20" Text='<%# Eval("Code") %>' runat="server"
                                                        MaxLength="3" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="lblValue" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="CurrencyGridValueHeading"
                                                    ResourceFile="Resource" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtValue" Columns="20" Text='<%# Convert.ToDouble(Eval("Value")) %>' runat="server"
                                                        MaxLength="20" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="lblSymbolLeft" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="CurrencyGridSymbolLeftHeading"
                                                    ResourceFile="Resource" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtSymbolLeft" Columns="20" Text='<%# Eval("SymbolLeft") %>' runat="server"
                                                        MaxLength="15" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="lblSymbolRight" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="CurrencyGridSymbolRightHeading"
                                                    ResourceFile="Resource" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtSymbolRight" Columns="20" Text='<%# Eval("SymbolRight") %>' runat="server"
                                                        MaxLength="15" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <div class="col-sm-offset-3 col-sm-9">
                                                    <asp:Button SkinID="UpdateButton" ID="btnGridUpdate" runat="server" Text='<%# Resources.Resource.CurrencyGridUpdateButton %>'
                                                        CommandName="Update" />
                                                    <asp:Button SkinID="CancelButton" ID="btnGridCancel" runat="server" Text='<%# Resources.Resource.CurrencyGridCancelButton %>'
                                                        CommandName="Cancel" />
                                                </div>
                                            </div>
                                        </div>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, CurrencyGridValueHeading %>">
                                    <ItemTemplate>
                                        <%# Convert.ToDouble(Eval("Value")) %>
                                    </ItemTemplate>
                                    <EditItemTemplate></EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="80">
                                    <ItemTemplate>
                                        <asp:Button ID="btnEditCurrency" runat="server" CommandName="Edit" SkinID="EditButton"
                                            Text='<%# Resources.Resource.CurrencyGridEditButton %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                            
                                    </EditItemTemplate>
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
