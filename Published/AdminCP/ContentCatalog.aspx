<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ContentCatalog.aspx.cs" Inherits="CanhCam.Web.AdminUI.ContentCatalogPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, AdminMenuContentManagerLink %>" CurrentPageUrl="~/AdminCP/ContentCatalog.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="headInfo form-horizontal">
            <asp:Panel ID="pnlNewContent" CssClass="settingrow form-group" runat="server" DefaultButton="btnCreateNewContent">
                <div class="col-sm-5"><asp:DropDownList ID="ddModuleType" CssClass="form-control" runat="server" DataValueField="ModuleDefID" DataTextField="FeatureName" /></div>
                <div class="col-sm-5"><asp:TextBox ID="txtModuleTitle" CssClass="form-control" runat="server" EnableViewState="false" /></div>
                <div class="col-sm-2"><asp:Button SkinID="InsertButton" ID="btnCreateNewContent" runat="server" /></div>
            </asp:Panel>
            <asp:Panel ID="pnlFind" CssClass="settingrow form-group" runat="server" DefaultButton="btnFind">
                <div class="col-sm-5">
                    <asp:TextBox ID="txtTitleFilter" placeholder="<%$Resources:Resource, ContentManagerTitleFilterLabel %>" CssClass="form-control" runat="server" MaxLength="255" />
                </div>
                <div class="col-sm-5">
                    <asp:Button SkinID="SearchButton" ID="btnFind" runat="server" />
                    <asp:CheckBox ID="chkFilterByFeature" runat="server" />
                </div>
            </asp:Panel>
        </div>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="ModuleID" AllowPaging="false" AllowSorting="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, ContentManagerContentTitleColumnHeader %>">
                            <ItemTemplate>
                                <%# Eval("ModuleTitle").ToString().Coalesce(Resources.Resource.ContentNoTitle)%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, ContentManagerFeatureTypeColumnHeader %>">
                            <ItemTemplate>
                                <%# CanhCam.Web.Framework.ResourceHelper.GetResourceString(DataBinder.Eval(Container.DataItem, "ResourceFile").ToString(),DataBinder.Eval(Container.DataItem, "FeatureName").ToString()) %>
                                (<%# Eval("UseCount") %>)
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, ContentManagerAuthorColumnHeader %>" DataField="CreatedBy" />
                        <telerik:GridTemplateColumn HeaderStyle-Width="100">
                            <ItemTemplate>
                                <a class="cp-link" href='<%# SiteRoot + "/AdminCP/ContentManagerPreview.aspx?mid=" + DataBinder.Eval(Container.DataItem,"ModuleID") %>'>
                                    <%# Resources.Resource.ContentManagerViewEditLabel %></a>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="150">
                            <ItemTemplate>
                                <a class="cp-link" href='<%# SiteRoot + "/AdminCP/ContentManager.aspx?mid=" + DataBinder.Eval(Container.DataItem,"ModuleID") %>'>
                                    <%# Resources.Resource.ContentManagerPublishDeleteLabel%></a>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <portal:gbCutePager ID="pgrContent" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
