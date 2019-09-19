<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="RejectContent.aspx.cs" Inherits="CanhCam.Web.NewsUI.RejectContent" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:NewsResources, NewsEditHeading %>" CurrentPageUrl="~/News/NewsEdit.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" runat="server" Text="" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="" OnClick="btnCancel_Click" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />        
        <div class="workplace">
            <div id="divRejectionIntro" runat="server" class="settingrow form-group">
                <asp:Literal ID="litRejectionIntroduction" runat="server" />
            </div>
            <div id="divRejectionComments" runat="server" class="settingrow form-group">
                <gb:SiteLabel ID="lblRejectionComments" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="RejectionCommentLabel" />
                <div class="col-sm-9">
                    <asp:TextBox ID="txtRejectionComments" runat="server" TextMode="MultiLine" Width="400"
                        Height="250" />
                </div>
            </div>
            <asp:HiddenField ID="hdnReturnUrl" runat="server" />
        </div>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
