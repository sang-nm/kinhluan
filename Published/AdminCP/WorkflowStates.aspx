<%@ Page CodeBehind="WorkflowStates.aspx.cs" MaintainScrollPositionOnPostback="true"
    Language="c#" MasterPageFile="~/App_MasterPages/layout.Master" AutoEventWireup="false"
    Inherits="CanhCam.Web.AdminUI.WorkflowStatesPage" EnableEventValidation="false" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, WorkflowStatesLink %>" CurrentPageUrl="~/AdminCP/WorkflowStates.aspx"
        ParentTitle="<%$Resources:Resource, WorkflowLink %>" ParentUrl="~/AdminCP/Workflows.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>"
                        runat="server" ValidationGroup="Workflows" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" Visible="false" Text="<%$Resources:Resource, DeleteSelectedButton %>"
                        runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="input-group">
                                <asp:ListBox ID="lbStates" Width="100%" Height="200" AutoPostBack="true" runat="server"
                                    AppendDataBoundItems="true" DataTextField="StateName" DataValueField="StateID" />
                                <div class="input-group-addon">
                                    <ul class="nav sorter">
                                        <li><asp:LinkButton ID="btnUp" CommandName="up" runat="server"><i class="fa fa-angle-up"></i></asp:LinkButton></li>
                                        <li><asp:LinkButton ID="btnDown" CommandName="down" runat="server"><i class="fa fa-angle-down"></i></asp:LinkButton></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="form-horizontal">
                                <asp:UpdatePanel ID="up" runat="server">
                                    <ContentTemplate>
                                        <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                                            EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                            CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                                        <div class="settingrow form-group">
                                            <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3"
                                                ConfigKey="WorkflowStateNameLabel" />
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="txtName" CssClass="form-control" MaxLength="50"
                                                    runat="server" />
                                                <asp:RequiredFieldValidator ID="reqStateName" runat="server" SetFocusOnError="true"
                                                    ControlToValidate="txtName" Display="Dynamic" ValidationGroup="Workflows" />
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblStateReviewRoles" runat="server" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="WorkflowStatesReviewRolesLabel" />
                                    <div class="col-sm-9">
                                        <asp:CheckBoxList ID="chklReviewRoles" SkinID="Roles" runat="server" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblStateIsActive" runat="server" ForControl="chbStateIsActive" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="WorkflowStatesIsActiveLabel" />
                                    <div class="col-sm-9">
                                        <asp:CheckBox ID="chkStateIsActive" Checked="true" runat="server" />
                                    </div>
                                </div>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblStateNotifyTemplate" runat="server" ForControl="ddStateNotifyTemplate" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="WorkflowStatesNotifyTemplateLabel" />
                                    <div class="col-sm-9">
                                        <asp:DropDownList ID="ddStateNotifyTemplate" AppendDataBoundItems="true" DataTextField="Name" DataValueField="SystemCode" runat="server" />
                                    </div>
                                </div>
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
