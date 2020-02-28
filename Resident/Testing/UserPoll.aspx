<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserPoll.aspx.cs" Inherits="Resident.Testing.UserPoll" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <%--<link rel="stylesheet" href="/resources/demos/style.css" />--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <style>
        legend.scheduler-border {
            width: inherit;
            padding: 0 10px;
            border-bottom: none;
            font-size: 0.8em !important;
            font-weight: bold !important;
            text-align: left !important;
            color: coral;
        }

        fieldset.scheduler-border {
            border: 1px groove #FF8800 !important;
            padding: 0 1.4em 1.4em 1.4em !important;
            -webkit-box-shadow: 0px 0px 0px 0px #000;
            box-shadow: 0px 0px 0px 0px #000;
        }
    </style>
    <script>

        $(document).ready(function () {
            $("#RbtnAnswer").buttonset();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sc1" runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div id="divOnlinePoll" runat="server">
                                <div class="card">
                                    <div class="card-body">

                                        <asp:Repeater ID="RepQuestion" runat="server" DataSourceID="SqlRepQuestion">
                                            <ItemTemplate>
                                                <div class="card mb-2">
                                                    <div class="card-body">
                                                        <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("Id") %>' />

                                                        <h6 class="card-title mb-1">
                                                            <asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question") %>' ForeColor="Crimson"></asp:Label>
                                                        </h6>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>



                                        <asp:SqlDataSource runat="server" ID="SqlRepQuestion" ConnectionString='<%$ ConnectionStrings:DemoCon %>'
                                            SelectCommand="SELECT 
                                                                [Id],[Question]
                                                            FROM 
                                                                [Question]
                                                            WHERE 
                                                                ([Id] = @Id AND IsDel=0)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter QueryStringField="Id" Name="Id" Type="Int32"></asp:QueryStringParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                        <div class="card">
                                            <div class="card-body">
                                                <div class="widget">
                                                    <fieldset class="scheduler-border">
                                                        <legend class="scheduler-border">Answer</legend>

                                                        <asp:RadioButtonList ID="RbtnAnswer" runat="server">
                                                        </asp:RadioButtonList>
                                                    </fieldset>
                                                </div>

                                                <asp:LinkButton ID="lbtnAnswer" runat="server" CssClass="btn btn-outline-success btn-sm mt-1 float-right" OnClick="lbtnAnswer_Click"><i class="far fa-question-circle"></i> Answer</asp:LinkButton>


                                                <div class="alert alert-danger mt-1 p-2 small" id="divNolog" runat="server">
                                                    <strong>You are not logged in!</strong> Kindly logged in.
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>

                            <div id="divSuccessMsg" runat="server">
                                <div class="jumbotron">
                                    <h6>
                                        <i class="far fa-check-circle"></i>Thank You For Your Vote
                                    </h6>
                                </div>
                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="col-sm-2">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
