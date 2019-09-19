<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="AvatarUploadDialog.aspx.cs"
    Inherits="CanhCam.Web.Dialog.AvatarUploadDialog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <portal:StyleSheetCombiner ID="StyleSheetCombiner" runat="server" IncludejCrop="true" />
    <portal:ScriptLoader ID="ScriptInclude" runat="server" IncludeJQuery="true" IncludeJQueryMigrate="true" />
</head>
<body class="dialogpage">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" EnablePageMethods="true" runat="server" />
        <portal:ImageCropper ID="cropper" runat="server" />
        <asp:Label ID="lblMaxAvatarSize" runat="server" />
        <div class="mrb10">
            <telerik:RadAsyncUpload ID="uplFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Disabled"
                runat="server" />
            <asp:Button ID="btnUploadAvatar" CssClass="btn btn-default" runat="server" Text="Upload" />
        </div>
    </form>
</body>
</html>