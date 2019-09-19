<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="MessageListDialog.aspx.cs" Inherits="CanhCam.Web.ContactUI.MessageListDialog" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <script type="text/javascript">
        function GetMessage(messageGuid, context)
         {
            <%= sCallBackFunctionInvocation %>
         }
         function ShowMessage(message, context) 
         {
            document.getElementById('<%= pnlMessage.ClientID %>').innerHTML = message;
         }
         function OnError(message, context) {
            //alert('An unhandled exception has occurred:\n' + message);
         }
    </script>
    <portal:NotifyMessage ID="message" runat="server" />
    <asp:Panel ID="pnlContainer" runat="server" CssClass="ui-layout-container">
        <asp:Panel ID="pnlLeft" runat="server" CssClass="ui-layout-west">
            <div class="wrap01">
                <asp:HyperLink SkinID="LinkButton" ID="lnkRefresh" runat="server" />
                <asp:Button SkinID="DefaultButton" ID="btnDelete" Text="<%$Resources:ContactFormResources, ContactFormDeleteButton %>" runat="server" CausesValidation="false" />
            </div>
            <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="RowGuid,Email" AllowPaging="false">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" HeaderText="<%$Resources:ContactFormResources, ContactFormMessageListFromHeader %>">
                            <ItemTemplate>
                                <%# Server.HtmlEncode(Eval("Url").ToString()) %><br />
                                <a href='mailto:<%# Eval("Email") %>'>
                                    <%# Eval("Email") %></a><br />
                                <%# Server.HtmlEncode(Eval("Subject").ToString()) %><br />
                                <%# FormatDate(Convert.ToDateTime(Eval("CreatedUtc")))%><br />
                                <asp:Button ID="btnView" SkinID="DefaultButton" runat="server" Text='<%# Resources.ContactFormResources.ContactFormViewButton %>'
                                    CommandArgument='<%# Eval("RowGuid") %>' CommandName="view" OnClientClick='<%# GetViewOnClick(Eval("RowGuid").ToString()) %>' />
                                <%--<asp:Button SkinID="DeleteButton" ID="btnDelete" SkinID="DefaultButton" runat="server" Text='<%# Resources.ContactFormResources.ContactFormDeleteButton %>'
                                    CommandArgument='<%# Eval("RowGuid") %>' CommandName="remove" OnClientClick='<%# GetDeleteOnClick(Eval("RowGuid").ToString()) %>' />--%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridClientSelectColumn ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5%"
                            UniqueName="ClientSelectColumn" />
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
            <portal:gbCutePager ID="pgrContactFormMessage" runat="server" />
        </asp:Panel>
        <asp:Panel ID="pnlCenter" runat="server" CssClass="ui-layout-westcenter">
            <asp:Literal ID="litMessage" runat="server" />
            <asp:Panel ID="pnlMessage" runat="server" CssClass="contactmessage">
            </asp:Panel>
            <br class="clear" />
        </asp:Panel>
    </asp:Panel>
</asp:Content>
