<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="LessUtility.aspx.cs" Inherits="CanhCam.Web.AdminUI.LessUtilityPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:DevTools, LessUtility %>" CurrentPageUrl="~/DesignTools/LessUtility.aspx"
        ParentTitle="<%$Resources:DevTools, DesignTools %>" ParentUrl="~/DesignTools/Default.aspx"
        RootTitle="<%$Resources:Resource, AdvancedToolsLink %>" RootUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="workplace">
            <div class="mrb10">
                <asp:Literal ID="litLessInstructions" runat="server" />
            </div>
            <div class="mrb10">
                <asp:TextBox ID="txtInput" runat="server" CssClass="form-control" TextMode="MultiLine"
                    Rows="30" Columns="90" />
            </div>
            <div class="mrb10">
                <asp:TextBox ID="txtOutput" runat="server" CssClass="form-control" TextMode="MultiLine"
                    Rows="30" Columns="90" />
            </div>
            <asp:Button SkinID="DefaultButton" ID="btnConvert" runat="server" Text="Generate CSS" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server">
</asp:Content>
