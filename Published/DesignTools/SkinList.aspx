<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="SkinList.aspx.cs" Inherits="CanhCam.Web.AdminUI.SkinListPage" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:DevTools, SkinManagement %>" CurrentPageUrl="~/DesignTools/SkinList.aspx"
        ParentTitle="<%$Resources:DevTools, DesignTools %>" ParentUrl="~/DesignTools/Default.aspx"
        RootTitle="<%$Resources:Resource, AdvancedToolsLink %>" RootUrl="~/AdminCP/AdvancedTools.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div id="divUpload" runat="server" class="headInfo form-horizontal">
            <div class="settingrow form-group">
                <telerik:RadAsyncUpload ID="uplFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Disabled"
                        AllowedFileExtensions=".zip" runat="server" />
            </div>
            <div class="settingrow form-group">
                <asp:Button SkinID="DefaultButton" ID="btnUpload" runat="server" />
                <asp:CheckBox ID="chkOverwrite" runat="server" Checked="true" />
                <%--<asp:RegularExpressionValidator ID="regexZipFile" ControlToValidate="zipFile" Display="Dynamic"
                    EnableClientScript="true" runat="server" ValidationGroup="upload" />
                <asp:RequiredFieldValidator ID="reqZipFile" runat="server" ControlToValidate="zipFile"
                    Display="Dynamic" ValidationGroup="upload" />--%>
            </div>
        </div>
        <div class="workplace">
            <asp:Repeater ID="rptSkins" runat="server">
                <ItemTemplate>
                    <div class="mrb10">
                        <%# Eval("Name") %>
                        <%# BuildDownloadLink(Eval("Name").ToString()) %>
                        <asp:HyperLink ID="lnkSkinPreview" runat="server" CssClass="popup-link cp-link" Text='<%# PreviewText %>'
                            NavigateUrl='<%# SiteRoot + "/default.aspx?skin=" + Eval("Name")  %>' />
                        <asp:HyperLink CssClass="cp-link" ID="lnkManage" runat="server" Visible='<%# allowEditing %>' Text='<%# ManageText %>'
                            NavigateUrl='<%# SiteRoot + "/DesignTools/ManageSkin.aspx?s=" + Eval("Name")  %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>