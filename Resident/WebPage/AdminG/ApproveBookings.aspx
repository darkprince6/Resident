<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveBookings.aspx.cs" Inherits="Resident.WebPage.AdminG.ApproveBookings" %>

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
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:HiddenField ID="hdnPixel" runat="server" />
                                <div id="divAminity">
                                    <asp:Repeater ID="RepAminity" runat="server" DataSourceID="SqlRepAminity">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="Id" runat="server" Value='<%# Bind("Id") %>' />

                                            <div class="card mt-1 mb-1 mt-1">
                                                <div class="card-body">
                                                    <h6 class="card-title m-0">
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' ForeColor="SaddleBrown"></asp:Label>
                                                    </h6>

                                                    <asp:LinkButton ID="lbtnShow" runat="server" CssClass="card-link btn-sm text-primary"
                                                        OnClick="lbtnShow_Click" Font-Size="Small">Show
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepAminity.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light">No data found!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="SqlRepAminity" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="SELECT ID, NAME FROM PropertyFlowChart WHERE ComplexId=10"></asp:SqlDataSource>
                                </div>
                                <div id="divBookingSatus" runat="server" visible="false">
                                    <asp:Repeater ID="RepBookingStatus" runat="server" DataSourceID="SqlRepBookingStatus">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnBookingId" runat="server" Value='<%# Eval("Id") %>' />

                                            <div class="card mt-1 mb-1 mt-1">
                                                <div class="card-body">
                                                    <h6 class="card-title m-0">
                                                        <asp:Label ID="lblDate" runat="server" Text='<%# Convert.ToDateTime(Eval("DateFrom")) == Convert.ToDateTime(Eval("DateTo"))? Eval("DateFrom","{0:dd MMM yyyy}"): Eval("DateFrom","{0:dd MMM yyyy}") + " to "+ Eval("DateTo","{0:dd MMM yyyy}") %>' ForeColor="SaddleBrown"></asp:Label>
                                                    </h6>
                                                    <div class="card-text">
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Bind("Descr") %>' ForeColor="SaddleBrown"></asp:Label>
                                                    </div>

                                                    <asp:LinkButton ID="lbtnApproved" runat="server" CssClass="card-link btn-sm text-success"
                                                        OnClick="lbtnApproved_Click" Font-Size="Small">Approved
                                                    </asp:LinkButton>
                                                     <asp:LinkButton ID="lbtnReject" runat="server" CssClass="card-link btn-sm text-danger"
                                                        OnClick="lbtnReject_Click" Font-Size="Small">Reject
                                                    </asp:LinkButton>
                                                     <asp:LinkButton ID="lbtnReply" runat="server" CssClass="card-link btn-sm text-info"
                                                        OnClick="lbtnReply_Click" Font-Size="Small">Reply
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepAminity.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light">No data found!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="AminityBookings_Sel_ForRep" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="ComplexId" Type="Int32" DefaultValue="10" />
                                            <asp:ControlParameter ControlID="hdnPixel" PropertyName="Value" DefaultValue="" Name="PFCId" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
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
