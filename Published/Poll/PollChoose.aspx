<%@ Page ValidateRequest="false" Language="c#" MaintainScrollPositionOnPostback="true"
    CodeBehind="PollChoose.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="PollFeature.UI.PollChoose" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <div class="admin-content">
        <div class="heading">
            <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
                CurrentPageTitle="<%$Resources:FAQsResources, EditPageTitle %>" CurrentPageUrl="~/FAQs/Edit.aspx" />
            <portal:HeadingControl ID="heading" runat="server" />
        </div>
        <div class="toolbox">
            <asp:HyperLink CssClass="active" ID="lnkNewPoll" runat="server" />
            <asp:Button ID="btnRemoveCurrent" runat="server" CausesValidation="false" />
        </div>
        <portal:NotifyMessage ID="message" runat="server" />
        <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
            <MasterTableView DataKeyNames="PollGuid">
                <Columns>
                    <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                        <ItemTemplate>
                            <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources:FAQsResources, QuestionLabel %>">
                        <ItemTemplate>
                            <asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question") %>' Font-Bold="true" />
                            <portal:gbDataList ID="dlResults" runat="server" DataKeyField="OptionGuid">
                                <ItemTemplate>
                                    <asp:Label ID="lblOption" runat="server" Text='<%# GetOptionResultText(Eval("OptionGuid")) %>'></asp:Label>
                                    <br />
                                    <span id="spnResultImage" runat="server"></span>
                                </ItemTemplate>
                            </portal:gbDataList>
                            <br />
                            <asp:Label ID="lblActive" runat="server" Text='<%# GetActiveText(Eval("ActiveFrom"), Eval("ActiveTo")) %>'></asp:Label>
                            <br />
                            <asp:Button CommandName="Choose" runat="server" CssClass="buttonlink" ID="btnChoose"
                                Text='<%$ Resources:PollResources, PollChooseChooseAlternateText %>' CommandArgument='<%# Eval("PollGuid") %>' />
                            <asp:HyperLink ID="lnkEdit" runat="server" Text='<%$ Resources:PollResources, PollViewEditAlternateText %>'
                                NavigateUrl='<%# SiteRoot + "/Poll/PollEdit.aspx?PollGuid=" + Eval("PollGuid") + "&pageid=" + pageId + "&mid=" + moduleId %>'></asp:HyperLink>
                            <asp:Button ID="btnCopyToNewPoll" runat="server" CssClass="buttonlink" CommandName="Copy" CommandArgument='<%# Eval("PollGuid") %>'
                                Text='<%$ Resources:PollResources, PollViewCopyToNewPollButton %>' ToolTip='<%$ Resources:PollResources, PollViewCopyToNewPollToolTip %>' />
                            <hr />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <%--
                    <telerik:GridTemplateColumn HeaderText="<%$Resources:FAQsResources, AnswerLabel %>">
                        <ItemTemplate>
                            <%# CanhCam.Web.Framework.UIHelper.CreateExcerpt(Eval("Answer").ToString(), 255, "...")%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources:FAQsResources, PositionLabel %>" AllowFiltering="false" >
                        <ItemTemplate>
                            <asp:CheckBoxList ID="chkListPosition" runat="server" DataTextField="Name" DataValueField="Value" SkinID="Enum" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:FAQsResources, DisplayOrderLabel %>" AllowFiltering="false" >
                        <ItemTemplate>
                            <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" MaxLength="4" Text='<%# Eval("DisplayOrder") %>'
                                runat="server" />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderStyle-Width="100" AllowFiltering="false" >
                        <ItemTemplate>
                            <asp:HyperLink CssClass="cp-link" ID="EditLink" runat="server" Text="<%# Resources.FAQsResources.EditLink %>" 
                                NavigateUrl='<%# this.SiteRoot + "/FAQs/Edit.aspx?ItemID=" + DataBinder.Eval(Container.DataItem,"ItemID") %>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>--%>
                    <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <portal:gbDataList ID="dlPolls" runat="server" DataKeyField="PollGuid">
            <ItemTemplate>
                <asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question") %>' Font-Bold="true" />
                <portal:gbDataList ID="dlResults" runat="server" DataKeyField="OptionGuid">
                    <ItemTemplate>
                        <asp:Label ID="lblOption" runat="server" Text='<%# GetOptionResultText(Eval("OptionGuid")) %>'></asp:Label>
                        <br />
                        <span id="spnResultImage" runat="server"></span>
                    </ItemTemplate>
                </portal:gbDataList>
                <br />
                <asp:Label ID="lblActive" runat="server" Text='<%# GetActiveText(Eval("ActiveFrom"), Eval("ActiveTo")) %>'></asp:Label>
                <br />
                <asp:Button CommandName="Choose" runat="server" CssClass="buttonlink" ID="btnChoose"
                    Text='<%$ Resources:PollResources, PollChooseChooseAlternateText %>' CommandArgument='<%# Eval("PollGuid") %>' />
                <asp:HyperLink ID="lnkEdit" runat="server" Text='<%$ Resources:PollResources, PollViewEditAlternateText %>'
                    NavigateUrl='<%# SiteRoot + "/Poll/PollEdit.aspx?PollGuid=" + Eval("PollGuid") + "&pageid=" + pageId + "&mid=" + moduleId %>'></asp:HyperLink>
                <asp:Button ID="btnCopyToNewPoll" runat="server" CssClass="buttonlink" CommandName="Copy" CommandArgument='<%# Eval("PollGuid") %>'
                    Text='<%$ Resources:PollResources, PollViewCopyToNewPollButton %>' ToolTip='<%$ Resources:PollResources, PollViewCopyToNewPollToolTip %>' />
                <hr />
            </ItemTemplate>
        </portal:gbDataList>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
