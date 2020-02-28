<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Celebrity.aspx.cs" Inherits="Resident.WebPage.AdminG.Celebrity" %>

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
        function custValCeleb_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkCeleb.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function openModalForCelebrity() {
            $('.celebrityInsModal').modal('show');
        }

        function closeModalForCelebrity() {
            $('.celebrityInsModal').modal('hide');
        }

        function alertMsgForCelebrity() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully added a new celebrity',
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
                                    <asp:LinkButton ID="lbtnAddCeleb" runat="server" OnClick="lbtnAddCeleb_Click" CssClass="btn btn-outline-primary btn-sm small">
                                        <i class="fas fa-star mr-1" style="color:#fd7e14"></i>Add Celebrity
                                    </asp:LinkButton>
                                        </span>
                                    <span>
                                        <asp:LinkButton ID="lbtnAddSubCeleb" runat="server" OnClick="lbtnAddSubCeleb_Click" CssClass="btn btn-outline-primary btn-sm small">
                                        <i class="fas fa-star mr-1" style="color:#fd7e14"></i>Add Sub Celebrity
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
        <div class="modal fade celebrityInsModal" role="dialog" aria-hidden="false">
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

                                        <asp:HiddenField ID="hdnPixelCeleb" runat="server" />

                                        <div class="form-group m-2px">
                                            <asp:Label AssociatedControlID="txtNameCeleb" runat="server" Text="Name: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                            <asp:TextBox ID="txtNameCeleb" runat="server" Placeholder="... enter a celebrity name" CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNameCeleb"
                                                runat="server" Display="Dynamic" ValidationGroup="valCeleb" Font-Size="XX-Small" SetFocusOnError="true" />
                                        </div>

                                        <div class="form-group m-2px">
                                            <asp:Label AssociatedControlID="txtDescrCeleb" runat="server" Text="Description: " Font-Size="Small"></asp:Label>
                                            <asp:TextBox ID="txtDescrCeleb" runat="server" Placeholder="... enter a description" CssClass="form-control form-control-sm" Font-Size="Small"
                                                Height="80" TextMode="MultiLine"></asp:TextBox>
                                        </div>

                                        <div class="form-group m-2px">
                                            <asp:Label AssociatedControlID="txtPriorityCeleb" runat="server" Text="Priority: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                            <asp:TextBox ID="txtPriorityCeleb" runat="server" Placeholder="... enter an prority" CssClass="form-control form-control-sm number-only"
                                                Font-Size="Small" Text="0"></asp:TextBox>
                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPriorityCeleb"
                                                runat="server" Display="Dynamic" ValidationGroup="valCeleb" Font-Size="XX-Small" SetFocusOnError="true" />
                                        </div>

                                        <div class="custom-control custom-checkbox m-1">
                                            <input type="checkbox" class="custom-control-input" id="chkCeleb" runat="server" clientidmode="static" />
                                            <label class="custom-control-label" for="chkCeleb">Terms And Condition</label>
                                        </div>

                                        <div>
                                            <asp:CustomValidator runat="server" ID="custValCeleb" EnableClientScript="true"
                                                Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                                ValidationGroup="valCeleb" OnServerValidate="custValCeleb_ServerValidate"
                                                ErrorMessage="* Required" ClientValidationFunction="custValCeleb_ClientValidate"></asp:CustomValidator>
                                        </div>

                                        <asp:Label ID="lblErroMsgCeleb" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                        </asp:Label>

                                        <div>
                                            <asp:Button ID="btnSubmitCeleb" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                                ValidationGroup="valCeleb" OnClick="btnSubmitCeleb_Click" />
                                             

                                            <asp:Button ID="btnCancelCeleb" runat="server" Text="Cancel" CssClass="btn btn-outline-danger btn-sm"
                                                OnClick="btnCancelCeleb_Click" />
                                            </div>
                                        <%--<div id="divSubCeleb" runat="server" visible="false">
                                            <asp:Button ID="btnSubmitSubCeleb" runat="server" Text="Submit2" CssClass="btn btn-outline-success btn-sm"
                                                ValidationGroup="valCeleb" OnClick="btnSubmitSubCeleb_Click" />

                                            <asp:Button ID="btnCancelSubCeleb" runat="server" Text="Cancel2" CssClass="btn btn-outline-danger btn-sm"
                                                OnClick="btnCancelSubCeleb_Click" />--%>

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
