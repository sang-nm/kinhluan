<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="QuestionEditor.ascx.cs"
    Inherits="CanhCam.FormWizard.Web.UI.QuestionEditor" %>
<asp:UpdatePanel ID="pnlQuestion" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div class="form-horizontal">
            <div id="divQuestionText" class="settingrow form-group" runat="server">
                <gb:SiteLabel runat="server" ConfigKey="QuestionTextLabel" ForControl="txtQuestionText"
                    ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:TextBox ID="txtQuestionText" runat="server" />
                </div>
            </div>
            <div id="divQuestionAlias" runat="server" class="settingrow form-group">
                <gb:SiteLabel runat="server" ConfigKey="QuestionAliasLabel" ForControl="txtQuestionAlias"
                    ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <div class="input-group">
                        <asp:TextBox ID="txtQuestionAlias" runat="server" />
                        <portal:gbHelpLink ID="gbHelpLink2" runat="server" HelpKey="FormWizard-EnableQuestionAliases-help" />
                    </div>
                </div>
            </div>
            <div id="divControlSrc" visible="false" class="settingrow form-group" runat="server">
                <gb:SiteLabel runat="server" ID="lblRegexExpression" ConfigKey="ControlSourceLabel" ForControl="txtControlSrc"
                    ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:TextBox ID="txtControlSrc" runat="server" />
                </div>
            </div>
            <div id="divRequired" class="settingrow form-group" runat="server">
                <gb:SiteLabel runat="server" ConfigKey="AnswerRequiredLabel" ForControl="chkAnswerRequired"
                    ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:CheckBox ID="chkAnswerRequired" runat="server" />
                </div>
            </div>
            <asp:Panel ID="pnlRegex" Visible="false" runat="server">
                <div class="settingrow form-group">
                    <gb:SiteLabel runat="server" ConfigKey="RegexExpressionLabel" ForControl="txtRegexExpression"
                        ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtRegexExpression" runat="server" />
                    </div>
                </div>
                <div class="settingrow form-group">
                    <gb:SiteLabel runat="server" ConfigKey="InvalidRegexTextLabel" ForControl="txtInvalidText"
                        ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <asp:TextBox ID="txtInvalidText" MaxLength="255" runat="server" />
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlInstructionBlock" CssClass="settingrow form-group" Visible="false" runat="server">
                <gb:SiteLabel ID="SiteLabel2" runat="server" ConfigKey="InstructionBlockLabel" ResourceFile="FormWizardResources"
                    CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:Literal ID="litInstructions" runat="server" /><br />
                    <asp:HyperLink ID="lnkEditInstructions" CssClass="cp-link cb-editquestion" runat="server" />
                </div>
            </asp:Panel>
            <div id="divCss" class="settingrow form-group" runat="server">
                <gb:SiteLabel runat="server" ConfigKey="CssClassLabel" ForControl="txtCssClass" ResourceFile="FormWizardResources"
                    CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <div class="input-group">
                        <asp:TextBox ID="txtCssClass" CssClass="normaltextbox" runat="server" />
                        <portal:gbHelpLink ID="gbHelpLink1" runat="server" HelpKey="FormWizard-CssClass-help" />
                    </div>
                </div>
            </div>
            <div id="divQuestionType" class="settingrow form-group" runat="server">
                <gb:SiteLabel runat="server" ConfigKey="QuestionTypeLabel" ForControl="ddQuestionType"
                    ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddQuestionType" ToolTip='<%# Resources.FormWizardResources.QuestionTypeLabel %>' runat="server" />
                </div>
            </div>
            <div id="divMinRange" class="settingrow form-group" runat="server">
                <gb:SiteLabel runat="server" ConfigKey="MinRangeLabel" ForControl="ddMinRange" ResourceFile="FormWizardResources"
                    CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddMinRange" ToolTip='<%# Resources.FormWizardResources.MinRangeLabel %>' runat="server" />
                </div>
            </div>
            <div id="divMaxRange" class="settingrow form-group" runat="server">
                <gb:SiteLabel runat="server" ConfigKey="MaxRangeLabel" ForControl="ddMaxRange" ResourceFile="FormWizardResources"
                    CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddMaxRange" ToolTip='<%# Resources.FormWizardResources.MaxRangeLabel %>' runat="server" />
                </div>
            </div>
            <div id="divMaxFileSize" visible="false" class="settingrow form-group" runat="server">
                <gb:SiteLabel ID="lblMaxFileSize" runat="server" ConfigKey="MaxFileSizeLabel" ForControl="txtMaxFileSize" ResourceFile="FormWizardResources"
                    CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <div class="input-group">
                        <asp:TextBox ID="txtMaxFileSize" CssClass="normaltextbox" runat="server" />
                        <portal:gbHelpLink ID="gbHelpLink6" runat="server" HelpKey="FormWizard-tMaxFileSize-help" />
                    </div>
                </div>
            </div>
            <div id="divAllowedFileExtensions" visible="false" class="settingrow form-group" runat="server">
                <gb:SiteLabel ID="lblAllowedFileExtensions" runat="server" ConfigKey="AllowedFileExtensionsLabel" ForControl="txtAllowedFileExtensions"
                    ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <div class="input-group">
                        <asp:TextBox ID="txtAllowedFileExtensions" runat="server" />
                        <portal:gbHelpLink ID="gbHelpLink5" runat="server" HelpKey="FormWizard-AllowedFileExtensions-help" />
                    </div>
                </div>
            </div>
            <div id="divPageNumber" class="settingrow form-group" runat="server">
                <gb:SiteLabel runat="server" ConfigKey="PageNumberLabel" ForControl="ddPageNumber"
                    ResourceFile="FormWizardResources" CssClass="settinglabel control-label col-sm-3" />
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddPageNumber" ToolTip='<%# Resources.FormWizardResources.PageNumberLabel %>' runat="server" />
                </div>
            </div>
            <div class="settingrow form-group">
                <div class="col-sm-9 col-sm-offset-3">
                    <asp:HiddenField ID="hdnQuestionGuid" runat="server" />
                    <asp:Button SkinID="DefaultButton" ID="btnSave" runat="server" />
                    <asp:HyperLink ID="lnkEditOption" Visible="false" CssClass="cp-link" 
                            Text="<%$Resources:FormWizardResources, BulkEditOptionsLink %>"
                            ToolTip="<%$Resources:FormWizardResources, BulkEditOptionsLink %>" runat="server"></asp:HyperLink>
                    <asp:Literal id="litHiddenEditLinks" runat="server" />
                    <%--<asp:UpdateProgress ID="up1" runat="server" AssociatedUpdatePanelID="pnlQuestion">
                        <ProgressTemplate>
                            <img src='<%= Page.ResolveUrl("~/Data/SiteImages/indicators/indicator1.gif") %>' alt=' ' />
                        </ProgressTemplate>
                    </asp:UpdateProgress>--%>
                    <asp:CustomValidator ID="valRegex" runat="server" Display="None" CssClass="txterror"></asp:CustomValidator>
                    <%--<asp:RegularExpressionValidator ID="regexCssClass" runat="server" ControlToValidate="txtCssClass"
                        ValidationExpression="^([\\s]?[a-zA-Z]+[_\\-a-zA-Z0-9]+)*\\z+" Display="Dynamic" />--%>
                </div>
            </div>
            <div id="divOptions" runat="server">
                <div class="settingrow form-group">
                    <gb:SiteLabel runat="server" ConfigKey="OptionsHeading" ResourceFile="FormWizardResources"
                        CssClass="settinglabel control-label col-sm-3" />
                    <div class="col-sm-9">
                        <div class="input-group">
                            <asp:ListBox ID="lbOptions" CssClass="listbox" Style="min-width: 120px" Rows="10" runat="server" />
                            <div class="input-group-addon">
                                <ul class="nav sorter">
                                    <li><asp:LinkButton ID="btnOptionUp" runat="server"><i class="fa fa-angle-up"></i></asp:LinkButton></li>
                                    <li><asp:LinkButton ID="btnOptionDown" runat="server"><i class="fa fa-angle-down"></i></asp:LinkButton></li>
                                    <li><asp:LinkButton ID="btnOptionEdit" runat="server"><i class="fa fa-edit"></i></asp:LinkButton></li>
                                    <li><asp:LinkButton ID="btnOptionDelete" runat="server"><i class="fa fa-trash-o"></i></asp:LinkButton></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="divAddOption" class="settingrow form-group" runat="server">
                <div class="col-sm-9 col-sm-offset-3">
                    <div class="row">
                        <div class="col-sm-6">
                            <asp:TextBox ID="txtNewOption" placeholder="<%$Resources:FormWizardResources, Display %>" MaxLength="255" runat="server" />
                        </div>
                        <div class="col-sm-6">
                            <div class="input-group">
                                <asp:TextBox ID="txtOptionValue" placeholder="<%$Resources:FormWizardResources, ValueAlias %>" MaxLength="255" runat="server" />
                                <div class="input-group-btn">
                                    <asp:Button SkinID="DefaultButton" ID="btnAddOption" runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--<portal:gbHelpLink ID="gbHelpLink3" runat="server" HelpKey="FormWizard-EnableOptionAliases-help" />--%>
                </div>
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>