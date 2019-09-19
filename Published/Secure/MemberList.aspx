<%@ Page Language="c#" CodeBehind="MemberList.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.UI.Pages.MemberList" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:MemberListDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, MemberListTitleLabel %>" CurrentPageUrl="~/Secure/MemberList.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:HyperLink SkinID="InsertButton" ID="lnkNewUser" runat="server" Visible="false" />
            <asp:Button SkinID="ExportButton" ID="btnExport" OnClick="btnExport_Click" Visible='<%# canManageUsers %>' Text="<%$Resources:Resource, ExportDataAsExcel %>" runat="server" CausesValidation="false" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:Resource, DeleteSelectedButton %>" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="headInfo">
            <div class="form-horizontal">
                <asp:Panel ID="divNewUser" CssClass="row" runat="server" DefaultButton="btnSearchUser">
                    <div class="col-md-6">
                        <div class="input-group">
                            <asp:TextBox ID="txtSearchUser" runat="server" CssClass="form-control" MaxLength="255" />
                            <div class="input-group-btn">
                                <asp:Button SkinID="SearchButton" ID="btnSearchUser" runat="server" />
                            </div>
                        </div>
                    </div>
                    <div id="divIPLookup" runat="server" visible="false" class="col-md-6">
                        <div class="input-group">
                            <asp:TextBox ID="txtIPAddress" runat="server" CssClass="form-control" MaxLength="50" />
                            <div class="input-group-btn">
                                <asp:Button SkinID="SearchButton" ID="btnIPLookup" runat="server" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlLocked" runat="server" Cssclass="mrb10 mrt10">
                    <asp:Button SkinID="SearchButton" ID="btnFindLocked" Visible="false" runat="server" />
                    <asp:Button SkinID="SearchButton" ID="btnFindNotApproved" Visible="false" runat="server" />
                </asp:Panel>
                <div class="mrb10">
                    <div id="spnTopPager" runat="server"></div>
                </div>
            </div>
        </div>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="UserID" AllowPaging="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (pageSize * (pageNumber - 1)) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, Name %>" DataField="Name">
                            <ItemTemplate>
                                <strong>
                                    <%# FormatName(Eval("Name").ToString(),Eval("LastName").ToString(), Eval("FirstName").ToString())%></strong>
                                <div id="Div1" runat="server" visible='<%# ShowEmailInMemberList %>'>
                                    &nbsp;<a href='<%# "mailto:" + Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Email").ToString())%>'><%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Email").ToString())%></a>
                                </div>
                                <div id="Div2" runat="server" visible='<%# ShowLoginNameInMemberList %>'>
                                    &nbsp;<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "LoginName").ToString())%>
                                </div>
                                <div id="Div3" runat="server" visible='<%# ShowUserIDInMemberList %>'>
                                    &nbsp;<gb:SiteLabel ID="lblTotalPosts" runat="server" ConfigKey="RegisterLoginNameLabel"
                                        UseLabelTag="false" />
                                    <%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "UserID").ToString())%>
                                </div>
                                <div id="Div4" runat="server" visible='<%# (IsAdmin && (!Convert.ToBoolean(Eval("DisplayInMemberList")))) %>'
                                    class="floatrightimage isvisible">
                                    <%# Resources.Resource.HiddenUser%>
                                </div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="150" HeaderText="<%$Resources:Resource, MemberListDateCreatedLabel %>" DataField="DateCreated">
                            <ItemTemplate>
                                <%# DateTimeHelper.Format(Convert.ToDateTime(Eval("DateCreated")), timeZone, "d", timeOffset)%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, MemberListUserWebSiteLabel %>" DataField="WebSiteUrl">
                            <ItemTemplate>
                                <a rel="nofollow" href='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"WebSiteUrl").ToString()) %>'>
                                                    <%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "WebSiteUrl").ToString())%></a>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="200" AllowFiltering="false">
                            <ItemTemplate>
                                <a class="popup-link cp-link" href='<%# SiteRoot + "/Secure/ProfileView.aspx?userid=" + DataBinder.Eval(Container.DataItem,"UserID") %>'>
                                    <gb:SiteLabel ID="lblViewProfile" runat="server" ConfigKey="MemberListViewProfileLabel"
                                        UseLabelTag="false" /></a>
                                <asp:HyperLink CssClass="cp-link" Text='<%# Resources.Resource.ManageUserLink %>' ID="Hyperlink2" NavigateUrl='<%# SiteRoot + "/AdminCP/ManageUsers.aspx?userid=" + DataBinder.Eval(Container.DataItem,"UserID")   %>'
                                    Visible="<%# canManageUsers %>" runat="server" EnableViewState="false" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <portal:gbCutePager ID="pgrMembers" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
