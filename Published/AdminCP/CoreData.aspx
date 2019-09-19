<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="CoreData.aspx.cs" Inherits="CanhCam.Web.AdminUI.CoreDataPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, CoreDataAdministrationLink %>" CurrentPageUrl="~/AdminCP/CoreData.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="workplace">
            <div class="metromini">
                <div class="row">
                    <div class="col-sm-12">
                        <div id="divLanguageAdmin" runat="server" class="item">
                            <asp:Literal ID="litLanguageAdmin" runat="server" />
                        </div>
                        <div id="divCurrencyAdmin" runat="server" class="item">
                            <asp:Literal ID="litCurrencyAdmin" runat="server" />
                        </div>
                        <div id="divCountryAdmin" runat="server" class="item">
                            <asp:Literal ID="litCountryAdmin" runat="server" />
                        </div>
                        <div id="divGeoZoneAdmin" runat="server" class="item">
                            <asp:Literal ID="litGeoZone" runat="server" />
                        </div>
                        <div id="divTaxClassAdmin" runat="server" class="item">
                            <asp:Literal ID="litTaxClassAdmin" runat="server" />
                        </div>
                        <div id="divTaxRateAdmin" runat="server" class="item">
                            <asp:Literal ID="litTaxRateAdmin" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
