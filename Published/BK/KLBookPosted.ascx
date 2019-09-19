<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLBookPosted.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLBookPosted" %>




<%@ Register Src="~/Custom/LeftMenu.ascx" TagPrefix="portal" TagName="LeftMenu" %>

<div class="container">
    <div class="row flex flex-wrap">
        <div class="col-xs-12 col-lg-3">
            <portal:LeftMenu runat="server" ID="LeftMenu" />
        </div>
        <div class="col-xs-12 col-lg-9">
            <section class="user-page clearfix">
                <div class="row flex flex-wrap">
                    <div class="col-xs-12">
                        <div class="user-tool clearfix">
                            <div class="user-search">
                                <asp:TextBox runat="server" ID="txtsearch" placeholder="Search..."></asp:TextBox>
                                <asp:LinkButton CssClass="btn-search" ID="btnsearch" runat="server"><i class="fa fa-search" aria-hidden="true"></i></asp:LinkButton>
                            </div>
                        <%--    <div class="btn-delete"><a href="#">Delete</a></div>
                            <div class="btn-new"><a href="#">New Article</a></div>--%>
                               <div class="btn-new">
                                    <asp:Button ID="btncreate" Text="<%$Resources:CustomResources, CreateBookButton %>" runat="server" CausesValidation="False" />
                                </div>
                               <div class="btn-delete">
                                    <asp:Button ID="btndelete" Text="<%$Resources:CustomResources, DeleteBookButton %>" runat="server" CausesValidation="False" />
                                </div>
                        </div>
                        <div class="table-responsive">
                            
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server" PagerStyle-Wrap="True"
                PagerStyle-Visible="True" PagerStyle-ShowPagerText="True" AllowPaging="True" >
                <MasterTableView DataKeyNames="BookID" AllowFilteringByColumn="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="1%" ItemStyle-Width="1%" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                        <telerik:GridTemplateColumn HeaderStyle-Width="1%"  ItemStyle-Width="20px" ItemStyle-Height="20px" HeaderText="<%$Resources:CustomResources, Title %>">
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="EditLink1" runat="server"
                                    NavigateUrl='<%# EditPageUrl + "?BookID=" + Eval("BookID") %>'>
                                   <asp:Image ImageUrl='<%# "/Data/Sites/1/Book/"+Eval("BookID")+"/"+Eval("Image") %>' runat="server" Style="width:50px;height:50px;" />
                                </asp:HyperLink>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>  
                        <telerik:GridTemplateColumn HeaderStyle-Width="5%" HeaderText="<%$Resources:CustomResources, Title %>">
                            <ItemTemplate>
                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server"
                                    NavigateUrl='<%# EditPageUrl + "?BookID=" + Eval("BookID") %>'>
                                    <%# Eval("Title") %>
                                </asp:HyperLink>
                                <div class="edit"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>  
                         <telerik:GridClientSelectColumn  ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                            HeaderStyle-Width="5%" ItemStyle-Width="5%" UniqueName="ClientSelectColumn" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
