<%@ Page Language="c#" CodeBehind="Edit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.SharedFilesUI.EditPage" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.SharedFiles" Namespace="CanhCam.Web.SharedFilesUI" %>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:SharedFilesDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:SharedFileResources, SharedFilesEditLabel %>" CurrentPageUrl="~/SharedFiles/Edit.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="workplace">
            <asp:Panel ID="pnlNotFound" runat="server" Visible="true">
                <gb:SiteLabel ID="Sitelabel1" runat="server" ConfigKey="SharedFilesNotFoundMessage"
                    ResourceFile="SharedFileResources" UseLabelTag="false" />
            </asp:Panel>
            <asp:Panel ID="pnlFound" runat="server">
                <div class="form-horizontal">
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel" ResourceFile="Resource"
                            ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                        <div class="col-sm-9">
                            <asp:DropDownList ID="ddZones" runat="server" />
                        </div>
                    </div>
                    <asp:Panel ID="pnlFolder" runat="server">
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblFolderList" runat="server" ForControl="ddFolderList" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="SharedFilesFolderParentLabel" ResourceFile="SharedFileResources" />
                            <div class="col-sm-9">
                                <asp:DropDownList ID="ddFolderList" runat="server" EnableTheming="false" DataValueField="FolderID"
                                    DataTextField="FolderName">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <asp:UpdatePanel ID="up" runat="server">
                            <ContentTemplate>
                                <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                                    EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                    CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                                <div class="settingrow form-group">
                                    <gb:SiteLabel ID="lblFolderName" runat="server" ForControl="txtFolderName" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="SharedFilesFolderNameLabel" ResourceFile="SharedFileResources" />
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtFolderName" runat="server" Columns="45" MaxLength="255" />
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="upButton" UpdateMode="Conditional" runat="server">
                            <ContentTemplate>
                                <div class="settingrow form-group">
                                    <div class="col-sm-9 col-sm-offset-3">
                                        <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" runat="server" />
                                        <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" runat="server" />
                                        <asp:Button SkinID="DeleteButton" ID="btnDeleteFolder" runat="server" CausesValidation="false" />
                                        <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>
                </div>
                <asp:Panel ID="pnlFile" runat="server" Visible="false">
                    <portal:NotifyMessage ID="message" runat="server" />
                    <div class="form-horizontal">
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblLanguage" runat="server" ConfigKey="SharedFilesLanguageLabel" ResourceFile="SharedFileResources"
                                ForControl="ddLanguage" CssClass="settinglabel control-label col-sm-3" />
                            <div class="col-sm-9">
                                <asp:DropDownList ID="ddLanguage" AppendDataBoundItems="true" DataTextField="Name" DataValueField="LanguageID" runat="server">
                                    <asp:ListItem Text="<%$Resources:SharedFileResources, SharedFilesLanguageSelector %>" Value="-1"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblUploadDateLabel" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="SharedFilesUploadDateLabel"
                                ResourceFile="SharedFileResources" />
                            <div class="col-sm-9">
                                <p class="form-control-static"><asp:Label ID="lblUploadDate" runat="server" /></p>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblUploadByLabel" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="SharedFilesUploadByLabel"
                                ResourceFile="SharedFileResources" />
                            <div class="col-sm-9">
                                <p class="form-control-static"><asp:Label ID="lblUploadBy" runat="server" /></p>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblFileSizeLabel" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="SharedFilesFileSizeLabel"
                                ResourceFile="SharedFileResources" />
                            <div class="col-sm-9">
                                <p class="form-control-static"><asp:Label ID="lblFileSize" runat="server" CssClass="Normal" /></p>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblFileNameLabel" runat="server" ForControl="txtFriendlyName" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="SharedFilesFileNameLabel" ResourceFile="SharedFileResources" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtFriendlyName" runat="server" Columns="45" MaxLength="255" CssClass="forminput widetextbox" />
                            </div>
                        </div>
                        <div id="divDescription" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="lblDescription" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="FileDescription"
                                ResourceFile="SharedFileResources" UseLabelTag="false" />
                            <div class="col-sm-9">
                                <gbe:EditorControl ID="edDescription" runat="server" />
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblFolders" runat="server" ForControl="ddFolders" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="SharedFilesFolderLabel" ResourceFile="SharedFileResources" />
                            <div class="col-sm-9">
                                <asp:DropDownList ID="ddFolders" runat="server" EnableTheming="false" DataValueField="FolderID"
                                    DataTextField="FolderName" CssClass="forminput">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="Sitelabel3" runat="server" ForControl="file1" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="SharedFilesUploadLabel" ResourceFile="SharedFileResources" />
                            <div class="col-sm-9">
                                <asp:Literal ID="litDownloadLink" runat="server" />
                                <telerik:RadAsyncUpload ID="file1" SkinID="radAsyncUploadSkin" MultipleFileSelection="Disabled"
                                    runat="server" />
                                
                            </div>
                        </div>
                        <div class="settingrow form-group">
                            <div class="col-sm-9 col-sm-offset-3">
                                <asp:Button SkinID="DefaultButton" ID="btnUpload" runat="server" Text="Upload" />
                                <asp:Button SkinID="UpdateButton" ID="btnUpdateFile" Text="<%$Resources:Resource, UpdateButton %>" runat="server" />
                                <asp:Button SkinID="UpdateButton" ID="btnUpdateFileAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" runat="server" />
                                <asp:Button SkinID="DeleteButton" ID="btnDeleteFile" runat="server" CausesValidation="false" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </asp:Panel>
            <portal:SessionKeepAliveControl ID="ka1" runat="server" />
        </div>
    </div>
</asp:Content>