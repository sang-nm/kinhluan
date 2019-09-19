<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HomeControl.ascx.cs" Inherits="CanhCam.Web.NewsUI.HomeControl" %>

<%--<asp:ScriptManager ID="ScriptManager" runat="server">
    <Services>
        <asp:ServiceReference path="~/NewsService.asmx"/>
    </Services>
</asp:ScriptManager>--%>
<section class="bannerwrap clearfix">
    <div id="bannerwrap" class="rev_slider_wrapper fullscreen-container">
        <div id="banner001" data-version="5.1.1RC" class="rev_slider fullscreenbanner">
            <ul>
                <li data-transition="crossfade">
                    <img src="/Data/Sites/1/Banner/1.jpg" alt="" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat" data-bgparallax="5" data-no-retina>
                    <div data-x="['center','center','center','center']" data-hoffset="['0','0','0','0']" data-y="['center','center','center','center']" data-voffset="['0','0','0','0']" data-width="['400','400','400','400']" data-height="none" data-whitespace="normal" data-transform_idle="o:1;" data-transform_in="y:[100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0;s:2000;e:Power2.easeInOut;" data-transform_out="auto:auto;s:1000;" data-mask_in="x:0px;y:[100%];" data-start="500" data-splitin="none" data-splitout="none" data-responsive_offset="on" style="z-index: 10" class="tp-caption tp-resizeme skrollable skrollable-after">
                        <div class="banner-caption">Top 5 reasons why you NEED to visit Sapa this year!<a href="#">View more</a></div>
                    </div>
                </li>
                <li data-transition="crossfade">
                    <img src="/Data/Sites/1/Banner/2.jpg" alt="" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat" data-bgparallax="5" data-no-retina>
                    <div data-x="['center','center','center','center']" data-hoffset="['0','0','0','0']" data-y="['center','center','center','center']" data-voffset="['0','0','0','0']" data-width="['400','400','400','400']" data-height="none" data-whitespace="normal" data-transform_idle="o:1;" data-transform_in="y:[100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0;s:2000;e:Power2.easeInOut;" data-transform_out="auto:auto;s:1000;" data-mask_in="x:0px;y:[100%];" data-start="500" data-splitin="none" data-splitout="none" data-responsive_offset="on" style="z-index: 10" class="tp-caption tp-resizeme skrollable skrollable-after">
                        <div class="banner-caption">Top 5 reasons why you NEED to visit Sapa this year!<a href="#">View more</a></div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</section>
