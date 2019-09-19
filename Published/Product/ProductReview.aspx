<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ProductReview.aspx.cs" Inherits="CanhCam.Web.ProductUI.ProductReviewPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:ProductResources, ProductReviewTitle %>" CurrentPageUrl="~/Product/ProductReview.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:Resource, DeleteSelectedButton %>" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />        
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="CommentId,IsApproved" AllowSorting="false" AllowFilteringByColumn="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductReviewProductTitle %>">
                            <ItemTemplate>
                                <asp:Literal ID="litProduct" Visible='<%# !CanhCam.Web.ProductUI.ProductPermission.CanUpdate %>' Text='<%#Eval("ProductTitle")%>' runat="server" />
                                <asp:HyperLink CssClass="cp-link" ID="EditProductLink" runat="server" 
                                    Visible='<%# CanhCam.Web.ProductUI.ProductPermission.CanUpdate %>'
                                    Text='<%#Eval("ProductTitle")%>' NavigateUrl='<%# SiteRoot + "/Product/AdminProductEdit.aspx?ProductID=" + Eval("ProductId") %>'>
                                </asp:HyperLink>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductReviewTitleLabel %>" UniqueName="Title">
                            <ItemTemplate>
                                <%# Server.HtmlEncode(Eval("Title").ToString()) %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductReviewText %>" UniqueName="ContentText">
                            <ItemTemplate>
                                <NeatHtml:UntrustedContent ID="UntrustedContent1" runat="server" EnableViewState="false"
                                    TrustedImageUrlPattern='<%# RegexRelativeImageUrlPatern %>' ClientScriptUrl="~/ClientScript/NeatHtml.js">
                                    <asp:Literal ID="litComment" runat="server" EnableViewState="false" Text='<%# DataBinder.Eval(Container.DataItem, "ContentText").ToString() %>' />
                                </NeatHtml:UntrustedContent>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductReviewRating %>" UniqueName="Rating">
                            <ItemTemplate>
                                <%# Convert.ToInt32(Eval("Rating")) > 0 ? Eval("Rating").ToString() : "" %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductReviewFullName %>" UniqueName="FullName">
                            <ItemTemplate>
                                <%# Server.HtmlEncode(Eval("FullName").ToString()) %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductReviewApproved %>">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkApproved" Checked='<%#Convert.ToBoolean(Eval("IsApproved")) %>' runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:ProductResources, ProductReviewCreatedOn %>">
                            <ItemTemplate>
                                <%# FormatDate(Eval("CreatedUtc")) %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="50" AllowFiltering="false" >
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" Text="<%# Resources.ProductResources.ProductReviewEditLink %>" 
                                    NavigateUrl='<%# this.SiteRoot + "/Product/ProductReviewEdit.aspx?CommentID=" + DataBinder.Eval(Container.DataItem,"CommentID") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />