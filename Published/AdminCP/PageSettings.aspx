<%@ Page Language="c#" MaintainScrollPositionOnPostback="true" CodeBehind="PageSettings.aspx.cs"
    MasterPageFile="~/App_MasterPages/layout.Master" AutoEventWireup="false" Inherits="CanhCam.Web.AdminUI.PageProperties" %>

<%@ Register TagPrefix="portal" TagName="PublishType" Src="~/Controls/PublishTypeSetting.ascx" %>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:PageLayoutDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, PageSettingsLabel %>" CurrentPageUrl="~/AdminCP/PageSettings.aspx"
        ParentTitle="<%$Resources:Resource, PageManagerHeading %>" ParentUrl="~/AdminCP/PageManager.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="DefaultButton" ID="applyBtn" runat="server" Text="Apply Changes" />
            <asp:HyperLink SkinID="DefaultButton" ID="lnkEditContent" Visible="false" EnableViewState="false"
                runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="pagetabs workplace block">
            <div id="divtabs" runat="server" class="tabs">
                <ul class="nav nav-tabs">
                    <li role="presentation" class="active"><a aria-controls="tabSettings" role="tab" data-toggle="tab" href="#tabSettings">
                        <asp:Literal ID="litSettingsTab" runat="server" /></a></li>
                    <li role="presentation" id="liCopyPage" runat="server" enableviewstate="false">
                        <asp:Literal ID="lblCopyPage" runat="server" /></li>
                    <li role="presentation" id="liSecurity" runat="server" enableviewstate="false">
                        <asp:Literal ID="litSecurityTab" runat="server" /></li>
                    <li role="presentation" id="liSitemapTab" runat="server">
                        <asp:Literal ID="litSitemapTab" runat="server" /></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane fade active in" id="tabSettings">
                        <div class="form-horizontal">
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblPageNameLabel" runat="server" ForControl="txtPageName" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsPageNameLabel" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtPageName" runat="server" MaxLength="255" CssClass="forminput verywidetextbox"></asp:TextBox>
                                        <portal:gbHelpLink ID="gbHelpLink2" runat="server" HelpKey="pagesettingspagenamehelp" />
                                    </div>
                                    <asp:RequiredFieldValidator ID="reqPageName" runat="server" Display="Dynamic" ControlToValidate="txtPageName"
                                        ValidationGroup="pagesettings" />
                                    <asp:HiddenField ID="hdnPageName" runat="server" />
                                </div>
                            </div>
                            <div id="divMenuDesc" runat="server" visible="false" class="settingrow form-group">
                                <gb:SiteLabel ID="Sitelabel36" runat="server" ForControl="txtMenuDesc" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="MenuDescription" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtMenuDesc" runat="server" TextMode="MultiLine" CssClass="forminput verywidetextbox"></asp:TextBox>
                                        <portal:gbHelpLink ID="gbHelpLink19" runat="server" HelpKey="pagesettings-menudesc-help" />
                                    </div>
                                </div>
                            </div>
                            <div id="tabSSL" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="lblRequireSSL" runat="server" ForControl="chkRequireSSL" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageLayoutRequireSSLLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkRequireSSL" runat="server"></asp:CheckBox>
                                    <portal:gbHelpLink ID="gbHelpLink18" runat="server" RenderWrapper="false" HelpKey="pagesettingsrequiresslhelp" />
                                </div>
                            </div>
                            <div id="divPublishMode" class="settingrow form-group" runat="server">
                                <gb:SiteLabel ID="SiteLabel30" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="PublishMode" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <portal:PublishType ID="publishType" runat="server" />
                                        <portal:gbHelpLink ID="gbHelpLink38" runat="server" HelpKey="page-settings-publish-mode-help" />
                                    </div>
                                </div>
                            </div>
                            <div id="Div1" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="lblIcon" runat="server" ForControl="txtIcons" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsIconLabel" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <img id="imgIcon" visible="false" alt="" src="/Data/SiteImages/1x1.gif" runat="server" />
                                        <asp:TextBox ID="txtIcons" MaxLength="255" runat="server" />
                                        <portal:FileBrowserTextBoxExtender ID="IconsFileBrowser" runat="server" BrowserType="image" />
                                        <portal:gbHelpLink ID="gbHelpLink6" runat="server" HelpKey="pagesettingsiconhelp" />
                                    </div>
                                </div>
                            </div>
                            <div id="divSkin" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="lblSkin" runat="server" ForControl="ddSkins" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="SiteSettingsSiteSkinLabel" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <portal:SkinList ID="SkinSetting" runat="server" AddSiteDefaultOption="true" />
                                        <portal:gbHelpLink ID="gbHelpLink7" runat="server" HelpKey="pagesettingsskinhelp" />
                                    </div>
                                </div>
                            </div>
                            <div id="divIsClickable" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="lblIsClickable" runat="server" ForControl="chkIsClickable" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsIsClickableLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkIsClickable" runat="server" CssClass="forminput" Checked="true" />
                                    <portal:gbHelpLink ID="gbHelpLink33" runat="server" RenderWrapper="false" HelpKey="pagesettingsisclickablehelp" />
                                </div>
                            </div>
                            <div id="Div2" visible="false" runat="server" class="settingrow form-group sitemapsettingrow">
                                <gb:SiteLabel ID="Sitelabel12" runat="server" ForControl="chkAllowBrowserCache" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsAllowBrowserCacheLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkAllowBrowserCache" runat="server" />
                                    <portal:gbHelpLink ID="gbHelpLink8" runat="server" RenderWrapper="false" HelpKey="pagesettingsallowbrowsercachehelp" />
                                </div>
                            </div>
                            <div id="Div3" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="Sitelabel10" runat="server" ForControl="chkIncludeInMenu" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsIncludeInMenuLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkIncludeInMenu" runat="server" CssClass="forminput" Checked="true" />
                                    <portal:gbHelpLink ID="gbHelpLink9" runat="server" RenderWrapper="false" HelpKey="pagesettingsincludeinmenuhelp" />
                                </div>
                            </div>
                            <div id="Div4" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="Sitelabel16" runat="server" ForControl="chkIncludeInSiteMap" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsIncludeInSiteMapLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkIncludeInSiteMap" runat="server" CssClass="forminput" Checked="true" />
                                    <portal:gbHelpLink ID="gbHelpLink10" runat="server" RenderWrapper="false" HelpKey="pagesettingsincludeinsitemaphelp" />
                                </div>
                            </div>
                            <div id="Div5" visible="false" runat="server" class="settingrow form-group expandonsitemap">
                                <gb:SiteLabel ID="Sitelabel29" runat="server" ForControl="chkExpandOnSiteMap" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsExpandOnSiteMapLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkExpandOnSiteMap" runat="server" CssClass="forminput" Checked="true" />
                                    <portal:gbHelpLink ID="gbHelpLink37" runat="server" RenderWrapper="false" HelpKey="pagesettings-expandonsitemap-help" />
                                </div>
                            </div>
                            <div id="Div6" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="Sitelabel26" runat="server" ForControl="chkIncludeInChildSiteMap"
                                    CssClass="settinglabel control-label col-sm-3" ConfigKey="PageSettingsIncludeInChildSiteMap" />
                                <div class="col-sm-9">
                                <asp:CheckBox ID="chkIncludeInChildSiteMap" runat="server" CssClass="forminput" Checked="true" />
                                <portal:gbHelpLink ID="gbHelpLink34" runat="server" RenderWrapper="false" HelpKey="pagesettings-includeinchildsitemap-help" />
                            </div>
                            </div>
                            <div id="divIsPending" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="Sitelabel19" runat="server" ForControl="chkIsPending" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsIsPendingLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkIsPending" runat="server" Checked="false" />
                                    <portal:gbHelpLink ID="gbHelpLink29" runat="server" RenderWrapper="false" HelpKey="pagesettingsisdrafthelp" />
                                </div>
                            </div>
                            <div class="settingrow form-group breadcrumbsetting">
                                <gb:SiteLabel ID="Sitelabel1" runat="server" ForControl="chkShowBreadcrumbs" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageLayoutShowBreadcrumbsLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkShowBreadcrumbs" runat="server" Checked="true" />
                                    <portal:gbHelpLink ID="gbHelpLink11" runat="server" RenderWrapper="false" HelpKey="pagesettingsbreadcrumbshelp" />
                                </div>
                            </div>
                            <div class="settingrow form-group breadcrumbsetting">
                                <gb:SiteLabel ID="Sitelabel17" runat="server" ForControl="chkShowHomeCrumb" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="ShowHomePageCrumb" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkShowHomeCrumb" runat="server" Checked="true" />
                                    <portal:gbHelpLink ID="gbHelpLink13" runat="server" RenderWrapper="false" HelpKey="pagesettingshomecrumbhelp" />
                                </div>
                            </div>
                            <div class="settingrow form-group breadcrumbsetting">
                                <gb:SiteLabel ID="Sitelabel7" runat="server" ForControl="chkShowChildPageBreadcrumbs"
                                    CssClass="settinglabel control-label col-sm-3" ConfigKey="PageLayoutShowChildBreadcrumbsLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkShowChildPageBreadcrumbs" runat="server" />
                                    <portal:gbHelpLink ID="gbHelpLink12" runat="server" RenderWrapper="false" HelpKey="pagesettingschildpagebreadcrumbshelp" />
                                </div>
                            </div>
                            <div id="Div7" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="Sitelabel4" runat="server" ForControl="chkNewWindow" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageLayoutOpenInNewWindowLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkNewWindow" runat="server" />
                                    <portal:gbHelpLink ID="gbHelpLink14" runat="server" RenderWrapper="false" HelpKey="pagesettingsnewwindowhelp" />
                                </div>
                            </div>
                            <div id="Div8" visible="false" runat="server" class="settingrow form-group ShowChildMenu">
                                <gb:SiteLabel ID="Sitelabel5" runat="server" ForControl="chkShowChildMenu" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageLayoutShowChildMenuLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkShowChildMenu" runat="server" />
                                    <portal:gbHelpLink ID="gbHelpLink15" runat="server" RenderWrapper="false" HelpKey="pagesettingschildpagemenuhelp" />
                                </div>
                            </div>
                            <div id="divHideMenu" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="Sitelabel9" runat="server" ForControl="chkHideMainMenu" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageLayoutHideMenuLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkHideMainMenu" runat="server" />
                                    <portal:gbHelpLink ID="gbHelpLink16" runat="server" RenderWrapper="false" HelpKey="pagesettingshidemenuhelp" />
                                </div>
                            </div>
                            <div id="Div9" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel ID="Sitelabel13" runat="server" ForControl="chkHideAfterLogin" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingstHideAfterLoginLabel" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkHideAfterLogin" runat="server" />
                                    <portal:gbHelpLink ID="gbHelpLink17" runat="server" RenderWrapper="false" HelpKey="pagesettingshideafterloginhelp" />
                                </div>
                            </div>
                            <asp:Panel ID="pnlComments" runat="server" Visible="false" CssClass="settingrow form-group">
                                <gb:SiteLabel ID="Sitelabel24" runat="server" ForControl="chkEnableComments" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsEnableComments" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkEnableComments" runat="server" />
                                    <portal:gbHelpLink ID="gbHelpLink32" runat="server" RenderWrapper="false" HelpKey="pagesettings-enablecomments-help" />
                                </div>
                            </asp:Panel>
                            <div id="divBodyCss" runat="server" class="settingrow form-group bodycss">
                                <gb:SiteLabel ID="SiteLabel27" runat="server" ForControl="txtBodyCssClass" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsBodyCssClass" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtBodyCssClass" runat="server" MaxLength="50" CssClass="forminput normaltextbox"></asp:TextBox>
                                        <portal:gbHelpLink ID="gbHelpLink35" runat="server" HelpKey="pagesettings-bodycssclass-help" />
                                    </div>
                                    <asp:RegularExpressionValidator ID="regexBodyCss" runat="server" ControlToValidate="txtBodyCssClass"
                                        ValidationExpression="^([\s]?[a-zA-Z]+[_\-a-zA-Z0-9]+)*\z+" Display="None" ValidationGroup="pagesettings" />
                                </div>
                            </div>
                            <asp:Panel ID="pnlModified" runat="server" EnableViewState="false" Visible="false">
                                <div class="settingrow form-group pcreateddate">
                                    <gb:SiteLabel ID="Sitelabel31" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="Created" />
                                    <div class="col-sm-9">
                                        <p class="form-control-static">
                                            <asp:Label ID="lblCreatedDate" runat="server" CssClass="readonly" />
                                        </p>
                                    </div>
                                </div>
                                <div class="settingrow form-group pmodifieddate">
                                    <gb:SiteLabel ID="Sitelabel32" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="LastModified" />
                                    <div class="col-sm-9">
                                        <p class="form-control-static">
                                            <asp:Label ID="lblLastModifiedDate" runat="server" CssClass="readonly" />
                                        </p>
                                    </div>
                                </div>
                                <div class="settingrow form-group pmodby">
                                    <gb:SiteLabel ID="Sitelabel33" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="LastModifiedBy" />
                                    <div class="col-sm-9">
                                        <p class="form-control-static">
                                            <asp:Label ID="lblLastModifiedBy" runat="server" CssClass="readonly" />
                                        </p>
                                    </div>
                                </div>
                                <div class="settingrow form-group pmodfromip">
                                    <gb:SiteLabel ID="Sitelabel34" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="LastModifiedFromIpAddress" />
                                    <div class="col-sm-9">
                                        <p class="form-control-static">
                                            <asp:Label ID="lblLastModifiedFromIp" runat="server" CssClass="readonly" />
                                        </p>
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="tabCopyPage" runat="server">
                        <asp:UpdatePanel ID="upCopyPage" UpdateMode="Conditional" runat="server" EnableViewState="true">
                            <ContentTemplate>
                                <div class="form-horizontal">
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="lblPage" runat="server" ForControl="ddPages" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="PageLayoutCopyPageLabel" />
                                        <div class="col-sm-9">
                                            <asp:DropDownList ID="ddPages" runat="server" DataTextField="PageName" DataValueField="PageID"
                                                AutoPostBack="true" CssClass="forminput">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <telerik:RadGrid ID="grdContent" SkinID="radGridSkin" runat="server">
                                    <MasterTableView DataKeyNames="ModuleID,Guid,FeatureGuid,PaneName,PageID,ModuleOrder" ShowHeader="false" AllowPaging="false" AllowSorting="false">
                                        <Columns>
                                            <telerik:GridTemplateColumn>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkChecked" Checked="true" runat="server" EnableViewState="true" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn>
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtModuleTitle" MaxLength="255" Text='<%# Eval("ModuleTitle") %>'
                                                        runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn>
                                                <ItemTemplate>
                                                    <%# GetPaneAlias(Eval("PaneName"))%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn>
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdbNew" runat="server" Checked='<%#!(bool)Eval("IsGlobal") %>'
                                                        GroupName="Module" Text="<%$Resources:Resource, PageLayoutCopyPageNew %>" />
                                                    <asp:RadioButton ID="rdbReference" runat="server" Checked='<%#(bool)Eval("IsGlobal") %>'
                                                        GroupName="Module" Text="<%$Resources:Resource, PageLayoutCopyPageReference %>" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="tabSecurity" runat="server">
                        <div id="divRoles" runat="server" class="accordion">
                            <h3 id="h3ViewRoles" runat="server">
                                <a href="#">
                                    <gb:SiteLabel ID="lblAuthorizedRoles" runat="server" ConfigKey="PageLayoutViewRolesLabel"
                                        UseLabelTag="false" />
                                </a>
                            </h3>
                            <div id="divViewRoles" runat="server">
                                <div class="mrb10">
                                    <asp:RadioButton ID="rbViewAdminOnly" runat="server" GroupName="rdoviewroles" CssClass="rbroles rbadminonly" />
                                </div>
                                <div class="mrb10">
                                    <asp:RadioButton ID="rbViewUseRoles" runat="server" GroupName="rdoviewroles" CssClass="rbroles" />
                                </div>
                                <div class="mrb10">
                                    <asp:CheckBoxList ID="chkListAuthRoles" runat="server" CssClass="forminput" SkinID="Roles">
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                            <h3 id="h3EditRoles" runat="server">
                                <a href="#">
                                    <gb:SiteLabel ID="SiteLabel21" runat="server" ConfigKey="PageLayoutEditRolesLabel"
                                        UseLabelTag="false" />
                                </a>
                            </h3>
                            <div id="divEditRoles" runat="server">
                                <div class="mrb10">
                                    <asp:RadioButton ID="rbEditAdminOnly" runat="server" GroupName="rdoeditroles" CssClass="rbroles rbadminonly" />
                                </div>
                                <div class="mrb10">
                                    <asp:RadioButton ID="rbEditUseRoles" runat="server" GroupName="rdoeditroles" CssClass="rbroles" />
                                </div>
                                <div class="mrb10">
                                    <asp:CheckBoxList ID="chkListEditRoles" runat="server" CssClass="forminput" SkinID="Roles">
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                            <h3 id="h3DraftRoles" runat="server">
                                <a href="#">
                                    <gb:SiteLabel ID="SiteLabel6" runat="server" ConfigKey="PageLayoutDraftEditRolesLabel"
                                        UseLabelTag="false" />
                                </a>
                            </h3>
                            <div id="divDraftRoles" runat="server">
                                <div class="mrb10">
                                    <asp:CheckBoxList ID="chkDraftEditRoles" runat="server" SkinID="Roles">
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                            <h3 id="h3ChildEditRoles" runat="server">
                                <a href="#">
                                    <gb:SiteLabel ID="SiteLabel18" runat="server" ConfigKey="PageLayoutCreateChildPageRolesLabel"
                                        UseLabelTag="false" />
                                </a>
                            </h3>
                            <div id="divChildEditRoles" runat="server">
                                <div class="mrb10">
                                    <asp:RadioButton ID="rbCreateChildAdminOnly" runat="server" GroupName="rdochildpageroles"
                                        CssClass="rbroles rbadminonly" />
                                </div>
                                <div class="mrb10">
                                    <asp:RadioButton ID="rbCreateChildUseRoles" runat="server" GroupName="rdochildpageroles"
                                        CssClass="rbroles" />
                                </div>
                                <div class="mrb10">
                                    <asp:CheckBoxList ID="chkListCreateChildPageRoles" runat="server" SkinID="Roles"
                                        CssClass="forminput">
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                        </div>
                        <div id="divRoleLinks" runat="server" visible="false" enableviewstate="false">
                            <ul class="simplelist">
                                <li>
                                    <asp:HyperLink ID="lnkPageViewRoles" runat="server" CssClass="lnkPageViewRoles" />
                                </li>
                                <li>
                                    <asp:HyperLink ID="lnkPageEditRoles" runat="server" CssClass="lnkPageEditRoles" />
                                </li>
                                <li>
                                    <asp:HyperLink ID="lnkPageDraftRoles" runat="server" CssClass="lnkPageDraftRoles" />
                                </li>
                                <li>
                                    <asp:HyperLink ID="lnkChildPageRoles" runat="server" CssClass="lnkChildPageRoles" />
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="tabSitemap" runat="server">
                        <asp:Panel ID="pnlSearchEngineOptimization" runat="server" SkinID="plain">
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="SiteLabel14" runat="server" ForControl="ddChangeFrequency" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsChangeFrequencyLabel" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddChangeFrequency" runat="server" CssClass="forminput" />
                                        <portal:gbHelpLink ID="gbHelpLink26" runat="server" HelpKey="pagesettingsseochangefequencyhelp" />
                                    </div>
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="SiteLabel15" runat="server" ForControl="ddSiteMapPriority" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PageSettingsPriorityLabel" />
                                <div class="col-sm-9">
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddSiteMapPriority" runat="server" CssClass="forminput">
                                            <asp:ListItem Text="0.0" Value="0.0" />
                                            <asp:ListItem Text="0.1" Value="0.1" />
                                            <asp:ListItem Text="0.2" Value="0.2" />
                                            <asp:ListItem Text="0.3" Value="0.3" />
                                            <asp:ListItem Text="0.4" Value="0.4" />
                                            <asp:ListItem Text="0.5" Value="0.5" Selected="true" />
                                            <asp:ListItem Text="0.6" Value="0.6" />
                                            <asp:ListItem Text="0.7" Value="0.7" />
                                            <asp:ListItem Text="0.8" Value="0.8" />
                                            <asp:ListItem Text="0.9" Value="0.9" />
                                            <asp:ListItem Text="1.0" Value="1.0" />
                                        </asp:DropDownList>
                                        <portal:gbHelpLink ID="gbHelpLink27" runat="server" HelpKey="pagesettingssitemappriorityhelp" />
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="SiteLabel22" runat="server" ForControl="chkIncludeInSearchEngineSiteMap"
                                CssClass="settinglabel control-label col-sm-3" ConfigKey="PageSettingsIncludeInSearchengineSiteMap" />
                            <div class="col-sm-9">
                                <asp:CheckBox ID="chkIncludeInSearchEngineSiteMap" runat="server" Checked="true"
                                    CssClass="forminput" />
                                <portal:gbHelpLink ID="gbHelpLink30" runat="server" HelpKey="pagesettings-IncludeInSearchEngineSiteMap-help" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>