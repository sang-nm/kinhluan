<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KLGratitudePage.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLGratitudePage" %>

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
                            <img src="<%= getGuestImage(getUserID(g.AuthorID), g.Avatar) %>" alt="guest avatar">
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-10">
                        <figcaption>
                            <div class="item-content"><%= g.Comment %></div>
                            <%--<div class="item-content"> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Delectus eos aliquid, sunt, illum tempora maiores. Architecto perferendis ipsum cumque quam amet nihil id dolor nisi debitis reprehenderit, earum, ipsam similique possimus. Vel a vero corporis consequuntur itaque, veritatis quia, in voluptate iure voluptas fugit quasi id nesciunt. Obcaecati, dolorum, blanditiis.</div>--%>
                            <time><%= g.CreateUtc %></time>
                            <div class="item-name"><%= g.Name %></div>
                        </figcaption>
                    </div>
                </figure>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>
