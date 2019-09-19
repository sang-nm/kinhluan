<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LanguageSelectorAdmin.ascx.cs" Inherits="CanhCam.Web.UI.LanguageSelectorAdmin" %>

<div class="cp-langbox right">
    <span class="left">
        <asp:Literal runat="server" EnableViewState="false" Text="<%$Resources:Resource, LanguageSelector%>" />
    </span>
    <asp:DropDownList ID="ddlLanguageSelector" AutoPostBack="true" 
                DataTextField="Name" DataValueField="LangCode"
                OnSelectedIndexChanged="ddlLanguageSelector_SelectedIndexChanged" runat="server" />
</div>