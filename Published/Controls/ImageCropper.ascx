<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ImageCropper.ascx.cs"
    Inherits="CanhCam.Web.UI.ImageCropper" %>
<asp:Panel ID="pnlCropped" runat="server">
    <div class="settingrow">
        <gb:SiteLabel ID="SiteLabel1" runat="server" ConfigKey="CropperCroppedImage" EnableViewState="false"
            CssClass="settinglabel" UseLabelTag="false" />
    </div>
    <div class="settingrow">
        <asp:Image ID="imgCropped" runat="server" />
    </div>
</asp:Panel>
<asp:Panel ID="pnlCrop" runat="server">
    <div class="settingrow">
        <asp:Button ID="btnCrop" runat="server" />
        <gb:SiteLabel ID="lblCroppedFileName" runat="server" ConfigKey="CropperCroppedImageFileName"
            EnableViewState="false" UseLabelTag="false" />
        <asp:TextBox ID="txtCroppedFileName" runat="server" CssClass="widetextbox" />
    </div>
    <asp:Panel ID="pnlFinalSize" runat="server" CssClass="settingrow">
        <gb:SiteLabel ID="SiteLabel2" runat="server" ConfigKey="CroppedImageWidth" EnableViewState="false"
            UseLabelTag="false" />
        <asp:TextBox ID="txtFinalWidth" runat="server" Text="0" CssClass="smalltextbox" />
        <gb:SiteLabel ID="SiteLabel3" runat="server" ConfigKey="CroppedImageHeight" EnableViewState="false"
            UseLabelTag="false" />
        <asp:TextBox ID="txtFinalHeight" runat="server" Text="0" CssClass="smalltextbox" />
        <gb:SiteLabel ID="SiteLabel4" runat="server" ConfigKey="CropperResizeInfo" EnableViewState="false"
            UseLabelTag="false" />
    </asp:Panel>
    <div class="settingrow">
        <gb:SiteLabel ID="lbl1" runat="server" ConfigKey="CropperOriginalImage" EnableViewState="false"
            CssClass="settinglabel" UseLabelTag="false" />
    </div>
    <div class="settingrow">
        <asp:Image ID="imgToCrop" runat="server" />
        <asp:HiddenField ID="X" runat="server" />
        <asp:HiddenField ID="Y" runat="server" />
        <asp:HiddenField ID="W" runat="server" />
        <asp:HiddenField ID="H" runat="server" />
    </div>
</asp:Panel>
