<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLAuthorFollowing.ascx.cs" Inherits="CanhCam.Web.CustomUI.KLAuthorFollowing" %>
<%@ Register Src="~/Custom/LeftMenu.ascx" TagPrefix="portal" TagName="LeftMenu" %>



<div class="container">
    <div class="row flex flex-wrap">
        <div class="col-xs-12 col-lg-3">
            <portal:LeftMenu runat="server" ID="LeftMenu" />
        </div>
        <div class="col-xs-12 col-lg-9">
             <section class="user-page clearfix">
                <div class="row flex flex-wrap">
                  <div class="col-xs-12">
                    <div class="author-list"> 
                      <div class="row flex flex-wrap">

                          <%
                                    if (authorList.Count > 0)
                                    {
                                        foreach (KLAuthor item in authorList)
                                        {
                                %>

                                <div class="col-xs-12 col-sm-6 col-md-4 col-xl-4">
                                    <div class="author-item">
                                        <figure>
                                            <div class="item-img">
                                                <img src="<%= "/data/Sites/1/Author/"+ item.UserID +"/"+ item.Avatar %>" alt=""><a href="<%="/author-detail?id="+item.AuthorID %>" class="btn-moreinfo">More Info</a>
                                            </div>
                                            <figcaption>
                                                <h2 class="item-name"><a href="<%="/author-detail?id="+item.AuthorID %>"><%= item.Name %></a></h2>
                                                <div class="item-des"><%= item.JoinDate %></div>
                                                <div class="item-social"><a href="<%= item.LinkFacebook %>"><i class="fa fa-facebook" aria-hidden="true"></i></a><a href="<%= item.LinkTwitter %>"><i class="fa fa-twitter" aria-hidden="true"></i></a><a href="<%= item.LinkPinterest %>"><i class="fa fa-pinterest-p" aria-hidden="true"></i></a><a href="<%= item.LinkInstagram %>"><i class="fa fa-instagram" aria-hidden="true"></i></a></div>
                                            </figcaption>
                                        </figure>
                                    </div>
                                </div>


                                <%
                                        }
                                    }
                                %>




<%--                        <div class="col-xs-12 col-sm-6 col-md-4 col-xl-4">
                          <div class="author-item"> 
                            <figure> 
                              <div class="item-img"><img src="img/author/1.jpg" alt=""><a href="#" class="btn-moreinfo">More Info</a></div>
                              <figcaption> 
                                <h2 class="item-name"><a href="#">Nguyen Kinh Luan</a></h2>
                                <div class="item-des">Lausks expert since Mar, 2014 </div>
                                <div class="item-social"> <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a><a href="#"><i class="fa fa-pinterest-p" aria-hidden="true"></i></a><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></div>
                              </figcaption>
                            </figure>
                          </div>
                        </div>--%>

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
                </div>
              </section>
        </div>
    </div>
</div>
