<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="TaskQueueMonitor.aspx.cs" Inherits="CanhCam.Web.AdminUI.TaskQueueMonitorPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, TaskQueueMonitorHeading %>" CurrentPageUrl="~/AdminCP/TaskQueueMonitor.aspx"
        ParentTitle="<%$Resources:Resource, AdvancedToolsLink %>" ParentUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
                <asp:HyperLink SkinID="DefaultButton" ID="lnkRefresh" runat="server" />
                <asp:HyperLink SkinID="DefaultButton" ID="lnkTaskQueueHistory" runat="server" />
                <asp:Button SkinID="DefaultButton" ID="btnTest" runat="server" Visible="false" />
                <asp:Button SkinID="DefaultButton" ID="btnStartTasks" runat="server" Visible="false" />
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
                                <%# DateTimeHelper.Format(Convert.ToDateTime(Eval("QueuedUTC")), timeZone, "g", timeOffset) %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, TaskQueueGridStartedHeader %>">
                            <ItemTemplate>
                                <%# DateTimeHelper.Format(Convert.ToDateTime(Eval("StartUTC")), timeZone, "g", timeOffset) %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, TaskQueueGridLastUpdateHeader %>">
                            <ItemTemplate>
                                <%# DateTimeHelper.Format(Convert.ToDateTime(Eval("LastStatusUpdateUTC")), timeZone, "g", timeOffset) %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, TaskQueueGridCompleteProgressHeader %>">
                            <ItemTemplate>
                                <%# GetPercentComplete(Eval("CompleteRatio"))%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, TaskQueueGridStatusHeader %>">
                            <ItemTemplate>
                                <%# Eval("Status")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <div class="mrb10">
                <asp:Label ID="lblStatus" runat="server" />
            </div>
            <div class="mrb10">
                <gb:SiteLabel ID="lblTaskQueueAvailable" runat="server" ConfigKey="TaskQueueAvailableThreadsLabel" />
                <asp:Literal ID="litAvailableThreads" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
