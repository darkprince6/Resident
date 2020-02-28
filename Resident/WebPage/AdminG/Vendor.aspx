 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Vendor.aspx.cs" Inherits="Resident.WebPage.AdminG.Vendor" %>

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
        function custValVendor_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkVendor.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function openRemoveModalForVendor() {
            $('.vendorRemoveModal').modal('show');
        }

        function closeRemoveModalForVendor() {
            $('.vendorRemoveModal').modal('hide');
        }

        function alertMsgForVendorIns() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully added a new vendor',
                type: 'success'
            });
        }

        function openReincludeModalForVendor() {
            $('.vendorReincludeModal').modal('show');
        }

        function closeReincludeModalForVendor() {
            $('.vendorReincludeModal').modal('hide');
        }

        function alertMsgForVendorUpd() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully updated vendor',
                type: 'success'
            });
        }

        ////function capLock(e) {
        ////    var kc = e.keyCode ? e.keyCode : e.which;
        ////    var sk = e.shiftKey ? e.shiftKey : kc === 16;
        ////    var visibility = ((kc >= 65 && kc <= 90) && !sk) ||
        ////        ((kc >= 97 && kc <= 122) && sk) ? 'visible' : 'hidden';
        ////    document.getElementById('divMayus').style.visibility = visibility
        ////}

        //function capLock(e) {
        //    var kc = e.keyCode ? e.keyCode : e.which;
        //    var sk = e.shiftKey ? e.shiftKey : kc === 16;
        //    var visibility = ((kc >= 65 && kc <= 90) && !sk) ||
        //        ((kc >= 97 && kc <= 122) && sk) ? 'visible' : 'hidden';
        //    document.getElementById('divMayus').style.visibility = visibility
        //}

    </script>

    <script>
        $(document).ready(function () {
            capsLock();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
                capsLock();
            });
        });


        function capsLock() {
            //window.onload = function () {
            var input = document.getElementById("txtNameVendor");
            var text = document.getElementById("capsAlert");
            input.addEventListener("keyup", function (event) {

                if (event.getModifierState("CapsLock")) {
                    text.style.display = "block";
                } else {
                    text.style.display = "none"
                }
            });
            //}
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
                                    <asp:HiddenField ID="hdnPixelVendor" runat="server" />

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtNameVendor" runat="server" Text="Name: *" CssClass="text-danger" Font-Size="Small"></asp:Label>

                                        <asp:TextBox ID="txtNameVendor" runat="server" Placeholder="... enter a vendor name" ClientIDMode="Static"
                                            CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>

                                        <div id="capsAlert" class="p-1 small text-info" style="display:none; font-size:xx-small; font-weight:500" role="alert">
                                            <i class="fas fa-dot-circle mr-1" style="color:#fd7e14"></i>Caps lock on
                                        </div>

                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNameVendor"
                                            runat="server" Display="Dynamic" ValidationGroup="valVendor" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>
                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtPhoneVendor" runat="server" Text="Phone: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtPhoneVendor" runat="server" Placeholder="... enter a phone" CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtEmailVendor" runat="server" Text="Email: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtEmailVendor" runat="server" Placeholder="... enter an email" CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtDescrVendor" runat="server" Text="Description: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtDescrVendor" runat="server" Placeholder="... enter a description" CssClass="form-control form-control-sm" Font-Size="Small"
                                            Height="80" TextMode="MultiLine"></asp:TextBox>
                                    </div>

                                    <div class="custom-control custom-checkbox m-1">
                                        <input type="checkbox" class="custom-control-input" id="chkVendor" runat="server" clientidmode="static" />
                                        <label class="custom-control-label" for="chkVendor">Terms And Condition</label>
                                    </div>

                                    <div>
                                        <asp:CustomValidator runat="server" ID="custValVendor" EnableClientScript="true"
                                            Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                            ValidationGroup="valVendor" OnServerValidate="custValVendor_ServerValidate"
                                            ErrorMessage="* Required" ClientValidationFunction="custValVendor_ClientValidate"></asp:CustomValidator>
                                    </div>

                                    <asp:Label ID="lblErroMsgVendor" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                    </asp:Label>

                                    <div>
                                        <asp:Button ID="btnSubmitVendor" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                            ValidationGroup="valVendor" OnClick="btnSubmitVendor_Click" />
                                        <asp:Button ID="btnUpdateVendor" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm" Visible="false"
                                            ValidationGroup="valVendor" OnClick="btnUpdateVendor_Click" />

                                        <asp:Button ID="btnCancelVendor" runat="server" Text="Cancel" CssClass="btn btn-outline-danger btn-sm"
                                            OnClick="btnCancelVendor_Click" />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RepVendor" runat="server" DataSourceID="SqlRepVendor">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnVendorId" runat="server" Value='<%# Eval("Id") %>' />

                                            <div class="card mb-2">
                                                <div class="card-body p-2">
                                                    <h6 class="card-title m-0">
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>

                                                    </h6>
                                                    <div class="card-text m-0" style="line-height: 1.1">
                                                        <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>' Font-Size="Small"></asp:Label>
                                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' Font-Size="Small"></asp:Label>
                                                        <asp:Label ID="lblDescr" runat="server" Text='<%# Eval("Descr") %>' Font-Size="11px" CssClass="text-justify"></asp:Label>
                                                    </div>

                                                    <div class="h6 mb-0">
                                                        <asp:Label runat="server" class="text-muted" Font-Size="XX-Small"
                                                            Text='<%# Eval("ModDt").ToString() =="" ? "Listed On: "+Eval("CrDt","{0:dd MMM yyyy hh:mm tt}"): "Updated On: "+Eval("ModDt", "{0:dd MMM yyyy hh:mm tt}") %>'>         
                                                        </asp:Label>
                                                    </div>

                                                    <asp:LinkButton ID="lbtnEditVendor" runat="server" CssClass="card-link btn-sm text-primary"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                        OnClick="lbtnEditVendor_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnRemoveVendor" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveVendor_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                    </asp:LinkButton>
                                                    <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                    <asp:LinkButton ID="lbtnReincludeVendor" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeVendor_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepVendor.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="SqlRepVendor" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="EventVendor_Sel_List" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="EventId" DefaultValue="1" ConvertEmptyStringToNull="true" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>

                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>

        <div class="modal fade vendorRemoveModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Warning!</h6>
                        <%-- <p>
                           <i class="fas fa-exclamation-triangle text-danger mr-1"></i> Are you want to remove from current list?
                        </p>--%>

                        <div class="card border-0">
                            <div class="card-body text-center p-2">

                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="lbtnSubmitVendorForRemove" runat="server"
                                            CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSubmitVendorForRemove_Click">
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

        <div class="modal fade vendorReincludeModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Warning!</h6>
                        <%-- <p>
                           <i class="fas fa-exclamation-triangle text-danger mr-1"></i> Are you want to remove from current list?
                        </p>--%>

                        <div class="card border-0">
                            <div class="card-body text-center p-2">

                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="lbtnSubmitVendorForReinclude" runat="server"
                                            CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSubmitVendorForReinclude_Click">
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

    </form>
</body>
</html>
