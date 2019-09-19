<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLAuthor_Articles.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLAuthor_Articles" %>
<%@ Register Src="~/Custom/KLAuthorLayer.ascx" TagPrefix="portal" TagName="KLAuthorLayer" %>


<div class="container">
    <div class="author-detail-wrap">
        <portal:KLAuthorLayer runat="server" ID="KLAuthorLayer" />
        <div class="news-list">
            <div class="row flex flex-wrap">
                <%
                    foreach (var n in news)
                    {
                %>
                <div class="col-xs-12 col-md-6 col-lg-4">
                    <div class="news-item level-2">
                        <figure>
                            <a href="<%= getArticleUrl(n.NewsID) %>" class="item-img">
                                <img src="<%=NewsImageUrl(n.NewsID)%>" alt="Article"></a>
                            <figcaption>
                                <h2 class="item-title"><a href="/news-detail?newsID=<%=n.NewsID %>"><%=getTitileNews(n.NewsID) %></a></h2>
                                <div class="wrap-up clearfix">
                                    <div class="item-author">
                                        <div class="img">
                                            <img src="<%=AuthorImageUrl(author.AuthorID) %>" alt="Author">
                                        </div>
                                        <div class="text">
                                            <div class="name"><%=GetAuthorName(author.AuthorID) %></div>
                                            <time><%= getStartDate(n.NewsID) %></time>
                                        </div>
                                    </div>
                                    <div class="item-button"><a href="#"><i class="fa fa-paperclip" aria-hidden="true"></i></a></div>
                                </div>
                                <div class="wrap-bottom clearfix">
                                    <div class="item-likeshare"><span><%= getView(n.NewsID) %> <i class="fa fa-eye" aria-hidden="true"></i></span><span><%=n.ShareCount %> <i class="fa fa-share-alt" aria-hidden="true"></i></span></div>
                                    <ul class="item-categories">
                                        <%foreach (var type in GetNewsType(n.NewType))
                                            {%>
                                                <li><a href="/blog?typeId=<%=type.NewsTypeID %>"><%=type.Name %></a></li>
                                            <%}
                                        %>
                                    </ul>
                                </div>
                            </figcaption>
                        </figure>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
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
                <li id="previous"><a href="<%=siteRoot +"?id="+ author.AuthorID +"&page="+ (pagenum-1) %>"><<</a></li>
                <%
                    }
                %>

                <%  for (int i = 1; i <= totalPage; i++)
                    {
                %>
                <li class="<%=(pagenum == i ? "active" : "") %>"><a href="<%=siteRoot +"?id="+ author.AuthorID +"&page="+ i %>"><%=i %></a></li>
                <%
                    }
                    if (pagenum < totalPage)
                    {
                %>
                <li id="previous"><a href="<%=siteRoot+"?id="+ author.AuthorID +"&page="+ (pagenum+1) %>">>></a></li>
                <%
                        }
                    }
                %>
            </ul>
        </div>
    </div>
</div>
