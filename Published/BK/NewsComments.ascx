<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="NewsComments.ascx.cs" Inherits="CanhCam.Web.CustomUI.NewsComments" %>

<div id="pncomment" class="commentpanel">
    <div class="container">
        <div class="row">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="col-xs-12 col-xl-9 col-comment">
                        <div class="messagecomment" runat="server" id="divmessagecomment">
                        </div>
                        <div class="maincomment">
                            <div class="maincommentinfo">
                                <div class="author">
                                    <asp:Image ID="imgAvatar" runat="server" placeholder="" />
                                </div>
                                <div class="journalClose"></div>
                                <div class="journalInfo">
                                    <asp:TextBox runat="server" ID="txtFullName" class="txtFullName" placeholder="Your Name (*)" required="true"  type="text" />
                                    <asp:TextBox runat="server" ID="txtEmail" class="txtEmail" placeholder="Your Email" type="text" />
                                   
                                </div>
                                <div class="form-group">
                                    <label for="txtcomment" >Comment:</label>
                                    <asp:TextBox runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" class="journalContent" ID="txtcomment" placeholder="Your Comment..."></asp:TextBox><br />

                                </div>
                                <asp:Button type="button" runat="server" ID="btnSendComment" class="btnSendComment" Text="Gửi bình luận" />

                            </div>
                        </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="clearfix"></div>
            <div class="rptcomment">

                <asp:Repeater ID="rptCommentTop" runat="server" OnItemCommand="rptComments_ItemCommand">
                    <ItemTemplate>
                        <div class="divcomment">
                            <div class="asktop">
                                <div class="author">
                                    <asp:Image runat="server" ImageUrl='<%# getimgURL(Convert.ToInt32(Eval("CommentID"))) %>' />

                                </div>
                                <div class="journalitem">
                                    <div class="journalsummary">
                                        <strong>
                                            <%# Eval("Name") %>
                                        </strong>
                                        <div>
                                            <%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Comment").ToString()).Replace("\n", "<br/>").Replace("\r\n", "<br />") %>
                                        </div>
                                    </div>
                                    <div class="journalfooter">
                                        <a class="cmreply" data-cmdid='<%#"cmtbtn-" + Eval("CommentID") %>' href="#">Reply</a>
                                        <abbr title='<%# DateTimeHelper.Format(Convert.ToDateTime(Eval("CreateDate")), timeZone, "g", timeOffset) %>'>
                                            <%# GetTimeAgo(Convert.ToDateTime(Eval("CreateDate")), timeZone, timeOffset) %>
                                        </abbr>
                                    </div>
                                </div>
                            </div>
                            <ul id='<%#"jcmt-" + Eval("CommentID") %>' class="jcmt clearfix">
                                <asp:Repeater ID="rptChildComments" DataSource='<%# GetChildComments(Convert.ToInt32(Eval("CommentID"))) %>' runat="server">
                                    <ItemTemplate>

                                        <li id='<%#"cmt-" + Eval("CommentID") %>'>
                                            <div class="author">
                                                <asp:Image runat="server" ImageUrl='<%# getimgURL(Convert.ToInt32(Eval("CommentID"))) %>' />

                                            </div>
                                            <div class="journalsummary">
                                                <strong>
                                                    <%# Eval("Name") %>
                                                </strong>
                                                <div>
                                                    <%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Comment").ToString()).Replace("\n", "<br/>").Replace("\r\n", "<br />") %>
                                                </div>
                                            </div>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <li class="cmtbtn" id="<%#"cmtbtn-" + Eval("CommentID") %>">
                                    <div class="divsubcomment col-sm-12">

                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="form-group ">
                                                    <label for="txtcomment">Comment:</label>
                                                    <asp:TextBox runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" class="journalContent" ID="txtsubcomment" placeholder="Your Comment..."></asp:TextBox><br />

                                                </div>
                                                <div class="cmtinfo">
                                                    <asp:TextBox runat="server" type="text" class="cmtname" placeholder="Your Name (*)" required="true" ID="txtsubname" MaxLength="100" />
                                                    <asp:TextBox runat="server" type="text" class="cmtemail" placeholder="Your Email" ID="txtsubemail" MaxLength="100" />
                                                    <asp:HiddenField Value='<%# Eval("CommentID") %>' runat="server" ID="hdcommentid" />
                                                    <asp:Button Text="Gửi bình luận" runat="server" CommandName="btnsubsend" />
                                                </div>

                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('.cmtbtn').hide();
        $('.cmreply').on("click", function (e) {
            var iddivcm = "#" + $(this).attr("data-cmdid");
            $(iddivcm).show();
            e.preventDefault();
        });
    });
</script>
