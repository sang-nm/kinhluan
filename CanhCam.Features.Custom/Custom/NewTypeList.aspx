<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="NewTypeList.aspx.cs" Inherits="CanhCam.Web.CustomUI.NewTypeList" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
<portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:CustomResources, NewsTypeList %>" CurrentPageUrl="~/Custom/NewTypeList.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <%--<asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:NewsResources, NewsListUpdateButton %>"
                runat="server" />--%>
            <asp:Button SkinID="InsertButton" ID="btnInsert" Text="<%$Resources:NewsResources, NewsInsertLabel %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:NewsResources, NewsListDeleteSelectedButton %>"
                runat="server" CausesValidation="false" />           
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="NewsTypeID,IsDelected" >
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:CustomResources, NewsName %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <%# Eval("Name") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="<%$Resources:CustomResources, Parent %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <%# getNewsTypeName(Eval("ParentID").ToString()) %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn> 

                        <telerik:GridTemplateColumn HeaderText="<%$Resources:CustomResources, Url %>"
                            AllowFiltering="false">
                            <ItemTemplate>
                                <%# Eval("Url") %>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                       <%-- <telerik:GridTemplateColumn HeaderText="<%$Resources:CustomResources, IsDelected %>">
                            <ItemTemplate>
                                <asp:CheckBox ID="cbDelete" runat="server" Checked='<%# Eval("IsDelected") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                         
                        <telerik:GridTemplateColumn>
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" 
                                    Text="<%$Resources:CustomResources, EditLink %>" NavigateUrl='<%# SiteRoot + "/Custom/NewTypeEdit.aspx?TypeID=" + Eval("NewsTypeID") %>'>
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
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />