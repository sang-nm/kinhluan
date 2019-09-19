<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="NewsManageControl.ascx.cs" Inherits="CanhCam.Web.NewsUI.NewsManageControl" %>

<div class="admin-content">
    <div class="heading">
        <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
            CurrentPageTitle="<%$Resources:NewsResources, NewsList %>" CurrentPageUrl="~/News/NewsList.aspx" />
        <portal:HeadingControl ID="heading" runat="server" />
    </div>
    <div class="toolbox">
        <asp:Button CssClass="active" ID="btnUpdate" Text="<%$Resources:NewsResources, NewsListUpdateButton %>"
            runat="server" />
        <asp:HyperLink CssClass="active" ID="lnkInsert" Text="<%$Resources:NewsResources, NewsInsertLabel %>" runat="server" />
        <asp:Button ID="btnDelete" Text="<%$Resources:NewsResources, NewsListDeleteSelectedButton %>"
            runat="server" CausesValidation="false" />
    </div>
    <portal:NotifyMessage ID="message" runat="server" />
    <asp:Panel ID="pnlSearch" DefaultButton="btnSearch" runat="server">
        <div class="settingrow">
            <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                ForControl="ddZones" CssClass="settinglabel" />
            <asp:DropDownList ID="ddZones" AutoPostBack="false" runat="server" />
        </div>
        <div id="divStates" visible="false" runat="server" class="settingrow">
            <gb:SiteLabel ID="lblStatusFilter" runat="server" ConfigKey="NewsListFilterStatusLabel"
                ResourceFile="NewsResources" ForControl="ddStatus" CssClass="settinglabel" />
            <asp:DropDownList ID="ddStates" AppendDataBoundItems="true" DataTextField="StateName" DataValueField="StateId" runat="server"></asp:DropDownList>
        </div>
        <div class="settingrow">
            <gb:SiteLabel ID="lblStartDate" runat="server" ConfigKey="NewsEditStartDateLabel"
                ResourceFile="NewsResources" ForControl="dpStartDate" CssClass="settinglabel" />
            <gb:DatePickerControl ID="dpStartDate" runat="server" SkinID="news"></gb:DatePickerControl>
        </div>
        <div class="settingrow">
            <gb:SiteLabel ID="lblEndDate" runat="server" ConfigKey="EndDate" ResourceFile="NewsResources"
                ForControl="dpEndDate" CssClass="settinglabel" />
            <gb:DatePickerControl ID="dpEndDate" runat="server" SkinID="news"></gb:DatePickerControl>
        </div>
        <div class="settingrow">
            <gb:SiteLabel ID="lblTitle" runat="server" ConfigKey="NewsListFilterTitleLabel"
                ResourceFile="NewsResources" ForControl="txtTitle" CssClass="settinglabel" />
            <asp:TextBox ID="txtTitle" runat="server" MaxLength="255" />
            <asp:Button CssClass="form-button" ID="btnSearch" Text="<%$Resources:NewsResources, NewsListSearchButton %>"
                runat="server" CausesValidation="false" />
        </div>
    </asp:Panel>
    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
        <MasterTableView DataKeyNames="NewsID,ZoneID,StateID,UserGuid,LastModUserGuid,DisplayOrder,Viewed">
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
                        <asp:HyperLink CssClass="cp-link" ID="Title" runat="server" Text='<%# Eval("Title").ToString() %>'
                            NavigateUrl='<%# CanhCam.Web.NewsUI.NewsHelper.FormatNewsUrl(Eval("Url").ToString(), Convert.ToInt32(Eval("NewsID")), Convert.ToInt32(Eval("ZoneID")))  %>'>
                        </asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsEditDisplayOrderLabel %>"
                    AllowFiltering="false">
                    <ItemTemplate>
                        <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox"
                            MaxLength="4" Text='<%# Eval("DisplayOrder") %>' runat="server" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsEditViewedLabel %>"
                    AllowFiltering="false">
                    <ItemTemplate>
                        <asp:TextBox ID="txtViewed" SkinID="NumericTextBox"
                            MaxLength="9" Text='<%# Eval("Viewed") %>' runat="server" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsManagePublishedDate %>"
                    AllowFiltering="false">
                    <ItemTemplate>
                        <%# FormatDate(Eval("StartDate")) %>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, NewsManageCreatedBy %>"
                    AllowFiltering="false">
                    <ItemTemplate>
                        <%# Eval("CreatedByName") %>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="<%$Resources:NewsResources, WorkflowStateLable %>"
                    AllowFiltering="false" UniqueName="WorkflowState">
                    <ItemTemplate>
                        <%--<%# WorkflowHelper.GetWorkflowStateName(workflowId, Eval("StateID")) %>--%>
                        <asp:Literal ID="litState" runat="server" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn UniqueName="WorkflowAction">
                    <ItemTemplate>
                        <%--<asp:ImageButton ID="ibPostDraftContentForApproval" OnCommand="ibPostDraftContentForApproval_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModulePostDraftForApprovalLink" Visible="false" runat="server" />
                        <asp:ImageButton ID="ibApproveContent" OnCommand="ibApproveContent_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleApproveContentLink" Visible="false" runat="server" />
                        <asp:HyperLink ID="lnkRejectContent" Visible="false" runat="server" />
                        <asp:ImageButton ID="ibCancelChanges" OnCommand="ibCancelChanges_Command" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleCancelChangesLink" Visible="false" runat="server" />
                        <asp:Image ID="statusIcon" Visible="false" runat="server" />--%>
                        <asp:ImageButton ID="ibPostDraftContentForApproval" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModulePostDraftForApprovalLink" Visible="false" runat="server" />
                        <asp:ImageButton ID="ibApproveContent" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleApproveContentLink" Visible="false" runat="server" />
                        <asp:HyperLink ID="lnkRejectContent" Visible="false" runat="server" />
                        <asp:ImageButton ID="ibCancelChanges" CommandArgument='<%# Eval("NewsID") %>' CssClass="ModuleCancelChangesLink" Visible="false" runat="server" />
                        <asp:Image ID="statusIcon" Visible="false" runat="server" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn>
                    <ItemTemplate>
                        <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" 
                            Visible='<%# CanEditNews(Convert.ToInt32(Eval("UserID")), Convert.ToBoolean(Eval("IsPublished"))) %>'
                            Text="<%$Resources:NewsResources, NewsEditLink %>" NavigateUrl='<%# SiteRoot + "/News/NewsEdit.aspx?NewsID=" + Eval("NewsID") %>'>
                        </asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</div>