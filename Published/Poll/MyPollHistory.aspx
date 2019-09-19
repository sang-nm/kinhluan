<%@ Page ValidateRequest="false" Language="c#" MaintainScrollPositionOnPostback="true"
    Codebehind="MyPollHistory.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="PollFeature.UI.MyPollHistory" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">

<div class="breadcrumbs">
    <asp:HyperLink ID="lnkPageCrumb" runat="server" CssClass="unselectedcrumb"></asp:HyperLink> &gt;
    <asp:HyperLink runat="server" ID="lnkPollHistory" CssClass="selectedcrumb"></asp:HyperLink>
</div>
 <portal:HeadingControl ID="heading" runat="server" />
<portal:gbDataList ID="dlPolls" runat="server" DataKeyField="PollGuid">
    <ItemTemplate>
        <asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question") %>' Font-Bold="true" />
        <portal:gbDataList ID="dlResults" runat="server" DataKeyField="OptionGuid">
            <ItemTemplate>
                <asp:Label ID="lblOption" runat="server" Text='<%# GetOptionResultText(Eval("OptionGuid")) %>'></asp:Label>
                <br />
                <span id="spnResultImage" runat="server"></span>
            </ItemTemplate>
        </portal:gbDataList>
        <br />
        <asp:Label ID="lblActive" runat="server" Text='<%# GetActiveText(Eval("ActiveFrom"), Eval("ActiveTo")) %>'></asp:Label>
        <br />
        <gb:SiteLabel ID="lblYouVoted" runat="server" ConfigKey="PollHistoryYouVotedLabel"
            ResourceFile="PollResources" UseLabelTag="false" />
        &nbsp;<asp:Label ID="lblAnswer" runat="server" Text='<%# Eval("Answer") %>'></asp:Label>
        <hr />
    </ItemTemplate>
</portal:gbDataList>
<portal:SessionKeepAliveControl ID="ka1" runat="server" />
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />