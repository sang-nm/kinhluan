<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewListControl.ascx.cs" Inherits="CanhCam.Web.NewsUI.NewListControl" %>


<section class="breadcrumb-wrap clearfix">
    <div style="background: url(/Data/Sites/1/Banner/4.jpg) center right no-repeat; background-size: cover" class="breadcrumb-bg">
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
    <div class="news-list">
        <div class="row flex flex-wrap">

            <%foreach (var n in lst_news)
                {%>
            <div class="col-xs-12 col-md-6 col-lg-4">
                <div class="news-item <%=((n.LikeCount + n.ShareCount) <= 100 ? "level-3" : (n.LikeCount + n.ShareCount) > 100 && (n.LikeCount + n.ShareCount) <= 500 ? "level-2" : "level-1")%>">
                    <figure>
                        <a href="/news-detail?newsID=<%=n.NewsID %>" class="item-img">
                            <img src="<%=NewsImageUrl(n.NewsID) %>" alt=""></a>
                        <figcaption>
                            <h2 class="item-title"><a href="/news-detail?newsID=<%=n.NewsID %>"><%=n.Title %></a></h2>
                            <div class="wrap-up clearfix">
                                <div class="item-author">
                                    <div class="img">
                                        <img src="<%=AuthorImageUrl(n.AuthorID) %>" alt="">
                                    </div>
                                    <div class="text">

                                        <div class="name"><%=GetAuthorName(n.AuthorID) %></div>
                                        <time><%=n.StartDate %></time>
                                    </div>
                                </div>
                                <div class="item-button <%=(currentUser!=null?"":"hidden") %>"><a class="like-news <%=(CheckLiked(n.NewsID)?"liked":"") %>" data-newsID="<%=n.NewsID %>" href="#"><i class="fa fa-heart-o" aria-hidden="true"></i></a></div>
                            </div>
                            <div class="wrap-bottom clearfix">
                                <div class="item-likeshare"><span><%=n.Viewed %> <i class="fa fa-eye" aria-hidden="true"></i></span><span><%=n.ShareCount %>  <i class="fa fa-share-alt" aria-hidden="true"></i></span></div>
                                <ul class="item-categories">
                                    <%foreach (var type in GetNewsType(n.NewstypeID))
                                        {%>
                                    <li><a href="/blog?typeId=<%=type.NewsTypeID %>"><%=type.Name %></a></li>
                                    <%} %>
                                </ul>
                            </div>
                        </figcaption>
                    </figure>
                </div>
            </div>

            <% } %>


            <%--<div class="col-xs-12 col-md-6 col-lg-4">
                <div class="news-item pin level-1">
                    <figure>
                        <a href="#" class="item-img">
                            <img src="img/news/2.jpg" alt=""></a>
                        <figcaption>
                            <h2 class="item-title"><a href="#">Great Places to Visit in London</a></h2>
                            <div class="wrap-up clearfix">
                                <div class="item-author">
                                    <div class="img">
                                        <img src="img/author/1.jpg" alt=""></div>
                                    <div class="text">
                                        <div class="name">Nguyen Kinh Luan</div>
                                        <time>25 Mar 2017</time>
                                    </div>
                                </div>
                                <div class="item-button"><a href="#"><i class="fa fa-paperclip" aria-hidden="true"></i></a></div>
                            </div>
                            <div class="wrap-bottom clearfix">
                                <div class="item-likeshare"><span>4862 <i class="fa fa-eye" aria-hidden="true"></i></span><span>432 <i class="fa fa-share-alt" aria-hidden="true"></i></span></div>
                                <ul class="item-categories">
                                    <li><a href="#">Health</a></li>
                                    <li><a href="#">Health Care</a></li>
                                </ul>
                            </div>
                        </figcaption>
                    </figure>
                </div>
            </div>
            <div class="col-xs-12 col-md-6 col-lg-4">
                <div class="news-item level-3">
                    <figure>
                        <a href="#" class="item-img">
                            <img src="img/news/3.jpg" alt=""></a>
                        <figcaption>
                            <h2 class="item-title"><a href="#">Why You Don't Need To Spend A Fortune To Experience Everything</a></h2>
                            <div class="wrap-up clearfix">
                                <div class="item-author">
                                    <div class="img">
                                        <img src="img/author/1.jpg" alt=""></div>
                                    <div class="text">
                                        <div class="name">Nguyen Kinh Luan</div>
                                        <time>25 Mar 2017</time>
                                    </div>
                                </div>
                                <div class="item-button"><a href="#"><i class="fa fa-paperclip" aria-hidden="true"></i></a></div>
                            </div>
                            <div class="wrap-bottom clearfix">
                                <div class="item-likeshare"><span>4862 <i class="fa fa-eye" aria-hidden="true"></i></span><span>432 <i class="fa fa-share-alt" aria-hidden="true"></i></span></div>
                                <ul class="item-categories">
                                    <li><a href="#">Health</a></li>
                                    <li><a href="#">Health Care</a></li>
                                </ul>
                            </div>
                        </figcaption>
                    </figure>
                </div>
            </div>--%>
        </div>
        <div class="pages">
            <ul class="pagination">
                <%if (totalPages > 1)
                    {
                %>
                <%for (int i = 1; i <= totalPages; i++)
                    {%>
                <li class="<%=i == pageNumber ? "active" : " "%>"><a href="/news-1?pagenumber=<%=i %>"><%=i %></a></li>
                <%}%>
                <%} %>
                <%-- <li class="active"><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>--%>
            </ul>
        </div>
    </div>
</div>
