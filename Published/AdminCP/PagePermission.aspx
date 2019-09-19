<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="PagePermission.aspx.cs" Inherits="CanhCam.Web.AdminUI.PagePermissionPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="SaveButton" ID="btnSave" runat="server" />
        </portal:HeadingPanel>        
        <div class="workplace">
            <div id="divRadioButtons" runat="server">
                <div class="mrb10">
                    <asp:RadioButton ID="rbAdminsOnly" runat="server" GroupName="rdouseroles" CssClass="rbroles rbadminonly" />
                    <portal:gbHelpLink ID="gbHelpLink32" runat="server" HelpKey="pagepermission-adminonly-help" />
                </div>
                <div class="mrb10">
                    <asp:RadioButton ID="rbUseRoles" runat="server" GroupName="rdouseroles" CssClass="rbroles" />
                </div>
            </div>
            <div class="mrb10">
                <asp:CheckBoxList ID="chkAllowedRoles" runat="server" SkinID="Roles">
                </asp:CheckBoxList>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
