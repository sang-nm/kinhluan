<%@ Page Language="c#" CodeBehind="AlbumEdit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.GalleryUI.AlbumEdit" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.ImageGallery" Namespace="CanhCam.Web.GalleryUI" %>
<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:GalleryDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:GalleryResources, AlbumEditTitle %>" CurrentPageUrl="~/ImageGallery/AlbumEdit.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upButton" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" ValidationGroup="GalleryAlbum" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndNew" Text="<%$Resources:Resource, UpdateAndNewButton %>" ValidationGroup="GalleryAlbum" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" ValidationGroup="GalleryAlbum" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsert" Text="<%$Resources:Resource, InsertButton %>" ValidationGroup="GalleryAlbum" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndNew" Text="<%$Resources:Resource, InsertAndNewButton %>" ValidationGroup="GalleryAlbum" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndClose" Text="<%$Resources:Resource, InsertAndCloseButton %>" ValidationGroup="GalleryAlbum" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:BannerResources, BannerEditDeleteButton %>" CausesValidation="false" />
                    <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="workplace">
            <div class="form-horizontal">
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel" ResourceFile="Resource"
                        ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <portal:ComboBox ID="cobZones" Width="250" SelectionMode="Multiple" runat="server" />
                    </div>
                </div>
                <div id="divPosition" visible="false" runat="server" class="settingrow form-group">
                    <gb:SiteLabel ID="lblPosition" runat="server" ForControl="chkListPosition" CssClass="settinglabel control-label col-sm-3"
                        ConfigKey="AlbumPositionLabel" ResourceFile="GalleryResources" />
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
                            <gb:SiteLabel ID="lblTitle" runat="server" ForControl="txtTitle" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="AlbumTitleLabel" ResourceFile="GalleryResources" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtTitle" runat="server" MaxLength="255" />
                                <asp:RequiredFieldValidator ID="reqTitle" ErrorMessage="<%$Resources:GalleryResources, AlbumTitleRequiredWarning %>" runat="server" ControlToValidate="txtTitle"
                                    Display="Dynamic" SetFocusOnError="true" CssClass="txterror" ValidationGroup="GalleryAlbum" />
                            </div>
                        </div>
                        <div id="divDescription" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="lblDescription" runat="server" ForControl="txtDescription" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="AlbumDescriptionLabel" ResourceFile="GalleryResources" />
                            <div class="col-sm-9">
                                <gbe:EditorControl ID="edDescription" runat="server" />
                                <asp:TextBox ID="txtDescription" Visible="false" runat="server" />
                                <portal:gbHelpLink ID="GbHelpLink3" runat="server" HelpKey="albumedit-description-help" />
                            </div>
                        </div>
                        <div id="divUrl" runat="server" class="settingrow form-group">
                            <gb:SiteLabel ID="lblUrl" ForControl="txtUrl" CssClass="settinglabel control-label col-sm-3" runat="server"
                                ConfigKey="AlbumUrlLabel" ResourceFile="GalleryResources" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtUrl" runat="server" MaxLength="255" />
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="mrb10">
                <portal:HeadingControl ID="subHeading" HeadingTag="h3" runat="server" />
            </div>
			<div class="form-horizontal">
				<div id="divBulkUpload" runat="server" class="settingrow form-group">
					<gb:SiteLabel runat="server" ForControl="uplImageFile" CssClass="settinglabel control-label col-sm-3"
						ConfigKey="spacer" ResourceFile="GalleryResources" />
					<div class="col-sm-9">
						<telerik:RadAsyncUpload ID="uplImageFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic"
							AllowedFileExtensions="jpg,jpeg,gif,png" runat="server" />
					</div>
				</div>
				<asp:Repeater ID="rpt" OnItemDataBound="rpt_ItemDataBound" runat="server">
					<HeaderTemplate>
						<style type="text/css">
							.bulkzone .settingrow form-group{padding-left:100px;}
							.bulkzone .settingrow form-group.settinglabel col-md-3 {margin-left: -100px;width: 90px;}
						</style>
						<div class="adminmenu">
							<ul class="simplelist">
					</HeaderTemplate>
					<FooterTemplate>
							</ul>
							<div class="clear"></div>
						</div>
					</FooterTemplate>
					<ItemTemplate>
						<li>
							<div class="bulkzone">
								<div class="settingrow form-group">
									<gb:SiteLabel ID="lblSpacer" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="spacer" />
									<div class="col-sm-9">
										<img width="260" src='<%#GetWebImageUrl(Eval("WebImageFile").ToString()) %>' alt='<%#Eval("Title").ToString()%>' />
									</div>
								</div>
								<div class="settingrow form-group">
									<gb:SiteLabel ID="lblTitle" runat="server" ForControl="txtTitle" CssClass="settinglabel control-label col-sm-3"
											ConfigKey="GalleryCaptionLabel" ResourceFile="GalleryResources" />
									<div class="col-sm-9">
										<asp:HiddenField ID="hdnItemId" runat="server" Value='<%#Eval("ItemId") %>' />
										<asp:HiddenField ID="hdnDataKeyValue" runat="server" Value='<%#Eval("ItemGuid") %>' />
										<asp:TextBox ID="txtTitle" MaxLength="255" Text='<%# Eval("Title") %>' runat="server" />
									</div>
								</div>
								<%if (WebConfigSettings.AllowMultiLanguage)
								{ %>
									<asp:Repeater ID="rptLanguages" OnItemDataBound="rptLanguages_ItemDataBound" runat="server">
										<ItemTemplate>
											<div class="settingrow form-group">
												<gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3"
														Text='<%#Eval("Name")%>' />
												<div class="col-sm-9">
													<asp:HiddenField ID="hdnLanguageId" runat="server" Value='<%#Eval("LanguageId") %>' />
													<asp:TextBox ID="txtTitle" MaxLength="255" runat="server" />
												</div>
											</div>
										</ItemTemplate>
									</asp:Repeater>
								<% }%>

								<div class="settingrow form-group">
									<gb:SiteLabel ID="lblDisplayOrder" runat="server" ForControl="txtDisplayOrder" CssClass="settinglabel control-label col-sm-3"
											ConfigKey="GalleryDisplayOrderLabel" ResourceFile="GalleryResources" />
									<div class="col-sm-9">
										<asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" MaxLength="4" 
											Text='<%# Eval("DisplayOrder") %>' runat="server" />
										<asp:CheckBox ID="chkDelete" Text="<%$Resources:GalleryResources, GalleryEditDeleteLabel %>" runat="server" />
									</div>
								</div>
							</div>
						</li>
					</ItemTemplate>
				</asp:Repeater>
			</div>
        </div>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />