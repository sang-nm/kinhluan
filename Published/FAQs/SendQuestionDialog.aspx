<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="SendQuestionDialog.aspx.cs" Inherits="CanhCam.Web.FAQsUI.SendQuestionDialog" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="email-subject row">
            <asp:Panel ID="pnlSend" runat="server" SkinID="plain" DefaultButton="btnSend">
                <div class="col-left">
                    <div class="form-group faq-name">
                        <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" ConfigKey="SendQuestionYourNameLabel"
                            ResourceFile="FAQsResources" CssClass="label" />
                        <asp:TextBox ID="txtName" placeholder="<%$Resources:FAQsResources,SendQuestionYourNameLabel %>" CssClass="form-control" runat="server" MaxLength="100" />
                    </div>
                    <div class="form-group faq-email">
                        <gb:SiteLabel ID="lblEmail" runat="server" ForControl="txtEmail" ShowRequired="true" ConfigKey="SendQuestionYourEmailLabel"
                            ResourceFile="FAQsResources" CssClass="label" />
                        <asp:TextBox ID="txtEmail" placeholder="<%$Resources:FAQsResources,SendQuestionYourEmailLabel %>" CssClass="form-control" runat="server" MaxLength="255" />
                        <asp:RequiredFieldValidator ID="reqEmail" ValidationGroup="SendQuestion" runat="server"
                            CssClass="txterror" Display="Dynamic" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="regexEmail" runat="server" Display="Dynamic" ValidationGroup="SendQuestion"
                            ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group faq-subject">
                        <gb:SiteLabel ID="lblSubject" runat="server" ForControl="txtSubject" ConfigKey="SendQuestionSubjectLabel"
                            ResourceFile="FAQsResources" CssClass="label" />
                        <asp:TextBox ID="txtSubject" placeholder="<%$Resources:FAQsResources,SendQuestionSubjectLabel %>" CssClass="form-control" runat="server" MaxLength="255" />
                    </div>
                </div>
                <div class="col-right">
                    <div class="form-group faq-message">
                        <gb:SiteLabel ID="lblMessageLabel" runat="server" ForControl="txtMessage" ConfigKey="SendQuestionMessageLabel"
                            ResourceFile="FAQsResources" CssClass="label" />
                        <asp:TextBox ID="txtMessage" placeholder="<%$Resources:FAQsResources,SendQuestionMessageLabel %>" CssClass="form-control" TextMode="MultiLine" runat="server" />
                        <asp:RequiredFieldValidator ID="reqMessage" ValidationGroup="SendQuestion" runat="server"
                            CssClass="txterror" Display="Dynamic" ControlToValidate="txtMessage"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="form-group faq-button">
                    <label class="label">&nbsp;</label>
                    <div class="frm-btn">
                        <asp:Button ID="btnSend" CssClass="btn btn-default" runat="server" ValidationGroup="SendQuestion"
                            Text="<%$Resources:FAQsResources, SendQuestionSendButton %>" CausesValidation="true" />
                    </div>
                </div>
            </asp:Panel>
            <portal:gbLabel ID="lblMessage" runat="server" CssClass="alert alert-success" />
        </div>
    </div>
</asp:Content>