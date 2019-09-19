<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QuestionViewer.ascx.cs" Inherits="CanhCam.FormWizard.Web.UI.QuestionViewer" %>

<%@ Register Namespace="CanhCam.FormWizard.Web.UI" Assembly="CanhCam.Features.FormWizard" TagPrefix="Site" %>

<Site:EmailQuestion ID="emQuestion" runat="server" />
<Site:TextBoxQuestion ID="txtQuestion" runat="server" />
<Site:TextAreaQuestion ID="taQuestion" runat="server" />
<Site:DropDownListQuestion ID="ddQuestion" runat="server" />
<Site:CheckBoxListQuestion ID="chkQuestion" runat="server" />
<Site:RadioButtonListQuestion ID="rdoQuestion" runat="server" />
<Site:DateQuestion ID="dateQuestion" runat="server" />
<Site:DateTimeQuestion ID="dateTimeQuestion" runat="server" />
<Site:RatingQuestion ID="ratingQuestion" runat="server" />
<Site:UploadQuestion ID="uploadQuestion" runat="server" />
<Site:CheckBoxQuestion ID="cbQuestion" runat="server" />
<Site:CustomQuestion ID="cusQuestion" runat="server" />
<Site:InstructionBlockQuestion ID="instructionBlock" runat="server" />