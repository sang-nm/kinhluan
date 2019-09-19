<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KLAuthor_Books.ascx.cs" Inherits="CanhCam.Web.CustomUI.KLAuthor_Books" %>
<%@ Register Src="~/Custom/KLAuthorLayer.ascx" TagPrefix="portal" TagName="KLAuthorLayer" %>


<div class="container">
    <div id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade" >
        <div role="document" class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 id="modalTitleBook" class="modal-title"></h5>
                    <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </div>
                <div class="modal-body">
                    <div class="row flex flex-wrap">
                        <div class="col-xs-12 col-md-5">
                            <div class="modal-img">
                                <img src="" alt="" id="modalImage">
                            </div>
                            <div class="btn-buybook"><a href="#" id="bookUrl">Buy now</a></div>
                        </div>
                        <div class="col-xs-12 col-md-7">
                            <div class="content">
                                <p class="first" id="bookDesc"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="author-detail-wrap">
        <portal:KLAuthorLayer runat="server" ID="KLAuthorLayer" />

        

        <div class="books-list">
            <div class="row flex flex-wrap">
                <%
                    foreach (var b in book)
                    {
                %>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="book-item">
                        <figure>
                            <a data-toggle="modal" data-target="#myModal" class="item-img">
                                <img src="<%= BookImageUrl(b.BookID, b.Image) %>" alt="Story image"></a>
                            <figcaption>
                                <h2 class="item-name"><a href="<%= b.Url %>"><%= b.Title %></a></h2>
                                <div class="item-button"><a class="linkmodalbook" data-toggle="modal" data-target="#myModal" data-bookid="<%= b.BookID %>">The Author Says </a></div>
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
                <li id="previous"><a href="<%=siteRoot +"?id="+ authorID +"&page="+ (pagenum-1) %>"><<</a></li>
                <%
                    }
                %>

                <%  for (int i = 1; i <= totalPage; i++)
                    {
                %>
                <li class="<%=(pagenum == i ? "active" : "") %>"><a href="<%=siteRoot +"?id="+ authorID +"&page="+ i %>"><%=i %></a></li>
                <%
                    }
                    if (pagenum < totalPage)
                    {
                %>
                <li id="previous"><a href="<%=siteRoot+"?id="+ authorID +"&page="+ (pagenum+1) %>">>></a></li>
                <%
                        }
                    }
                %>
            </ul>
        </div>
    </div>
</div>
<script>
    $(document).on("click", ".linkmodalbook", function () {
        var bookid = $(this).attr("data-bookid");
        $.ajax({
            type: "POST",
            url: "/Custom/Services/NewsServices.aspx",
            data: { "method": "GetBooks", "bookid": bookid },
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.success) {
                    document.getElementById("modalTitleBook").innerText = data.bookTitle;
                    document.getElementById("modalImage").setAttribute("src", data.bookImageSrc);
                    document.getElementById("bookDesc").innerText = data.bookDesc;
                    document.getElementById("bookUrl").setAttribute("href", data.bookUrl);
                }
                else
                {
                    alert(data.message);
                }
            },
            failure: function (errMsg) {
                alert(errMsg);
            }
        });

    });
</script>