<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KLAuthorList.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLAuthorList" %>


<div class="container">
    <div class="author-list">
        <div class="row flex flex-wrap">

            <%
                foreach (var a in authorList)
                {
            %>
            <div class="col-xs-12 col-sm-6 col-md-4 col-xl-3">
                <div class="author-item">
                    <figure>
                        <div class="item-img">
                            <img src="<%= getAuthorImg(a.UserID, a.Avatar) %>" alt=""><a href="<%=getAuthorUrl(a.AuthorID) %>" class="btn-moreinfo">More Info</a>
                        </div>
                        <figcaption>
                            <h2 class="item-name"><a href="<%= getAuthorUrl(a.AuthorID) %>"><%= a.Name %></a></h2>
                            <div class="item-des"><%= a.JoinDate.ToString("dd/MM/yyyy") %></div>
                            <div class="item-social"><a href="<%=a.LinkFacebook %>"><i class="fa fa-facebook" aria-hidden="true"></i></a><a href="<%=a.LinkTwitter %>"><i class="fa fa-twitter" aria-hidden="true"></i></a><a href="<%=a.LinkPinterest %>"><i class="fa fa-pinterest-p" aria-hidden="true"></i></a><a href="<%=a.LinkInstagram %>"><i class="fa fa-instagram" aria-hidden="true"></i></a></div>
                        </figcaption>
                    </figure>
                </div>
            </div>
            <%
                }
            %>
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
                            <li id="previous"><a href="<%=siteRoot+"?page=" +(pagenum-1) %>"><<</a></li>
                    <%
                        }
                    %>

                    <%  for (int i = 1; i <= totalPage; i++)
                        {
                    %>
                            <li class="<%=(pagenum == i ? "active" : "") %>"><a href="<%=siteRoot + "?page=" + i %>"><%=i %></a></li>
                    <%
                        }
                        if (pagenum < totalPage)
                        {
                    %>
                            <li id="previous"><a href="<%=siteRoot+"?page=" +(pagenum+1) %>">>></a></li>
                <%
                        }
                    }
                %>
            </ul>
        </div>
    </div>
</div>
