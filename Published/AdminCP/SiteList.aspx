<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="SiteList.aspx.cs" Inherits="CanhCam.Web.AdminUI.SiteListPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, SiteList %>" CurrentPageUrl="~/AdminCP/SiteList.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:HyperLink SkinID="InsertButton" ID="lnkNewSite" runat="server" />
        </portal:HeadingPanel>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView AllowPaging="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, SiteSettingsSiteTitleLabel %>">
                            <ItemTemplate>
                                <%# Eval("SiteName") %>
                                <asp:Label ID="lblSiteID" runat="server" CssClass="siteidlabel" Visible='<%# showSiteIDInSiteList %>'
                                    Text='<%# FormatSiteId(Convert.ToInt32(Eval("SiteID"))) %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <a class="cp-link" href='<%# SiteRoot + "/AdminCP/SiteSettings.aspx?SiteID=" + Eval("SiteID") %>'>
                                    <%# Resources.Resource.AdminMenuSiteSettingsLink %></a>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <a class="cp-link" href='<%# SiteRoot + "/AdminCP/PermissionsMenu.aspx?SiteID=" + Eval("SiteID") %>'>
                                        <%# Resources.Resource.SiteSettingsPermissionsTab%></a>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <portal:gbCutePager ID="pgr" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
