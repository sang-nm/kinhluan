<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="EditRegistrationAgreement.aspx.cs" Inherits="CanhCam.Web.AdminUI.EditRegistrationAgreementPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:Resource, RegistrationAgreementLink %>" CurrentPageUrl="~/AdminCP/EditRegistrationAgreement.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnSave" runat="server" />
        </portal:HeadingPanel>
        <div class="workplace">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblPreamble" runat="server" CssClass="settinglabel control-label" ConfigKey="RegistrationPreamble" />
                <div>
                    <gbe:EditorControl ID="edPreamble" runat="server" />
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblAgreement" runat="server" CssClass="settinglabel control-label" ConfigKey="RegistrationAgreement" />
                <div>
                    <gbe:EditorControl ID="edAgreement" runat="server" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />