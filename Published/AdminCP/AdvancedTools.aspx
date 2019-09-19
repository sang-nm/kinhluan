<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdvnacedTools.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdvnacedToolsPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, AdvancedToolsLink %>" CurrentPageUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="workplace">
            <div class="metromini">
                <div class="row">
                    <div class="col-sm-12">
                        <div id="divUrlManager" class="item" runat="server">
                            <asp:Literal ID="litUrlManager" runat="server" />
                        </div>
                        <div id="divRedirectManager" class="item" runat="server">
                            <asp:Literal ID="litRedirectManager" runat="server" />
                        </div>
                        <div id="divBannedIPs" class="item" runat="server">
                            <asp:Literal ID="litBannedIPs" runat="server" />
                        </div>
                        <div id="divFeatureAdmin" class="item" runat="server">
                            <asp:Literal ID="litFeatureAdmin" runat="server" />
                        </div>
                        <div id="divTaskQueue" class="item" runat="server">
                            <asp:Literal ID="litTaskQueue" runat="server" />
                        </div>
                        <div id="divDesignTools" class="item" runat="server">
                            <asp:Literal ID="litDesignTools" runat="server" />
                        </div>
                        <div id="divDevTools" class="item" runat="server">
                            <asp:Literal ID="litDevTools" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" 
    runat="server" >
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" 
    runat="server" >
</asp:Content>

