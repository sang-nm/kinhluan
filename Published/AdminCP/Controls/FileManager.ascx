<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="FileManager.ascx.cs"
    Inherits="CanhCam.Web.AdminUI.FileManagerControl" %>
<portal:gbLabel ID="lblDisabledMessage" runat="server" CssClass="txterror info" />
<asp:Panel ID="pnlFile" runat="server" DefaultButton="btnUpload">
    <portal:NotifyMessage ID="message" runat="server" />
    <asp:PlaceHolder ID="myPlaceHolder" runat="server"></asp:PlaceHolder>
    <input id="hdnUploadID" type="hidden" name="hdnUploadID" />
    <asp:HiddenField ID="hdnCurDir" runat="server" />
    <div class="mrb10">
        <asp:LinkButton ID="btnDelete" runat="server"><i class="fa fa-trash-o"></i></asp:LinkButton>
        <asp:LinkButton ID="btnGoUp" runat="server"><i class="fa fa-level-up"></i></asp:LinkButton>
        <asp:Label ID="lblCurrentDirectory" runat="server" CssClass="foldername" />
    </div>
    <telerik:RadGrid ID="grid" SkinID="radGridSkin" runat="server">
        <MasterTableView DataKeyNames="type,filename" AllowPaging="false" EditMode="InPlace">
            <Columns>
                <telerik:GridTemplateColumn SortExpression="fileName" HeaderText="<%$Resources:Resource, FileManagerFileNameLabel %>">
                    <ItemTemplate>
                        <asp:Image ID="imgType" runat="server" AlternateText=" "></asp:Image>
                        <asp:Button SkinID="LinkButton" ID="lnkName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"filename") %>'
                            CommandName="ItemClicked" CommandArgument='<%# Eval("path").ToString() + "#" + Eval("type").ToString()  %>'
                            CausesValidation="false"></asp:Button>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <div class="input-group">
                            <div class="input-group-addon">
                                <asp:Image ID="imgEditType" runat="server"></asp:Image>
                            </div>
                            <asp:TextBox ID="txtEditName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"filename") %>' />
                        </div>
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-Wrap="false" ItemStyle-Wrap="false" SortExpression="size" HeaderText="<%$Resources:Resource, FileManagerSizeLabel %>">
                    <ItemTemplate>
                        <asp:Literal ID="litSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"size") %>' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-Wrap="false" ItemStyle-Wrap="false" SortExpression="modified" HeaderText="<%$Resources:Resource, FileManagerModifiedLabel %>">
                    <ItemTemplate>
                        <asp:Literal ID="litModified" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"modified") %>' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <asp:Button SkinID="EditButton" ID="lnkEdit" runat="server" CommandName="Edit"
                            CausesValidation="false" Text="<%# Resources.Resource.FileManagerRename %>">
                        </asp:Button>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Button SkinID="UpdateButton" ID="btnGridUpdate" runat="server" Text='<%# Resources.Resource.LanguageGridUpdateButton %>'
                            CommandName="Update" />
                        <asp:Button SkinID="CancelButton" ID="btnGridCancel" runat="server" Text='<%# Resources.Resource.LanguageGridCancelButton %>'
                            CommandName="Cancel" />
                    </EditItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridClientSelectColumn HeaderStyle-Width="35" />
            </Columns>
        </MasterTableView>
        <ClientSettings>
            <Selecting AllowRowSelect="true" />
        </ClientSettings>
    </telerik:RadGrid>
    <div class="mrb10">
        <asp:Label ID="lblCounter" runat="server"></asp:Label>
    </div>
    <div id="divUpload" runat="server">
        <asp:Panel ID="pnlNewFolder" runat="server" CssClass="row" DefaultButton="btnNewFolder">
            <div class="col-sm-5">
                <div class="input-group">
                    <asp:TextBox ID="txtNewDirectory" runat="server" CssClass="form-control" />
                    <div class="input-group-btn">
                        <asp:Button SkinID="InsertButton" ID="btnNewFolder" runat="server" />
                    </div>
                </div>
            </div>
        </asp:Panel>
        <div class="mrt10">
            <div class="settingrow form-group">
                <gb:SiteLabel ID="lblGalleryEditImageLabel" CssClass="settinglabel control-label" runat="server" ConfigKey="FileManagerUploadLabel" />
                <div>
                    <telerik:RadAsyncUpload ID="multiFile" SkinID="radAsyncUploadSkin" MultipleFileSelection="Automatic" runat="server" />
                </div>
                <asp:Button SkinID="DefaultButton" ID="btnUpload" runat="server" Text="Upload" />
            </div>
        </div>
    </div>
</asp:Panel>