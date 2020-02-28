<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResiApprove.aspx.cs" Inherits="Resident.WebPage.AdminG.ResiApprove" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>

    <script>
        function openModal() {
            $('.openmodal').modal('show');
        }

        function closeModal() {
            $('.openmodal').modal('hide');
        }

        function alertmsgforapprove() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully Approved',
                type: 'success'
            });
        }

        function alertmsgforreject() {
            swal({
                title: 'Congratulations!',
                text: 'Successfully rejected',
                type: 'warning'
            });
        }

        function alertmsg() {
            swal({
                title: 'Congratulations!',
                text: 'Sent message Successfully',
                type: 'success'
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="SM1" runat="server"></asp:ScriptManager>
        <div class="container" style="margin-top: 10px">
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="card bg-light text-dark">
                        <div class="card-body mb-2">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="repApprove" runat="server" DataSourceID="SqlRepApprove" OnItemDataBound="repApprove_ItemDataBound">

                                        <ItemTemplate>
                                            <div class="card mb-2">
                                                <div class="card-body">
                                                    <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("Id") %>' />
                                                    <asp:HiddenField ID="hdnIsAppr" runat="server" Value='<%# Eval("IsAppr") %>' />

                                                    <h5 class="card-title"><%# Eval("Name") %></h5>
                                                    <h6 class="card-subtitle mb-2 text-muted"><%# Eval("CrByName") %></h6>
                                                    <p class="card-text">
                                                        Status: <span runat="server" visible='<%#(Eval("IsAppr")).ToString()==string.Empty? true:false %>' class="text-warning">Pending
                                                        </span>
                                                        <span runat="server" visible='<%#(Eval("IsAppr")).ToString()=="True"? true:false %>' class="text-success">Approved
                                                        </span>
                                                        <span runat="server" visible='<%#(Eval("IsAppr")).ToString()=="False"? true:false %>' class="text-danger">Rejected
                                                        </span>
                                                    </p>

                                                    <asp:LinkButton ID="lbtnApprove" CssClass="card-link text-success small" runat="server" OnClick="lbtnApprove_Click"><i class="fas fa-user-check"></i> Approve</asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnReject" CssClass="card-link text-danger small" runat="server" OnClick="lbtnReject_Click"><i class="fas fa-user-times"></i> Reject</asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnSendMessage" CssClass="card-link text-primary small" runat="server" OnClick="lbtnSendMessage_Click"><i class="fas fa-comment-alt"></i> Send Message</asp:LinkButton>

                                                </div>
                                            </div>
                                        </ItemTemplate>


                                    </asp:Repeater>

                                    <asp:SqlDataSource runat="server" ID="SqlRepApprove" ConnectionString='<%$ ConnectionStrings:Residence4UmDBContext %>'
                                        SelectCommand="SELECT 
                                                    PRA.Id, Pra.CrByName, PRA.IsResident, PRA.IsResident, PRA.IsTenant, PRA.Descr, 
                                                    PRA.CrDt, PRA.FromDate, PFC.Name , PRA.IsAppr
                                                FROM 
	                                                PropertyResiApply PRA 
	                                                INNER JOIN 
		                                                PropertyFlowChart PFC ON PRA.PFCId=PFC.Id
                                                WHERE 
	                                                PRA.ComplexId=@ComplexId AND PRA.IsDel=0">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ComplexId" Name="ComplexId"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>


            <div class="modal fade openmodal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Send Message</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="form-group">
                                                    <asp:HiddenField ID="hdnApplyId" runat="server" />

                                                    <asp:Label AssociatedControlID="txtDescr" runat="server" Text="Desc:"></asp:Label>
                                                    <asp:TextBox ID="txtDescr" runat="server" Placeholder="Enter a description" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr"
                                                        runat="server" Display="Dynamic" ValidationGroup="valReply" Font-Size="XX-Small" SetFocusOnError="true" />
                                                </div>
                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" class="custom-control-input" id="customCheckReply" runat="server" />
                                                    <label class="custom-control-label" for="customCheckReply">Terms And Condition</label>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnReplySubmit" runat="server" Text="Submit" ValidationGroup="valReply" CssClass="btn btn-outline-success btn-sm" OnClick="btnReplySubmit_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
