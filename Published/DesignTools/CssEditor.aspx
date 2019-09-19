<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="CssEditor.aspx.cs" Inherits="CanhCam.Web.AdminUI.CssEditorPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:DevTools, SkinManagement %>" CurrentPageUrl="~/DesignTools/SkinList.aspx"
        ParentTitle="<%$Resources:DevTools, DesignTools %>" ParentUrl="~/DesignTools/Default.aspx"
        RootTitle="<%$Resources:Resource, AdvancedToolsLink %>" RootUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnSave" runat="server" />
            <asp:HyperLink SkinID="CancelButton" ID="lnkSkin" runat="server" />
        </portal:HeadingPanel>
        <div class="workplace">
            <div class="settingrow form-group">
                <portal:CodeEditor ID="edCss" runat="server" Syntax="css" CssClass="form-control" StartHighlighted="false"
                    MinWidth="700" AllowToggle="true" Width="100%" />
                <asp:TextBox ID="txtCss" runat="server" Rows="20" Columns="140" CssClass="form-control"
                    TextMode="MultiLine" Visible="false" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server">
</asp:Content>
