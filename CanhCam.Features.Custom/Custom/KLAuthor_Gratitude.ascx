<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KLAuthor_Gratitude.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLAuthor_Gratitude" %>
<%@ Register Src="~/Custom/KLAuthorLayer.ascx" TagPrefix="portal" TagName="KLAuthorLayer" %>


<script>
    $(document).ready(function () {
        $(".guestbook-list .guestbook-item").hide();
        var pageSize = 4;
        var pageStart = 0;
        pagination(pageStart, pageSize);
        pageStart = pageSize + pageStart;
        $('.read-more').click(function (e) {
            e.preventDefault();
            pagination(pageStart, pageSize);
            pageStart = pageSize + pageStart;
        });

    });

    function pagination(pageStart, pageSize) {
        for (i = pageStart; i <= pageSize + pageStart; i++) {
            $(".guestbook-list .guestbook-item:nth-child(" + i + ")").css("display", "block");
        }
    }
</script>
<div class="container">
    <div class="author-detail-wrap">
        <portal:KLAuthorLayer runat="server" ID="KLAuthorLayer" />
        <div class="guestbook-private">
            <div class="guestbook-list">
                <%
                    foreach (var g in guests)
                    {
                %>
                <div class="guestbook-item">
                    <figure class="clearfix">
                        <div class="item-img">
                            <img src="<%= getGuestImage(g.AuthorID) %>" alt="guest avatar">
                        </div>
                        <figcaption>
                            <div class="item-content"><%= g.Comment %></div>
                            <%--<div class="item-content">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Delectus eos aliquid, sunt, illum tempora maiores. Architecto perferendis ipsum cumque quam amet nihil id dolor nisi debitis reprehenderit, earum, ipsam similique possimus. Vel a vero corporis consequuntur itaque, veritatis quia, in voluptate iure voluptas fugit quasi id nesciunt. Obcaecati, dolorum, blanditiis.</div>--%>
                            <time><%= g.CreateUtc %></time>
                            <div class="item-name"><%= getName(g.AuthorID) %></div>
                        </figcaption>
                    </figure>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <div class="gratitude-info">
            <div class="btn-viewmore">
                <a href="#" class="read-more"><span>More</span></a>
            </div>
        </div>
    </div>
</div>
