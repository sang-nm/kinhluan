<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="JobCVList.aspx.cs" Inherits="CanhCam.Web.NewsUI.JobCVList" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <portal:HeadingControl ID="heading" runat="server" />
    <div class="wrap01 right">
        <asp:Button CssClass="cp-button" ID="btnDelete" Text="<%$Resources:NewsResources, NewsListDeleteSelectedButton %>"
            runat="server" CausesValidation="false" />
        <asp:HyperLink CssClass="cp-link" ID="lnkCancel" Text="<%$Resources:NewsResources, NewsEditCancelButton %>"
            runat="server" />
    </div>
    <div class="clear"></div>
    <div class="cp-gridwrap">
        <div class="cp-outerwrap">
            <div class="cp-innerwrap">
                <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                    <MasterTableView DataKeyNames="NewsID,Status,UserGuid,LastModUserGuid">
                        <Columns>
                            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:Resource, RowNumber %>"
                                AllowFiltering="false">
                                <ItemTemplate>
                                    <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, NewsEditTitleLabel %>"
                                DataField="Title" UniqueName="Title" SortExpression="Title" CurrentFilterFunction="Contains"
                                AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100%">
                                <ItemTemplate>
                                    <h4 class="newstitle">
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
                            </telerik:GridTemplateColumn>
                            <%--<telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:NewsResources, NewsEditDisplayOrderLabel %>"
                                AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDisplayOrder" CssClass="cp-input-grid" SkinID="NumericTextBoxSkin"
                                        MaxLength="4" Text='<%# Eval("DisplayOrder") %>' runat="server" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:NewsResources, NewsEditViewedLabel %>"
                                AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtViewed" CssClass="cp-input-grid" SkinID="NumericTextBoxSkin"
                                        MaxLength="9" Text='<%# Eval("Viewed") %>' runat="server" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:NewsResources, NewsManagePublishedDate %>"
                                AllowFiltering="false">
                                <ItemTemplate>
                                    <%# FormatDate(Eval("StartDate")) %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, NewsManageCreatedBy %>"
                                AllowFiltering="false">
                                <ItemTemplate>
                                    <%# Eval("CreatedByName") %>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" 
                                        Visible='<%# CanEditNews(Convert.ToInt32(Eval("ModuleID")), Convert.ToInt32(Eval("UserID")), Convert.ToBoolean(Eval("IsPublished"))) %>'
                                        Text='<%# EditLinkText %>' NavigateUrl='<%# SiteRoot + "/News/NewsEdit.aspx?pageid=" + pageId + "&NewsID=" + Eval("NewsID") + "&mid=" + moduleId %>'>
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>--%>
                            <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%"
                                UniqueName="ClientSelectColumn" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </div>
    </div>

    <portal:gbCutePager ID="pgr" runat="server" />
</asp:Content>