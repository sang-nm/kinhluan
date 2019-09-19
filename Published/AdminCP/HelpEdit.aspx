<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/App_MasterPages/DialogMaster.Master" CodeBehind="HelpEdit.aspx.cs" Inherits="CanhCam.Web.UI.Pages.HelpEdit" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="col-md-12">
        <div id="divEditor" class="settingrow form-group" runat="server">
            <div class="mrb10 mrt10">
                <asp:Button SkinID="DefaultButton" ID="btnSave" runat="server" OnClick="btnSave_Click" />
                <asp:HyperLink CssClass="cp-link" ID="lnkCancel" runat="server" />
            </div>
            <div class="mrb10">
                <gbe:EditorControl id="edContent" runat="server"></gbe:EditorControl>
            </div>
            <portal:SessionKeepAliveControl id="ka1" runat="server" />
        </div>
    </div>
</asp:Content>
