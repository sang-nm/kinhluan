<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="PageManager.aspx.cs" Inherits="CanhCam.Web.AdminUI.PageManager" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" >
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, PageManagerHeading %>" CurrentPageUrl="~/AdminCP/PageManager.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <a class="btn btn-default" id="lnkNewPage" runat="server"></a>
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:Resource, DeleteSelectedButton %>"
                        runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />                
                <div class="workplace">
                    <div class="input-group">
                        <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                            <MasterTableView DataKeyNames="PageID,PageOrder,PageName" AllowPaging="false">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                                        <ItemTemplate>
                                            <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, PageSettingsPageNameLabel %>" DataField="PageName" />
                                    <telerik:GridTemplateColumn HeaderStyle-Width="150">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="lnkEditContent" CssClass="cp-link" EnableViewState="false" runat="server"
                                                NavigateUrl='<%# SiteRoot + "/AdminCP/PageLayout.aspx?pageid=" + Eval("PageID") %>'
                                                Text="<%$Resources:Resource, AddFeaturesToPageLink %>" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderStyle-Width="50">
                                        <ItemTemplate>
                                            <asp:HyperLink CssClass="cp-link" ID="PagesEditSettings" runat="server"
                                                Text="<%$Resources:Resource, EditLink %>" NavigateUrl='<%# SiteRoot + "/AdminCP/PageSettings.aspx?pageid=" + Eval("PageID") %>'>
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
                            </ul>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" 
    runat="server" >
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" 
    runat="server" >
</asp:Content>

