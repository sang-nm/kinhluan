<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" AutoEventWireup="false"
    MasterPageFile="~/App_MasterPages/layout.Master" CodeBehind="UrlManager.aspx.cs"
    Inherits="CanhCam.Web.AdminUI.UrlManagerPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, AdminMenuUrlManagerLink %>" CurrentPageUrl="~/AdminCP/UrlManager.aspx"
        ParentTitle="<%$Resources:Resource, AdvancedToolsLink %>" ParentUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="InsertButton" ID="btnAddNew" Text="<%$Resources:Resource, InsertLink %>" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, DeleteSelectedButton %>" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="headInfo">
                    <div class="row">
                        <div class="col-sm-5">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearch" placeholder="<%$Resources:Resource, SearchKeywordLabel %>" runat="server" MaxLength="255" CssClass="widetextbox" />
                                <div class="input-group-btn">
                                    <asp:Button SkinID="DefaultButton" ID="btnSearchUrls" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="UrlID,FriendlyUrl,RealUrl,LanguageID" EditMode="InPlace">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>">
                                    <ItemTemplate>
                                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, FriendlyUrlLabel %>">
                                    <ItemTemplate>
                                        <%# RootUrl %><%# DataBinder.Eval(Container.DataItem, "FriendlyUrl") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <%# RootUrl %>
                                            </div>
                                            <asp:TextBox ID="txtFriendlyUrl" Columns="60" Text='<%# DataBinder.Eval(Container.DataItem, "FriendlyUrl") %>' runat="server" />
                                        </div>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, FriendlyUrlRealUrlLabel %>">
                                    <ItemTemplate>
                                        <%# RootUrl %><%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "RealUrl").ToString().Replace("~/","")) %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <%# RootUrl %>
                                            </div>
                                            <asp:TextBox ID="txtRealUrl" Columns="60" Text='<%# DataBinder.Eval(Container.DataItem, "RealUrl").ToString().Replace("~/","") %>' runat="server" />
                                        </div>
                                        <div class="settingrow form-group mrt10">
                                            <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="FriendlyUrlSelectFromDropdownLabel" CssClass="settinglabel control-label" />
                                            <asp:DropDownList ID="ddZones" runat="server" DataSource='<%# ZoneList %>' DataValueField="value" DataTextField="key" />
                                        </div>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, LanguageLabel %>">
                                    <ItemTemplate>
                                        <%# LanguageHelper.GetNameByLanguageId(Convert.ToInt32(DataBinder.Eval(Container.DataItem, "LanguageID")))%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddLanguages" Width="100" runat="server" AppendDataBoundItems="true" DataSource='<%# LanguageHelper.GetPublishedLanguages() %>' DataValueField="LanguageID" DataTextField="Name">
                                            <asp:ListItem Text="" Value="-1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:Button SkinID="EditButton" ID="btnEdit" runat="server" CommandName="Edit" 
                                            Text='<%# Resources.Resource.EditLink %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Button SkinID="DefaultButton" ID="btnGridUpdate" runat="server" Text='<%# Resources.Resource.FriendlyUrlSaveLabel %>'
                                            CommandName="Update" />
                                        <asp:Button SkinID="DefaultButton" ID="btnGridCancel" runat="server" Text='<%# Resources.Resource.FriendlyUrlCancelButton %>'
                                            CommandName="Cancel" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderStyle-Width="50">
                                    <ItemTemplate>
                                        <a class="cp-link" href='<%# RootUrl + DataBinder.Eval(Container.DataItem, "FriendlyUrl") %>'>
                                            <gb:SiteLabel ID="lblViewUrl" runat="server" ConfigKey="FriendlyUrlViewLink" UseLabelTag="false" />
                                        </a>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server">
</asp:Content>
