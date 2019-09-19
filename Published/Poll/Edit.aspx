<%@ Page Language="c#" CodeBehind="Edit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.PollUI.PollEdit" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:PollResources, PollEditTitle %>" CurrentPageUrl="~/Poll/Edit.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="up" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" ValidationGroup="poll" Text="<%$Resources:Resource, UpdateButton %>" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndNew" ValidationGroup="poll" Text="<%$Resources:Resource, UpdateAndNewButton %>" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" ValidationGroup="poll" Text="<%$Resources:Resource, UpdateAndCloseButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsert" ValidationGroup="poll" Text="<%$Resources:Resource, InsertButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndNew" ValidationGroup="poll" Text="<%$Resources:Resource, InsertAndNewButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndClose" ValidationGroup="poll" Text="<%$Resources:Resource, InsertAndCloseButton %>" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, DeleteButton %>" CausesValidation="false" />
                    <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
                <div class="workplace form-horizontal">
                    <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                        EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                        CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblQuestion" runat="server" ForControl="txtQuestion" CssClass="settinglabel control-label col-sm-3"
                            ConfigKey="PollEditQuestionLabel" ResourceFile="PollResources" />
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtQuestion" runat="server" CssClass="forminput verywidetextbox"  MaxLength="255" />
                            <asp:RequiredFieldValidator ID="reqQuestion" runat="server" ControlToValidate="txtQuestion"
                                Display="Dynamic" ValidationGroup="poll"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div id="divAnonymousVoting" runat="server" class="settingrow form-group">
                        <gb:SiteLabel ID="lblAnonymousVoting" runat="server" ForControl="chkAnonymousVoting"
                            CssClass="settinglabel control-label col-sm-3" ConfigKey="PollEditAnonymousVotingLabel" ResourceFile="PollResources">
                        </gb:SiteLabel>
                        <div class="col-sm-9">
                            <asp:CheckBox ID="chkAnonymousVoting" Checked="true" runat="server" />
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblAllowViewingResultsBeforeVoting" runat="server" ForControl="chkAllowViewingResultsBeforeVoting"
                            CssClass="settinglabel control-label col-sm-3" ConfigKey="PollEditAllowViewingResultsBeforeVotingLabel"
                            ResourceFile="PollResources" />
                        <div class="col-sm-9">
                            <asp:CheckBox ID="chkAllowViewingResultsBeforeVoting" runat="server" />
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblShowOrderNumbers" runat="server" ForControl="chkShowOrderNumbers"
                            CssClass="settinglabel control-label col-sm-3" ConfigKey="PollEditShowOrderNumbersLabel" ResourceFile="PollResources">
                        </gb:SiteLabel>
                        <div class="col-sm-9">
                            <asp:CheckBox ID="chkShowOrderNumbers" runat="server" />
                        </div>
                    </div>
                    <div id="divShowResultsWhenDeactivated" runat="server"  class="settingrow form-group">
                        <gb:SiteLabel ID="lblShowResultsWhenDeactivated" runat="server" ForControl="chkShowResultsWhenDeactivated"
                            CssClass="settinglabel control-label col-sm-3" ConfigKey="PollEditShowResultsWhenDeactivatedLabel" ResourceFile="PollResources" />
                        <div class="col-sm-9">
                            <asp:CheckBox ID="chkShowResultsWhenDeactivated" runat="server" />
                        </div>
                    </div>
                    <div class="settingrow form-group">
                        <gb:SiteLabel ID="lblActiveFromTo" runat="server" CssClass="settinglabel control-label col-sm-3" ConfigKey="PollEditActiveFromToLabel"
                            ResourceFile="PollResources" />
                        <div class="col-sm-9">
                            <gb:DatePickerControl ID="dpActiveFrom" runat="server" ShowTime="True" CssClass="forminput" SkinID="Poll" />
                            <gb:SiteLabel ID="lblTo" runat="server" ResourceFile="PollResources" ConfigKey="PollEditToLabel" />
                            <gb:DatePickerControl ID="dpActiveTo" runat="server" ShowTime="True" CssClass="forminput" SkinID="Poll" />
                        </div>
                    </div>
                    <div class="settingrow form-group" id="divStartDeactivated" runat="server" visible="false">
                        <gb:SiteLabel ID="lblStartDeactivated" runat="server" ForControl="chkStartDeactivated"
                            CssClass="settinglabel control-label col-sm-3" ConfigKey="PollEditStartDeactivatedLabel" ResourceFile="PollResources" />
                        <div class="col-sm-9">
                            <asp:CheckBox ID="chkStartDeactivated" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group">
                                <asp:ListBox ID="lbOptions" Width="100%" DataTextField="Answer" DataValueField="OptionGuid"
                                    Rows="10" AutoPostBack="true" runat="server" />
                                <div class="input-group-addon">
                                    <ul class="nav sorter">
                                        <li><asp:LinkButton ID="btnUp" runat="server"><i class="fa fa-angle-up"></i></asp:LinkButton></li>
                                        <li><asp:LinkButton ID="btnDown" runat="server"><i class="fa fa-angle-down"></i></asp:LinkButton></li>
                                        <li><asp:LinkButton ID="btnDeleteOption" runat="server"><i class="fa fa-trash-o"></i></asp:LinkButton></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <telerik:RadTabStrip ID="tabOptionLanguage" OnTabClick="tabOptionLanguage_TabClick" 
                                EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblPollAddOptions" runat="server" ForControl="tblOptions" CssClass="settinglabel control-label col-sm-3"
                                    ConfigKey="PollEditOptionsLabel" ResourceFile="PollResources" />
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtNewOption" runat="server" MaxLength="255" />
                                    <asp:Button ID="btnAddOption" runat="server" 
                                        Text="<%$Resources:PollResources, PollEditOptionsAddButton %>"
                                        ToolTip="<%$Resources:PollResources, PollEditOptionsAddButton %>"
                                        SkinID="DefaultButton" CausesValidation="False" />
                                    <asp:CustomValidator ID="cvOptionsLessThanTwo" runat="server" Display="Dynamic" ValidationGroup="poll" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />