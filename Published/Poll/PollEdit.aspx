<%@ Page ValidateRequest="false" Language="c#" MaintainScrollPositionOnPostback="true"
    Codebehind="PollEdit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="PollFeature.UI.PollEdit" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <div class="admin-content">
        <div class="heading">
            <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
                CurrentPageTitle="<%$Resources:FAQsResources, EditPageTitle %>" CurrentPageUrl="~/FAQs/Edit.aspx" />
            <portal:HeadingControl ID="heading" runat="server" />
        </div>
        <div class="toolbox">
            <asp:Button ID="btnSave" CssClass="active" runat="server" />
            <asp:Button ID="btnDelete" runat="server" CausesValidation="false" />
            <asp:Button ID="btnActivateDeactivate" runat="server" CausesValidation="False" Visible="false" />
        </div>
        <portal:NotifyMessage ID="message" runat="server" />
        <asp:Panel ID="pnlPoll" runat="server" DefaultButton="btnSave">
            <div class="pollwrap">
                <asp:Button ID="btnAddNewPoll" runat="server" CssClass="form-button" CausesValidation="false" />
                <asp:Button ID="btnViewPolls" runat="server" CssClass="form-button" CausesValidation="false" />
                <div class="settingrow">
                    <gb:SiteLabel ID="lblQuestion" runat="server" ForControl="txtQuestion" CssClass="settinglabel"
                        ConfigKey="PollEditQuestionLabel" ResourceFile="PollResources" />
                    <asp:TextBox ID="txtQuestion" runat="server" CssClass="forminput verywidetextbox"  MaxLength="255"></asp:TextBox>
                </div>
                <div class="settingrow">
                    <gb:SiteLabel ID="lblAnonymousVoting" runat="server" ForControl="chkAnonymousVoting"
                        CssClass="settinglabel" ConfigKey="PollEditAnonymousVotingLabel" ResourceFile="PollResources">
                    </gb:SiteLabel>
                    <asp:CheckBox ID="chkAnonymousVoting" runat="server"></asp:CheckBox>
                </div>
                <div class="settingrow">
                    <gb:SiteLabel ID="lblAllowViewingResultsBeforeVoting" runat="server" ForControl="chkAllowViewingResultsBeforeVoting"
                        CssClass="settinglabel" ConfigKey="PollEditAllowViewingResultsBeforeVotingLabel"
                        ResourceFile="PollResources" />
                    <asp:CheckBox ID="chkAllowViewingResultsBeforeVoting" runat="server"></asp:CheckBox>
                </div>
                <div class="settingrow">
                    <gb:SiteLabel ID="lblShowOrderNumbers" runat="server" ForControl="chkShowOrderNumbers"
                        CssClass="settinglabel" ConfigKey="PollEditShowOrderNumbersLabel" ResourceFile="PollResources">
                    </gb:SiteLabel>
                    <asp:CheckBox ID="chkShowOrderNumbers" runat="server"></asp:CheckBox>
                </div>
                <div class="settingrow">
                    <gb:SiteLabel ID="lblShowResultsWhenDeactivated" runat="server" ForControl="chkShowResultsWhenDeactivated"
                        CssClass="settinglabel" ConfigKey="PollEditShowResultsWhenDeactivatedLabel" ResourceFile="PollResources">
                    </gb:SiteLabel>
                    <asp:CheckBox ID="chkShowResultsWhenDeactivated" runat="server"></asp:CheckBox>
                </div>
                <div class="settingrow">
                    <gb:SiteLabel ID="lblPollAddOptions" runat="server" ForControl="tblOptions" CssClass="settinglabel"
                        ConfigKey="PollEditOptionsLabel" ResourceFile="PollResources" />
                    <div class="left suffix_2" style="width: 22%;">
                        <asp:ListBox ID="lbOptions" Width="100%" DataTextField="Answer" DataValueField="OptionGuid"
                            Rows="10" runat="server" />
                    </div>
                    <div class="left" style="width: 2%">
                        <asp:ImageButton ID="btnUp" CommandName="up" runat="server" CausesValidation="False" />
                        <br />
                        <asp:ImageButton ID="btnDown" CommandName="down" runat="server" CausesValidation="False" />
                        <br />
                        <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" />
                        <br />
                        <asp:ImageButton ID="btnDeleteOption" runat="server" CausesValidation="False" />
                        <br />
                        <br />
                        <portal:gbHelpLink ID="MojoHelpLink1" runat="server" HelpKey="addeditpolloptionshelp" />
                    </div>
                    <div class="left" style="width: 74%">
                        <%--<telerik:RadTabStrip ID="tabAttributeLanguage" OnTabClick="tabAttributeLanguage_TabClick" 
                            EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                            CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />--%>
                        <asp:TextBox ID="txtNewOption" runat="server" Columns="39" MaxLength="100"></asp:TextBox>
                        <asp:Button ID="btnAddOption" runat="server" CssClass="form-button" CausesValidation="False" />
                    </div>
                    <div class="clear"></div>
                </div>
                <br />
                <div class="settingrow">
                    <gb:SiteLabel ID="lblActiveFromTo" runat="server" CssClass="settinglabel" ConfigKey="PollEditActiveFromToLabel"
                        ResourceFile="PollResources" />
                    <gb:DatePickerControl ID="dpActiveFrom" runat="server" ShowTime="True" CssClass="forminput" SkinID="Poll" />
                    <gb:SiteLabel ID="lblTo" runat="server" ResourceFile="PollResources" ConfigKey="PollEditToLabel" />
                    <gb:DatePickerControl ID="dpActiveTo" runat="server" ShowTime="True" CssClass="forminput" SkinID="Poll" />
                </div>
                <div class="settingrow" id="divStartDeactivated" runat="server" visible="false">
                    <gb:SiteLabel ID="lblStartDeactivated" runat="server" ForControl="chkStartDeactivated"
                        CssClass="settinglabel" ConfigKey="PollEditStartDeactivatedLabel" ResourceFile="PollResources">
                    </gb:SiteLabel>
                    <asp:CheckBox ID="chkStartDeactivated" runat="server" />
                </div>
                <div class="settingrow">
                    <asp:RequiredFieldValidator ID="reqQuestion" runat="server" ControlToValidate="txtQuestion"
                        Display="None" CssClass="txterror" ValidationGroup="poll"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvOptionsLessThanTwo" runat="server" Display="None" CssClass="txterror" ValidationGroup="poll"></asp:CustomValidator>
                    <asp:ValidationSummary ID="vSummary" runat="server" CssClass="txterror" ValidationGroup="poll"></asp:ValidationSummary>
                </div>
            </div>
        </asp:Panel>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
