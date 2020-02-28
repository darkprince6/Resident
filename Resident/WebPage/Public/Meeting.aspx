<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Meeting.aspx.cs" Inherits="Resident.WebPage.Public.Meeting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/notify/0.4.2/notify.js"></script>
    <script src="https://kit.fontawesome.com/5f92b8c4a8.js"></script>
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
                        <div class="card-header text-white" style="padding: .75rem 1.25rem; background-color: #899097">
                            <h6>Meetings scheduled in this complex:</h6>
                        </div>
                        <div class="card-body">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RepMeeting" runat="server" DataSourceID="SqlRepMeeting" OnItemDataBound="RepMeeting_ItemDataBound">
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
                                                    <div class="card-text m-0" style="line-height: normal">
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

                                                        <asp:HyperLink ID="lnkShowMeetdetails" runat="server" Target="_blank" CssClass="card-link">
                                                            <i class="far fa-eye"></i> ... show details
                                                        </asp:HyperLink>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepMeeting.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light">No meeting is scheduled as of now!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="SqlRepMeeting" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="Meetings_Sel_ForView" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="AssoId" Name="AssoId" ></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>

                <div class="col-sm-2">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
