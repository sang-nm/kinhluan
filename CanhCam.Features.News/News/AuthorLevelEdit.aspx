<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AuthorLevelEdit.aspx.cs" Inherits="CanhCam.Web.CustomUI.AuthorLevelEdit" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">

    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" CurrentPageTitle="Add/Edit Level"
        CurrentPageUrl="~/News/AuthorLevelEdit.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upButton" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndNew" Text="<%$Resources:Resource, UpdateAndNewButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" Text="<%$Resources:Resource, UpdateAndCloseButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsert" Text="<%$Resources:Resource, InsertButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndNew" Text="<%$Resources:Resource, InsertAndNewButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndClose" Text="<%$Resources:Resource, InsertAndCloseButton %>" ValidationGroup="news" runat="server" />
                    <asp:Button SkinID="DefaultButton" ID="btnCopyModal" Visible="false" data-toggle="modal" data-target="#pnlModal" Text="Copy" runat="server" CausesValidation="false" />

                    <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:CustomResources, DeleteButton %>"
                        runat="server" />

                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Panel ID="pnlNews" runat="server" CssClass="workplace" DefaultButton="btnUpdate">
            <div class="form-horizontal">
                <asp:UpdatePanel ID="up" runat="server">
                    <ContentTemplate>

                        <div id="divname" runat="server" class="settingrow form-group newsedit-subtitle">
                            <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="Name" ResourceFile="NewsResources" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtName" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                            </div>
                        </div>

                        <div id="divFrom" runat="server" class="settingrow form-group newsedit-subtitle">
                            <gb:SiteLabel ID="lblFrom" runat="server" ForControl="txtFrom" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="From" ResourceFile="NewsResources" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtFrom" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                            </div>
                        </div>
                        <div id="divTo" runat="server" class="settingrow form-group newsedit-subtitle">
                            <gb:SiteLabel ID="lblTo" runat="server" ForControl="txtTo" CssClass="settinglabel control-label col-sm-3"
                                ConfigKey="To" ResourceFile="NewsResources" />
                            <div class="col-sm-9">
                                <asp:TextBox ID="txtTo" runat="server" MaxLength="255" CssClass="forminput verywidetextbox" />
                            </div>
                        </div>

                        <%--<div class="settingrow form-group">
                            <div id="divDelete" class="settingrow form-group" runat="server">
                                <gb:SiteLabel ID="lblDelete" runat="server" ForControl="ckActive" ConfigKey="IsDelected"
                                    ResourceFile="CustomResources" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="ckDelete" runat="server" Checked="false" />
                                </div>
                            </div>
                        </div>--%>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
