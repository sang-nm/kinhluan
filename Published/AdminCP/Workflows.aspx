<%@ Page CodeBehind="Workflows.aspx.cs" MaintainScrollPositionOnPostback="true"
    Language="c#" MasterPageFile="~/App_MasterPages/layout.Master" AutoEventWireup="false"
    Inherits="CanhCam.Web.AdminUI.WorkflowsPage" EnableEventValidation="false" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, WorkflowLink %>" CurrentPageUrl="~/AdminCP/Workflows.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>"
                        runat="server" ValidationGroup="Workflows" />
                    <asp:HyperLink SkinID="DefaultButton" ID="lnkWorkflowStates" Visible="false" CssClass="active" Text="<%$Resources:Resource, WorkflowStatesLink %>" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" Visible="false" Text="<%$Resources:Resource, DeleteSelectedButton %>"
                        runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <div class="row">
                        <div class="col-md-3">
                            <asp:ListBox ID="lbWorkflows" Width="100%" Height="200" AutoPostBack="true" runat="server"
                                AppendDataBoundItems="true" DataTextField="WorkflowName" DataValueField="WorkflowID" />
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
                                                ConfigKey="WorkflowNameLabel" />
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="txtName" CssClass="form-control" MaxLength="50" runat="server" />
                                                <asp:RequiredFieldValidator ID="reqName" runat="server" SetFocusOnError="true"
                                                    ControlToValidate="txtName" Display="Dynamic" ValidationGroup="Workflows" />
                                            </div>
                                        </div>
                                        <div class="settingrow form-group">
                                            <gb:SiteLabel ID="lblDescription" runat="server" ForControl="txtDescription" CssClass="settinglabel control-label col-sm-3"
                                                ConfigKey="WorkflowDescriptionLabel" />
                                            <div class="col-sm-9">
                                                <asp:TextBox ID="txtDescription" CssClass="form-control" TextMode="MultiLine" MaxLength="50"
                                                    runat="server" />
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblGuid" runat="server" ForControl="txtGuid" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="WorkflowGuidLabel" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtGuid" runat="server" MaxLength="36" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div id="divScope" runat="server" class="settingrow form-group">
                                    <gb:SiteLabel ID="lblScope" runat="server" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="WorkflowScopeLabel" />
                                    <div class="col-sm-9">
                                        <asp:CheckBoxList ID="cklScope" runat="server" />
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
