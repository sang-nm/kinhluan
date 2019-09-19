<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="closed.aspx.cs" Inherits="CanhCam.Web.UI.Pages.ClosedPage" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    <style type="text/css">
	    body { color: #444444; background-color: #E5F2FF; font-family: verdana; margin: 0px; }
	    #PageOutline { text-align: center; margin-top: 300px; }
	    A { color: #0153A4; }
	    h1 { font-size: 16pt; margin-bottom: 4px; }
	    div.closedmessage { font-size: 14pt; margin-bottom: 4px; font-weight: normal; }
    </style>
</head>
<body class="closedpage">
    <div id="PageOutline">
	    <h1><asp:Literal ID="litSiteClosedTitle" runat="server" /></h1>
        <div class="closedmessage">
            <asp:Literal ID="litSiteClosedMessage" runat="server" />
        </div>
    </div>
</body>
</html>