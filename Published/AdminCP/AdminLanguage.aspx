<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminLanguage.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdminLanguagePage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" CurrentPageTitle="<%$Resources:Resource, LanguageAdministrationLink %>"
        CurrentPageUrl="~/AdminCP/AdminLanguage.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="InsertButton" ID="btnAddNew" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, LanguageDeleteSelectedButton %>" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="LanguageID,Name" EditMode="InPlace">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>">
                                    <ItemTemplate>
                                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, LanguageGridNameHeading %>">
                                    <ItemTemplate>
                                        <%# Eval("Name") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtName" Columns="20" Text='<%# Eval("Name") %>' runat="server"
                                            MaxLength="100" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, LanguageGridCultureHeading %>">
                                    <ItemTemplate>
                                        <%# Eval("LanguageCode")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlLanguageCode" runat="server" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, LanguageGridIconHeading %>">
                                    <ItemTemplate>
                                        <%# !string.IsNullOrEmpty(Eval("IconPath").ToString()) ? "<img src='" + Eval("IconPath").ToString() + "' alt='" + Eval("Name").ToString() + "' />" : ""%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtFlagImage" Text='<%# Eval("Icon") %>' runat="server"
                                            MaxLength="50" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, LanguageGridPublishedHeading %>">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="ckbPublished" Enabled="false" Checked='<%# Eval("IsPublished") %>'
                                            runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="ckbPublished" Checked='<%# Eval("IsPublished") %>' runat="server" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, LanguageGridPublishedInBackend %>">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="ckbPublishedInBackend" Enabled="false" Checked='<%# Eval("PublishedInBackend") %>'
                                            runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="ckbPublishedInBackend" Checked='<%# Eval("PublishedInBackend") %>' runat="server" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, LanguageGridSortHeading %>">
                                    <ItemTemplate>
                                        <%# Eval("DisplayOrder") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" MaxLength="4" Text='<%# Eval("DisplayOrder") %>'
                                            runat="server" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn>
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" CommandName="Edit" SkinID="EditButton"
                                            Text='<%# Resources.Resource.LanguageGridEditButton %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Button SkinID="UpdateButton" ID="btnGridUpdate" runat="server" Text='<%# Resources.Resource.LanguageGridUpdateButton %>'
                                            CommandName="Update" />
                                        <asp:Button SkinID="CancelButton" ID="btnGridCancel" runat="server" Text='<%# Resources.Resource.LanguageGridCancelButton %>'
                                            CommandName="Cancel" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
