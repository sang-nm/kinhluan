<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="EditLoginInfo.aspx.cs" Inherits="CanhCam.Web.AdminUI.EditLoginInfo" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, LoginPageContent %>" CurrentPageUrl="~/AdminCP/EditLoginInfo.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnSave" runat="server" />
        </portal:HeadingPanel>
        <div class="workplace">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblTopInfo" runat="server" CssClass="settinglabel control-label" ConfigKey="LoginPageTopContent" />
                <div>
                    <gbe:EditorControl ID="edTopInfo" runat="server" />
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblBottomInfo" runat="server" CssClass="settinglabel control-label" ConfigKey="LoginPageBottomContent" />
                <div>
                    <gbe:EditorControl ID="edBottomInfo" runat="server" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />