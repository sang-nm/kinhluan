<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="EmailSubjectDialog.aspx.cs" Inherits="CanhCam.Web.NewsUI.EmailSubjectDialog" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="email-subject row">
            <asp:Panel ID="pnlSend" runat="server" SkinID="plain" DefaultButton="btnSend">
                <div class="form-group">
                    <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" ConfigKey="EmailSubjectYourNameLabel"
                        ResourceFile="NewsResources" CssClass="label" />
                    <asp:TextBox ID="txtName" CssClass="form-control" runat="server" MaxLength="100" />
                </div>
                <div class="form-group">
                    <gb:SiteLabel ID="lblEmail" runat="server" ForControl="txtEmail" ConfigKey="EmailSubjectYourEmailLabel"
                        ResourceFile="NewsResources" CssClass="label" />
                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" MaxLength="255" />
                    <asp:RequiredFieldValidator ID="reqEmail" ValidationGroup="EmailSubject" runat="server"
                        Display="Dynamic" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regexEmail" runat="server" Display="Dynamic" ValidationGroup="EmailSubject"
                        ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <gb:SiteLabel ID="lblTo" runat="server" ForControl="txtTo" ConfigKey="EmailSubjectToEmailLabel"
                        ResourceFile="NewsResources" CssClass="label" />
                    <asp:TextBox ID="txtToEmail" CssClass="form-control" runat="server" MaxLength="255" />
                    <asp:RequiredFieldValidator ID="reqToEmail" ValidationGroup="EmailSubject" runat="server"
                        Display="Dynamic" ControlToValidate="txtToEmail"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regexToEmail" runat="server" Display="Dynamic" ValidationGroup="EmailSubject"
                        ControlToValidate="txtToEmail" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <gb:SiteLabel ID="lblSubject" runat="server" ForControl="txtSubject" ConfigKey="EmailSubjectLabel"
                        ResourceFile="NewsResources" CssClass="label" />
                    <asp:TextBox ID="txtSubject" CssClass="form-control" runat="server" MaxLength="255" />
                </div>
                <div class="form-group">
                    <gb:SiteLabel ID="lblMessageLabel" runat="server" ForControl="txtMessage" ConfigKey="EmailSubjectMessageLabel"
                        ResourceFile="NewsResources" CssClass="label" />
                    <asp:TextBox ID="txtMessage" CssClass="form-control" TextMode="MultiLine" runat="server" />
                </div>
                <div class="form-group">
                    <label class="label">&nbsp;</label>
                    <div class="frm-btn">
                        <asp:Button ID="btnSend" CssClass="btn btn-default" runat="server" ValidationGroup="EmailSubject"
                            Text="<%$Resources:NewsResources, EmailSubjectSendButton %>" CausesValidation="true" />
                    </div>
                </div>
            </asp:Panel>
            <portal:gbLabel ID="lblMessage" runat="server" CssClass="alert alert-success" />
        </div>
    </div>
</asp:Content>