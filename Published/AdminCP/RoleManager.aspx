<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="RoleManager.aspx.cs" Inherits="CanhCam.Web.AdminUI.RoleManagerPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, AdminMenuRoleAdminLink %>" CurrentPageUrl="~/AdminCP/RoleManager.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, RolesDeleteSelectedButton %>" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <asp:Panel ID="pnlAddRole" runat="server" CssClass="headInfo" DefaultButton="btnAddRole">
                    <div class="row">
                        <div class="col-sm-5">
                            <div class="mrb10 input-group">
                                <asp:TextBox ID="txtNewRoleName" runat="server" MaxLength="50" CssClass="form-control" />
                                <div class="input-group-btn">
                                    <asp:Button SkinID="InsertButton" runat="server" ID="btnAddRole" />
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="RoleID,DisplayName" AllowPaging="false" EditMode="InPlace">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>">
                                    <ItemTemplate>
                                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, RolesNameLabel %>">
                                    <ItemTemplate>
                                        <%# DataBinder.Eval(Container.DataItem, "DisplayName") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="roleName" Width="200" Text='<%# DataBinder.Eval(Container.DataItem, "DisplayName") %>' runat="server" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:Button SkinID="EditButton" ID="btnEdit" runat="server" CommandName="Edit" CssClass="link-button"
                                            Text='<%# Resources.Resource.RolesEditLabel %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Button SkinID="UpdateButton" ID="btnGridUpdate" runat="server" Text='<%# Resources.Resource.UpdateButton %>'
                                            CommandName="Update" />
                                        <asp:Button SkinID="CancelButton" ID="btnGridCancel" runat="server" Text='<%# Resources.Resource.RoleManagerCancelButton %>'
                                            CommandName="Cancel" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:HyperLink CssClass="cp-link" ID="lnkMembers" runat="server" Text='<%#  FormatMemberLink(Convert.ToInt32(Eval("MemberCount"))) %>'
                                            NavigateUrl='<%# SiteRoot + "/AdminCP/SecurityRoles.aspx?roleid=" + DataBinder.Eval(Container.DataItem, "RoleID") %>' />
                                    </ItemTemplate>
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
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
