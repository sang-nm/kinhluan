<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master" CodeBehind="GlobalContentDialog.aspx.cs" Inherits="CanhCam.Web.UI.GlobalContentDialog" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server"></asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <div class="globalconentdialog">
        <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
            <MasterTableView DataKeyNames="ModuleID" AllowPaging="false">
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, ContentManagerContentTitleColumnHeader %>">
                        <ItemTemplate>
                            <%# Eval("ModuleTitle").ToString().Coalesce(Resources.Resource.ContentNoTitle)%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="<%$Resources:Resource, ContentManagerFeatureTypeColumnHeader %>">
                        <ItemTemplate>
                            <%# CanhCam.Web.Framework.ResourceHelper.GetResourceString(DataBinder.Eval(Container.DataItem, "ResourceFile").ToString(),DataBinder.Eval(Container.DataItem, "FeatureName").ToString()) %>
                            <span class="contentusecount">(<%# Eval("UseCount") %>)</span>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn HeaderText="<%$Resources:Resource, ContentManagerAuthorColumnHeader %>" DataField="CreatedBy" />
                    <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <asp:Button SkinID="DefaultButton" ID="btnSelect" Text='<%# Resources.Resource.GlobalContentDialogSelectButton %>' runat="server" CommandName="select" CommandArgument='<%# Eval("ModuleID") %>'  />
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <portal:gbCutePager ID="pgr" runat="server" />
    </div>
</asp:Content>
