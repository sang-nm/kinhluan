<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminTaxClass.aspx.cs" Inherits="CanhCam.Web.AdminUI.AdminTaxClassPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, TaxClassAdminLink %>" CurrentPageUrl="~/AdminCP/AdminTaxClass.aspx"
        ParentTitle="<%$Resources:Resource, CoreDataAdministrationLink %>" ParentUrl="~/AdminCP/CoreData.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button  SkinID="InsertButton" ID="btnAddNew" runat="server" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="Guid" EditMode="InPlace" AllowPaging="false" AllowSorting="false">
                    <Columns>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <%# Eval("Title") %>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="txtTitle" Columns="20" Text='<%# Eval("Title") %>' runat="server" MaxLength="255" />
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="txtDescription" Columns="20" Text='<%# Eval("Description") %>' runat="server" />
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CommandName="Edit" SkinID="EditButton"
                                    Text='<%# Resources.Resource.TaxClassGridEditButton %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="btnGridUpdate" SkinID="UpdateButton" runat="server" Text='<%# Resources.Resource.TaxClassGridUpdateButton %>'
                                    CommandName="Update" />
                                <asp:Button ID="btnGridCancel" SkinID="CancelButton" runat="server" Text='<%# Resources.Resource.TaxClassGridCancelButton %>'
                                    CommandName="Cancel" />
                                <asp:Button ID="btnGridDelete" SkinID="DeleteButton" runat="server" Text='<%# Resources.Resource.TaxClassGridDeleteButton %>'
                                    CommandName="Delete" />
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <portal:gbCutePager ID="pgrTaxClass" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
