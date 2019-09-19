<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="Help.aspx.cs" Inherits="CanhCam.Web.UI.Pages.Help" %>

<!DOCTYPE html>
<html>
    <head id="Head1" runat="server">
        <title>Help Page</title>
    </head>
    <body class="dialogpage help-page">
        <form id="form1" runat="server">
            <asp:Panel ID="pnlHelp" runat="server">
                <asp:Literal ID="litEditLink" runat="server" />
                <asp:Literal ID="litHelp" runat="server" />
            </asp:Panel>
        </form>
    </body>
</html>