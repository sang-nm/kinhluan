<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="LetterSubscribers.aspx.cs" Inherits="CanhCam.Web.AdminUI.LetterSubscribersPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, NewsletterPreferencesHeader %>" CurrentPageUrl="~/AdminCP/LetterSubscribers.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="ExportButton" runat="server" ID="btnExportExcel" />
            <asp:Button SkinID="ExportButton" runat="server" ID="btnExport" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="workplace">
            <asp:Panel ID="pnlSearchSubscribers" runat="server" DefaultButton="btnSearch" CssClass="headInfo mrb10">
                <div class="row">
                    <div class="col-sm-5">
                        <div class="input-group">
                            <asp:TextBox ID="txtSearchInput" runat="server" CssClass="form-control" MaxLength="100" />
                            <div class="input-group-btn">
                                <asp:Button SkinID="SearchButton" ID="btnSearch" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="Guid" AllowPaging="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, NewsletterNameHeading %>">
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" Text='<%# Eval("Name") %>' ID="Hyperlink2" NavigateUrl='<%# SiteRoot + "/AdminCP/ManageUsers.aspx?u=" + Eval("UserGuid")   %>'
                                    Visible='<%# ShowUserLink(Eval("UserGuid").ToString()) %>' runat="server" />
                                <asp:Literal ID="litUser" runat="server" Text='<%# Eval("Name") %>' Visible='<%# !ShowUserLink(Eval("UserGuid").ToString()) %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, EmailLabel %>"
                            DataField="Email"></telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, NewsletterBeginDateHeading %>">
                            <ItemTemplate>
                                <%# DateTimeHelper.Format(Convert.ToDateTime(Eval("BeginUtc")), timeZone, "g", timeOffset) %>
                                <a class='popup-link cp-link' title='<%# Eval("IpAddress") %>' href='http://whois.arin.net/rest/ip/<%# Eval("IpAddress") %>.txt'>
                                    <%# Eval("IpAddress")%></a>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <portal:gbCutePager ID="pgrLetterSubscriber" Visible="false" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
