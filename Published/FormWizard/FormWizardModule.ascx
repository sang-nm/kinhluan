<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="FormWizardModule.ascx.cs"
    Inherits="CanhCam.FormWizard.Web.UI.FormWizardModule" %>

<asp:UpdatePanel ID="pnlFormWizard" runat="server">
    <ContentTemplate>
        <asp:Panel ID="pnlForm" CssClass="wrap-form" DefaultButton="btnSubmit" runat="server">
            <div id="divTitle" runat="server" class="form-title">
                <asp:Literal ID="litFormTitle" runat="server" />
            </div>
            <asp:Literal ID="litInstructions" runat="server" />
            <asp:Panel ID="pnlToAddresses" CssClass="form-group frm-toaddress" runat="server" Visible="false">
                <asp:Label ID="lblToAddresses" ForControl="ddToAddresses" runat="server" CssClass="label" />
                <asp:DropDownList ID="ddToAddresses" CssClass="form-control" runat="server" EnableTheming="false" />
            </asp:Panel>
            <asp:Panel ID="pnlQuestions" runat="server">
                    
            </asp:Panel>
            <div class="form-group frm-captcha" id="divCaptcha" runat="server">
                <div class="frm-captcha-input">
                    <label class="label">
                        <asp:Literal ID="litCaptcha" Text="<%$Resources:Resource, CaptchaInstructions %>"
                            EnableViewState="false" runat="server" />
                    </label>
                    <asp:TextBox ID="txtCaptcha" runat="server" MaxLength="5"></asp:TextBox>
                </div>
                <telerik:RadCaptcha ID="captcha" runat="server" ValidationGroup="formwizard" EnableRefreshImage="true" 
                    ValidatedTextBoxID="txtCaptcha" CaptchaImage-RenderImageOnly="true" Width="50%"
                    CaptchaTextBoxLabel="" ErrorMessage="<%$Resources:Resource, CaptchaFailureMessage %>" 
                    CaptchaTextBoxTitle="<%$Resources:Resource, CaptchaInstructions %>" 
                    CaptchaLinkButtonText="<%$Resources:Resource, CaptchaRefreshImage %>" />
            </div>
            <asp:UpdateProgress ID="up1" runat="server" AssociatedUpdatePanelID="pnlFormWizard">
                <ProgressTemplate>
                    <img src='<%= Page.ResolveUrl("~/Data/SiteImages/indicators/indicator1.gif") %>' alt=' ' />
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="form-group frm-btnwrap">
                <label class="label">&nbsp;</label>
                <div class="frm-btn">
                    <asp:Button CssClass="btn btn-default frm-btn-back" ID="btnPrevious" runat="server" />
                    <asp:Button CssClass="btn btn-default frm-btn-submit" ID="btnSubmit" runat="server" ValidationGroup="formwizard" />
                    <input class="btn btn-default frm-btn-reset" id="btnReset" runat="server" type="reset" />
                    <asp:HiddenField ID="hdnResponseSetGuid" runat="server" />
                </div>
            </div>
            <div class="clear"></div>
        </asp:Panel>
        <asp:Panel ID="pnlThankYou" Visible="false" CssClass="msg-frm frm-thanks" runat="server">
            <asp:Literal ID="litThankYou" runat="server" />
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>