<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="TaskQueueHistory.aspx.cs" Inherits="CanhCam.Web.AdminUI.TaskQueueHistoryPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, TaskQueueHistoryHeading %>" CurrentPageUrl="~/AdminCP/TaskQueueHistory.aspx"
        ParentTitle="<%$Resources:Resource, TaskQueueMonitorHeading %>" ParentUrl="~/AdminCP/TaskQueueMonitor.aspx"
        RootTitle="<%$Resources:Resource, AdvancedToolsLink %>" RootUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:HyperLink SkinID="LinkButton" ID="lnkRefresh" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, DeleteSelectedButton %>" />
                    <asp:Button SkinID="DeleteButton" ID="btnClearHistory" runat="server" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />                
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="Guid,TaskName">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                                    <ItemTemplate>
                                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, TaskQueueGridTaksNameHeader %>" DataField="TaskName" />
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, TaskQueueGridQueuedHeader %>">
                                    <ItemTemplate>
                                        <%# FormatDate(Eval("QueuedUTC")) %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, TaskQueueGridStartedHeader %>">
                                    <ItemTemplate>
                                        <%# FormatDate(Eval("StartUTC")) %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, TaskQueueGridLastUpdateHeader %>">
                                    <ItemTemplate>
                                        <%# FormatDate(Eval("LastStatusUpdateUTC")) %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, TaskQueueGridCompleteHeader %>">
                                    <ItemTemplate>
                                        <%# FormatDate(Eval("CompleteUTC")) %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, TaskQueueGridCompleteProgressHeader %>">
                                    <ItemTemplate>
                                        <%# GetPercentComplete(Eval("CompleteRatio"))%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <div class="mrb10">
                        <asp:Label ID="lblStatus" runat="server" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
