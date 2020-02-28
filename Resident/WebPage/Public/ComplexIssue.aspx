<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComplexIssue.aspx.cs" Inherits="Resident.WebPage.Public.ComplexIssue" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/notify/0.4.2/notify.js"></script>

    <script>
        $(document).ready(function () {
            uploader();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (evt, args) {
                uploader();
            });
        });
        function funPopOver() {
            //$('.pop').popover().click(function () {
            //    setTimeout(function () {
            //        $('.pop').popover('hide');
            //    }, 2000);
            //});

            $("#RepIssue_btnShowReply_6").notify(
                "I'm to the right of this box",
                { position: "right" }
            );
        }


        function uploader() {
            $('.custom-file-input').on('change', function () {
                //get the file name
                var fileName = $(this).val();
                //replace the "Choose a file" label
                fileName = fileName.replace("C:\\fakepath\\", "");
                if (fileName != '') {
                    $(this).next('.custom-file-label').html(fileName);
                }
                else {
                    $(this).next('.custom-file-label').html("Choose File");
                }
            });
        }

        function alertmsg() {
            swal({
                title: 'Congratulations!',
                text: 'Your issue has been succesfully listed',
                type: 'success'
            });
        }

        function openModal() {
            $('.openmodal').modal('show');
        }
        function openModal2() {
            $('.openmodal2').modal('show');
        }

        function openModal3() {
            $('.open-issue-modal').modal('show');
        }
    </script>
    <style>
        .m-2px {
            margin: 2px;
        }
    </style>
