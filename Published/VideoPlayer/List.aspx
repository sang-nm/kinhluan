<%@ Page Language="c#" CodeBehind="List.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.VideoUI.VideoList" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:VideoResources, VideoListHeading %>" CurrentPageUrl="~/VideoPlayer/List.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:VideoResources, UpdateButton %>" runat="server" />
            <asp:HyperLink SkinID="InsertButton" ID="lnkInsert" Text="<%$Resources:VideoResources, InsertLink %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:VideoResources, DeleteSelectedButton %>" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="headInfo form-horizontal">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                    ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddZones" AutoPostBack="true" runat="server" />
                </div>
            </div>
        </div>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="VideoID,DisplayOrder,Position" AllowSorting="false" AllowFilteringByColumn="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="<%$Resources:VideoResources, VideoNameHeader %>"
                            DataField="Name" UniqueName="Name" SortExpression="Name" CurrentFilterFunction="Contains"
                            AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%" />
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:VideoResources, ThumbnailHeader %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# GetThumnailMarkup(Eval("Thumbnail").ToString(), Eval("VideoPath").ToString(), Eval("Name").ToString())%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="<%$Resources:VideoResources, FileLocationHeader %>"
                            DataField="VideoPath" UniqueName="VideoPath" SortExpression="VideoPath" AllowFiltering="false" />
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:VideoResources, PositionLabel %>" AllowFiltering="false" >
                            <ItemTemplate>
                                <asp:CheckBoxList ID="chkListPosition" runat="server" DataTextField="Name" DataValueField="Value" SkinID="Enum" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:VideoResources, DisplayOrderLabel %>" AllowFiltering="false" >
                            <ItemTemplate>
                                <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" MaxLength="4" Text='<%# Eval("DisplayOrder") %>'
                                    runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="100" AllowFiltering="false" >
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" Text="<%# Resources.VideoResources.VideoEditLabel %>" 
                                    NavigateUrl='<%# this.SiteRoot + "/VideoPlayer/Edit.aspx?VideoID=" + DataBinder.Eval(Container.DataItem,"VideoID") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
