<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="CommentEditor.ascx.cs" Inherits="CanhCam.Web.UI.CommentEditor" %>

<asp:Panel ID="pnlNewComment" runat="server" CssClass="blogcommentservice commenteditpanel">
    <fieldset>
    <legend>
        <gb:SiteLabel ID="lblFeedback" runat="server" ConfigKey="NewComment" ResourceFile="Resource" EnableViewState="false" />
    </legend>
    <div id="divTitle" runat="server" class="settingrow">
        <gb:SiteLabel ID="lblCommentTitle" runat="server" ForControl="txtCommentTitle" CssClass="settinglabel"
            ConfigKey="CommentTitle" ResourceFile="Resource" EnableViewState="false" />
        
        <asp:TextBox ID="txtCommentTitle" runat="server" MaxLength="100" EnableViewState="true" CssClass="forminput widetextbox" />
    </div>
    <div class="settingrow">
        <gb:SiteLabel ID="SiteLabel1" runat="server" ForControl="txtEmail" CssClass="settinglabel"
            ConfigKey="ManageUsersEmailLabel" ResourceFile="Resource" EnableViewState="false" />
        <asp:TextBox ID="txtEmail" runat="server" MaxLength="100" EnableViewState="true" CssClass="forminput widetextbox" />
        <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtEmail" ValidationGroup="comments" Display="Dynamic" EnableClientScript="true" />
        <asp:RequiredFieldValidator ID="reqEmail" runat="server" ValidationGroup="comments" ControlToValidate="txtEmail" Display="Dynamic" EnableClientScript="true" />
    </div>
    <div class="settingrow">
        <gb:SiteLabel ID="lblCommentUserName" runat="server" ForControl="txtName" CssClass="settinglabel"
            ConfigKey="CommentUserName" ResourceFile="Resource" EnableViewState="false" />
        <asp:TextBox ID="txtName" runat="server" MaxLength="100" EnableViewState="true" CssClass="forminput widetextbox" />
        <asp:RequiredFieldValidator ID="reqName" runat="server" ValidationGroup="comments" ControlToValidate="txtName" Display="Dynamic" EnableClientScript="true" />
    </div>
    <div id="divCommentUrl" runat="server" class="settingrow">
        <gb:SiteLabel ID="lblCommentURL" runat="server" ForControl="txtURL" CssClass="settinglabel"
            ConfigKey="CommentUrl" ResourceFile="Resource" EnableViewState="false" />
        <asp:TextBox ID="txtURL" runat="server" MaxLength="200" EnableViewState="true" CssClass="forminput widetextbox" />
        <asp:RegularExpressionValidator ID="regexUrl" runat="server" ControlToValidate="txtURL"
            ValidationGroup="comments" ValidationExpression="(((http(s?))\://){1}\S+)" />
    </div>
    <asp:Panel ID="pnlRemeberMe" runat="server" CssClass="settingrow">
        <gb:SiteLabel ID="lblRememberMe" runat="server" ForControl="chkRememberMe" CssClass="settinglabel"
            ConfigKey="SignInSendRememberMeLabel" ResourceFile="Resource" EnableViewState="false" />
        <asp:CheckBox ID="chkRememberMe" runat="server" EnableViewState="false" CssClass="forminput" />
    </asp:Panel>
    <div class="settingrow">
        <gbe:EditorControl ID="edComment" runat="server"></gbe:EditorControl>
    </div>
    <asp:Panel ID="pnlAntiSpam" runat="server">
        <gb:CaptchaControl ID="captcha" runat="server" />
    </asp:Panel>
    <div class="settingrow">
        <asp:Button SkinID="DefaultButton" ID="btnPostComment" runat="server" Text="Submit" ValidationGroup="comments" />
    </div>
    </fieldset>   
</asp:Panel>
