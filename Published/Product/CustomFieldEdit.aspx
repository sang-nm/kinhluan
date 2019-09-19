<%@ Page Language="c#" CodeBehind="CustomFieldEdit.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.Web.ProductUI.CustomFieldEditPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        ParentTitle="<%$Resources:ProductResources, CustomFieldsTitle %>" ParentUrl="~/Product/CustomFields.aspx"
        CurrentPageTitle="<%$Resources:ProductResources, CustomFieldEditTitle %>" CurrentPageUrl="~/Product/CustomFieldEdit.aspx" />
    <div class="admin-content col-md-12">
        <asp:UpdatePanel ID="upButton" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <portal:HeadingPanel ID="heading" runat="server">
                    <asp:Button SkinID="UpdateButton" ID="btnUpdate" ValidationGroup="CustomFields" Text="<%$Resources:Resource, UpdateButton %>" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndNew" ValidationGroup="CustomFields" Text="<%$Resources:Resource, UpdateAndNewButton %>" runat="server" />
                    <asp:Button SkinID="UpdateButton" ID="btnUpdateAndClose" ValidationGroup="CustomFields" Text="<%$Resources:Resource, UpdateAndCloseButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsert" ValidationGroup="CustomFields" Text="<%$Resources:Resource, InsertButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndNew" ValidationGroup="CustomFields" Text="<%$Resources:Resource, InsertAndNewButton %>" runat="server" />
                    <asp:Button SkinID="InsertButton" ID="btnInsertAndClose" ValidationGroup="CustomFields" Text="<%$Resources:Resource, InsertAndCloseButton %>" runat="server" />
                    <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" Text="<%$Resources:Resource, DeleteButton %>" CausesValidation="false" />
                    <asp:Button SkinID="DeleteButton" ID="btnDeleteLanguage" Visible="false" OnClick="btnDeleteLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                </portal:HeadingPanel>
                <portal:NotifyMessage ID="message" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="workplace">
            <div id="divtabs" runat="server" class="tabs">
                <ul id="ulTabs" class="nav nav-tabs" runat="server">
                    <li class="active" role="presentation">
                        <asp:Literal ID="litTabContent" runat="server" /></li>
                    <li role="presentation">
                        <asp:Literal ID="litTabOptions" runat="server" /></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane fade active in" id="tabContent">
                        <div class="form-horizontal">
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblZones" runat="server" ConfigKey="ZoneLabel" ResourceFile="Resource"
                                    ForControl="cobZones" CssClass="settinglabel control-label col-sm-3" />
                                <div class="col-sm-9">
                                    <portal:ComboBox ID="cobZones" SelectionMode="Multiple" runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel id="lblFieldType" runat="server" ForControl="ddlFieldType" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldTypeLabel" ResourceFile="ProductResources" />
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlFieldType" runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel id="lblDataType" runat="server" ForControl="ddlDataType" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldDataTypeLabel" ResourceFile="ProductResources" />
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlDataType" runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel id="lblFilterType" runat="server" ForControl="ddlFilterType" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldFilterTypeLabel" ResourceFile="ProductResources" />
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlFilterType" runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel id="lblIsEnabled" runat="server" ForControl="chkIsEnabled" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldIsEnabledLabel" ResourceFile="ProductResources" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkIsEnabled" Checked="true" runat="server" />	
                                </div>
                            </div>
                            <div id="divIsRequired" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel id="lblIsRequired" runat="server" ForControl="chkIsRequired" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldIsRequiredLabel" ResourceFile="ProductResources" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkIsRequired" runat="server" />	
                                </div>
                            </div>
                            <div id="divValidationExpression" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel id="lblValidationExpression" runat="server" ForControl="txtValidationExpression" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldValidationExpressionLabel" ResourceFile="ProductResources" />
                                <div class="col-sm-9">
                                    <asp:TextBox ID="txtValidationExpression" runat="server" />	
                                </div>
                            </div>
                            <div id="divAllowComparing" visible="false" runat="server" class="settingrow form-group">
                                <gb:SiteLabel id="lblAllowComparing" runat="server" ForControl="chkAllowComparing" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldAllowComparingLabel" ResourceFile="ProductResources" />
                                <div class="col-sm-9">
                                    <asp:CheckBox ID="chkAllowComparing"  runat="server" CssClass="forminput" />	
                                </div>
                            </div>
                            <asp:UpdatePanel ID="up" runat="server">
                                <ContentTemplate>
                                    <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                                        EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                        CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                                    <div class="settingrow form-group">
                                        <gb:SiteLabel id="lblName" runat="server" ForControl="txtName" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldNameLabel" ResourceFile="ProductResources" />
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="txtName" MaxLength="255" runat="server" />
                                            <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtName"
                                                ErrorMessage="<%$Resources:ProductResources, CustomFieldNameRequiredWarning %>"
                                                Display="Dynamic" SetFocusOnError="true" CssClass="txterror" ValidationGroup="CustomFields" />
                                        </div>
                                    </div>
                                    <div id="divDisplayName" visible="false" runat="server" class="settingrow form-group">
                                        <gb:SiteLabel id="lblDisplayName" runat="server" ForControl="txtDisplayName" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldDisplayNameLabel" ResourceFile="ProductResources" />
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="txtDisplayName" MaxLength="255" runat="server" />	
                                        </div>
                                    </div>
                                    <div id="divInvalidMessage" visible="false" runat="server" class="settingrow form-group">
                                        <gb:SiteLabel id="lblInvalidMessage" runat="server" ForControl="txtInvalidMessage" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldInvalidMessageLabel" ResourceFile="ProductResources" />
                                        <div class="col-sm-9">
                                            <asp:TextBox ID="txtInvalidMessage" MaxLength="255" runat="server" />	
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade" id="tabOptions" runat="server">
                        <asp:UpdatePanel ID="upOptions" runat="server">
                            <ContentTemplate>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group">
                                            <asp:ListBox ID="lbOptions" Width="100%" Height="300" AutoPostBack="true" runat="server"
                                                AppendDataBoundItems="true" DataTextField="Name" DataValueField="CustomFieldOptionID" />
                                            <div class="input-group-addon">
                                                <ul class="nav sorter">
                                                    <li><asp:LinkButton ID="btnOptionUp" CommandName="up" runat="server"><i class="fa fa-angle-up"></i></asp:LinkButton></li>
                                                    <li><asp:LinkButton ID="btnOptionDown" CommandName="down" runat="server"><i class="fa fa-angle-down"></i></asp:LinkButton></li>
                                                    <li><asp:LinkButton ID="btnDeleteOption" runat="server"><i class="fa fa-trash-o"></i></asp:LinkButton></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <telerik:RadTabStrip ID="tabOptionLanguage" OnTabClick="tabOptionLanguage_TabClick" 
                                            EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                                            CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                                        <div class="form-horizontal">
                                            <div class="settingrow form-group">
                                                <gb:SiteLabel ID="lblOptionTitle" runat="server" CssClass="settinglabel control-label col-sm-3" ForControl="txtOptionName" ConfigKey="CustomFieldOptionNameLabel"
                                                    ResourceFile="ProductResources" />
                                                <div class="col-sm-9">
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtOptionName" runat="server" MaxLength="255" />
                                                        <portal:gbHelpLink ID="GbHelpLink1" runat="server" HelpKey="customfield-options-help" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="divOptionType" visible="false" runat="server" class="settingrow form-group">
                                                <%--<gb:SiteLabel id="lblOptionType" runat="server" ForControl="ddlFilterType" CssClass="settinglabel control-label col-sm-3" ConfigKey="CustomFieldOptionTypeLabel" ResourceFile="ProductResources" />--%>
                                                <div class="col-sm-9 col-md-offset-3">
                                                    <asp:DropDownList ID="ddlOptionType" Enabled="false" runat="server" />
                                                    <telerik:RadColorPicker ID="colorPicker" Skin="Simple" ShowIcon="true" PaletteModes="All" runat="server" />
                                                </div>
                                            </div>
                                            <div class="settingrow form-group">
                                                <div class="col-sm-9 col-md-offset-3">
                                                    <asp:Button SkinID="DefaultButton" ID="btnUpdateOption" Text="<%$Resources:Resource, UpdateButton %>" runat="server" />
                                                    <asp:Button SkinID="DefaultButton" ID="btnDeleteOptionLanguage" Visible="false" OnClick="btnDeleteOptionLanguage_Click" Text="<%$Resources:Resource, DeleteLanguageButton %>" runat="server" CausesValidation="false" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
        <portal:SessionKeepAliveControl ID="ka1" runat="server" />
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />