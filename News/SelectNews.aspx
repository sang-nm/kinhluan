<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="SelectNews.aspx.cs" Inherits="CanhCam.Web.NewsUI.SelectNews" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:HeadingControl ID="heading" runat="server" />
    <div class="wrap01">
        <gb:SiteLabel ID="lblModule" runat="server" ConfigKey="SelectNewsPageFilterLabel"
            ResourceFile="NewsResources" ForControl="ddPages" />
        <asp:DropDownList ID="ddPages" AutoPostBack="true" runat="server" DataTextField="PageName"
            DataValueField="PageID" />
        <asp:HyperLink ID="lnkCancel" runat="server" CssClass="cp-link" />
    </div>
    <div class="wrap01 left" style="width: 48%">
        <div class="cp-gridwrap">
            <div class="cp-outerwrap">
                <div class="cp-innerwrap">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="NewsID" AllowFilteringByColumn="true">
                            <Columns>
                                <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:NewsResources, RowNumber %>"
                                    AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, NewsEditTitleLabel %>"
                                    DataField="Title" UniqueName="Title" SortExpression="Title" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Title" CssClass="cp-link" runat="server" Text='<%# Eval("Title").ToString() %>'
                                            NavigateUrl='<%# FormatNewsUrl(Eval("Url").ToString(), Convert.ToInt32(Eval("NewsID")))  %>'></asp:HyperLink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:NewsResources, NewsManagePublishedDate %>"
                                    AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# FormatDate(Eval("StartDate")) %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, NewsManageCreatedBy %>"
                                    AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# Eval("CreatedByName")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%"
                                    UniqueName="ClientSelectColumn">
                                </telerik:GridClientSelectColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </div>
    <div class="left wrap01 prefix_1 suffix_1">
        <asp:Button CssClass="form-button" Text="&raquo;" Font-Bold="true" runat="server" ID="btnSelect" />
        <div class="wrap01">
        </div>
        <asp:Button CssClass="form-button" Text="&laquo;" runat="server" ID="btnDelete" />
    </div>
    <div class="wrap01 left" style="width: 48%">
        <div class="cp-gridwrap">
            <div class="cp-outerwrap">
                <div class="cp-innerwrap">
                    <telerik:RadGrid ID="gridSelected" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="NewsID" AllowFilteringByColumn="true" AllowPaging="false">
                            <Columns>
                                <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:NewsResources, RowNumber %>"
                                    AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# (gridSelected.PageSize * gridSelected.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, NewsEditTitleLabel %>"
                                    DataField="Title" UniqueName="Title" SortExpression="Title" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="Title" CssClass="cp-link" runat="server" Text='<%# Eval("Title").ToString() %>'
                                            NavigateUrl='<%# FormatNewsUrl(Eval("Url").ToString(), Convert.ToInt32(Eval("NewsID")))  %>'></asp:HyperLink>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:NewsResources, NewsManagePublishedDate %>"
                                    AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# FormatDate(Eval("StartDate")) %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, NewsManageCreatedBy %>"
                                    AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# Eval("CreatedByName")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%"
                                    UniqueName="ClientSelectColumn">
                                </telerik:GridClientSelectColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </div>
    <div class="clear">
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
