<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="TopPane.ascx.cs" Inherits="CanhCam.Web.AdminUI.TopPane" %>

<header>
    <div id="header" class="clearfix resize">
        <nav class="navbar navbar-default" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <i class="fa fa-bars"></i>
                    </button>
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbarsubCMS" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <i class="fa fa-bars"></i>
                    </button>
                    <asp:HyperLink ID="hplLogo" CssClass="navbar-brand" ImageUrl="~/Data/logos/logo.png" runat="server" />
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <nav>
                        <ul class="hidden-xs nav navbar-nav">
                            <li class="ctlons">
                                <a id="menu-toggle"><i class="fa fa-bars"></i><em class="fa fa-caret-down"></em></a>
                            </li>
                        </ul>
                        <ul class="hidden-xs hidden-sm nav navbar-nav navbar-right">
                            <asp:Repeater ID="rptLanguage" runat="server">
                                <ItemTemplate>
                                    <li>
                                        <asp:LinkButton ID="lkbLanguage" CssClass="language" runat="server" Text='<%#Eval("TwoLetterCode")%>' 
                                            CommandArgument='<%#Eval("LanguageCode")%>' CommandName="ChangeLanguage" />
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                            <li class="dropdown author">
                                <a href="javascript:return false;" class="dropdown-toggle" role="button" aria-expanded="false">
                                    <portal:Avatar ID="userAvatar" runat="server" />
                                </a>
                                <div class="dropdown-menu" role="menu">
                                    <div class="media clearfix">
                                        <div class="title">
                                            <portal:WelcomeMessage ID="WelcomeMessage1" WrapInProfileLink="true" runat="server" />
                                        </div>
                                        <a class="media-left" href="javascript:return false;">
                                            <portal:Avatar ID="userAvatar2" runat="server" />
                                        </a>
                                        <div class="media-body">
                                            <nav>
                                                <ul class="nav">
                                                    <portal:UserProfileLink ID="UserProfileLink" IconCssClass="fa fa-user" RenderAsListItem="true" runat="server" />
                                                    <portal:LogoutLink ID="LogoutLink" IconCssClass="fa fa-sign-out" RenderAsListItem="true" runat="server" />
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <asp:Xml ID="xmlTopMenu" runat="server"></asp:Xml>
                    </nav>
                </div>
            </div>
        </nav>
    </div>
    <div id="subheader" class="hidden-xs">
        <nav class="navbarsub navbar-default" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbarsub" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <i class="fa fa-bars"></i>
                    </button>
                    <div class="navbar-brand"></div>
                </div>
                <div id="navbarsub" class="navbar-collapse collapse">
                    <nav>
                        <ul class="nav navbar-nav">
                            <li>
                                <portal:HomeLink ID="HomeLink1" IconCssClass="fa fa-home" runat="server" />
                            </li>
                            <asp:Repeater ID="rptQuickLink" runat="server">
                                <ItemTemplate>
                                    <li>
                                        <a target='<%# Convert.ToBoolean(Eval("OpenInNewWindow")) ? "_blank" : "_self" %>'
                                           href='<%# BuildMenuLink(Eval("Url").ToString()) %>'>
                                            <%# ResourceHelper.GetResourceString(Eval("ResourceFile").ToString(), Eval("KeyName").ToString()) %>
                                        </a>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </nav>
                </div>
            </div>
        </nav>
    </div>
</header>