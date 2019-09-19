<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewsDetailControl.ascx.cs" Inherits="CanhCam.Web.NewsUI.NewsDetailControl" %>

<section class="breadcrumb-wrap clearfix">
    <div style="background: url(/Data/Sites/1/breadcrumb/4.jpg) center right no-repeat; background-size: cover" class="breadcrumb-bg">
        <div class="breadcrumb-overlay"></div>
        <div class="container"></div>
    </div>
    <div class="breadcrumb-content">
        <div class="container">
            <h3 class="pagename"></h3>
            <ol itemscope itemtype="http://schema.org/BreadcrumbList" class="breadcrumb">
                <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem"><a itemscope itemtype="http://schema.org/Thing" itemprop="item" href="/home-1"><span itemprop="name">Home</span></a>
                    <meta itemprop="position" content="1">
                </li>
                <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem"><a itemscope itemtype="http://schema.org/Thing" itemprop="item" href="/blog"><span itemprop="name">News</span></a>
                    <meta itemprop="position" content="2">
                </li>
            </ol>
        </div>
    </div>
</section>
<div class="container">
    <div class="like-share <%=(currentUser!=null?"":"hidden") %>">
        <%--<a href="#" data-toggle="tooltip" data-placement="right" title="999" class="facebook"><i class="fa fa-thumbs-up" aria-hidden="true"></i></a>--%>
        <a class="share-social facebook" data-newsID="<%=News.NewsID %>" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=<%= siteRoot + "/news-detail?newsID=" + News.NewsID%>" data-placement="right"><i class="fa fa-share-alt" aria-hidden="true"></i></a>
        <a class="share-social twitter" data-newsID="<%=News.NewsID %>" target="_blank" href="https://twitter.com/home?status=<%= siteRoot + "/news-detail?newsID=" + News.NewsID%>" data-toggle="tooltip" data-placement="right"><i class="fa fa-twitter" aria-hidden="true"></i></a>
        <a class="share-social google" data-newsID="<%=News.NewsID %>" target="_blank" href="https://plus.google.com/share?url=<%= siteRoot + "/news-detail?newsID=" + News.NewsID%>" data-toggle="tooltip" data-placement="right"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
    </div>
    <div class="news-detail-wrap">
        <div class="row flex flex-wrap">
            <div class="col-xs-12 col-lg-9">
                <section class="news-detail-left clearfix">
                    <div class="newsdetail-time">
                        <time><%=News.StartDate.ToString("dd/MM/yyyy") %></time>
                        <span class="author-name"><%=Author.Name %></span>
                    </div>
                    <h1 class="newsdetail-name"><%=News.Title %></h1>
                    <div class="by-author">
                        <span>Approved by</span>
                        <h2><%=News.ApprovedBy %></h2>
                    </div>
                    <div class="news-img-slide">
                        <%foreach (var slide in ListImageSlider)
                            {%>
                            <div class="item">
                                <img src="<%=slide %>" alt="">
                            </div>
                        <%} %>
                    </div>
                    <div class="banner-img">
                        <div class="img">
                            <img src="/Data/Sites/1/Banner/banner.jpg" alt="">
                        </div>
                    </div>
                    <div class="content">
                        <%=News.FullContent %>
                        <%--<p class="first">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rerum consectetur provident rem magni delectus facilis, iure eius ipsam quibusdam, aut incidunt soluta? Quis aliquid corrupti asperiores, non accusamus dolores nisi error a temporibus. Quis voluptatibus ex neque, eius corporis fuga consequuntur harum, totam deleniti, alias maxime facilis magni vel praesentium numquam ratione cumque accusamus labore culpa at aliquid. Laboriosam perspiciatis laudantium debitis nam deleniti doloremque quaerat iusto tempora dolorum? Ipsa, quidem! Nobis autem iure velit accusantium et recusandae nulla accusamus!</p>
                        <figure class="clearfix">
                            <figcaption>
                                <div class="content">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore dolorem reprehenderit adipisci saepe beatae nisi, atque perferendis aliquam illo perspiciatis eos voluptatem laborum doloremque maxime, ea sunt natus distinctio exercitationem, error porro impedit dolorum tenetur. </p>
                                </div>
                            </figcaption>
                            <div class="aboutimg">
                                <img src="/Data/Sites/1/Banner/dt1.jpg" alt="">
                            </div>
                        </figure>
                        <p class="ps"><i class="fa fa-quote-left" aria-hidden="true"></i>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Placeat cupiditate voluptates quibusdam quae explicabo pariatur tempore, aliquid ipsa.<i class="fa fa-quote-right" aria-hidden="true"></i></p>
                        <figure class="fix">
                            <div class="aboutimg">
                                <img src="/Data/Sites/1/Banner/dt1.jpg" alt="">
                            </div>
                            <figcaption>
                                <div class="content">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolore dolorem reprehenderit adipisci saepe beatae nisi, atque perferendis aliquam illo perspiciatis eos voluptatem laborum doloremque maxime, ea sunt natus distinctio exercitationem, error porro impedit dolorum tenetur. </p>
                                </div>
                            </figcaption>
                        </figure>--%>
                    </div>
                    <%--<div style="margin-top: 30px" class="comment">
                        <img src="img/comment.jpg" alt="">
                    </div>--%>
                </section>
            </div>
            <div class="col-xs-12 col-lg-3">
                <section class="news-detail-right">
                    <div class="title">About Author </div>
                    <div class="author-info">
                        <figure>
                            <div class="item-img">
                                <img src="<%=AuthorImageUrl(Author.AuthorID) %>"" alt="">
                            </div>
                            <figcaption>
                                <div class="item-name"><a href="/articles-by-author?id=<%=Author.AuthorID %>"><%=Author.Name %></a></div>
                                <div class="item-social">
                                    <a href="<%=Author.LinkFacebook%>"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                                    <a href="<%=Author.LinkTwitter %>"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                                    <a href="<%=Author.LinkPinterest %>"><i class="fa fa-pinterest-p" aria-hidden="true"></i></a>
                                    <a href="<%=Author.LinkInstagram %>"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                                </div>
                            </figcaption>
                        </figure>
                    </div>
                    <div class="title">Hot Article </div>
                    <div class="hot-news-list">

                        <%foreach (var item in HotNews)
                            {%>

                        <div class="hot-news-item">
                            <figure>
                                <a href="/news-detail?newsID=<%=item.NewsID %>" class="item-img">
                                    <img src="<%=NewsImageUrl(item.NewsID) %>"" alt=""></a>
                                <figcaption>
                                    <div class="item-title"><a href="/news-detail?newsID=<%=item.NewsID %>"><%=item.Title %></a></div>
                                </figcaption>
                            </figure>
                        </div>

                        <%} %>
                    </div>
                </section>
            </div>
        </div>
    </div>
</div>