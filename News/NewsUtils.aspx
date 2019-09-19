<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="NewsUtils.aspx.cs" Inherits="CanhCam.Web.NewsUI.NewsUtilsPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <portal:BreadcrumbAdmin ID="breadcrumb" runat="server" 
        CurrentPageTitle="<%$Resources:NewsResources, NewsList %>" CurrentPageUrl="~/News/NewsList.aspx" />
    <div class="admin-content col-md-12">
        <portal:HeadingPanel ID="heading" runat="server"></portal:HeadingPanel>
        <div class="workplace">
            <div class="mrt10 mrb10">
                Connection String:<br /><asp:TextBox ID="txtConnectionString" Width="500" Text="server=web;UID=sa;PWD=cant0N@;database=sahuynhoil.gb" runat="server"></asp:TextBox>
            </div>
            <div class="mrt10 mrb10">
                Ngôn ngữ:<br />
                <asp:DropDownList ID="ddlLanguage" runat="server">
                    <asp:ListItem Text="Tiếng Việt" Value="2"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="mrt10 mrb10">
                Chuyên mục:<br />
                <asp:DropDownList ID="ddlZone" runat="server">
                    <asp:ListItem Text="Thắng cảnh du lịch - Tham quan &amp; Du ngoạn" Value="87" rel="100"></asp:ListItem>
                    <asp:ListItem Text="Thắng cảnh du lịch - Ẩm thực - Đặc sản" Value="88" rel="101"></asp:ListItem>
                    <asp:ListItem Text="Thắng cảnh du lịch - Thông tin cần biết" Value="90" rel="102"></asp:ListItem>
                    <asp:ListItem Text="Văn học nghệ thuật - Kỷ niệm - Hồi ức" Value="92" rel="111"></asp:ListItem>
                    <asp:ListItem Text="Văn học nghệ thuật - Hát về Sa Huỳnh" Value="93" rel="103"></asp:ListItem>
                    <asp:ListItem Text="Văn học nghệ thuật - Thơ Trần Cao Duyên" Value="94" rel="104"></asp:ListItem>
                    <asp:ListItem Text="Văn học nghệ thuật - Tản mạn" Value="95" rel="112"></asp:ListItem>
                    <asp:ListItem Text="Tin quê nhà - Theo dòng thời sự" Value="97" rel="109"></asp:ListItem>
                    <asp:ListItem Text="Tin quê nhà - Phóng sự - Ký sự" Value="98" rel="110"></asp:ListItem>
                    <asp:ListItem Text="Tin quê nhà - Chuyện đời thường" Value="99" rel="116"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <asp:Button SkinID="DefaultButton" ID="btnImport" Text="Import" runat="server" CausesValidation="false" />
        </div>
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
