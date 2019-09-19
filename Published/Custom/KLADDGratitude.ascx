<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="KLADDGratitude.ascx.cs"
    Inherits="CanhCam.Web.CustomUI.KLADDGratitude" %>


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
                        <section class="comment clearfix">
                            <div class="user-tool clearfix">
                                <div class="btn-save">
                                    <asp:Button ID="btncreate" Text="<%$Resources:CustomResources, PostGratitude %>" runat="server" CausesValidation="False" />
                                </div>
                            <portal:NotifyMessage ID="message" runat="server" />
                            </div>
                            <div class="form-editor">
                                <div class="form-group">
                                    <label>Gratitude: </label>
                                    <asp:TextBox runat="server" ID="txtgratitude" TextMode="MultiLine"  />
                                </div>
                               
                            </div>
                        </section>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>

