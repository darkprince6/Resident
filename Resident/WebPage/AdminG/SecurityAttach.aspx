<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SecurityAttach.aspx.cs" Inherits="Resident.WebPage.AdminG.SecurityAttach" %>

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
    <script src="../../ScriptsProject/SecurityAttach.js"></script>
    <style>
        .slow-spin {
            -webkit-animation: fa-spin 6s infinite linear;
            animation: fa-spin 6s infinite linear;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#attachStaff">Attach Staff</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#approveStaff ">Approve Staff</a>
                        </li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane container active" id="attachStaff">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="card border-0 mt-2" style="margin-bottom: 5px">
                                        <div class="card-header p-1 border-0 bg-gradient-2" style="font-weight: 600;">
                                            <h6>Staff List</h6>
                                        </div>
                                        <asp:HiddenField ID="hdnPixel" runat="server" Visible="false" />
                                        <asp:HiddenField ID="hdnPixelPost" runat="server" Visible="false" />
                                        <asp:HiddenField ID="hdnPixelApprove" runat="server" Visible="false" />

                                        <div class="card-body" style="padding: 1px">
                                            <asp:Repeater ID="RepPost" runat="server" OnItemDataBound="RepPost_ItemDataBound">
                                                <ItemTemplate>
                                                    <div class="card" style="margin-bottom: 1px; border-radius: unset; border: 0px">
                                                        <div class="card-header bg-light" style="padding: 4px; border-radius: unset; border: 0">
                                                            <span class="btn btn-info btn-sm small" style="cursor: default">
                                                                <%# Eval("PName") %> :
                                                            </span>
                                                            <asp:HiddenField ID="hdnPostId" runat="server" Value='<%# Eval("Id") %>' Visible="false" />
                                                        </div>

                                                        <div class="card-body" style="padding: 1px">
                                                            <div class="row" style="padding-left: 15px; padding-right: 15px">

                                                                <asp:Repeater ID="RepStaff" runat="server">
                                                                    <ItemTemplate>
                                                                        <asp:HiddenField ID="hdnStaffId" runat="server" Value='<%# Eval("Id") %>' Visible="false" />
                                                                        <asp:HiddenField ID="hdnPostId" runat="server" Value='<%# Eval("PostId") %>' Visible="false" />

                                                                        <div class="col-md-6 col-md-3 col-xl-3" style="padding: 1px">
                                                                            <div class="card h-100 border-light" style="margin-bottom: 0px; box-shadow: none">
                                                                                <div class="card-body p-2">
                                                                                    <div style="max-width: 70px">
                                                                                        <asp:Image ID="img" runat="server" ImageUrl='<%# Eval("Image1").ToString() != "" ? Eval("Image1") : ResolveUrl("~/Image/wallpaper.jpg")  %>' CssClass="img-fluid img-large pointer-cursor" />
                                                                                    </div>
                                                                                    <h6 class="card-title text-primary mb-1">
                                                                                        <%# Eval("Name") %>
                                                                                    </h6>
                                                                                    <div class="card-text" style="font-size: small; margin-bottom: 0px">

                                                                                        <asp:Label runat="server" CssClass="text-success" Font-Size="12px" Visible='<%#(Eval("IsAppr")).ToString()=="True" && (Eval("IsSend")).ToString()=="True"? true:false %>'>
                                                                                                <i class="far fa-check-circle mr-1" style="color:#82c91e"></i>Approved
                                                                                        </asp:Label>

                                                                                        <asp:Label runat="server" CssClass="text-danger" Font-Size="12px" Visible='<%#(Eval("IsAppr")).ToString()=="False" && (Eval("IsSend")).ToString()=="True"? true:false %>'>
                                                                                            <i class="far fa-times-circle mr-1" style="color:#f783ac"></i>Decline
                                                                                        </asp:Label>

                                                                                        <asp:LinkButton ID="lbtnStaffCheck" runat="server" Font-Size="X-Small" Visible='<%#((Eval("IsAppr")).ToString()==string.Empty) && ((Eval("IsSend")).ToString()=="False")? true:false %>'
                                                                                            CssClass="btn btn-outline-primary btn-sm" OnClick="lbtnStaffCheck_Click">
                                                                                   <i class="fas fa-share-square mr-1" style="color:#82c91e"></i>Send
                                                                                        </asp:LinkButton>

                                                                                       
                                                                                        <button class="btn btn-outline-secondary btn-sm small" disabled="disabled" runat="server" style="font-size:x-small"
                                                                                            visible='<%#((Eval("IsAppr")).ToString()==string.Empty) && ((Eval("IsSend")).ToString()=="True")? true:false %>'>
                                                                                            <i class="fas fa-cog fa-spin slow-spin"></i> Send
                                                                                        </button>
                                                                                    </div>

                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                    </ItemTemplate>

                                                                </asp:Repeater>

                                                                <asp:Panel ID="pnlStaffNotFound" runat="server" Visible="false">
                                                                    <ul class="list-group text-center mt-1" runat="server">
                                                                        <li class="list-group-item  list-group-item-warning border-0 small mr-1"><i class="fas fa-exclamation-triangle mr-1"></i>No record found!
                                                                        </li>
                                                                    </ul>
                                                                </asp:Panel>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <div class="col-sm-12">
                                                        <ul class="list-group text-center mt-1" runat="server" visible='<%# bool.Parse((RepPost.Items.Count == 0).ToString()) %>'>
                                                            <li class="list-group-item  list-group-item-warning border-0 small mr-1"><i class="fas fa-exclamation-triangle mr-1"></i>No record found!
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </div>

                                        <asp:SqlDataSource ID="SqlRepPost" runat="server" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                            SelectCommand="MaintPosts_Sel_ForRep" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:RouteParameter RouteKey="ComplexId" Name="ComplexId" DefaultValue="1"></asp:RouteParameter>
                                            </SelectParameters>

                                        </asp:SqlDataSource>

                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <div class="tab-pane container fade" id="approveStaff">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RepApproveStaff" runat="server">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdnAttachId" runat="server" Value='<%# Eval("Id") %>' Visible="false" />
                                            <asp:HiddenField ID="hdnStaffId" runat="server" Value='<%# Eval("StaffId") %>' Visible="false" />

                                            <div class="card mb-2 mt-2">
                                                <div class="card-body p-2">
                                                    <h6 class="card-title">
                                                        <asp:Label ID="lblStaff" CssClass="name" runat="server" Text='<%# Eval("Staff") %>' ForeColor="SaddleBrown" Font-Size="Small"></asp:Label>
                                                        <span class="badge badge-pill badge-secondary">
                                                            <%# Eval("PName") %>
                                                        </span>
                                                    </h6>
                                                    <div class="card-text">
                                                        <asp:Label runat="server" CssClass="text-success" Font-Size="Small" Visible='<%#(Eval("IsAppr")).ToString()=="True"? true:false %>'>
                                                            <i class="far fa-check-circle mr-1" style="color:#82c91e"></i>Approved
                                                        </asp:Label>

                                                        <asp:Label runat="server" CssClass="text-danger" Font-Size="Small" Visible='<%#(Eval("IsAppr")).ToString()=="False"? true:false %>'>
                                                            <i class="far fa-times-circle mr-1" style="color:#f783ac"></i>Decline
                                                        </asp:Label>
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
                                                    <asp:LinkButton ID="lbtnApprove" runat="server" Font-Size="X-Small" Visible='<%#(Eval("IsAppr")).ToString()==string.Empty? true:false %>'
                                                        CssClass="btn btn-outline-success btn-sm" OnClick="lbtnApprove_Click">
                                                                                   <i class="far fa-check-circle mr-1" style="color:#82c91e"></i>Approve
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="lbtnDecline" runat="server" Font-Size="X-Small" Visible='<%#(Eval("IsAppr")).ToString()==string.Empty? true:false %>'
                                                        CssClass="btn btn-outline-danger btn-sm" OnClick="lbtnDecline_Click">
                                                                                   <i class="far fa-times-circle mr-1" style="color:#f783ac"></i>Decline
                                                    </asp:LinkButton>


                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group text-center" runat="server" visible='<%# bool.Parse((RepApproveStaff.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-warning border-0 small"><i class="fas fa-exclamation-triangle mr-1"></i>No record listed as of now!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource ID="SqlRepApproveStaff" runat="server" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="MaintStaffAttach_Sel_ForRep" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:RouteParameter RouteKey="ComplexId" Name="ComplexId" DefaultValue="1"></asp:RouteParameter>
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

        <div class="modal fade staffCheckModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Staff Check</h6>

                        <div class="card border-0 text-center">
                            <div class="card-body p-2">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnCheckSubmit" runat="server" class="btn btn-outline-danger btn-sm" Text="Yes" OnClick="btnCheckSubmit_Click" />
                                        <button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">
                                            No
                                        </button>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade staffApproveModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Staff Approve</h6>

                        <div class="card border-0 text-center">
                            <div class="card-body p-2">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnApproveSubmit" runat="server" class="btn btn-outline-danger btn-sm" Text="Yes" OnClick="btnApproveSubmit_Click" />
                                        <button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">
                                            No
                                        </button>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade staffDeclineModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Staff Decline</h6>

                        <div class="card border-0 text-center">
                            <div class="card-body p-2">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnDeclineSubmit" runat="server" class="btn btn-outline-danger btn-sm" Text="Yes" OnClick="btnDeclineSubmit_Click" />
                                        <button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">
                                            No
                                        </button>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>
