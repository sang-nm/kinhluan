<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="SearchableFeatureFilterSetting.ascx.cs" Inherits="CanhCam.Web.UI.SearchableFeatureFilterSetting" %>

<asp:UpdatePanel ID="upFeatures" UpdateMode="Conditional" runat="server" >
    <ContentTemplate>
        <div class="row">
            <div class="col-sm-5">
                <h3>
                    <gb:SiteLabel ID="Sitelabel4" runat="server" ConfigKey="SiteSettingsSiteAvailableFeaturesLabel"
                        UseLabelTag="false" />
                </h3>
                <asp:ListBox ID="lstAllFeatures" runat="Server" Width="100%" Height="200" SelectionMode="Multiple"  />
            </div>
            <div class="col-sm-1 text-center mrt60">
                <asp:Button SkinID="DefaultButton" Text="&laquo;" runat="server" ID="btnRemoveFeature" CausesValidation="false" />
                <asp:Button SkinID="DefaultButton" Text="&raquo;" runat="server" ID="btnAddFeature" CausesValidation="false" />
                <br />
                <portal:gbHelpLink ID="gbHelpLink55" runat="server" RenderWrapper="false" HelpKey="sitesettingschildsitefeatureshelp" />
            </div>
            <div class="col-sm-6">
                <h3>
                    <gb:SiteLabel ID="Sitelabel5" runat="server" ConfigKey="SiteSettingsSiteSelectedFeaturesLabel"
                        UseLabelTag="false" />
                </h3>
                <asp:ListBox ID="lstSelectedFeatures" runat="Server" Width="100%" Height="200" SelectionMode="Multiple"  />
            </div>
        </div>
        <portal:gbLabel ID="lblFeatureMessage" runat="server" CssClass="alert alert-danger" />
        <asp:HiddenField ID="featureGuidCsv" runat="server" />
    </ContentTemplate>
</asp:UpdatePanel>
