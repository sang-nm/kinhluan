<%@ Page Language="C#" MasterPageFile="~/App_MasterPages/layout.Master" AutoEventWireup="false"
    CodeBehind="PermissionDefine.aspx.cs" Inherits="CanhCam.Web.AdminUI.PermissionDefinePage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        ParentTitle="<%$Resources:Resource, AdminMenuFeatureModulesLink %>" ParentUrl="~/AdminCP/ModuleAdmin.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, ModuleDefinitionSettingsDeleteButton %>" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="headInfo">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="KeyName" EditMode="InPlace" AllowPaging="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, ModuleDefinitionsSettingNameHeading %>">
                            <ItemTemplate>
                                <%# Eval("KeyName")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="form-horizontal">
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel9" runat="server" ForControl="txtResourceFile" ConfigKey="ModuleDefinitionsResourceFileLabel"
                                            CssClass="settinglabel control-label col-sm-3" />
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="txtResourceFile" Text='<%# Bind("ResourceFile")%>' runat="server"
                                                MaxLength="255" Columns="60" CssClass="forminput" />
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel15" runat="server" ForControl="txtGroupNameKey" ConfigKey="ModuleDefinitionsGroupNameLabel"
                                            CssClass="settinglabel control-label col-sm-3" />
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="txtGroupNameKey" Text='<%# Bind("GroupName")%>' runat="server" MaxLength="255"
                                                Columns="60" CssClass="forminput" />
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lbl1" runat="server" ForControl="txtSettingName" ConfigKey="ModuleDefinitionsSettingNameLabel"
                                            CssClass="settinglabel control-label col-sm-3" />
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="txtSettingName" ReadOnly="true" Text='<%# Bind("KeyName")%>' runat="server"
                                                MaxLength="255" Columns="60" CssClass="forminput" />
                                            <asp:HiddenField ID="hdfKeyValue" Value='<%# Bind("KeyValue")%>' runat="server" />
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel1" runat="server" ForControl="chbIsVisible" ConfigKey="FeaturePermissionIsVisibleLabel"
                                            CssClass="settinglabel control-label col-sm-3" />
                                        <div class="col-sm-9">
                                            <asp:CheckBox ID="chbIsVisible" Checked='<%# Bind("IsVisible")%>'
                                                runat="server" />
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel2" runat="server" ForControl="txtSortOrder" ConfigKey="ModuleDefinitionsSettingSortOrderLabel"
                                            CssClass="settinglabel control-label col-sm-3" />
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="txtSortOrder" runat="server" Text='<%# Bind("SortOrder")%>' MaxLength="255"
                                                Columns="60" CssClass="forminput" />
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <div class="col-sm-offset-3 col-sm-9">
                                            <asp:Button SkinID="DefaultButton" ID="btnGridUpdate" runat="server" Text='<%# GetUpdateButtonText() %>'
                                                CommandName="Update" />
                                            <asp:Button SkinID="DefaultButton" ID="btnGridCancel" runat="server" Text='<%# GetCancelButtonText() %>'
                                                CommandName="Cancel" />
                                        </div>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="100">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" SkinID="EditButton" runat="server" CommandName="Edit" CssClass="link-button"
                                    Text='<%# Resources.Resource.ModuleDefinitionSettingsEditButton %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
        <div class="workplace">
            <portal:HeadingControl ID="subHeading" HeadingTag="h3" runat="server" />
            <div class="form-horizontal">
                <div class="settingrow form-group">
                    <gb:SiteLabel runat="server" ForControl="txtNewResourceFile" ConfigKey="ModuleDefinitionsResourceFileLabel"
                        CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtNewResourceFile" Text='<%# Bind("ResourceFile")%>' runat="server"
                            MaxLength="255" Columns="60" CssClass="forminput" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel runat="server" ForControl="txtGroupNameKey" ConfigKey="ModuleDefinitionsGroupNameLabel"
                        CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtGroupNameKey" runat="server" MaxLength="255" Columns="60" CssClass="forminput" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="SiteLabel5" runat="server" ForControl="txtNewSettingName" ConfigKey="ModuleDefinitionsSettingNameLabel"
                        CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtNewSettingName" runat="server" MaxLength="255" Columns="60" CssClass="forminput" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel runat="server" ForControl="chbNewIsVisible"
                        ConfigKey="FeaturePermissionIsVisibleLabel" CssClass="settinglabel control-label col-sm-3">
                    </gb:SiteLabel>
                    <div class="col-sm-9">
                        <asp:CheckBox ID="chbNewIsVisible" Checked="true" runat="server" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel runat="server" ForControl="txtNewSortOrder" ConfigKey="ModuleDefinitionsSettingSortOrderLabel"
                        CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtNewSortOrder" runat="server" Text="500" MaxLength="255" Columns="60"
                            CssClass="forminput" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <div class="col-sm-offset-3 col-sm-9">
                        <asp:Button SkinID="DefaultButton" ID="btnCreateNewSetting" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
