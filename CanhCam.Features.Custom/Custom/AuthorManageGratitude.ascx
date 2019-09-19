<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="AuthorManageGratitude.ascx.cs" 
    Inherits="CanhCam.Web.CustomUI.AuthorManageGratitude" %>

<style>
    table tr {
        display: none;
    }

        table tr.active {
            display: table-row;
        }
</style>
<script>
    $(document).ready(function () {
        $('table tr:first').addClass('active');
        $('table tr:nth-child(2)').addClass('active');
        $('table tr:nth-child(3)').addClass('active');
        $('a.load_more').on('click', function (e) {
            e.preventDefault();
            var $rows = $('table tr');
            var lastActiveIndex = $rows.filter('.active:last').index();
            $rows.filter(':lt(' + (lastActiveIndex + 3) + ')').addClass('active');
        });
    });
</script>


<section class="user-page clearfix">
    <div class="post-title-wrap clearfix">
        <h1 class="postname">Manage Gratitude</h1>
    </div>
    <div class="row flex flex-wrap">
        <div class="col-xs-12">
            <section class="gratitude-list">
                <asp:ListView ID="listviewGratitude" OnItemCommand="listviewGratitude_ItemCommand" OnItemDeleting="listviewGratitude_ItemDeleting" runat="server">
                    <LayoutTemplate>
                        <table cellpadding="1" runat="server" id="tblGratitude" style="width: 100%;">
                            <tr runat="server" id="groupPlaceholder">
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <GroupTemplate>
                        <tr runat="server" id="characterRow">
                            <td runat="server" id="itemPlaceholder"></td>
                        </tr>
                    </GroupTemplate>
                    <ItemTemplate>
                        <td runat="server">
                            <div class="guestbook-item">
                                <figure class="row flex flex-wrap">
                                    <div class="col-xs-12 col-md-2">
                                        <div class="item-img">
                                            <img src="<%# getImageURL() %>"></img>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-md-10">
                                        <figcaption>
                                            <div class="item-content"><%# Eval("Comment") %></div>
                                            <time><%# Eval("CreateUtc") %></time>
                                            <asp:Label ID="GuestID" Visible="false" runat="server" Text='<%# Eval("GuestID") %>'></asp:Label>
                                        </figcaption>
                                    </div>
                                </figure>
                                <div class="button-wrap">
                                    <div class="btn-update">
                                        <asp:Button ID="btnUpdate" Text="<%$Resources:CustomResources, UpdateButton  %>" CommandName="fix" runat="server" CausesValidation="False" />
                                    </div>
                                    <div class="btn-delete">
                                        <asp:Button ID="btnDelete" Text="<%$Resources:CustomResources, DeleteButton %>" CommandName="Delete" runat="server" CausesValidation="False" />
                                    </div>
                                </div>
                            </div>
                        </td>
                    </ItemTemplate>
                </asp:ListView>
            </section>
            <div class="gratitude-info">
                <div class="btn-viewmore">
                    <a href="#" class="load_more"><span>More</span></a>
                </div>
            </div>
        </div>
    </div>
</section>