<section class="home-lastnews center">
    <div class="container">
        <h2 class="pagetitle center">THE LATEST & GREATEST</h2>
        <div class="news-list">
            <div class="row flex flex-wrap">
                <%int count = 1; %>
                <%foreach (var item in lstNewsTop5)
                    {
                        if (count == 1)
                        {%>
                <div class="col-xs-12 col-md-12 col-lg-8">
                    <div class="news-item <%=((item.LikeCount + item.ShareCount) <= 100 ? "level-1" : (item.LikeCount + item.ShareCount) > 100 && (item.LikeCount + item.ShareCount) <= 500 ? "level-2" : "level-3")%> item-big">
                        <figure>
                            <a href="/news-detail?newsID=<%=item.NewsID %>" class="item-img">
                                <img src="<%=NewsImageUrl(item.NewsID) %>" alt=""></a>
                            <figcaption>
                                <h2 class="item-title"><a href="/news-detail?newsID=<%=item.NewsID %>"><%=item.Title %></a></h2>
                                <div class="wrap-up clearfix">
                                    <div class="item-author">
                                        <div class="img">
                                            <img src="<%=AuthorImageUrl(item.AuthorID) %>" alt="">
                                        </div>
                                        <div class="text">
                                            <div class="name"><%=GetAuthorName(item.AuthorID) %></div>
                                            <time><%=item.StartDate %></time>
                                        </div>
                                    </div>
                                    <div class="item-button <%=(currentUser!=null?"":"hidden") %>">
                                        <a class="like-news <%=(CheckLiked(item.NewsID)?"liked":"") %>" data-newsID="<%=item.NewsID %>" href="#"><i class="fa fa-heart-o" aria-hidden="true"></i></a>
                                    </div>
                                </div>
                                <div class="wrap-bottom clearfix">
                                    <div class="item-likeshare"><span><%=item.Viewed %> <i class="fa fa-eye" aria-hidden="true"></i></span><span><%=item.ShareCount %> <i class="fa fa-share-alt" aria-hidden="true"></i></span></div>
                                </div>
                            </figcaption>
                        </figure>
                    </div>
                </div>
                <%
                        count++;
                    }
                    else
                    {%>
                <div class="col-xs-12 col-md-6 col-lg-4">
                    <div class="news-item pin <%=((item.LikeCount + item.ShareCount) <= 100 ? "level-3" : (item.LikeCount + item.ShareCount) > 100 && (item.LikeCount + item.ShareCount) <= 500 ? "level-2" : "level-1")%>">
                        <figure>
                            <a href="/news-detail?newsID=<%=item.NewsID %>" class="item-img">
                                <img src="<%=NewsImageUrl(item.NewsID) %>" alt=""></a>
                            <figcaption>
                                <h2 class="item-title"><a href="/news-detail?newsID=<%=item.NewsID %>"><%=item.Title %></a></h2>
                                <div class="wrap-up clearfix">
                                    <div class="item-author">
                                        <div class="img">
                                            <img src="<%=AuthorImageUrl(item.AuthorID) %>" alt="">
                                        </div>
                                        <div class="text">
                                            <div class="name"><%=GetAuthorName(item.AuthorID) %></div>
                                            <time><%=item.StartDate %></time>
                                        </div>
                                    </div>
                                    <div class="item-button <%=(currentUser!=null?"":"hidden")%>">
                                        <a class="like-news <%=(CheckLiked(item.NewsID)?"liked":"") %>" data-newsID="<%=item.NewsID %>" href="#"><i class="fa fa-heart-o" aria-hidden="true"></i></a>
                                    </div>
                                </div>
                                <div class="wrap-bottom clearfix">
                                    <div class="item-likeshare"><span><%=item.Viewed %> <i class="fa fa-eye" aria-hidden="true"></i></span><span><%=item.ShareCount %> <i class="fa fa-share-alt" aria-hidden="true"></i></span></div>
                                    <ul class="item-categories">
                                        <%foreach (var type in GetNewsType(item.NewstypeID))
                                            {%>
                                        <li><a href="/blog?typeId=<%=type.NewsTypeID %>"><%=type.Name %></a></li>
                                        <%} %>
                                    </ul>
                                </div>
                            </figcaption>
                        </figure>
                    </div>
                </div>
                <%} %>
                <%} %>
            </div>
        </div>
    </div>
