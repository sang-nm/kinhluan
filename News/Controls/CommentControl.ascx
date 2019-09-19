<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="CommentControl.ascx.cs"
    Inherits="CanhCam.Web.NewsUI.CommentControl" %>
<div id="pnlFeedback" visible="false" runat="server" class="bcommentpanel">
    <portal:HeadingControl ID="commentListHeading" runat="server" SkinID="NewsComments"
        HeadingTag="h3" />
    <%--<asp:Xml ID="xmlTransformer" runat="server"></asp:Xml>
    <div id="divPager" runat="server" class="pages">
        <portal:gbCutePager ID="pgr" runat="server" />
    </div>--%>
    <div class="comments">
        <asp:Repeater ID="dlComments" runat="server" EnableViewState="true" OnItemCommand="dlComments_ItemCommand">
            <ItemTemplate>
                <h4 class="newstitle">
                    <asp:LinkButton ID="btnDelete" runat="server" AlternateText="<%# Resources.NewsResources.DeleteImageAltText %>"
                        ToolTip="<%# Resources.NewsResources.DeleteImageAltText %>" ImageUrl='<%# DeleteLinkImage %>'
                        CommandName="DeleteComment" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"NewsCommentID")%>'
                        Visible="<%# IsEditable%>"><i class="fa fa-trash-o"></i></asp:LinkButton>
                    <asp:Literal ID="litTitle" runat="server" EnableViewState="false" Text='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Title").ToString()) %>' />
                </h4>
                <div>
                    <asp:Label ID="Label2" Visible="True" runat="server" EnableViewState="false" CssClass="newsdate"
                        Text='<%# FormatCommentDate(Convert.ToDateTime(Eval("DateCreated"))) %>' />
                    <asp:Label ID="Label3" runat="server" EnableViewState="false" Visible='<%# (bool) (DataBinder.Eval(Container.DataItem, "URL").ToString().Length == 0) %>'
                        CssClass="newscommentposter">
					        <%#  Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Name").ToString()) %>
                    </asp:Label>
                    <NeatHtml:UntrustedContent ID="UntrustedContent2" runat="server" EnableViewState="false"
                        TrustedImageUrlPattern='<%# RegexRelativeImageUrlPatern %>' ClientScriptUrl="~/ClientScript/NeatHtml.js">
                        <asp:HyperLink ID="Hyperlink2" runat="server" EnableViewState="false" Visible='<%# (bool) (DataBinder.Eval(Container.DataItem, "URL").ToString().Length != 0) %>'
                            Text='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Name").ToString()) %>'
                            NavigateUrl='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"URL").ToString())%>'
                            CssClass="newscommentposter">
                        </asp:HyperLink>
                    </NeatHtml:UntrustedContent>
                </div>
                <div class="newscommenttext">
                    <NeatHtml:UntrustedContent ID="UntrustedContent1" runat="server" EnableViewState="false"
                        TrustedImageUrlPattern='<%# RegexRelativeImageUrlPatern %>' ClientScriptUrl="~/ClientScript/NeatHtml.js">
                        <asp:Literal ID="litComment" runat="server" EnableViewState="false" Text='<%# DataBinder.Eval(Container.DataItem, "Comment").ToString() %>' />
                    </NeatHtml:UntrustedContent>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <fieldset id="fldEnterComments" runat="server" visible="false">
        <legend>
            <gb:SiteLabel ID="lblFeedback" runat="server" ConfigKey="NewComment" ResourceFile="NewsResources"
                EnableViewState="false" />
        </legend>
        <asp:Panel ID="pnlNewComment" DefaultButton="btnPostComment" runat="server">
            <div class="settingrow">
                <gb:SiteLabel ID="lblCommentTitle" runat="server" ForControl="txtCommentTitle" CssClass="settinglabel"
                    ConfigKey="NewsCommentTitleLabel" ResourceFile="NewsResources" EnableViewState="false">
                </gb:SiteLabel>
                <asp:TextBox ID="txtCommentTitle" runat="server" MaxLength="100" EnableViewState="false"
                    CssClass="forminput widetextbox">
                </asp:TextBox>
            </div>
            <div class="settingrow">
                <gb:SiteLabel ID="lblCommentUserName" runat="server" ForControl="txtName" CssClass="settinglabel"
                    ConfigKey="NewsCommentUserNameLabel" ResourceFile="NewsResources" EnableViewState="false">
                </gb:SiteLabel>
                <asp:TextBox ID="txtName" runat="server" MaxLength="100" EnableViewState="false"
                    CssClass="forminput widetextbox">
                </asp:TextBox>
            </div>
            <div id="divCommentUrl" runat="server" class="settingrow">
                <gb:SiteLabel ID="lblCommentURL" runat="server" ForControl="txtURL" CssClass="settinglabel"
                    ConfigKey="NewsCommentUrlLabel" ResourceFile="NewsResources" EnableViewState="false">
                </gb:SiteLabel>
                <asp:TextBox ID="txtURL" runat="server" MaxLength="200" EnableViewState="true" CssClass="forminput widetextbox" />
                <asp:RegularExpressionValidator ID="regexUrl" runat="server" ControlToValidate="txtURL"
                    Display="Dynamic" ValidationGroup="newscomments" ValidationExpression="(((http(s?))\://){1}\S+)">
                </asp:RegularExpressionValidator>
            </div>
            <div class="settingrow">
                <gb:SiteLabel ID="lblRememberMe" runat="server" ForControl="chkRememberMe" CssClass="settinglabel"
                    ConfigKey="NewsCommentRemeberMeLabel" ResourceFile="NewsResources" EnableViewState="false">
                </gb:SiteLabel>
                <asp:CheckBox ID="chkRememberMe" runat="server" EnableViewState="false" CssClass="forminput">
                </asp:CheckBox>
            </div>
            <div class="settingrow">
                <gb:SiteLabel ID="SiteLabel1" runat="server" CssClass="settinglabel" ConfigKey="NewsCommentCommentLabel"
                    ResourceFile="NewsResources" EnableViewState="false"></gb:SiteLabel>
            </div>
            <div class="settingrow">
                <gbe:EditorControl ID="edComment" runat="server">
                </gbe:EditorControl>
            </div>
            <asp:Panel ID="pnlAntiSpam" runat="server" Visible="true">
                <gb:CaptchaControl ID="captcha" runat="server" />
            </asp:Panel>
            <div class="modulebuttonrow">
                <asp:Button SkinID="DefaultButton" ID="btnPostComment" runat="server" Text="Submit"
                    ValidationGroup="newscomments" />
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlCommentsClosed" runat="server" EnableViewState="false">
            <asp:Literal ID="litCommentsClosed" runat="server" EnableViewState="false" />
        </asp:Panel>
        <asp:Panel ID="pnlCommentsRequireAuthentication" runat="server" Visible="false" EnableViewState="false">
            <asp:Literal ID="litCommentsRequireAuthentication" runat="server" EnableViewState="false" />
        </asp:Panel>
    </fieldset>
</div>