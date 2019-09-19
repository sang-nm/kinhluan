<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="BannedIPAddresses.aspx.cs" Inherits="CanhCam.Web.AdminUI.BannedIPAddressesPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, AdminMenuBannedIPAddressesLabel %>" CurrentPageUrl="~/AdminCP/BannedIPAddresses.aspx"
        ParentTitle="<%$Resources:Resource, AdvancedToolsLink %>" ParentUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="InsertButton" ID="btnAddNew" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, BannedIPAddressesDeleteSelectedButton %>" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <asp:Panel ID="pnlBannedIPAddresses" runat="server" DefaultButton="btnAddNew">
                    <asp:Panel ID="pnlLookup" runat="server" CssClass="headInfo" DefaultButton="btnIPLookup">
                        <div class="input-group">
                            <asp:TextBox ID="txtIPAddress" CssClass="form-control" runat="server" MaxLength="50" />
                            <div class="input-group-btn">
                                <asp:Button SkinID="SearchButton" ID="btnIPLookup" runat="server" />
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="workplace">
                        <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                            <MasterTableView DataKeyNames="RowID,BannedIP" EditMode="InPlace">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>">
                                        <ItemTemplate>
                                            <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, BannedIPAddressLabel %>">
                                        <ItemTemplate>
                                            <%# Eval("BannedIP") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtBannedIP" Columns="20" Text='<%# Eval("BannedIP") %>' runat="server"
                                                MaxLength="50" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, BannedIPAddressReasonLabel %>">
                                        <ItemTemplate>
                                            <%# Eval("BannedReason") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtBannedReason" Columns="20" Text='<%# Eval("BannedReason") %>'
                                                runat="server" MaxLength="255" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, BannedIPAddressUTCLabel %>">
                                        <ItemTemplate>
                                            <%# DateTimeHelper.Format(Convert.ToDateTime(Eval("BannedUTC")), timeZone, "g", timeOffset)%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtBannedUtc" Columns="20" Text='<%# DateTimeHelper.Format(Convert.ToDateTime(Eval("BannedUTC")), timeZone, "g", timeOffset) %>'
                                                runat="server" MaxLength="30" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn>
                                        <ItemTemplate>
                                            <asp:Button ID="btnEdit" SkinID="EditButton" runat="server" CommandName="Edit" CssClass="link-button"
                                                Text='<%# Resources.Resource.BannedIPAddressesGridEditButton %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Button ID="btnGridUpdate" SkinID="UpdateButton" runat="server" Text='<%# Resources.Resource.BannedIPAddressesGridUpdateButton %>'
                                                CommandName="Update" />
                                            <asp:Button ID="btnGridCancel" SkinID="CancelButton" runat="server" Text='<%# Resources.Resource.BannedIPAddressesGridCancelButton %>'
                                                CommandName="Cancel" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
