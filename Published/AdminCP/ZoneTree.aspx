<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ZoneTree.aspx.cs" Inherits="CanhCam.Web.AdminUI.ZoneTree" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" CurrentPageTitle="<%$Resources:Resource, ZoneStructureLink %>"
        CurrentPageUrl="~/AdminCP/ZoneTree.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <a id="lnkNewZone" class="btn btn-default btn-insert" runat="server"></a>
            <asp:Button ID="btnDelete" SkinID="DeleteButton" Text="<%$Resources:Resource, DeleteSelectedButton %>"
                runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="workplace">
            <div class="input-group">
                <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                    <MasterTableView DataKeyNames="ZoneID" AllowFilteringByColumn="true">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, ZoneNameLabel %>"
                                DataField="Title" UniqueName="Title" SortExpression="Title" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                <ItemTemplate>
                                    <%# Eval("DepthIndicator") %><%# Eval("Title") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="100" AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:HyperLink CssClass="cp-link" ID="ViewZone" runat="server" Text="<%$Resources:Resource, ZoneViewZoneLink %>"
                                        NavigateUrl='<%# FormatUrl(Eval("Url").ToString(), Eval("UrlExpand").ToString(), Convert.ToBoolean(Eval("IsClickable"))) %>'>
                                    </asp:HyperLink>
                                    <asp:HyperLink CssClass="cp-link" ID="ZonesEditSettings" runat="server" Text="<%$Resources:Resource, EditLink %>"
                                        NavigateUrl='<%# SiteRoot + "/AdminCP/ZoneSettings.aspx?zoneid=" + Eval("ZoneID") %>'>
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                <div class="input-group-addon">
                    <ul class="nav sorter">
                        <li><asp:LinkButton ID="btnTop" CommandName="top" runat="server"><i class="fa fa-angle-double-up"></i></asp:LinkButton></li>
                        <li><asp:LinkButton ID="btnUp" CommandName="up" runat="server"><i class="fa fa-angle-up"></i></asp:LinkButton></li>
                        <li><asp:LinkButton ID="btnDown" CommandName="down" runat="server"><i class="fa fa-angle-down"></i></asp:LinkButton></li>
                        <li><asp:LinkButton ID="btnBottom" CommandName="bottom" runat="server"><i class="fa fa-angle-double-down"></i></asp:LinkButton></li>
                        <li><asp:LinkButton ID="btnSortChildPagesAlpha" runat="server"><i class="fa fa-sort-alpha-asc"></i></asp:LinkButton></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server">
</asp:Content>