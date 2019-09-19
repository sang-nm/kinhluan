<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="UserRoles.ascx.cs" Inherits="CanhCam.Web.AdminUI.UserRoles" %>

<asp:HyperLink ID="lnkRolesDialog" runat="server" Visible="false" CssClass="lnkRolesDialog" EnableViewState="false" />
<asp:UpdatePanel ID="upRoles" UpdateMode="Conditional" runat="server">
<ContentTemplate> 
    <div id="divRoles" runat="server" class="mrb10">
        <div class="input-group">
            <asp:DropDownList ID="allRoles" runat="server" DataValueField="RoleID" DataTextField="DisplayName" CssClass="forminput" />
            <div class="input-group-btn">
                <asp:Button SkinID="DefaultButton" ID="addExisting" runat="server" Text="<%# Resources.Resource.ManageUsersAddToRoleButton %>"
                    CausesValidation="false" />
            </div>
        </div>
    </div>
     <asp:ImageButton ID="btnRefreshRoles" runat="server" />
    <div id="divUserRoles" runat="server" class="mrb10">
        <portal:gbDataList ID="userRoles" runat="server" DataKeyField="RoleID" RepeatColumns="2">
            <ItemTemplate>
                <asp:LinkButton CommandName="delete" CausesValidation="false"
                    AlternateText='<%# Resources.Resource.ManageUsersRemoveFromRoleButton %>' runat="server"
                    ToolTip='<%# Resources.Resource.ManageUsersRemoveFromRoleButton %>' runat="server"
                    ID="btnRemoveRole" Visible='<%# CanDeleteUserFromRole(Eval("RoleName").ToString()) %>'>
                    <i class="fa fa-trash-o"></i>
                </asp:LinkButton>
                <%# DataBinder.Eval(Container.DataItem, "DisplayName") %>
            </ItemTemplate>
        </portal:gbDataList>
    </div>
</ContentTemplate>
</asp:UpdatePanel>
