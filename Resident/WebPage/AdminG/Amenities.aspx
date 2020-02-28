<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Amenities.aspx.cs" Inherits="Resident.WebPage.AdminG.Amenities" %>

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
        function CustvalAmenities_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkAmenities.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function alertMsgForAmenities() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Inserted Data',
                type: 'success'
            });
        }

        function alertMsgForAmenitiesUpd() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Updated Data',
                type: 'success'
            });
        }

        function openModalForRemove() {
            $('.amenitiesRemoveModal').modal('show');
        }

        function closeModalForRemove() {
            $('.amenitiesRemoveModal').modal('hide');
        }
    </script>
</head>
<body class="fu">
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
                                    <div class="row" id="divAmenities" runat="server">
                                        <div class="col-sm-12">
                                            <asp:HiddenField ID="hdnPixel" runat="server" />

                                            <div class="form-group m-2px">
                                                <asp:Label AssociatedControlID="txtTitle" runat="server" Text="Title: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                <asp:TextBox ID="txtTitle" runat="server" Placeholder="... enter a title" CssClass="form-control form-control-sm"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitle"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAmenities" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>

                                            <div class="form-group m-2px">
                                                <asp:Label AssociatedControlID="txtDescr" runat="server" Text="Address: " Font-Size="Small"></asp:Label>
                                                <asp:TextBox ID="txtDescr" runat="server" Placeholder="... enter a description" CssClass="form-control form-control-sm" Height="80" TextMode="MultiLine"></asp:TextBox>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAmenities" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>

                                            <div class="custom-control custom-checkbox m-1">
                                                <input type="checkbox" class="custom-control-input" id="chkAmenities" runat="server" clientidmode="static" />
                                                <label class="custom-control-label" for="chkAmenities">Terms And Condition</label>
                                            </div>

                                            <div>
                                                <asp:CustomValidator runat="server" ID="CustvalAmenities" EnableClientScript="true"
                                                    Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                                    ValidationGroup="valAmenities" OnServerValidate="CustvalAmenities_ServerValidate"
                                                    ErrorMessage="* Required" ClientValidationFunction="CustvalAmenities_ClientValidate"></asp:CustomValidator>
                                            </div>

                                            <asp:Label ID="lblErroMsg" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                            </asp:Label>

                                            <div>
                                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                                    ValidationGroup="valAmenities" OnClick="btnSubmit_Click" />

                                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-outline-success btn-sm" Visible="false"
                                                    ValidationGroup="valAmenities" OnClick="btnUpdate_Click" />

                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-danger btn-sm"
                                                    OnClick="btnCancel_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RepAmenities" runat="server" DataSourceID="SqlRepAmenities">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnAmenitiesId" runat="server" Value='<%# Eval("Id") %>' />

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

                                                    <asp:LinkButton ID="lbtnEdit" runat="server" CssClass="card-link btn-sm text-primary"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                        OnClick="lbtnEdit_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnRemove" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemove_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                    </asp:LinkButton>
                                                    <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                    <asp:LinkButton ID="lbtnReinclude" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReinclude_Click" Font-Size="Small"
                                                        Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepAmenities.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="SqlRepAmenities" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="Amenities_Sel_List" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="ComplexId" DefaultValue="1" ConvertEmptyStringToNull="true" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RepAmenitiesP" runat="server" DataSourceID="SqlRepAmenitiesP">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnAmenitiesId" runat="server" Value='<%# Eval("Id") %>' />

                                            <div class="card mb-2">
                                                <div class="card-body p-2">
                                                    <h6 class="card-title m-0">
                                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>

                                                    </h6>
                                                    <div class="card-text m-0" style="line-height: 1.1">
                                                        <asp:Label ID="lblDescr" runat="server" Text='<%# Eval("Descr") %>' Font-Size="11px" CssClass="text-justify"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepAmenitiesP.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="SqlRepAmenitiesP" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="Amenities_Sel_List" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="ComplexId" DefaultValue="1" ConvertEmptyStringToNull="true" />
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

        <div class="modal fade amenitiesRemoveModal" role="dialog" aria-hidden="false">
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
                                        <asp:LinkButton ID="lbtnSubmitForRemove" runat="server"
                                            CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSubmitForRemove_Click">
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
