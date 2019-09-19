<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="MessageList.aspx.cs" Inherits="CanhCam.Web.ContactUI.MessageListPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:ContactFormResources, ContactFormViewMessagesLink %>" CurrentPageUrl="~/ContactForm/MessageList.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="ExportButton" ID="btnExport" Visible="false" Text="<%$Resources:Resource, ExportDataAsExcel %>" runat="server" CausesValidation="false" />
            <asp:Button SkinID="DefaultButton" ID="btnDelete" Text="<%$Resources:Resource, DeleteSelectedButton %>" runat="server" CausesValidation="false" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <div class="workplace">
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="RowGuid,Email">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:ContactFormResources, ContactFormMessageListFromHeader %>">
                            <ItemTemplate>
                                <%# Server.HtmlEncode(Eval("FullName").ToString()) %>
                                <div><a href='mailto:<%# Eval("Email") %>'><%# Eval("Email") %></a></div>
                                <%# FormatDate(Convert.ToDateTime(Eval("CreatedUtc")))%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:ContactFormResources, ContactFormMessageLabel %>">
                            <ItemTemplate>
                                <%# SecurityHelper.SanitizeHtml(Eval("Message").ToString())%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn ItemStyle-Width="5%" UniqueName="ClientSelectColumn" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
</asp:Content>