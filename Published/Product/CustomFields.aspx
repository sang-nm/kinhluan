<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="CustomFields.aspx.cs" Inherits="CanhCam.Web.ProductUI.CustomFieldsPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" >
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server"
        CurrentPageTitle="<%$Resources:ProductResources, CustomFieldsTitle %>" CurrentPageUrl="~/Product/CustomFields.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>"
                runat="server" />
            <asp:HyperLink SkinID="InsertButton" ID="lnkInsert" Text="<%$Resources:Resource, InsertButton %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:Resource, DeleteSelectedButton %>" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="CustomFieldId" AllowPaging="false" AllowSorting="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, CustomFieldNameLabel %>">
                            <ItemTemplate>
                                <%# Eval("Name") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductDisplayOrderLabel %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox"
                                    MaxLength="4" Text='<%# Eval("DisplayOrder") %>' runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" 
                                    Text="<%$Resources:ProductResources, CustomFieldEditLink %>" NavigateUrl='<%# SiteRoot + "/Product/CustomFieldEdit.aspx?id=" + Eval("CustomFieldId") %>'>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" 
    runat="server" >
</asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" 
    runat="server" >
</asp:Content>

