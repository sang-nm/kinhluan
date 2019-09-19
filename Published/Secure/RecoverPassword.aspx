<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="RecoverPassword.aspx.cs" Inherits="CanhCam.Web.UI.Pages.RecoverPassword" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">

<div class="admin-content col-md-12">
    <div class="wrap-secure wrap-recover">
        <div class="panel panel-primary">
            <div class="panel-heading"><portal:HeadingControl ID="headingControl" Text="<%$Resources:Resource, SignInSendPasswordButton %>" runat="server" /></div>
            <div class="form-horizontal pd20">
                <asp:PasswordRecovery ID="PasswordRecovery1" runat="server">
                    <UserNameTemplate>
                        <asp:Panel ID="pnlRecover" runat="server" DefaultButton="SubmitButton">
                            <div class="form-group">
                                <asp:Label ID="lblEnterUserName" CssClass="settinglabel control-label col-sm-3" AssociatedControlID="UserName" runat="server" />
                                <div class="col-sm-9">
                                    <asp:TextBox ID="UserName" runat="server" MaxLength="100" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" SetFocusOnError="true" ControlToValidate="UserName"
                                        Display="Dynamic" ValidationGroup="PasswordRecovery1"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <asp:Panel class="captcha" id="divCaptcha" runat="server">
                                        <telerik:RadCaptcha ID="captcha" runat="server" ValidationGroup="PasswordRecovery1" EnableRefreshImage="true" 
                                            CaptchaTextBoxCssClass="form-control" CaptchaTextBoxLabel="" ErrorMessage="<%$Resources:Resource, CaptchaFailureMessage %>" 
                                            CaptchaTextBoxTitle="<%$Resources:Resource, CaptchaInstructions %>" 
                                            CaptchaLinkButtonText="<%$Resources:Resource, CaptchaRefreshImage %>" />
                                    </asp:Panel>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <asp:Button SkinID="DefaultButton" CssClass="btn btn-default btn-block" ID="SubmitButton" runat="server" CommandName="Submit" ValidationGroup="PasswordRecovery1" />
                                </div>
                            </div>
                            <portal:gbLabel ID="FailureText" CssClass="alert alert-danger" runat="server" />
                        </asp:Panel>
                    </UserNameTemplate>
                    <QuestionTemplate>
                        <asp:Panel ID="pnlRecover2" runat="server" DefaultButton="SubmitButton">
                            <div class="mrb10">
                                <gb:SiteLabel ID="sitelabel4" runat="server" ConfigKey="HelloLabel" UseLabelTag="false" />
                                <asp:Literal ID="UserName" runat="server" />
                            </div>
                            <div class="mrb10">
                                <gb:SiteLabel ID="sitelabel5" runat="server" ConfigKey="PasswordQuestionLabel" />
                                <br />
                                <strong><asp:Literal ID="Question" runat="server" /></strong>
                            </div>
                            <div class="mrb10">
                                <asp:TextBox ID="Answer" runat="server" CssClass="verywidetextbox" />
                                <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer"
                                    Display="Dynamic" ValidationGroup="PasswordRecovery1"></asp:RequiredFieldValidator>
                                <br />
                                <asp:Button SkinID="DefaultButton" ID="SubmitButton" runat="server" CommandName="Submit" ValidationGroup="PasswordRecovery1" />
                            </div>
                            <portal:gbLabel ID="FailureText" runat="server" CssClass="alert alert-danger" />
                        </asp:Panel>
                    </QuestionTemplate>
                    <SuccessTemplate>
                        <gb:SiteLabel ID="successLabel" runat="server" CssClass="alert alert-success" ConfigKey="PasswordRecoverySuccessMessage" />
                        <portal:gbLabel ID="EmailLabel" runat="server" CssClass="alert alert-success" />
                    </SuccessTemplate>
                </asp:PasswordRecovery>
                <portal:gbLabel ID="lblMailError" runat="server" CssClass="alert alert-danger" />
            </div>

        </div>
    </div>
</div>

</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