</head>
<body>



    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="container">
                    <div class="row">

                        <div class="modal fade open-issue-modal" id="IssueModal" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Add a new issue</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="card" style="border: 0px">
                                            <div class="card-body" style="padding: 0px">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="ddlIssueCat" runat="server" Text="Category:"></asp:Label>
                                                            <asp:DropDownList ID="ddlIssueCat" runat="server" CssClass="form-control" DataSourceID="SqlddlIssueCat"
                                                                DataTextField="Name" DataValueField="Id" OnDataBound="ddlIssueCat_DataBound">
                                                            </asp:DropDownList>
                                                            <asp:SqlDataSource runat="server" ID="SqlddlIssueCat" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                                                SelectCommand="SELECT [Id], [Name] FROM [ComplexIssueCat]"></asp:SqlDataSource>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="ddlIssueCat" InitialValue="0"
                                                                runat="server" Display="Dynamic" ValidationGroup="valIssue" Font-Size="XX-Small" SetFocusOnError="true" />

                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtTitle" runat="server" Text="Title:"></asp:Label>
                                                            <asp:TextBox ID="txtTitle" runat="server" Placeholder="Enter a title" CssClass="form-control"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtTitle"
                                                                runat="server" Display="Dynamic" ValidationGroup="valIssue" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr1" runat="server" Text="Desc:"></asp:Label>
                                                            <asp:TextBox ID="txtDescr1" runat="server" Placeholder="Enter a description" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr1"
                                                                runat="server" Display="Dynamic" ValidationGroup="valIssue" Font-Size="XX-Small" SetFocusOnError="true" />
                                                        </div>

                                                        <div class="form-group m-2px">
                                                            <asp:Label AssociatedControlID="txtDescr2" runat="server" Text="Desc:"></asp:Label>
                                                            <asp:TextBox ID="txtDescr2" runat="server" Placeholder="Enter a description" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                                        </div>

                                                        <div class="custom-file">
                                                            <asp:FileUpload ID="fuImage1" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                            <asp:Label AssociatedControlID="fuImage1" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                        </div>
                                                        <div class="custom-control custom-checkbox">
                                                            <input type="checkbox" class="custom-control-input" id="customCheck" runat="server" />
                                                            <label class="custom-control-label" for="customCheck">Terms And Condition</label>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm float-right" ValidationGroup="valIssue" OnClick="btnSubmit_Click" />
                                        <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>

                        </div>


                        <div class="col-sm-2">
                        </div>
                        <div class="col-sm-8">
                            <div class="card">
                                <div class="card-body">
                                    <asp:Button ID="Button1" runat="server" Text="Add Issue" CssClass="btn btn-outline-success btn-sm float-right" ValidationGroup="valIssue" OnClick="btnSubmit_Click" />
                                    <asp:LinkButton ID="lbtnAddIssue" runat="server" CssClass="btn btn-outline-primary" OnClick="lbtnAddIssue_Click"><i class="fa fa-plus-square-o" style="font-size:large"></i> Add Issue</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-2">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-2">
                        </div>
                        <div class="col-sm-8">
                            <asp:Repeater ID="RepIssue" runat="server" DataSourceID="SqlRepIssue" OnItemDataBound="RepIssue_ItemDataBound" OnItemCommand="RepIssue_ItemCommand">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnIssueId" runat="server" Value='<%# Bind("Id") %>' />
                                    <asp:Label ID="lblTitle" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                                    <asp:Button ID="btnReply" runat="server" Text="Reply" CssClass="btn btn-outline-success btn-sm" OnClick="btnReply_Click" />
                                    <asp:Button ID="btnLike" Text="Like" runat="server" CssClass="btn btn-outline-primary btn-sm" OnClick="btnLike_Click" />
                                    <asp:Button ID="btnShowReply" OnClick="btnShowReply_Click" runat="server" CssClass="btn btn-link pop" Text="Show Reply" />
                                    <p></p>
                                    <p></p>
                                    <asp:Repeater ID="RepIssueReply" runat="server">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescr1Reply" runat="server" Text='<%# Bind("Descr1") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="SqlRepIssue" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                SelectCommand="SELECT 
                                            CI.Id, CI.Title, CI.Descr1, CI.Descr2, CI.Descr3, CI.Descr4, CI.Image1, CIC.Name 
                                        FROM 
	                                        ComplexIssues CI
	                                        INNER JOIN  ComplexIssueCat CIC ON CIC.Id=CI.IssueCatId
                                        WHERE 
	                                        (CI.ComplexId = @ComplexId AND CI.IsDel=0)">
                                <SelectParameters>
                                    <asp:QueryStringParameter QueryStringField="Id" DefaultValue="1" Name="ComplexId" Type="Int32"></asp:QueryStringParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                        <div class="col-sm-2">
                        </div>
                    </div>


                    <div class="modal fade openmodal" id="replyModal" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Reply</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <div class="form-group">
                                                    <asp:HiddenField ID="hdnIssueId2" runat="server" />

                                                    <asp:Label AssociatedControlID="txtDescr1Reply" runat="server" Text="Desc:"></asp:Label>
                                                    <asp:TextBox ID="txtDescr1Reply" runat="server" Placeholder="Enter a description" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ErrorMessage="* Required" ForeColor="Crimson" ControlToValidate="txtDescr1Reply"
                                                        runat="server" Display="Dynamic" ValidationGroup="valIssueReply" Font-Size="XX-Small" SetFocusOnError="true" />
                                                </div>

                                                <div class="form-group">
                                                    <asp:Label AssociatedControlID="txtDescr2Reply" runat="server" Text="Desc:"></asp:Label>
                                                    <asp:TextBox ID="txtDescr2Reply" runat="server" Placeholder="Enter a description" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                                </div>

                                                <div class="custom-file">
                                                    <asp:FileUpload ID="fuImage1Reply" runat="server" accept="image/*" CssClass="custom-file-input" />
                                                    <asp:Label AssociatedControlID="fuImage1Reply" CssClass="custom-file-label" runat="server" Font-Size="Smaller">Choose File</asp:Label>
                                                </div>
                                                <asp:RegularExpressionValidator ID="revalfuImage1Reply" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.png|.jpg|.bmp|.gif|.jpeg|.tft|.PNG|.JPG|.BMP|.GIF|.JPEG|.TFT)$"
                                                    ControlToValidate="fuImage1Reply" runat="server" ForeColor="Red" ErrorMessage="*Invalid Image Extension." Font-Size="XX-Small"
                                                    Display="Dynamic" ValidationGroup="valIssueReply" />

                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" class="custom-control-input" id="customCheckReply" runat="server" />
                                                    <label class="custom-control-label" for="customCheckReply">Terms And Condition</label>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="btnReplySubmit" runat="server" Text="Submit" ValidationGroup="valIssueReply" CssClass="btn btn-outline-success btn-sm" OnClick="btnReplySubmit_Click" />
                                    <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>

                    </div>




                    <div class="modal fade openmodal2" id="likeModal" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Comment</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">

                                                <div class="form-group">
                                                    <asp:HiddenField ID="hdnIssueId3" runat="server" />
                                                    <asp:TextBox ID="txtDescrLike" runat="server" Placeholder="Enter a description. If not leave it blank" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button ID="btnLikeSubmit" runat="server" Text="Submit" CssClass="btn btn-outline-success btn-sm" OnClick="btnLikeSubmit_Click" />
                                    <button type="button" class="btn btn-outline-secondary btn-sm" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>

</body>
</html>
