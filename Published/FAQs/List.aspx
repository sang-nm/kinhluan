<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="List.aspx.cs" Inherits="CanhCam.Web.FAQsUI.FAQsList" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:FAQsResources, FAQsListHeading %>" CurrentPageUrl="~/FAQs/List.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" runat="server" />
            <asp:HyperLink SkinID="InsertButton" ID="lnkInsert" Text="<%$Resources:FAQsResources, InsertLink %>" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:FAQsResources, DeleteSelectedButton %>" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="headInfo form-horizontal">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel"
                    ForControl="ddZones" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddZones" AutoPostBack="true" runat="server" />
                </div>
            </div>
        </div>
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="ItemID,DisplayOrder,Position" AllowSorting="false" AllowFilteringByColumn="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-Width="35" HeaderText="<%$Resources:Resource, RowNumber %>" AllowFiltering="false">
                            <ItemTemplate>
                                <%# (grid.PageSize * grid.CurrentPageIndex) + Container.ItemIndex + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="<%$Resources:FAQsResources, QuestionLabel %>">
                            <ItemTemplate>
                                <%# CanhCam.Web.Framework.UIHelper.CreateExcerpt(Eval("Question").ToString(), 100, "...")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
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
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
