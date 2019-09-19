<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="ProductTagsBulkEdit.aspx.cs" Inherits="CanhCam.Web.ProductUI.ProductTagsBulkEditPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <style type="text/css">
        .adminmenu ul.simplelist {padding-left:0;}
        .settingrow form-group{padding-left:100px;}
        .settingrow form-group.settinglabel col-md-3 {margin-left:-100px;width:90px}
    </style>
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:ProductResources, ProductTagsBulkEdit %>" CurrentPageUrl="~/Product/ProductTagsBulkEdit.aspx"
        ParentTitle="<%$Resources:ProductResources, ProductTagsTitle %>" ParentUrl="~/Product/ProductTags.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server">
            <asp:Button SkinID="InsertButton" ID="btnAddNew" Text="<%$Resources:ProductResources, ProductTagAddNewButton %>" runat="server" />
            <asp:Button SkinID="UpdateButton" ID="btnUpdate" Text="<%$Resources:Resource, UpdateButton %>" runat="server" CausesValidation="false" />
            <asp:Button SkinID="CancelButton" ID="btnCancel" Visible="false" Text="<%$Resources:Resource, CancelButton %>" runat="server" />
            <asp:HyperLink SkinID="DefaultButton" ID="lnkGridView" Text="<%$Resources:ProductResources, ProductTagsTitle %>" runat="server" />
        </portal:HeadingPanel>
        <portal:NotifyMessage ID="message" runat="server" />
        <asp:Panel ID="pnlSearch" DefaultButton="btnSearch" CssClass="headInfo" runat="server">
            <div class="input-group">
                <asp:TextBox ID="txtKeyword" placeholder="<%$Resources:ProductResources, ProductTagKeywordLabel %>" CssClass="form-control" runat="server" MaxLength="255" />
                <div class="input-group-btn">
                    <asp:Button SkinID="DefaultButton" ID="btnSearch" Text="<%$Resources:ProductResources, ProductSearchButton %>"
                        runat="server" CausesValidation="false" />
                </div>
            </div>
        </asp:Panel>
        <div class="workplace">
            <asp:Repeater ID="rpt" OnItemDataBound="rpt_ItemDataBound" runat="server">
                <HeaderTemplate>
                    <div class="row">
                </HeaderTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
                <ItemTemplate>
                    <div class="col-md-6">
                        <div class="bulkzone">
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3"
                                        ConfigKey="ProductTagName" ResourceFile="ProductResources" />
                                <div class="col-sm-9">
                                    <asp:HiddenField ID="hdfTagId" runat="server" Value='<%#Eval("TagId") %>' />
                                    <asp:HiddenField ID="hdfTagGuid" runat="server" Value='<%#Eval("Guid") %>' />
                                    <asp:TextBox ID="txtName" MaxLength="255" Text='<%# Eval("TagText") %>' runat="server" /><br />
                                    <asp:CheckBox ID="chkDelete" Text="<%$Resources:Resource, DeleteButton %>" runat="server" />
                                </div>
                            </div>
                            <%if (WebConfigSettings.AllowMultiLanguage)
                            { %>
                                <asp:Repeater ID="rptLanguages" OnItemDataBound="rptLanguages_ItemDataBound" runat="server">
                                    <ItemTemplate>
                                        <div class="settingrow form-group">
                                            <gb:SiteLabel ID="lblName" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3"
                                                    Text='<%#Eval("Name")%>' />
                                            <div class="col-sm-9">
                                                <asp:HiddenField ID="hdfLanguageId" runat="server" Value='<%#Eval("LanguageId") %>' />
                                                <asp:TextBox ID="txtName" MaxLength="255" runat="server" />
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            <% }%>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <portal:gbCutePager ID="pgr" runat="server" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
