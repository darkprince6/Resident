<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MeetingDetails.aspx.cs" Inherits="Resident.WebPage.Public.MeetingDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.7/flatpickr.min.css" />--%>
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker-standalone.css" />--%>
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" />--%>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.1/moment.min.js"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/notify/0.4.2/notify.js"></script>
    <script src="https://kit.fontawesome.com/5f92b8c4a8.js"></script>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.7/flatpickr.min.js"></script>--%>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>--%>
    <script src="../../ScriptsProject/Public/Meeting.js"></script>
    <script>

        function CustValAgenda_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkAgenda.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function CustValAttendance_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkAttendance.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function CustValMinutes_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkMinutes.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function CustValDecisions_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkDecisions.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }


        function CustValAgendaForEdit_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkAgendaForEdit.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function CustValAttendanceForEdit_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkAttendanceForEdit.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function CustValMinutesForEdit_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkMinutesForEdit.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
        function CustValDecisionsForEdit_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkDecisionsForEdit.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div>
                <div class="row mt-3" style="min-height: 700px">
                    <div class="col-sm-2">
                    </div>
                    <div class="col-sm-8">
                        <div class="card bg-white">
                            <div class="card-body">
                                <ul class="nav nav-tabs" id="meetingDetailsTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active btn-sm" id="meeting-tab" data-toggle="tab" href="#meeting" role="tab" aria-controls="meeting" aria-selected="true">
                                            <i class="far fa-handshake mr-1"></i>Meeting</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link btn-sm" id="agenda-tab" data-toggle="tab" href="#agenda" role="tab" aria-controls="agenda" aria-selected="false">
                                            <i class="far fa-list-alt mr-1"></i>Agenda</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link btn-sm" id="attendance-tab" data-toggle="tab" href="#attendance" role="tab" aria-controls="attendance" aria-selected="false">
                                            <i class="fas fa-tasks mr-1"></i>Attendance</a>

                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link btn-sm" id="minutes-tab" data-toggle="tab" href="#minutes" role="tab" aria-controls="minutes" aria-selected="false">
                                            <i class="fas fa-clipboard-list mr-1"></i>Minutes</a>

                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link btn-sm" id="decisions-tab" data-toggle="tab" href="#decisions" role="tab" aria-controls="decisions" aria-selected="false">
                                            <i class="fas fa-stamp mr-1"></i>Decisions</a>
                                    </li>
                                </ul>
                                <div class="tab-content" id="meetingDetailsTabContent">
                                    <div class="tab-pane fade show active" id="meeting" role="tabpanel" aria-labelledby="meeting-tab">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Repeater ID="RepMeeting" runat="server" DataSourceID="SqlRepMeeting">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdnMeetingId" runat="server" Value='<%# Bind("Id") %>' />
                                                        <div class="card mt-1 mb-1">
                                                            <div class="card-body">
                                                                <h6 class="card-title m-0">
                                                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("Title") %>' ForeColor="SaddleBrown"></asp:Label>

                                                                    <div class="text-secondary" style="font-size: small">
                                                                        <span style="font-size: x-small; color: navy">Meeting Date:</span> <%#Eval("MeetDate1", "{0:dd MMM yyyy, hh:mm tt}") %>
                                                                    </div>
                                                                    <div class="text-secondary" style="font-size: small">
                                                                        <span style="font-size: x-small; color: navy">Venue:</span>  <%#Eval("Venue1") %>
                                                                    </div>
                                                                </h6>
                                                                <div class="card-text m-0 text-justify" style="line-height: normal">
                                                                    <div class="indent-text-30px">
                                                                        <asp:Label runat="server" Text='<%# Eval("Descr1") %>' ID="lblDescr1" Font-Size="Small"></asp:Label>
                                                                    </div>
                                                                    <div runat="server" visible='<%#(Eval("Descr2")).ToString()!=""? true:false %>' class="indent-text-30px">
                                                                        <asp:Label runat="server" Text='<%# Eval("Descr2") %>' ID="lblDescr2" Font-Size="Small"></asp:Label>
                                                                    </div>
                                                                    <div class="h6">
                                                                        <asp:Label runat="server" class="text-muted" Font-Size="X-Small">
                                                        Listed on: <%#Eval("CrDt", "{0:dd MMM yyyy}") %>
                                                                        </asp:Label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <asp:SqlDataSource runat="server" ID="SqlRepMeeting" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="Meeting_Details_Sel_ForView" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="MeetingId" Name="MeetingId"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="tab-pane fade" id="agenda" role="tabpanel" aria-labelledby="agenda-tab">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="text-center mt-2">
                                                    <asp:LinkButton ID="lbtnAddAgenda" runat="server" CssClass="btn btn-outline-success btn-sm" OnClick="lbtnAddAgenda_Click">
                                                    <i class="fas fa-plus-circle mr-1"></i> Add Agenda
                                                    </asp:LinkButton>
                                                </div>
                                                <asp:Repeater ID="RepAgenda" runat="server" DataSourceID="SqlRepMeetingAgenda">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdnAgendaId" runat="server" Value='<%# Bind("Id") %>' />
                                                        <asp:HiddenField ID="hdnPriority" runat="server" Value='<%# Bind("Priority") %>' />

                                                        <div class="card mt-1 mb-1 mt-1">
                                                            <div class="card-body">
                                                                <h6 class="card-title m-0">
                                                                    <asp:Label ID="lblTitle" runat="server" Text='<%# Bind("Title") %>' ForeColor="SaddleBrown"></asp:Label>
                                                                </h6>
                                                                <div class="card-text m-0 text-justify" style="line-height: normal">
                                                                    <div class="indent-text-30px">
                                                                        <asp:Label runat="server" Text='<%# Eval("Descr1") %>' ID="lblDescr1" Font-Size="Small"></asp:Label>
                                                                    </div>
                                                                    <div runat="server" visible='<%#(Eval("Descr2")).ToString()!=""? true:false %>'>
                                                                        <asp:Label runat="server" Text='<%# Eval("Descr2") %>' ID="lblDescr2" Font-Size="Small"></asp:Label>
                                                                    </div>
                                                                    <div class="h6">
                                                                        <asp:Label runat="server" class="text-muted" Font-Size="X-Small">
                                                        Listed on: <%#Eval("CrDt", "{0:dd MMM yyyy}") %>
                                                                        </asp:Label>
                                                                    </div>
                                                                </div>
                                                                <asp:LinkButton ID="lbtnEditAgenda" runat="server" CssClass="card-link btn-sm text-primary" 
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                                    OnClick="lbtnEditAgenda_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="lbtnRemoveAgenda" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveAgenda_Click" Font-Size="Small"  
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                                </asp:LinkButton>
                                                                <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                                <asp:LinkButton ID="lbtnReincludeAgenda" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeAgenda_Click" Font-Size="Small"  
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepAgenda.Items.Count == 0).ToString()) %>'>
                                                            <li class="list-group-item  list-group-item-light">No data found!
                                                            </li>
                                                        </ul>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                                <asp:SqlDataSource runat="server" ID="SqlRepMeetingAgenda" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="Meeting_Agenda_Sel_ForView" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="MeetingId" Name="MeetingId"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="tab-pane fade" id="attendance" role="tabpanel" aria-labelledby="attendance-tab">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>

                                                <div class="text-center mt-2">
                                                    <asp:LinkButton ID="lbtnAddAttendance" runat="server" CssClass="btn btn-outline-success btn-sm" OnClick="lbtnAddAttendance_Click">
                                                    <i class="fas fa-plus-circle mr-1"></i> Add Attendance
                                                    </asp:LinkButton>
                                                </div>
                                                <asp:Repeater ID="RepAttendance" runat="server" DataSourceID="SqlRepMeetingRepAttendance">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdnAttendanceId" runat="server" Value='<%# Bind("Id") %>' />
                                                        <asp:HiddenField ID="hdnPriority" runat="server" Value='<%# Bind("Priority") %>' />

                                                        <div class="card mt-1 mb-1 mt-1">
                                                            <div class="card-body">
                                                                <h6 class="card-title m-0">
                                                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' ForeColor="SaddleBrown"></asp:Label>
                                                                </h6>
                                                                <div class="card-text m-0 text-justify" style="line-height: normal">
                                                                    <div class="indent-text-30px">
                                                                        <asp:Label runat="server" Text='<%# Eval("Descr") %>' ID="lblDescr" Font-Size="Small"></asp:Label>
                                                                    </div>
                                                                    <div class="h6">
                                                                        <asp:Label runat="server" class="text-muted" Font-Size="X-Small">
                                                        Listed on: <%#Eval("CrDt", "{0:dd MMM yyyy}") %>
                                                                        </asp:Label>
                                                                    </div>
                                                                </div>
                                                                <asp:LinkButton ID="lbtnEditAttendance" runat="server" CssClass="card-link btn-sm text-primary"
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                                    OnClick="lbtnEditAttendance_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="lbtnRemoveAttendance" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveAttendance_Click" Font-Size="Small"
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                                </asp:LinkButton>
                                                                <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                                <asp:LinkButton ID="lbtnReincludeAttendance" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeAttendance_Click" Font-Size="Small"
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepAttendance.Items.Count == 0).ToString()) %>'>
                                                            <li class="list-group-item  list-group-item-light">No data found!
                                                            </li>
                                                        </ul>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                                <asp:SqlDataSource runat="server" ID="SqlRepMeetingRepAttendance" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="Meeting_Attendance_Sel_ForView" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="MeetingId" Name="MeetingId"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="tab-pane fade" id="minutes" role="tabpanel" aria-labelledby="minutes-tab">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="text-center mt-2">
                                                    <asp:LinkButton ID="lbtnAddMinutes" runat="server" CssClass="btn btn-outline-success btn-sm" OnClick="lbtnAddMinutes_Click">
                                                    <i class="fas fa-plus-circle mr-1"></i> Add Minutes
                                                    </asp:LinkButton>
                                                </div>

                                                <asp:Repeater ID="RepMinutes" runat="server" DataSourceID="SqlRepMeetingMinutes">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdnMinutesId" runat="server" Value='<%# Bind("Id") %>' />
                                                        <asp:HiddenField ID="hdnPriority" runat="server" Value='<%# Bind("Priority") %>' />

                                                        <div class="card mt-1 mb-1 mt-1">
                                                            <div class="card-body">
                                                                <h6 class="card-title m-0">
                                                                    <asp:Label ID="lblTime" runat="server" Text='<%# Bind("Time") %>' ForeColor="SaddleBrown"></asp:Label>
                                                                </h6>
                                                                <div class="card-text m-0 text-justify" style="line-height: normal">
                                                                    <div class="indent-text-30px">
                                                                        <asp:Label runat="server" Text='<%# Eval("Descr1") %>' ID="lblDescr1" Font-Size="Small"></asp:Label>
                                                                    </div>
                                                                    <div runat="server" visible='<%#(Eval("Descr2")).ToString()!=""? true:false %>'>
                                                                        <asp:Label runat="server" Text='<%# Eval("Descr2") %>' ID="lblDescr2" Font-Size="Small"></asp:Label>
                                                                    </div>

                                                                    <div runat="server" visible='<%#(Eval("Descr3")).ToString()!=""? true:false %>'>
                                                                        <asp:Label runat="server" Text='<%# Eval("Descr3") %>' ID="lblDescr3" Font-Size="Small"></asp:Label>
                                                                    </div>
                                                                    <div class="h6">
                                                                        <asp:Label runat="server" class="text-muted" Font-Size="X-Small">
                                                        Listed on: <%#Eval("CrDt", "{0:dd MMM yyyy}") %>
                                                                        </asp:Label>
                                                                    </div>
                                                                </div>
                                                                <asp:LinkButton ID="lbtnEditMinutes" runat="server" CssClass="card-link btn-sm text-primary"
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                                    OnClick="lbtnEditMinutes_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="lbtnRemoveMinutes" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveMinutes_Click" Font-Size="Small"
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                                </asp:LinkButton>
                                                                <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                                <asp:LinkButton ID="lbtnReincludeMinutes" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeMinutes_Click" Font-Size="Small"
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepMinutes.Items.Count == 0).ToString()) %>'>
                                                            <li class="list-group-item  list-group-item-light">No data found!
                                                            </li>
                                                        </ul>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                                <asp:SqlDataSource runat="server" ID="SqlRepMeetingMinutes" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="Meeting_Minutes_Sel_ForView" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="MeetingId" Name="MeetingId"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="tab-pane fade" id="decisions" role="tabpanel" aria-labelledby="decisions-tab">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="text-center mt-2">
                                                    <asp:LinkButton ID="lbtnAddDecisions" runat="server" CssClass="btn btn-outline-success btn-sm" OnClick="lbtnAddDecisions_Click">
                                                    <i class="fas fa-plus-circle mr-1"></i> Add Minutes
                                                    </asp:LinkButton>
                                                </div>

                                                <asp:Repeater ID="RepDecisions" runat="server" DataSourceID="SqlRepMeetingDecisions">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdnDecisionsId" runat="server" Value='<%# Bind("Id") %>' />
                                                        <asp:HiddenField ID="hdnPriority" runat="server" Value='<%# Bind("Priority") %>' />

                                                        <div class="card mt-1 mb-1 mt-1">
                                                            <div class="card-body">
                                                                <h6 class="card-title m-0">
                                                                    <asp:Label ID="lblTime" runat="server" Text='<%# Bind("Title") %>' ForeColor="SaddleBrown"></asp:Label>
                                                                </h6>
                                                                <div class="card-text m-0 text-justify" style="line-height: normal">
                                                                    <div class="indent-text-30px">
                                                                        <asp:Label runat="server" Text='<%# Eval("Descr1") %>' ID="lblDescr1" Font-Size="Small"></asp:Label>
                                                                    </div>
                                                                    <div runat="server" visible='<%#(Eval("Descr2")).ToString()!=""? true:false %>'>
                                                                        <asp:Label runat="server" Text='<%# Eval("Descr2") %>' ID="lblDescr2" Font-Size="Small"></asp:Label>
                                                                    </div>
                                                                    <div class="h6">
                                                                        <asp:Label runat="server" class="text-muted" Font-Size="X-Small">
                                                        Listed on: <%#Eval("CrDt", "{0:dd MMM yyyy}") %>
                                                                        </asp:Label>
                                                                    </div>
                                                                </div>
                                                                <asp:LinkButton ID="lbtnEditDecisions" runat="server" CssClass="card-link btn-sm text-primary"
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                                    OnClick="lbtnEditDecisions_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="lbtnRemoveDecisions" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveDecisions_Click" Font-Size="Small"
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                                </asp:LinkButton>
                                                                <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                                <asp:LinkButton ID="lbtnReincludeDecisions" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeDecisions_Click" Font-Size="Small"
                                                                    Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                                </asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepDecisions.Items.Count == 0).ToString()) %>'>
                                                            <li class="list-group-item  list-group-item-light">No data found!
                                                            </li>
                                                        </ul>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                                <asp:SqlDataSource runat="server" ID="SqlRepMeetingDecisions" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="Meeting_Decisions_Sel_ForView" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="MeetingId" Name="MeetingId"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2">
                    </div>

                </div>
            </div>
        </div>

        <%-- Insert Modal --%>

        <div class="modal fade open-agenda-modal" id="AgendaModel" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleAgenda" runat="server">Add an Agenda</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="row" id="divEntryForAgenda" runat="server" visible="false">
                                                    <div class="col-sm-12">
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtTitleForAgenda" runat="server" Text="Title:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtTitleForAgenda" runat="server" Placeholder="... enter a title" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitleForAgenda"
                                                                runat="server" Display="Dynamic" ValidationGroup="valAgenda" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr1Agenda" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr1Agenda" runat="server" Placeholder="... enter first paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr1Agenda"
                                                                runat="server" Display="Dynamic" ValidationGroup="valAgenda" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr2Agenda" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr2Agenda" runat="server" Placeholder="... enter second paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtPriorityAgenda" runat="server" Text="Priority:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtPriorityAgenda" runat="server" Placeholder="... enter second paragraph" Text="0" MaxLength="2"
                                                                CssClass="form-control form-control-sm numberonly"></asp:TextBox>
                                                            <asp:RangeValidator runat="server" Type="Integer"
                                                                MinimumValue="1" MaximumValue="99" ForeColor="Crimson" ControlToValidate="txtPriorityAgenda"
                                                                Display="Dynamic" ValidationGroup="valAgenda" Font-Size="XX-Small" SetFocusOnError="true"
                                                                ErrorMessage="Value must be a whole number between 1 and 99" />

                                                        </div>

                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input chk-agenda" id="chkAgenda" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkAgenda">Terms And Condition</label>
                                                        </div>
                                                        <div>
                                                            <asp:CustomValidator runat="server" ID="CustValAgenda" EnableClientScript="true"
                                                                Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                                ValidationGroup="valAgenda" OnServerValidate="CustValAgenda_ServerValidate"
                                                                ErrorMessage="* Required" ClientValidationFunction="CustValAgenda_ClientValidate"></asp:CustomValidator>
                                                        </div>
                                                        <asp:Label ID="lblErroMsgForAgenda" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                        </asp:Label>
                                                        <div>
                                                            <asp:Label runat="server" ID="lblNoLogForAgenda" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminForAgenda" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminComForAgenda" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminActGForAgenda" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNotAttachedForAgenda" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnSubmitForAgenda" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm float-right"
                                    ValidationGroup="valAgenda" OnClick="btnSubmitForAgenda_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-attendance-modal" id="AttendanceModel" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblAttendance" runat="server">Add an Attendance</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="row" id="divEntryForAttendance" runat="server">
                                                    <div class="col-sm-12">
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtNameForAttendance" runat="server" Text="Name:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtNameForAttendance" runat="server" Placeholder="... enter a Name" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNameForAttendance"
                                                                runat="server" Display="Dynamic" ValidationGroup="valAttendance" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr1Attendance" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr1Attendance" runat="server" Placeholder="... enter first paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr1Attendance"
                                                                runat="server" Display="Dynamic" ValidationGroup="valAttendance" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr2Attendance" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr2Attendance" runat="server" Placeholder="... enter second paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtPriorityAttendance" runat="server" Text="Priority:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtPriorityAttendance" runat="server" Placeholder="... enter second paragraph" Text="0" MaxLength="2"
                                                                CssClass="form-control form-control-sm numberonly"></asp:TextBox>
                                                            <asp:RangeValidator runat="server" Type="Integer"
                                                                MinimumValue="1" MaximumValue="99" ForeColor="Crimson" ControlToValidate="txtPriorityAttendance"
                                                                Display="Dynamic" ValidationGroup="valAttendance" Font-Size="XX-Small" SetFocusOnError="true"
                                                                ErrorMessage="Value must be a whole number between 1 and 99" />

                                                        </div>


                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input chk-attendance" id="chkAttendance" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkAttendance">Terms And Condition</label>
                                                        </div>
                                                        <div>
                                                            <asp:CustomValidator runat="server" ID="CustValAttendance" EnableClientScript="true"
                                                                Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                                ValidationGroup="valAttendance" OnServerValidate="CustValAttendance_ServerValidate"
                                                                ErrorMessage="* Required" ClientValidationFunction="CustValAttendance_ClientValidate"></asp:CustomValidator>
                                                        </div>

                                                        <asp:Label ID="lblErroMsgForAttendance" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                        </asp:Label>
                                                        <div>
                                                            <asp:Label runat="server" ID="lblNoLogForAttendance" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminForAttendance" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminComForAttendance" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminActGForAttendance" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNotAttachedForAttendance" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnSubmitForAttendance" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm float-right"
                                    ValidationGroup="valAttendance" OnClick="btnSubmitForAttendance_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-minutes-modal" id="MinutesModel" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleForMinutes" runat="server">Add an Minutes</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="row" id="divEntryForMinutes" runat="server" visible="false">
                                                    <div class="col-sm-12">
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtTimeForMinutes" runat="server" Text="Time:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtTimeForMinutes" runat="server" Placeholder="... enter a Time" CssClass="form-control form-control-sm time-picker"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTimeForMinutes"
                                                                runat="server" Display="Dynamic" ValidationGroup="valMinutes" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr1Minutes" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr1Minutes" runat="server" Placeholder="... enter first paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr1Minutes"
                                                                runat="server" Display="Dynamic" ValidationGroup="valMinutes" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr2Minutes" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr2Minutes" runat="server" Placeholder="... enter second paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr3Minutes" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr3Minutes" runat="server" Placeholder="... enter third paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtPriorityMinutes" runat="server" Text="Priority:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtPriorityMinutes" runat="server" Placeholder="... enter second paragraph" Text="0" MaxLength="2"
                                                                CssClass="form-control form-control-sm numberonly"></asp:TextBox>
                                                            <asp:RangeValidator runat="server" Type="Integer"
                                                                MinimumValue="1" MaximumValue="99" ForeColor="Crimson" ControlToValidate="txtPriorityMinutes"
                                                                Display="Dynamic" ValidationGroup="valMinutes" Font-Size="XX-Small" SetFocusOnError="true"
                                                                ErrorMessage="Value must be a whole number between 1 and 99" />

                                                        </div>


                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input chk-minutes" id="chkMinutes" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkMinutes">Terms And Condition</label>
                                                        </div>
                                                        <div>
                                                            <asp:CustomValidator runat="server" ID="CustValMinutes" EnableClientScript="true"
                                                                Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                                ValidationGroup="valMinutes" OnServerValidate="CustValMinutes_ServerValidate"
                                                                ErrorMessage="* Required" ClientValidationFunction="CustValMinutes_ClientValidate"></asp:CustomValidator>
                                                        </div>
                                                        <asp:Label ID="lblErroMsgForMinutes" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                        </asp:Label>
                                                        <div>
                                                            <asp:Label runat="server" ID="lblNoLogForMinutes" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminForMinutes" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminComForMinutes" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminActGForMinutes" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNotAttachedForMinutes" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnSubmitForMinutes" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm float-right"
                                    ValidationGroup="valMinutes" OnClick="btnSubmitForMinutes_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-decisions-modal" id="DecisionsModel" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleDecisions" runat="server">Add a Decisions</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="row" id="divEntryForDecisions" runat="server" visible="false">
                                                    <div class="col-sm-12">
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtTitleForDecisions" runat="server" Text="Title:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtTitleForDecisions" runat="server" Placeholder="... enter a title" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitleForDecisions"
                                                                runat="server" Display="Dynamic" ValidationGroup="valDecisions" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr1Decisions" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr1Decisions" runat="server" Placeholder="... enter first paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr1Decisions"
                                                                runat="server" Display="Dynamic" ValidationGroup="valDecisions" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr2Decisions" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr2Decisions" runat="server" Placeholder="... enter second paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtPriorityDecisions" runat="server" Text="Priority:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtPriorityDecisions" runat="server" Placeholder="... enter second paragraph" Text="0" MaxLength="2"
                                                                CssClass="form-control form-control-sm numberonly"></asp:TextBox>
                                                            <asp:RangeValidator runat="server" Type="Integer"
                                                                MinimumValue="1" MaximumValue="99" ForeColor="Crimson" ControlToValidate="txtPriorityDecisions"
                                                                Display="Dynamic" ValidationGroup="valDecisions" Font-Size="XX-Small" SetFocusOnError="true"
                                                                ErrorMessage="Value must be a whole number between 1 and 99" />

                                                        </div>
                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input chk-decisions" id="chkDecisions" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkDecisions">Terms And Condition</label>
                                                        </div>
                                                        <div>
                                                            <asp:CustomValidator runat="server" ID="CustValDecisions" EnableClientScript="true"
                                                                Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                                ValidationGroup="valDecisions" OnServerValidate="CustValDecisions_ServerValidate"
                                                                ErrorMessage="* Required" ClientValidationFunction="CustValDecisions_ClientValidate"></asp:CustomValidator>
                                                        </div>
                                                        <asp:Label ID="lblErroMsgForDecisions" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                        </asp:Label>
                                                        <div>
                                                            <asp:Label runat="server" ID="lblNoLogForDecisions" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminForDecisions" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminComForDecisions" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminActGForDecisions" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNotAttachedForDecisions" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnSubmitForDecisions" runat="server" Text="Submit"
                                    CssClass="btn btn-outline-success btn-sm float-right" ValidationGroup="valDecisions" OnClick="btnSubmitForDecisions_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- End  --%>


        <%-- Update Modal --%>

        <div class="modal fade open-agenda-modal-for-edit" id="AgendaModelForEdit" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleAgendaForEdit" runat="server">Update an Agenda</asp:Label>
                                    <asp:HiddenField ID="hdnPixel" runat="server" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="row" id="divEntryForAgendaForEdit" runat="server">
                                                    <div class="col-sm-12">
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtTitleForAgendaForEdit" runat="server" Text="Title:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtTitleForAgendaForEdit" runat="server" Placeholder="... enter a title" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitleForAgendaForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valAgendaForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr1AgendaForEdit" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr1AgendaForEdit" runat="server" Placeholder="... enter first paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr1AgendaForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valAgendaForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr2AgendaForEdit" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr2AgendaForEdit" runat="server" Placeholder="... enter second paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtPriorityAgendaForEdit" runat="server" Text="Priority:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtPriorityAgendaForEdit" runat="server" Placeholder="... enter second paragraph" Text="0" MaxLength="2"
                                                                CssClass="form-control form-control-sm numberonly"></asp:TextBox>
                                                            <asp:RangeValidator runat="server" Type="Integer"
                                                                MinimumValue="1" MaximumValue="99" ForeColor="Crimson" ControlToValidate="txtPriorityAgendaForEdit"
                                                                Display="Dynamic" ValidationGroup="valAgendaForEdit" Font-Size="XX-Small" SetFocusOnError="true"
                                                                ErrorMessage="Value must be a whole number between 1 and 99" />

                                                        </div>

                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input chk-agendaForEdit" id="chkAgendaForEdit" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkAgendaForEdit">Terms And Condition</label>
                                                        </div>
                                                        <div>
                                                            <asp:CustomValidator runat="server" ID="CustValAgendaForEdit" EnableClientScript="true"
                                                                Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                                ValidationGroup="valAgendaForEdit" OnServerValidate="CustValAgendaForEdit_ServerValidate"
                                                                ErrorMessage="* Required" ClientValidationFunction="CustValAgendaForEdit_ClientValidate"></asp:CustomValidator>
                                                        </div>
                                                        <asp:Label ID="lblErroMsgForAgendaForEdit" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                        </asp:Label>
                                                        <div>
                                                            <asp:Label runat="server" ID="lblNoLogForAgendaForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminForAgendaForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminComForAgendaForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminActGForAgendaForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNotAttachedForAgendaForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnSubmitForAgendaForEdit" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm float-right"
                                    ValidationGroup="valAgendaForEdit" OnClick="btnSubmitForAgendaForEdit_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-attendance-modal-for-edit" id="AttendanceModelForEdit" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblAttendanceForEdit" runat="server">Update an Attendance</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="row" id="divEntryForAttendanceForEdit" runat="server">
                                                    <div class="col-sm-12">
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtNameForAttendanceForEdit" runat="server" Text="Name:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtNameForAttendanceForEdit" runat="server" Placeholder="... enter a Name" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtNameForAttendanceForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valAttendanceForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescrAttendanceForEdit" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescrAttendanceForEdit" runat="server" Placeholder="... enter a description" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescrAttendanceForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valAttendanceForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtPriorityAttendanceForEdit" runat="server" Text="Priority:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtPriorityAttendanceForEdit" runat="server" Placeholder="... enter second paragraph" Text="0" MaxLength="2"
                                                                CssClass="form-control form-control-sm numberonly"></asp:TextBox>
                                                            <asp:RangeValidator runat="server" Type="Integer"
                                                                MinimumValue="1" MaximumValue="99" ForeColor="Crimson" ControlToValidate="txtPriorityAttendanceForEdit"
                                                                Display="Dynamic" ValidationGroup="valAttendanceForEdit" Font-Size="XX-Small" SetFocusOnError="true"
                                                                ErrorMessage="Value must be a whole number between 1 and 99" />

                                                        </div>


                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input chk-AttendanceForEdit" id="chkAttendanceForEdit" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkAttendanceForEdit">Terms And Condition</label>
                                                        </div>
                                                        <div>
                                                            <asp:CustomValidator runat="server" ID="CustValAttendanceForEdit" EnableClientScript="true"
                                                                Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                                ValidationGroup="valAttendanceForEdit" OnServerValidate="CustValAttendanceForEdit_ServerValidate"
                                                                ErrorMessage="* Required" ClientValidationFunction="CustValAttendanceForEdit_ClientValidate"></asp:CustomValidator>
                                                        </div>

                                                        <asp:Label ID="lblErroMsgForAttendanceForEdit" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                        </asp:Label>
                                                        <div>
                                                            <asp:Label runat="server" ID="lblNoLogForAttendanceForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminForAttendanceForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminComForAttendanceForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminActGForAttendanceForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNotAttachedForAttendanceForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnSubmitForAttendanceForEdit" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm float-right"
                                    ValidationGroup="valAttendanceForEdit" OnClick="btnSubmitForAttendanceForEdit_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-minutes-modal-for-edit" id="MinutesModelForEdit" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleForMinutesForEdit" runat="server">Update a Minutes</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="row" id="divEntryForMinutesForEdit" runat="server">
                                                    <div class="col-sm-12">
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtTimeForMinutesForEdit" runat="server" Text="Time:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtTimeForMinutesForEdit" runat="server" Placeholder="... enter a Time" CssClass="form-control form-control-sm time-picker"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTimeForMinutesForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valMinutesForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr1MinutesForEdit" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr1MinutesForEdit" runat="server" Placeholder="... enter first paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr1MinutesForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valMinutesForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr2MinutesForEdit" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr2MinutesForEdit" runat="server" Placeholder="... enter second paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr3MinutesForEdit" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr3MinutesForEdit" runat="server" Placeholder="... enter third paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtPriorityMinutesForEdit" runat="server" Text="Priority:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtPriorityMinutesForEdit" runat="server" Placeholder="... enter second paragraph" Text="0" MaxLength="2"
                                                                CssClass="form-control form-control-sm numberonly"></asp:TextBox>
                                                            <asp:RangeValidator runat="server" Type="Integer"
                                                                MinimumValue="1" MaximumValue="99" ForeColor="Crimson" ControlToValidate="txtPriorityMinutesForEdit"
                                                                Display="Dynamic" ValidationGroup="valMinutesForEdit" Font-Size="XX-Small" SetFocusOnError="true"
                                                                ErrorMessage="Value must be a whole number between 1 and 99" />

                                                        </div>


                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input chk-MinutesForEdit" id="chkMinutesForEdit" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkMinutesForEdit">Terms And Condition</label>
                                                        </div>
                                                        <div>
                                                            <asp:CustomValidator runat="server" ID="CustValMinutesForEdit" EnableClientScript="true"
                                                                Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                                ValidationGroup="valMinutesForEdit" OnServerValidate="CustValMinutesForEdit_ServerValidate"
                                                                ErrorMessage="* Required" ClientValidationFunction="CustValMinutesForEdit_ClientValidate"></asp:CustomValidator>
                                                        </div>
                                                        <asp:Label ID="lblErroMsgForMinutesForEdit" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                        </asp:Label>
                                                        <div>
                                                            <asp:Label runat="server" ID="lblNoLogForMinutesForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminForMinutesForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminComForMinutesForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminActGForMinutesForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNotAttachedForMinutesForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnSubmitForMinutesForEdit" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm float-right"
                                    ValidationGroup="valMinutesForEdit" OnClick="btnSubmitForMinutesForEdit_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-decisions-modal-for-edit" id="DecisionsModelForEdit" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleDecisionsForEdit" runat="server">Update a Decisions</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="row" id="divEntryForDecisionsForEdit" runat="server">
                                                    <div class="col-sm-12">
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtTitleForDecisionsForEdit" runat="server" Text="Title:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtTitleForDecisionsForEdit" runat="server" Placeholder="... enter a title" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitleForDecisionsForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valDecisionsForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr1DecisionsForEdit" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr1DecisionsForEdit" runat="server" Placeholder="... enter first paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr1DecisionsForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valDecisionsForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr2DecisionsForEdit" runat="server" Text="Description:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtDescr2DecisionsForEdit" runat="server" Placeholder="... enter second paragraph" TextMode="MultiLine" CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtPriorityDecisionsForEdit" runat="server" Text="Priority:" Font-Italic="true" ForeColor="SaddleBrown"></asp:Label>
                                                            <asp:TextBox ID="txtPriorityDecisionsForEdit" runat="server" Placeholder="... enter second paragraph" Text="0" MaxLength="2"
                                                                CssClass="form-control form-control-sm numberonly"></asp:TextBox>
                                                            <asp:RangeValidator runat="server" Type="Integer"
                                                                MinimumValue="1" MaximumValue="99" ForeColor="Crimson" ControlToValidate="txtPriorityDecisionsForEdit"
                                                                Display="Dynamic" ValidationGroup="valDecisionsForEdit" Font-Size="XX-Small" SetFocusOnError="true"
                                                                ErrorMessage="Value must be a whole number between 1 and 99" />

                                                        </div>
                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input chk-DecisionsForEdit" id="chkDecisionsForEdit" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkDecisionsForEdit">Terms And Condition</label>
                                                        </div>
                                                        <div>
                                                            <asp:CustomValidator runat="server" ID="CustValDecisionsForEdit" EnableClientScript="true"
                                                                Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                                ValidationGroup="valDecisionsForEdit" OnServerValidate="CustValDecisionsForEdit_ServerValidate"
                                                                ErrorMessage="* Required" ClientValidationFunction="CustValDecisionsForEdit_ClientValidate"></asp:CustomValidator>
                                                        </div>
                                                        <asp:Label ID="lblErroMsgForDecisionsForEdit" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                        </asp:Label>
                                                        <div>
                                                            <asp:Label runat="server" ID="lblNoLogForDecisionsForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminForDecisionsForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminComForDecisionsForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminActGForDecisionsForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNotAttachedForDecisionsForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnSubmitForDecisionsForEdit" runat="server" Text="Submit"
                                    CssClass="btn btn-outline-success btn-sm float-right" ValidationGroup="valDecisionsForEdit" OnClick="btnSubmitForDecisionsForEdit_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- End  --%>

        <%-- Remove Modal --%>

        <div class="modal fade open-decisions-modal-for-remove" id="DecisionsModelForRemove" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleDecisionsForRemove" runat="server">Remove a Decisions</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <div class="row">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:LinkButton ID="lbtnSubmitForDecisionsForRemove" runat="server"
                                                        CssClass="btn btn-outline-danger btn-sm float-right" OnClick="lbtnSubmitForDecisionsForRemove_Click">
                                                                        <i class="fas fa-check mr-1"></i>Yes
                                                    </asp:LinkButton>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">
                                                <i class="fas fa-times mr-1"></i>No
                                            </button>

                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-agenda-modal-for-remove" id="AgendaModelForRemove" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleAgendaForRemove" runat="server">Remove a Agenda</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <div class="row">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:LinkButton ID="lbtnSubmitForAgendaForRemove" runat="server"
                                                        CssClass="btn btn-outline-danger btn-sm float-right" OnClick="lbtnSubmitForAgendaForRemove_Click">
                                                                        <i class="fas fa-check mr-1"></i>Yes
                                                    </asp:LinkButton>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">
                                                <i class="fas fa-times mr-1"></i>No
                                            </button>

                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-attendance-modal-for-remove" id="AttendanceModelForRemove" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleAttendanceForRemove" runat="server">Remove a Attendance</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <div class="row">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:LinkButton ID="lbtnSubmitForAttendanceForRemove" runat="server"
                                                        CssClass="btn btn-outline-danger btn-sm float-right" OnClick="lbtnSubmitForAttendanceForRemove_Click">
                                                                        <i class="fas fa-check mr-1"></i>Yes
                                                    </asp:LinkButton>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">
                                                <i class="fas fa-times mr-1"></i>No
                                            </button>

                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-minutes-modal-for-remove" id="MinutesModelForRemove" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleMinutesForRemove" runat="server">Remove a Minutes</asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body card-body-modal-popup">
                                        <div class="row">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:LinkButton ID="lbtnSubmitForMinutesForRemove" runat="server"
                                                        CssClass="btn btn-outline-danger btn-sm float-right" OnClick="lbtnSubmitForMinutesForRemove_Click">
                                                                        <i class="fas fa-check mr-1"></i>Yes
                                                    </asp:LinkButton>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">
                                                <i class="fas fa-times mr-1"></i>No
                                            </button>

                                        </div>

                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>

        <%-- End  --%>
    </form>
</body>
</html>
