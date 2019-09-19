<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/DialogMaster.Master" CodeBehind="UserSelectorDialog.aspx.cs" Inherits="CanhCam.Web.UI.UserSelectorDialog" %>

<asp:Content ContentPlaceHolderID="phHead" ID="HeadContent" runat="server"></asp:Content>
<asp:Content ContentPlaceHolderID="phMain" ID="MainContent" runat="server">
<div  style="padding: 5px 5px 5px 5px;" class="yui-skin-sam">

<asp:Panel ID="pnlLookup" runat="server" Visible="false">
<div class="modulesubtitle" id="divNewUser" runat="server">
    <asp:TextBox ID="txtSearchUser" runat="server" CssClass="mediumtextbox" MaxLength="255" />
    <asp:Button ID="btnSearchUser" runat="server" />
</div>	

<div class="modulepager">
	    <asp:HyperLink ID="lnkAllUsers" runat="server" CssClass="ModulePager" />
	    <span id="spnTopPager"  runat="server" ></span>
	</div>	
	<div class="cp-gridwrap">	
	<table  cellspacing="0" width="100%">
		<thead>
		<tr>
			<th id='<%# Resources.Resource.MemberListUserNameLabel.Replace(" ", "") %>' >
				<gb:SiteLabel id="lblUserNameLabel" runat="server" ConfigKey="MemberListUserNameLabel" UseLabelTag="false" />
			</th>
			<th id='<%# Resources.Resource.MemberListEmailLabel.Replace(" ", "") %>'>
				<gb:SiteLabel id="SiteLabel1" runat="server" ConfigKey="MemberListEmailLabel" UseLabelTag="false" />
			</th>
			<th id='<%# Resources.Resource.MemberListLoginNameLabel.Replace(" ", "") %>'>
				<gb:SiteLabel id="SiteLabel2" runat="server" ConfigKey="MemberListLoginNameLabel" UseLabelTag="false" />
			</th>
			<th></th>
		</tr></thead><tbody>
		<asp:Repeater id="rptUsers" runat="server" EnableViewState="False">
			<ItemTemplate>
				<tr>
					<td headers='<%# Resources.Resource.MemberListUserNameLabel.Replace(" ", "") %>'>
						<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Name").ToString())%>
					</td>
					<td headers='<%# Resources.Resource.MemberListEmailLabel.Replace(" ", "") %>'>
					    <a href='<%# "mailto:" + Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Email").ToString())%>'><%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Email").ToString())%></a>
					</td>
					<td headers='<%# Resources.Resource.MemberListLoginNameLabel.Replace(" ", "") %>'> 
						<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "LoginName").ToString())%>
					</td>
					<td>
					<asp:Button ID="btnSelect" runat="server" Text='<%# Resources.Resource.UserLookupDialogSelectButton %>' CommandName="selectUser" 
                        CommandArgument='<%# Eval("UserGuid").ToString() + "|" + Eval("UserID").ToString() + "|" + Eval("Email").ToString() %>' />
					</td>
				</tr>
			</ItemTemplate>
			<alternatingItemTemplate>
				<tr class="AspNet-GridView-Alternate">
					<td headers='<%# Resources.Resource.MemberListUserNameLabel.Replace(" ", "") %>'>
						<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Name").ToString())%>
					</td>
					<td headers='<%# Resources.Resource.MemberListEmailLabel.Replace(" ", "") %>'>
					    <a href='<%# "mailto:" + Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Email").ToString())%>'><%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "Email").ToString())%></a>
					</td>
					<td headers='<%# Resources.Resource.MemberListLoginNameLabel.Replace(" ", "") %>'> 
						<%# Server.HtmlEncode(DataBinder.Eval(Container.DataItem, "LoginName").ToString())%>
					</td>
					<td>
					<asp:Button ID="btnSelect" runat="server" Text='<%# Resources.Resource.UserLookupDialogSelectButton %>' CommandName="selectUser" 
                        CommandArgument='<%# Eval("UserGuid").ToString() + "|" + Eval("UserID").ToString() + "|" + Eval("Email").ToString() %>' />
					</td>
				</tr>
			</AlternatingItemTemplate>
		</asp:Repeater></tbody>
	</table>
	</div>	
   <portal:gbCutePager ID="pgrMembers" runat="server" />
</asp:Panel>
<asp:Panel ID="pnlNotAllowed" runat="server" Visible="false">
<gb:SiteLabel ID="lblNotAllowed" runat="server" CssClass="txterror warning" UseLabelTag="false" ConfigKey="NotInUserLookupRolesWarning" />
</asp:Panel>


</div>
</asp:Content>
