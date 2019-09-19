<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="CommentControl.ascx.cs"
    Inherits="CanhCam.Web.ProductUI.CommentControl" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.Product" Namespace="CanhCam.Web.ProductUI" %>
<Site:ProductDisplaySettings ID="displaySettings" runat="server" />
<div id="pnlFeedback" visible="false" runat="server" class="pcommentpanel">
    <asp:UpdatePanel ID="up" runat="server">
        <ContentTemplate>
            <portal:HeadingControl ID="commentListHeading" runat="server" SkinID="ProductComments" HeadingTag="h3" />
            <asp:Repeater ID="dlComments" runat="server" EnableViewState="true" OnItemCommand="dlComments_ItemCommand">
                <ItemTemplate>
                    <div class="comment">
                        <div class="cmtitle">
                            <%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Title").ToString()) %>
                            <asp:LinkButton ID="btnDelete" runat="server" 
                                ToolTip="<%# Resources.NewsResources.DeleteImageAltText %>" ImageUrl='<%# Page.ResolveUrl(DeleteLinkImage) %>'
                                CommandName="DeleteComment" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"CommentID")%>'
                                Visible="<%# IsEditable%>" CausesValidation="false"><i class="fa fa-trash-o"></i></asp:LinkButton>
                        </div>
                        <div class="cmtext">
                            <NeatHtml:UntrustedContent ID="UntrustedContent1" runat="server" EnableViewState="false"
                                TrustedImageUrlPattern='<%# RegexRelativeImageUrlPatern %>' ClientScriptUrl="~/ClientScript/NeatHtml.js">
                                <asp:Literal ID="litComment" runat="server" EnableViewState="false" Text='<%# DataBinder.Eval(Container.DataItem, "ContentText").ToString() %>' />
                            </NeatHtml:UntrustedContent>
                        </div>
                        <div class="cmposter">
                            <span class="poster"><%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"FullName").ToString()) %></span>
                            <span class="date">
                                <%# FormatCommentDate(Convert.ToDateTime(Eval("CreatedUtc"))) %>
                            </span>
                        </div>
                    </div>
                </ItemTemplate>
                <HeaderTemplate><div class="commentlist"></HeaderTemplate>
                <FooterTemplate></div></FooterTemplate>
            </asp:Repeater>

            <div id="divEnterComments" class="entercomments" runat="server" visible="false">
                <h3>
                    <gb:SiteLabel ID="lblFeedback" runat="server" ConfigKey="CommentYourCommentTitle" ResourceFile="ProductResources"
                        EnableViewState="false" />
                </h3>
                <asp:Panel ID="pnlNewComment" DefaultButton="btnPostComment" runat="server">
                    <div id="divRating" runat="server" class="form-group cm-rating">
                        <gb:SiteLabel ID="lblRating" runat="server" ForControl="ratRating" CssClass="label"
                            ConfigKey="CommentRating" ResourceFile="ProductResources" EnableViewState="false">
                        </gb:SiteLabel>
                        <telerik:RadRating ID="ratRating" SkinID="radRatingSkin" runat="server" /> 
                    </div>
                    <div id="divTitle" runat="server" class="form-group cm-title">
                        <gb:SiteLabel ID="lblCommentTitle" runat="server" ForControl="txtCommentTitle" CssClass="label"
                            ConfigKey="CommentTitle" ResourceFile="ProductResources" EnableViewState="false">
                        </gb:SiteLabel>
                        <asp:TextBox ID="txtCommentTitle" runat="server" MaxLength="100" EnableViewState="false" />
                    </div>
                    <div id="divFullName" runat="server" class="form-group cm-name">
                        <gb:SiteLabel ID="lblFullName" runat="server" ForControl="txtFullName" CssClass="label"
                            ConfigKey="CommentFullName" ResourceFile="ProductResources" EnableViewState="false">
                        </gb:SiteLabel>
                        <asp:TextBox ID="txtFullName" runat="server" MaxLength="100" EnableViewState="false" />
                    </div>
                    <div id="divComment" runat="server" class="form-group cm-comment">
                        <gb:SiteLabel ID="lblComment" runat="server" CssClass="label" ConfigKey="CommentYourComment"
                            ResourceFile="ProductResources" EnableViewState="false" />
                        <asp:TextBox ID="txtComment" TextMode="MultiLine" runat="server" />
                        <asp:RequiredFieldValidator ID="reqMessage" ToolTip="<%$Resources:ContactFormResources, ContactFormEmptyMessageWarning %>"
                            ValidationGroup="ProductComments" runat="server" Display="Dynamic" ControlToValidate="txtComment"
                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </div>
                    <asp:Panel ID="pnlAntiSpam" class="form-group cm-captcha" runat="server" Visible="true">
                        <gb:SiteLabel ID="lblCaptcha" runat="server" ForControl="captcha" CssClass="label"
                            ConfigKey="CommentCaptcha" ResourceFile="ProductResources" EnableViewState="false">
                        </gb:SiteLabel>
                        <div class="left">
                            <telerik:RadCaptcha ID="captcha" runat="server" ValidationGroup="ProductComments" EnableRefreshImage="true" 
                                CaptchaTextBoxLabel="" ErrorMessage="<%$Resources:Resource, CaptchaFailureMessage %>" 
                                CaptchaTextBoxTitle="<%$Resources:Resource, CaptchaInstructions %>" 
                                CaptchaLinkButtonText="<%$Resources:Resource, CaptchaRefreshImage %>" />
                        </div>
                    </asp:Panel>
                    <div class="clear"></div>
                    <div class="form-group cm-button">
                        <asp:Button CssClass="cm-button" ID="btnPostComment" runat="server" Text="Submit"
                            ValidationGroup="ProductComments" />
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlCommentsClosed" CssClass="comment-closed" runat="server" EnableViewState="false">
                    <asp:Literal ID="litCommentsClosed" runat="server" EnableViewState="false" />
                </asp:Panel>
                <asp:Panel ID="pnlCommentsRequireAuthentication" CssClass="comment-requireauth" runat="server" Visible="false" EnableViewState="false">
                    <asp:Literal ID="litCommentsRequireAuthentication" runat="server" EnableViewState="false" />
                </asp:Panel>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>