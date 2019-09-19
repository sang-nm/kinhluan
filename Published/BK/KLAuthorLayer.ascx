<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KLAuthorLayer.ascx.cs" Inherits="CanhCam.Web.CustomUI.KLAuthorLayer" %>
<div class="row flex flex-wrap">
    <div class="col-xs-12 col-md-5 col-lg-4">
        <div class="author-info">
            <figure>
                <div class="item-img">
                    <img src="<%= getAuthorImage(author.UserID, author.Avatar)%>" alt="">
                </div>
                <figcaption>
                    <div class="item-name"><%=author.Name %></div>
                    <div class="item-social"><a href="<%=author.LinkFacebook %>"><i class="fa fa-facebook" aria-hidden="true"></i></a><a href="<%=author.LinkTwitter %>"><i class="fa fa-twitter" aria-hidden="true"></i></a><a href="<%=author.LinkPinterest %>"><i class="fa fa-pinterest-p" aria-hidden="true"></i></a><a href="<%=author.LinkInstagram %>"><i class="fa fa-instagram" aria-hidden="true"></i></a></div>
                    <div class="item-post">
                        <span>Articles: </span>
                        <div class="number"><%=author.ArticleCount %></div>
                    </div>
                </figcaption>
            </figure>
        </div>
    </div>
    <div class="col-xs-12 col-md-7 col-lg-8 col-right">
        <div class="pagetitle">About me</div>
        <div class="aboutme-content content">
            <p>Love to travel and have taken time to experience life in many countries. I made this website to share useful information with the community. If you have the same hobby, please connect with me. I wish you success! Best regards!</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quos, asperiores dicta eum alias quis hic! Omnis eveniet quasi necessitatibus voluptates animi explicabo! Nisi maiores obcaecati temporibus dolor, quae voluptates quibusdam.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi alias iste, temporibus quia nihil hic veritatis quidem, libero error id.</p>
        </div>
    </div>
</div>
<section class="author-nav">
    <ul>
        <li id="nav1" runat="server"><a href="<%= getCatUrl(author.AuthorID,"Articles") %>">Articles</a></li>
        <li id="nav2" runat="server"><a href="<%= getCatUrl(author.AuthorID,"Books") %>">Books</a></li>
        <li id="nav3" runat="server"><a href="<%= getCatUrl(author.AuthorID,"Gratitude") %>">Gratitude</a></li>
    </ul>
</section>
