<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="AuthorManageGratitude.ascx.cs" Inherits="CanhCam.Web.CustomUI.AuthorManageGratitude" %>
<%@ Register Src="~/Custom/LeftMenu.ascx" TagPrefix="portal" TagName="LeftMenu" %>



<div class="container">
    <div class="row flex flex-wrap">
        <div class="col-xs-12 col-lg-3">
            <portal:LeftMenu runat="server" ID="LeftMenu" />
        </div>
        <div class="col-xs-12 col-lg-9">
            <section class="user-page clearfix">
                <div class="post-title-wrap clearfix">
                    <h1 class="postname">Manage Gratitude</h1>
                </div>
                <div class="row flex flex-wrap">
                        <section class="comment-list">
                            <asp:ListView runat="server" ID="listviewComment" GroupItemCount="8" DataKeyNames="" OnItemCommand="listviewComment_ItemCommand" OnItemDeleting="listviewComment_ItemDeleting">
                                <LayoutTemplate>
                                    <table cellpadding="1" runat="server" id="tblComment" style="width: 100%;">
                                        <tr runat="server" id="groupPlaceholder">
                                        </tr>
                                    </table>

                                </LayoutTemplate>
                                <GroupTemplate>
                                    <tr runat="server" id="characterRow">
                                        <td runat="server" id="itemPlaceholder"></td>
                                    </tr>
                                </GroupTemplate>
                                <ItemTemplate>
                                    <td runat="server">
                                        <div class="comment-item">
                                            <figure class="row flex flex-wrap">
                                                <div class="col-xs-12 col-md-2">

                                                    <div class="item-img">
                                                        <img src="<%# getImageURL(int.Parse(Eval("UserID").ToString())) %>" alt="">
                                                    </div>
                                                    <div class="item-name"><%# getNameUser(int.Parse(Eval("UserID").ToString())) %></div>
                                                </div>
                                                <div class="col-xs-12 col-md-10">
                                                    <figcaption>
                                                        <div class="item-content"><%# Eval("Comment") %></div>
                                                        <time><%# Eval("CreateDate") %></time>
                                                        <div class="item-article"><%#Eval("Newstitle")  %></div>
                                                        <asp:Label id="CommentID" Visible="false" runat="server" Text='<%# Eval("CommentID") %>'></asp:Label>
                                                  
                                                        </figcaption>
                                                </div>
                                            </figure>
                                            <div class="button-wrap">
                                                
                                                <div class="btn-approve">
                                                    <asp:Button ID="btnapprove" Visible='<%# !Convert.ToBoolean(Eval("isPublish")) %>' Text="<%$Resources:CustomResources, ApproveButton %>" CommandName="Approve" runat="server" CausesValidation="False" />
                                                </div>
                                                <div class="btn-delete-comment">
                                                    <asp:Button ID="btnDelete" Text="<%$Resources:CustomResources, DeleteButton %>" CommandName="Delete" runat="server" CausesValidation="False" />
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </ItemTemplate>
                            </asp:ListView>


                        </section>
                        <div class="comment-info">
                            <div class="btn-viewmore">
                                <a href="#">
                                    <%--                                    <div class="count">
                                        <div class="show">6</div>
                                        <div class="all">20</div>
                                    </div>--%>
                                    <span>Xem thêm</span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
