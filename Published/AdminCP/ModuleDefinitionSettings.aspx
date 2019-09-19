<%@ Page Language="C#" MasterPageFile="~/App_MasterPages/layout.Master" AutoEventWireup="false"
    CodeBehind="ModuleDefinitionSettings.aspx.cs" Inherits="CanhCam.Web.AdminUI.ModuleDefinitionSettingsPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        ParentTitle="<%$Resources:Resource, AdminMenuFeatureModulesLink %>" ParentUrl="~/AdminCP/ModuleAdmin.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, ModuleDefinitionSettingsDeleteButton %>" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="headInfo">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="DefSettingID,SettingName" EditMode="InPlace" AllowPaging="false">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, ModuleDefinitionsSettingNameHeading %>">
                                    <ItemTemplate>
                                        <%# Eval("SettingName") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <div class="form-horizontal">
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="SiteLabel9" runat="server" ForControl="txtResourceFile" ConfigKey="ModuleDefinitionsResourceFileLabel"
                                                    CssClass="settinglabel control-label col-sm-3" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtResourceFile" Text='<%# Bind("ResourceFile")%>' runat="server"
                                                        MaxLength="255" Columns="60" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="SiteLabel15" runat="server" ForControl="txtGroupNameKey" ConfigKey="ModuleDefinitionsGroupNameLabel"
                                                    CssClass="settinglabel control-label col-sm-3" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtGroupNameKey" Text='<%# Bind("GroupName")%>' runat="server" MaxLength="255"
                                                        Columns="60" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="lbl1" runat="server" ForControl="txtSettingName" ConfigKey="ModuleDefinitionsSettingNameLabel"
                                                    CssClass="settinglabel control-label col-sm-3" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtSettingName" Text='<%# Bind("SettingName")%>' runat="server"
                                                        MaxLength="255" Columns="60" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="SiteLabel2" runat="server" ForControl="ddControlType" ConfigKey="ModuleDefinitionsSettingControlTypeLabel"
                                                    CssClass="settinglabel control-label col-sm-3" />
                                                <div class="col-sm-9">
                                                    <asp:DropDownList ID="ddControlType" runat="server" SelectedValue='<%# Bind("ControlType") %>'
                                                        CssClass="form-control">
                                                        <asp:ListItem Value="TextBox" Text="TextBox" />
                                                        <asp:ListItem Value="CheckBox" Text="CheckBox" />
                                                        <asp:ListItem Value="ISettingControl" Text="ISettingControl" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="SiteLabel3" runat="server" ForControl="txtControlSrc" ConfigKey="ModuleDefinitionsSettingControlSrcLabel"
                                                    CssClass="settinglabel control-label col-sm-3" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtControlSrc" runat="server" Text='<%# Bind("ControlSrc")%>' MaxLength="255"
                                                        Columns="60" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="SiteLabel33" runat="server" ForControl="txtSettingValue" ConfigKey="ModuleDefinitionsSettingValueLabel"
                                                    CssClass="settinglabel control-label col-sm-3" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtSettingValue" runat="server" Text='<%# Bind("SettingValue")%>'
                                                        MaxLength="255" Columns="60" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="SiteLabel1" runat="server" ForControl="chbIsAdvancedSetting" ConfigKey="ModuleDefinitionsIsAdvancedSettingLabel"
                                                    CssClass="settinglabel control-label col-sm-3" />
                                                <div class="col-sm-9">
                                                    <asp:CheckBox ID="chbIsAdvancedSetting" Checked='<%# Bind("IsAdvancedSetting")%>'
                                                        runat="server" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="SiteLabel10" runat="server" ForControl="txtSortOrder" ConfigKey="ModuleDefinitionsSettingSortOrderLabel"
                                                    CssClass="settinglabel control-label col-sm-3" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtSortOrder" runat="server" Text='<%# Bind("SortOrder")%>' MaxLength="255"
                                                        Columns="60" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="SiteLabel12" runat="server" ForControl="txtHelpKey" ConfigKey="ModuleDefinitionsSettingHelpKeyLabel"
                                                    CssClass="settinglabel control-label col-sm-3" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtHelpKey" runat="server" Text='<%# Bind("HelpKey")%>' MaxLength="255"
                                                        Columns="60" CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="SiteLabel4" runat="server" ConfigKey="ModuleDefinitionsSettingRegexExpressionLabel"
                                                    CssClass="settinglabel control-label col-sm-3" />
                                                <div class="col-sm-9">
                                                    <asp:TextBox ID="txtRegexValidationExpression" runat="server" Text='<%# Bind("RegexValidationExpression")%>'
                                                        Rows="4" Columns="60" TextMode="MultiLine" />
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
                                        <asp:Button ID="btnEdit" SkinID="EditButton" runat="server" CommandName="Edit"
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
                            <gb:SiteLabel ID="lblResourceFile" runat="server" ForControl="txtNewResourceFile" ConfigKey="ModuleDefinitionsResourceFileLabel"
                                CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtNewResourceFile" Text='<%# Bind("ResourceFile")%>' runat="server"
                                    MaxLength="255" Columns="60" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblGroupName" runat="server" ForControl="txtGroupNameKey" ConfigKey="ModuleDefinitionsGroupNameLabel"
                                CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtGroupNameKey" runat="server" MaxLength="255" Columns="60" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblSettingName" runat="server" ForControl="txtNewSettingName" ConfigKey="ModuleDefinitionsSettingNameLabel"
                                CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtNewSettingName" runat="server" MaxLength="255" Columns="60" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblControlType" runat="server" ForControl="ddNewControlType" ConfigKey="ModuleDefinitionsSettingControlTypeLabel"
                                CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:DropDownList ID="ddNewControlType" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="TextBox" Text="TextBox" />
                                    <asp:ListItem Value="CheckBox" Text="CheckBox" />
                                    <asp:ListItem Value="ISettingControl" Text="ISettingControl" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblControlSrc" runat="server" ForControl="txtNewControlSrc" ConfigKey="ModuleDefinitionsSettingControlSrcLabel"
                                CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtNewControlSrc" runat="server" MaxLength="255" Columns="60" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblSettingValue" runat="server" ForControl="txtNewSettingValue" ConfigKey="ModuleDefinitionsSettingValueLabel"
                                CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtNewSettingValue" runat="server" MaxLength="255" Columns="60"
                                    CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblIsAdvancedSetting" runat="server" ForControl="chbNewIsAdvancedSetting"
                                ConfigKey="ModuleDefinitionsIsAdvancedSettingLabel" CssClass="settinglabel control-label col-sm-3">
                            </gb:SiteLabel>
                            <div class="col-sm-9">
                                <asp:CheckBox ID="chbNewIsAdvancedSetting" runat="server" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblSortOrder" runat="server" ForControl="txtNewSortOrder" ConfigKey="ModuleDefinitionsSettingSortOrderLabel"
                                CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtNewSortOrder" runat="server" Text="500" MaxLength="255" Columns="60"
                                    CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblHelpKey" runat="server" ForControl="txtNewHelpKey" ConfigKey="ModuleDefinitionsSettingHelpKeyLabel"
                                CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtNewHelpKey" runat="server" MaxLength="255" Columns="60" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblRegexValidation" runat="server" ForControl="txtNewRegexValidationExpression"
                                ConfigKey="ModuleDefinitionsSettingRegexExpressionLabel" CssClass="settinglabel control-label col-sm-3">
                            </gb:SiteLabel>
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtNewRegexValidationExpression" runat="server" Rows="4" Columns="60"
                                    TextMode="MultiLine" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                                <asp:Button SkinID="DefaultButton" ID="btnCreateNewSetting" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
