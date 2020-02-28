<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Slider.aspx.cs" Inherits="Resident.Testing.Slider" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#myCarousel').carousel();
        });
    </script>
    <style type="text/css">
        /*.carousel-indicators li {
            text-indent: 0 !important;
            height: 25px !important;
            width: 25px !important;
            line-height: 25px !important;
            border-radius: 25px !important;
            background-color: #d1d1d1;
            color: #444;
            text-align: center;
        }

            .carousel-indicators li.active {
                background-color: #fff;
            }*/
        .carousel-indicators li {
            width: 10px;
            height: 10px;
            border-radius: 100%;
        }

        .carousel-control-prev-icon {
            background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23f00' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E");
        }

        .carousel-control-next-icon {
            background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23f00' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E");
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row mt-2">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <div id="myCarousel" class="carousel slide" data-ride="carousel">
                        <asp:Repeater ID="rptMain" runat="server" OnItemDataBound="rptMain_ItemDataBound1">
                            <ItemTemplate>
                                <ol class="carousel-indicators">
                                    <asp:Repeater ID="rptIndicators" runat="server">
                                        <ItemTemplate>
                                            <li data-target="#myCarousel" data-slide-to='<%# Container.ItemIndex%>' class='<%# Container.ItemIndex == 0 ? "active" : "" %>'>
                                                <%--<%#Eval("Id")%>--%>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ol>
                                <div class="carousel-inner" role="listbox">
                                    <asp:Repeater ID="rptSlides" runat="server">
                                        <ItemTemplate>
                                            <div <%# Container.ItemIndex == 0 ? "class=\"carousel-item active\"" : "class=\"carousel-item\"" %>>
                                                <img src='<%#Eval("CoverImg")%>' class="img-responsive d-block w-100" alt="" runat="server" style="max-height: 400px" />
                                            </div>
                                            <div class="carousel-caption text-warning d-none d-sm-block">
                                                <h5>The demo of using text in carousel Bootstrap</h5>
                                                <p class="text-light">
                                                    Another caption line goes here
                                                <button class="btn btn-outline-warning btn-sm">More info</button>
                                                </p>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>

                        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>

                        </a>
                    </div>
                </div>
                <div class="col-sm-2">
                </div>
            </div>
        </div>
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:Residence4UmDBContext %>'
            SelectCommand="SELECT [Id], [CoverImg] FROM [ResidentialComplex]"></asp:SqlDataSource>
    </form>
</body>
</html>
