<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ModuleAdmin.aspx.cs" Inherits="CanhCam.Web.AdminUI.ModuleAdminPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, AdminMenuFeatureModulesLink %>" CurrentPageUrl="~/AdminCP/ModuleAdmin.aspx"
        ParentTitle="<%$Resources:Resource, AdvancedToolsLink %>" ParentUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:HyperLink SkinID="InsertButton" ID="lnkNewModule" runat="server" NavigateUrl="~/AdminCP/ModuleDefinitions.aspx?defid=-1" />
        </portal:HeadingPanel>
		<portal:NotifyMessage ID="message" runat="server" />
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="ModuleDefID" AllowPaging="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, ModuleDefinitionsNameLabel %>">
                            <ItemTemplate>
                                <%# CanhCam.Web.Framework.ResourceHelper.GetResourceString(DataBinder.Eval(Container.DataItem, "ResourceFile").ToString(),DataBinder.Eval(Container.DataItem, "FeatureName").ToString()) %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="lnkEditLink" Visible='<%# isServerAdminSite %>' runat="server"
                                    Text='<%# Resources.Resource.ModuleAdminEditLink%>' ToolTip='<%# Resources.Resource.ModuleAdminEditLink %>'
                                    NavigateUrl='<%# SiteRoot + "/AdminCP/ModuleDefinitions.aspx?defid=" + DataBinder.Eval(Container.DataItem, "ModuleDefID") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="lnkSettings" runat="server" Visible='<%# isServerAdminSite %>'
                                    Text='<%# Resources.Resource.ModuleAdminSettingsLink %>' ToolTip='<%# Resources.Resource.ModuleAdminSettingsLink %>'
                                    NavigateUrl='<%# SiteRoot + "/AdminCP/ModuleDefinitionSettings.aspx?defid=" + DataBinder.Eval(Container.DataItem, "ModuleDefID") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="lnkPermissions" runat="server" Text='<%# Resources.Resource.FeaturePermissionsLink %>'
                                    ToolTip='<%# Resources.Resource.FeaturePermissionsLink %>' NavigateUrl='<%# SiteRoot + "/AdminCP/FeaturePermissions.aspx?defid=" + DataBinder.Eval(Container.DataItem, "ModuleDefID") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="lnkPermissionDefine" runat="server" Text='<%# Resources.Resource.FeaturePermissionDefineLink %>'
                                    ToolTip='<%# Resources.Resource.FeaturePermissionDefineLink %>' NavigateUrl='<%# SiteRoot + "/AdminCP/PermissionDefine.aspx?defid=" + DataBinder.Eval(Container.DataItem, "ModuleDefID") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
