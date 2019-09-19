<%@ Page Language="c#" CodeBehind="PageLayout.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.AdminUI.PageLayout" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:PageLayoutDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, PageLayoutPageTitle %>" CurrentPageUrl="~/AdminCP/PageLayout.aspx"
        ParentTitle="<%$Resources:Resource, PageManagerHeading %>" ParentUrl="~/AdminCP/PageManager.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <div id="divAdminLinks" runat="server">
                <asp:HyperLink SkinID="DefaultButton" ID="lnkEditSettings" EnableViewState="false" runat="server" />
                <asp:HyperLink SkinID="DefaultButton" ID="lnkPageTree" runat="server" />
            </div>
        </portal:HeadingPanel>
        <asp:Panel ID="pnlContent" CssClass="pagelayout workplace" runat="server" Visible="False">
            <asp:UpdatePanel ID="upLayout" UpdateMode="Conditional" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div id="divAddContent" runat="server" class="col-sm-5">
                            <h4>
                                <gb:SiteLabel ID="lblAddModule" runat="server" ConfigKey="PageLayoutAddModuleLabel" UseLabelTag="false" />
                            </h4>
                            <div class="form-horizontal">
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblModuleType" runat="server" ForControl="moduleType" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="PageLayoutModuleTypeLabel" />
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <asp:DropDownList ID="moduleType" runat="server" EnableTheming="false" CssClass="forminput"
                                                DataValueField="ModuleDefID" DataTextField="FeatureName">
                                            </asp:DropDownList>
                                            <portal:gbHelpLink ID="gbHelpLink1" runat="server" HelpKey="pagelayoutmoduletypehelp" />
                                        </div>
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblModuleName" runat="server" ForControl="moduleTitle" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="PageLayoutModuleNameLabel" />
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <asp:TextBox ID="moduleTitle" runat="server" CssClass="widetextbox forminput" Text=""
                                                EnableViewState="false"></asp:TextBox>
                                            <portal:gbHelpLink ID="gbHelpLink2" runat="server" HelpKey="pagelayoutmodulenamehelp" />
                                        </div>
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="SiteLabel2" runat="server" ForControl="ddPaneNames" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="PageLayoutLocationLabel" />
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <asp:DropDownList ID="ddPaneNames" runat="server" EnableTheming="false" CssClass="forminput"
                                                DataTextField="key" DataValueField="value">
                                            </asp:DropDownList>
                                            <portal:gbHelpLink ID="gbHelpLink3" runat="server" HelpKey="pagelayoutmodulelocationhelp" />
                                        </div>
                                        <asp:HyperLink ID="lnkGlobalContent" CssClass="cp-link" runat="server" Visible="false" />
                                        <asp:HiddenField ID="hdnModuleID" runat="server" />
                                        <asp:ImageButton ID="btnAddExisting" runat="server" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblOrganizeModules" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="EmptyLabel"
                                        UseLabelTag="false" />
                                    <div class="col-sm-9">
                                        <asp:Button SkinID="DefaultButton" ID="btnCreateNewContent" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-7">
                            <h4>
                                <gb:SiteLabel ID="lblPageLayoutCopyExistModule" runat="server" ConfigKey="PageLayoutCopyExistModuleLabel"
                                    UseLabelTag="false" />
                            </h4>
                            <div class="form-horizontal">
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblPage" runat="server" ForControl="ddlPages" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="PageLayoutCopyPageLabel" />
                                    <div class="col-sm-9">
                                        <div class="input-group">
                                            <asp:DropDownList ID="ddlPages" runat="server" DataTextField="PageName" DataValueField="PageID"
                                                AutoPostBack="true" CssClass="forminput" />
                                            <portal:gbHelpLink ID="gbHelpLink20" runat="server" HelpKey="pagesettingscopypagehelp" />
                                        </div>
                                    </div>
                                </div>
                                <div id="divAddExistContent" runat="server" visible="false">
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel3" runat="server" ForControl="ddlPageModules" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="PageLayoutModuleTypeLabel" />
                                        <div class="col-sm-9">
                                            <asp:DropDownList ID="ddlPageModules" AutoPostBack="true" runat="server" EnableTheming="false"
                                                CssClass="forminput" DataTextField="ModuleTitle" DataValueField="ModuleID">
                                            </asp:DropDownList>
                                            <asp:Literal ID="litFeatureName" runat="server" />
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel5" runat="server" ForControl="txtModuleTitle" CssClass="settinglabel control-label col-sm-3"
                                            ConfigKey="PageLayoutModuleNameLabel" />
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <asp:TextBox ID="txtModuleTitle" runat="server" CssClass="widetextbox forminput"
                                                    Text="" EnableViewState="false"></asp:TextBox>
                                                <portal:gbHelpLink ID="gbHelpLink4" runat="server" HelpKey="pagelayoutmodulenamehelp" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel4" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="EmptyLabel"
                                            UseLabelTag="false" />
                                        <div class="col-sm-9">
                                            <asp:RadioButton ID="rdbNew" runat="server" GroupName="Module" Text="<%$Resources:Resource, PageLayoutCopyPageNew %>" />
                                            <asp:RadioButton ID="rdbReference" runat="server" GroupName="Module" Text="<%$Resources:Resource, PageLayoutCopyPageReference %>" />
                                        </div>
                                    </div>
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel ID="SiteLabel6" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="EmptyLabel"
                                            UseLabelTag="false" />
                                        <div class="col-sm-9">
                                            <asp:Button SkinID="DefaultButton" ID="btnCreateExistContent" Text="<%$Resources:Resource, ContentManagerCopyContentButton %>"
                                                runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panelayout">
                        <div visible="false" runat="server" class="altlayoutnotice">
                            <asp:Literal ID="litEditNotes" runat="server" />
                        </div>
                        <asp:Panel class="altlayoutnotice" ID="divAltLayoutNotice" runat="server" SkinID="notice">
                            <asp:Literal ID="litAltLayoutNotice" runat="server" />
                        </asp:Panel>
                        <div class="row pane layoutalt1" id="divAltPanel1" runat="server">
                            <div class="col-sm-3 col-sm-offset-4">
                                <gb:SiteLabel ID="lblAltPanel1" runat="server" CssClass="control-label" ConfigKey="PageLayoutAltPanel1Label" />
                                <div class="form-group panelistbox">
                                    <div class="input-group">
                                        <asp:ListBox ID="lbAltContent1" runat="server" CssClass="form-control" DataValueField="ModuleID" DataTextField="ModuleTitle"
                                            Rows="9" />
                                        <div class="input-group-addon layoutbuttons">
                                            <ul class="nav sorter">
                                                <li>
                                                    <asp:LinkButton ID="btnAlt1MoveUp" runat="server"
                                                        CommandName="up" CommandArgument="altcontent1" SkinID="pageLayoutMoveUp" CssClass="btnup"><i class="fa fa-angle-up"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="btnAlt1MoveDown" runat="server"
                                                        CommandName="down" CommandArgument="altcontent1" SkinID="pageLayoutMoveDown"
                                                        CssClass="btndown"><i class="fa fa-angle-down"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="btnMoveAlt1ToCenter" runat="server"
                                                        CssClass="btndownpanel" SkinID="pageLayoutItemMoveDown"><i class="fa fa-angle-double-down"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="btnEditAlt1" runat="server" CommandName="edit" CommandArgument="lbAltContent1"
                                                        CssClass="btnedit" SkinID="pageLayoutEditSettings"><i class="fa fa-cog"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="btnDeleteAlt1" runat="server" CommandName="delete" CommandArgument="lbAltContent1"
                                                        SkinID="pageLayoutDeleteItem" CssClass="btnremove"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row regularpanes">
                            <div class="col-sm-3 col-sm-offset-1 pane layoutleft">
                                <gb:SiteLabel ID="lblLeftPane" runat="server" CssClass="control-label" ConfigKey="PageLayoutLeftPaneLabel" />
                                <div class="form-group panelistbox">
                                    <div class="input-group">
                                        <asp:ListBox ID="leftPane" runat="server" DataValueField="ModuleID" DataTextField="ModuleTitle"
                                            Rows="10" />
                                        <div class="input-group-addon layoutbuttons">
                                            <ul class="nav sorter">
                                                <li>
                                                    <asp:LinkButton ID="LeftUpBtn" runat="server"
                                                        CommandName="up" CommandArgument="LeftPane" SkinID="pageLayoutMoveUp" CssClass="btnup"><i class="fa fa-angle-up"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="LeftDownBtn" runat="server"
                                                        CommandName="down" CommandArgument="LeftPane" SkinID="pageLayoutMoveDown" CssClass="btndown"><i class="fa fa-angle-down"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="LeftRightBtn" runat="server"
                                                        CommandName="right" SkinID="pageLayoutMoveItemRight" CssClass="btnright"><i class="fa fa-angle-double-right"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="LeftEditBtn" runat="server" CommandName="edit" CommandArgument="LeftPane"
                                                        SkinID="pageLayoutEditSettings" CssClass="btnedit"><i class="fa fa-cog"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="LeftDeleteBtn" runat="server" CommandName="delete" CommandArgument="LeftPane"
                                                        SkinID="pageLayoutDeleteItem" CssClass="btnremove"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3 pane layoutcenter">
                                <gb:SiteLabel ID="lblContentPane" runat="server" CssClass="control-label" ConfigKey="PageLayoutContentPaneLabel" />
                                <div class="form-group panelistbox">
                                    <div class="input-group">
                                        <asp:ListBox ID="contentPane" runat="server" DataValueField="ModuleID" DataTextField="ModuleTitle"
                                            Rows="10" />
                                        <div class="input-group-addon layoutbuttons">
                                            <ul class="nav sorter">
                                                <li>
                                                    <asp:LinkButton ID="ContentUpBtn" runat="server"
                                                        CommandName="up" CommandArgument="ContentPane" SkinID="pageLayoutMoveUp" CssClass="btnup"><i class="fa fa-angle-up"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="ContentDownBtn" runat="server"
                                                        CommandName="down" CommandArgument="ContentPane" SkinID="pageLayoutMoveDown"
                                                        CssClass="btndown"><i class="fa fa-angle-down"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="ContentLeftBtn" runat="server"
                                                        SkinID="pageLayoutMoveItemLeft" CssClass="btnleft"><i class="fa fa-angle-double-left"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="ContentRightBtn" runat="server"
                                                        SkinID="pageLayoutMoveItemRight" CssClass="btnright"><i class="fa fa-angle-double-right"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="ContentUpToNextButton" runat="server"
                                                        CommandName="uptoalt1" CommandArgument="ContentPane" SkinID="pageLayoutMoveItemUp"
                                                        CssClass="btnuppanel"><i class="fa fa-angle-double-up"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="ContentDownToNextButton" runat="server"
                                                        CommandName="downtoalt2" CommandArgument="ContentPane" SkinID="pageLayoutItemMoveDown"
                                                        CssClass="btndownpanel"><i class="fa fa-angle-double-down"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="ContentEditBtn" runat="server" CommandName="edit" CommandArgument="ContentPane"
                                                        SkinID="pageLayoutEditSettings" CssClass="btnedit"><i class="fa fa-cog"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="ContentDeleteBtn" runat="server" CommandName="delete" CommandArgument="ContentPane"
                                                        SkinID="pageLayoutDeleteItem" CssClass="btnremove"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3 pane layoutright">
                                <gb:SiteLabel ID="lblRightPane" runat="server" CssClass="control-label" ConfigKey="PageLayoutRightPaneLabel" />
                                <div class="form-group panelistbox">
                                    <div class="input-group">
                                        <asp:ListBox ID="rightPane" runat="server" DataValueField="ModuleID" DataTextField="ModuleTitle"
                                            Rows="10" />
                                        <div class="input-group-addon layoutbuttons">
                                            <ul class="nav sorter">
                                                <li>
                                                    <asp:LinkButton ID="RightUpBtn" runat="server"
                                                        CommandName="up" CommandArgument="RightPane" SkinID="pageLayoutMoveUp" CssClass="btnup"><i class="fa fa-angle-up"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="RightDownBtn" runat="server"
                                                        CommandName="down" CommandArgument="RightPane" SkinID="pageLayoutMoveDown" CssClass="btndown"><i class="fa fa-angle-down"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="RightLeftBtn" runat="server"
                                                        SkinID="pageLayoutMoveItemLeft" CssClass="btnleft"><i class="fa fa-angle-double-left"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="RightEditBtn" runat="server" CommandName="edit" CommandArgument="RightPane"
                                                        SkinID="pageLayoutEditSettings" CssClass="btnedit"><i class="fa fa-cog"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="RightDeleteBtn" runat="server" CommandName="delete" CommandArgument="RightPane"
                                                        SkinID="pageLayoutDeleteItem" CssClass="btnremove"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row pane layoutalt2" id="divAltPanel2" runat="server">
                            <div class="col-sm-3 col-sm-offset-4">
                                <gb:SiteLabel ID="lblAltLayout2" runat="server" CssClass="control-label" ConfigKey="PageLayoutAltPanel2Label" />
                                <div class="form-group panelistbox">
                                    <div class="input-group">
                                        <asp:ListBox ID="lbAltContent2" runat="server" DataValueField="ModuleID" DataTextField="ModuleTitle"
                                            Rows="9" />
                                        <div class="input-group-addon layoutbuttons">
                                            <ul class="nav sorter">
                                                <%--<li>
                                                <asp:LinkButton ID="btnMoveAlt2ToAlt1" runat="server" />
                                                </li>--%>
                                                <li>
                                                    <asp:LinkButton ID="btnAlt2MoveUp" runat="server"
                                                        CommandName="up" CommandArgument="AltContent2" SkinID="pageLayoutMoveUp" CssClass="btnup"><i class="fa fa-angle-up"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="btnAlt2MoveDown" runat="server"
                                                        CommandName="down" CommandArgument="AltContent2" SkinID="pageLayoutMoveDown"
                                                        CssClass="btndown"><i class="fa fa-angle-down"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="btnMoveAlt2ToCenter" runat="server"
                                                        SkinID="pageLayoutMoveItemUp" CssClass="btnuppanel"><i class="fa fa-angle-double-up"></i></asp:LinkButton>
                                                </li>
                                                <li>
                                                    <asp:LinkButton ID="btnEditAlt2" runat="server" CommandName="edit" CommandArgument="lbAltContent2"
                                                        SkinID="pageLayoutEditSettings" CssClass="btnedit"><i class="fa fa-cog"></i></asp:LinkButton>
                                                <li>
                                                </li>
                                                    <asp:LinkButton ID="btnDeleteAlt2" runat="server" CommandName="delete" CommandArgument="lbAltContent2"
                                                        SkinID="pageLayoutDeleteItem" CssClass="btnremove"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
    </div>
</asp:Content>