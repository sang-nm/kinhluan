<%@ Page ValidateRequest="false" Language="c#" CodeBehind="FormResults.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.FormWizard.Web.UI.FormResultsPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:FormWizardResources, FormEditPageTitle %>" CurrentPageUrl="~/FormWizard/FormEdit.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="DeleteButton" ID="btnDeleteSelected" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" />
        </portal:HeadingPanel>
        <div class="workplace">
            <asp:Panel ID="pnlNoResults" CssClass="mrt10" runat="server">
                <asp:Literal ID="litNoResults" runat="server" Text="<%$Resources:FormWizardResources, NoResultsMessage %>" />
            </asp:Panel>
            <asp:Panel ID="pnlResults" runat="server">
                <div class="mrt10">
                    <asp:Button SkinID="DefaultButton" ID="btnExport" runat="server" />
                    <asp:ImageButton ID="btnExport2" runat="server" />
                    <asp:Button SkinID="DefaultButton" ID="btnExportToWord" runat="server" />
                    <asp:ImageButton ID="btnExportToWord2" runat="server" />
                    <asp:HyperLink ID="lnkGridBrowser" Visible="false" CssClass="cp-link gb-popup" runat="server" />
                    <asp:HyperLink ID="lnkDetailBrowse" CssClass="cp-link gb-popup" runat="server" />
                    <asp:Literal ID="litSubmissionCountLabel" Text="<%$Resources:FormWizardResources, SubmissionCountLabel %>" runat="server" />: 
                    <asp:Literal ID="litSubmissionCount" runat="server"></asp:Literal>
                </div>
                <telerik:RadGrid ID="grdResults" SkinID="radGridSkin" runat="server">
                    <MasterTableView DataKeyNames="Code" AllowSorting="false" AutoGenerateColumns="true">
                        <Columns>
                            <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </asp:Panel>
            <asp:Panel ID="pnlOrphans" CssClass="mrt10 row" runat="server">
                <div class="col-sm-6">
                    <asp:Button SkinID="DefaultButton" ID="btnDeleteOrphans" runat="server" />
                    <asp:Button SkinID="DefaultButton" ID="btnExportOrphans" runat="server" />
                    <asp:ImageButton ID="btnExportOrphans2" runat="server" />
                    <portal:gbHelpLink ID="GbHelpLink1" runat="server" RenderWrapper="false" HelpKey="FormWizard-Orphans-help" />
                </div>
                <div class="col-sm-6 text-right">
                    <asp:Literal Text="<%$Resources:FormWizardResources, OrphanCountLabel %>" runat="server" />: 
                    <asp:Literal ID="litOrphanCount" runat="server" />
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />