<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="WebFormControl.ascx.cs"
    Inherits="CanhCam.FormWizard.Web.UI.WebFormControl" %>
<%@ Register TagPrefix="Site" TagName="QuestionViewer" Src="~/FormWizard/Controls/QuestionViewer.ascx" %>
<%@ Register TagPrefix="Site" TagName="QuestionEditor" Src="~/FormWizard/Controls/QuestionEditor.ascx" %>
<portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
    CurrentPageTitle="<%$Resources:FormWizardResources, FormEditPageTitle %>" CurrentPageUrl="~/FormWizard/FormEdit.aspx" />
<div class="admin-content col-md-12">
    <portal:HeadingPanel ID="heading" runat="server">
        <asp:Button SkinID="SaveButton" ID="btnSaveForm" runat="server" />
    </portal:HeadingPanel>
    <portal:NotifyMessage ID="message" runat="server" />
    <div id="divtabs" class="tabs workplace">
        <ul class="nav nav-tabs">
            <li role="presentation" id="liQuestionsTab" runat="server" class="active">
                <asp:Literal ID="litQuestionsTab" runat="server" /></li>
            <li role="presentation"><a aria-controls="tab2" role="tab" data-toggle="tab" href="#tab2">
                <asp:Literal ID="litMessageTab" runat="server" /></a></li>
        </ul>
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane fade active in" id="divQuestionsTab" runat="server">
                <asp:UpdatePanel ID="pnlForm" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <telerik:RadGrid ID="grdQuestions" SkinID="radGridSkin" runat="server">
                            <MasterTableView DataKeyNames="Guid" ClientDataKeyNames="Guid" EditMode="InPlace"
                                ShowHeader="false" ShowFooter="false" AllowPaging="false">
                                <Columns>
                                    <telerik:GridTemplateColumn>
                                        <ItemTemplate>
                                            <div class="settingrow form-group">
                                                <Site:QuestionViewer ID="QuestionViewer1" Enabled="false" 
                                                    Question='<%# ((CanhCam.Business.WebFormQuestion)Container.DataItem) %>'
                                                    runat="server" />
                                            </div>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <Site:QuestionEditor ID="QuestionEditor1" EnableRegexValidation="true" Enabled="false" Question='<%# ((CanhCam.Business.WebFormQuestion)Container.DataItem) %>'
                                                runat="server" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" ToolTip='<%# Resources.FormWizardResources.EditQuestionButton %>'><i class="fa fa-edit text-16px"></i></asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" ToolTip='<%# Resources.FormWizardResources.DeleteQuestionButtonTooltip %>'
                                                CommandArgument='<%#Eval("Guid") %>'><i class="fa fa-trash-o text-16px"></i></asp:LinkButton>
                                            <a class="cp-link" onclick="window.open(this.href,'_blank');return false;" href='<%# SiteRoot + "/FormWizard/Export.aspx?mid=" + ModuleId + "&q=" + Eval("Guid") %>'>
                                                <asp:Literal ID="litExportQuestionButton" Visible="false" EnableViewState="false" runat="server"
                                                    Text='<%# Resources.FormWizardResources.ExportQuestionButton %>'></asp:Literal>
                                            </a>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Button SkinID="DefaultButton" ID="btnFinished" CommandName="Cancel" Text='<%# Resources.FormWizardResources.DoneButton %>'
                                                runat="server" />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:Panel ID="pnlNewQuestion" CssClass="settingrow form-group mrt10" DefaultButton="btnNewQuestion" runat="server">
                            <div class="input-group mrb10">
                                <asp:DropDownList ID="ddQuestionType" runat="server"></asp:DropDownList>
                                <div class="input-group-btn">
                                    <asp:Button SkinID="DefaultButton" ID="btnNewQuestion" runat="server" />
                                    <asp:HyperLink ID="lnkEditQuestion" Visible="false" SkinID="DefaultButton"
                                        Text="<%$Resources:FormWizardResources, BulkEditQuestionsLink %>"
                                        ToolTip="<%$Resources:FormWizardResources, BulkEditQuestionsLink %>" runat="server" />
                                </div>
                            </div>
                            <asp:HiddenField ID="hdnPageNumber" Value="1" runat="server" />
                            <asp:Literal id="litHiddenEditLinks" runat="server" />
                        </asp:Panel>
                        <div id="pnlPager" runat="server">
                            <portal:gbCutePager ID="pgr" runat="server" />
                        </div>
                        <asp:ImageButton ID="btnReloadGreyBox" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="settingrow form-group">
                    <gb:SiteLabel ID="lblTotalPagesLabel" runat="server" ForControl="txtTotalPages" CssClass="settinglabel control-label col-sm-2"
                        ConfigKey="TotalPagesLabel" ResourceFile="FormWizardResources" />
                    <div class="col-sm-10">
                        <asp:TextBox ID="txtTotalPages" CssClass="form-control" Text="1" runat="server" />
                    </div>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane fade" id="tab2">
                <asp:UpdatePanel ID="up" runat="server">
                    <ContentTemplate>
                        <telerik:RadTabStrip ID="tabLanguage" OnTabClick="tabLanguage_TabClick" 
                            EnableEmbeddedSkins="false" EnableEmbeddedBaseStylesheet="false" 
                            CssClass="subtabs" SkinID="SubTabs" Visible="false" SelectedIndex="0" runat="server" />
                        <div class="form-horizontal">
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblInstructions" runat="server" CssClass="settinglabel control-label col-sm-2"
                                    ConfigKey="InstructionsMessageLabel" ResourceFile="FormWizardResources" />
                                <div class="col-sm-10">
                                    <gbe:EditorControl ID="edInstructions" runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblThankYou" runat="server" CssClass="settinglabel control-label col-sm-2"
                                    ConfigKey="ThankYouMessageLabel" ResourceFile="FormWizardResources" />
                                <div class="col-sm-10">
                                    <gbe:EditorControl ID="edThankYou" runat="server" />
                                </div>
                            </div>
                            <div class="settingrow form-group">
                                <gb:SiteLabel ID="lblRedirectUrl" runat="server" ForControl="txtRedirectUrl" CssClass="settinglabel control-label col-sm-2"
                                    ConfigKey="RedirectUrlLabel" ResourceFile="FormWizardResources" />
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtRedirectUrl" runat="server" MaxLength="255" />
                                        <portal:gbHelpLink ID="GbHelpLink1" runat="server" HelpKey="FormWizard-RedirectUrl-help" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <div id="divImportOptions" class="importoptions settingrow form-group" runat="server">
        <telerik:RadAsyncUpload ID="uploader" SkinID="radAsyncUploadSkin" MultipleFileSelection="Disabled"
            AllowedFileExtensions="config" runat="server" />
        <%--<asp:RegularExpressionValidator ID="regexFile" runat="server" ControlToValidate="uploader"
            ValidationExpression="/^.*\.(config)$/i" Display="Dynamic" ValidationGroup="upload" />
        <asp:RequiredFieldValidator ID="reqFile" runat="server" ControlToValidate="uploader"
            Display="Dynamic" CssClass="txterror" ValidationGroup="upload" />--%>
        <asp:Button SkinID="DefaultButton" ID="btnImportForm" ValidationGroup="upload" runat="server" />
        <asp:Button SkinID="DefaultButton" ID="btnImportQuestion" ValidationGroup="upload" runat="server" />
        <asp:Button SkinID="DefaultButton" ID="btnExportForm" runat="server" />
    </div>
</div>