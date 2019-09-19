<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="ContentPublishDialog.aspx.cs" Inherits="CanhCam.Web.AdminUI.ContentPublishDialog" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="form-horizontal">
        <asp:Panel ID="pnlUpdate" runat="server">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="SiteLabel5" runat="server" ConfigKey="PageSettingsPageNameLabel"
                    CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:Label ID="lblPageName" runat="server" />
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="SiteLabel6" runat="server" ConfigKey="ModuleSettingsModuleNameLabel"
                    CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:Label ID="lblModuleName" runat="server" />
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="SiteLabel4" runat="server" ConfigKey="ContentManagerPublishedColumnHeader"
                    ForControl="chkPublished" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:CheckBox ID="chkPublished" runat="server" />
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblPageNameLayout" runat="server" ConfigKey="ContentManagerColumnColumnHeader"
                    ForControl="ddPaneNames" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddPaneNames" runat="server" DataTextField="key" DataValueField="value"
                        CssClass="forminput">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="SiteLabel1" runat="server" ConfigKey="ContentManagerOrderColumnHeader"
                    ForControl="txtModuleOrder" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:TextBox ID="txtModuleOrder" Columns="4" runat="server" CssClass="forminput smalltextbox" />
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="SiteLabel2" runat="server" ConfigKey="ContentManagerPublishBeginDateColumnHeader"
                    CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <gb:DatePickerControl ID="dpBeginDate" runat="server" ShowTime="True" SkinID="ContentManager" />
                    <asp:RequiredFieldValidator ID="reqElement" runat="server" ControlToValidate="dpBeginDate" Display="Dynamic" />
                </div>
            </div>
            <div class="settingrow form-group">
                <gb:SiteLabel ID="SiteLabel3" runat="server" ConfigKey="ContentManagerPublishEndDateColumnHeader"
                    CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <gb:DatePickerControl ID="dpEndDate" runat="server" ShowTime="True" SkinID="ContentManager" />
                </div>
            </div>
            <div class="settingrow form-group">
                <div class="col-sm-offset-3 col-sm-9">
                    <asp:Button SkinID="UpdateButton" ID="btnSave" runat="server" />
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlFinished" runat="server" Visible="false">
            <script type="text/javascript">
                window.parent.location.reload();
                window.close();
            </script>
        </asp:Panel>
    </div>
</asp:Content>