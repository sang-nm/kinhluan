<%@ Page Language="c#" CodeBehind="SecurityRoles.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.AdminUI.SecurityRoles" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, AdminMenuRoleAdminLink %>" CurrentPageUrl="~/AdminCP/RoleManager.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:HyperLink ID="lnkFindUser" runat="server" CssClass="popup-link active" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:Resource, ManageUsersRemoveFromRoleButton %>"
                runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <asp:HiddenField ID="hdnUserID" runat="server" />
        <asp:ImageButton ID="btnSetUserFromGreyBox" runat="server" />
        <portal:NotifyMessage ID="message" runat="server" />
        <asp:Panel ID="pnlSecurity" runat="server" CssClass="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="UserID" AllowPaging="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, MemberListUserNameLabel %>" DataField="Name" />
                        <telerik:GridTemplateColumn HeaderStyle-Width="200">
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="lnkManageUser" runat="server" EnableViewState="false" Visible='<%# CanManageUsers %>'
                                    NavigateUrl='<%# SiteRoot + "/AdminCP/ManageUsers.aspx?userid=" + Eval("UserID") %>'
                                    Text='<%# Resources.Resource.ManageUsersPageTitle %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <portal:gbCutePager ID="pgr" runat="server" />
        </asp:Panel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
