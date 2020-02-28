<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Visitor2.aspx.cs" Inherits="Resident.WebPage.AdminG.Visitor2" ClientIDMode="AutoID" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.3/flatpickr.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.3/flatpickr.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://kit.fontawesome.com/5f92b8c4a8.js"></script>
    <script>
        function custValCat_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkCat.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function custValVisitor_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkVisitor.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        //Visitor Cat
        function openRemoveModalForCat() {
            $('.catRemoveModal').modal('show');
        }

        function closeRemoveModalForCat() {
            $('.catRemoveModal').modal('hide');
        }

        function alertMsgForCatIns() {
            swal({
                title: '',
                text: 'Successfully added a new category',
                type: 'success'
            });
        }

        function openReincludeModalForCat() {
            $('.catReincludeModal').modal('show');
        }

        function closeReincludeModalForCat() {
            $('.catReincludeModal').modal('hide');
        }

        function alertMsgForCatUpd() {
            swal({
                title: '',
                text: 'Successfully updated category',
                type: 'success'
            });
        }
        //Visitor
        function openRemoveModalForVisitor() {
            $('.visitorRemoveModal').modal('show');
        }

        function closeRemoveModalForVisitor() {
            $('.visitorRemoveModal').modal('hide');
        }

        function alertMsgForVisitorIns() {
            swal({
                title: '',
                text: 'Successfully added a new visitor',
                type: 'success'
            });
        }

        function openReincludeModalForVisitor() {
            $('.visitorReincludeModal').modal('show');
        }

        function closeReincludeModalForVisitor() {
            $('.visitorReincludeModal').modal('hide');
        }

        function alertMsgForVisitorUpd() {
            swal({
                title: '',
                text: 'Successfully updated visitor',
                type: 'success'
            });
        }

        $(document).ready(function () {
            datePickerFrom();
            datePickerTo();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
                datePickerFrom();
                datePickerTo();
            });
        });

        function datePickerFrom() {
            $(".date-picker-from").flatpickr({
                altInput: true,
                enableTime: true,
                altFormat: "F j, Y H:i",
                dateFormat: "Y-m-d H:i"
            });
        }

        function datePickerTo() {
            $(".date-picker-to").flatpickr({
                altInput: true,
                enableTime: true,
                altFormat: "F j, Y H:i",
                dateFormat: "Y-m-d H:i"
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
                    <ul class="nav nav-tabs mt-2">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#cat">
                                <i class="fas fa-th-large mr-1" style="color: #f783ac"></i>Category
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#visitor">
                                <i class="fas fa-user-check mr-1" style="color: #be4bdb"></i>Visitor
                            </a>
                        </li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content mt-2">
                        <div class="tab-pane container active" id="cat">
                            <div class="card mb-2">
                                <div class="card-body">
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:HiddenField ID="hdnPixelCat" runat="server" />

                                            <div class="form-group m-2px">
                                                <asp:Label AssociatedControlID="txtNameCat" runat="server" Text="Name: *" CssClass="text-danger" Font-Size="Small"></asp:Label>

                                                <asp:TextBox ID="txtNameCat" runat="server" Placeholder="... enter a Category name" ClientIDMode="Static"
                                                    CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>

                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNameCat" BackColor="Yellow"
                                                    runat="server" Display="Dynamic" ValidationGroup="valCat" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>

                                            <div class="form-group m-2px">
                                                <asp:Label AssociatedControlID="txtPriorityCat" runat="server" Text="Priority: *" Font-Size="Small" CssClass="text-danger"></asp:Label>

                                                <asp:TextBox ID="txtPriorityCat" runat="server" Placeholder="... enter a Priority" MaxLength="2"
                                                    CssClass="form-control form-control-sm number-only" Font-Size="Small"></asp:TextBox>

                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPriorityCat" BackColor="Yellow"
                                                    runat="server" Display="Dynamic" ValidationGroup="valCat" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>

                                            <div class="custom-control custom-checkbox m-1">
                                                <input type="checkbox" class="custom-control-input" id="chkCat" runat="server" clientidmode="static" />
                                                <label class="custom-control-label" for="chkCat">Terms And Condition</label>
                                            </div>

                                            <div>
                                                <asp:CustomValidator runat="server" ID="custValCat" EnableClientScript="true"
                                                    Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson" BackColor="Yellow"
                                                    ValidationGroup="valCat" OnServerValidate="custValCat_ServerValidate"
                                                    ErrorMessage="* Required" ClientValidationFunction="custValCat_ClientValidate"></asp:CustomValidator>
                                            </div>

                                            <asp:Label ID="lblErroMsgCat" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                            </asp:Label>

                                            <div>
                                                <asp:Button ID="btnSubmitCat" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                                    ValidationGroup="valCat" OnClick="btnSubmitCat_Click" />
                                                <asp:Button ID="btnUpdateCat" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm" Visible="false"
                                                    ValidationGroup="valCat" OnClick="btnUpdateCat_Click" />

                                                <asp:Button ID="btnCancelCat" runat="server" Text="Cancel" CssClass="btn btn-outline-danger btn-sm"
                                                    OnClick="btnCancelCat_Click" />
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:Repeater ID="RepCat" runat="server" DataSourceID="SqlRepCat">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnCatId" runat="server" Value='<%# Eval("Id") %>' />
                                                    <div class="card mb-2">
                                                        <div class="card-body p-2">
                                                            <h6 class="card-title m-0">
                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>

                                                            </h6>
                                                            <div class="card-text m-0" style="line-height: 1.1">
                                                                <asp:Label ID="lblPriority" runat="server" Text='<%# Eval("Priority") %>' Font-Size="Small"></asp:Label>
                                                            </div>

                                                            <div class="h6 mb-0 text-muted" style="font-size: xx-small">
                                                                <span>Create by 
                                                                    <asp:Label runat="server" ForeColor="Indigo" Font-Bold="true"
                                                                        Text='<%# Eval("NameOfUser") %>'>         
                                                                    </asp:Label>
                                                                </span>
                                                                <span>on 
                                                                    <asp:Label runat="server" ForeColor="Indigo" Font-Bold="true"
                                                                        Text='<%# Eval("ModDt").ToString() =="" ?Eval("CrDt","{0:dd MMM yyyy hh:mm tt}"): Eval("ModDt", "{0:dd MMM yyyy hh:mm tt}") %>'>         
                                                                    </asp:Label>
                                                                </span>

                                                            </div>

                                                            <asp:LinkButton ID="lbtnEditCat" runat="server" CssClass="card-link btn-sm text-primary"
                                                                Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                                OnClick="lbtnEditCat_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnRemoveCat" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveCat_Click" Font-Size="Small"
                                                                Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                            </asp:LinkButton>
                                                            <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                            <asp:LinkButton ID="lbtnReincludeCat" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeCat_Click" Font-Size="Small"
                                                                Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepCat.Items.Count == 0).ToString()) %>'>
                                                        <li class="list-group-item  list-group-item-warning border-0 small"><i class="fas fa-exclamation-triangle mr-1"></i>No record listed as of now!
                                                        </li>
                                                    </ul>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            <asp:SqlDataSource runat="server" ID="SqlRepCat" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="VisitorCat_Sel_List" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>

                            <div class="modal fade catRemoveModal" role="dialog" aria-hidden="false">
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
                                                            <asp:LinkButton ID="lbtnSubmitCatForRemove" runat="server"
                                                                CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSubmitCatForRemove_Click">
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

                            <div class="modal fade catReincludeModal" role="dialog" aria-hidden="false">
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
                                                            <asp:LinkButton ID="lbtnSubmitCatForReinclude" runat="server"
                                                                CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSubmitCatForReinclude_Click">
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
                        </div>
                        <div class="tab-pane container fade" id="visitor">
                            <div class="card mb-2">
                                <div class="card-body">
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:HiddenField ID="hdnPixelVisitor" runat="server" />

                                            <div class="form-group m-2px">
                                                <asp:Label AssociatedControlID="ddlVisitorCat" runat="server" Text="Select a category: *" ForeColor="Indigo" Font-Size="Small"></asp:Label>

                                                <asp:DropDownList ID="ddlVisitorCat" runat="server" CssClass="form-control form-control-sm" Font-Size="Small" DataSourceID="SqlddlVisitorCat"
                                                    DataTextField="Name" DataValueField="Id" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlVisitorCat_SelectedIndexChanged">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                </asp:DropDownList>

                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="ddlVisitorCat" BackColor="Yellow"
                                                    runat="server" Display="Dynamic" ValidationGroup="valVisitor" Font-Size="XX-Small" SetFocusOnError="true" />

                                                <asp:SqlDataSource runat="server" ID="SqlddlVisitorCat" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="VisitorCat_Sel_DDL" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                            </div>
                                            <div class="form-group m-2px">
                                                <asp:Repeater ID="RepVisitorCat" runat="server" DataSourceID="SqlddlVisitorCat">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnCatSelect" CssClass="btn btn-outline-dark btn-sm mb-1" runat="server" OnClick="lbtnCatSelect_Click" Font-Size="11px">
                                                             <i class='<%# Eval("Icon") %>' style='<%# "font-size:15px; color:" + DataBinder.Eval(Container.DataItem, "Color") + ";" %>' runat="server" visible='<%#(Eval("Icon")).ToString()!=""? true:false %>'></i>
                                                             <i class="far fa-image text-secondary" style="font-size: 15px" runat="server" visible='<%#(Eval("Icon")).ToString()==""? true:false %>'></i>
                                                             <span class="ml-1" style="font-weight:500">
                                                                 <%# Eval("Name") %>
                                                             </span> 
                                                        </asp:LinkButton>
                                                        <asp:HiddenField ID="hdnCatId" runat="server" Value='<%# Eval("Id") %>' />
                                                        <asp:HiddenField ID="hdnCatName" runat="server" Value='<%# Eval("Name") %>' />
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepVisitorCat.Items.Count == 0).ToString()) %>'>
                                                            <li class="list-group-item  list-group-item-warning border-0 small"><i class="fas fa-exclamation-triangle mr-1"></i>No record listed as of now!
                                                            </li>
                                                        </ul>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </div>

                                            <div class="form-group m-2px">
                                                <asp:Label AssociatedControlID="ddlVisitorFrec" runat="server" Text="Select a frequiency: *" ForeColor="Indigo" Font-Size="Small"></asp:Label>

                                                <asp:DropDownList ID="ddlVisitorFrec" runat="server" CssClass="form-control form-control-sm" Font-Size="Small" AutoPostBack="true" OnDataBound="ddlVisitorFrec_DataBound"
                                                    DataSourceID="SqlVisitorFrequency" DataTextField="Name" DataValueField="Id" OnSelectedIndexChanged="ddlVisitorFrec_SelectedIndexChanged">
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="ddlVisitorFrec" BackColor="Yellow"
                                                    runat="server" Display="Dynamic" ValidationGroup="valVisitor" Font-Size="XX-Small" SetFocusOnError="true" />
                                                <asp:SqlDataSource runat="server" ID="SqlVisitorFrequency" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="VisitorFrequency_Sel_DDL" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="RepVisitorCat" PropertyName="SelectedValue" Name="CatId" Type="Int32"></asp:ControlParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </div>

                                            <div class="form-group m-2px">
                                                <asp:Repeater ID="RepFrequency" runat="server" DataSourceID="SqlVisitorFrequency">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnFrecSelect" CssClass="btn btn-outline-dark btn-sm mb-1" runat="server" OnClick="lbtnFrecSelect_Click" Font-Size="11px">
                                                             <i class='<%# Eval("Icon") %>' style='<%# "font-size:15px; color:" + DataBinder.Eval(Container.DataItem, "Color") + ";" %>' runat="server" visible='<%#(Eval("Icon")).ToString()!=""? true:false %>'></i>
                                                             <i class="far fa-image text-secondary" style="font-size: 15px" runat="server" visible='<%#(Eval("Icon")).ToString()==""? true:false %>'></i>
                                                             <span class="ml-1" style="font-weight:500">
                                                                 <%# Eval("Name") %>
                                                             </span> 
                                                        </asp:LinkButton>
                                                        <asp:HiddenField ID="hdnCatId" runat="server" Value='<%# Eval("Id") %>' />
                                                        <asp:HiddenField ID="hdnCatName" runat="server" Value='<%# Eval("Name") %>' />
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepFrequency.Items.Count == 0).ToString()) %>'>
                                                            <li class="list-group-item  list-group-item-warning border-0 small"><i class="fas fa-exclamation-triangle mr-1"></i>No record listed as of now!
                                                            </li>
                                                        </ul>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </div>
                                            <div class="form-group m-2px">
                                                <asp:Label AssociatedControlID="txtNameVisitor" runat="server" Text="Name: *" CssClass="text-danger" Font-Size="Small"></asp:Label>

                                                <asp:TextBox ID="txtNameVisitor" runat="server" Placeholder="... enter a visitor name" ClientIDMode="Static"
                                                    CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>

                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNameVisitor" BackColor="Yellow"
                                                    runat="server" Display="Dynamic" ValidationGroup="valVisitor" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>
                                            <asp:Panel ID="pnlVisitorDate" runat="server" Visible="false">
                                                <div class="form-group m-2px">
                                                    <asp:Label AssociatedControlID="txtFromDateVisitor" runat="server" Text="From: *" Font-Size="Small" CssClass="text-danger"></asp:Label>

                                                    <asp:TextBox ID="txtFromDateVisitor" runat="server" Placeholder="... enter from date" CssClass="form-control form-control-sm date-picker-from" Font-Size="Small"></asp:TextBox>

                                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtFromDateVisitor" BackColor="Yellow"
                                                        runat="server" Display="Dynamic" ValidationGroup="valVisitor" Font-Size="XX-Small" SetFocusOnError="true" />
                                                </div>
                                                <div class="form-group m-2px">
                                                    <asp:Label AssociatedControlID="txtToDateVisitor" runat="server" Text="To: " Font-Size="Small" ForeColor="Navy"></asp:Label>
                                                    <asp:TextBox ID="txtToDateVisitor" runat="server" Placeholder="... enter to date" CssClass="form-control form-control-sm date-picker-to" Font-Size="Small"></asp:TextBox>

                                                </div>
                                            </asp:Panel>
                                            <div class="form-group m-2px">
                                                <asp:Label AssociatedControlID="txtDescrVisitor" runat="server" Text="Description: " Font-Size="Small" ForeColor="Navy"></asp:Label>
                                                <asp:TextBox ID="txtDescrVisitor" runat="server" Placeholder="... enter description" Height="80" TextMode="MultiLine"
                                                    CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>
                                            </div>


                                            <div class="custom-control custom-checkbox m-1">
                                                <input type="checkbox" class="custom-control-input" id="chkVisitor" runat="server" clientidmode="static" />
                                                <label class="custom-control-label" for="chkVisitor">Terms And Condition</label>
                                            </div>

                                            <div>
                                                <asp:CustomValidator runat="server" ID="custValVisitor" EnableClientScript="true"
                                                    Display="Dynamic" Font-Size="XX-Small" ForeColor="Crimson" BackColor="Yellow"
                                                    ValidationGroup="valVisitor" OnServerValidate="custValVisitor_ServerValidate"
                                                    ErrorMessage="* Required" ClientValidationFunction="custValVisitor_ClientValidate"></asp:CustomValidator>
                                            </div>

                                            <asp:Label ID="lblErroMsgVisitor" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                            </asp:Label>

                                            <div>
                                                <asp:Button ID="btnSubmitVisitor" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                                    ValidationGroup="valVisitor" OnClick="btnSubmitVisitor_Click" />
                                                <asp:Button ID="btnUpdateVisitor" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm" Visible="false"
                                                    ValidationGroup="valVisitor" OnClick="btnUpdateVisitor_Click" />

                                                <asp:Button ID="btnCancelVisitor" runat="server" Text="Cancel" CssClass="btn btn-outline-danger btn-sm"
                                                    OnClick="btnCancelVisitor_Click" />
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:Repeater ID="RepVisitor" runat="server" DataSourceID="SqlRepVisitor">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnVisitorId" runat="server" Value='<%# Eval("Id") %>' />
                                                    <asp:HiddenField ID="hdnCatId" runat="server" Value='<%# Eval("CatId") %>' />
                                                    <asp:HiddenField ID="hdnFrequencyId" runat="server" Value='<%# Eval("FrequencyId") %>' />

                                                    <div class="card mb-2">
                                                        <div class="card-body p-2">
                                                            <h6 class="card-title">
                                                                <span>
                                                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>
                                                                </span>


                                                            </h6>
                                                            <h6 class="card-title">

                                                                <span class="shadow p-1 mb-1 bg-white" style="color: indigo">
                                                                    <asp:Label ID="lblCat" runat="server" Text='<%# Eval("Cat") %>' Font-Size="X-Small"></asp:Label>
                                                                </span>
                                                                <span class="shadow p-1 mb-1 bg-white" style="color: darkcyan">
                                                                    <asp:Label ID="lblFrequency" runat="server" Text='<%# Eval("Frequency") %>' Font-Size="X-Small"></asp:Label>
                                                                </span>
                                                            </h6>
                                                            <div class="card-text" style="line-height: 1.1; font-size: x-small" runat="server" visible='<%#(Eval("FromDate")).ToString()!=""? true:false %>'>
                                                                <span class="text-muted">Date:-
                                                                </span>
                                                                <span>
                                                                    <asp:Label ID="lblFromDate" runat="server" Text='<%# Eval("FromDate","{0:dd MMM yyyy hh:mm tt}") %>' ForeColor="Navy"></asp:Label>
                                                                    <asp:HiddenField ID="hdnFromDate" runat="server" Value='<%# Eval("FromDate","{0:yyyy-MM-dd hh:mm tt}") %>' />
                                                                </span>
                                                                <span runat="server" visible='<%#(Eval("ToDate")).ToString()!=""? true:false %>'>-
                                                                    <asp:Label ID="lblToDate" runat="server" Text='<%# Eval("ToDate","{0:dd MMM yyyy hh:mm tt}") %>' ForeColor="Navy"></asp:Label>
                                                                    <asp:HiddenField ID="hdnToDate" runat="server" Value='<%# Eval("ToDate","{0:yyyy-MM-dd hh:mm tt}") %>' />
                                                                </span>

                                                            </div>
                                                            <div class="card-text m-0 text-justify" style="font-size: 11px; text-indent: 20px">
                                                                <asp:Label ID="lblDescr" runat="server" Text='<%# Eval("Descr") %>'></asp:Label>
                                                            </div>
                                                            <div class="h6 mb-0 mt-1 text-muted" style="font-size: xx-small">
                                                                <span>Create by 
                                                                            <asp:Label runat="server" ForeColor="Indigo" Font-Bold="true"
                                                                                Text='<%# Eval("NameOfUser") %>'>         
                                                                            </asp:Label>
                                                                </span>
                                                                <span>on 
                                                                            <asp:Label runat="server" ForeColor="Indigo" Font-Bold="true"
                                                                                Text='<%# Eval("ModDt").ToString() =="" ?Eval("CrDt","{0:dd MMM yyyy hh:mm tt}"): Eval("ModDt", "{0:dd MMM yyyy hh:mm tt}") %>'>         
                                                                            </asp:Label>
                                                                </span>
                                                            </div>

                                                            <asp:LinkButton ID="lbtnEditVisitor" runat="server" CssClass="card-link btn-sm text-primary"
                                                                Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                                OnClick="lbtnEditVisitor_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnRemoveVisitor" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveVisitor_Click" Font-Size="Small"
                                                                Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                            </asp:LinkButton>
                                                            <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                            <asp:LinkButton ID="lbtnReincludeVisitor" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeVisitor_Click" Font-Size="Small"
                                                                Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepVisitor.Items.Count == 0).ToString()) %>'>
                                                        <li class="list-group-item  list-group-item-warning border-0 small"><i class="fas fa-exclamation-triangle mr-1"></i>No record listed as of now!
                                                        </li>
                                                    </ul>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            <asp:SqlDataSource runat="server" ID="SqlRepVisitor" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="Visitor_Sel_List" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:RouteParameter Name="ComplexId" RouteKey="ComplexId" DefaultValue="1" ConvertEmptyStringToNull="true" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>

                            <div class="modal fade visitorRemoveModal" role="dialog" aria-hidden="false">
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
                                                            <asp:LinkButton ID="lbtnSubmitVisitorForRemove" runat="server"
                                                                CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSubmitVisitorForRemove_Click">
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

                            <div class="modal fade visitorReincludeModal" role="dialog" aria-hidden="false">
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
                                                            <asp:LinkButton ID="lbtnSubmitVisitorForReinclude" runat="server"
                                                                CssClass="btn btn-outline-success btn-sm " OnClick="lbtnSubmitVisitorForReinclude_Click">
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
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
