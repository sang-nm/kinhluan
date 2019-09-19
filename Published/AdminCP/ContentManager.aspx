<%@ Page Language="C#" MaintainScrollPositionOnPostback="true" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" CodeBehind="ContentManager.aspx.cs" Inherits="CanhCam.Web.AdminUI.ContentManagerPage"
    Title="Untitled Page" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <div class="headLinne">
        <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
            CurrentPageTitle="<%$Resources:Resource, AdminMenuContentManagerLink %>" CurrentPageUrl="~/AdminCP/ContentCatalog.aspx" />
    </div>
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:HyperLink SkinID="DefaultButton" ID="lnkModuleSettings" Visible="False" runat="server" />
            <asp:HyperLink ID="lnkEdit" SkinID="EditButton" EnableViewState="false" runat="server" />
            <asp:HyperLink ID="lnkBackToList" SkinID="LinkButton" runat="server" Visible="false" />
            <asp:Button ID="btnDelete" SkinID="DeleteButton" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <asp:Panel ID="pnlWarning" CssClass="alert alert-danger" runat="server" Visible="false">
            <gb:SiteLabel ID="lblNoReuse" runat="server" ConfigKey="ContentManagerNoReuseWarning" UseLabelTag="false" />
        </asp:Panel>
        <asp:HiddenField ID="hdnReturnUrl" runat="server" />
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" EnableViewState="true" runat="server">
                <MasterTableView DataKeyNames="PageID" EditMode="InPlace" AllowPaging="false" AllowSorting="false">
                    <Columns>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <%# Eval("DepthIndicator")%><%# Eval("PageName")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="center">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEditPublish" runat="server" Visible='<%# !useDialogForEditing %>'
                                    CommandName="Edit" ToolTip='<%# GetIsPublishedImageAltText(Eval("IsPublished"))%>'>
                                    <%# GetIsPublishedIcon(Eval("IsPublished")) %>
                                </asp:LinkButton>
                                <asp:HyperLink ID="lnkPubDialog" runat="server" Visible='<%# useDialogForEditing %>'
                                    NavigateUrl='<%# SiteRoot + "/AdminCP/ContentPublishDialog.aspx?pageid=" + Eval("PageId") + "&mid=" + Eval("ModuleId") + "&ia=" + includeAltPanes %>'
                                    CssClass="publink" ToolTip='<%# publishLinkTitle  %>'>
                                    <%# GetIsPublishedIcon(Eval("IsPublished")) %>
                                </asp:HyperLink>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkPublished" runat="server" Checked='<%# WebUtils.NullToFalse(Eval("IsPublished")) %>' />
                                <asp:Button SkinID="UpdateButton" ID="btnGridUpdate" runat="server" Text='<%# GetUpdateButtonText() %>'
                                    CommandName="Update" EnableViewState='<%# !useDialogForEditing %>' />
                                <asp:Button SkinID="CancelButton" ID="btnGridCancel" runat="server" Text='<%# GetCancelButtonText() %>'
                                    CommandName="Cancel" EnableViewState='<%# !useDialogForEditing %>' />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="center">
                            <ItemTemplate>
                                <%# GetPaneAlias(Eval("PaneName"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddPaneNames" runat="server" DataTextField="key" DataValueField="value"
                                    EnableViewState='<%# !useDialogForEditing %>' DataSource='<%# PaneList() %>'
                                    SelectedValue='<%# GetPaneName(Eval("PaneName")) %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="center">
                            <ItemTemplate>
                                <%# Eval("ModuleOrder")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtModuleOrder" Columns="4" Text='<%# GetModuleOrder(Eval("ModuleOrder")) %>'
                                    runat="server" EnableViewState='<%# !useDialogForEditing %>' />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <%# GetDisplayBeginDate(Eval("PublishBeginDate"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <gb:DatePickerControl ID="dpBeginDate" runat="server" Text='<%# GetBeginDate(Eval("PublishBeginDate")) %>'
                                    ShowTime="True" SkinID="ContentManager" EnableViewState='<%# !useDialogForEditing %>'>
                                </gb:DatePickerControl>
                                <asp:RequiredFieldValidator ID="reqElement" runat="server" ControlToValidate="dpBeginDate"
                                    ErrorMessage='<%# Resources.Resource.ContentPublishBeginDateRequiredMessage %>'
                                    Display="Dynamic" EnableViewState='<%# !useDialogForEditing %>' />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <%# GetEndDate(Eval("PublishEndDate"))%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <gb:DatePickerControl ID="dpEndDate" runat="server" Text='<%# GetEndDate(Eval("PublishEndDate")) %>'
                                    ShowTime="True" SkinID="ContentManager" EnableViewState='<%# !useDialogForEditing %>'>
                                </gb:DatePickerControl>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
