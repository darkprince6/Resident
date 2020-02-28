<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ECandiPoll.aspx.cs" Inherits="Resident.WebPage.Public.ECandiPoll" %>

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

    <script>
        function alertMsgForVote() {
            swal({
                title: '',
                text: 'Successfully count your vote',
                type: 'success'
            });
        }

        function openConfirmPollModal() {
            $('.confirmPollModal').modal('show');
        }

        function closeConfirmPollModal() {
            $('.confirmPollModal').modal('hide');
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
                    <div class="card border-0 bg-light">
                        <div class="card-body m-1">
                            <div class="row">
                                <div class="col-md-2">
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group m-2px">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Label AssociatedControlID="ddlElec" runat="server" Text="Choose an election: " ForeColor="Indigo" Font-Size="Small"></asp:Label>
                                                <asp:DropDownList ID="ddlElec" runat="server" CssClass="form-control form-control-sm" Font-Size="Small" DataSourceID="SqlddlElec"
                                                    OnSelectedIndexChanged="ddlElec_SelectedIndexChanged" AutoPostBack="true"
                                                    DataTextField="Name" DataValueField="Id" AppendDataBoundItems="true">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource runat="server" ID="SqlddlElec" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                    SelectCommand="Elec_Sel_ForDdl" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter QueryStringField="ComplexId" Name="ComplexId" Type="Int32"></asp:QueryStringParameter>
                                                    </SelectParameters>
                                                </asp:SqlDataSource>

                                                <asp:HiddenField ID="hdnPixelPoll" runat="server" />
                                                <asp:HiddenField ID="hdnPixelPost" runat="server" />

                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                </div>
                            </div>
                        </div>

                        <div id="divRepeater">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RepPost" runat="server" DataSourceID="sqlRepPost" OnItemDataBound="RepPost_ItemDataBound" Visible="false">
                                        <ItemTemplate>
                                            <div class="card" style="margin-bottom: 1px; border-radius: unset">
                                                <div class="card-header bg-info text-white text-center" style="padding: 2px; border-radius: unset">
                                                    <%# Eval("PName") %>
                                                    <asp:HiddenField ID="hdnPostId" runat="server" Value='<%# Eval("Id") %>' />
                                                </div>
                                                <div class="card-body" style="padding: 1px">
                                                    <div class="row" style="padding-left: 15px; padding-right: 15px">
                                                        <asp:Repeater ID="RepECandi" runat="server" OnItemDataBound="RepECandi_ItemDataBound">
                                                            <ItemTemplate>
                                                                <div class="col-sm-6 col-md-3 col-xl-3" style="padding: 1px">
                                                                    <div class="card h-100 card-hover border-light bg-light" style="margin-bottom: 0px; box-shadow: none">
                                                                        <div style="margin: auto">
                                                                            <asp:Image ID="img" runat="server" ImageUrl="~/Image/Public/Vote Icon.png" Width="20px" CssClass="img-fluid img-large pointer-cursor" />
                                                                            <asp:HiddenField ID="hdnCandiId" runat="server" Value='<%# Eval("Id") %>' />
                                                                        </div>


                                                                        <div class="card-body p-1">
                                                                            <h6 class="card-title text-primary mb-0">
                                                                                <%# Eval("Name") %>
                                                                            </h6>
                                                                            <div class="card-text" style="font-size: small; margin-bottom: 0px">
                                                                                <div runat="server" visible='<%#(Eval("Age")).ToString()!=""? true:false %>' style="font-size: small">
                                                                                    <span class="text-info">
                                                                                        <b>Age: </b>
                                                                                    </span>
                                                                                    <span runat="server" visible='<%#(Eval("Age")).ToString()!=""? true:false %>'>
                                                                                        <%# Eval("Age") %>
                                                                                    </span>
                                                                                </div>
                                                                                <asp:LinkButton ID="lbtnSubmitPoll" runat="server" CssClass="btn btn-outline-success btn-sm" Font-Size="Small" OnClick="lbtnSubmitPoll_Click">
                                                                                    Submit
                                                                                </asp:LinkButton>

                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                        <asp:SqlDataSource runat="server" ID="SqlRepPost" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                            SelectCommand="AssoPost_Sel_ForRep" SelectCommandType="StoredProcedure">
                                                            <SelectParameters>
                                                                <asp:QueryStringParameter QueryStringField="ComplexId" Name="ComplexId" Type="Int32"></asp:QueryStringParameter>
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>

                                                    </div>
                                                </div>
                                            </div>
                                            <%--<div class="card-columns">--%>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <ul class="list-group" runat="server" visible='<%# bool.Parse((RepPost.Items.Count == 0).ToString()) %>'>
                                                <li class="list-group-item  list-group-item-light border-0">No Record Found!
                                                </li>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:SqlDataSource runat="server" ID="sqlRepPost" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                        SelectCommand="AssoPost_Sel_ForRep" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="ComplexId" Name="ComplexId" Type="Int32"></asp:QueryStringParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:CheckBoxList ID="MyCheckBoxList" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="MyCheckBoxList_SelectedIndexChanged">
                                </asp:CheckBoxList>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="col-md-2">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade confirmPollModal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="alert alert-light fade show mb-0" role="alert">

                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        <h6 class="alert-heading">Warning!</h6>

                        <div class="card border-0 text-center">
                            <div class="card-body p-2">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:Label ID="lblX" runat="server"></asp:Label>
                                        <asp:Button ID="btnSubmitPollConfirm" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm"
                                            OnClick="btnSubmitPollConfirm_Click" />
                                        <button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">
                                            <i class="fas fa-times mr-1"></i>No
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
