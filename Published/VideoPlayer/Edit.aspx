<%@ Page Language="c#" CodeBehind="Edit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.VideoUI.VideoEdit" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:VideoResources, VideoEditHeading %>" CurrentPageUrl="~/VideoPlayer/Edit.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upButton" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" ValidationGroup="VideoValidation" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndNew" Text="<%$Resources:Resource, UpdateAndNewButton %>" ValidationGroup="VideoValidation" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" ValidationGroup="VideoValidation" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsert" Text="<%$Resources:Resource, InsertButton %>" ValidationGroup="VideoValidation" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndNew" Text="<%$Resources:Resource, InsertAndNewButton %>" ValidationGroup="VideoValidation" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndClose" Text="<%$Resources:Resource, InsertAndCloseButton %>" ValidationGroup="VideoValidation" runat="server" />
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
                        <gb:SiteLabel ID="Sitelabel1" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="VideoNameLabel" ResourceFile="VideoResources" />
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtName" runat="server" MaxLength="255" />
                            <asp:RequiredFieldValidator ID="reqName" runat="server" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtName" ValidationGroup="VideoValidation" 
                                Text="<%$Resources:VideoResources, VideoNameRequiredValidatorErrorMessage %>" ErrorMessage="<%$Resources:VideoResources, VideoNameRequiredValidatorErrorMessage %>" />
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="FileLocationLabel" runat="server" ForControl="txtVideoPath" ResourceFile="VideoResources"
                            ConfigKey="FileLocationLabel" CssClass="settinglabel control-label col-sm-3" />
                        <div class="col-sm-9">
                            <div class="input-group">
                                <asp:TextBox ID="txtVideoPath" MaxLength="255" runat="server" />
                                <div class="input-group-addon">
                                    <portal:FileBrowserTextBoxExtender ID="VideoFileBrowser" runat="server" BrowserType="video" />
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="reqVideoPath" runat="server" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtVideoPath" ValidationGroup="VideoValidation"
                                Text="<%$Resources:VideoResources, VideoFileRequiredValidatorErrorMessage %>" ErrorMessage="<%$Resources:VideoResources, VideoFileRequiredValidatorErrorMessage %>" />
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="SiteLabel2" runat="server" ForControl="txtThumbnail" ResourceFile="VideoResources"
                            ConfigKey="ThumbnailLabel" CssClass="settinglabel control-label col-sm-3" />
                        <div class="col-sm-9">
                            <div class="input-group">
                                <asp:TextBox ID="txtThumbnail" MaxLength="255" runat="server" />
                                <div class="input-group-addon">
                                    <portal:FileBrowserTextBoxExtender ID="ThumbnailFileBrowser" runat="server" BrowserType="image" />
                                </div>
                                <portal:gbHelpLink ID="GbHelpLink1" runat="server" HelpKey="videoedit-thumbnail-help" />
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <portal:SessionKeepAliveControl ID="ka1" runat="server" />
        </div>
    </div>
</asp:Content>