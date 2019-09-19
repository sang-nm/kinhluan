<%@ Page ValidateRequest="false" Language="c#" CodeBehind="EditInstructionBlock.aspx.cs"
    MasterPageFile="~/App_MasterPages/DialogMaster.Master" AutoEventWireup="false"
    Inherits="CanhCam.FormWizard.Web.UI.EditInstructionBlock" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="cp-settingrow">
        <asp:Button CssClass="cp-button" ID="btnSave" runat="server" />
        <asp:Button CssClass="cp-button" ID="btnClose" runat="server" />
    </div>
    <div class="cp-settingrow">
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
                <div id="divQuestionText" class="settingrow" runat="server">
                    <gb:SiteLabel ID="SiteLabel1" runat="server" ConfigKey="QuestionTextLabel" ForControl="txtQuestionText"
                        ResourceFile="FormWizardResources" CssClass="settinglabel" />
                    <asp:TextBox ID="txtQuestionText" CssClass="widetextbox" runat="server"></asp:TextBox>
                </div>
                <div id="divQuestionAlias" runat="server" class="settingrow">
                    <gb:SiteLabel ID="SiteLabel2" runat="server" ConfigKey="QuestionAliasLabel" ForControl="txtQuestionAlias"
                        ResourceFile="FormWizardResources" CssClass="settinglabel" />
                    <asp:TextBox ID="txtQuestionAlias" CssClass="widetextbox" runat="server"></asp:TextBox>
                </div>
                <div id="divInstructions" runat="server" class="cp-settingrow">
                    <gbe:EditorControl ID="edInstructions" runat="server" />
                </div>
                <%if (WebConfigSettings.AllowMultiLanguage)
                  { %>
            </div>
            <asp:Repeater ID="rptLanguageDivs" OnItemCreated="rptLanguageDivs_ItemCreated" OnItemDataBound="rptLanguageDivs_ItemDataBound"
                runat="server">
                <ItemTemplate>
                    <div id="idTab_Info<%# Container.ItemIndex+2 %>">
                        <asp:HiddenField ID="hdnLangCode" runat="server" Value='<%#Eval("LangCode") %>' />
                        <div id="divQuestionText" class="settingrow" runat="server">
                            <gb:SiteLabel ID="SiteLabel1" runat="server" ConfigKey="QuestionTextLabel" ForControl="txtQuestionText"
                                ResourceFile="FormWizardResources" CssClass="settinglabel" />
                            <asp:TextBox ID="txtQuestionText" CssClass="widetextbox" runat="server"></asp:TextBox>
                        </div>
                        <div id="divQuestionAlias" runat="server" class="settingrow">
                            <gb:SiteLabel ID="SiteLabel2" runat="server" ConfigKey="QuestionAliasLabel" ForControl="txtQuestionAlias"
                                ResourceFile="FormWizardResources" CssClass="settinglabel" />
                            <asp:TextBox ID="txtQuestionAlias" CssClass="widetextbox" runat="server"></asp:TextBox>
                        </div>
                        <div id="divInstructions" runat="server" class="cp-settingrow">
                            <gbe:EditorControl ID="edInstructions" runat="server" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <% }%>
    </div>
</asp:Content>
