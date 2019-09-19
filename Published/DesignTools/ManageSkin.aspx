<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ManageSkin.aspx.cs" Inherits="CanhCam.Web.AdminUI.ManageSkinPage" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:DevTools, SkinManagement %>" CurrentPageUrl="~/DesignTools/SkinList.aspx"
        ParentTitle="<%$Resources:DevTools, DesignTools %>" ParentUrl="~/DesignTools/Default.aspx"
        RootTitle="<%$Resources:Resource, AdvancedToolsLink %>" RootUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="headInfo">
            <div class="input-group">
                <asp:TextBox ID="txtCopyAs" runat="server" CssClass="form-control" />
                <div class="input-group-btn">
                    <asp:Button SkinID="DefaultButton" ID="btnCopy" runat="server" />
                </div>
                <portal:gbHelpLink ID="gbHelpLink2" runat="server"  HelpKey="skinmanager-copyas-help" />
            </div>
		</div>
        <div class="workplace">
            <asp:Repeater ID="rptCss" runat="server">
                <ItemTemplate>
                    <div class="mrb10">
                        <asp:HyperLink ID="lnkEdit" runat="server" Text='<%# Eval("Name") %>' NavigateUrl='<%# SiteRoot + "/DesignTools/CssEditor.aspx?s=" + skinName + "&amp;f=" + Eval("Name")  %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>