<%@ Page ValidateRequest="false" Language="c#" CodeBehind="FormResultsGrid.aspx.cs" MasterPageFile="~/App_MasterPages/DialogMaster.Master"
    AutoEventWireup="false" Inherits="CanhCam.FormWizard.Web.UI.FormResultsGridPage" %>

<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <telerik:RadGrid ID="grdResults" SkinID="radGridSkin" runat="server">
                <MasterTableView DataKeyNames="Code" AllowSorting="false" AutoGenerateColumns="true">
                    <Columns>
                        
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>