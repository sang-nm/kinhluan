﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WebUserControl.ascx.cs" Inherits="Data_Sites_1_skins_default_WebUserControl" %>
<div class="login"> 
                          <%--  <div class="img"><img src="img/author/1.jpg" alt=""></div>
                            <div class="name">Nguyen Kinh Luan</div>--%>
                              <%--<ul>
                                  <portal:WelcomeMessage ID="WelcomeMessage1" runat="server" WrapInProfileLink="true" ProfileLink="~/Account/UserProfile.aspx" RenderAsListItem="true" ListItemCss="firstnav" />
                                    <portal:RegisterLink ID="RegisterLink1" runat="server" RenderAsListItem="true" />
                                    <portal:LoginLink ID="LoginLink1" runat="server" RenderAsListItem="true" />
                                    <portal:LogoutLink ID="LogoutLink1" runat="server" RenderAsListItem="true" />
                              </ul>--%>
                              <% SiteUser current = SiteUtils.GetCurrentSiteUser();
                                  if (current == null)
                                  {
                                      %>
                              <ul>
                                  <li><a href="/author-login">Login</a></li>
                                  <li> <a href="/register-author">Register</a></li>
                              </ul>
                                    
                             
                              <%
                                  }
                                  else
                                  {
                                      KLAuthor author = null;
                                      try
                                      {
                                          author = KLAuthor.GetKLAuthorByUserID(current.UserId);
                                      }
                                      catch (Exception)
                                      {
                                      }

                                      %>
                                
                          <div class="mail"><i class="fa fa-envelope-o" aria-hidden="true"></i><span>5</span></div>

                               <div class="img"><img src='<%= "Data/Sites/1/Author/"+author.UserID+"/"+author.Avatar %>' alt=""></div>
                                   <div class="name">
                                       <ul>
                                           <li><a href="/author-news"><span class="nameauthor"><%= current.Name %></span></a></li>
                                           <li><a href="/logoff.aspx">Log Out</a></li>
                                       </ul>
                                   </div>
                              <%
                                  }

                                  %>
                          </div>