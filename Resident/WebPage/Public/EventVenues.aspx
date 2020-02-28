<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EventVenues.aspx.cs" Inherits="Resident.WebPage.Public.EventVenues" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.7/flatpickr.min.css" />
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker-standalone.css" />--%>
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" />--%>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/angular_material/1.1.12/angular-material.min.css" />


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.1/moment.min.js"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/notify/0.4.2/notify.js"></script>
    <script src="https://kit.fontawesome.com/5f92b8c4a8.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.5.7/flatpickr.min.js"></script>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>--%>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-maxlength/1.7.0/bootstrap-maxlength.min.js"></script>--%>
    <script src="../../ScriptsProject/Public/jquery.charCountPlugin.js"></script>
    <script src="../../ScriptsProject/Public/EventVenues.js"></script>
    <script>
        

        function CustValVenue_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkVenue.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function CustValVenueForEdit_ClientValidate(sender, args) {
            if (document.getElementById("<%=chkVenueForEdit.ClientID %>").checked == true) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <div class="row mt-3" style="min-height: 700px">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <div class="card bg-white">
                        <div class="card-body">
                            <ul class="nav nav-tabs" id="eventDetailsTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active btn-sm" id="event-tab" data-toggle="tab" href="#event" role="tab" aria-controls="event" aria-selected="true">
                                        <i class="fas fa-flag-checkered mr-1"></i>Event</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link btn-sm" id="venue-tab" data-toggle="tab" href="#venue" role="tab" aria-controls="venue" aria-selected="false">
                                        <i class="fas fa-map-marker-alt mr-1"></i>Venue</a>
                                </li>

                            </ul>
                            <div class="tab-content" id="eventDetailsTabContent">
                                <div class="tab-pane fade show active" id="event" role="tabpanel" aria-labelledby="event-tab">
                                    <asp:Repeater ID="RepEvents" runat="server" DataSourceID="sqlRepEvents">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnComplexEventId" runat="server" Value='<%# Eval("ComplexEventId") %>' />
                                            <asp:HiddenField ID="hdnEventId" runat="server" Value='<%# Eval("EventId") %>' />
                                            <div class="card mb-2">
                                                <div class="row">
                                                    <div class="col-md-3" runat="server">
                                                        <%--<asp:Image ID="img" runat="server" ImageUrl='<%# Eval("Image").ToString() != "" ? Eval("Image") : ResolveUrl("~/Img/Profile/NoImage.png")  %>' CssClass="img-fluid w-100 p-2" />--%>
                                                    </div>
                                                    <div class="col-md-9">
                                                        <div class="card-block p-2">
                                                            <h6 class="card-title m-0">
                                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' ForeColor="SaddleBrown"></asp:Label>
                                                            </h6>

                                                            <div class="card-text m-0">
                                                                <asp:Label ID="lblTag" runat="server" Text='<%# Eval("NameTag") %>' ForeColor="SaddleBrown"></asp:Label>

                                                                <div class="h6 mb-0">
                                                                    <span style="font-size: x-small">From - To Date: 
                                                                    </span>
                                                                    <span>
                                                                        <asp:Label ID="lblFromDate" runat="server" Font-Size="X-Small" Text='<%# Eval("FromDate","{0:dd MMM yyyy}") %>'> </asp:Label>
                                                                        <asp:HiddenField ID="hdnFromDate" runat="server" Value='<%# Eval("FromDate","{0:yyyy-MM-dd}") %>' />
                                                                    </span>
                                                                    <span runat="server" visible='<%#(Eval("ToDate")).ToString()!=""? true:false %>'>-
                                                                                <asp:Label ID="lblToDate" runat="server" Font-Size="X-Small" Text='<%# Eval("ToDate","{0:dd MMM yyyy}") %>'> </asp:Label>
                                                                        <asp:HiddenField ID="hdnToDate" runat="server" Value='<%# Eval("ToDate","{0:yyyy-MM-dd}") %>' />
                                                                    </span>
                                                                </div>
                                                                <div class="h6 mb-0">
                                                                    <asp:Label runat="server" class="text-muted" Font-Size="XX-Small"
                                                                        Text='<%# Eval("ModDt").ToString() =="" ? "Listed On: "+Eval("CrDt","{0:dd MMM yyyy hh:mm tt}"): "Updated On: "+Eval("ModDt", "{0:dd MMM yyyy hh:mm tt}") %>'>
                                                                        
                                                                    </asp:Label>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepEvents.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light small">No record listed as of now!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>

                                    <asp:SqlDataSource runat="server" ID="sqlRepEvents" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="ComplexEvents_Sel_ForRep_ById" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ComplexEventId" Name="ComplexEventId" Type="Int32" DefaultValue="1" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="tab-pane fade" id="venue" role="tabpanel" aria-labelledby="venue-tab">

                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="text-center mt-2">
                                                <asp:LinkButton ID="lbtnAddVenue" runat="server" CssClass="btn btn-outline-success btn-sm" OnClick="lbtnAddVenue_Click">
                                                    <i class="fas fa-plus-circle mr-1"></i> Add Venue
                                                </asp:LinkButton>
                                            </div>
                                            <asp:Repeater ID="RepVenue" runat="server" DataSourceID="SqlRepMeetingVenue">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnVenueId" runat="server" Value='<%# Bind("Id") %>' />

                                                    <div class="card mt-1 mb-1 mt-1">
                                                        <div class="card-body">
                                                            <h6 class="card-title m-0">
                                                                <asp:Label ID="lblTitleForVenue" runat="server" Text='<%# Bind("Title") %>' ForeColor="SaddleBrown"></asp:Label>
                                                            </h6>
                                                            <div class="card-text m-0 text-justify" style="line-height: normal">
                                                                <div>
                                                                    <asp:Label runat="server" Text='<%# Eval("Address1") %>' ID="lblAdd1ForVenue" Font-Size="Small"></asp:Label>

                                                                    <span runat="server" visible='<%#(Eval("Address2")).ToString()!=""? true:false %>'>,<asp:Label runat="server" Text='<%# Eval("Address2") %>' ID="lblAdd2ForVenue" Font-Size="Small"></asp:Label>
                                                                    </span>
                                                                    <span>-
                                                                        <asp:Label runat="server" Text='<%# Eval("PostalCode") %>' ID="lblPostalCodeForVenue" Font-Size="Small"></asp:Label>
                                                                    </span>

                                                                </div>

                                                                <div>
                                                                    <asp:Label runat="server" Text='<%# Eval("FromDate") %>' ID="lblFromDateForVenue" Font-Size="Small"></asp:Label>
                                                                    <asp:HiddenField ID="hdnFromDateForVenue" runat="server" Value='<%# Eval("FromDate","{0:yyyy-MM-dd}") %>' />


                                                                    <span runat="server" visible='<%#(Eval("ToDate")).ToString()!=""? true:false %>'>-
                                                                        <asp:Label runat="server" Text='<%# Eval("ToDate") %>' ID="lblToDateForVenue" Font-Size="Small"></asp:Label>
                                                                    </span>
                                                                    <asp:HiddenField ID="hdnToDateForVenue" runat="server" Value='<%# Eval("ToDate","{0:yyyy-MM-dd}") %>' />

                                                                </div>

                                                                <div>
                                                                    <asp:Label runat="server" Text='<%# Eval("Descr") %>' ID="lblDescrForVenue" Font-Size="Small"></asp:Label>
                                                                </div>
                                                                <div class="h6 mb-0">
                                                                    <asp:Label runat="server" class="text-muted" Font-Size="XX-Small"
                                                                        Text='<%# Eval("ModDt").ToString() =="" ? "Listed On: "+Eval("CrDt","{0:dd MMM yyyy hh:mm tt}"): "Updated On: "+Eval("ModDt", "{0:dd MMM yyyy hh:mm tt}") %>'>
                                                                        
                                                                    </asp:Label>
                                                                </div>
                                                            </div>
                                                            <asp:LinkButton ID="lbtnEditVenue" runat="server" CssClass="card-link btn-sm text-primary"
                                                                Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'
                                                                OnClick="lbtnEditVenue_Click" Font-Size="Small">
                                                                    <i class="far fa-edit"></i> Edit
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnRemoveVenue" runat="server" CssClass="card-link btn-sm text-danger" OnClick="lbtnRemoveVenue_Click" Font-Size="Small"
                                                                Visible='<%#(Eval("IsDel")).ToString()=="False"? true:false %>'>
                                                                    <i class="far fa-trash-alt"></i> Remove
                                                            </asp:LinkButton>
                                                            <asp:Label runat="server" CssClass="text-danger" Font-Size="10px" Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>Removed</asp:Label>
                                                            <asp:LinkButton ID="lbtnReincludeVenue" runat="server" CssClass="card-link btn-sm text-warning" OnClick="lbtnReincludeVenue_Click" Font-Size="Small"
                                                                Visible='<%#(Eval("IsDel")).ToString()=="True"? true:false %>'>
                                                                   <i class="fas fa-undo"></i> Re-include
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepVenue.Items.Count == 0).ToString()) %>'>
                                                        <li class="list-group-item  list-group-item-light">No data found!
                                                        </li>
                                                    </ul>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            <asp:SqlDataSource runat="server" ID="SqlRepMeetingVenue" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                SelectCommand="EventVenues_Sel_ForView" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter QueryStringField="ComplexEventId" Name="ComplexEventId"></asp:QueryStringParameter>
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

        <div class="modal fade open-venue-modal" id="VenueModel" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleVenue" runat="server">Add an Venue</asp:Label>
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
                                                <div class="row" id="divEntryForVenue" runat="server" visible="false">
                                                    <div class="col-sm-12">
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtTitleForVenueForIns" runat="server" Text="Title:" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtTitleForVenueForIns" runat="server" Placeholder="... enter a title" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitleForVenueForIns"
                                                                runat="server" Display="Dynamic" ValidationGroup="valVenue" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtAdd1ForVenueForIns" runat="server" Text="Address Line1 *:" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtAdd1ForVenueForIns" runat="server" Placeholder="... enter address line1" TextMode="MultiLine" Height="80" data-charcount="true" data-maxlen="250"
                                                                CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtAdd1ForVenueForIns"
                                                                runat="server" Display="Dynamic" ValidationGroup="valVenue" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtAdd2ForVenueForIns" runat="server" Text="Address Line2:" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtAdd2ForVenueForIns" runat="server" Placeholder="... enter address line2" TextMode="MultiLine" Height="80" data-charcount="true" data-maxlen="250"
                                                                CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtPostalCodeForVenueForIns" runat="server" Text="Postal Code *:" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtPostalCodeForVenueForIns" runat="server" Placeholder="... enter postal code" CssClass="form-control form-control-sm" MaxLength="6"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPostalCodeForVenueForIns"
                                                                runat="server" Display="Dynamic" ValidationGroup="valVenue" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtFromDateForVenueForIns" runat="server" Text="From Date*:" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtFromDateForVenueForIns" runat="server" Placeholder="... enter from date"
                                                                CssClass="form-control form-control-sm date-picker-from"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtFromDateForVenueForIns"
                                                                runat="server" Display="Dynamic" ValidationGroup="valVenue" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtToDateForVenueForIns" runat="server" Text="To Date:" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtToDateForVenueForIns" runat="server" Placeholder="... enter from date"
                                                                CssClass="form-control form-control-sm date-picker-to"></asp:TextBox>
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescrForVenueForIns" runat="server" Text="Description:" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtDescrForVenueForIns" runat="server" Placeholder="... enter description" TextMode="MultiLine" Height="100" data-charcount="true" data-maxlen="500"
                                                                CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>


                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input chk-venue" id="chkVenue" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkVenue">Terms And Condition</label>
                                                        </div>
                                                        <div>
                                                            <asp:CustomValidator runat="server" ID="CustValVenue" EnableClientScript="true"
                                                                Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                                ValidationGroup="valVenue" OnServerValidate="CustValVenue_ServerValidate"
                                                                ErrorMessage="* Required" ClientValidationFunction="CustValVenue_ClientValidate"></asp:CustomValidator>
                                                        </div>
                                                        <asp:Label ID="lblErroMsgForVenue" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                        </asp:Label>
                                                        <div>
                                                            <asp:Label runat="server" ID="lblNoLogForVenue" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminForVenue" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminComForVenue" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminActGForVenue" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNotAttachedForVenue" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
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
                                <asp:Button ID="btnSubmitForVenue" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm float-right"
                                    ValidationGroup="valVenue" OnClick="btnSubmitForVenue_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-venue-modal-for-edit" id="VenueModelForEdit" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleVenueForEdit" runat="server">Update an Venue</asp:Label>
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
                                                <div class="row" id="divEntryForVenueForEdit" runat="server">
                                                    <div class="col-sm-12">

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtTitleForVenueForEdit" runat="server" Text="Title:" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtTitleForVenueForEdit" runat="server" Placeholder="... enter a title" CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitleForVenueForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valVenueForEdit0" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtAdd1ForVenueForEdit" runat="server" Text="Address Line1 *:" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtAdd1ForVenueForEdit" runat="server" Placeholder="... enter address line1" TextMode="MultiLine" Height="80"
                                                                CssClass="form-control form-control-sm"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtAdd1ForVenueForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valVenueForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtAdd2ForVenueForEdit" runat="server" Text="Address Line2:" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtAdd2ForVenueForEdit" runat="server" Placeholder="... enter address line2" TextMode="MultiLine" Height="80"
                                                                CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtPostalCodeForVenueForEdit" runat="server" Text="Postal Code *:" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtPostalCodeForVenueForEdit" runat="server" Placeholder="... enter postal code" CssClass="form-control form-control-sm" MaxLength="6"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtPostalCodeForVenueForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valVenueForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtFromDateForVenueForEdit" runat="server" Text="From Date*:" CssClass="text-danger" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtFromDateForVenueForEdit" runat="server" Placeholder="... enter from date"
                                                                CssClass="form-control form-control-sm date-picker-from"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtFromDateForVenueForEdit"
                                                                runat="server" Display="Dynamic" ValidationGroup="valVenueForEdit" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtToDateForVenueForEdit" runat="server" Text="To Date:" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtToDateForVenueForEdit" runat="server" Placeholder="... enter from date"
                                                                CssClass="form-control form-control-sm date-picker-to"></asp:TextBox>
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescrForVenueForEdit" runat="server" Text="Description:" Font-Size="Small"></asp:Label>
                                                            <asp:TextBox ID="txtDescrForVenueForEdit" runat="server" Placeholder="... enter description" TextMode="MultiLine" Height="100"
                                                                CssClass="form-control form-control-sm"></asp:TextBox>
                                                        </div>


                                                        <div class="custom-control custom-checkbox m-1">
                                                            <input type="checkbox" class="custom-control-input chk-venueForEdit" id="chkVenueForEdit" runat="server" clientidmode="static" />
                                                            <label class="custom-control-label" for="chkVenueForEdit">Terms And Condition</label>
                                                        </div>
                                                        <div>
                                                            <asp:CustomValidator runat="server" ID="CustValVenueForEdit" EnableClientScript="true"
                                                                Display="Dynamic" Font-Size="X-Small" ForeColor="Crimson"
                                                                ValidationGroup="valVenueForEdit" OnServerValidate="CustValVenueForEdit_ServerValidate"
                                                                ErrorMessage="* Required" ClientValidationFunction="CustValVenueForEdit_ClientValidate"></asp:CustomValidator>
                                                        </div>
                                                        <asp:Label ID="lblErroMsgForVenueForEdit" runat="server" ForeColor="Crimson" Font-Size="Small" Visible="false">
                                                                    <i class="fas fa-exclamation-triangle mr-1"></i> Failed to submit data. Please try again
                                                        </asp:Label>
                                                        <div>
                                                            <asp:Label runat="server" ID="lblNoLogForVenueForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not logged-in or session has expired."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminForVenueForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the governing association of this complex to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminComForVenueForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the committee you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNoAdminActGForVenueForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You do not hold an admin post in the activity group you have selected to schedule a meeting on its behalf. <b>You can share as an individual</b>."></asp:Label>
                                                            <asp:Label runat="server" ID="lblNotAttachedForVenueForEdit" Font-Bold="true" ForeColor="Crimson" Visible="false" Font-Size="X-Small" Text="You are not an authorised owner / resident of this complex. So you can't schedule a meeting inside it."></asp:Label>
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
                                <asp:Button ID="btnSubmitForVenueForEdit" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm float-right"
                                    ValidationGroup="valVenueForEdit" OnClick="btnSubmitForVenueForEdit_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade open-venue-modal-for-remove" id="VenueModelForRemove" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblTitleVenueForRemove" runat="server">Remove a Venue</asp:Label>
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
                                                    <asp:LinkButton ID="lbtnSubmitForVenueForRemove" runat="server"
                                                        CssClass="btn btn-outline-danger btn-sm float-right" OnClick="lbtnSubmitForVenueForRemove_Click">
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

    </form>
</body>
</html>
