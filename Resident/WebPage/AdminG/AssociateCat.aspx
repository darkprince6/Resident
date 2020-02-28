<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssociateCat.aspx.cs" Inherits="Resident.WebPage.AdminG.AssociateCat" %>

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
        function CustvalCatIns_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkCatIns.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function CustvalCatEdit_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkCatEdit.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function alertMsgForCatIns() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Inserted Data',
                type: 'success'
            });
        }

        function alertMsgForCatUpd() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Updated Data',
                type: 'success'
            });
        }

        function openModalForCatIns() {
            $('.open-modal-for-cat-ins').modal('show');
        }

        function closeModalForCatIns() {
            $('.open-modal-for-cat-ins').modal('hide');
        }
        function openModalForCatEdit() {
            $('.open-modal-for-cat-edit').modal('show');
        }

        function closeModalForCatEdit() {
            $('.open-modal-for-cat-edit').modal('hide');
        }
        function openModalForCatRemove() {
            $('.open-modal-for-cat-remove').modal('show');
        }

        function closeModalForCatRemove() {
            $('.open-modal-for-cat-remove').modal('hide');
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
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="text-center mb-2 mt-2">
                                <asp:LinkButton ID="lbtnAddCat" runat="server" CssClass="btn-danger btn-primary btn-sm" OnClick="lbtnAddCat_Click">
                                <i class="far fa-edit"></i> Add Category
                                </asp:LinkButton>
                                <asp:HiddenField ID="hdnPixel" runat="server" />
                            </div>

                            <asp:Repeater ID="RepCat" runat="server" DataSourceID="SqlRepCat">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnCatId" runat="server" Value='<%# Eval("Id") %>' />

                                    <div class="card mb-2">
                                        <div class="card-body p-2">
                                            <h6 class="card-title m-0">
                                                <span>
                                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>
                                                </span>
                                                <span>
                                                    <asp:LinkButton ID="lbtnEditCat" runat="server" CssClass="card-link btn-sm text-primary"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                        OnClick="lbtnEditCat_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                    </asp:LinkButton>
                                                </span>
                                                <span>
                                                    <asp:LinkButton ID="lbtnRemoveCat" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveCat_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                    </asp:LinkButton>
                                                </span>
                                                <span>
                                                    <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                    <asp:LinkButton ID="lbtnReincludeCat" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeCat_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                    </asp:LinkButton>
                                                </span>
                                            </h6>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepCat.Items.Count == 0).ToString()) %>'>
                                        <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                        </li>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="SqlRepCat" ConnectionString='<%$ ConnectionStrings:EveCon %>'
                                SelectCommand="AssociateCat_Sel_ForRep" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>

        <div class="modal fade open-modal-for-cat-ins" id="ModelForCatIns" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6 class="alert-heading">Warning!</h6>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div class="form-group m-2px">
                                    <asp:Label AssociatedControlID="txtCatIns" runat="server" Text="Category: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                    <asp:TextBox ID="txtCatIns" runat="server" Placeholder="... enter a category" CssClass="form-control form-control-sm"></asp:TextBox>
                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtCatIns"
                                        runat="server" Display="Dynamic" ValidationGroup="valCatIns" Font-Size="XX-Small" SetFocusOnError="true" />
                                </div>

                                <div class="custom-control custom-checkbox m-1">
                                    <input type="checkbox" class="custom-control-input" id="chkCatIns" runat="server" clientidmode="static" />
                                    <label class="custom-control-label" for="chkCatIns">Terms And Condition</label>
                                </div>

                                <div>
                                    <asp:CustomValidator runat="server" ID="CustvalCatIns" EnableClientScript="true"
                                        Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                        ValidationGroup="valCatIns" OnServerValidate="CustvalCatIns_ServerValidate"
                                        ErrorMessage="* Required" ClientValidationFunction="CustvalCatIns_ClientValidate"></asp:CustomValidator>
                                </div>

                                <asp:Label ID="lblMsgCatIns" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                </asp:Label>
                                <hr />
                                <div class="mb-0">
                                    <asp:LinkButton ID="lbtnCatInsSubmit" runat="server" ValidationGroup="valCatIns"
                                        CssClass="btn btn-outline-success btn-sm " OnClick="lbtnCatInsSubmit_Click">
                                                                        Submit
                                    </asp:LinkButton>

                                    <button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">
                                        Close
                                    </button>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-modal-for-cat-edit" id="ModelForCatEdit" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6 class="alert-heading">Warning!</h6>

                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div class="form-group m-2px">
                                    <asp:Label AssociatedControlID="txtCatEdit" runat="server" Text="Category: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                    <asp:TextBox ID="txtCatEdit" runat="server" Placeholder="... enter a category" CssClass="form-control form-control-sm"></asp:TextBox>
                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtCatEdit"
                                        runat="server" Display="Dynamic" ValidationGroup="valCatEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                </div>

                                <div class="custom-control custom-checkbox m-1">
                                    <input type="checkbox" class="custom-control-input" id="chkCatEdit" runat="server" clientidmode="static" />
                                    <label class="custom-control-label" for="chkCatEdit">Terms And Condition</label>
                                </div>

                                <div>
                                    <asp:CustomValidator runat="server" ID="CustvalCatEdit" EnableClientScript="true"
                                        Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                        ValidationGroup="valCatEdit" OnServerValidate="CustvalCatEdit_ServerValidate"
                                        ErrorMessage="* Required" ClientValidationFunction="CustvalCatEdit_ClientValidate"></asp:CustomValidator>
                                </div>

                                <asp:Label ID="lblMsgCatEdit" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                </asp:Label>
                                <hr />
                                <div class="mb-0">

                                    <asp:LinkButton ID="lbtnCatEditSubmit" runat="server" ValidationGroup="valCatEdit"
                                        CssClass="btn btn-outline-success btn-sm " OnClick="lbtnCatEditSubmit_Click">
                                                                        Submit
                                    </asp:LinkButton>

                                    <button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">
                                        Close
                                    </button>


                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade open-modal-for-cat-remove" id="ModelForCatRemove" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6 class="alert-heading">Warning!</h6>

                        <div class="mb-0 text-center">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:LinkButton ID="lbtnCatRemoveSubmit" runat="server"
                                        CssClass="btn btn-outline-success btn-sm " OnClick="lbtnCatRemoveSubmit_Click">
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
    </form>
</body>

</html>
