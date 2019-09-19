<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ContentStyles.aspx.cs" Inherits="CanhCam.Web.AdminUI.ContentStylesPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, ContentStyleTemplates %>" CurrentPageUrl="~/AdminCP/ContentStyles.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="InsertButton" ID="btnAddNew" runat="server" />
        </portal:HeadingPanel>
        <div class="headInfo form-horizontal">
            <div class="settingrow form-group">
                <telerik:RadAsyncUpload ID="uplFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Disabled" runat="server" />
            </div>
            <div class="settingrow form-group">
                <asp:Button SkinID="DefaultButton" ID="btnImportStyles" runat="server" Text="Import Styles" />
                <asp:Button SkinID="DefaultButton" ID="btnExportStyles" runat="server" Text="Export Styles" />
            </div>
        </div>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="Guid" EditMode="InPlace" AllowPaging="false" AllowSorting="false">
                    <Columns>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <%# Eval("Name") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" runat="server" CssClass="mediumtextbox" Text='<%# Eval("Name") %>'
                                    MaxLength="100" />
                                <asp:RequiredFieldValidator ID="reqName" runat="server" Display="Dynamic" ControlToValidate="txtName"
                                    ErrorMessage='<%# Resources.Resource.StyleNameRequiredMessage %>' />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <%# Eval("Element")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtElement" runat="server" CssClass="smalltextbox" Text='<%# Eval("Element") %>'
                                    MaxLength="50" />
                                <asp:RequiredFieldValidator ID="reqElement" runat="server" Display="Dynamic" ControlToValidate="txtElement"
                                    ErrorMessage='<%# Resources.Resource.StyleElementRequiredMessage %>' />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <%# Eval("CssClass") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCssClass" runat="server" CssClass="smalltextbox" Text='<%# Eval("CssClass") %>'
                                    MaxLength="50" />
                                <asp:RequiredFieldValidator ID="reqCssClass" runat="server" Display="Dynamic" ControlToValidate="txtCssClass"
                                    ErrorMessage='<%# Resources.Resource.StyleCssClassRequiredMessage %>' />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <%# Eval("IsActive") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox ID="chkIsActive" runat="server" Checked='<%# Eval("IsActive") %>' />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CommandName="Edit" CssClass="link-button"
                                    Text='<%# Resources.Resource.TaxClassGridEditButton %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="btnGridUpdate" SkinID="UpdateButton" runat="server" Text='<%# Resources.Resource.ContentStyleSave %>'
                                    CommandName="Update" />
                                <asp:Button ID="btnGridDelete" SkinID="DeleteButton" runat="server" Text='<%# Resources.Resource.ContentStyleDelete %>'
                                    CommandName="Delete" />
                                <asp:HyperLink ID="lnkCancel" SkinID="CancelButton" runat="server" Text='<%# Resources.Resource.ContentStyleCancel %>'
                                    NavigateUrl='<%# Request.RawUrl %>'></asp:HyperLink>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <portal:gbCutePager ID="pgr" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
