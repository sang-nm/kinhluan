<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="KLGratitudePage.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLGratitudePage" %>


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

<div class="guestbook-page">
    <div class="container">
        <h1 class="pagetitle">Gratitude</h1>
        <div class="guestbook-list">
            <%
                foreach (var g in guest)
                {
            %>
            <div class="guestbook-item">
                <figure class="row flex flex-wrap">
                    <div class="col-xs-12 col-md-2">
                        <div class="item-img">
                            <img src="<%= getGuestImage(g.AuthorID) %>" alt="guest avatar">
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-10">
                        <figcaption>
                            <div class="item-content"><%= g.Comment %></div>
                            <%--<div class="item-content"> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Delectus eos aliquid, sunt, illum tempora maiores. Architecto perferendis ipsum cumque quam amet nihil id dolor nisi debitis reprehenderit, earum, ipsam similique possimus. Vel a vero corporis consequuntur itaque, veritatis quia, in voluptate iure voluptas fugit quasi id nesciunt. Obcaecati, dolorum, blanditiis.</div>--%>
                            <time><%= g.CreateUtc %></time>
                            <div class="item-name"><%= getName(g.AuthorID) %></div>
                        </figcaption>
                    </div>
                </figure>
            </div>
            <%
                }
            %>
        </div>
        <div class="gratitude-info">
            <div class="btn-viewmore">
                <a href="#" class="read-more"><span>More</span></a>
            </div>
        </div>
    </div>
</div>
