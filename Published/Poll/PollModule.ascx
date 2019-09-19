<%@ Control Language="C#" AutoEventWireup="false" Codebehind="PollModule.ascx.cs" Inherits="CanhCam.Web.PollUI.PollModule" EnableViewState="true" %>

<asp:Label ID="lblQuestion" CssClass="poll-question" runat="server" />
<asp:UpdatePanel ID="pnlPollUpdate" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <asp:RadioButtonList ID="rblOptions" SkinID="Polls" CssClass="poll-options" runat="server" RepeatLayout="UnorderedList"
            DataTextField="Answer" DataValueField="OptionGuid" EnableViewState="true">
        </asp:RadioButtonList>
        <asp:RequiredFieldValidator ID="reqOptions" 
            Text="<%$Resources:PollResources, ChooseOptionRequiredWarning %>"
            ToolTip="<%$Resources:PollResources, ChooseOptionRequiredWarning %>"
            ValidationGroup="Polls" runat="server" Display="Dynamic" ControlToValidate="rblOptions"></asp:RequiredFieldValidator>
        <asp:Repeater ID="rptResults" runat="server" >
            <HeaderTemplate><div class="poll-resultswrap"><ul></HeaderTemplate>
            <ItemTemplate>
                <li>
                    <asp:Label ID="lblOption" runat="server" CssClass="poll-option" Text='<%# GetOptionResultText(Eval("DisplayOrder"), Eval("Answer"), Eval("Votes")) %>'></asp:Label>
                    <div id="spnResultImage" class="poll-resultbar" runat="server"></div>
                    <asp:HiddenField ID="hdnID" runat="server" Value='<%# Eval("OptionGuid")%>' />
                </li>
            </ItemTemplate>
            <FooterTemplate></ul></div></FooterTemplate>
        </asp:Repeater>
        <asp:Label ID="lblMessage" CssClass="poll-message" runat="server" />
        <asp:Label ID="lblVotingStatus" CssClass="poll-status" runat="server" />
        <div class="poll-buttons">
            <asp:Button ID="btnVote" CssClass="button-vote" ValidationGroup="Polls" Text="<%$Resources:PollResources, PollVoteButton %>" ToolTip="<%$Resources:PollResources, PollVoteToolTip %>" runat="server" />
            <asp:Button ID="btnShowResults" CssClass="button-results" Text="<%$Resources:PollResources, PollShowResultsButton %>" ToolTip="<%$Resources:PollResources, PollShowResultsToolTip %>" runat="server" />
            <asp:Button ID="btnBackToVote" CssClass="button-back" Text="<%$Resources:PollResources, PollBackToVoteButton %>" ToolTip="<%$Resources:PollResources, PollBackToVoteToolTip %>" runat="server" Visible="false" />
        </div>
    </ContentTemplate>
</asp:UpdatePanel>