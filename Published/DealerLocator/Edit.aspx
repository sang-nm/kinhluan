<%@ Page Language="c#" CodeBehind="Edit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.DealerUI.EditPage" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.DealerLocator" Namespace="CanhCam.Web.DealerUI" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:DealerDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:DealerResources, EditPageLabel %>" CurrentPageUrl="~/DealerLocator/Edit.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upButton" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" ValidationGroup="dealers" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndNew" Text="<%$Resources:Resource, UpdateAndNewButton %>" ValidationGroup="dealers" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" ValidationGroup="dealers" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsert" Text="<%$Resources:Resource, InsertButton %>" ValidationGroup="dealers" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndNew" Text="<%$Resources:Resource, InsertAndNewButton %>" ValidationGroup="dealers" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndClose" Text="<%$Resources:Resource, InsertAndCloseButton %>" ValidationGroup="dealers" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, DeleteButton %>" CausesValidation="false" />
                    <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="workplace form-horizontal">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                    ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <portal:ComboBox ID="cobZones" SelectionMode="Multiple" runat="server" />
                </div>
            </div>
            <asp:UpdatePanel ID="upGeoZone" runat="server">
                <ContentTemplate>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblProvince" runat="server" ForControl="ddProvince" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="ProvinceLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                        <div class="col-sm-9">
                            <asp:DropDownList ID="ddProvince" runat="server" DataTextField="Name" DataValueField="Guid"
                                AutoPostBack="true" />
                        </div>
                    </div>
                    <div id="divDistrict" runat="server" class="settingrow form-group">
                        <gb:SiteLabel ID="lblDistrict" runat="server" ForControl="ddDistrict" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="DistrictLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                        <div class="col-sm-9">
                            <asp:DropDownList ID="ddDistrict" runat="server" DataTextField="Name" DataValueField="Guid" />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblPhone" runat="server" ForControl="txtPhone" CssClass="settinglabel control-label col-sm-3"
                    ConfigKey="EditPagePhoneLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtPhone" runat="server" MaxLength="255"></asp:TextBox>
                </div>
            </div>
            <div id="divFax" runat="server" class="settingrow form-group dealerfax">
                <gb:SiteLabel ID="lblFax" runat="server" ForControl="txtFax" CssClass="settinglabel control-label col-sm-3"
                    ConfigKey="EditPageFaxLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtFax" runat="server" MaxLength="255"></asp:TextBox>
                </div>
            </div>
            <div id="divEmail" runat="server" class="settingrow form-group dealeremail">
                <gb:SiteLabel ID="lblEmail" runat="server" ForControl="txtEmail" CssClass="settinglabel control-label col-sm-3"
                    ConfigKey="EditPageEmailLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtEmail" runat="server" MaxLength="255"></asp:TextBox>
                </div>
            </div>
            <div id="divWebsite" runat="server" class="settingrow form-group dealerwebsite">
                <gb:SiteLabel ID="lblWebsite" runat="server" ForControl="txtWebsite" CssClass="settinglabel control-label col-sm-3"
                    ConfigKey="EditPageWebsiteLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtWebsite" runat="server" MaxLength="255"></asp:TextBox>
                </div>
            </div>
            <div id="divContactPerson" runat="server" class="settingrow form-group dealercontactpersion">
                <gb:SiteLabel ID="lblContactPerson" runat="server" ForControl="txtContactPerson" CssClass="settinglabel control-label col-sm-3"
                    ConfigKey="EditPageContactPersonLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtContactPerson" runat="server" MaxLength="255"></asp:TextBox>
                </div>
            </div>
            <div id="divPicture" runat="server" class="settingrow form-group dealerpicture">
                <gb:SiteLabel ID="lblPicture" runat="server" ForControl="txtPicture" ResourceFile="DealerResources"
                    ConfigKey="EditPagePictureLabel" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <div class="input-group">
                        <asp:TextBox ID="txtPicture" MaxLength="255" runat="server" />
                        <div class="input-group-addon">
                            <portal:FileBrowserTextBoxExtender ID="PictureBrowser" runat="server" BrowserType="image" />
                        </div>
                    </div>
                </div>
            </div>
            <asp:UpdatePanel ID="up" runat="server">
                <ContentTemplate>
                    <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                        EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                        CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="EditPageNameLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtName" runat="server" MaxLength="255"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtName"
                                Display="Dynamic" ErrorMessage="<%$Resources:DealerResources, EditPageNameRequiredWarning %>" CssClass="txterror" ValidationGroup="dealers" />
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblAddress" runat="server" ForControl="txtAddress" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="EditPageAddressLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtAddress" runat="server" MaxLength="255"></asp:TextBox>
                        </div>
                    </div>
                    <div class="settingrow form-group dealermap">
                        <gb:SiteLabel ID="lblMap" runat="server" ForControl="txtMap" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="EditPageMapLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtMap" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </div>
                    <div id="divDescription" runat="server" class="settingrow form-group dealerdes">
                        <gb:SiteLabel ID="lblDescription" runat="server" ForControl="txtDescription" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="EditPageDescriptionLabel" ResourceFile="DealerResources"></gb:SiteLabel>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtDescription" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>