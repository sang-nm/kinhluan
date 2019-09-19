<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="NewsTypeControl.ascx.cs"
    Inherits="CanhCam.Web.NewsUI.NewsTypeControl" %>

<div class="btn-showsub"><i class="fa fa-angle-right" aria-hidden="true"></i></div>
<div class="mega">
    <ul class="sub">
        <%int count = 1; %>
        <%foreach (var parent in parentType)
            {%>
                <li class="<%=count==1?"active first":"" %>"><a href="/blog?typeId=<%=parent.NewsTypeID %>"><%=parent.Name %></a>
                <div class="btn-showchild"><i class="fa fa-angle-right" aria-hidden="true"></i></div>
                <div class="child">
                    <ul>
                        <%foreach (var child in GetChildType(parent.NewsTypeID))
                            { %>
                            <li <%=count==1?"active":"" %>><a href="/blog?typeId=<%=child.NewsTypeID %>"><%=child.Name %></a>
                                <div class="mega-product-wrap">
                                <div class="mega-product-list clearfix">
                                    <%foreach (var news in GetNews(child.NewsTypeID))
                                        {%>
                                            <div class="product-item">
                                                <figure>
                                                    <a href="/news-detail?newsID=<%=news.NewsID %>" class="item-img">
                                                        <img src="<%=NewsImageUrl(news.NewsID) %>" alt=""></a>
                                                    <figcaption>
                                                        <h3 class="item-name"><a href="/news-detail?newsID=<%=news.NewsID %>"><%=news.Title %></a></h3>
                                                    </figcaption>
                                                </figure>
                                            </div>
                                        <%} %>
                                    
                                </div>
                            </div>
                            </li>
                            <%} %>
                    </ul>
                </div>
            </li>

            <%count++;
                } %>
    </ul>
</div>
