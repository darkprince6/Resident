<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResidentialComplex.aspx.cs" Inherits="Resident.WebPage.Public.ResidentialComplex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" />

    <link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.jssocials/1.4.0/jssocials.css" />
    <link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.jssocials/1.4.0/jssocials-theme-flat.css" />
    <%--<link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.jssocials/1.4.0/jssocials-theme-classic.css" />--%>
    <%--<link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.jssocials/1.4.0/jssocials-theme-minima.css" />--%>
    <%--<link type="text/css" rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.jssocials/1.4.0/jssocials-theme-plain.css" />--%>




    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../ScriptsProject/Public/ResidentialComplex.js"></script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
    <link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/confetti.css" />
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>

    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.jssocials/1.4.0/jssocials.min.js"></script>
    <%--<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5bd04b8a6f864b4a"></script>--%>

    <script>
        $(document).ready(function () {

            $("#txt1").flatpickr({
                //altInput: true,
                //altFormat: "d j, Y",
                dateFormat: "d M Y",
                minDate: "1/1/2017",
                maxDate: "today"
            });
        });
    </script>
</head>
<body style="background: linear-gradient(to right, #ffefba, #ffffff)">
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-sm-2"></div>

                <div class="col-sm-8">
                    <div id="share"></div>
                    <div class="jumbotron jumbotron-fluid">
                        <div class="container">
                            <h4>Search Your Residential Complex</h4>
                            <p>
                                <asp:DropDownList ID="ddlC" runat="server" DataSourceID="sqlddlC" DataTextField="Name" 
                                    DataValueField="Id" AppendDataBoundItems="true" CssClass="form-control">
                                    <asp:ListItem Value="0" Text="-Select-"></asp:ListItem>
                                </asp:DropDownList>

                                <asp:SqlDataSource ID="sqlddlC" runat="server" ConnectionString='<%$ ConnectionStrings: DemoCon %>'
                                    SelectCommand="SELECT
                                                         Id, Name
                                                   FROM
                                                         Countries
                                                   WHERE
                                                         IsDel=0">

                                </asp:SqlDataSource>
                            </p>
                            <p>
                                <asp:TextBox ID="txtResCom" runat="server" Placeholder="Enter Residential Complex"
                                    CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                <asp:HiddenField ID="hdnResCom" runat="server" />
                            </p>
                            <p>
                                <asp:HyperLink ID="hlSubmit" runat="server" CssClass="btn btn-outline-success float-sm-right disabled"
                                    Target="_blank" ClientIDMode="Static"> Submit </asp:HyperLink>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2"></div>

            </div>
            <div class="row">
                <div class="col-sm-12">
                    <asp:TextBox ID="txt1" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
        </div>
    </form>
    <script type='text/javascript' src='//platform-api.sharethis.com/js/sharethis.js#property=5bd06ac4ee53240011e10748&product=sticky-share-buttons' async='async'></script>
    <script>
        $("#share").jsSocials({

            showCount: false,
            showLabel: true,
            shares: [
                "email",
                "twitter",
                { share: "facebook", label: "Share this" },
                "googleplus",
                "linkedin",

                "whatsapp"
            ]
        });
    </script>
</body>
</html>
