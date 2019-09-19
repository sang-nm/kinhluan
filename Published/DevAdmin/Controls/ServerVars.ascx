<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ServerVars.ascx.cs" Inherits="CanhCam.Web.DevAdmin.ServerVarsControl" %>

<div class="form-horizontal">
    <asp:Repeater ID="rptrServerVars" Runat="server">
	    <ItemTemplate>
	        <div class="settingrow form-group">
	            <asp:Label ID="lblvar" runat="server" CssClass="settinglabel control-label col-sm-3" Text='<%# Container.DataItem %>' />
	            <div class="col-sm-9" style="overflow:hidden;">
                    <p class="form-control-static">
                        <asp:Literal ID="VarValue" Runat="server" />
                    </p>
                </div>
	         </div>
	    </ItemTemplate>
    </asp:Repeater>
</div>