</section>
<section class="home-hotnews">
    <div class="container">
        <h2 class="pagetitle center">Most view of the week</h2>
        <div class="hot-news-list">
            <%int i = 1; %>
            <%foreach (var nw in lstNewsMostOfWeek)
                {
                    if (i == 1)
                    {%>
            <div class="news-col">
                <div class="news-item tall">
                    <figure>
                        <a href="/news-detail?newsID=<%=nw.NewsID%>" style="background: url('<%=NewsImageUrl(nw.NewsID)%>') center center no-repeat; background-size: cover" class="item-img"></a>
                        <figcaption>
                            <h2 class="item-title"><a href="/news-detail?newsID=<%=nw.NewsID %>"><%=nw.Title %></a></h2>
                            <div class="item-des"><%=nw.Title %></div>
                        </figcaption>
                    </figure>
                </div>
            </div>
            <%i++;
                }
                else if (i > 1 && i < 5)
                {
                    if (i == 2)
                    {%>
                    <div class="news-col">
                     <div class="news-item">
                        <figure>
                            <a href="/news-detail?newsID=<%=nw.NewsID%>" style="background: url('<%=NewsImageUrl(nw.NewsID)%>') center center no-repeat; background-size: cover" class="item-img"></a>
                            <figcaption>
                                <h2 class="item-title"><a href="/news-detail?newsID=<%=nw.NewsID %>"><%=nw.Title %></a></h2>
                                <div class="item-des"><%=nw.Title %></div>
                            </figcaption>
                        </figure>
                    </div>
                    <%i++;
                    }
                    else if (i == 3)
                    {%>
                         <div class="news-item width50">
                    <figure>
                        <a href="/news-detail?newsID=<%=nw.NewsID%>" style="background: url('<%=NewsImageUrl(nw.NewsID)%>') center center no-repeat; background-size: cover" class="item-img"></a>
                        <figcaption>
                            <h2 class="item-title"><a href="/news-detail?newsID=<%=nw.NewsID %>"><%=nw.Title %></a></h2>
                            <div class="item-des"><%=nw.Title %></div>
                        </figcaption>
                    </figure>
                </div>
                    <%i++;
                    }
                    else
                    { %>
                         <div class="news-item width50">
                            <figure>
                                <a href="/news-detail?newsID=<%=nw.NewsID%>" style="background: url('<%=NewsImageUrl(nw.NewsID)%>') center center no-repeat; background-size: cover" class="item-img"></a>
                                <figcaption>
                                    <h2 class="item-title"><a href="/news-detail?newsID=<%=nw.NewsID %>"><%=nw.Title %></a></h2>
                                    <div class="item-des"><%=nw.Title %></div>
                                </figcaption>
                            </figure>
                        </div>
                     </div>
                <% i++;
                }%>

            <%}
                else
                {
                    if (i == 5)
                    {
            %>
            <div class="news-col">
                <div class="news-item">
                    <figure>
                        <a href="/news-detail?newsID=<%=nw.NewsID%>" style="background: url('<%=NewsImageUrl(nw.NewsID)%>') center center no-repeat; background-size: cover" class="item-img"></a>
                        <figcaption>
                            <h2 class="item-title"><a href="/news-detail?newsID=<%=nw.NewsID %>"><%=nw.Title %></a></h2>
                            <div class="item-des"><%=nw.Title %></div>
                        </figcaption>
                    </figure>
                </div>
                <%i++;
                    }
                    else if(i==6)
                    {%>
                    <div class="news-item">
                        <figure>
                            <a href="/news-detail?newsID=<%=nw.NewsID%>" style="background: url('<%=NewsImageUrl(nw.NewsID)%>') center center no-repeat; background-size: cover" class="item-img"></a>
                            <figcaption>
                                <h2 class="item-title"><a href="/news-detail?newsID=<%=nw.NewsID %>"><%=nw.Title %></a></h2>
                                <div class="item-des"><%=nw.Title %></div>
                            </figcaption>
                        </figure>
                    </div>
                </div>
            <%} %>

            <%} %>
            <%} %>
        </div>
    </div>
</section>
<section class="home-banner-era">
    <div class="container">
        <div class="banner-content">
            <img src="/Data/Sites/1/Banner/banner1.jpg" alt="">
        </div>
    </div>
</section>
<section class="home-author">
    <div class="container">
        <div class="pagetitle center">Most articles author</div>
        <div class="home-author-list">
            <%foreach (var author in lstAuthorMostArticle)
                {%>
            <div class="author-item">
                <figure>
                    <a href="/articles-by-author?id=<%=author.AuthorID %>" class="item-img">
                        <img src="<%=AuthorImageUrl(author.AuthorID) %>" alt=""></a>
                    <figcaption>
                        <h3 class="item-name"><a href="/articles-by-author?id=<%=author.AuthorID %>"><%=author.Name %></a></h3>
                        <div class="author-des"><%=author.JoinDate %>  </div>
                    </figcaption>
                </figure>
            </div>
            <%} %>
        </div>
    </div>
</section>
<%--<section class="home-banner-dns">
    <div class="banner-content">
        <img src="img/home/banner2.jpg" alt="">
    </div>
</section>--%>
<section class="home-subcribe">
    <div class="title">NEWSLETTER BOX</div>
    <div class="subscribe">
        <div class="module-title">Enter your email to get latest update from us.</div>
        <div class="subscribefrm clear-fix">
            <input type="text" placeholder="Email...">
            <button class="subscribebutton"><i class="fa fa-check" aria-hidden="true"></i></button>
        </div>
    </div>
</section>