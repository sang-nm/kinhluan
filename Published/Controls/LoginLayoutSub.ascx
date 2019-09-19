<%@ Control Language="C#" AutoEventWireup="false" CodeFile="LoginLayoutSub.ascx.cs" Inherits="Controls_LoginLayoutSub" %>
<div class="login">
    <%--  <div class="img"><img src="img/author/1.jpg" alt=""></div>
                            <div class="name">Nguyen Kinh Luan</div>--%>
    <%--<ul>
                                  <portal:WelcomeMessage ID="WelcomeMessage1" runat="server" WrapInProfileLink="true" ProfileLink="~/Account/UserProfile.aspx" RenderAsListItem="true" ListItemCss="firstnav" />
                                    <portal:RegisterLink ID="RegisterLink1" runat="server" RenderAsListItem="true" />
                                    <portal:LoginLink ID="LoginLink1" runat="server" RenderAsListItem="true" />
                                    <portal:LogoutLink ID="LogoutLink1" runat="server" RenderAsListItem="true" />
                              </ul>--%>
    <% SiteUser current = SiteUtils.GetCurrentSiteUser();
        if (current == null)
        {
    %>
    <ul>
        <li><a href="/author-login">Login</a></li>
        <li><a href="/register-author">Register</a></li>
    </ul>


    <%
        }
        else
        {
            KLAuthor author = null;
            try
            {
                author = KLAuthor.GetKLAuthorByUserID(current.UserId);
            }
            catch (Exception)
            {
            }

    %>


    <%
        if (author.Avatar != "")
        {
    %>
    <div class="mail">
        <i class="fa fa-envelope-o" aria-hidden="true"></i>
        <input hidden="hidden" value="<%= current.UserId %>" id="useridmail" />
        <span id="spanmailno">5</span>
        <nav class="mail-menu">
            <ul id="ul-mail">
                <li class="footer-mail"><a href="/author-mail">See More</a>/li>
            </ul>
        </nav>
    </div>
    <div class="img">
        <img src='<%= "Data/Sites/1/Author/"+author.UserID+"/"+author.Avatar %>' alt="">
        <nav class="login-menu">
            <ul>
                <li><a href="/update-Author">Update information</a></li>
                <li><a href="/Author-Change-Password">Change Password</a></li>

            </ul>
        </nav>

    </div>
    <%
        }
        else
    %>
    <div class="img">
        <img src="/Data/Sites/1/Author/Authordefault.png" alt="">
    </div>
    <%
    %>

    <div class="name">
        <ul>
            <li><a href="/author-news"><span class="nameauthor"><%= current.Name %></span></a></li>
            <li><a href="/logoff.aspx">Log Out</a></li>
        </ul>
    </div>
    <%
        }

                                  %>
</div>


<script>
    $(document).ready(function () {
        var userid = $('#useridmail').val();
        if (userid != "")
        {
            $.ajax({
                type: "POST",
                url: "/Custom/Services/NewsServices.aspx",
                data: { "method": "GetNotify", "userid": userid },
                contentType: "application/json; charset=utf-8",
                success: function (result) {
                    var temp = "";
                    $.each(result.data, function () {
                        var viewed = "";
                        if (!this.viewed)
                            viewed = "mail-nonview";
                        temp += '<li><div class="notify-mail ' + viewed+'"><div class="mail-body">><a href="' + this.notifyLink + '" class="notify-mail">' + this.notify + '</a></div>';
                        temp += '<div class="mail-footer">' + this.dateCreate +'</div></div></li>';
                    });
                    temp += '<li class="footer-mail"><div class="viewmore"><a href="/author-mail">See More</a><div>/li>';
                    $('#ul-mail').html(temp);
                },
                failure: function (errMsg) {
                    alert(errMsg);
                }
            });
        }
        
    });

</script>
