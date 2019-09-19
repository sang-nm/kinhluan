<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="DealerLocatorModule.ascx.cs" Inherits="CanhCam.Web.DealerUI.DealerLocatorModule" %>

<%@ Register TagPrefix="Site" Assembly="CanhCam.Features.DealerLocator" Namespace="CanhCam.Web.DealerUI" %>
<Site:DealerDisplaySettings ID="displaySettings" runat="server" />

<asp:UpdatePanel ID="upLocator" runat="server">
    <ContentTemplate>
        <div class="wrap-dealer">
            <div class="dealer-title">
                <asp:Literal ID="litDealerSearch" Text="<%$Resources:DealerResources, DealerSearchLabel %>" runat="server" />
            </div>
            <div class="form-group dealer-province">
                <asp:Label ID="lblProvince" CssClass="label" Text="<%$Resources:DealerResources, ProvinceLabel %>" runat="server" />
                <asp:DropDownList ID="ddProvince" runat="server" CssClass="form-control" DataTextField="Name" DataValueField="Guid"
                    AutoPostBack="true" AppendDataBoundItems="true">
                </asp:DropDownList>
            </div>
            <div id="divDistrict" runat="server" class="form-group dealer-district">
                <asp:Label ID="lblDistrict" CssClass="label" Text="<%$Resources:DealerResources, DistrictLabel %>" runat="server" />
                <asp:DropDownList ID="ddDistrict" runat="server" CssClass="form-control" DataTextField="Name" DataValueField="Guid"
                    AutoPostBack="true" AppendDataBoundItems="true">
                </asp:DropDownList>
            </div>
            <div class="form-group dealer-button">
                <asp:Button ID="btnSearch" Text="<%$Resources:DealerResources, SearchButton %>" CssClass="btn btn-default dsubmit" runat="server" />
            </div>
            <div class="clear"></div>
        </div>
        <asp:Xml ID="xmlTransformer" runat="server"></asp:Xml>
        <div id="divPager" runat="server" class="pages">
            <portal:gbCutePager ID="pgr" runat="server" />
        </div>
    </ContentTemplate>
</asp:UpdatePanel>