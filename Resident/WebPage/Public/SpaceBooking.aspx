<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SpaceBooking.aspx.cs" Inherits="Resident.WebPage.Public.SpaceBooking" %>

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

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
        rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
    <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.3/plugins/rangePlugin.js"
        integrity="sha256-hCte2r5gOQr+luM+anHERyFkMKfC8nBce0BoTv4UEJo=" crossorigin="anonymous"></script>

    <script>
        $(document).ready(function () {
            disabledDate();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
                disabledDate();
            });
        });

        function disabledDate() {
            $.ajax({
                url: '/Services/DisDate.asmx/GetAllDates',
                data: "{'complexId':'" + $("#hdnComplexId").val() + "'}",
                dataType: "json",
                method: 'post',
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    console.log(data);
                    $(".date-pick").flatpickr({
                        disable: data,
                        altInput: true,
                        altFormat: "j F, Y",
                        dateFormat: "Y-m-d",
                        minDate: "today",
                        maxDate: new Date().fp_incr(365)
                    });

                    $(".range-pick2").flatpickr({
                        disable: data,
                        altInput: true,
                        mode: "range",
                        altFormat: "j F, Y",
                        dateFormat: "Y/m/d",
                        minDate: "today",
                        maxDate: new Date().fp_incr(365),
                        locale: {
                            rangeSeparator: '-'
                        }
                    });

                    flatpickr('#txtRangeDateFrom', {
                        disable: data,
                        altInput: true,
                        altFormat: "j F, Y",
                        dateFormat: "Y-m-d",
                        minDate: "today",
                        maxDate: new Date().fp_incr(365),

                        "plugins": [new rangePlugin({ input: "#txtRangeDateTo" })],
                        onChange: [function (selectedDates) {
                            const dateArr = selectedDates.map(date => this.formatDate(date, "Y-m-d"));
                            $('#txtRangeDateFrom').val(dateArr[0]);
                        }]
                    });
                },
                error: function (err) {
                    alert(err);
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager runat="server"></asp:ScriptManager>
            <div class="container">

                <div class="row">
                    <div class="col-md-2">
                    </div>
                    <div class="col-md-8">

                        <asp:UpdatePanel ID="up1" runat="server">
                            <ContentTemplate>
                                <div class="container">
                                    <div class="form-group">
                                        <asp:Label AssociatedControlID="txtFromDate" runat="server" Font-Size="Small" CssClass="text-danger">From</asp:Label>
                                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control form-control-sm date-pick" Font-Size="Small" Width="50%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtFromDate"
                                            runat="server" Display="Dynamic" ValidationGroup="valBooking" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>

                                    <div class="form-group">
                                        <asp:Label AssociatedControlID="txtToDate" runat="server" Font-Size="Small">To</asp:Label>
                                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control form-control-sm date-pick" Font-Size="Small" Width="50%"></asp:TextBox>
                                        <asp:CompareValidator ControlToCompare="txtFromDate"
                                            ControlToValidate="txtToDate" Type="Date" Operator="GreaterThanEqual" Display="Dynamic"
                                            ValidationGroup="valBooking" Font-Size="XX-Small" SetFocusOnError="true" ForeColor="Crimson"
                                            ErrorMessage="*To date gretter then from date" runat="server"></asp:CompareValidator>
                                    </div>
                                    <div class="form-group">
                                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-outline-primary btn-sm"
                                            ValidationGroup="valBooking" Text="Submit" OnClick="btnSubmit_Click" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label ID="lblMsg" runat="server" Font-Size="X-Small" ForeColor="Red"></asp:Label>
                                    </div>
                                </div>

                                <div class="container">
                                    <div class="form-group">
                                        <asp:Label AssociatedControlID="txtRangeDateFrom" runat="server" Font-Size="Small" CssClass="text-danger">From</asp:Label>
                                        <asp:TextBox ID="txtRangeDateFrom" runat="server" CssClass="form-control form-control-sm range-pick" Font-Size="Small" Width="50%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtRangeDateFrom"
                                            runat="server" Display="Dynamic" ValidationGroup="valBookingRange" Font-Size="XX-Small" SetFocusOnError="true" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label AssociatedControlID="txtRangeDateTo" runat="server" Font-Size="Small" CssClass="text-danger">To</asp:Label>
                                        <asp:TextBox ID="txtRangeDateTo" runat="server" CssClass="form-control form-control-sm range-pick" Font-Size="Small"></asp:TextBox>

                                    </div>

                                    <div class="form-group">
                                        <asp:Button ID="btnRange" runat="server" CssClass="btn btn-outline-primary btn-sm"
                                            ValidationGroup="valBookingRange" Text="Submit" OnClick="btnRange_Click" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label ID="lblMsgRange" runat="server" Font-Size="X-Small" ForeColor="Red"></asp:Label>
                                    </div>

                                </div>


                                <div class="container">
                                    <div class="form-group">
                                        <asp:Label AssociatedControlID="txtRange2" runat="server" Font-Size="Small" CssClass="text-danger">From</asp:Label>
                                        <asp:TextBox ID="txtRange2" runat="server" CssClass="form-control form-control-sm range-pick2" Font-Size="Small" Width="50%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtRange2"
                                            runat="server" Display="Dynamic" ValidationGroup="valBookingRange2" Font-Size="XX-Small" SetFocusOnError="true" />
                                        <asp:RegularExpressionValidator runat="server" ValidationExpression="([12]\d{3}/(0[1-9]|1[0-2])/(0[1-9]|[12]\d|3[01]))-([12]\d{3}/(0[1-9]|1[0-2])/(0[1-9]|[12]\d|3[01]))|([12]\d{3}/(0[1-9]|1[0-2])/(0[1-9]|[12]\d|3[01]))"
                                            ErrorMessage="* Invalid" ForeColor="Crimson" ControlToValidate="txtRange2"
                                            Display="Dynamic" ValidationGroup="valBookingRange2" Font-Size="XX-Small" SetFocusOnError="true">
                                            

                                        </asp:RegularExpressionValidator>
                                    </div>

                                    <div class="form-group">
                                        <asp:Button ID="btnRange2" runat="server" CssClass="btn btn-outline-primary btn-sm"
                                            ValidationGroup="valBookingRange2" Text="Submit" OnClick="btnRange2_Click" />
                                    </div>
                                    <div class="form-group">
                                        <asp:Label ID="lblMsgRange2" runat="server" Font-Size="X-Small" ForeColor="Red" Text="The date is overlape."></asp:Label>
                                    </div>
                                    <asp:HiddenField ID="hdnComplexId" runat="server" ClientIDMode="Static" Value="1" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        </div>

    </form>
</body>
</html>
