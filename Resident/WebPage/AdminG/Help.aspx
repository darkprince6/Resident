<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="Resident.WebPage.AdminG.Help" ClientIDMode="AutoID" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.7/flatpickr.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://kit.fontawesome.com/5f92b8c4a8.js"></script>
    <script>
        function custValHelpIns_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkHelpIns.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function custValHelpUpd_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkHelpUpd.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function custValHelpReply_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkHelpReply.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function openEditHelpModal() {
            $('.editHelpModal').modal('show');
        }

        function closeEditHelpModal() {
            $('.editHelpModal').modal('hide');
        }

        function alertMsgForHelpIns() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully added a new help',
                type: 'success'
            });
        }

        function alertMsgForHelpUpd() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully update a new help',
                type: 'success'
            });
        }

        function openReplyHelpModal() {
            $('.replyHelpModal').modal('show');
        }

        function closeReplyHelpModal() {
            $('.replyHelpModal').modal('hide');
        }

        function alertMsgForHelpReply() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully added a new reply',
                type: 'success'
            });
        }

        function openResolveHelpModal() {
            $('.resolveHelpModal').modal('show');
        }

        function closeResolveHelpModal() {
            $('.resolveHelpModal').modal('hide');
        }



    </script>
    <script>
var input = document.getElementById("myInput");
var text = document.getElementById("text");
input.addEventListener("keyup", function(event) {

if (event.getModifierState("CapsLock")) {
    text.style.display = "block";
  } else {
    text.style.display = "none"
  }
});
</script>

    <style>
        body {
            margin-top: 20px;
            background: #FDFDFD;
        }

        @media (min-width: 0) {
            .g-mr-15 {
                margin-right: 1.07143rem !important;
            }
        }

        @media (min-width: 0) {
            .g-mt-3 {
                margin-top: 0.21429rem !important;
            }
        }

        .g-height-50 {
            height: 50px;
        }

        .g-width-50 {
            width: 50px !important;
        }

        @media (min-width: 0) {
            .g-pa-30 {
                padding: 2.14286rem !important;
            }
        }

        .g-bg-secondary {
            background-color: #fafafa !important;
        }

        .u-shadow-v18 {
            box-shadow: 0 5px 10px -6px rgba(0, 0, 0, 0.15);
        }

        .g-color-gray-dark-v4 {
            color: #777 !important;
        }

        .g-font-size-12 {
            font-size: 0.85714rem !important;
        }

        .media-comment {
            margin-top: 20px
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>

        <div class="container">
            <div class="row">
                <div class="col-md-2">
                </div>
                <div class="col-md-8">
                    <div class="card mb-2">
                        <div class="card-body">

                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:HiddenField ID="hdnHelpPixel" runat="server" />

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtTitleForHelpIns" runat="server" Text="Title: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtTitleForHelpIns" runat="server" Placeholder="... enter a title"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitleForHelpIns"
                                            runat="server" Display="Dynamic" ValidationGroup="valHelpIns" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtDescrForHelpIns" runat="server" Text="Description: " CssClass="text-danger" Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtDescrForHelpIns" runat="server" Placeholder="... enter a description" CssClass="form-control form-control-sm" Font-Size="Small"
                                            Height="80" TextMode="MultiLine"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescrForHelpIns"
                                            runat="server" Display="Dynamic" ValidationGroup="valHelpIns" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>

                                    <div class="custom-control custom-checkbox m-1">
                                        <input type="checkbox" class="custom-control-input" id="chkHelpIns" runat="server" clientidmode="static" />
                                        <label class="custom-control-label" for="chkHelpIns">Terms And Condition</label>
                                    </div>

                                    <div>
                                        <asp:CustomValidator runat="server" ID="custValHelpIns" EnableClientScript="true"
                                            Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                            ValidationGroup="valHelpIns" OnServerValidate="custValHelpIns_ServerValidate"
                                            ErrorMessage="* Required" ClientValidationFunction="custValHelpIns_ClientValidate"></asp:CustomValidator>
                                    </div>

                                    <asp:Label ID="lblErroMsgHelpIns" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                    </asp:Label>

                                    <div>
                                        <asp:Button ID="btnSubmitHelpIns" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                            ValidationGroup="valHelpIns" OnClick="btnSubmitHelpIns_Click" />
                                        <asp:Button ID="btnCancelHelpIns" runat="server" Text="Cancel" CssClass="btn btn-outline-danger btn-sm"
                                            OnClick="btnCancelHelpIns_Click" />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RepHelp" runat="server" DataSourceID="SqlRepHelp" OnItemDataBound="RepHelp_ItemDataBound">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnHelpId" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Id") %>' />

                                            <div class="card mb-2">
                                                <div class="card-body p-2">
                                                    <h6 class="card-title m-0">
                                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>

                                                    </h6>
                                                    <div class="card-text m-0" style="line-height: 1.1">
                                                        <asp:Label ID="lblDescr" runat="server" Text='<%# Eval("Descr") %>' Font-Size="11px" CssClass="text-justify"></asp:Label>
                                                    </div>

                                                    <div class="h6 mb-0">
                                                        <asp:Label runat="server" class="text-muted" Font-Size="XX-Small"
                                                            Text='<%# Eval("ModDt").ToString() =="" ? "Listed On: "+Eval("CrDt","{0:dd MMM yyyy hh:mm tt}"): "Updated On: "+Eval("ModDt", "{0:dd MMM yyyy hh:mm tt}") %>'>         
                                                        </asp:Label>
                                                    </div>
                                                    <asp:LinkButton ID="lbtnEditHelp" runat="server" CssClass="card-link btn-sm text-primary"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                        OnClick="lbtnEditHelp_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnReplyHelp" runat="server" CssClass="card-link btn-sm text-success"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                        OnClick="lbtnReplyHelp_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Reply
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnResolveHelp" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnResolveHelp_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Resolve
                                                    </asp:LinkButton>
                                                    <asp:Label runat="server" CssClass="text-success" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Resolved</asp:Label>
                                                </div>
                                            </div>
                                            <div style="text-indent: 10px">
                                                <asp:Repeater ID="RepReply" runat="server">
                                                    <ItemTemplate>
                                                        <div class="card mb-2">
                                                            <div class="card-body p-2">
                                                                <asp:HiddenField ID="hdnHelpId" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Id") %>' />
                                                                <div class="card-text m-0" style="line-height: 1.1">
                                                                    <asp:Label ID="lblDescr" runat="server" Text='<%# Eval("Descr") %>' Font-Size="10px" CssClass="text-justify"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <asp:SqlDataSource runat="server" ID="SqlRepHelpReply" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="HelpReply_Sel_List" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:ControlParameter Name="HelpId" Type="Int32" ControlID="hdnHelpId" DefaultValue="0" ConvertEmptyStringToNull="true" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepHelp.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light small">No help record found!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="SqlRepHelp" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="Help_Sel_List" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="ComplexId" DefaultValue="1" ConvertEmptyStringToNull="true" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>


                    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
                    <%-- <div class="row">
                        <div class="col-md-12">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RepHelp" runat="server" DataSourceID="SqlRepHelp" OnItemDataBound="RepHelp_ItemDataBound">

                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnHelpId" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Id") %>' />
                                            <div class="media g-mb-30 media-comment">
                                                <img class="d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15" src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Image Description" />
                                                <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
                                                    <div class="g-mb-15">
                                                        <h5 class="h5 g-color-gray-dark-v1 mb-0">
                                                            <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>
                                                        </h5>
                                                        <span class="g-color-gray-dark-v4 g-font-size-12">
                                                            <asp:Label runat="server" class="text-muted" Font-Size="XX-Small"
                                                                Text='<%# Eval("ModDt").ToString() =="" ? "Listed On: "+Eval("CrDt","{0:dd MMM yyyy hh:mm tt}"): "Updated On: "+Eval("ModDt", "{0:dd MMM yyyy hh:mm tt}") %>'>         
                                                            </asp:Label>
                                                        </span>
                                                    </div>

                                                    <p>
                                                        <asp:Label ID="lblDescr" runat="server" Text='<%# Eval("Descr") %>' Font-Size="11px" CssClass="text-justify"></asp:Label>
                                                    </p>

                                                    <ul class="list-inline d-sm-flex my-0">
                                                        <li class="list-inline-item g-mr-20" runat="server" visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                            <asp:Label runat="server" CssClass="text-success" Font-Size="10px">Resolved</asp:Label>
                                                        </li>

                                                        <li class="list-inline-item g-mr-20" runat="server" visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                            <asp:LinkButton ID="lbtnEditHelp" runat="server" CssClass="card-link btn-sm text-primary"
                                                                OnClick="lbtnEditHelp_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                            </asp:LinkButton>
                                                        </li>
                                                        <li class="list-inline-item g-mr-20" runat="server" visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                            <asp:LinkButton ID="lbtnReplyHelp" runat="server" CssClass="card-link btn-sm text-success"
                                                                OnClick="lbtnReplyHelp_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Reply
                                                            </asp:LinkButton>
                                                        </li>

                                                        <li class="list-inline-item ml-auto" runat="server" visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                            <asp:LinkButton ID="lbtnResolveHelp" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnResolveHelp_Click" Font-Size="Small">
                                                                    <i class="far fa-trash-alt"></i> Resolve
                                                            </asp:LinkButton>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div style="text-indent: 10px">
                                                <asp:Repeater ID="RepReply" runat="server">
                                                    <ItemTemplate>
                                                        <div class="card mb-2">
                                                            <div class="card-body p-2">
                                                                <asp:HiddenField ID="hdnHelpId" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Id") %>' />
                                                                <div class="card-text m-0" style="line-height: 1.1">
                                                                    <asp:Label ID="lblDescr" runat="server" Text='<%# Eval("Descr") %>' Font-Size="10px" CssClass="text-justify"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                        </ItemTemplate>

                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepHelp.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light small">No help record found!
                                                </li>
                                            </ul>
                                        </FooterTemplate>

                                    </asp:Repeater>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                    </div>--%>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>
        <div class="modal fade editHelpModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Warning!</h6>

                        <div class="card border-0">
                            <div class="card-body p-2">

                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div class="form-group m-2px">
                                            <asp:Label AssociatedControlID="txtTitleForHelpUpd" runat="server" Text="Title: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                            <asp:TextBox ID="txtTitleForHelpUpd" runat="server" Placeholder="... enter a title" CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitleForHelpUpd"
                                                runat="server" Display="Dynamic" ValidationGroup="valHelpUpd" Font-Size="XX-Small" SetFocusOnError="true" />
                                        </div>

                                        <div class="form-group m-2px">
                                            <asp:Label AssociatedControlID="txtDescrForHelpUpd" runat="server" Text="Description: " CssClass="text-danger" Font-Size="Small"></asp:Label>
                                            <asp:TextBox ID="txtDescrForHelpUpd" runat="server" Placeholder="... enter a description" CssClass="form-control form-control-sm" Font-Size="Small"
                                                Height="80" TextMode="MultiLine"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescrForHelpUpd"
                                                runat="server" Display="Dynamic" ValidationGroup="valHelpUpd" Font-Size="XX-Small" SetFocusOnError="true" />
                                        </div>

                                        <div class="custom-control custom-checkbox m-1">
                                            <input type="checkbox" class="custom-control-input" id="chkHelpUpd" runat="server" clientidmode="static" />
                                            <label class="custom-control-label" for="chkHelpUpd">Terms And Condition</label>
                                        </div>

                                        <div>
                                            <asp:CustomValidator runat="server" ID="custValHelpUpd" EnableClientScript="true"
                                                Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                                ValidationGroup="valHelpUpd" OnServerValidate="custValHelpUpd_ServerValidate"
                                                ErrorMessage="* Required" ClientValidationFunction="custValHelpUpd_ClientValidate"></asp:CustomValidator>
                                        </div>

                                        <asp:Label ID="lblErroMsgHelpUpd" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                        </asp:Label>

                                        <div>
                                            <asp:Button ID="btnSubmitHelpUpd" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                                ValidationGroup="valHelpUpd" OnClick="btnSubmitHelpUpd_Click" />
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade replyHelpModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Warning!</h6>

                        <div class="card border-0">
                            <div class="card-body p-2">

                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>

                                        <div class="form-group m-2px">
                                            <asp:Label AssociatedControlID="txtDescrForHelpReply" runat="server" Text="Description: " CssClass="text-danger" Font-Size="Small"></asp:Label>
                                            <asp:TextBox ID="txtDescrForHelpReply" runat="server" Placeholder="... enter a description" CssClass="form-control form-control-sm" Font-Size="Small"
                                                Height="80" TextMode="MultiLine"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescrForHelpReply"
                                                runat="server" Display="Dynamic" ValidationGroup="valHelpReply" Font-Size="XX-Small" SetFocusOnError="true" />
                                        </div>

                                        <div class="custom-control custom-checkbox m-1">
                                            <input type="checkbox" class="custom-control-input" id="chkHelpReply" runat="server" clientidmode="static" />
                                            <label class="custom-control-label" for="chkHelpReply">Terms And Condition</label>
                                        </div>

                                        <div>
                                            <asp:CustomValidator runat="server" ID="custValHelpReply" EnableClientScript="true"
                                                Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                                ValidationGroup="valHelpReply" OnServerValidate="custValHelpReply_ServerValidate"
                                                ErrorMessage="* Required" ClientValidationFunction="custValHelpReply_ClientValidate"></asp:CustomValidator>
                                        </div>

                                        <asp:Label ID="lblErroMsgHelpReply" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                        </asp:Label>

                                        <div>
                                            <asp:Button ID="btnSubmitHelpReply" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                                ValidationGroup="valHelpReply" OnClick="btnSubmitHelpReply_Click" />
                                            <asp:LinkButton ID="lbtnX" runat="server" CssClass="btn btn-outline-danger btn-sm" ValidationGroup="valHelpReply" OnClick="lbtnX_Click" OnClientClick="return DisableButton()">
                                               <i class="fas fa-user"></i> Link Button
                                            </asp:LinkButton>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade resolveHelpModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Warning!</h6>
                        <div class="card border-0">
                            <div class="card-body text-center p-2">

                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="lbtnSubmitHelpForResolve" runat="server"
                                            CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSubmitHelpForResolve_Click">
                                                                        <i class="fas fa-check mr-1"></i>Yes
                                        </asp:LinkButton>

                                        <button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">
                                            <i class="fas fa-times mr-1"></i>No
                                        </button>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <script type="text/javascript" language="javascript">

            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
            function BeginRequestHandler(sender, args) { var oControl = args.get_postBackElement(); oControl.disabled = true; }

            //$(document).ready(function () {
            //    numberOnly();
            //    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
            //        numberOnly();
            //    });
            //});
            var pending = false;
            function DisableButton() {
                if (pending) {
                    // alert("The new patient is being created. Please wait...");
                    return false;
                }
                else {
                    if (Page_ClientValidate(""))
                        pending = true;
                    return true;
                }
            }

        </script>
    </form>
</body>
</html>
