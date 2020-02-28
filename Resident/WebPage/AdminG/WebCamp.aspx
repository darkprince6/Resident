<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebCamp.aspx.cs" Inherits="Resident.WebPage.AdminG.WebCamp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-webcam/1.0.0/jquery.webcam.js"></script>
    <script>
        var pageUrl = '<%=ResolveUrl("~/WebPage/AdminG/WebCamp.aspx") %>';
        $(function () {
            $("#webcam").webcam({
                width: 300,
                height: 250,
                mode: "save",
                swffile: '<%=ResolveUrl("~/Image/jscam.swf") %>',
                debug: function (type, status) {
                    $('.camStatus').empty();
                    $('.camStatus').append(status + '<br />');
                    $('.camStatus').show();
                    // $('#camStatus').append(type + ": " + status + '<br /><br />');
                },

                onTick: function (remain) {

                    if (0 == remain) {
                        jQuery(".camStatus").text("Cheese!");
                    } else {
                        jQuery(".camStatus").text(remain + " seconds remaining...");
                    }
                },
                onSave: function (data) {
                    $.ajax({
                        type: "POST",
                        url: pageUrl + "/GetCapturedImage",
                        data: '',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            $(".imgPreview").css("visibility", "visible");
                            $("[id*=imgCapture]").attr("src", r.d);
                        },
                        failure: function (response) {
                            alert(response.d);
                            $('.camStatus').empty();
                            $('.camStatus').append(response.d + '<br />');
                            $('.camStatus').show();
                        }
                    });
                },
                onCapture: function () {
                    webcam.save(pageUrl);
                }
            });

        });
        function Capture() {
            webcam.capture();
            return false;
        }

        function openModal() {
            $('.open-modal').modal('show');
        }

        function closeModal() {
            $('.open-modal').modal('hide');
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btnOpenModal" runat="server" OnClick="btnOpenModal_Click" Text="Open Camera" CssClass="btn btn-outline-success btn-sm mt-1" />



                    <div class="modal fade open-modal" id="AgendaModelForRemove" role="dialog" aria-hidden="false">
                        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h6 class="modal-title">Camera Modal
                                    </h6>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="card border-warning">
                                                <div class="card-body">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <div id="webcam" class="img-fluid img-thumbnail">
                                                            </div>

                                                            <asp:LinkButton ID="lbtnCapture" Text="Capture" runat="server"
                                                                OnClientClick="return Capture();" CssClass="btn btn-outline-success btn-sm mt-1">

                                                            </asp:LinkButton>
                                                            <br />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>

                                                    <%--<span id="camStatus"></span>--%>
                                                    <div class="alert alert-success camStatus p-1 mt-1" style="display: none; font-size: smaller">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="card border-success">
                                                <div class="card-body imgPreview" style="visibility: hidden;">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:Image ID="imgCapture" runat="server" CssClass="img-fluid img-thumbnail" />

                                                            <asp:LinkButton ID="lbtnSave" Text="Save" runat="server" CssClass="btn btn-outline-success btn-sm mt-1" OnClick="lbtnSave_Click"></asp:LinkButton>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-outline-danger btn-sm" data-dismiss="modal">
                                        Close
                                    </button>
                                </div>
                            </div>
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
