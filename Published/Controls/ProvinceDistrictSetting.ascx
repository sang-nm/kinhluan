<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ProvinceDistrictSetting.ascx.cs" Inherits="CanhCam.Web.UI.ProvinceDistrictSetting" %>

<asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
    <ContentTemplate>
        <div class="frm-row">
            <asp:DropDownList ID="ddProvince" runat="server" AutoPostBack="true" DataValueField="Guid" DataTextField="Name" EnableTheming="false" />
        </div>
        <div class="frm-row">
            <asp:DropDownList ID="ddDistrict" runat="server" DataValueField="Guid" DataTextField="Name"
                EnableTheming="false">
            </asp:DropDownList>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>