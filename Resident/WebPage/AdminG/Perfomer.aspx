<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Perfomer.aspx.cs" Inherits="Resident.WebPage.AdminG.Perormer" %>

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
        function custValPerf_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkPerf.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function openModalForPerformer() {
            $('.performerInsModal').modal('show');
        }

        function closeModalForPerformer() {
            $('.performerInsModal').modal('hide');
        }

        function alertMsgForPerformer() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully added a new performer',
                type: 'success'
            });
        }


    </script>
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
                                    <span>
                                    <asp:LinkButton ID="lbtnAddPerf" runat="server" OnClick="lbtnAddPerf_Click" CssClass="btn btn-outline-primary btn-sm small">
                                        <i class="fas fa-star mr-1" style="color:#fd7e14"></i>Add Performer
                                    </asp:LinkButton>
                                        </span>
                                    <span>
                                        <asp:LinkButton ID="lbtnAddSubPerf" runat="server" OnClick="lbtnAddSubPerf_Click" CssClass="btn btn-outline-primary btn-sm small">
                                        <i class="fas fa-star mr-1" style="color:#fd7e14"></i>Add Sub Performer
                                    </asp:LinkButton>
                                    </span>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>
        <div class="modal fade performerInsModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6 class="alert-heading">Warning!</h6>
                        <div class="card border-0">
                            <div class="card-body p-0">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>

                                        <asp:HiddenField ID="hdnPixelPerf" runat="server" />

                                        <div class="form-group m-2px">
                                            <asp:Label AssociatedControlID="txtNamePerf" runat="server" Text="Name: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                            <asp:TextBox ID="txtNamePerf" runat="server" Placeholder="... enter a performer name" CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNamePerf"
                                                runat="server" Display="Dynamic" ValidationGroup="valPerf" Font-Size="XX-Small" SetFocusOnError="true" />
                                        </div>

                                        <div class="form-group m-2px">
                                            <asp:Label AssociatedControlID="txtCapecityPerf" runat="server" Text="Capacity: " Font-Size="Small"></asp:Label>
                                            <asp:TextBox ID="txtCapecityPerf" runat="server" Placeholder="... enter a capacity" CssClass="form-control form-control-sm" Font-Size="Small"
                                                Height="60" TextMode="MultiLine"></asp:TextBox>
                                        </div>

                                        <div class="form-group m-2px">
                                            <asp:Label AssociatedControlID="txtDescrPerf" runat="server" Text="Description: " Font-Size="Small"></asp:Label>
                                            <asp:TextBox ID="txtDescrPerf" runat="server" Placeholder="... enter a description" CssClass="form-control form-control-sm" Font-Size="Small"
                                                Height="80" TextMode="MultiLine"></asp:TextBox>
                                        </div>

                                        <div class="form-group m-2px">
                                            <asp:Label AssociatedControlID="txtPriorityPerf" runat="server" Text="Priority: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                            <asp:TextBox ID="txtPriorityPerf" runat="server" Placeholder="... enter an prority" CssClass="form-control form-control-sm number-only"
                                                Font-Size="Small" Text="0"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPriorityPerf"
                                                runat="server" Display="Dynamic" ValidationGroup="valPerf" Font-Size="XX-Small" SetFocusOnError="true" />
                                        </div>

                                        <div class="custom-control custom-checkbox m-1">
                                            <input type="checkbox" class="custom-control-input" id="chkPerf" runat="server" clientidmode="static" />
                                            <label class="custom-control-label" for="chkPerf">Terms And Condition</label>
                                        </div>

                                        <div>
                                            <asp:CustomValidator runat="server" ID="custValPerf" EnableClientScript="true"
                                                Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                                ValidationGroup="valPerf" OnServerValidate="custValPerf_ServerValidate"
                                                ErrorMessage="* Required" ClientValidationFunction="custValPerf_ClientValidate"></asp:CustomValidator>
                                        </div>

                                        <asp:Label ID="lblErroMsgPerf" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                        </asp:Label>

                                        <div>
                                            <asp:Button ID="btnSubmitPerf" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                                ValidationGroup="valPerf" OnClick="btnSubmitPerf_Click" />
                                             

                                            <asp:Button ID="btnCancelPerf" runat="server" Text="Cancel" CssClass="btn btn-outline-danger btn-sm"
                                                OnClick="btnCancelPerf_Click" />
                                            </div>
                                        <%--<div id="divSubPerf" runat="server" visible="false">
                                            <asp:Button ID="btnSubmitSubPerf" runat="server" Text="Submit2" CssClass="btn btn-outline-success btn-sm"
                                                ValidationGroup="valPerf" OnClick="btnSubmitSubPerf_Click" />

                                            <asp:Button ID="btnCancelSubPerf" runat="server" Text="Cancel2" CssClass="btn btn-outline-danger btn-sm"
                                                OnClick="btnCancelSubPerf_Click" />--%>


                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
