<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Visitor.aspx.cs" Inherits="Resident.WebPage.AdminG.Visitor" ClientIDMode="AutoID" %>

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-dateFormat/1.0/jquery.dateFormat.js"></script>
    <script src="/ScriptsProject/Public/Visitor.js"></script>
    <style>
        .highlightRow {
            background-color: #9999FF;
        }
    </style>
    <script>
        function custValVisitor_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkVisitor.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function removeButton() {
            $('.div-visitor div').each(function () {
                if ($(this).find('.toDate').html() !== '') {
                    $(this).find('.linkUpdate').remove();
                }
                console.log($(this).find('.image1').attr("src"));

                if ($(this).find('.image1').html() !== '') {
                    //$(this).find('.image1').remove();
                    $(this).find('.image1').attr("src","a.jpg")
                    //console.log($(this).find('.image1').html())

                }
            });
        }
        //Visitor Cat
        function alertMsgForCatIns() {
            swal({
                title: '',
                text: 'Successfully added a new category',
                type: 'success'
            });
        }
        //Visitor
        function alertMsgForVisitorIns() {
            swal({
                title: '',
                text: 'Successfully added a new visitor',
                type: 'success'
            });
        }

        $(document).ready(function () {
            datePickerFrom();
            datePickerTo();
            //funX();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
                datePickerFrom();
                datePickerTo();
                // funX();
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
                            <a class="nav-link active" data-toggle="tab" href="#visitor">
                                <i class="fas fa-user-check mr-1" style="color: #be4bdb"></i>Visitor

                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#details">
                                <i class="fas fa-th-large mr-1" style="color: #f783ac"></i>View Details

                            </a>
                        </li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content mt-2">
                        <div class="tab-pane container active" id="visitor">
                            <div class="card mb-2">
                                <div class="card-body">
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:HiddenField ID="hdnPixelVisitor" runat="server" />

                                            <div class="form-group m-2px">
                                                <h6>
                                                    <asp:Label runat="server" Text="Select a category: *" ForeColor="Indigo" Font-Size="Small"></asp:Label>
                                                </h6>
                                                <asp:HiddenField ID="hdnVisitorCatId" runat="server" />
                                                <asp:Repeater ID="RepVisitorCat" runat="server" DataSourceID="SqlddlVisitorCat">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnCatSelect" CssClass="btn btn-outline-dark btn-sm mb-1 c-btn" runat="server" OnClick="lbtnCatSelect_Click" Font-Size="11px">
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
                                                <asp:SqlDataSource runat="server" ID="SqlddlVisitorCat" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="VisitorCat_Sel_DDL" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                            </div>

                                            <div class="form-group m-2px" id="divFrequency" runat="server" visible="false">
                                                <h6>
                                                    <asp:Label runat="server" Text="Select a frequiency: *" ForeColor="Indigo" Font-Size="Small"></asp:Label>
                                                </h6>
                                                <asp:HiddenField ID="hdnVisitorFId" runat="server" />
                                                <asp:Repeater ID="RepFrequency" runat="server" DataSourceID="SqlVisitorFrequency">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnFrecSelect" CssClass="btn btn-outline-dark btn-sm mb-1" runat="server" OnClick="lbtnFrecSelect_Click" Font-Size="11px">
                                                             <i class='<%# Eval("Icon") %>' style='<%# "font-size:15px; color:" + DataBinder.Eval(Container.DataItem, "Color") + ";" %>' runat="server" visible='<%#(Eval("Icon")).ToString()!=""? true:false %>'></i>
                                                             <i class="far fa-image text-secondary" style="font-size: 15px" runat="server" visible='<%#(Eval("Icon")).ToString()==""? true:false %>'></i>
                                                             <span class="ml-1" style="font-weight:500">
                                                                 <%# Eval("Name") %>
                                                             </span> 
                                                        </asp:LinkButton>
                                                        <asp:HiddenField ID="hdnFrequencyId" runat="server" Value='<%# Eval("Id") %>' />
                                                        <asp:HiddenField ID="hdnFrequencyName" runat="server" Value='<%# Eval("Name") %>' />
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepFrequency.Items.Count == 0).ToString()) %>'>
                                                            <li class="list-group-item  list-group-item-warning border-0 small"><i class="fas fa-exclamation-triangle mr-1"></i>No record listed as of now!
                                                            </li>
                                                        </ul>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                                <asp:SqlDataSource runat="server" ID="SqlVisitorFrequency" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="VisitorFrequency_Sel_DDL" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="hdnVisitorCatId" PropertyName="Value" Name="CatId" Type="Int32" ConvertEmptyStringToNull="true"></asp:ControlParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </div>
                                            <div id="divEntry" runat="server" visible="false">
                                                <div class="form-group m-2px">
                                                    <asp:Label AssociatedControlID="txtNameVisitor" runat="server" Text="Name: *" CssClass="text-danger" Font-Size="Small"></asp:Label>

                                                    <asp:TextBox ID="txtNameVisitor" runat="server" Placeholder="... enter a visitor name" ClientIDMode="Static"
                                                        CssClass="form-control form-control-sm" Font-Size="Small"></asp:TextBox>

                                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNameVisitor" BackColor="Yellow"
                                                        runat="server" Display="Dynamic" ValidationGroup="valVisitor" Font-Size="XX-Small" SetFocusOnError="true" />
                                                </div>

                                                <div class="form-group m-2px">
                                                    <asp:Label AssociatedControlID="txtTotalVisitor" runat="server" Text="Total Visitor:" CssClass="text-danger" Font-Size="Small"></asp:Label>

                                                    <asp:TextBox ID="txtTotalVisitor" runat="server" Placeholder="... enter total visitor" ClientIDMode="Static" Text="1"
                                                        CssClass="form-control form-control-sm w-50 number-only" Font-Size="Small"></asp:TextBox>

                                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTotalVisitor" BackColor="Yellow"
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

                                                    <asp:Button ID="btnCancelVisitor" runat="server" Text="Cancel" CssClass="btn btn-outline-danger btn-sm"
                                                        OnClick="btnCancelVisitor_Click" />
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>

                        </div>
                        <div class="tab-pane container fade" id="details">
                            <div class="row">
                                <div class="col-md-12">

                                    <div id="divVisitor" class="div-visitor">
                                        <asp:Repeater ID="RepVisitor" runat="server">
                                            <ItemTemplate>

                                                <%--<asp:HiddenField ID="hdnVisitorId1" runat="server" Value='<%# Eval("Id") %>' />--%>
                                                <%--<asp:HiddenField ID="hdnFrequencyId" runat="server" Value='<%# Eval("FrequencyId") %>' />--%>

                                                <div class="card mb-2 cardId" id="div_<%# Guid.NewGuid() %>">
                                                    <div class="card-body p-2">
                                                        <h6 class="card-title">
                                                            <div>
                                                                <asp:Image ID="Img" runat="server" ImageUrl='<%# Eval("Image1") %>' CssClass="rounded img-fluid w-25 image1" />
                                                                <asp:Label ID="lblRowNumber" CssClass="rowNumber" runat="server" Text='<%# Eval("RowNumber") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>
                                                                <asp:Label ID="lblId" CssClass="id" runat="server" Text='<%# Eval("Id") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>
                                                                <input type="hidden" runat="server"
                                                                    value='<%# DataBinder.Eval(Container.DataItem,"Id") %>' class="hdnId" />
                                                            </div>
                                                            <div>
                                                                <asp:Label ID="lblName" CssClass="name" runat="server" Text='<%# Eval("Name") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>
                                                            </div>
                                                            <div style="font-size: x-small; color: indigo">
                                                                Total Number: 
                                                                <asp:Label ID="lblTotalNumber" CssClass="totalNumber" runat="server" Text='<%# Eval("TotalNumber") %>'></asp:Label>
                                                            </div>

                                                        </h6>
                                                        <h6 class="card-title">

                                                            <span class="shadow p-1 mb-1 bg-white" style="color: indigo">
                                                                <asp:Label ID="lblCat" CssClass="cat" runat="server" Text='<%# Eval("Cat") %>' Font-Size="X-Small"></asp:Label>
                                                            </span>
                                                            <span class="shadow p-1 mb-1 bg-white" style="color: darkcyan">
                                                                <asp:Label ID="lblFrequency" CssClass="frequency" runat="server" Text='<%# Eval("Frequency") %>' Font-Size="X-Small"></asp:Label>
                                                            </span>
                                                        </h6>

                                                        <div class="card-text noDisplay" style="line-height: 1.1; font-size: x-small" visible='<%#(Eval("FromDate")).ToString()!=string.Empty? true:false %>'>
                                                            <span class="text-muted">Date:-
                                                            </span>
                                                            <span>
                                                                <asp:Label ID="lblFromDate" CssClass="fromDate" runat="server" Text='<%# Eval("FromDate") %>' ForeColor="Navy"></asp:Label>

                                                            </span>
                                                            <span>-
                                                                    <asp:Label ID="lblToDate" CssClass="toDate" runat="server" Text='<%# Eval("ToDate") %>' ForeColor="Navy"></asp:Label>

                                                            </span>

                                                        </div>
                                                        <div class="card-text m-0 text-justify" style="font-size: 11px; text-indent: 20px">
                                                            <asp:Label ID="lblDescr" CssClass="descr" runat="server" Text='<%# Eval("Descr") %>'></asp:Label>
                                                        </div>
                                                        <div class="h6 mb-0 mt-1 text-muted" style="font-size: xx-small">
                                                            <span>Create by 
                                                                            <asp:Label runat="server" ForeColor="Indigo" Font-Bold="true" CssClass="nameOfUser"
                                                                                Text='<%# Eval("NameOfUser") %>'>         
                                                                            </asp:Label>
                                                            </span>
                                                            <span>on 
                                                                            <asp:Label runat="server" ForeColor="Indigo" Font-Bold="true" CssClass="crDt"
                                                                                Text='<%# Eval("CrDt","{0:dd MMM yyyy hh:mm tt}") %>'>         
                                                                            </asp:Label>
                                                            </span>
                                                        </div>

                                                        <%--<a id="lnkUpdate" href="#" class="linkUpdate">Update</a>--%>
                                                        <input type="button" class="linkUpdate btn btn-link btn-sm" value="Update" />
                                                        <input type="button" class="linkRemove btn btn-link btn-sm" value="Remove" />

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
                                    </div>
                                    <%--</ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                    <div class="loader text-center" style="display: none">
                                        <div class="spinner-grow spinner-grow-sm"></div>
                                        <div class="spinner-grow spinner-grow-sm"></div>
                                        <div class="spinner-grow spinner-grow-sm"></div>

                                    </div>

                                    <asp:SqlDataSource runat="server" ID="SqlRepVisitor" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="Visitor_Sel_List" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:RouteParameter Name="ComplexId" RouteKey="ComplexId" DefaultValue="1" ConvertEmptyStringToNull="true" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>
        <div class="modal fade updateVisitorModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Warning!</h6>

                        <div class="card border-0">
                            <div class="card-body p-2">
                                <input id="hdnVisitorIdForModal" type="hidden" runat="server" value="0" class="hdnModalId" />
                                <input id="hdnUniqueDivId" type="hidden" runat="server" value="0" class="hdnUniqueDiv" />

                                <div class="form-group m-2px">
                                    <asp:Label AssociatedControlID="txtToDate" runat="server" Text="Description: " CssClass="text-danger" Font-Size="Small"></asp:Label>
                                    <asp:TextBox ID="txtToDate" runat="server" Placeholder="... enter a description" required="required"
                                        CssClass="form-control form-control-sm date-picker-to txtToDate" Font-Size="Small"></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtToDate"
                                        runat="server" Display="Dynamic" ValidationGroup="valHelpReply" Font-Size="XX-Small" SetFocusOnError="true" />--%>
                                </div>

                                <input type="button" id="btnSubmitDate" class="btnSubmitDate btn btn-outline-success btn-sm" value="Submit" />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade removeVisitorModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Warning!</h6>

                        <div class="card border-0 text-center">
                            <div class="card-body p-2">

                                <input type="button" id="btnRemoveVisitor" class="btnRemoveVisitor btn btn-outline-success btn-sm" value="Yes" />
                                <button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">
                                    <i class="fas fa-times mr-1"></i>No
                                </button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>
