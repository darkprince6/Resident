<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Associate.aspx.cs" Inherits="Resident.WebPage.AdminG.Associate" %>

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
        function CustvalAssoIns_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkAssociate.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function CustvalAssoCat_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkAssoCat.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }


        function alertMsgForAssociateIns() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Inserted Data',
                type: 'success'
            });
        }

        function alertMsgForAssociateUpd() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Updated Data',
                type: 'success'
            });
        }

        function openModalForAssociateRemove() {
            $('.open-modal-for-associate-remove').modal('show');
        }

        function closeModalForAssociateRemove() {
            $('.open-modal-for-associate-remove').modal('hide');
        }

        function openModalForAssoCat() {
            $('.open-modal-for-asso-cat').modal('show');
        }

        function closeModalForAssoCat() {
            $('.open-modal-for-asso-cat').modal('hide');
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
                            <div class="card">
                                <div class="card-body">


                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="ddlAssociateCat" runat="server" Text="Choose a Associate Category: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                        <asp:DropDownList ID="ddlAssociateCat" runat="server" CssClass="form-control form-control-sm" Font-Size="Small" DataSourceID="SqlddlAssoCat"
                                            DataTextField="Name" DataValueField="Id" AppendDataBoundItems="true">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="ddlAssociateCat"
                                            runat="server" Display="Dynamic" ValidationGroup="valAssociate" Font-Size="XX-Small" SetFocusOnError="true" InitialValue="0" />
                                        <asp:SqlDataSource runat="server" ID="SqlddlAssoCat" ConnectionString='<%$ ConnectionStrings:EveCon %>'
                                            SelectCommand="SELECT [Id], [Name] FROM [EAssociatesCategory] WHERE ([EId] = @EventId) AND IsDel=0">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="EventId" Name="EventId" Type="Int32"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <span style="font-size: 12px">You can add it 
                                    <asp:LinkButton ID="lbtnAddAssoCat" runat="server" OnClick="lbtnAddAssoCat_Click">
                                       here
                                    </asp:LinkButton>
                                            <asp:HiddenField ID="hdnPixelAssociate" runat="server" />
                                        </span>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtNameAsso" runat="server" Text="Name: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtNameAsso" runat="server" Placeholder="... enter a name" CssClass="form-control form-control-sm"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNameAsso"
                                            runat="server" Display="Dynamic" ValidationGroup="valAssociate" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>
                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtBNameAsso" runat="server" Text="Brand Name: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtBNameAsso" runat="server" Placeholder="... enter a brand name" CssClass="form-control form-control-sm"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtBNameAsso"
                                            runat="server" Display="Dynamic" ValidationGroup="valAssociate" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>



                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtAddressAsso" runat="server" Text="Address: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtAddressAsso" runat="server" Placeholder="... enter an address line" CssClass="form-control form-control-sm" Height="100" TextMode="MultiLine"></asp:TextBox>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtPhoneAsso" runat="server" Text="Phone: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtPhoneAsso" runat="server" Placeholder="... enter a phone" CssClass="form-control form-control-sm"> </asp:TextBox>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtMobileAsso" runat="server" Text="Mobile: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtMobileAsso" runat="server" Placeholder="... enter a mobile" CssClass="form-control form-control-sm"></asp:TextBox>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtEmailAsso" runat="server" Text="Email: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtEmailAsso" runat="server" Placeholder="... enter a email" CssClass="form-control form-control-sm"></asp:TextBox>
                                    </div>

                                    <div class="form-group m-2px">
                                        <asp:Label AssociatedControlID="txtWebLinkAsso" runat="server" Text="WebSite: " Font-Size="Small"></asp:Label>
                                        <asp:TextBox ID="txtWebLinkAsso" runat="server" Placeholder="... enter a link" CssClass="form-control form-control-sm"></asp:TextBox>
                                    </div>

                                    <div class="custom-control custom-checkbox m-1">
                                        <input type="checkbox" class="custom-control-input" id="chkAssociate" runat="server" clientidmode="static" />
                                        <label class="custom-control-label" for="chkAssociate">Terms And Condition</label>
                                    </div>

                                    <div>
                                        <asp:CustomValidator runat="server" ID="CustvalAssoIns" EnableClientScript="true"
                                            Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                            ValidationGroup="valAssociate" OnServerValidate="CustvalAssoIns_ServerValidate"
                                            ErrorMessage="* Required" ClientValidationFunction="CustvalAssoIns_ClientValidate"></asp:CustomValidator>
                                    </div>

                                    <asp:Label ID="lblMsgAssoIns" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                    </asp:Label>
                                    <hr />
                                    <div class="mb-0">
                                        <asp:LinkButton ID="lbtnAssoInsSubmit" runat="server" ValidationGroup="valAssociate"
                                            CssClass="btn btn-outline-success btn-sm " OnClick="lbtnAssoInsSubmit_Click">
                                                                        Submit
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="lbtnAssoUpdSubmit" runat="server" ValidationGroup="valAssociate" Visible="false"
                                            CssClass="btn btn-outline-success btn-sm " OnClick="lbtnAssoUpdSubmit_Click">
                                                                        Update
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="lbtnAssoCancel" runat="server"
                                            CssClass="btn btn-outline-danger btn-sm " OnClick="lbtnAssoCancel_Click">
                                                                        Cancel
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>


                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>

                            <asp:Repeater ID="RepAssociate" runat="server" DataSourceID="SqlRepAssociate">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnAssoId" runat="server" Value='<%# Eval("Id") %>' />
                                    <asp:HiddenField ID="hdnAssoCatId" runat="server" Value='<%# Eval("EACatId") %>' />

                                    <div class="card mb-2">
                                        <div class="card-body p-2">
                                            <h6 class="card-title m-0">
                                                <asp:Label ID="lblAssoCat" runat="server" Text='<%# Eval("Cat") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>

                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>

                                                <asp:Label ID="lblBrandName" runat="server" Text='<%# Eval("BrandName") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>

                                            </h6>
                                            <div class="card-text m-0">
                                                <div class="h6 mb-0">
                                                    <span style="font-size: 11px">Address:</span>
                                                    <span>
                                                        <asp:Label ID="lblAddress" runat="server" Font-Size="11px" Text='<%# Eval("Address") %>'> </asp:Label>
                                                    </span>
                                                </div>

                                                <div class="h6 mb-0">
                                                    <span style="font-size: 11px">Contact Details:</span>
                                                    <span runat="server" visible='<%#(Eval("Phone")).ToString()==""? true:false %>'>
                                                        <asp:Label ID="lblPhone" runat="server" Font-Size="11px" Text='<%# Eval("Phone") %>'> </asp:Label>
                                                    </span>
                                                    <span runat="server" visible='<%#(Eval("Mobile")).ToString()==""? true:false %>'>/
                                                                    <asp:Label ID="lblMobile" runat="server" Font-Size="11px" Text='<%# Eval("Mobile") %>'> </asp:Label>
                                                    </span>
                                                </div>


                                                <div class="h6 mb-0" runat="server" visible='<%#(Eval("Email")).ToString()==""? true:false %>'>
                                                    <span style="font-size: 12px">Email:</span>
                                                    <span>
                                                        <asp:Label ID="lblEmail" runat="server" Font-Size="X-Small" Text='<%# Eval("Email") %>'> </asp:Label>
                                                    </span>
                                                </div>
                                                <div class="h6 mb-0" runat="server" visible='<%#(Eval("Weblink")).ToString()==""? true:false %>'>
                                                    <span style="font-size: 12px">Website:</span>
                                                    <span>
                                                        <asp:Label ID="lblWeblink" runat="server" Font-Size="X-Small" Text='<%# Eval("Weblink") %>'> </asp:Label>
                                                    </span>
                                                </div>


                                                <div class="h6 mb-0">
                                                    <asp:Label runat="server" class="text-muted" Font-Size="XX-Small"
                                                        Text='<%# Eval("ModDt").ToString() =="" ? "Listed On: "+Eval("CrDt","{0:dd MMM yyyy hh:mm tt}"): "Updated On: "+Eval("ModDt", "{0:dd MMM yyyy hh:mm tt}") %>'>         
                                                    </asp:Label>
                                                </div>
                                            </div>
                                            <asp:LinkButton ID="lbtnEditAssociate" runat="server" CssClass="card-link btn-sm text-primary"
                                                Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                OnClick="lbtnEditAssociate_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="lbtnRemoveAssociate" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveAssociate_Click" Font-Size="Small"
                                                Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                            </asp:LinkButton>
                                            <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                            <asp:LinkButton ID="lbtnReincludeAssociate" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeAssociate_Click" Font-Size="Small"
                                                Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepAssociate.Items.Count == 0).ToString()) %>'>
                                        <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                        </li>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="SqlRepAssociate" ConnectionString='<%$ ConnectionStrings:EveCon %>'
                                SelectCommand="Associate_Sel_ForRep" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:QueryStringParameter QueryStringField="EventId" Name="EventId" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>



        <div class="modal fade open-modal-for-asso-cat" id="ModelForAssoCat" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h6 class="alert-heading">Enter a category!</h6>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:HiddenField ID="hdnPixelAssoCat" runat="server" Value='<%# Eval("Id") %>' />

                                <div class="form-group m-2px">
                                    <asp:Label AssociatedControlID="txtAssoCat" runat="server" Text="Category: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                    <asp:TextBox ID="txtAssoCat" runat="server" Placeholder="... enter a category name" CssClass="form-control form-control-sm"></asp:TextBox>
                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtAssoCat"
                                        runat="server" Display="Dynamic" ValidationGroup="valAssoCat" Font-Size="XX-Small" SetFocusOnError="true" />
                                </div>

                                <div class="form-group m-2px">
                                    <asp:Label AssociatedControlID="txtCatPriority" runat="server" Text="Priority: *" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                    <asp:TextBox ID="txtCatPriority" runat="server" Placeholder="... enter a priority" CssClass="form-control form-control-sm" Text="0"></asp:TextBox>
                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtCatPriority"
                                        runat="server" Display="Dynamic" ValidationGroup="valAssoCat" Font-Size="XX-Small" SetFocusOnError="true" />
                                </div>

                                <div class="custom-control custom-checkbox m-1">
                                    <input type="checkbox" class="custom-control-input" id="chkAssoCat" runat="server" clientidmode="static" />
                                    <label class="custom-control-label" for="chkAssoCat">Terms And Condition</label>
                                </div>

                                <div>
                                    <asp:CustomValidator runat="server" ID="CustvalAssoCat" EnableClientScript="true"
                                        Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson"
                                        ValidationGroup="valAssoCat" OnServerValidate="CustvalAssoCat_ServerValidate"
                                        ErrorMessage="* Required" ClientValidationFunction="CustvalAssoCat_ClientValidate"></asp:CustomValidator>
                                </div>

                                <asp:Label ID="lblMsgAssoCat" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                </asp:Label>
                                <hr />
                                <div class="mb-0">
                                    <asp:LinkButton ID="lbtnAssoCatSubmit" runat="server" ValidationGroup="valAssoCat"
                                        CssClass="btn btn-outline-success btn-sm " OnClick="lbtnAssoCatSubmit_Click">
                                                                        Submit
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="lbtnAssoCatCancel" runat="server"
                                        CssClass="btn btn-outline-danger btn-sm " OnClick="lbtnAssoCatCancel_Click">
                                                                        Cancel
                                    </asp:LinkButton>
                                </div>

                                <asp:Repeater ID="RepAssoCat" runat="server" DataSourceID="SqlRepAssoCat">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnAssoCatId" runat="server" Value='<%# Eval("Id") %>' />

                                        <div class="card mb-2">
                                            <div class="card-body p-2">
                                                <h6 class="card-title m-0">
                                                    <span>
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>
                                                    </span>
                                                    <span>
                                                        <asp:LinkButton ID="lbtnRemoveAssoCat" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveAssoCat_Click" Font-Size="Small"
                                                            Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                        </asp:LinkButton>
                                                    </span>
                                                </h6>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepAssociate.Items.Count == 0).ToString()) %>'>
                                            <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                            </li>
                                        </ul>
                                    </FooterTemplate>
                                </asp:Repeater>
                                <asp:SqlDataSource runat="server" ID="SqlRepAssoCat" ConnectionString='<%$ ConnectionStrings:EveCon %>'
                                    SelectCommand="AssociateCat_Sel_ForRep" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:QueryStringParameter QueryStringField="EventId" Name="EventId" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-modal-for-associate-remove" id="ModelForAssociateRemove" role="dialog" aria-hidden="false">
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
                                    <asp:LinkButton ID="lbtnAssoRemoveSubmit" runat="server"
                                        CssClass="btn btn-outline-success btn-sm " OnClick="lbtnAssoRemoveSubmit_Click">
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
