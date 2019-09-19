<%@ Page ValidateRequest="false" Language="c#" CodeBehind="FormResultsBrowse.aspx.cs" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    AutoEventWireup="false" Inherits="CanhCam.FormWizard.Web.UI.FormResultsBrowsePage" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <portal:gbCutePager ID="pgr" runat="server" />
    <div class="mrt10 mrb10">
        <asp:Button SkinID="DefaultButton" ID="btnDelete" runat="server" />
        <asp:Literal ID="litTimestamp" runat="server"></asp:Literal>
    </div>
    <div class="formwizardresults">
        <NeatHtml:UntrustedContent ID="UntrustedContent1" runat="server" EnableViewState="false"
            TrustedImageUrlPattern='<%# CanhCam.Web.Framework.SecurityHelper.RegexRelativeImageUrlPatern %>' ClientScriptUrl="~/ClientScript/NeatHtml.js">
            <asp:Literal ID="litResult" runat="server"></asp:Literal>
        </NeatHtml:UntrustedContent>
    </div>
    <div id="divAttachments" runat="server">
        <telerik:RadGrid ID="grdAttachments" SkinID="radGridSkin" runat="server">
            <MasterTableView DataKeyNames="RowGuid" AllowSorting="false">
                <Columns>
                    <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <%# Eval("FileName") %>
                            <asp:HyperLink ID="lnkDownload" runat="server" EnableViewState="false" 
                                    ImageUrl='<%# this.ImageBaseUrl + "/Data/SiteImages/Download.gif" %>' 
                                    NavigateUrl='<%# upLoadPath + Eval("ServerFileName") %>' 
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