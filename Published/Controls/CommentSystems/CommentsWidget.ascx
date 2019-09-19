<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="CommentsWidget.ascx.cs" Inherits="CanhCam.Web.UI.CommentsWidget" %>
<portal:CommentSystemDisplaySettings id="displaySettings" runat="server" />
<asp:Panel ID="pnlFeedback" runat="server" CssClass="bcommentpanel">
<portal:HeadingControl ID="commentListHeading" runat="server" SkinID="Comments" HeadingTag="h3" />
    <asp:Repeater ID="rptComments" runat="server" EnableViewState="true">
        <ItemTemplate>
            <asp:Panel id="pnlItem" runat="server" CssClass='<%# "postcontainer modstatus" + Eval("ModerationStatus").ToString() %>' Visible='<%# UserCanModerate || (Convert.ToInt32(Eval("ModerationStatus")) == Comment.ModerationApproved)   %>'>
            <asp:Panel id="dw1" runat="server" CssClass="forumpostheader">
                <%# FormatCommentDate(Convert.ToDateTime(Eval("CreatedUtc"))) %>
            </asp:Panel>
            <asp:Panel id="ip1" runat="server" CssClass="postwrapper">
                <asp:Panel id="pnlLeft" runat="server" CssClass="postleft">
                    <div class="forumpostusername">
                        <asp:HyperLink ID="useredit1" runat="server" 
                            ImageUrl='<%#  Page.ResolveUrl(UserEditIcon)  %>'
                            Tooltip='<%$ Resources:Resource, ManageUsersTitleLabel %>'
                            NavigateUrl='<%# SiteRoot + "/AdminCP/ManageUsers.aspx?userid=" + Eval("UserId")   %>'
                            Visible='<%# CanManageUsers && (Convert.ToInt32(Eval("UserId")) > -1) %>'  />
                        <%# GetProfileLinkOrLabel(Convert.ToInt32(Eval("UserId")), Eval("PostAuthor").ToString(), Eval("PostAuthorWebSiteUrl").ToString())%>
                    </div>
                    <div class="forumpostuseravatar">
                    <portal:Avatar id="av1" runat="server"
	                    UseLink='<%# UseProfileLink() %>'
	                    MaxAllowedRating='<%# MaxAllowedGravatarRating %>'
                        AvatarFile='<%# Eval("PostAuthorAvatar") %>'
	                    UserName='<%# Eval("PostAuthor") %>'
                        UserId='<%# Convert.ToInt32(Eval("UserId")) %>'
                        SiteId='<%# SiteId %>'
                        SiteRoot='<%# SiteRoot %>'
	                    Email='<%# Eval("AuthorEmail") %>'
                        UserNameTooltipFormat='<%# UserNameTooltipFormat %>'
	                    Disable='<%# disableAvatars %>'
	                    UseGravatar='<%# allowGravatars %>'
                        />
                    </div>
                    <div id="divRevenue" runat="server" visible='<%# showUserRevenue %>' class="forumpostuserattribute">
                        <gb:SiteLabel ID="SiteLabel1" runat="server" ConfigKey="UserSalesLabel" ResourceFile="ForumResources"
                            UseLabelTag="false" />
                        <%# string.Format(currencyCulture, "{0:c}", Convert.ToDecimal(Eval("UserRevenue"))) %>
                    </div>
                    <asp:Button SkinID="DefaultButton" id="btnDelete" runat="server" Text='<%$ Resources:Resource, DeleteButton %>' CommandName="DeleteComment" CommandArgument='<%# Eval("Guid")%>'
                        Visible='<%# UserCanModerate %>' />
                   <asp:Button SkinID="DefaultButton" id="btnApprove" runat="server" Text='<%$ Resources:Resource, ContentManagerPublishContentLink %>' CommandName="ApproveComment" CommandArgument='<%# Eval("Guid")%>'
                        Visible='<%# UserCanModerate && (Convert.ToInt32(Eval("ModerationStatus")) != Comment.ModerationApproved) %>' />
                    
                </asp:Panel>
                <asp:Panel id="pnlRight" runat="server" CssClass="postright">
                    <NeatHtml:UntrustedContent ID="UntrustedContent1" runat="server" TrustedImageUrlPattern='<%# AllowedImageUrlRegexPatern %>'
                            ClientScriptUrl="~/ClientScript/NeatHtml.js">
                    <asp:Panel id="pnlTitle" runat="server" CssClass="posttopic"  Visible='<%# UseCommentTitle %>'>
                        <<%# CommentItemHeaderElement %>>
                            <a id='post<%# Eval("Guid") %>'></a>
                            
                            <%# Server.HtmlEncode(Eval("Title").ToString())%></<%# CommentItemHeaderElement %>>
                    </asp:Panel>
                    <asp:Panel id="pnlBody" runat="server" CssClass="postbody">
                            <%# Eval("UserComment").ToString()%>   
                    </asp:Panel>
                   </NeatHtml:UntrustedContent>
                    <asp:HyperLink  CssClass="commentEdit ceditlink" Text="<%$ Resources:Resource, EditLink %>"
                                ID="editLink" 
                                 NavigateUrl='<%# EditBaseUrl + "&c=" + Eval("Guid")  %>'
                                Visible='<%# UserCanEdit(new Guid(Eval("UserGuid").ToString()), Eval("UserEmail").ToString(), Convert.ToInt32(Eval("ModerationStatus")), Convert.ToDateTime(Eval("CreatedUtc"))) %>' runat="server" />
                </asp:Panel>
            </asp:Panel>
            </asp:Panel>
        </ItemTemplate>
        <AlternatingItemTemplate>
            <asp:Panel id="pnlItem" runat="server" CssClass='<%# "postcontainer postcontaineralt modstatus" + Eval("ModerationStatus").ToString() %>' Visible='<%# UserCanModerate || (Convert.ToInt32(Eval("ModerationStatus")) == Comment.ModerationApproved)   %>'>
            <asp:Panel id="dw1" runat="server" CssClass="forumpostheader">
                <%# FormatCommentDate(Convert.ToDateTime(Eval("CreatedUtc"))) %>
            </asp:Panel>
            <asp:Panel id="ip1" runat="server" CssClass="postwrapper">
                <asp:Panel id="pnlLeft" runat="server" CssClass="postleft">
                    <div class="forumpostusername">
                        <asp:HyperLink ID="edituser2"  runat="server"
                            Tooltip='<%$ Resources:Resource, ManageUsersTitleLabel %>'
                            ImageUrl='<%# Page.ResolveUrl(UserEditIcon)  %>'
                            NavigateUrl='<%# SiteRoot + "/AdminCP/ManageUsers.aspx?userid=" + Eval("UserId")   %>'
                            Visible='<%# CanManageUsers && (Convert.ToInt32(Eval("UserId")) > -1) %>' />
                        <%# GetProfileLinkOrLabel(Convert.ToInt32(Eval("UserId")), Eval("PostAuthor").ToString(),Eval("PostAuthorWebSiteUrl").ToString())%>
                    </div>
                    <div class="forumpostuseravatar">
                    <portal:Avatar id="av1" runat="server"
	                    UseLink='<%# UseProfileLink() %>'
	                    MaxAllowedRating='<%# MaxAllowedGravatarRating %>'
                        AvatarFile='<%# Eval("PostAuthorAvatar") %>'
	                    UserName='<%# Eval("PostAuthor") %>'
                        UserId='<%# Convert.ToInt32(Eval("UserId")) %>'
                        SiteId='<%# SiteId %>'
                        SiteRoot='<%# SiteRoot %>'
	                    Email='<%# Eval("AuthorEmail") %>'
                        UserNameTooltipFormat='<%# UserNameTooltipFormat %>'
	                    Disable='<%# disableAvatars %>'
	                    UseGravatar='<%# allowGravatars %>'
                        />
                    </div>
                    <div id="divRevenue" runat="server" visible='<%# showUserRevenue %>' class="forumpostuserattribute">
                        <gb:SiteLabel ID="SiteLabel1" runat="server" ConfigKey="UserSalesLabel" ResourceFile="ForumResources"
                            UseLabelTag="false" />
                        <%# string.Format(currencyCulture, "{0:c}", Convert.ToDecimal(Eval("UserRevenue"))) %>
                    </div>
                    <asp:Button SkinID="DefaultButton" id="btnDelete" runat="server" Text='<%$ Resources:Resource, DeleteButton %>' CommandName="DeleteComment" CommandArgument='<%# Eval("Guid")%>'
                        Visible='<%# UserCanModerate %>' />
                    <asp:Button SkinID="DefaultButton" id="btnApprove" runat="server" Text='<%$ Resources:Resource, ContentManagerPublishContentLink %>' CommandName="ApproveComment" CommandArgument='<%# Eval("Guid")%>'
                        Visible='<%# UserCanModerate && (Convert.ToInt32(Eval("ModerationStatus")) != Comment.ModerationApproved) %>' />
                </asp:Panel>
                <asp:Panel id="pnlRight" runat="server" CssClass="postright"> 
                    <NeatHtml:UntrustedContent ID="UntrustedContent1" runat="server" TrustedImageUrlPattern='<%# AllowedImageUrlRegexPatern %>'
                            ClientScriptUrl="~/ClientScript/NeatHtml.js">
                    <asp:Panel id="pnlTitle" runat="server" CssClass="posttopic" Visible='<%# UseCommentTitle %>'>
                        <<%# CommentItemHeaderElement %>>
                            <a id='post<%# Eval("Guid") %>'></a>
                            <%# Server.HtmlEncode(Eval("Title").ToString())%></<%# CommentItemHeaderElement %>>
                    </asp:Panel>
                    <asp:Panel id="pnlBody" runat="server" CssClass="postbody">
                            <%# Eval("UserComment").ToString()%>
                    </asp:Panel>    
                    </NeatHtml:UntrustedContent>
                    <asp:HyperLink  CssClass="commentEdit ceditlink" Text="<%$ Resources:Resource, EditLink %>"
                                ID="editLink" 
                                NavigateUrl='<%# EditBaseUrl + "&c=" + Eval("Guid")  %>'
                                Visible='<%# UserCanEdit(new Guid(Eval("UserGuid").ToString()), Eval("UserEmail").ToString(), Convert.ToInt32(Eval("ModerationStatus")), Convert.ToDateTime(Eval("CreatedUtc"))) %>' runat="server" />
                </asp:Panel>
            </asp:Panel>
            </asp:Panel>
        </AlternatingItemTemplate>
    </asp:Repeater>
    <portal:CommentEditor id="commentEditor" runat="server" />
    <asp:Panel ID="pnlCommentsClosed" runat="server" EnableViewState="false" CssClass="commentsclosed">
        <asp:Literal ID="litCommentsClosed" runat="server" EnableViewState="false" />
    </asp:Panel>
    <asp:Panel ID="pnlCommentsRequireAuthentication" runat="server" Visible="false" EnableViewState="false" CssClass="commentsclosed">
        <portal:SignInOrRegisterPrompt ID="srPrompt" runat="server" />
    </asp:Panel>
</asp:Panel>
<div id="divCommentService" runat="server" enableviewstate="false" class="blogcommentservice commentservice">
    <portal:IntenseDebateDiscussion ID="intenseDebate" runat="server" EnableViewState="false" />
    <portal:DisqusWidget ID="disqus" runat="server" RenderPoweredBy="false" EnableViewState="false" />
    <portal:FacebookCommentWidget ID="fbComments" runat="server" Visible="false" EnableViewState="false" SkinID="Blog" />
</div>
