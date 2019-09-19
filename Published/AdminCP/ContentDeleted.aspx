<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ContentDeleted.aspx.cs" Inherits="CanhCam.Web.AdminUI.ContentDeletedPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" >
</asp:Content>
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, ContentDeleted %>" CurrentPageUrl="~/AdminCP/ContentDeleted.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upPanel" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button CssClass="btn btn-success" ID="btnRestore" Text="<%$Resources:Resource, RestoreSelectedButton %>"
                        runat="server" CausesValidation="false" />
                    <asp:Button ID="btnDelete" SkinID="DeleteButton" Text="<%$Resources:Resource, DeleteSelectedButton %>"
                        runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <asp:Panel ID="pnlSearch" DefaultButton="btnSearch" CssClass="headInfo" runat="server">
                    <div class="row">
                        <div class="col-sm-5">
                            <div class="input-group">
                                <asp:TextBox ID="txtKeyword" placeholder="<%$Resources:Resource, SearchKeywordLabel %>" CssClass="form-control" runat="server" MaxLength="255" />
                                <div class="input-group-btn">
                                    <asp:Button SkinID="SearchButton" ID="btnSearch" Text="<%$Resources:Resource, SearchButton %>" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <div class="workplace">
                    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                        <MasterTableView DataKeyNames="Guid" AllowSorting="false">
                            <Columns>
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, ContentDeletedName %>" DataField="ContentName" />
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, ContentDeletedCategory %>" DataField="Category" />
                                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, ContentDeletedDeletedByUser %>" DataField="DeletedByUser" />
                                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, ContentDeletedDeletedDate %>">
                                    <ItemTemplate>
                                        <%# DateTimeHelper.Format(Convert.ToDateTime(Eval("DeletedDate")), timeZone, "g", timeOffset)%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <portal:gbCutePager ID="pgr" Visible="false" runat="server" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" ></asp:Content>
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" ></asp:Content>