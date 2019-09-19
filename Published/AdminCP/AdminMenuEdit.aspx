<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminMenuEdit.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdminMenuEditPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, AdminMenuEditHeading %>" CurrentPageUrl="~/AdminCP/AdminMenuEdit.aspx"
        ParentTitle="<%$Resources:Resource, AdminMenuLink %>" ParentUrl="~/AdminCP/AdminMenu.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnSave" ValidationGroup="editadminmenu" Text="<%$Resources:Resource, SaveButton %>" runat="server" />
            <asp:Button SkinID="UpdateButton" ID="btnSaveAndClose" ValidationGroup="editadminmenu" Text="<%$Resources:Resource, SaveAndCloseButton %>" runat="server" />
            <asp:Button SkinID="UpdateButton" ID="btnSaveAndNew" ValidationGroup="editadminmenu" Text="<%$Resources:Resource, SaveAndNewButton %>" runat="server" />
            <asp:Button ID="btnDelete" SkinID="DeleteButton" Text="<%$Resources:Resource, DeleteButton %>" runat="server" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="workplace">
            <div class="form-horizontal">
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblParent" runat="server" ForControl="ddlParent" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="AdminMenuParentLabel" ResourceFile="Resource" />
                    <div class="col-sm-9">
                        <asp:DropDownList ID="ddlParent" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblKeyName" runat="server" ForControl="txtKeyName" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="AdminMenuResourceKeyLabel" ResourceFile="Resource" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtKeyName" MaxLength="255" runat="server" />
                        <asp:RequiredFieldValidator ControlToValidate="txtKeyName" ValidationGroup="editadminmenu" 
                            ErrorMessage="<%$Resources:Resource, AdminMenuResourceKeyRequiredWarning %>"
                            ID="reqKeyName" Display="Dynamic" SetFocusOnError="true" runat="server" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblResourceFile" runat="server" ForControl="txtResourceFile" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="AdminMenuResourceFileLabel" ResourceFile="Resource" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtResourceFile" MaxLength="255" runat="server" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblUrl" runat="server" ForControl="txtUrl" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="AdminMenuUrlLabel" ResourceFile="Resource" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtUrl" MaxLength="255" runat="server" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblCssClass" runat="server" ForControl="txtCssClass" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="CssClassLabel" ResourceFile="Resource" />
                    <div class="col-sm-9">
                        <div class="input-group">
                            <asp:TextBox ID="txtCssClass" MaxLength="50" runat="server" />
                            <div class="input-group-addon">
                                <asp:Literal ID="litIconCssClass" Text="<i></i>" runat="server" />
                            </div>
                        </div>
                        <asp:RegularExpressionValidator ID="regexCssClass" runat="server" ControlToValidate="txtCssClass"
                            ErrorMessage="<%$Resources:Resource, CssClassInvalidWarning %>"
                            ValidationExpression="^([\s]?[a-zA-Z]+[_\-a-zA-Z0-9]+)*\z+" Display="Dynamic" ValidationGroup="editadminmenu" SetFocusOnError="true" />
                    </div>
                </div>
                <div id="divIcons" visible="false" runat="server" class="settingrow form-group">
                    <gb:SiteLabel ID="lblImages" runat="server" ForControl="ddIcons" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="ModuleSettingsIconLabel" />
                    <div class="col-sm-9">
                        <asp:DropDownList ID="ddIcons" runat="server" DataValueField="Name" DataTextField="Name"
                            CssClass="forminput">
                        </asp:DropDownList>
                        <img id="imgIcon" alt="" src="" runat="server" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblPosition" runat="server" ForControl="chklPosition" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="AdminMenuPositionLabel" ResourceFile="Resource" />
                    <div class="col-sm-9">
                        <asp:CheckBoxList ID="chklPosition" SkinID="Enum" runat="server" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblIsVisible" runat="server" ForControl="chkIsVisible" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="AdminMenuIsVisibleLabel" ResourceFile="Resource" />
                    <div class="col-sm-9">
                        <asp:CheckBox ID="chkIsVisible" Checked="true" runat="server" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblPermissionNames" runat="server" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="AdminMenuPermissionNamesLabel" ResourceFile="Resource" />
                    <div class="col-sm-9">
                        <portal:ComboBox ID="lbPermissionNames" DataTextField="KeyName" DataValueField="KeyName" SelectionMode="Multiple" runat="server" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblVisibleToRoles" runat="server" ForControl="chklAllowedRoles" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="AdminMenuVisibleToRolesLabel" ResourceFile="Resource" />
                    <div class="col-sm-9">
                        <asp:CheckBoxList ID="chklAllowedRoles" SkinID="Roles" runat="server"></asp:CheckBoxList>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server">
</asp:Content>
