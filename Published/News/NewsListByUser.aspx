<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="NewsListByUser.aspx.cs" Inherits="CanhCam.Web.NewsUI.NewsListByUser" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:HeadingControl ID="heading" runat="server" />
    <div class="settingrow">
        <gb:SiteLabel ID="lblStatusFilter" runat="server" ConfigKey="NewsListFilterStatusLabel"
            ResourceFile="NewsResources" ForControl="ddStatus" CssClass="settinglabel" />
        <asp:DropDownList ID="ddStatus" runat="server">
            <asp:ListItem Text="<%$Resources:NewsResources, NewsListStatusFilterAll %>" Value="All"></asp:ListItem>
            <asp:ListItem Text="<%$Resources:NewsResources, NewsListStatusFilterInProgress %>"
                Value="InProgress"></asp:ListItem>
            <asp:ListItem Text="<%$Resources:NewsResources, NewsListStatusFilterAwaitingApproval %>"
                Value="AwaitingApproval"></asp:ListItem>
            <asp:ListItem Text="<%$Resources:NewsResources, NewsListStatusFilterPublishedAll %>"
                Value="PublishedAll"></asp:ListItem>
            <asp:ListItem Text="<%$Resources:NewsResources, NewsListStatusFilterCancelled %>"
                Value="Cancelled"></asp:ListItem>
            <%--<asp:ListItem Text="<%$Resources:NewsResources, NewsListStatusFilterPublished %>" Value="Published"></asp:ListItem>
            <asp:ListItem Text="<%$Resources:NewsResources, NewsListStatusFilterPublishedDraft %>" Value="PublishedDraft"></asp:ListItem>
            <asp:ListItem Text="<%$Resources:NewsResources, NewsListStatusFilterPublishedExpired %>"
                Value="PublishedExpired"></asp:ListItem>
            <asp:ListItem Text="<%$Resources:NewsResources, NewsListStatusFilterNotPublishedYet %>"
                Value="NotPublishedYet"></asp:ListItem>--%>
        </asp:DropDownList>
    </div>
    
    <div class="settingrow">
        <gb:SiteLabel ID="lblStartDate" runat="server" ConfigKey="NewsEditStartDateLabel"
            ResourceFile="NewsResources" ForControl="dpStartDate" CssClass="settinglabel" />
        <gb:DatePickerControl ID="dpStartDate" runat="server" SkinID="news"></gb:DatePickerControl>
    </div>
    <div class="settingrow">
        <gb:SiteLabel ID="SiteLabel16" runat="server" ConfigKey="EndDate" ResourceFile="NewsResources"
            ForControl="dpEndDate" CssClass="settinglabel" />
        <gb:DatePickerControl ID="dpEndDate" runat="server" SkinID="news"></gb:DatePickerControl>
    </div>
    <div class="settingrow">
        <gb:SiteLabel ID="SiteLabel1" runat="server" ConfigKey="NewsListFilterTitleLabel"
            ResourceFile="NewsResources" ForControl="txtTitle" CssClass="settinglabel" />
        <asp:TextBox ID="txtTitle" runat="server" MaxLength="255" />
        <asp:Button CssClass="form-button" ID="btnSearch" Text="<%$Resources:NewsResources, NewsListSearchButton %>"
            runat="server" CausesValidation="false" />
    </div>
    <div class="clear"></div>
    <div class="wrap01 right">
        <asp:HyperLink CssClass="cp-link" ID="lnkInsert" Text="<%$Resources:NewsResources, NewsInsertLabel %>" runat="server" />
        <asp:HyperLink CssClass="cp-link" ID="lnkCancel" Text="<%$Resources:NewsResources, NewsEditCancelButton %>"
            runat="server" />
    </div>
    <div class="clear"></div>
    <div class="cp-gridwrap">
        <div class="cp-outerwrap">
            <div class="cp-innerwrap">
                <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                    <%--<PagerStyle EnableSEOPaging="true" />--%>
                    <MasterTableView DataKeyNames="NewsID,IsPublished,Status,UserGuid,LastModUserGuid">
                        <Columns>
                            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:Resource, RowNumber %>"
                                AllowFiltering="false">
                                <ItemTemplate>
                                    <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, NewsEditTitleLabel %>"
                                DataField="Title" UniqueName="Title" SortExpression="Title" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                <ItemTemplate>
                                    <asp:HyperLink CssClass="cp-link" ID="Title" runat="server" Text='<%# Eval("Title").ToString() %>'
                                        NavigateUrl='<%# FormatNewsUrl(Eval("Url").ToString(), Convert.ToInt32(Eval("NewsID")))  %>'>
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:NewsResources, NewsEditViewedLabel %>"
                                AllowFiltering="false">
                                <ItemTemplate>
                                    <%# Eval("Viewed") %>
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
                                    <%# Eval("CreatedByName") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Right" AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:ImageButton ID="ibPostDraftContentForApproval" OnCommand="ibPostDraftContentForApproval_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModulePostDraftForApprovalLink" Visible="false" runat="server" />
                                    <asp:ImageButton ID="ibApproveContent" OnCommand="ibApproveContent_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleApproveContentLink" Visible="false" runat="server" />
                                    <asp:HyperLink ID="lnkRejectContent" Visible="false" runat="server" />
                                    <asp:ImageButton ID="ibCancelChanges" OnCommand="ibCancelChanges_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleCancelChangesLink" Visible="false" runat="server" />
                                    <asp:ImageButton ID="ibDelete" OnCommand="ibDelete_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleDeleteLink" runat="server" />
                                    <asp:Image ID="statusIcon" Visible="false" runat="server" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" 
                                        Visible='<%# CanEditNews(Convert.ToInt32(Eval("ModuleID")), Convert.ToInt32(Eval("UserID")), Convert.ToBoolean(Eval("IsPublished"))) %>'
                                        Text='<%# EditLinkText %>' NavigateUrl='<%# SiteRoot + "/News/NewsEdit.aspx?pageid=" + pageId + "&NewsID=" + Eval("NewsID") + "&mid=" + moduleId %>'>
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
