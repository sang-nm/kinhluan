<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="LeftMenu.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.LeftMenu" %>
 <section class="user-sidebar clearfix">
                <div class="userinfo clearfix">
                    <figure>
                        <a href="#" class="user-img">
                            <img src="/update-author" alt=""></a>
                        <figcaption>
                            <div class="user-name"><%= Name %></div>
                            <div class="level"><i class="fa fa-diamond" aria-hidden="true"></i><%= Level %></div>
                        </figcaption>
                    </figure>   
                </div>  
                <nav class="user-sidelink clearfix">
                    <ul>
                        <li><a href="/author-news">Article</a>
                            <div class="btn-showsubarticle"><i class="fa fa-angle-right" aria-hidden="true"></i></div>
                            <div class="sub">
                                <ul>
                                    <li><a href="/author-news">All</a></li>
                                    <li><a href="/author-news?status=draft">Drafts</a></li>
                                    <li><a href="/author-news?status=pending">Pending</a></li>
                                    <li><a href="/author-news?status=posted">Posted</a></li>
                                </ul>
                            </div>
                        </li>
                        <li><a href="/author-book-posted">Books Author</a></li>
                        <li><a href="/manage-comment">Manage Comment </a></li>
                        <li><a href="/author-following">Following Author</a></li>
                        <li><a href="/add-gratitude">Post Gratitude</a></li>
                    </ul>
                </nav>
            </section>