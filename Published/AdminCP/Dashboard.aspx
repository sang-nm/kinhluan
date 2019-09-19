<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="Dashboard.aspx.cs" Inherits="CanhCam.Web.AdminUI.DashboardPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div id="divAdminMenu" runat="server" class="workplace">
            <div class="metromini">
                <div class="row">
                    <div class="col-sm-12">
                        <asp:Repeater ID="rptMenuItems" runat="server">
                            <ItemTemplate>
                                <div class="item">
                                    <asp:Literal ID="litMenuItem" runat="server" />
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />