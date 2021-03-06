﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UtilityView2.aspx.cs" Inherits="Resident.WebPage.Public.UtilityView2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js"></script>

    <script>
        var pageIndex = 1;
        var pageCount = 10;
         

        //$(document).ready(function () {
        //    $("#dvImages").on("scroll", function (e) {
        //        var $o = $(e.currentTarget);
        //        if ($o[0].scrollHeight - $o.scrollTop() <= $o.outerHeight()) {
        //            GetRecords();
        //        }
        //    });
        //});
        $(document).ready(function () {

            $(window).scroll(function () {
                //if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                if (($(window).scrollTop() + $(window).innerHeight()) >= $(document).height() - 100) {
                    $(".loader").show().delay(2000).queue(function () {
                        GetRecords();
                        $(this).dequeue();
                        $(".loader").hide();

                    });
                }
                // $(".loader").hide();
            });
        });


        function GetRecords() {
            pageIndex++;
            if (pageIndex == 2 || pageIndex <= pageCount) {
                if ($(".loader").is(':visible') == 0) {
                    $(".loader").show();
                }
                $.ajax({
                    type: "POST",
                    url: "UtilityView.aspx/GetImages",
                    data: '{pageIndex: ' + pageIndex + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response.d);
                        alert("failure");
                    },
                    error: function (response) {
                        alert(response.d);
                        alert("error");
                    }
                });
            } else {
                if (!IsNoMoreImages) {
                    $(".loader").hide();
                    IsNoMoreImages = true;
                    $("#dvImages").append('<br /><div class="text-center small text-secondery"><b>No more data to show...</b><div>');

                }
            }
        }

        function OnSuccess(response) {
            //alert("success");
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            pageCount = parseInt(xml.find("PageCount").eq(0).find("PageCount").text());
            var customers = xml.find("Images");
            // var table = $("#dvImages div").eq(0).clone(true);
            //  $("#dvImages div").eq(0).remove();
            customers.each(function () {
                var customer = $(this);
                var table = $("#dvImages div").eq(0).clone(true);
                $(".lblRowNumber", table).html(customer.find("RowNumber").text());

                $(".lblId", table).html(customer.find("Id").text());
                var utilityId = customer.find("Id").text();

                $(".lblName", table).html(customer.find("Name").text());
                $(".spanAddr1", table).html(customer.find("Addr1").text());
                $(".spanAddr2", table).html(customer.find("Addr2").text());
                $(".spanPostalCode", table).html(customer.find("PostalCode").text());
                $(".linkMobile", table).html(customer.find("Mobile").text());
                $(".spanPhone", table).html(customer.find("Phone").text());
                $(".linkEmail", table).html(customer.find("Email").text());
                $(".linkWebsite", table).html(customer.find("Website").text());
                //$(".fancybox", table).find('img').attr('src', customer.find("Url").text());
                // $("#dvImages").append(table);
                NestedData(utilityId, table);
                $("#dvImages").append(table).append();

                //table = $("#dvImages div").eq(0).clone(true);
            });
            $(".loader").hide();
        }


        function NestedData(utilityId, table) {
            $.ajax({
                type: "POST",
                url: "UtilityView.aspx/GetEmail",
                data: '{utilityId: "' + utilityId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (respon) {
                    var xmlDoc = $.parseXML(respon.d);
                    var xml = $(xmlDoc);
                    var orders = xml.find("tblEmail");
                    orders.each(function () {
                        var order = $(this);
                        var rptOrders = $('#divEmail div').eq(0).clone(true);
                        $(".lblUtilityId", rptOrders).html(order.find("UtilityId").text());
                        $(".lblEmail", rptOrders).html(order.find("Email").text());
                        $(table).append(rptOrders).append("<br />");
                    });
                },
                failure: function (respon) {
                    //alert(respon.d);
                },
                error: function (respon) {
                    //alert(respon.d);
                }
            });
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="container" style="min-height: 700px">
            <div class="row mt-5">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="card text-center">
                        <div class="card-body">
                            <asp:Repeater ID="RepUtility" runat="server" DataSourceID="SqlRepUtility">
                                <ItemTemplate>

                                    <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("Id") %>' />
                                    <asp:Button ID="btnUtilityCat" runat="server" Text='<%# Eval("Name") %>' CssClass="btn btn-outline-primary btn-sm" OnClick="btnUtilityCat_Click" />

                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:SqlDataSource runat="server" ID="SqlRepUtility" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                SelectCommand="SELECT [Id], [Name] FROM [UtilityCat]"></asp:SqlDataSource>

                        </div>
                    </div>
                </div>
                <div class="col-sm-2"></div>
            </div>

            <div class="row mt-5">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="card">
                        <div class="card-body">
                            <div id="dvImages">
                                <asp:Repeater ID="RepUtilityView" runat="server" OnItemDataBound="RepUtilityView_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="mix col-sm-12">
                                            <div class="card border-dark mb-3">
                                                <div class="card-body text-dark">
                                                    <h6 class="card-title text-primary">
                                                        <asp:HiddenField ID="hdnUtilityId" runat="server" Value='<%# Eval("Id") %>' />
                                                        <asp:Label runat="server" Text='<%# Eval("RowNumber") %>' CssClass="lblRowNumber" ID="lblRowNumber"></asp:Label>
                                                        <asp:Label runat="server" Text='<%# Eval("Id") %>' CssClass="lblId" ID="lblId"></asp:Label>
                                                        <asp:Label runat="server" Text='<%# Eval("Name") %>' CssClass="lblName"></asp:Label>
                                                    </h6>
                                                    <div class="card-text">
                                                        <div style="font-size: small">
                                                            <i class="far fa-address-card" style="color: crimson"></i>
                                                            <span class="spanAddr1"><%# Eval("Addr1") %></span>
                                                            <span runat="server" visible='<%#(Eval("Addr2")).ToString()!=string.Empty? true:false %>' class="spanAddr2">,<%# Eval("Addr2") %></span>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="divEmail">
                                            <asp:Repeater ID="RepEmail" runat="server">
                                                <ItemTemplate>
                                                    <div class="row">
                                                        <div class="com-sm-12">
                                                            <div class="card border-dark mb-3">
                                                                <div class="card-body text-dark">

                                                                    <asp:Label ID="lblUtilityId" runat="server" Text='<%# Eval("UtilityId") %>' CssClass="lblUtilityId"></asp:Label>

                                                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' CssClass="lblEmail"></asp:Label>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                            <div class="loader text-center" style="display: none">
                                <div class="spinner-grow spinner-grow-sm"></div>
                                <div class="spinner-grow spinner-grow-sm"></div>
                                <div class="spinner-grow spinner-grow-sm"></div>

                            </div>
                            <asp:SqlDataSource runat="server" ID="SqlUtilityView" ConnectionString='<%$ ConnectionStrings:ResiCon %>'
                                SelectCommand="SELECT 
	                                                U.ID, U.Name, U.Addr1, U.Addr2, U.PostalCode, U.Image1, U.Logo1
	                                               
                                                FROM 
	                                                Utility U 
	                                               "></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2"></div>
            </div>
        </div>
    </form>
</body>
</html>
