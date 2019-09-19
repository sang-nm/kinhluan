<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="NewsSpecial.aspx.cs" Inherits="CanhCam.Web.NewsUI.NewsSpecialPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:NewsResources, NewsSpecialTilte %>" CurrentPageUrl="~/News/NewsSpecial.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-horizontal">
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                                        ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                                    <div class="col-sm-9">
                                        <asp:DropDownList ID="ddZones" Width="100%" runat="server" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblTitle" runat="server" ConfigKey="NewsListFilterTitleLabel"
                                        ResourceFile="NewsResources" ForControl="txtTitle" CssClass="settinglabel control-label col-sm-3" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtTitle" runat="server" MaxLength="255" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <div class="col-sm-offset-3 col-sm-9">
                                        <asp:Button SkinID="DefaultButton" ID="btnSearch" Text="<%$Resources:NewsResources, NewsListSearchButton %>"
                                            runat="server" CausesValidation="false" />
                                    </div>
                                </div>
                            </div>
                            <telerik:RadGrid ID="grid1" SkinID="radGridSkin" runat="server">
                                <MasterTableView DataKeyNames="NewsID,Position">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                                            <ItemTemplate>
                                                <%# (grid1.PageSize * grid1.CurrentPageIndex) + Container.ItemIndex + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsEditTitleLabel %>"
                                            DataField="Title" UniqueName="Title" SortExpression="Title" CurrentFilterFunction="Contains"
                                            AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                            <ItemTemplate>
                                                <asp:HyperLink CssClass="cp-link" ID="Title" runat="server" Text='<%# Eval("Title").ToString() %>'
                                                    NavigateUrl='<%# CanhCam.Web.NewsUI.NewsHelper.FormatNewsUrl(Eval("Url").ToString(), Convert.ToInt32(Eval("NewsID")), Convert.ToInt32(Eval("ZoneID")))  %>'>
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="100" >
                                            <ItemTemplate>
                                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" 
                                                    Text="<%$Resources:NewsResources, NewsEditLink %>" NavigateUrl='<%# SiteRoot + "/News/NewsEdit.aspx?NewsID=" + Eval("NewsID") %>'>
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                        <div class="col-md-1 text-center mrt150">
                            <asp:LinkButton ID="btnLeft" runat="server" CssClass="btnleft"><i class="fa fa-arrow-left text-16px"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnRight" runat="server" CssClass="btnright"><i class="fa fa-arrow-right text-16px"></i></asp:LinkButton>
                        </div>
                        <div class="col-md-5 mrt80">
                            <div class="form-horizontal">
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblPosition" runat="server" ForControl="ddlPosition" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="NewsPositionLabel" ResourceFile="NewsResources" />
                                    <div class="col-sm-9">
                                        <asp:DropDownList ID="ddlPosition" AutoPostBack="true" runat="server" DataTextField="Name" DataValueField="Value" />
                                    </div>
                                </div>
                            </div>
                            <telerik:RadGrid ID="grid2" SkinID="radGridSkin" runat="server">
                                <MasterTableView DataKeyNames="NewsID,Position">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                                            <ItemTemplate>
                                                <%# (grid2.PageSize * grid2.CurrentPageIndex) + Container.ItemIndex + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsEditTitleLabel %>"
                                            DataField="Title" UniqueName="Title" SortExpression="Title" CurrentFilterFunction="Contains"
                                            AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                            <ItemTemplate>
                                                <asp:HyperLink CssClass="cp-link" ID="Title" runat="server" Text='<%# Eval("Title").ToString() %>'
                                                    NavigateUrl='<%# CanhCam.Web.NewsUI.NewsHelper.FormatNewsUrl(Eval("Url").ToString(), Convert.ToInt32(Eval("NewsID")), Convert.ToInt32(Eval("ZoneID")))  %>'>
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="100">
                                            <ItemTemplate>
                                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" 
                                                    Text="<%$Resources:NewsResources, NewsEditLink %>" NavigateUrl='<%# SiteRoot + "/News/NewsEdit.aspx?NewsID=" + Eval("NewsID") %>'>
                                                </asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />