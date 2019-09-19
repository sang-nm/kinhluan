<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ContentTemplates.aspx.cs" Inherits="CanhCam.Web.AdminUI.ContentTemplatesPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, ContentTemplates %>" CurrentPageUrl="~/AdminCP/ContentTemplates.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:HyperLink SkinID="InsertButton" ID="lnkAddNew" runat="server" />
        </portal:HeadingPanel>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView AllowPaging="false" AllowSorting="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, ContentTemplateTitleLabel %>" DataField="Title" />
                        <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, ContentTemplateTab %>" DataField="Body" />
                        <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, ContentTemplateDescriptionTab %>" DataField="Description" />
                        <telerik:GridTemplateColumn HeaderStyle-Width="50">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkEdit" runat="server" NavigateUrl='<%# SiteRoot + "/AdminCP/ContentTemplateEdit.aspx?t=" + Eval("Guid") %>'
                                    Text='<%# Resources.Resource.ContentTemplateEditLink %>' CssClass="cp-link" />
                            </ItemTemplate>
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
