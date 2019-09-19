<%@ Page ValidateRequest="false" Language="c#" CodeBehind="FormOptionEdit.aspx.cs"
    MasterPageFile="~/App_MasterPages/DialogMaster.Master" AutoEventWireup="false"
    Inherits="CanhCam.FormWizard.Web.UI.FormOptionEdit" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="form-horizontal">
        <div class="settingrow form-group">
            <div class="col-sm-9 col-sm-offset-3">
                <div class="input-group">
                    <asp:DropDownList ID="ddOptions" AutoPostBack="true" Width="250" runat="server" />
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
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblOptionText" runat="server" ConfigKey="Display" ForControl="txtOptionText"
                        ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtOptionText" MaxLength="255" runat="server" />
                    </div>
                </div>
                <div id="divOptionValue" visible="false" runat="server" class="settingrow form-group">
                    <gb:SiteLabel ID="lblOptionValue" runat="server" ConfigKey="ValueAlias" ForControl="txtOptionValue"
                        ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtOptionValue" MaxLength="255" runat="server" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
