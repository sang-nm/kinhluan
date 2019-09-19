<%@ Page ValidateRequest="false" Language="c#" CodeBehind="FormQuestionEdit.aspx.cs"
    MasterPageFile="~/App_MasterPages/DialogMaster.Master" AutoEventWireup="false"
    Inherits="CanhCam.FormWizard.Web.UI.FormQuestionEdit" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="form-horizontal">
        <div class="settingrow form-group">
            <div class="col-sm-9 col-sm-offset-3">
                <div class="input-group">
                    <asp:DropDownList ID="ddQuestions" AutoPostBack="true" Width="250" runat="server" />
                    <div class="input-group-btn">
                        <asp:Button SkinID="DefaultButton" ID="btnSave" runat="server" />
                    </div>
                    <div class="input-group-btn">
                        <asp:Button SkinID="DefaultButton" ID="btnClose" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="up" runat="server">
            <ContentTemplate>
                <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                    EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                    CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                <div id="divQuestionText" class="settingrow form-group" runat="server">
                    <gb:SiteLabel ID="lblQuestionText" runat="server" ConfigKey="QuestionTextLabel" ForControl="txtQuestionText"
                        ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtQuestionText" CssClass="widetextbox" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div id="divQuestionAlias" runat="server" class="settingrow form-group">
                    <gb:SiteLabel ID="lblQuestionAlias" runat="server" ConfigKey="QuestionAliasLabel" ForControl="txtQuestionAlias"
                        ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtQuestionAlias" CssClass="widetextbox" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div id="divInvalidText" visible="false" runat="server" class="settingrow form-group">
                    <gb:SiteLabel ID="lblInvalidText" runat="server" ConfigKey="InvalidRegexTextLabel" ForControl="txtInvalidText"
                        ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtInvalidText" MaxLength="255" CssClass="verywidetextbox" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div id="divInstructions" runat="server" class="settingrow form-group">
                    <gbe:EditorControl ID="edInstructions" runat="server" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>