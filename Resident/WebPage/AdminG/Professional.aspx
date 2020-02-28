<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Professional.aspx.cs" Inherits="Resident.WebPage.AdminG.Professional" %>

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
        function custValProf_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkProf.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function openRemoveModalForProfessional() {
            $('.profRemoveModal').modal('show');
        }

        function closeRemoveModalForProfessional() {
            $('.profRemoveModal').modal('hide');
        }

        function alertMsgForProfessionalIns() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully added a new professional',
                type: 'success'
            });
        }

        function openReincludeModalForProfessional() {
            $('.profReincludeModal').modal('show');
        }

        function closeReincludeModalForProfessional() {
            $('.profReincludeModal').modal('hide');
        }

        function alertMsgForProfessionalUpd() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully updated professional',
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
                                    <asp:HiddenField ID="hdnPixelProf" runat="server" />

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtNameProf" runat="server" Text="Name: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtNameProf" runat="server" Placeholder="... enter a professional name" CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNameProf"
                                            runat="server" Display="Dynamic" ValidationGroup="valProf" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>
                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtPhoneProf" runat="server" Text="Phone: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtPhoneProf" runat="server" Placeholder="... enter a phone" CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtEmailProf" runat="server" Text="Email: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtEmailProf" runat="server" Placeholder="... enter an email" CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtDescrProf" runat="server" Text="Description: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtDescrProf" runat="server" Placeholder="... enter a description" CssClass="form-control form-control-sm" Font-Size="Small"
                                            Height="80" TextMode="MultiLine"></asp:TextBox>
                                    </div>

                                    <div class="custom-control custom-checkbox m-1">
                                        <input type="checkbox" class="custom-control-input" id="chkProf" runat="server" clientidmode="static" />
                                        <label class="custom-control-label" for="chkProf">Terms And Condition</label>
                                    </div>

                                    <div>
                                        <asp:CustomValidator runat="server" ID="custValProf" EnableClientScript="true"
                                            Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                            ValidationGroup="valProf" OnServerValidate="custValProf_ServerValidate"
                                            ErrorMessage="* Required" ClientValidationFunction="custValProf_ClientValidate"></asp:CustomValidator>
                                    </div>

                                    <asp:Label ID="lblErroMsgProf" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                    </asp:Label>

                                    <div>
                                        <asp:Button ID="btnSubmitProf" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                            ValidationGroup="valProf" OnClick="btnSubmitProf_Click" />
                                        <asp:Button ID="btnUpdateProf" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm" Visible="false"
                                            ValidationGroup="valProf" OnClick="btnUpdateProf_Click" />

                                        <asp:Button ID="btnCancelProf" runat="server" Text="Cancel" CssClass="btn btn-outline-danger btn-sm"
                                            OnClick="btnCancelProf_Click" />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RepProfessional" runat="server" DataSourceID="SqlRepProfessional">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnProfessionalId" runat="server" Value='<%# Eval("Id") %>' />

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

                                                    <asp:LinkButton ID="lbtnEditProf" runat="server" CssClass="card-link btn-sm text-primary"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                        OnClick="lbtnEditProf_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnRemoveProf" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveProf_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                    </asp:LinkButton>
                                                    <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                    <asp:LinkButton ID="lbtnReincludeProf" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeProf_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepProfessional.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="SqlRepProfessional" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="EventProfessional_Sel_List" SelectCommandType="StoredProcedure">
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

        <div class="modal fade profRemoveModal" role="dialog" aria-hidden="false">
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
                                        <asp:LinkButton ID="lbtnSubmitProfForRemove" runat="server"
                                            CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSubmitProfForRemove_Click">
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

        <div class="modal fade profReincludeModal" role="dialog" aria-hidden="false">
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
                                        <asp:LinkButton ID="lbtnSubmitProfForReinclude" runat="server"
                                            CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSubmitProfForReinclude_Click">
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
