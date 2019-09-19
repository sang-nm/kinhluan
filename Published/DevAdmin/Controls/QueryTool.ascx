<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="QueryTool.ascx.cs" Inherits="CanhCam.Web.DevAdmin.Controls.QueryTool" %>

<div class="toolbox">
    <asp:Button ID="btnExecuteQuery" CssClass="btn btn-danger" runat="server"  />
    <asp:Button ID="btnExecuteNonQuery" CssClass="btn btn-danger" runat="server"  />
    <asp:Button ID="btnExport" CssClass="btn btn-default" runat="server"   />
    <asp:HyperLink ID="lnkClear" CssClass="btn btn-default" runat="server"  />
</div>
<portal:NotifyMessage ID="message" runat="server" />
<div class="panelwrapper padded">
    <div class="mrb10 mrt10">
        <p><em><asp:Literal ID="litWarning" runat="server" /></em></p>
    </div>
    <div class="form-horizontal">
        <asp:Panel ID="pnlTables" runat="server" CssClass="settingrow form-group">
            <gb:SiteLabel ID="lblTables" runat="server" CssClass="settinglabel control-label col-sm-3" UseLabelTag="false" ResourceFile="DevTools" ConfigKey="Tables" />
            <div class="col-sm-9">
                <div class="input-group">
                    <asp:DropDownList ID="ddTables" runat="server" DataValueField="TableName" DataTextField="TableName" ></asp:DropDownList>
                    <div class="input-group-btn">
                        <asp:Button ID="btnSelectTable" SkinID="DefaultButton" runat="server" />
                    </div>
                </div>
            </div>
        </asp:Panel>
        <div class="settingrow form-group">
            <gb:SiteLabel ID="lblQueries" runat="server" CssClass="settinglabel control-label col-sm-3" UseLabelTag="false" ResourceFile="DevTools" ConfigKey="SavedQueries" />
            <div class="col-sm-9">
                <div class="input-group">
                    <asp:DropDownList ID="ddQueries" runat="server" DataValueField="Id" DataTextField="Name"></asp:DropDownList>
                    <div class="input-group-btn">
                        <asp:Button ID="btnLoadQuery" SkinID="DefaultButton" runat="server" />
                        <asp:Button ID="btnDelete" SkinID="DefaultButton" runat="server" />
                    </div>
                </div>
                <div class="input-group mrt10">
                    <div class="input-group-btn">
                        <asp:Button ID="btnSave" SkinID="DefaultButton" runat="server" />
                    </div>
                    <asp:TextBox ID="txtQueryName" runat="server" MaxLength="50" />
                </div>
            </div>
        </div>
        <div class="settingrow form-group">
            <gb:SiteLabel ID="lblQuery" runat="server" CssClass="settinglabel control-label" ResourceFile="DevTools" ConfigKey="SqlQuery" />
            <portal:CodeEditor ID="txtQuery" runat="server" Syntax="sql" CssClass="sqleditor" StartHighlighted="true" MinWidth="900" AllowToggle="false" Width="100%" />
        </div>
    </div>
    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
        <MasterTableView AutoGenerateColumns="true" AllowPaging="false"></MasterTableView>
    </telerik:RadGrid>
</div>
