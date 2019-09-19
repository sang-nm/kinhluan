<%@ Page Language="c#" CodeBehind="Edit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.FAQsUI.FAQsEdit" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.FAQs" Namespace="CanhCam.Web.FAQsUI" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:FAQsDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:FAQsResources, EditPageTitle %>" CurrentPageUrl="~/FAQs/Edit.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upButton" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndNew" Text="<%$Resources:Resource, UpdateAndNewButton %>" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsert" Text="<%$Resources:Resource, InsertButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndNew" Text="<%$Resources:Resource, InsertAndNewButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndClose" Text="<%$Resources:Resource, InsertAndCloseButton %>" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, DeleteButton %>" CausesValidation="false" />
                    <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="workplace form-horizontal">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel" ResourceFile="Resource"
                    ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <portal:ComboBox ID="cobZones" SelectionMode="Multiple" runat="server" />
                </div>
            </div>
            <div id="divPosition" visible="false" runat="server" class="settingrow form-group">
                <gb:SiteLabel ID="lblPosition" runat="server" ForControl="chkListPosition" CssClass="settinglabel control-label col-sm-3"
                    ConfigKey="BannerPositionLabel" ResourceFile="BannerResources" />
                <div class="col-sm-9">
                    <asp:CheckBoxList ID="chkListPosition" runat="server" DataTextField="Name" DataValueField="Value" SkinID="Enum" />
                </div>
            </div>
            <asp:UpdatePanel ID="up" runat="server">
                <ContentTemplate>
                    <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                        EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                        CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblQuestion" runat="server" ForControl="edQuestion" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="QuestionLabel" ResourceFile="FAQsResources" />
                        <div class="col-sm-9">
                            <gbe:EditorControl ID="edQuestion" runat="server" />
                            <asp:TextBox ID="txtQuestion" Visible="false" runat="server" />
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblAnswer" runat="server" ForControl="edAnswer" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="AnswerLabel" ResourceFile="FAQsResources" />
                        <div class="col-sm-9">
                            <gbe:EditorControl ID="edAnswer" runat="server" />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
