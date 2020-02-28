<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Event.aspx.cs" Inherits="Resident.WebPage.Public.Event" %>

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
                                    <asp:Repeater ID="RepEvents" runat="server" DataSourceID="sqlRepEvents" OnItemDataBound="RepEvents_ItemDataBound">
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

                                                                <asp:HyperLink ID="lnkAddVanue" runat="server" Target="_blank" CssClass="card-link">
                                                                    <i class="fas fa-map-marker-alt"></i> ... add vanue
                                                                </asp:HyperLink>

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
                                        SelectCommand="ComplexEvents_Sel_ForRep" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ComplexId" Name="ComplexId" Type="Int32" DefaultValue="1" />
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

