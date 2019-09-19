<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="JobCVListDialog.aspx.cs" Inherits="CanhCam.Web.NewsUI.JobCVListDialog" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="wrap01 right">
        <asp:HyperLink ID="lnkRefresh" CssClass="cp-link" runat="server" />
        <asp:HyperLink ID="lnkViewAll" CssClass="cp-link" runat="server" />
        <asp:Button SkinID="DefaultButton" ID="btnDelete" Text="<%$Resources:NewsResources, NewsListDeleteSelectedButton %>"
            runat="server" CausesValidation="false" />
    </div>
    <div class="clear"></div>
    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
        <MasterTableView DataKeyNames="NewsID,NewsCommentID">
            <Columns>
                <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderText="<%$Resources:Resource, RowNumber %>"
                    AllowFiltering="false">
                    <ItemTemplate>
                        <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, JobPositionLabel %>">
                    <ItemTemplate>
                        <asp:HyperLink CssClass="cp-link" ID="hplTitle" runat="server" EnableViewState="false" Visible='<%# (bool) (DataBinder.Eval(Container.DataItem, "URL").ToString().Length != 0) %>'
                            Text='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Title").ToString()) %>' Target="_blank"
                            NavigateUrl='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"URL").ToString())%>'>
                        </asp:HyperLink>
                        <asp:Literal ID="litTitle" Visible='<%# (bool) (DataBinder.Eval(Container.DataItem, "URL").ToString().Length == 0) %>' Text='<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Title").ToString()) %>' runat="server" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, JobCandidateInfoLabel %>">
                    <ItemTemplate>
                        <div>
                            <b>
                                <asp:Literal ID="litFullName" Text="<%$Resources:NewsResources, JobFullNameLabel %>" EnableViewState="false" runat="server" />:
                            </b>&nbsp;
                            <%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Name").ToString()) %>
                        </div>
                        <div>
                            <b>
                                <asp:Literal ID="litAddress" Text="<%$Resources:NewsResources, JobAddressLabel %>" EnableViewState="false" runat="server" />:
                            </b>&nbsp;
                            <%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Address").ToString()) %>
                        </div>
                        <div>
                            <b>
                                <asp:Literal ID="litEmail" Text="<%$Resources:NewsResources, JobEmailLabel %>" EnableViewState="false" runat="server" />:
                            </b>&nbsp;
                            <%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Email").ToString()) %>
                        </div>
                        <div>
                            <b>
                                <asp:Literal ID="litPhone" Text="<%$Resources:NewsResources, JobPhoneLabel %>" EnableViewState="false" runat="server" />:
                            </b>&nbsp;
                            <%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"Phone").ToString()) %>
                        </div>
                        <%# FormatDate(Convert.ToDateTime(Eval("CreatedDate"))) %>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, JobMessageLabel %>">
                    <ItemTemplate>
                        <NeatHtml:UntrustedContent ID="UntrustedContent2" runat="server" EnableViewState="false"
                            TrustedImageUrlPattern='<%# RegexRelativeImageUrlPatern %>' ClientScriptUrl="~/ClientScript/NeatHtml.js">
                            <%# DataBinder.Eval(Container.DataItem, "Comment").ToString() %>
                        </NeatHtml:UntrustedContent>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:NewsResources, JobAttachFileLabel %>">
                    <ItemTemplate>
                        <%# GetAttachFile(Convert.ToInt32(Eval("NewsID")), Eval("AttachFile1"), Eval("AttachFile2")) %>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%" UniqueName="ClientSelectColumn" />
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <portal:gbCutePager ID="pgr" runat="server" />
</asp:Content>