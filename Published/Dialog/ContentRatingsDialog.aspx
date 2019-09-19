<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    CodeBehind="ContentRatingsDialog.aspx.cs" Inherits="CanhCam.Web.AdminUI.ContentRatingsDialog" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
        <MasterTableView DataKeyNames="RowGuid" AllowPaging="false" AllowSorting="false">
            <Columns>
                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, Email %>" DataField="EmailAddress" />
                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, IpAddress %>" DataField="IpAddress" />
                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, Date %>">
                    <ItemTemplate>
                        <%# DateTimeHelper.Format(Convert.ToDateTime(Eval("CreatedUtc")), timeZone, "g", timeOffset) %>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, Rating %>" DataField="Rating" />
                <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, Comments %>">
                    <ItemTemplate>
                        <NeatHtml:UntrustedContent ID="UntrustedContent1" runat="server" EnableViewState="false"
                            ClientScriptUrl="~/ClientScript/NeatHtml.js">
                            <%# Eval("Comments") %>
                        </NeatHtml:UntrustedContent>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn>
                    <ItemTemplate>
                        <asp:Button ID="btnDeleteRating" runat="server" Text='<%# Resources.Resource.DeleteButton %>'
                            SkinID="DefaultButton" CommandArgument='<%# Eval("RowGuid") %>' CommandName='DeleteRating' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

    <portal:gbCutePager ID="pgr" runat="server" />
</asp:Content>
