<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="FeaturePermissions.aspx.cs" Inherits="CanhCam.Web.AdminUI.FeaturePermissionsPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        ParentTitle="<%$Resources:Resource, AdminMenuFeatureModulesLink %>" ParentUrl="~/AdminCP/ModuleAdmin.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnSave" runat="server" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="workplace">
            <div class="frinstructions">
                <asp:Literal ID="litInfo" runat="server" />
            </div>
            <div class="mrb10">
                <asp:CheckBoxList ID="chklAllowedRoles" runat="server"></asp:CheckBoxList>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
