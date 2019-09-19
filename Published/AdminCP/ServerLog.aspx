<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ServerLog.aspx.cs" Inherits="CanhCam.Web.AdminUI.ServerLog" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" CurrentPageTitle="<%$Resources:Resource, AdminMenuServerLogLabel %>"
        CurrentPageUrl="~/AdminCP/ServerLog.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:HyperLink SkinID="DefaultButton" ID="lnkRefresh" runat="server" />
            <asp:Button SkinID="DefaultButton" ID="btnDownloadLog" runat="server" />
            <asp:Button SkinID="DeleteButton" ID="btnClearLog" runat="server" />
        </portal:HeadingPanel>
        <div class="workplace">
            <asp:Panel ID="pnlDbLog" runat="server">
                <asp:Repeater ID="rptSystemLog" runat="server">
                    <HeaderTemplate>
                        <ul class="simplelist errorlog">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li class="logitem">
                            <h2 class="logitem <%# Eval("LogLevel") %>">
                                <asp:LinkButton CommandName="deleteitem" CommandArgument='<%# Eval("ID") %>'
                                    ToolTip="<%# Resources.Resource.DeleteButton %>" runat="server" ID="btnDeleteItem"><i class="fa fa-trash-o"></i></asp:LinkButton>
                                <%# FormatDate(Convert.ToDateTime(Eval("LogDate"))) %>
                                <%# Eval("LogLevel") %>
                                <%# Eval("Logger") %>
                                <%# FormatIpAddress(Eval("IpAddress").ToString()) %>
                                <%# Eval("Culture") %>
                                <%# Server.HtmlEncode(Eval("ShortUrl").ToString()) %>
                            </h2>
                            <p class="logmessage">
                                <%# Server.HtmlEncode(Eval("Message").ToString()) %>
                            </p>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul>
                    </FooterTemplate>
                </asp:Repeater>
                <portal:gbCutePager ID="pgr" runat="server" />
                <asp:HyperLink ID="lnkRefresh2" runat="server" />
                <asp:Button SkinID="DefaultButton" ID="btnClearDbLOg" runat="server" />
            </asp:Panel>
            <asp:Panel ID="pnlFileLog" runat="server">
                <asp:TextBox ID="txtLog" runat="server" Width="100%" Height="300" TextMode="MultiLine"></asp:TextBox>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
