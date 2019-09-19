<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" AutoEventWireup="false"
    MasterPageFile="~/App_MasterPages/layout.Master" CodeBehind="RedirectManager.aspx.cs"
    Inherits="CanhCam.Web.AdminUI.RedirectManagerPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, RedirectManagerShortLink %>" CurrentPageUrl="~/AdminCP/RedirectManager.aspx"
        ParentTitle="<%$Resources:Resource, AdvancedToolsLink %>" ParentUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, DeleteSelectedButton %>" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <asp:Panel ID="pnlAddRedirect" CssClass="headInfo" runat="server" DefaultButton="btnAdd">
            <div class="form-horizontal">
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblOldUrl" runat="server" ForControl="txtOldUrl" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="RedirectsOldUrlLabel" />
                    <div class="col-sm-9">
                        <div class="input-group">
                            <div class="input-group-addon">
                                <asp:Literal ID="litSiteRoot" runat="server" />
                            </div>
                            <asp:TextBox ID="txtOldUrl" runat="server" Columns="60" MaxLength="255" />
                        </div>
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblNewUrl" runat="server" ForControl="txtNewUrl" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="RedirectsToLabel" />
                    <div class="col-sm-9">
                        <div class="input-group">
                            <div class="input-group-addon">
                                <asp:Literal ID="litSiteRoot2" runat="server" />
                            </div>
                            <asp:TextBox ID="txtNewUrl" Columns="60" runat="server" MaxLength="255" />
                        </div>
                    </div>
                </div>
                <div class="settingrow form-group mrb10">
                    <div class="col-sm-offset-3 col-sm-9"><asp:Button SkinID="DefaultButton" runat="server" Text="<%$Resources:Resource, InsertButton %>" ID="btnAdd" /></div>
                </div>
            </div>
            <%--<gb:SiteLabel ID="Sitelabel5" runat="server" ConfigKey="RedirectHelp" />--%>
        </asp:Panel>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="RowGuid,OldUrl" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, RedirectsOldUrlLabel %>">
                            <ItemTemplate>
                                <a href='<%# RootUrl + DataBinder.Eval(Container.DataItem, "OldUrl")%>'>
                                    <%# RootUrl + DataBinder.Eval(Container.DataItem, "OldUrl")%>
                                </a>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%# RootUrl %><asp:TextBox ID="txtGridOldUrl" Columns="60" Text='<%# DataBinder.Eval(Container.DataItem, "OldUrl").ToString() %>' runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, RedirectsToLabel %>">
                            <ItemTemplate>
                                <a href='<%# ((!Eval("NewUrl").ToString().StartsWith("http://") && !Eval("NewUrl").ToString().StartsWith("https://")) ? RootUrl : "") + DataBinder.Eval(Container.DataItem, "NewUrl")%>'>
                                    <%# ((!Eval("NewUrl").ToString().StartsWith("http://") && !Eval("NewUrl").ToString().StartsWith("https://")) ? RootUrl : "") + DataBinder.Eval(Container.DataItem, "NewUrl")%>
                                </a>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%# (!Eval("NewUrl").ToString().StartsWith("http://") && !Eval("NewUrl").ToString().StartsWith("https://")) ? RootUrl : "" %><asp:TextBox ID="txtGridNewUrl" Columns="60" Text='<%# DataBinder.Eval(Container.DataItem, "NewUrl").ToString() %>' runat="server" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" SkinID="EditButton" runat="server" CommandName="Edit"
                                    Text='<%# Resources.Resource.EditLink %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button SkinID="DefaultButton" ID="btnGridUpdate" runat="server" Text='<%# Resources.Resource.SaveButton %>'
                                    CommandName="Update" />
                                <asp:Button SkinID="DefaultButton" ID="btnGridCancel" runat="server" Text='<%# Resources.Resource.CancelButton %>'
                                    CommandName="Cancel" />
                            </EditItemTemplate>
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
