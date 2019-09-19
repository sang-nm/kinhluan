<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="SecurityAdvisor.aspx.cs" Inherits="CanhCam.Web.AdminUI.SecurityAdvisorPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:Resource, SecurityAdvisor %>" CurrentPageUrl="~/AdminCP/SecurityAdvisor.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="workplace">
            <p class="sadvisorintro">
                <asp:Literal ID="litInfo" runat="server" />
            </p>
            <ul class="simplelist">
                <li>
                    <gb:SiteLabel ID="SiteLabel5" runat="server" CssClass="" ConfigKey="UsingACustomMachineKey"
                        UseLabelTag="false" />
                    <asp:Image ID="imgMachineKeyOk" runat="server" Visible="false" />
                    <gb:SiteLabel ID="lblMachineKeyGood" runat="server" CssClass="goodsecurity" ConfigKey="OKLabel"
                        UseLabelTag="false" Visible="false" />
                    <asp:Image ID="imgMachineKeyDanger" runat="server" Visible="false" />
                    <gb:SiteLabel ID="lblMachineKeyBad" runat="server" CssClass="txterror verybadsecurity"
                        ConfigKey="SecurityDangerLabel" UseLabelTag="false" Visible="false" />
                    <p>
                        <asp:TextBox ID="txtRandomMachineKey" runat="server" TextMode="MultiLine" Rows="5"
                            Columns="70" Width="100%" />
                        <asp:HyperLink CssClass="cp-link" ID="lnkMachineKeyRefresh" runat="server" Visible="false" />
                    </p>
                    <p>
                        <gb:SiteLabel ID="lblMachineKeyInstructions" runat="server" CssClass="" ConfigKey="CustomMachineKeyInstructions"
                            UseLabelTag="false" Visible="false" />
                    </p>
                </li>
                <li>
                    <asp:HyperLink CssClass="cp-link" ID="lnkCheckFolders" runat="server" />
                    <asp:Image ID="imgFileSystemOk" runat="server" Visible="false" />
                    <gb:SiteLabel ID="lblFileSystemOk" runat="server" CssClass="goodsecurity" ConfigKey="OKLabel"
                        UseLabelTag="false" Visible="false" />
                    <asp:Image ID="imgFileSystemWarning" runat="server" Visible="false" />
                    <gb:SiteLabel ID="lblFileSystemWarning" runat="server" CssClass="txterror securitywarning"
                        ConfigKey="WritePermissionsNotNeededOnFolders" UseLabelTag="false" Visible="false">
                    </gb:SiteLabel>
                    <asp:HyperLink ID="lnkFileSystemHelp" runat="server" Visible="false" />
                    <asp:Literal ID="litWritableFolderList" runat="server" />
                </li>
            </ul>
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
