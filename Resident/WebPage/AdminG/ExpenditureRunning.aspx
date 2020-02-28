<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExpenditureRunning.aspx.cs" Inherits="Resident.WebPage.AdminG.ExpenditureRunning" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.2/plugins/confirmDate/confirmDate.css" />


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.2/plugins/confirmDate/confirmDate.js"></script>

    <title></title>
    <style>
        .custom-span {
            color: crimson;
            font-size: small
        }
    </style>
    <script>
        function openModal() {
            $('.openmodal').modal('show');
        }

        function closeModal() {
            $('.openmodal').modal('hide');
        }
        function alertMsgForExpenditure() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Updated Expenditure',
                type: 'success'
            });
        }
    </script>
    <style>
        body.modal-open {
            overflow: hidden;
        }
    </style>
</head>
<body style="line-height: unset">
    <form id="form1" runat="server">
        <div class="container">
            <div class="row mt-2">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="row">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-8">
                            <div class="card">
                                <div class="card-body">

                                    <div class="form-group">
                                        <asp:Label ID="lblHead" AssociatedControlID="txtHead" runat="server" CssClass="small" Text="Head"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtHead" CssClass="form-control form-control-sm" Placeholder="..enter a head"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtHead"
                                            runat="server" Display="Dynamic" ValidationGroup="valExpRunning" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>

                                    <div class="form-group">
                                        <asp:Label ID="lblSubItem" AssociatedControlID="txtSubItem" runat="server" CssClass="small" Text="Sub Item"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtSubItem" CssClass="form-control form-control-sm" Placeholder="..enter subitem"></asp:TextBox>
                                    </div>

                                    <div class="form-group">
                                        <asp:Label ID="lblAmount" AssociatedControlID="txtAmount" runat="server" CssClass="small" Text="Amount"></asp:Label>
                                        <div class="input-group input-group-sm">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">Rs.</span>
                                            </div>
                                            <asp:TextBox runat="server" ID="txtAmount" CssClass="form-control form-control-sm" Placeholder="..enter an amount"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <asp:Label ID="lblPaymtIssuedBy" AssociatedControlID="txtPaymtIssuedBy" runat="server" CssClass="small" Text="Payment Issued By"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtPaymtIssuedBy" CssClass="form-control form-control-sm" Placeholder="..enter payment issued by"></asp:TextBox>
                                    </div>

                                    <div class="form-group">
                                        <asp:Label ID="lblApprovalDetails" AssociatedControlID="txtApprovalDetails" runat="server" CssClass="small" Text="Approval Details"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtApprovalDetails" CssClass="form-control form-control-sm" Placeholder="..enter approval details"></asp:TextBox>
                                    </div>
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-outline-primary btn-sm" ValidationGroup="valExpRunning" OnClick="btnSubmit_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-2"></div>
                    </div>
                </div>
                <div class="col-sm-2"></div>
            </div>

            <div class="row mt-2">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="row">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-8">
                            <div class="card">
                                <div class="card-body">
                                    <asp:Repeater ID="RepExpenditureRunning" runat="server" DataSourceID="SqlRepExpenditureRunning">
                                        <ItemTemplate>
                                            <div class="card mb-2">
                                                <div class="card-body">
                                                    <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("Id") %>' />

                                                    <h6 class="card-title mb-1">
                                                        <asp:Label ID="lblHead" runat="server" Text='<%# Eval("Head") %>'></asp:Label>
                                                        <div>
                                                            <span class="custom-span">Amount: <i class="fas fa-rupee-sign" style="color: lightcoral; font-size: small"></i></span>
                                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount") %>' Font-Size="Small"></asp:Label>

                                                        </div>

                                                    </h6>
                                                    <div class="card-text">
                                                        <div>
                                                            <span class="custom-span">Itemes:</span>
                                                            <asp:Label ID="lblSubItem" runat="server" Text='<%# Eval("SubItem") %>' Font-Size="Small"></asp:Label>
                                                        </div>

                                                        <div>
                                                            <span class="custom-span">Paymt Issued By:</span>
                                                            <asp:Label ID="lblPaymtIssuedBy" runat="server" Text='<%# Eval("PaymtIssuedBy") %>' Font-Size="Small"></asp:Label>
                                                        </div>


                                                        <div>
                                                            <span class="custom-span">Details:</span>
                                                            <asp:Label ID="lblApprovalDetails" runat="server" Text='<%# Eval("ApprovalDetails") %>' Font-Size="Small"></asp:Label>
                                                        </div>
                                                        <div>
                                                            <asp:Label ID="lblApproved" runat="server" CssClass="text-success" Font-Size="Small" Visible='<%#((bool)Eval("ApprovalStatus"))==true? true:false %>'>Approved <i class="fas fa-check-circle"></i></asp:Label>
                                                            <asp:Label ID="lblPending" runat="server" CssClass="text-warning" Font-Size="Small" Visible='<%#((bool)Eval("ApprovalStatus"))==false? true:false %>'>Pending <i class="fas fa-exclamation-circle"></i></asp:Label>

                                                        </div>
                                                        <div>
                                                            <asp:LinkButton ID="lbtnUpdate" runat="server" CssClass="btn btn-link text-primary p-0" OnClick="lbtnUpdate_Click" Font-Size="X-Small"><i class="far fa-edit"></i> Edit</asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="SqlRepExpenditureRunning" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="ExpenditureRunning_Sel_ForView" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="1" Name="ComplexId" Type="Int32"></asp:Parameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-2"></div>
                    </div>
                </div>
                <div class="col-sm-2"></div>
            </div>


            <div class="modal fade openmodal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Update Expenditure</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body p-0">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card">
                                        <div class="card-body">

                                            <asp:HiddenField ID="hdnExpenditureId" runat="server" />
                                            <div class="form-group">
                                                <asp:Label ID="lblHeadModal" AssociatedControlID="txtHeadModal" runat="server" CssClass="small" Text="Head"></asp:Label>
                                                <asp:TextBox runat="server" ID="txtHeadModal" CssClass="form-control form-control-sm" Placeholder="..enter a head"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtHeadModal"
                                                    runat="server" Display="Dynamic" ValidationGroup="valExpRunningModal" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="lblSubItemModal" AssociatedControlID="txtSubItemModal" runat="server" CssClass="small" Text="Sub Item"></asp:Label>
                                                <asp:TextBox runat="server" ID="txtSubItemModal" CssClass="form-control form-control-sm" Placeholder="..enter subitem"></asp:TextBox>
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="lblAmountModal" AssociatedControlID="txtAmountModal" runat="server" CssClass="small" Text="Amount"></asp:Label>
                                                <div class="input-group input-group-sm">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text">Rs.</span>
                                                    </div>
                                                    <asp:TextBox runat="server" ID="txtAmountModal" CssClass="form-control form-control-sm" Placeholder="..enter an amount"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="lblPaymtIssuedByModal" AssociatedControlID="txtPaymtIssuedByModal" runat="server" CssClass="small" Text="Payment Issued By"></asp:Label>
                                                <asp:TextBox runat="server" ID="txtPaymtIssuedByModal" CssClass="form-control form-control-sm" Placeholder="..enter payment issued by"></asp:TextBox>
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="lblApprovalDetailsModal" AssociatedControlID="txtApprovalDetailsModal" runat="server" CssClass="small" Text="Approval Details"></asp:Label>
                                                <asp:TextBox runat="server" ID="txtApprovalDetailsModal" CssClass="form-control form-control-sm" Placeholder="..enter approval details"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">

                            <asp:Button ID="btnSubmitModal" runat="server" Text="Update" CssClass="btn btn-outline-primary btn-sm" ValidationGroup="valExpRunningModal" OnClick="btnSubmitModal_Click" />
                            <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
