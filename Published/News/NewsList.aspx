<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="NewsList.aspx.cs" Inherits="CanhCam.Web.NewsUI.NewsListPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:NewsResources, NewsList %>" CurrentPageUrl="~/News/NewsList.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:NewsResources, NewsListUpdateButton %>"
                runat="server" />
            <asp:HyperLink SkinID="InsertButton" ID="lnkInsert" Text="<%$Resources:NewsResources, NewsInsertLabel %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:NewsResources, NewsListDeleteSelectedButton %>"
                runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <asp:Panel ID="pnlSearch" DefaultButton="btnSearch" CssClass="headInfo" runat="server">
            <div class="row">
                <div class="col-md-5">
                    <div class="form-horizontal">
                        <div class="settingrow form-group hidden">
                            <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                                ForControl="ddZones" CssClass="control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:DropDownList ID="ddZones" AutoPostBack="false" runat="server" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblType" runat="server" ConfigKey="NewsType"
                                ResourceFile="NewsResources" ForControl="ddlNewsType" CssClass="control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:DropDownList ID="ddlNewsType" AppendDataBoundItems="true" AutoPostBack="false" DataTextField="Name" DataValueField="NewsTypeID" runat="server" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblAuthor" runat="server" ConfigKey="AuthorLabel"
                                ResourceFile="NewsResources" ForControl="ddlAuthor" CssClass="control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:DropDownList ID="ddlAuthor" AppendDataBoundItems="true" AutoPostBack="false" DataTextField="Name" DataValueField="AuthorID" runat="server" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblStatus" runat="server" ConfigKey="NewsListFilterStatusLabel" ResourceFile="NewsResources"
                                ForControl="Status" CssClass="control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:DropDownList ID="ddlStatus" runat="server">
                                    <asp:ListItem Value="-1">Tất cả</asp:ListItem>
                                    <asp:ListItem Value="0">Chưa duyệt</asp:ListItem>
                                    <asp:ListItem Value="1">Duyệt</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                    <div class="form-horizontal">
                        <div id="divStates" visible="false" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="lblStatusFilter" runat="server" ConfigKey="NewsListFilterStatusLabel"
                                ResourceFile="NewsResources" ForControl="ddStatus" CssClass="control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:DropDownList ID="ddStates" AppendDataBoundItems="true" DataTextField="StateName" DataValueField="StateId" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblStartDate" runat="server" ConfigKey="NewsEditStartDateLabel"
                                ResourceFile="NewsResources" ForControl="dpStartDate" CssClass="control-label col-sm-3" />
                            <div class="col-sm-9">
                                <gb:DatePickerControl ID="dpStartDate" runat="server" SkinID="news"></gb:DatePickerControl>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblEndDate" runat="server" ConfigKey="EndDate" ResourceFile="NewsResources"
                                ForControl="dpEndDate" CssClass="control-label col-sm-3" />
                            <div class="col-sm-9">
                                <gb:DatePickerControl ID="dpEndDate" runat="server" SkinID="news"></gb:DatePickerControl>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblTitle" runat="server" ConfigKey="NewsListFilterTitleLabel"
                                ResourceFile="NewsResources" ForControl="txtTitle" CssClass="control-label col-sm-3" />
                            <div class="col-sm-9">
                                <div class="form-inline">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <asp:TextBox ID="txtTitle" runat="server" MaxLength="255" />
                                        </div>
                                        <div class="form-group">
                                            <asp:Button SkinID="DefaultButton" ID="btnSearch" Text="<%$Resources:NewsResources, NewsListSearchButton %>"
                                                runat="server" CausesValidation="false" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="NewsID,ZoneID,StateId,IsPublished,UserGuid,LastModUserGuid,DisplayOrder,Viewed">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsEditTitleLabel %>"
                            DataField="Title" UniqueName="Title" SortExpression="Title" CurrentFilterFunction="Contains"
                            AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                            <ItemTemplate>
                                <%--<asp:HyperLink ID="Title" runat="server" Text='<%# Eval("Title").ToString() %>'
                                    NavigateUrl='<%# CanhCam.Web.NewsUI.NewsHelper.FormatNewsUrl(Eval("Url").ToString(), Convert.ToInt32(Eval("NewsID")), Convert.ToInt32(Eval("ZoneID")))  %>'>
                                </asp:HyperLink>--%>
                                <asp:HyperLink ID="Title" runat="server" Text='<%# Eval("Title").ToString() %>' 
                                    NavigateUrl='<%# SiteRoot + "/news-detail?newsID=" + Eval("NewsID") %>'></asp:HyperLink>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <%-- <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsEditDisplayOrderLabel %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox"
                                    MaxLength="4" Text='<%# Eval("DisplayOrder") %>' runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsEditViewedLabel %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <%# Eval("Viewed") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsEditShareCountLabel %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <%# Eval("ShareCount") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsEditLikeCountLabel %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <%# Eval("LikeCount") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsCommentCountLabel %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <%# Eval("CommentCount") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <%-- <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsManagePublishedDate %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <%# FormatDate(Eval("StartDate")) %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, IsPublishedLabel %>">
                            <ItemTemplate>
                                <asp:CheckBox ID="cbPublished" runat="server" Checked='<%# Eval("IsPublished") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, CreatedByLabel %>"
                            AllowFiltering="false" UniqueName="WorkflowCreatedBy">
                            <ItemTemplate>
                                <%# Eval("CreatedByName") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, WorkflowStateLable %>"
                            AllowFiltering="false" UniqueName="WorkflowState">
                            <ItemTemplate>
                                <asp:Literal ID="litWorkflowStatus" runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="WorkflowAction">
                            <ItemTemplate>
                                <asp:ImageButton ID="ibApproveContent" OnCommand="ibApproveContent_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleApproveContentLink" Visible="false" runat="server" />
                                <asp:HyperLink ID="lnkRejectContent" Visible="false" runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server"
                                    Visible='<%# CanEditNews(Convert.ToInt32(Eval("UserID")), Convert.ToBoolean(Eval("IsPublished")), Eval("StateId")) %>'
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
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
