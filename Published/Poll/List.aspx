<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="List.aspx.cs" Inherits="CanhCam.Web.PollUI.PollList" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:PollResources, PollListTitle %>" CurrentPageUrl="~/Poll/List.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" runat="server" />
            <asp:HyperLink SkinID="InsertButton" ID="lnkInsert" Text="<%$Resources:Resource, InsertLink %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:Resource, DeleteSelectedButton %>" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />        
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="PollGuid,DisplayOrder" AllowSorting="false" AllowFilteringByColumn="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:PollResources, PollEditQuestionLabel %>">
                            <ItemTemplate>
                                <asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question") %>' Font-Bold="true" />
                                <div class="wrap01 prefix_2">
                                    <asp:Repeater ID="rptResults" runat="server" >
                                        <ItemTemplate>
                                            <div>
                                                <asp:Label ID="lblOption" runat="server" Text='<%# GetOptionResultText(Eval("OptionGuid")) %>'></asp:Label>
                                                <br />
                                                <span id="spnResultImage" runat="server"></span>
                                                <asp:HiddenField ID="hdnID" runat="server" Value='<%# Eval("OptionGuid")%>' />
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <asp:Label ID="lblActive" runat="server" Text='<%# GetActiveText(Eval("ActiveFrom"), Eval("ActiveTo")) %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-Width="100" HeaderText="<%$Resources:FAQsResources, DisplayOrderLabel %>" AllowFiltering="false" >
                            <ItemTemplate>
                                <asp:TextBox ID="txtDisplayOrder" SkinID="NumericTextBox" MaxLength="4" Text='<%# Eval("DisplayOrder") %>'
                                    runat="server" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="Edit">
                            <ItemTemplate>
                                <asp:Button CommandName="Choose" runat="server" SkinID="DefaultButton" ID="btnChoose"
                                    Text='<%$ Resources:PollResources, PollChooseChooseAlternateText %>' CommandArgument='<%# Eval("PollGuid") %>' />
                                <asp:Button ID="btnCopyToNewPoll" runat="server" SkinID="DefaultButton" CommandName="Copy" CommandArgument='<%# Eval("PollGuid") %>'
                                    Text='<%$ Resources:PollResources, PollViewCopyToNewPollButton %>' ToolTip='<%$ Resources:PollResources, PollViewCopyToNewPollToolTip %>' />
                                <asp:HyperLink ID="lnkEdit" CssClass="cp-link" runat="server" Text='<%$ Resources:PollResources, PollViewEditAlternateText %>'
                                    NavigateUrl='<%# this.SiteRoot + "/Poll/Edit.aspx?PollGuid=" + Eval("PollGuid") %>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</asp:Content>