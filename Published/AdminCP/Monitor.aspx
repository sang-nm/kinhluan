<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="Monitor.aspx.cs" Inherits="CanhCam.Web.AdminUI.MonitorPage" %>

<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <h2>Memory and CPU Consumption</h2>
    <p class="container">
        <b>Total Bytes Allocated:</b>
        <asp:Literal ID="litTotalAllocatedMemorySize" runat="server" />
        Bytes<br />
        <br />
        <b>Total Bytes In Use:</b>
        <asp:Literal ID="litSurvivedMemorySize" runat="server" />
        Bytes<br />
        <br />
        <b>CPU usage:</b>
        <asp:Literal ID="litTotalProcessorTime" runat="server" />
        Milliseconds
    </p>
    <asp:Repeater ID="rpt" runat="server">
        <HeaderTemplate>
            <h2>Exceptions</h2>
        </HeaderTemplate>
        <ItemTemplate>
            <br />
            <a href="javascript:" class="ExpLink">
                <%# Eval("Url")%></a><br />
            <br />
            <div class="outerExpContent">
                <asp:Repeater ID="rptExceptions" runat="server">
                    <ItemTemplate>
                        <div class="ExpContent">
                            <p>
                                <b>Exception Type:</b>
                                <%# ((Exception)Container.DataItem).GetType().FullName %></p>
                            <p>
                                <b>Message:</b>
                                <%# Eval("Message")%>
                            </p>
                            <p>
                                <b>Stack Trace:</b>
                                <%# Eval("StackTrace")%>
                            </p>
                            <hr />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>