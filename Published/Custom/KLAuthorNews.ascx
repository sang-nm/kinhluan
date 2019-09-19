<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLAuthorNews.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLAuthorNews" %>
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
                                <asp:Panel runat="server" DefaultButton="btnsearch">
                                <asp:TextBox runat="server" ID="txtsearch" CssClass="txtsearch" placeholder="Search..."></asp:TextBox>
                                <asp:LinkButton CssClass="btn-search" ID="btnsearch" runat="server"><i class="fa fa-search" aria-hidden="true"></i></asp:LinkButton>
                           </asp:Panel> </div>
                           
                            <%--    <div class="btn-delete"><a href="#">Delete</a></div>
                            <div class="btn-new"><a href="#">New Article</a></div>--%>
                            <div class="btn-new">
                                <asp:Button ID="btncreate" Text="<%$Resources:CustomResources, CreateNewButton %>" runat="server" CausesValidation="False" />
                            </div>
                            <div class="btn-delete">
                                <asp:Button ID="btndelete" Text="<%$Resources:CustomResources, DeleteArticleButton %>" runat="server" CausesValidation="False" />
                            </div>
                        </div>
                        <div class="table-responsive">

                            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server" PagerStyle-Wrap="True"
                                PagerStyle-Visible="True" PagerStyle-ShowPagerText="True" AllowPaging="True">
                                <MasterTableView DataKeyNames="NewsID" AllowFilteringByColumn="false">
                                    <Columns>
                                        <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="5%" ItemStyle-Width="5%" UniqueName="ClientSelectColumn" />
                                        <telerik:GridTemplateColumn HeaderStyle-Width="5%" HeaderText="<%$Resources:CustomResources, Title %>">
                                            <ItemTemplate>
                                                <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server"
                                                    NavigateUrl='<%# EditPageUrl + "?NewsID=" + Eval("NewsID") %>'>
                                    <%# Eval("Title") %>
                                                </asp:HyperLink>
                                                <div class="edit"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></div>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:CustomResources, Comments %>">
                                            <ItemTemplate>
                                                <i class="fa fa-comments" aria-hidden="true"></i><span><%# Eval("CommentCount").ToString()%></span><a href="/manage-comment?NewID=<%# Eval("NewsID") %>" class="comment-link" style="color: white">See</a>

                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:CustomResources, View %>">
                                            <ItemTemplate>
                                                <%# getviewcount(Convert.ToInt32(Eval("NewsID")))%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources:CustomResources, DateOfPost %>">
                                            <ItemTemplate>
                                                <%# Eval("Datepost").ToString()%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

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
<%--<script>
    $(document).ready(function () {
        $('#ctl00_mainContent_ctl00_txtsearch').bind("enterKey", function (e) {
            alert($('#ctl00_mainContent_ctl00_btnsearch').attr("href"));
            //$('#ctl00_mainContent_ctl00_btnsearch').click();
            //e.preventDefault();

        });
        $('#ctl00_mainContent_ctl00_txtsearch').keydown(function (e) {
            if (e.keyCode == 13) {
                $(this).trigger("enterKey"); 
            }
        });
    });
   

</script>--%>
