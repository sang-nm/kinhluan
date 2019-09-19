<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLAuthorMail.ascx.cs" Inherits="CanhCam.Web.CustomUI.KLAuthorMail" %>

<%@ Register Src="~/Custom/LeftMenu.ascx" TagPrefix="portal" TagName="LeftMenu" %>
<div class="container">
    <div class="row flex flex-wrap">
        <div class="col-xs-12 col-lg-3">
            <portal:LeftMenu runat="server" ID="LeftMenu" />
        </div>
        <div class="col-xs-12 col-lg-9">
            <section class="user-page clearfix">
                <div class="row flex flex-wrap">
                            <portal:NotifyMessage ID="message" runat="server" />
                    <div class="col-xs-12">
                        <div class="row">
                            <ul class="ul-notify">
                                <asp:Repeater ID="rptnotify" runat="server" OnItemCommand="rptnotify_ItemCommand" >
                                    <ItemTemplate>
                                        <li>
                                            <div class="notify">
                                                <a href="<%# Eval("NotifyLink") %>">
                                                    <div class="notify-body">
                                                        <%# Eval("UserName_Action") +" "+Eval("Notify") %>
                                                    </div>
                                                    <div class="notify-footer">
                                                        <%# Eval("DateCreate") %>
                                                    </div>
                                                    <asp:HiddenField ID="hdnotifyid" Value='<%# Eval("Notifyid") %>' runat="server" />
                                                    <div class="notify-remove"><asp:Button runat="server" CommandName="Remove" ID="btnremove" Text="Remove" /></div>
                                                </a>
                                            </div>

                                        </li>

                                    </ItemTemplate>
                                </asp:Repeater>


                            </ul>
                            <div class="pages">
            <ul class="pagination">
                <%
                    if (totalPage > 1)
                    {
                %>
                    <%
                        if (pagenum > 1)
                        {
                    %>
                            <li id="previous"><a href="<%=siteRoot+"?page=" +(pagenum-1) %>"><<</a></li>
                    <%
                        }
                    %>

                    <%  for (int i = 1; i <= totalPage; i++)
                        {
                    %>
                            <li class="<%=(pagenum == i ? "active" : "") %>"><a href="<%=siteRoot + "?page=" + i %>"><%=i %></a></li>
                    <%
                        }
                        if (pagenum < totalPage)
                        {
                    %>
                            <li id="previous"><a href="<%=siteRoot+"?page=" +(pagenum+1) %>">>></a></li>
                <%
                        }
                    }
                %>
            </ul>
        </div>

                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
