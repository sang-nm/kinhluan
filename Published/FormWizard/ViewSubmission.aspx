<%@ Page ValidateRequest="false" Language="c#" CodeBehind="ViewSubmission.aspx.cs" MasterPageFile="~/App_MasterPages/layout.Master"
    AutoEventWireup="false" Inherits="CanhCam.FormWizard.Web.UI.ViewSubmissionPage" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:HeadingControl ID="heading" runat="server" />
    <div class="settingrow form-group">
        <asp:Button SkinID="DeleteButton" ID="btnDelete" Text="<%$Resources:FormWizardResources, DeleteResponseButton %>" runat="server" />
        <asp:Literal ID="litTimestamp" runat="server" />
    </div>
    <div class="formwizardresults">
        <NeatHtml:UntrustedContent ID="UntrustedContent1" runat="server" EnableViewState="false"
            TrustedImageUrlPattern='<%# CanhCam.Web.Framework.SecurityHelper.RegexRelativeImageUrlPatern %>' ClientScriptUrl="~/ClientScript/NeatHtml.js">
            <asp:Literal ID="litResult" runat="server"></asp:Literal>
        </NeatHtml:UntrustedContent>
    </div>
    <div id="divAttachments" runat="server">
        <telerik:RadGrid ID="grdAttachments" SkinID="radGridSkin" runat="server">
            <MasterTableView DataKeyNames="RowGuid" AllowPaging="false">
                <Columns>
                    <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <%# Eval("FileName") %>
                            <asp:HyperLink ID="lnkDownload" runat="server" EnableViewState="false" 
                                    ImageUrl='<%# upLoadPath + "/Data/SiteImages/Download.gif" %>' 
                                    NavigateUrl='<%# ImageBaseUrl + Eval("ServerFileName") %>' 
                                    ToolTip='<%# Resources.FormWizardResources.DownloadLink %>' />
                            <asp:Button SkinID="DeleteButton" ID="btnDelete" runat="server" CommandName="delete" CommandArgument='<%# Eval("RowGuid") %>'
                                Text='<%# Resources.FormWizardResources.DeleteResponseButton %>' />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
</asp:Content>