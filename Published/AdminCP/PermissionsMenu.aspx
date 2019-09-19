<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="PermissionsMenu.aspx.cs" Inherits="CanhCam.Web.AdminUI.PermissionsMenuPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, SiteSettingsPermissionsTab %>" CurrentPageUrl="~/AdminCP/PermissionsMenu.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="headInfo form-horizontal">
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblGroupName" runat="server" ForControl="ddlGroupName" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="PermissionGroupNameLabel" />
                        <div class="col-sm-9">
                            <asp:DropDownList ID="ddlGroupName" runat="server" />
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblRoles" runat="server" ForControl="ddlRoles" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="PermissionByRoleLabel" />
                        <div class="col-sm-9">
                            <asp:DropDownList ID="ddlRoles" AppendDataBoundItems="true" AutoPostBack="true"
                                DataTextField="DisplayName" DataValueField="RoleName" runat="server">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <div class="col-sm-offset-3 col-sm-9">
                            <asp:Button ID="btnSearch" SkinID="DefaultButton" Text="<%$Resources:Resource, SearchButton %>" runat="server" />
                            <asp:Button ID="btnUpdate" SkinID="DefaultButton" Text="<%$Resources:Resource, UpdateButton %>" Visible="false" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="KeyName,KeyValue,ResourceFile" AllowPaging="false">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>"
                                    AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, PermissionNameLabel %>">
                                    <ItemTemplate>
                                        <%# CanhCam.Web.Framework.ResourceHelper.GetResourceString(DataBinder.Eval(Container.DataItem, "ResourceFile").ToString(), DataBinder.Eval(Container.DataItem, "KeyName").ToString().Replace(".", ""))%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, PermissionGroupNameLabel %>">
                                    <ItemTemplate>
                                        <%# CanhCam.Web.Framework.ResourceHelper.GetResourceString(DataBinder.Eval(Container.DataItem, "ResourceFile").ToString(), DataBinder.Eval(Container.DataItem, "GroupName").ToString())%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, PermissionRoleAllowLabel %>">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkAllowed" Checked='<%#GetRoleChecked(DataBinder.Eval(Container.DataItem, "KeyValue").ToString())%>' runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, PermissionRolesAllowLabel %>">
                                    <ItemTemplate>
                                        <asp:Repeater ID="rptRoles" DataSource='<%#GetRoles(DataBinder.Eval(Container.DataItem, "KeyValue").ToString())%>' runat="server">
                                            <ItemTemplate>
                                                <div class="mrb0">
                                                    + <%# Eval("DisplayName")%>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="lnkChange" CssClass="cp-link" NavigateUrl='<%# SiteRoot + "/AdminCP/PermissionEdit.aspx?p=" + Eval("KeyName").ToString() + "&res=" + Eval("ResourceFile").ToString() + siteParam %>' Text="<%$Resources:Resource, PermissionChangeRolesLink %>" runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
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
