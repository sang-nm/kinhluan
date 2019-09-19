<%@ Page Language="c#" CodeBehind="List.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="true" Inherits="CanhCam.Web.SharedFilesUI.ListPage" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.SharedFiles" Namespace="CanhCam.Web.SharedFilesUI" %>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <Site:SharedFilesDisplaySettings ID="displaySettings" runat="server" />
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:SharedFileResources, SharedFilesListHeading %>" CurrentPageUrl="~/SharedFiles/List.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:SharedFileResources, SharedFilesUpdateButton %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:SharedFileResources, SharedFilesDeleteSelectedButton %>" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <div class="workplace">
            <div class="form-horizontal">
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                        ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:DropDownList ID="ddZones" AutoPostBack="true" runat="server" />
                    </div>
                </div>
                <asp:Panel ID="pnlUpload" runat="server" DefaultButton="btnUpload">
                    <div class="settingrow form-group">
                        <div class="col-sm-9 col-sm-offset-3">
                            <telerik:RadAsyncUpload ID="multiFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic" runat="server" />
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <div class="col-sm-9 col-sm-offset-3">
                            <asp:Button SkinID="DefaultButton" ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" />
                        </div>
                    </div>
                </asp:Panel>
            </div>
            <asp:UpdatePanel ID="upFiles" UpdateMode="Conditional" runat="server">
                <ContentTemplate>
				    <portal:NotifyMessage ID="message" runat="server" />
                    <asp:Panel ID="pnlNewFolder" runat="server" CssClass="form-horizontal" DefaultButton="btnNewFolder">
                        <div class="settingrow form-group">
                            <gb:SiteLabel ID="lblFolderList" runat="server" ForControl="ddFolderList" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="FileManagerNewFolderButton" ResourceFile="SharedFileResources" />
                            <div class="col-sm-9">
                                <div class="form-inline col-sm-12">
                                    <div class="settingrow form-group">
                                        <asp:TextBox ID="txtNewDirectory" MaxLength="255" runat="server" />
                                    </div>
                                    <div class="settingrow form-group">
                                        <asp:Button SkinID="DefaultButton" ID="btnNewFolder" runat="server" Text="<%$Resources:Resource, InsertButton %>" OnClick="btnNewFolder_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="pnlFile" runat="server" DefaultButton="btnUpload">
                        <asp:LinkButton ID="btnGoUp" runat="server" OnClick="btnGoUp_Click"><i class="fa fa-level-up"></i></asp:LinkButton>
                        <asp:Label ID="lblCurrentDirectory" runat="server" CssClass="foldername" />
                        <asp:Label ID="lblError" runat="server" EnableViewState="false" CssClass="txterror" />
                        <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                            <MasterTableView DataKeyNames="ID,LanguageID" EditMode="InPlace">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:SharedFileResources, FileManagerFileNameLabel %>">
                                        <ItemTemplate>
                                            <asp:PlaceHolder ID="plhImgEdit" runat="server"></asp:PlaceHolder>
                                            <asp:Image ID="imgType" runat="server" AlternateText=" "
                                                ImageUrl="~/Data/SiteImages/Icons/unknown.gif" />
                                            <asp:Button ID="lnkName" runat="server" CssClass="btn-link" Text='<%# DataBinder.Eval(Container.DataItem,"filename") %>'
                                                CommandName="ItemClicked" CommandArgument='<%# Eval("ID") %>' CausesValidation="false"
                                                Visible='<%# (DataBinder.Eval(Container.DataItem,"type").ToString().ToLower() != "1") %>' />
                                            <asp:Literal ID="litDownloadLink" runat="server" Text='<%# BuildDownloadLink(Eval("ID").ToString(),Eval("filename").ToString(), Eval("type").ToString(), false )%>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Panel ID="PnlRename" runat="server" DefaultButton="btnRename">
                                                <asp:PlaceHolder ID="Placeholder1" runat="server"></asp:PlaceHolder>
                                                <asp:Image ID="imgEditType" runat="server" ImageUrl="~/Data/SiteImages/Icons/unknown.gif" />
                                                <asp:TextBox ID="txtEditName" runat="server" style="width:200px;display:inline-block" Text='<%# DataBinder.Eval(Container.DataItem,"filename") %>' />
                                            </asp:Panel>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:SharedFileResources, FileManagerSizeLabel %>">
                                        <ItemTemplate>
                                            <asp:Literal ID="litSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"size") %>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:SharedFileResources, DownloadCountLabel %>">
                                        <ItemTemplate>
                                            <asp:Literal ID="litDownloadCount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DownloadCount")%>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:SharedFileResources, FileManagerModifiedLabel %>">
                                        <ItemTemplate>
                                            <asp:Literal ID="litMod" runat="server" Text='<%# DateTimeHelper.GetTimeZoneAdjustedDateTimeString(((System.Data.DataRowView)Container.DataItem),"modified", TimeOffset, timeZone)%>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:SharedFileResources, SharedFilesUploadedByLabel %>">
                                        <ItemTemplate>
                                            <asp:Literal ID="litUser" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "username")%>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="<%$Resources:SharedFileResources, SharedFilesLanguageLabel %>">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddLanguage" AppendDataBoundItems="true" DataTextField="Name" DataValueField="LanguageID" runat="server">
                                                <asp:ListItem Text="<%$Resources:SharedFileResources, SharedFilesLanguageSelector %>" Value="-1"></asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:SharedFileResources, SharedFilesDisplayOrderLabel %>">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" MaxLength="4" Text='<%# Eval("DisplayOrder") %>'
                                                runat="server" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%# DataBinder.Eval(Container.DataItem,"DisplayOrder") %>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn>
                                        <ItemTemplate>
                                            <asp:Button ID="LinkButton1" runat="server"
                                                 SkinID="EditButton" CommandName="Edit" CommandArgument='<%# Eval("ID") %>'
                                                CausesValidation="false" Text="<%# Resources.SharedFileResources.FileManagerRename %>" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Button SkinID="DefaultButton" ID="btnRename" runat="server" CommandName="Update"
                                                CommandArgument='<%# Eval("ID") %>' Text="<%# Resources.SharedFileResources.SharedFilesUpdateButton %>" />
                                            <asp:Button SkinID="DefaultButton" ID="btnCancel" runat="server" CommandName="Cancel" CausesValidation="false"
                                                Text="<%# Resources.SharedFileResources.SharedFilesCancelButton %>" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn>
                                        <ItemTemplate>
                                            <asp:HyperLink ID="editLink" runat="server" Visible='<%#canUpdate %>' Text="<%# Resources.SharedFileResources.SharedFilesEditLink %>"
                                                NavigateUrl='<%# this.SiteRoot + "/SharedFiles/Edit.aspx?ItemID=" + DataBinder.Eval(Container.DataItem,"ID") %>'
                                                />
                                            <asp:Literal ID="litDownloadLink1" runat="server" Text='<%# BuildDownloadLink(Eval("ID").ToString(),Eval("filename").ToString(), Eval("type").ToString(), true )%>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:HiddenField ID="hdnCurrentFolderId" runat="server" Value="-1" />
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
            <portal:SessionKeepAliveControl ID="ka1" runat="server" />
        </div>
    </div>
</asp:Content>