<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ServerInformation.aspx.cs" Inherits="CanhCam.Web.AdminUI.ServerInformation" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, AdminMenuServerInfoLabel %>" CurrentPageUrl="~/AdminCP/ServerInformation.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="headInfo">
            <div class="form-horizontal">
                <div class="settingrow form-group">
                    <label class="settinglabel control-label col-sm-3">
                        Flyingfish
                    </label>
                    <div class="col-sm-9">
                        <p class="form-control-static">
                            <asp:Literal ID="litCodeVersion" runat="server" />
                            <asp:Literal ID="litPlatform" runat="server" />
                        </p>
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="SiteLabel5" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="OperatingSystemLabel" />
                    <div class="col-sm-9">
                        <p class="form-control-static">
                            <asp:Literal ID="litOperatingSystem" runat="server" />
                        </p>
                    </div>
                </div>
                <div class="settingrow form-group" id="divDotNetVersion" runat="server">
                    <gb:SiteLabel ID="SiteLabel7" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="DotNetVersionLabel" />
                    <div class="col-sm-9">
                        <p class="form-control-static">
                            <asp:Literal ID="litDotNetVersion" runat="server" />
                        </p>
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="SiteLabel3" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="AdminMenuServerTimeZoneLabel" />
                    <div class="col-sm-9">
                        <p class="form-control-static">
                            <asp:Literal ID="litServerTimeZone" runat="server" />
                        </p>
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="SiteLabel2" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="AdminMenuServerLocalTimeLabel" />
                    <div class="col-sm-9">
                        <p class="form-control-static">
                            (<gb:SiteLabel ID="SiteLabel4" runat="server" ConfigKey="GMT" UseLabelTag="false" />
                            <asp:Literal ID="litServerGMTOffset" runat="server" />)
                            <asp:Literal ID="litServerLocalTime" runat="server" />
                        </p>
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="SiteLabel6" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="AdminMenuServerCurrentGMTTimeLabel" />
                    <div class="col-sm-9">
                        <p class="form-control-static">
                            <asp:Literal ID="litCurrentGMT" runat="server" />
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <asp:Panel ID="pnlFeatureVersions" runat="server" CssClass="workplace">
            <portal:HeadingControl ID="subHeading" HeadingTag="h4" runat="server" />
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="ApplicationID" AllowPaging="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, Feature %>" DataField="ApplicationName" AllowSorting="false" />
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, SchemaVersion %>">
                            <ItemTemplate>
                                <%# Eval("Major") %>.<%# Eval("Minor") %>.<%# Eval("Build") %>.<%# Eval("Revision") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </asp:Panel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
