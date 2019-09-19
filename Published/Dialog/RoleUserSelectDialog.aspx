<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="RoleUserSelectDialog.aspx.cs" Inherits="CanhCam.Web.AdminUI.RoleUserSelectDialog" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server">
    <style type="text/css">
        .grid-members{width:99% !important;}
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <asp:Panel ID="pnlLookup" runat="server" Visible="false">
        <telerik:RadGrid ID="grid" SkinID="radGridSkin" CssClass="grid-members" runat="server">
            <MasterTableView AllowPaging="false" AllowSorting="false">
                <Columns>
                    <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                        <ItemTemplate>
                            <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, MemberListUserNameLabel %>" DataField="Name" />
                    <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, MemberListEmailLabel %>" DataField="Email" />
                    <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, MemberListLoginNameLabel %>" DataField="LoginName" />
                    <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <asp:Button ID="btnSelect" SkinID="DefaultButton" runat="server" Text='<%# Resources.Resource.UserLookupDialogSelectButton %>'
                                CommandName="selectUser" CommandArgument='<%# Eval("UserID") %>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <portal:gbCutePager ID="pgrMembers" runat="server" />
    </asp:Panel>
    <asp:Panel ID="pnlNotAllowed" runat="server" Visible="false">
        <gb:SiteLabel ID="lblNotAllowed" runat="server" CssClass="warning" UseLabelTag="false"
            ConfigKey="NotInUserLookupRolesWarning" />
    </asp:Panel>
</asp:Content>