<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="AttributeDialog.aspx.cs" Inherits="CanhCam.Web.NewsUI.AttributeDialog" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="settingrow">
        <asp:Button CssClass="form-button" ID="btnSave" Text="<%$Resources:NewsResources, AttributeSaveButton %>"
            ValidationGroup="news" runat="server" />
        <asp:Button CssClass="form-button" ID="btnSaveAndNew" Text="<%$Resources:NewsResources, AttributeSaveAndNew %>"
            ValidationGroup="news" runat="server" />
        <asp:Button CssClass="form-button" ID="btnDelete" runat="server" Text="<%$Resources:NewsResources, AttributeDeleteButton %>"
            CausesValidation="false" />
    </div>
    <div class="settingrow">
        <asp:RequiredFieldValidator ID="reqTitle" ControlToValidate="txtTitle" ErrorMessage="<%$Resources:NewsResources, AttributeTitleRequired %>"
            ValidationGroup="news" Display="Dynamic" CssClass="txterror" runat="server" />
    </div>
    <%if (WebConfigSettings.AllowMultiLanguage)
      {%>
    <div class="gb-tabs">
        <ul>
            <li class="selected"><a href="#idTab_Info1" class="selected">
                <asp:Literal ID="lblDefaultLanguage" Text="<%$Resources:Resource, DefaultLanguage %>"
                    runat="server" />
            </a></li>
            <asp:Repeater ID="rptLanguageTabs" runat="server">
                <ItemTemplate>
                    <li class="idTab"><a href="#idTab_Info<%# Container.ItemIndex+2 %>">
                        <%#Server.HtmlEncode(Eval("Name").ToString())%></a> </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
        <div id="idTab_Info1" class="tab">
            <%}%>
            <div class="settingrow">
                <gb:SiteLabel ID="Sitelabel1" runat="server" CssClass="settinglabel" ConfigKey="AttributeTitle"
                    ResourceFile="NewsResources" />
                <asp:TextBox ID="txtTitle" runat="server" MaxLength="255"></asp:TextBox>
            </div>
            <div class="settingrow">
                <gb:SiteLabel ID="Sitelabel4" runat="server" CssClass="settinglabel" ConfigKey="AttributeContent"
                    ResourceFile="NewsResources" />
            </div>
            <div class="settingrow">
                <gbe:EditorControl ID="edContent" runat="server" />
            </div>
            <%if (WebConfigSettings.AllowMultiLanguage)
              { %>
        </div>
        <asp:Repeater ID="rptLanguageDivs" OnItemCreated="rptLanguageDivs_ItemCreated" OnItemDataBound="rptLanguageDivs_ItemDataBound"
            runat="server">
            <ItemTemplate>
                <div id="idTab_Info<%# Container.ItemIndex+2 %>">
                    <asp:HiddenField ID="hdnLangCode" runat="server" Value='<%#Eval("LangCode") %>' />
                    <div class="settingrow">
                        <gb:SiteLabel ID="Sitelabel1" runat="server" CssClass="settinglabel" ConfigKey="AttributeTitle"
                            ResourceFile="NewsResources" />
                        <asp:TextBox ID="txtTitle" runat="server" MaxLength="255"></asp:TextBox>
                    </div>
                    <div class="settingrow">
                        <gb:SiteLabel ID="Sitelabel4" runat="server" CssClass="settinglabel" ConfigKey="AttributeContent"
                            ResourceFile="NewsResources" />
                    </div>
                    <div class="settingrow">
                        <gbe:EditorControl ID="edContent" runat="server" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <% }%>
</asp:Content>
