<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="Resident.WebPage.Public.Booking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />
    <%--<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />--%>
    <link href="../../ContentPlugIn/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <%--<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.no-icons.min.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.2/plugins/confirmDate/confirmDate.css" />


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-timeago/1.6.3/jquery.timeago.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.2/plugins/confirmDate/confirmDate.js"></script>

    <%--    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>
    <script src="../../ScriptPlugIn/bootstrap-datetimepicker.min.js"></script>
    <script>
        function openModal() {
            $(".openmodal").modal('show');
        }

        function closeModal() {
            $('body').removeClass('modal-open');
            $('.modal-backdrop').remove();
        }

        function alertmsg() {
            swal({
                title: 'Congratulations!',
                text: 'Your issue has been succesfully listed',
                type: 'success'
            });
        }

        $(document).ready(function () {
            //$(".datetime-picker").datetimepicker({
            //    format: "dd MM yyyy HH:ii P",
            //    showMeridian: true,
            //    autoclose: true,
            //    todayBtn: true,
            //    changeMonth: true,
            //    pickerPosition: 'top-right',
            //    startDate: "+0d",
            //    //defaultDate: new Date(),
            //    keyboardNavigation: true,
            //    endDate: "+1y"

            //});
            $(".datetime-picker").flatpickr({
                "enableTime": true,
                //dateFormat: "Y-m-d H:i",
                //altInput: true,
                //altFormat: "F j, Y H:i",
                //minDate: "today",
                //maxDate: new Date().fp_incr(365),

                "plugins": [new confirmDatePlugin({
                    confirmIcon: "<i class='fa fa-check'></i>", // your icon's html, if you wish to override
                    confirmText: "OK ",
                    showAlways: false,
                    //theme: "light" // or "dark"
                })]
            });
            

            $('#basic-addon1').click(function () {
                $('#txtStartDate').val('');
            });

            $('#basic-addon2').click(function () {
                $('#txtEndDate').val('');
            });

            $("time.timeago").timeago();
        })


    </script>
    <style>
        .glyphicon-arrow-right {
            pointer-events: none;
            border: solid black;
            border-width: 0 3px 3px 0;
            display: inline-block;
            padding: 3px;
            transform: rotate(-45deg);
            -webkit-transform: rotate(-45deg);
        }

        .glyphicon-arrow-left {
            pointer-events: none;
            border: solid black;
            border-width: 0 3px 3px 0;
            display: inline-block;
            padding: 3px;
            transform: rotate(135deg);
            -webkit-transform: rotate(135deg);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <asp:Label ID="lbl" runat="server"></asp:Label>
                    <asp:Button ID="btnAddButton" runat="server" Text="Booking" OnClick="btnAddButton_Click" CssClass="btn btn-outline-primary glyphicon glyphicon-envelope" />

                    <div class="modal openmodal" id="myModal">
                        <div class="modal-dialog">
                            <div class="modal-content">

                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 class="modal-title">Modal Heading</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>

                                <!-- Modal body -->
                                <div class="modal-body">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="form-group">
                                                <label for="lblPurposeCat">Category:</label>
                                                <asp:Label runat="server" ID="lblPurposeCat" AssociatedControlID="ddlPurposeCat" Text="Purpose for"></asp:Label>
                                                <asp:DropDownList ID="ddlPurposeCat" runat="server" CssClass="form-control" DataSourceID="sqlddlPurposeCat" OnDataBound="ddlPurposeCat_DataBound"
                                                    DataTextField="Name" DataValueField="Id">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource runat="server" ID="sqlddlPurposeCat" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="SELECT [Id], [Name] FROM [ComplexPurposeCat]"></asp:SqlDataSource>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="ddlPurposeCat" InitialValue="0"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAddBooking" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>
                                            <div class="form-group">
                                                <asp:Label runat="server" ID="lbltxtDescr" AssociatedControlID="txtDescr" Text="Description"></asp:Label>
                                                <asp:TextBox ID="txtDescr" runat="server" CssClass="form-control" TextMode="MultiLine" Placeholder="It can be optional!"></asp:TextBox>
                                            </div>

                                            <div class="form-group">
                                                <asp:Label runat="server" ID="lblWhoseEvent" AssociatedControlID="txtWhoseEvent" Text="Whose Event"></asp:Label>

                                                <asp:TextBox ID="txtWhoseEvent" runat="server" CssClass="form-control" Placeholder="Enter The name of the persons!">
                                                    
                                                </asp:TextBox>


                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtWhoseEvent"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAddBooking" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>
                                            <div class="form-group">
                                                <asp:Label runat="server" ID="lblStartDate" AssociatedControlID="txtStartDate" Text="StateDate"></asp:Label>

                                                <div class="input-group mb-3">

                                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control datetime-picker"
                                                        AutoCompleteType="Disabled" Placeholder="Pick a valid Booking date and time"></asp:TextBox>
                                                    <div class="input-group-append" style="cursor: pointer">
                                                        <span class="input-group-text" id="basic-addon1"><i class="icon-remove"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtStartDate"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAddBooking" Font-Size="XX-Small" SetFocusOnError="true" />
                                            </div>

                                            <div class="form-group">
                                                <asp:Label runat="server" ID="lblEndDate" AssociatedControlID="txtEndDate" Text="StateDate"></asp:Label>
                                                <div class="input-group mb-3">
                                                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control datetime-picker"
                                                        AutoCompleteType="Disabled" Placeholder="Pick a valid finished date and time"></asp:TextBox>

                                                    <div class="input-group-append" style="cursor: pointer">
                                                        <span class="input-group-text" id="basic-addon2"><i class="icon-remove"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                                <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtEndDate"
                                                    runat="server" Display="Dynamic" ValidationGroup="valAddBooking" Font-Size="XX-Small" SetFocusOnError="true" />

                                                <asp:CompareValidator ID="valRange" ValidationGroup="valAddBooking" ControlToCompare="txtStartDate" ForeColor="Crimson"
                                                    Operator="GreaterThan" Type="String" ControlToValidate="txtEndDate" Font-Size="XX-Small" SetFocusOnError="true" Display="Dynamic"
                                                    ErrorMessage="End date can be greaterthen booking date" runat="server" />
                                            </div>

                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="customCheck" runat="server" />
                                                <label class="custom-control-label" for="customCheck">Terms And Condition</label>
                                            </div>

                                        </div>
                                    </div>

                                </div>

                                <!-- Modal footer -->
                                <div class="modal-footer">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm" ValidationGroup="valAddBooking" OnClick="btnSubmit_Click" />
                                    <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-12">
                    <div class="card" style="margin-bottom: 5px">
                        <div class="card-header text-white bg-dark">
                            Booking Details
                        </div>
                        <div class="card-body" style="padding: 1px">
                            <div class="row" style="padding-left: 15px; padding-right: 15px">
                                <asp:Repeater runat="server" ID="repBooking" DataSourceID="sqlRepBooking">
                                    <ItemTemplate>
                                        <div class="col-sm-6 col-md-4 col-xl-4" style="padding: 1px">

                                            <div class="card h-100" style="margin-bottom: 0px; box-shadow: none">

                                                <div class="card-body" style="padding: 10px">
                                                    <h5 class="card-title"><%# Eval("Name") %></h5>
                                                    <h6 class="card-subtitle mb-2 text-muted"><%# Eval("WhoseEvent") %></h6>
                                                    <p class="card-text" style="font-size: small">
                                                        <%# Eval("FromDate","{0:ddd, dd MMM yyyy hh:mm tt}") %> -  <%# Eval("ToDate","{0:ddd, dd MMM yyyy hh:mm tt}") %>
                                                    </p>
                                                    <div runat="server" visible='<%#(Eval("Descr")).ToString()!=""? true:false %>' style="font-size: small">
                                                        <%# Eval("Descr") %>
                                                    </div>

                                                    <time class="timeago text-muted" runat="server" datetime='<%# Eval("CrDt") %>' style="font-size: 10px"></time>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                            <asp:SqlDataSource runat="server" ID="SqlRepBooking" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                SelectCommand="SELECT 
	                                                PFB.Id, PFB.FromDate, PFB.ToDate, PFB.WhoseEvent, PFB.Descr, CPC.Name, PFB.CrDt
                                                FROM 
	                                                PropertyFlowBookings PFB
	                                                INNER JOIN 
		                                                ComplexPurposeCat CPC ON PFB.PurposeCatId=CPC.Id
                                                WHERE 
	                                                PropertyFlowId = @PropertyFlowId">
                                <SelectParameters>
                                    <asp:QueryStringParameter QueryStringField="Id" DefaultValue="1" Name="PropertyFlowId" Type="Int32"></asp:QueryStringParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
